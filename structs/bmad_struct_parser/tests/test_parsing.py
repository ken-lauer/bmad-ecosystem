import pathlib
import pytest

from ..parser import (
    FileLine,
    ParsedDeclaration,
    Structure,
    StructureInfo,
    StructureMember,
    TypeInformation,
    find_structs,
    get_default,
    get_names_from_line,
    get_python_member_name,
    get_python_type,
    get_type_from_line,
    parse_declaration,
    parse_type_declaration,
)


@pytest.mark.parametrize(
    ("python_type", "size", "fortran_default", "expected", "expected_default_factory"),
    [
        ("str", None, "'abc'", "abc", ""),
        ("int", None, "1", 1, ""),
        ("", None, ".false.", False, ""),
        ("", None, ".true.", True, ""),
        ("", None, "real_garbage$", 0.0, ""),
        ("", None, "int_garbage$", 0, ""),
        ("float", None, "10e3", 10e3, ""),
        ("float", None, "10d3", 10e3, ""),
        ("float", None, "10d3_rp", 10e3, ""),
        ("int", None, "[1, 2, 3]", (1, 2, 3), ""),
        ("float", None, "[1., 2., 3.]", (1.0, 2.0, 3.0), ""),
    ],
)
def test_get_default(
    python_type: str,
    size: str | None,
    fortran_default: str,
    expected: str | int | float | bool | tuple | None,
    expected_default_factory: str | None,
) -> None:
    default, default_factory = get_default(python_type, size, fortran_default)
    assert default == expected
    assert default_factory == expected_default_factory


