from __future__ import annotations

import pathlib

import pytest

from ..parser import (
    FileLine,
    ParsedDeclaration,
    Structure,
    StructureMember,
    TypeInformation,
    find_structs,
    get_names_from_line,
    parse_declaration,
)


@pytest.mark.parametrize(
    ("line", "expected_type"),
    [
        # Simple basic types
        ("INTEGER :: x", TypeInformation(type="INTEGER")),
        ("REAL :: y", TypeInformation(type="REAL")),
        ("CHARACTER(8) :: c", TypeInformation(type="CHARACTER", kind="8")),
        ("CHARACTER c", TypeInformation(type="CHARACTER")),
        ("CHARACTER(8) c", TypeInformation(type="CHARACTER", kind="8")),
        ("CHARACTER :: c", TypeInformation(type="CHARACTER")),
        ("LOGICAL :: flag", TypeInformation(type="LOGICAL")),
        # Types with sizes/kinds
        ("INTEGER(KIND=4) :: i", TypeInformation(type="INTEGER", kind="KIND=4")),
        ("REAL(8) :: x", TypeInformation(type="REAL", kind="8")),
        ("CHARACTER(LEN=80) :: str", TypeInformation(type="CHARACTER", kind="LEN=80")),
        # Dimension attribute
        (
            "INTEGER, DIMENSION(10) :: arr",
            TypeInformation(type="INTEGER", dimension="10"),
        ),
        (
            "REAL, DIMENSION(0:9, -5:5) :: matrix",
            TypeInformation(type="REAL", dimension="0:9, -5:5"),
        ),
        (
            "CHARACTER(LEN=20), DIMENSION(:) :: dynamic_array",
            TypeInformation(type="CHARACTER", kind="LEN=20", dimension=":"),
        ),
        # Allocatable attribute
        (
            "REAL, ALLOCATABLE :: dynamic_var",
            TypeInformation(type="REAL", allocatable=True),
        ),
        (
            "INTEGER, ALLOCATABLE, DIMENSION(:,:) :: matrix",
            TypeInformation(type="INTEGER", allocatable=True, dimension=":,:"),
        ),
        # Pointer attribute
        ("REAL, POINTER :: p", TypeInformation(type="REAL", pointer=True)),
        (
            "INTEGER, POINTER, DIMENSION(:) :: p_arr",
            TypeInformation(type="INTEGER", pointer=True, dimension=":"),
        ),
        # Intent attribute
        ("REAL, INTENT(IN) :: input_var", TypeInformation(type="REAL", intent="IN")),
        (
            "INTEGER, INTENT(OUT) :: result",
            TypeInformation(type="INTEGER", intent="OUT"),
        ),
        (
            "REAL, INTENT(INOUT) :: inout_var",
            TypeInformation(type="REAL", intent="INOUT"),
        ),
        # Bind attribute
        ("INTEGER, BIND(C) :: c_int", TypeInformation(type="INTEGER", bind="C")),
        (
            'REAL, BIND(C, name="c_float") :: c_float_var',
            TypeInformation(type="REAL", bind='C, name="c_float"'),
        ),
        # Optional attribute
        (
            "REAL, OPTIONAL :: maybe_present",
            TypeInformation(type="REAL", optional=True),
        ),
        # Access attributes (PRIVATE/PUBLIC)
        (
            "INTEGER, PRIVATE :: hidden_var",
            TypeInformation(type="INTEGER", private=True),
        ),
        ("REAL, PUBLIC :: exposed_var", TypeInformation(type="REAL", public=True)),
        # Parameter attribute
        (
            "REAL, PARAMETER :: PI = 3.14159",
            TypeInformation(type="REAL", parameter=True),
        ),
        # External attribute
        (
            "REAL, EXTERNAL :: external_func",
            TypeInformation(type="REAL", external=True),
        ),
        # Target attribute
        ("INTEGER, TARGET :: target_var", TypeInformation(type="INTEGER", target=True)),
        # Value attribute
        ("REAL, VALUE :: val_param", TypeInformation(type="REAL", value=True)),
        # Contiguous attribute
        (
            "REAL, POINTER, CONTIGUOUS :: contiguous_array(:)",
            TypeInformation(type="REAL", pointer=True, contiguous=True),
        ),
        # Protected attribute
        (
            "INTEGER, PROTECTED :: protected_var",
            TypeInformation(type="INTEGER", protected=True),
        ),
        # Asynchronous attribute
        (
            "REAL, ASYNCHRONOUS :: async_var",
            TypeInformation(type="REAL", asynchronous=True),
        ),
        # Save attribute
        ("INTEGER, SAVE :: persistent_var", TypeInformation(type="INTEGER", save=True)),
        # Volatile attribute
        (
            "INTEGER, VOLATILE :: changing_var",
            TypeInformation(type="INTEGER", volatile=True),
        ),
        # Static attribute (non-standard extension)
        ("INTEGER, STATIC :: static_var", TypeInformation(type="INTEGER", static=True)),
        # Intrinsic attribute
        (
            "REAL, INTRINSIC :: intrinsic_func",
            TypeInformation(type="REAL", intrinsic=True),
        ),
        # Complex combinations
        (
            "REAL(KIND=8), DIMENSION(100), ALLOCATABLE, INTENT(INOUT), TARGET :: complex_var",
            TypeInformation(
                type="REAL",
                kind="KIND=8",
                dimension="100",
                allocatable=True,
                intent="INOUT",
                target=True,
            ),
        ),
        (
            "CHARACTER(LEN=:), ALLOCATABLE, PRIVATE :: dynamic_string",
            TypeInformation(type="CHARACTER", kind="LEN=:", allocatable=True, private=True),
        ),
        (
            "INTEGER, DIMENSION(:,:), POINTER, CONTIGUOUS, INTENT(IN) :: input_matrix",
            TypeInformation(
                type="INTEGER",
                dimension=":,:",
                pointer=True,
                contiguous=True,
                intent="IN",
            ),
        ),
        (
            "REAL, OPTIONAL, INTENT(IN), VALUE :: optional_param",
            TypeInformation(type="REAL", optional=True, intent="IN", value=True),
        ),
        (
            'INTEGER, VOLATILE, ASYNCHRONOUS, BIND(C, name="status") :: status_flag',
            TypeInformation(
                type="INTEGER",
                volatile=True,
                asynchronous=True,
                bind='C, name="status"',
            ),
        ),
        # Edge cases with unusual spacing or formatting
        (
            "  INTEGER   ,  DIMENSION(10)   ::   x  ",
            TypeInformation(type="INTEGER", dimension="10"),
        ),
        (
            "REAL,DIMENSION(10),INTENT(IN),OPTIONAL::param",
            TypeInformation(type="REAL", dimension="10", intent="IN", optional=True),
        ),
        # User-defined types
        (
            "TYPE(MyCustomType) :: custom_var",
            TypeInformation(type="TYPE", kind="MyCustomType"),
        ),
        (
            "TYPE(MyCustomType), POINTER :: custom_ptr",
            TypeInformation(type="TYPE", kind="MyCustomType", pointer=True),
        ),
        # Non-standard attributes that would be collected but not specifically parsed
        (
            "INTEGER, ALIGN(32) :: aligned_var",
            TypeInformation(type="INTEGER", attributes=("ALIGN(32)",)),
        ),
    ],
)
def test_type_parsing(line: str, expected_type: TypeInformation) -> None:
    """Test parsing of Fortran type declarations with various attributes."""
    parsed_type = TypeInformation.from_line(line)

    assert parsed_type == expected_type


