import sys
import textwrap
from typing import Literal

import pydantic
from .parser import (
    GENERATED_PATH,
    Structure,
    StructureFile,
    StructureMember,
    load_structures,
)


filename_skips = {
    "a_def_element_fibre_layout",
}

special_use_by_filename = {
    "h_definition": "ptc_spin",
    "a_def": "ptc_spin",
}
special_use_by_struct = {
    "genfield": "ptc_spin",
    "fibre": "ptc_spin",
    "layout": "ptc_spin",
    "c_damap": "ptc_spin",
    "c_normal_form": "ptc_spin",
    "c_taylor": "ptc_spin",
    "quaternion_8": "ptc_spin",
    "probe_8": "ptc_spin",
    "internal_state": "ptc_spin",
}
skips = {
    # "cylindrical_map_term1_struct",
    # "fibre",
    # "layout",
    # "c_normal_form",
}


def _split_defn_words(defn: str) -> list[str]:
    separators = "(), \t[]"
    words = []
    last = []
    for ch in defn:
        if ch in separators:
            words.append("".join(last))
            last = []
        else:
            last.append(ch)
    return words


class JsonDumpMember(pydantic.BaseModel):
    var: str
    member: StructureMember
    code: str


class JsonDumpCode(pydantic.BaseModel):
    code: str


def get_structures_by_name(
    struct_file: StructureFile,
    attr: Literal["python", "bmad"],
) -> dict[str, Structure]:
    by_name: dict[str, Structure] = {}
    for _, structs in struct_file.items():
        for struct in structs.values():
            if attr == "python":
                by_name[struct.info.class_name] = struct
            else:
                by_name[struct.name.lower()] = struct
    return by_name


def to_subroutine_name(struct: Structure | str):
    if isinstance(struct, Structure):
        name = struct.name
    else:
        name = struct

    return f"{name}_to_json"


class ListBuilder(pydantic.BaseModel):
    struct_var: str
    member: StructureMember
    iter_var: str
    json_list_var: str
    parent_json_var: str
    json_value_var: str
    key: str

    def create_loop(self) -> str:
        member = self.member
        assert member.dimension
        num_dimensions = member.dimension.count(",") + 1

        iter_vars = ", ".join(
            f"{self.iter_var}{dim}" for dim in range(1, num_dimensions + 1)
        )
        if member.python_type in {"int", "float", "bool"}:
            create = {
                "int": "create_integer",
                "float": "create_real",
                "bool": "create_logical",
            }[member.python_type]
            iteration = f"call json%{create}({self.json_value_var}, {self.struct_var}%{member.name}({iter_vars}), '')"
        elif member.python_type in {"str"}:
            iteration = f"call json%create_string({self.json_value_var}, trim({self.struct_var}%{member.name}({iter_vars})), '')"
        else:
            conv_subroutine = to_subroutine_name(member.type)
            iteration = f"call {conv_subroutine}({self.struct_var}%{member.name}({iter_vars}), {self.json_value_var}, depth + 1)"

        def iter_dimension(dim: int, loop: str, key: str = ""):
            before = (
                f"call json%create_array({self.json_list_var}{dim}, {key})\n"
                f"do {self.iter_var}{dim} = lbound({self.struct_var}%{member.name}, {dim}), ubound({self.struct_var}%{member.name}, {dim})"
            )
            if dim == 1:
                inner = (
                    f"{loop}\n"
                    f"call json%add({self.json_list_var}{dim}, {self.json_value_var})"
                )
            else:
                inner = loop

            if dim == num_dimensions:
                after = "\n".join(
                    (
                        "enddo",
                        f"call json%add({self.parent_json_var}, {self.json_list_var}{dim})",
                        f"nullify({self.json_list_var}{dim})",
                    )
                )
            else:
                next_dim = dim + 1
                after = "\n".join(
                    (
                        "enddo",
                        f"call json%add({self.json_list_var}{next_dim}, {self.json_list_var}{dim})",
                        f"nullify({self.json_list_var}{dim})",
                    )
                )
            return "\n".join(
                (
                    before,
                    textwrap.indent(inner, "  "),
                    after,
                )
            )

        res = iteration
        for dimension in range(1, num_dimensions + 1):
            res = iter_dimension(
                dimension,
                loop=res,
                key=repr(self.key) if dimension == 1 else repr(f"dim-{dimension}"),
            )

        assert "do i1" in res
        res = f"!{member}\n{res}"
        return res


