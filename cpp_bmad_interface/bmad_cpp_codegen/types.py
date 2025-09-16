from __future__ import annotations

from typing import Literal, NamedTuple

REAL = "real"
REAL16 = "real16"  # quad precision
CMPLX = "complex"
INT = "integer"
INT8 = "integer8"
LOGIC = "logical"
CHAR = "character"
STRUCT = "type"
SIZE = "size"
ArgumentType = Literal[
    "real", "real16", "complex", "integer", "integer8", "logical", "character", "type", "size"
]

NOT = "NOT"
PTR = "PTR"
ALLOC = "ALLOC"
PointerType = Literal["NOT", "PTR", "ALLOC"]


class FullType(NamedTuple):
    type: ArgumentType
    dim: int
    ptr: PointerType

    def sort_key(self):
        return (self.dim, self.ptr, self.type)

    def __str__(self) -> str:
        return f"{self.dim}D_{self.ptr}_{self.type}"

    @staticmethod
    def from_template(type: str) -> FullType:
        dim, ptr, type_name = type.split("_")

        try:
            dim = int(dim.lower().rstrip("d"))
        except TypeError:
            raise ValueError(f"Dimension of type from template is not integer: {type=} {dim=}") from None

        if type_name not in (
            "real",
            "real16",
            "complex",
            "integer",
            "integer8",
            "logical",
            "character",
            "type",
            "size",
        ):
            raise ValueError(f"Unexpected type: {type_name}")
        if ptr not in ("NOT", "PTR", "ALLOC"):
            raise ValueError(f"Invalid pointer type: {type=} {ptr=}")
        return FullType(type_name, dim, ptr)