@pytest.mark.parametrize(
    ("line", "expected_type", "expected_kind"),
    [
        (
            "logical :: good = .true.                    ! Expression is valid.",
            "logical",
            None,
        ),
        (
            "real(rp) :: x = 0, y = 0       ! Transverse offset",
            "real",
            "rp",
        ),
        (
            "character(16) abc",
            "character",
            "16",
        ),
        (
            "type (qp_axis_struct) x, y, x2, y2",
            "type",
            "qp_axis_struct",
        ),
        (
            "character*20 magnet",
            "character",
            "20",
        ),
    ],
)
def test_get_type_from_line(
    line: str,
    expected_type: str,
    expected_kind: str | None,
) -> None:
    type_info = TypeInformation.from_line(line)
    assert type_info.type == expected_type
    assert type_info.kind == expected_kind


@pytest.mark.parametrize(
    ("line", "expected_names"),
    [
        (
            "logical :: good = .true.                    ! Expression is valid.",
            ["good"],
        ),
        (
            "real(rp) :: x = 0, y = 0       ! Transverse offset",
            ["x", "y"],
        ),
        (
            "real(rp) :: x , y ! , z = 0",
            ["x", "y"],
        ),
        (
            "character(16) abc",
            ["abc"],
        ),
    ],
)
def test_get_names_from_line(
    line: str,
    expected_names: list[str],
) -> None:
    names = get_names_from_line(line)
    assert names == expected_names


