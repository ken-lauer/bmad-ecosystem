from __future__ import annotations

from dataclasses import dataclass, fields

from .types import FullType


@dataclass
class CSideTransform:
    c_class: str = ""

    # C++ --> Fortran
    # |   C++     |    Fortran |
    # obj_to_f() -> obj_to_f2()
    #
    # (C) handles obj_to_f()  - picks out class members
    # (F) handles obj_to_f2() - takes flattened class members to reconstruct a new Fortran structure

    # C -> F2 argument type:
    to_f2_arg: str = ""

    # Fortran --> C++
    # | Fortran   |  C++       |
    # obj_to_c() -> obj_to_c2()
    #
    # (F) handles obj_to_c()  - picks out structure members
    # (C) handles obj_to_c2() - takes flattened class members to reconstruct a new C++ class instance

    # C2 function: parameter type
    to_c2_arg: str = ""

    def replace_all(self, old: str, new: str) -> None:
        for fld in fields(self):
            value = getattr(self, fld.name)

            if isinstance(value, str):
                setattr(self, fld.name, value.replace(old, new))
            else:
                setattr(self, fld.name, [v.replace(old, new) for v in value])

    def __str__(self):
        return f"{self.c_class},  {self.to_f2_arg},  {self.to_c2_arg}"


@dataclass
class FortranSideTransform:
    # Fortran -> C++:
    #
    # | Fortran   |  C++       |
    # obj_to_c() -> obj_to_c2()
    #
    # (F) handles obj_to_c()  - picks out structure members
    # (C) handles obj_to_c2() - takes flattened class members to reconstruct a new C++ class instance
    #
    # F -> C2: how to call obj_to_c2() from fortran with the argument
    # to_c2_call: str = ""
    # F -> C2: how to define the local variable in to_c to call to_c2:
    to_c2_type: str = ""

    # C++ -> Fortran:
    #
    # |   C++     |    Fortran |
    # obj_to_f() -> obj_to_f2()
    #
    # (C) handles obj_to_f()  - picks out class members
    # (F) handles obj_to_f2() - takes flattened class members to reconstruct a new Fortran structure
    to_f2_type: str = ""

    equality_test: str = "is_eq = is_eq .and. all(f1%NAME == f2%NAME)\n"

    def replace_all(self, old: str, new: str) -> None:
        for fld in fields(self):
            value = getattr(self, fld.name)

            if isinstance(value, str):
                setattr(self, fld.name, value.replace(old, new))
            else:
                setattr(self, fld.name, [v.replace(old, new) for v in value])