@pytest.mark.parametrize(
    "line, expected_type",
    [
        # Simple basic types
        ("INTEGER :: x", TypeInformation(type="INTEGER")),
        ("REAL :: y", TypeInformation(type="REAL")),
        ("CHARACTER :: c", TypeInformation(type="CHARACTER")),
        ("LOGICAL :: flag", TypeInformation(type="LOGICAL")),
        # Types with sizes/kinds
        ("INTEGER(KIND=4) :: i", TypeInformation(type="INTEGER", size="KIND=4")),
        ("REAL(8) :: x", TypeInformation(type="REAL", size="8")),
        ("CHARACTER(LEN=80) :: str", TypeInformation(type="CHARACTER", size="LEN=80")),
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
            TypeInformation(type="CHARACTER", size="LEN=20", dimension=":"),
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
                size="KIND=8",
                dimension="100",
                allocatable=True,
                intent="INOUT",
                target=True,
            ),
        ),
        (
            "CHARACTER(LEN=:), ALLOCATABLE, PRIVATE :: dynamic_string",
            TypeInformation(
                type="CHARACTER", size="LEN=:", allocatable=True, private=True
            ),
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
            TypeInformation(type="MyCustomType"),
        ),
        (
            "TYPE(MyCustomType), POINTER :: custom_ptr",
            TypeInformation(type="MyCustomType", pointer=True),
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
    parsed_type = get_type_from_line(line)

    assert parsed_type == expected_type


@pytest.mark.parametrize(
    ("line", "expected_type", "expected_size"),
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
            "qp_axis_struct",
            None,
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
    expected_size: str | None,
) -> None:
    type_info = get_type_from_line(line)
    assert type_info.type == expected_type
    assert type_info.size == expected_size


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
            [ParsedDeclaration(name="good", dimension="", default=".true.")],
        ),
        (
            "real(rp) :: x = 0, y = 1       ! Transverse offset",
            [
                ParsedDeclaration(name="x", dimension="", default="0"),
                ParsedDeclaration(name="y", dimension="", default="1"),
            ],
        ),
        (
            "real(rp) :: x , y ! , z = 0",
            [
                ParsedDeclaration(name="x", dimension="", default=None),
                ParsedDeclaration(name="y", dimension="", default=None),
            ],
        ),
        (
            "character(16) abc",
            [
                ParsedDeclaration(name="abc", dimension="", default=None),
            ],
        ),
        (
            "integer :: i_chan = -1",
            [
                ParsedDeclaration(name="i_chan", dimension="", default="-1"),
            ],
        ),
        (
            "complex(DP), POINTER,dimension(:)::C => null() ! Coefficients C(N)",
            [
                ParsedDeclaration(name="C", dimension=":", default="null()"),
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
    ("name", "expected_python_name"),
    [
        ("str", "str_"),
        ("float", "float_"),
        ("int", "int_"),
        ("is", "is_"),
        ("lambda", "lambda_"),
        ("0", "bmad_0"),
        ("model_abc", "bmad_model_abc"),
    ],
)
def test_get_python_member_name(name: str, expected_python_name: str) -> None:
    python_name = get_python_member_name(name)
    assert python_name == expected_python_name


@pytest.mark.parametrize(
    ("line", "expected_decl"),
    [
        ("type name", [ParsedDeclaration(name="name", dimension=None, default=None)]),
        (
            "type (spin_orbit_map1_struct), allocatable :: q_ele(:)",
            [ParsedDeclaration(name="q_ele", dimension=":", default=None)],
        ),
        (
            "type (spin_orbit_map1_struct), allocatable :: q_ele(:)",
            [ParsedDeclaration(name="q_ele", dimension=":", default=None)],
        ),
        (
            "type (qp_axis_struct) x, y, x2, y2",
            [
                ParsedDeclaration(name="x", dimension="", default=None),
                ParsedDeclaration(name="y", dimension="", default=None),
                ParsedDeclaration(name="x2", dimension="", default=None),
                ParsedDeclaration(name="y2", dimension="", default=None),
            ],
        ),
    ],
)
def test_parse_type_decl(line: str, expected_decl: list[ParsedDeclaration]) -> None:
    assert parse_type_declaration(line) == expected_decl


@pytest.mark.parametrize(
    ("type", "expected_python_type"),
    [
        ("logical", "bool"),
        ("LOGICAL", "bool"),
        ("real", "float"),
        ("integer", "int"),
        ("character", "str"),
        ("complex", "Complex"),
        ("logical, allocatable", "bool"),
    ],
)
def test_get_python_type_basic(type: str, expected_python_type: str) -> None:
    python_type = get_python_type(TypeInformation(type=type))
    assert python_type == expected_python_type


@pytest.mark.parametrize(
    ("lines", "expected_info"),
    [
        pytest.param(
            """
            type tao_curve_orbit_struct
                real(rp) :: x = 0       ! Transverse offset
            """,
            StructureInfo(
                members={
                    "x": StructureMember(
                        line=2,
                        definition="real(rp) :: x = 0",
                        name="x",
                        python_name="x",
                        type="real",
                        python_type="float",
                        size=None,
                        dimension="",
                        comment="Transverse offset",
                        fortran_default="0",
                        default=0,
                        default_factory="",
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
            StructureInfo(
                members={
                    "x": StructureMember(
                        line=2,
                        definition="real(rp) :: x = 0, y = 0",
                        name="x",
                        python_name="x",
                        type="real",
                        python_type="float",
                        size=None,
                        dimension="",
                        comment="Transverse offset",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "y": StructureMember(
                        line=2,
                        definition="real(rp) :: x = 0, y = 0",
                        name="y",
                        python_name="y",
                        type="real",
                        python_type="float",
                        size=None,
                        dimension="",
                        comment="Transverse offset",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "t": StructureMember(
                        line=3,
                        definition="real(rp) :: t = 0",
                        name="t",
                        python_name="t",
                        type="real",
                        python_type="float",
                        size=None,
                        dimension="",
                        comment="Time",
                        fortran_default="0",
                        default=0,
                        default_factory="",
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
            StructureInfo(
                members={
                    "data_type": StructureMember(
                        line=2,
                        definition="character(100) :: data_type = 'default'",
                        name="data_type",
                        python_name="data_type",
                        type="character",
                        python_type="str",
                        size="100",
                        dimension="",
                        comment="Datum type to use for z-axis.",
                        fortran_default="'default'",
                        default="default",
                        default_factory="",
                    ),
                    "is_on": StructureMember(
                        line=3,
                        definition="logical :: is_on = .false.",
                        name="is_on",
                        python_name="is_on",
                        type="logical",
                        python_type="bool",
                        size=None,
                        dimension="",
                        comment="On/Off",
                        fortran_default=".false.",
                        default=False,
                        default_factory="",
                    ),
                    "min": StructureMember(
                        line=4,
                        definition="real(rp) :: min = 0, max = 0",
                        name="min",
                        python_name="min",
                        type="real",
                        python_type="float",
                        size=None,
                        dimension="",
                        comment="Min and max values for mapping z-axis to color.",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "max": StructureMember(
                        line=4,
                        definition="real(rp) :: min = 0, max = 0",
                        name="max",
                        python_name="max",
                        type="real",
                        python_type="float",
                        size=None,
                        dimension="",
                        comment="Min and max values for mapping z-axis to color.",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "autoscale": StructureMember(
                        line=5,
                        definition="logical :: autoscale = .true.",
                        name="autoscale",
                        python_name="autoscale",
                        type="logical",
                        python_type="bool",
                        size=None,
                        dimension="",
                        comment="Set %min, %max automatically to the limits of %data_type",
                        fortran_default=".true.",
                        default=True,
                        default_factory="",
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
            StructureInfo(
                members={
                    "dn_dpz": StructureMember(
                        line=2,
                        definition="type (tao_spin_dn_dpz_struct) dn_dpz",
                        name="dn_dpz",
                        python_name="dn_dpz",
                        type="tao_spin_dn_dpz_struct",
                        python_type="TaoSpinDnDpzStruct",
                        dimension="",
                        fortran_default=None,
                        default=None,
                        default_factory="",
                    ),
                    "orb_eigen_val": StructureMember(
                        line=3,
                        definition="real(rp) :: orb_eigen_val(6) = 0",
                        name="orb_eigen_val",
                        python_name="orb_eigen_val",
                        type="real",
                        python_type="float",
                        dimension="6",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "orb_eigen_vec": StructureMember(
                        line=4,
                        definition="real(rp) :: orb_eigen_vec(6,6) = 0",
                        name="orb_eigen_vec",
                        python_name="orb_eigen_vec",
                        type="real",
                        python_type="float",
                        dimension="6,6",
                        comment="(j,:) is j^th vector",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "spin_eigen_vec": StructureMember(
                        line=5,
                        definition="real(rp) :: spin_eigen_vec(6,3) = 0",
                        name="spin_eigen_vec",
                        python_name="spin_eigen_vec",
                        type="real",
                        python_type="float",
                        dimension="6,3",
                        comment="(j,:) is j^th vector",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "valid": StructureMember(
                        line=6,
                        definition="logical :: valid = .false.",
                        name="valid",
                        python_name="valid",
                        type="logical",
                        python_type="bool",
                        dimension="",
                        fortran_default=".false.",
                        default=False,
                        default_factory="",
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
            StructureInfo(
                members={
                    "orb_eigen_vec": StructureMember(
                        line=3,
                        definition="real(rp) :: orb_eigen_vec(6,6) = 0",
                        name="orb_eigen_vec",
                        python_name="orb_eigen_vec",
                        type="real",
                        python_type="float",
                        dimension="6,6",
                        comment="this has a multiline comment",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                    "orb_eigen_vec1": StructureMember(
                        line=5,
                        definition="real(rp) :: orb_eigen_vec1(6,7) = 0",
                        name="orb_eigen_vec1",
                        python_name="orb_eigen_vec1",
                        type="real",
                        python_type="float",
                        dimension="6,7",
                        comment="this has a multiline comment too",
                        fortran_default="0",
                        default=0,
                        default_factory="",
                    ),
                },
            ),
            id="multiline-comment-1",
        ),
    ],
)
def test_parse_structure(lines: str, expected_info: StructureInfo) -> None:
    struct = Structure(
        lines=[line.strip() for line in lines.strip().splitlines()],
        filename=pathlib.Path("."),
        line=1,
        name="name",
        module="",
    )
    struct.parse()
    assert struct.info.members == expected_info.members


@pytest.mark.parametrize(
    ("lines", "expected_info"),
    [
        pytest.param(
            """
            type struct_name
            ENDTYPE
            type struct_name2
            ENDTYPE
            """,
            {
                "struct_name": Structure(
                    filename=pathlib.Path("."),
                    lines=["type struct_name"],
                    line=2,
                    name="struct_name",
                    module="",
                    info=StructureInfo(
                        class_name="StructName",
                        comment="",
                        members={},
                    ),
                ),
                "struct_name2": Structure(
                    filename=pathlib.Path("."),
                    module="",
                    lines=["type struct_name2"],
                    line=4,
                    name="struct_name2",
                    info=StructureInfo(
                        class_name="StructName2",
                        comment="",
                        members={},
                    ),
                ),
            },
            id="structs-1",
        ),
        pytest.param(
            """
            type struct_name
                real(rp) :: orb_eigen_vec(6,6) = 0    ! this has a 
                                                      ! multiline comment
            ENDTYPE
            """,
            {
                "struct_name": Structure(
                    filename=pathlib.Path("."),
                    module="",
                    lines=[
                        "type struct_name",
                        "real(rp) :: orb_eigen_vec(6,6) = 0    ! this has a",
                        "! multiline comment",
                    ],
                    line=2,
                    name="struct_name",
                    info=StructureInfo(
                        class_name="StructName",
                        comment="",
                        members={
                            "orb_eigen_vec": StructureMember(
                                line=3,
                                definition="real(rp) :: orb_eigen_vec(6,6) = 0",
                                name="orb_eigen_vec",
                                python_name="orb_eigen_vec",
                                type="real",
                                python_type="float",
                                dimension="6,6",
                                comment="this has a multiline comment",
                                fortran_default="0",
                                default=0,
                                default_factory="",
                            ),
                        },
                    ),
                )
            },
            id="structs-2",
        ),
    ],
)
def test_find_structs(lines: str, expected_info: dict[str, Structure]) -> None:
    file_lines = [
        FileLine(line=line, lineno=lineno, filename=pathlib.Path())
        for lineno, line in enumerate(lines.splitlines(), 1)
    ]
    res = find_structs(file_lines, filename=pathlib.Path("."), by_class_name={})
    for struct in res.values():
        struct.parse()
    assert res == expected_info