@pytest.mark.parametrize(
    ("line", "expected_decls"),
    [
        (
            "logical :: good = .true.                    ! Expression is valid.",
            [
                ParsedDeclaration(
                    name="good",
                    dimension=None,
                    default=".true.",
                    type=TypeInformation(type="logical", kind=None),
                )
            ],
        ),
        (
            "real(rp) :: x = 0, y = 1       ! Transverse offset",
            [
                ParsedDeclaration(
                    name="x", dimension=None, default="0", type=TypeInformation(type="real", kind="rp")
                ),
                ParsedDeclaration(
                    name="y", dimension=None, default="1", type=TypeInformation(type="real", kind="rp")
                ),
            ],
        ),
        (
            "real(rp) :: x , y ! , z = 0",
            [
                ParsedDeclaration(
                    name="x", dimension=None, default=None, type=TypeInformation(type="real", kind="rp")
                ),
                ParsedDeclaration(
                    name="y", dimension=None, default=None, type=TypeInformation(type="real", kind="rp")
                ),
            ],
        ),
        (
            "character(16) abc",
            [
                ParsedDeclaration(
                    name="abc",
                    dimension=None,
                    default=None,
                    type=TypeInformation(type="character", kind="16"),
                ),
            ],
        ),
        (
            "integer :: i_chan = -1",
            [
                ParsedDeclaration(
                    name="i_chan",
                    dimension=None,
                    default="-1",
                    type=TypeInformation(type="integer", kind=None),
                ),
            ],
        ),
        (
            "complex(DP), POINTER,dimension(:)::C => null() ! Coefficients C(N)",
            [
                ParsedDeclaration(
                    name="C",
                    dimension=":",
                    default="null()",
                    type=TypeInformation(type="complex", kind="DP", pointer=True, dimension=":"),
                ),
            ],
        ),
    ],
)
def test_parse_declaration(
    line: str,
    expected_decls: list[ParsedDeclaration],
) -> None:
    decls = parse_declaration(line)
    assert decls == expected_decls


@pytest.mark.parametrize(
    ("line", "expected_decl"),
    [
        (
            "type name",
            [
                ParsedDeclaration(
                    name="name", type=TypeInformation(type="type", kind=None), dimension=None, default=None
                )
            ],
        ),
        (
            "type (spin_orbit_map1_struct), allocatable :: q_ele(:)",
            [
                ParsedDeclaration(
                    name="q_ele",
                    type=TypeInformation(
                        type="type", kind="spin_orbit_map1_struct", allocatable=True, dimension=":"
                    ),
                    dimension=":",
                    default=None,
                )
            ],
        ),
        (
            "type (spin_orbit_map1_struct), allocatable :: q_ele(0:)",
            [
                ParsedDeclaration(
                    name="q_ele",
                    type=TypeInformation(
                        type="type", kind="spin_orbit_map1_struct", allocatable=True, dimension="0:"
                    ),
                    dimension="0:",
                    default=None,
                )
            ],
        ),
        (
            "type (qp_axis_struct) x, y, x2, y2",
            [
                ParsedDeclaration(
                    name="x",
                    type=TypeInformation(type="type", kind="qp_axis_struct"),
                    dimension=None,
                    default=None,
                ),
                ParsedDeclaration(
                    name="y",
                    type=TypeInformation(type="type", kind="qp_axis_struct"),
                    dimension=None,
                    default=None,
                ),
                ParsedDeclaration(
                    name="x2",
                    type=TypeInformation(type="type", kind="qp_axis_struct"),
                    dimension=None,
                    default=None,
                ),
                ParsedDeclaration(
                    name="y2",
                    type=TypeInformation(type="type", kind="qp_axis_struct"),
                    dimension=None,
                    default=None,
                ),
            ],
        ),
    ],
)
def test_parse_type_decl(line: str, expected_decl: list[ParsedDeclaration]) -> None:
    assert parse_declaration(line) == expected_decl