class Converter(pydantic.BaseModel):
    structs: StructureFile
    generated: set[str] = pydantic.Field(default_factory=set)
    seen: set[str] = pydantic.Field(default_factory=set)

    @property
    def by_bmad_name(self) -> dict[str, Structure]:
        return get_structures_by_name(self.structs, "bmad")

    @property
    def by_class_name(self) -> dict[str, Structure]:
        return get_structures_by_name(self.structs, "python")

    def _get_json_dump_code_array(
        self,
        struct_var: str,
        member: StructureMember,
        parent_json_var: str,
        member_json_var: str = "json_obj",
        # print_: bool = False,
        # destroy: bool = False,
    ) -> JsonDumpMember:
        assert member.dimension

        builder = ListBuilder(
            struct_var=struct_var,
            member=member,
            iter_var="i",
            json_list_var="json_list",
            json_value_var="json_val",
            parent_json_var=parent_json_var,
            key=member.python_name,
        )
        code = builder.create_loop()
        defn_words = _split_defn_words(member.definition.lower())
        if "pointer" in defn_words:
            code = "\n".join(
                (
                    f"if (associated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        if "allocatable" in defn_words:
            code = "\n".join(
                (
                    f"if (allocated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        return JsonDumpMember(var=struct_var, member=member, code=code)

    def get_json_dump_code(
        self,
        struct_var: str,
        member: StructureMember,
        parent_json_var: str,
        member_json_var: str = "json_obj",
        # print_: bool = False,
        # destroy: bool = False,
    ) -> JsonDumpMember:
        if member.python_type not in {"int", "float", "bool", "str", "Complex"}:
            self.seen.add(member.type)

        if member.dimension:
            return self._get_json_dump_code_array(
                struct_var=struct_var,
                member=member,
                parent_json_var=parent_json_var,
                member_json_var=member_json_var,
            )

        if (
            "parent" in member.comment.lower()
            or member.name.lower()
            in {
                "g",
                "p",
                "u",
            }
            or member.type.lower()
            in {"tao_super_universe_struct", "tao_universe_struct"}
        ):
            return JsonDumpMember(
                var=member_json_var,
                member=member,
                code=f"! parent pointer skip: {member.name} ({member.type}, {member.comment})",
            )

        if member.python_type in {"int"}:
            code = f"call json%add({parent_json_var}, '{member.python_name}', int({struct_var}%{member.name}))"
        elif member.python_type in {"float", "bool"}:
            code = f"call json%add({parent_json_var}, '{member.python_name}', {struct_var}%{member.name})"
        elif member.python_type in {"str"}:
            code = f"call json%add({parent_json_var}, '{member.python_name}', trim({struct_var}%{member.name}))"
        elif member.python_type in {"Complex"}:
            json_list_var = "json_list"
            list_var = f"{json_list_var}1"
            code = "\n".join(
                (
                    f"call complex_to_json({struct_var}%{member.name}, {list_var}, depth+1)",
                    f"call json%rename({list_var}, '{member.python_name}')",
                    f"call json%add({parent_json_var}, {list_var})",
                )
            )
        else:
            struct = self.by_bmad_name[member.type.lower()]
            if struct.name.lower() in skips or struct.filename.stem in filename_skips:
                self.seen.remove(member.type)
                return JsonDumpMember(
                    var="",
                    member=member,
                    code=f"! skipped explicitly by converter: struct={struct.name} file={struct.filename.name} member={member_json_var}",
                )

            conv_subroutine = to_subroutine_name(member.type)
            code = "\n".join(
                (
                    f"call {conv_subroutine}({struct_var}%{member.name}, json_val, depth + 1)",
                    f"call json%rename(json_val, '{member.name}')",
                    f"call json%add({parent_json_var}, json_val)",
                )
            )

        defn_words = _split_defn_words(member.definition.lower())
        if "pointer" in defn_words:
            code = "\n".join(
                (
                    f"if (associated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        if "allocatable" in defn_words:
            code = "\n".join(
                (
                    f"if (allocated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        return JsonDumpMember(var=member_json_var, member=member, code=code)

    def get_struct_dump_code(
        self,
        struct_var: str,
        struct: Structure,
        root_variable: str = "json_root",
        key: str = "",
        print_: bool = True,
        destroy: bool = True,
    ) -> JsonDumpCode:
        if not key:
            key = "''"
        lines = [
            f"call json%create_object({root_variable}, {key})",
        ]

        for member in struct.info.members.values():
            member_dump = self.get_json_dump_code(
                struct_var=struct_var,
                member=member,
                parent_json_var=root_variable,
                member_json_var="json_obj",
            )
            if False:
                lines.append(
                    f"print *, '{struct.name}%{member.name}, depth=', depth",
                )
            lines.extend(member_dump.code.splitlines())

        if print_:
            lines.append(f"call json%print({root_variable})")

        if destroy:
            lines.append(f"call json%destroy({root_variable})")
            lines.append(f"nullify({root_variable})")

        return JsonDumpCode(code="\n".join(lines))

    def get_struct_dump_subroutine(
        self,
        struct: Structure,
        root_variable: str = "json_root",
        print_: bool = True,
        destroy: bool = True,
    ) -> JsonDumpCode:
        subroutine_name = to_subroutine_name(struct.name)

        lines = [f"subroutine {subroutine_name} (input, json_root, depth)"]
        if struct.name.lower() in skips or struct.filename.stem in filename_skips:
            raise ValueError(f"skipped subroutine: {subroutine_name}")

        if struct.name.lower() in special_use_by_struct:
            struct_filename = special_use_by_struct[struct.name.lower()]
        elif struct.filename.stem in special_use_by_filename:
            struct_filename = special_use_by_filename[struct.filename.stem]
        else:
            struct_filename = struct.filename.stem

        lines += textwrap.dedent(
            f"""\
            use {struct_filename}, only: {struct.name}

            use json_module
            use json_string_utilities, only: integer_to_string
            use json_kinds, only: CK

            implicit none

            type(json_core) :: json
            type ({struct.name}), pointer, intent(in) :: input
            type (json_value), pointer :: json_val
            type (json_value), pointer, intent(inout) :: json_root
            integer, optional, value :: depth

            integer i1, i2, i3, i4, i5, i6
            type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5

            if (.not. present(depth)) depth = 0
            if (depth > 10) then
              call json%create_string(json_root, 'too deep', '')
              return
            endif

            if (.not. associated(input)) then
              call json%create_null(json_root, name)
              return
            endif
            """.rstrip()
        ).splitlines()

        dump_code = self.get_struct_dump_code(
            "input",
            struct,
            root_variable="json_root",
            key="name",
            print_=False,
            destroy=False,
        )

        def should_indent(text: str) -> bool:
            return not (
                text.startswith("subroutine") or text.startswith("end subroutine")
            )

        lines.extend(dump_code.code.splitlines())
        lines.append("")
        lines.append(f"end subroutine {subroutine_name}")
        lines.append("")
        return JsonDumpCode(
            code=textwrap.indent("\n".join(lines), prefix="  ", predicate=should_indent)
        )


def get_used_structures(
    struct: Structure,
    structures: dict[str, Structure],
    seen: set[str] | None = None,
) -> set[str]:
    if seen is None:
        seen = set()
    elif struct.name.lower() in seen:
        return seen

    seen.add(struct.name.lower())
    for member in struct.info.members.values():
        type_name = member.type.lower()
        if type_name in structures and type_name not in seen:
            seen.add(type_name)
            seen = seen | get_used_structures(
                structures[type_name],
                structures,
                seen=seen,
            )
    return seen


def make_struct_tree(structures: dict[str, Structure]) -> dict[str, set[str]]:
    res: dict[str, set[str]] = {}
    for name, struct in structures.items():
        res[name] = get_used_structures(struct, structures)
    return res


print(
    """\
subroutine complex_to_json (input, json_root, depth)

    use json_module
    use json_kinds, only: CK

    implicit none

    type(json_core) :: json
    type (complex(rp)), intent(in) :: input
    type (json_value), pointer :: json_val
    type (json_value), pointer, intent(inout) :: json_root
    integer, optional, value :: depth

    call json%create_array(json_root, '')
    call json%create_real(json_val, real(input), '')
    call json%add(json_root, json_val)
    call json%create_real(json_val, aimag(input), '')
    call json%add(json_root, json_val)

end subroutine complex_to_json
    """.rstrip()
)


def load_all():
    structs = load_structures(GENERATED_PATH / "tao_structs.yaml")
    structs.update(load_structures(GENERATED_PATH / "sim_utils_structs.yaml"))
    structs.update(load_structures(GENERATED_PATH / "bmad_structs.yaml"))
    structs.update(load_structures(GENERATED_PATH / "forest_structs.yaml"))
    return structs


def convert(struct_name: str):
    structs = load_all()
    conv = Converter(structs=structs)
    by_name = conv.by_bmad_name

    conv.seen = {struct_name}

    while conv.seen - conv.generated:
        remaining = conv.seen - conv.generated
        next_struct = sorted(remaining)[0]
        print("Generating:", next_struct, file=sys.stderr)
        if (
            next_struct.lower() in skips
            or by_name[next_struct.lower()].filename.stem in filename_skips
        ):
            conv.generated.add(next_struct)
            continue
        subroutine = conv.get_struct_dump_subroutine(by_name[next_struct.lower()])
        print(subroutine.code)
        conv.generated.add(next_struct)

    print("Total structures", len(conv.seen), file=sys.stderr)


def dump_tree():
    structs = load_all()
    conv = Converter(structs=structs)
    return make_struct_tree(conv.by_bmad_name)


if __name__ == "__main__":
    # convert("tao_super_universe_struct")
    convert("lat_struct")
    # dump_tree()