transforms = {
    FullType(type="character", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="character(c_char)",
            to_f2_type="character(c_char)",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<string>",
            to_f2_arg="  c_Char",
            to_c2_arg="",
        ),
    ),
    FullType(type="character", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="character(c_char)",
            to_f2_type="character(c_char)",
            equality_test="is_eq = is_eq .and. (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="string",
            to_f2_arg="  c_Char",
            to_c2_arg="",
        ),
    ),
    FullType(type="character", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="character(c_char)",
            to_f2_type="character(c_char)",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<string>",
            to_f2_arg="  c_Char",
            to_c2_arg="",
        ),
    ),
    FullType(type="character", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<string>",
            to_f2_arg="        c_Char*",
            to_c2_arg="",
        ),
    ),
    FullType(type="character", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray1D<string, DIM1>",
            to_f2_arg="  c_Char*",
            to_c2_arg="",
        ),
    ),
    FullType(type="character", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<string>",
            to_f2_arg="        c_Char*",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Complex>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="complex(c_double_complex)",
            equality_test="is_eq = is_eq .and. (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="Complex",
            to_f2_arg="  c_Complex&",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Complex>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Complex>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="complex(c_double_complex)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray1D<Complex, DIM1>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Complex>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=2, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Complex>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=2, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="complex(c_double_complex)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray2D<Complex, DIM1, DIM2>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=2, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Complex>",
            to_f2_arg="  c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=3, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Complex>",
            to_f2_arg="        c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="complex", dim=3, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="complex(c_double_complex)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray3D<Complex, DIM1, DIM2, DIM3>", to_f2_arg="  c_ComplexArr", to_c2_arg=""
        ),
    ),
    FullType(type="complex", dim=3, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="complex(c_double_complex)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Complex>",
            to_f2_arg="        c_ComplexArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Int>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="integer(c_int)",
            equality_test="is_eq = is_eq .and. (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="Int",
            to_f2_arg="  c_Int&",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Int>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Int>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="integer(c_int)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray1D<Int, DIM1>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Int>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=2, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Int>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=2, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="integer(c_int)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray2D<Int, DIM1, DIM2>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=2, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Int>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=3, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Int>",
            to_f2_arg="        c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=3, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="integer(c_int)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray3D<Int, DIM1, DIM2, DIM3>",
            to_f2_arg="  c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer", dim=3, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Int>",
            to_f2_arg="        c_IntArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Int8>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="integer(c_long)",
            equality_test="is_eq = is_eq .and. (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="Int8",
            to_f2_arg="  c_Int8&",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Int8>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Int8>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="integer(c_long)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray1D<Int8, DIM1>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Int8>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=2, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Int8>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=2, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="integer(c_long)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray2D<Int8, DIM1, DIM2>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=2, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Int8>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=3, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Int8>",
            to_f2_arg="        c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=3, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="integer(c_long)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray3D<Int8, DIM1, DIM2, DIM3>",
            to_f2_arg="  c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="integer8", dim=3, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_long)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Int8>",
            to_f2_arg="        c_Int8Arr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Bool>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="logical(c_bool)",
            equality_test="is_eq = is_eq .and. (f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="Bool",
            to_f2_arg="  c_Bool&",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Bool>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Bool>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="logical(c_bool)",
            equality_test="is_eq = is_eq .and. all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray1D<Bool, DIM1>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Bool>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=2, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Bool>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=2, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="logical(c_bool)",
            equality_test="is_eq = is_eq .and. all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray2D<Bool, DIM1, DIM2>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=2, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Bool>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=3, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Bool>",
            to_f2_arg="        c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=3, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="logical(c_bool)",
            equality_test="is_eq = is_eq .and. all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray3D<Bool, DIM1, DIM2, DIM3>",
            to_f2_arg="  c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="logical", dim=3, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="logical(c_bool)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME .eqv. f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Bool>",
            to_f2_arg="        c_BoolArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Real>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="real(c_double)",
            equality_test="is_eq = is_eq .and. (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="Real",
            to_f2_arg="  c_Real&",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<Real>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Real>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="real(c_double)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray1D<Real, DIM1>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<Real>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=2, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Real>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=2, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="real(c_double)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray2D<Real, DIM1, DIM2>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=2, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<Real>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=3, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Real>",
            to_f2_arg="        c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=3, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="real(c_double)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray3D<Real, DIM1, DIM2, DIM3>",
            to_f2_arg="  c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real", dim=3, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<Real>",
            to_f2_arg="        c_RealArr",
            to_c2_arg="",
        ),
    ),
    FullType(type="real16", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="real(c_double)",
            to_f2_type="real(c_double)",
            equality_test="is_eq = is_eq .and. (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="Real",
            to_f2_arg="  c_Real&",
            to_c2_arg="",
        ),
    ),
    FullType(type="size", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="size", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="integer(c_int), value",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="",
            to_f2_arg="  c_Int",
            to_c2_arg="",
        ),
    ),
    FullType(type="size", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="size", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="size", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="integer(c_int), value",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="",
            to_f2_arg="  c_Int",
            to_c2_arg="",
        ),
    ),
    FullType(type="size", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="size", dim=2, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="size", dim=2, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="integer(c_int), value",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="",
            to_f2_arg="  c_Int",
            to_c2_arg="",
        ),
    ),
    FullType(type="size", dim=2, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="size", dim=3, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="size", dim=3, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="integer(c_int), value",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="",
            to_f2_arg="  c_Int",
            to_c2_arg="",
        ),
    ),
    FullType(type="size", dim=3, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="integer(c_int), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        None,
    ),
    FullType(type="type", dim=0, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<PROXYCLS>",
            to_f2_arg="  void*",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=0, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="PROXYCLS",
            to_f2_arg="  void *",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=0, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr), value",
            to_f2_type="type(c_ptr), value",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="std::optional<PROXYCLS>",
            to_f2_arg="  void *",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=1, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<PROXYCLS>",
            to_f2_arg="  const PROXYCLS**",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=1, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray1D<PROXYCLS, DIM1>",
            to_f2_arg="  void*",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=1, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray1D<PROXYCLS>",
            to_f2_arg="  const PROXYCLS**",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=2, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<PROXYCLS>",
            to_f2_arg="  const PROXYCLS**",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=2, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray2D<PROXYCLS, DIM1, DIM2>", to_f2_arg="  const PROXYCLS**", to_c2_arg=""
        ),
    ),
    FullType(type="type", dim=2, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray2D<PROXYCLS>",
            to_f2_arg="  const PROXYCLS**",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=3, ptr="ALLOC"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (allocated(f1%NAME) .eqv. allocated(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<PROXYCLS>",
            to_f2_arg="  const PROXYCLS**",
            to_c2_arg="",
        ),
    ),
    FullType(type="type", dim=3, ptr="NOT"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="FixedArray3D<PROXYCLS, DIM1, DIM2, DIM3>", to_f2_arg="  const PROXYCLS**", to_c2_arg=""
        ),
    ),
    FullType(type="type", dim=3, ptr="PTR"): (
        FortranSideTransform(
            to_c2_type="type(c_ptr)",
            to_f2_type="type(c_ptr)",
            equality_test="is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))\nif (.not. is_eq) return\nif (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)",
        ),
        CSideTransform(
            c_class="VariableArray3D<PROXYCLS>",
            to_f2_arg="  const PROXYCLS**",
            to_c2_arg="",
        ),
    ),
}


def _split_transforms(transforms):
    f_transforms = {}
    c_transforms = {}

    for full_type, (f_transform, c_transform) in transforms.items():
        if f_transform is not None:
            f_transforms[full_type] = f_transform
        if c_transform is not None:
            c_transforms[full_type] = c_transform

    return f_transforms, c_transforms


f_transforms, c_transforms = _split_transforms(transforms)