@pytest.mark.parametrize(
    ("lines", "expected_info"),
    [
        pytest.param(
            """
            type tao_curve_orbit_struct
                real(rp) :: x = 0       ! Transverse offset
            """,
            Structure(
                members={
                    "x": StructureMember(
                        line=2,
                        definition="real(rp) :: x = 0",
                        name="x",
                        comment="Transverse offset",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp"),
                    ),
                },
            ),
            id="basic-0",
        ),
        pytest.param(
            """
            type tao_curve_orbit_struct
                real(rp) :: x = 0, y = 0       ! Transverse offset
                real(rp) :: t = 0              ! Time
            """,
            Structure(
                members={
                    "x": StructureMember(
                        line=2,
                        definition="real(rp) :: x = 0, y = 0",
                        name="x",
                        comment="Transverse offset",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp"),
                    ),
                    "y": StructureMember(
                        line=2,
                        definition="real(rp) :: x = 0, y = 0",
                        name="y",
                        comment="Transverse offset",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp"),
                    ),
                    "t": StructureMember(
                        line=3,
                        definition="real(rp) :: t = 0",
                        name="t",
                        comment="Time",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp"),
                    ),
                },
            ),
            id="basic-1",
        ),
        pytest.param(
            # This is a made-up structure
            """
            type tao_curve_color_struct
                character(100) :: data_type = 'default'  ! Datum type to use for z-axis.
                logical :: is_on = .false.               ! On/Off
                real(rp) :: min = 0, max = 0             ! Min and max values for mapping z-axis to color.
                logical :: autoscale = .true.            ! Set %min, %max automatically to the limits of %data_type
            """,
            Structure(
                members={
                    "data_type": StructureMember(
                        line=2,
                        definition="character(100) :: data_type = 'default'",
                        name="data_type",
                        comment="Datum type to use for z-axis.",
                        default="'default'",
                        type_info=TypeInformation(type="character", kind="100"),
                    ),
                    "is_on": StructureMember(
                        line=3,
                        definition="logical :: is_on = .false.",
                        name="is_on",
                        comment="On/Off",
                        default=".false.",
                        type_info=TypeInformation(type="logical"),
                    ),
                    "min": StructureMember(
                        line=4,
                        definition="real(rp) :: min = 0, max = 0",
                        name="min",
                        comment="Min and max values for mapping z-axis to color.",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp"),
                    ),
                    "max": StructureMember(
                        line=4,
                        definition="real(rp) :: min = 0, max = 0",
                        name="max",
                        comment="Min and max values for mapping z-axis to color.",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp"),
                    ),
                    "autoscale": StructureMember(
                        line=5,
                        definition="logical :: autoscale = .true.",
                        name="autoscale",
                        comment="Set %min, %max automatically to the limits of %data_type",
                        default=".true.",
                        type_info=TypeInformation(type="logical"),
                    ),
                },
            ),
            id="misc-types-1",
        ),
        pytest.param(
            """
            type tao_spin_ele_struct
                type (tao_spin_dn_dpz_struct) dn_dpz
                real(rp) :: orb_eigen_val(6) = 0
                real(rp) :: orb_eigen_vec(6,6) = 0            ! (j,:) is j^th vector
                real(rp) :: spin_eigen_vec(6,3) = 0           ! (j,:) is j^th vector
                logical :: valid = .false.
            """,
            Structure(
                members={
                    "dn_dpz": StructureMember(
                        line=2,
                        definition="type (tao_spin_dn_dpz_struct) dn_dpz",
                        name="dn_dpz",
                        default=None,
                        type_info=TypeInformation(type="type", kind="tao_spin_dn_dpz_struct"),
                    ),
                    "orb_eigen_val": StructureMember(
                        line=3,
                        definition="real(rp) :: orb_eigen_val(6) = 0",
                        name="orb_eigen_val",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp", dimension="6"),
                    ),
                    "orb_eigen_vec": StructureMember(
                        line=4,
                        definition="real(rp) :: orb_eigen_vec(6,6) = 0",
                        name="orb_eigen_vec",
                        comment="(j,:) is j^th vector",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp", dimension="6,6"),
                    ),
                    "spin_eigen_vec": StructureMember(
                        line=5,
                        definition="real(rp) :: spin_eigen_vec(6,3) = 0",
                        name="spin_eigen_vec",
                        comment="(j,:) is j^th vector",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp", dimension="6,3"),
                    ),
                    "valid": StructureMember(
                        line=6,
                        definition="logical :: valid = .false.",
                        name="valid",
                        default=".false.",
                        type_info=TypeInformation(type="logical"),
                    ),
                },
            ),
            id="misc-types-2",
        ),
        pytest.param(
            """
            type tao_spin_ele_struct
                ! pre-comment
                real(rp) :: orb_eigen_vec(6,6) = 0    ! this has a 
                                                      ! multiline comment
                real(rp) :: orb_eigen_vec1(6,7) = 0   ! this has a
                                                      ! multiline comment too
            """,
            Structure(
                members={
                    "orb_eigen_vec": StructureMember(
                        line=3,
                        definition="real(rp) :: orb_eigen_vec(6,6) = 0",
                        name="orb_eigen_vec",
                        comment="this has a multiline comment",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp", dimension="6,6"),
                    ),
                    "orb_eigen_vec1": StructureMember(
                        line=5,
                        definition="real(rp) :: orb_eigen_vec1(6,7) = 0",
                        name="orb_eigen_vec1",
                        comment="this has a multiline comment too",
                        default="0",
                        type_info=TypeInformation(type="real", kind="rp", dimension="6,7"),
                    ),
                },
            ),
            id="multiline-comment-1",
        ),
    ],
)
def test_parse_structure(lines: str, expected_info: Structure) -> None:
    struct = Structure(
        lines=[line.strip() for line in lines.strip().splitlines()],
        filename=pathlib.Path(),
        line=1,
        name="name",
        module="",
    )
    struct.parse()
    assert struct.members == expected_info.members


@pytest.mark.parametrize(
    ("lines", "expected_info"),
    [
        pytest.param(
            """
            module foo
            type struct_name
            ENDTYPE
            type struct_name2
            ENDTYPE
            end module
            """,
            [
                Structure(
                    filename=pathlib.Path(),
                    lines=["type struct_name"],
                    line=3,
                    name="struct_name",
                    module="foo",
                    comment="",
                    members={},
                ),
                Structure(
                    filename=pathlib.Path(),
                    module="foo",
                    lines=["type struct_name2"],
                    line=5,
                    name="struct_name2",
                    comment="",
                    members={},
                ),
            ],
            id="structs-1",
        ),
        pytest.param(
            """
            module bar
            type struct_name
                real(rp) :: orb_eigen_vec(6,6) = 0    ! this has a 
                                                      ! multiline comment
            ENDTYPE
            end module
            """,
            [
                Structure(
                    filename=pathlib.Path(),
                    module="bar",
                    lines=[
                        "type struct_name",
                        "real(rp) :: orb_eigen_vec(6,6) = 0    ! this has a",
                        "! multiline comment",
                    ],
                    line=3,
                    name="struct_name",
                    comment="",
                    members={
                        "orb_eigen_vec": StructureMember(
                            line=4,
                            definition="real(rp) :: orb_eigen_vec(6,6) = 0",
                            name="orb_eigen_vec",
                            comment="this has a multiline comment",
                            default="0",
                            type_info=TypeInformation(type="real", kind="rp", dimension="6,6"),
                        ),
                    },
                )
            ],
            id="structs-2",
        ),
    ],
)
def test_find_structs(lines: str, expected_info: dict[str, Structure]) -> None:
    file_lines = [
        FileLine(line=line, lineno=lineno, filename=pathlib.Path())
        for lineno, line in enumerate(lines.splitlines(), 1)
    ]
    res = find_structs(file_lines, filename=pathlib.Path())
    for struct in res:
        struct.parse()
    assert res == expected_info
