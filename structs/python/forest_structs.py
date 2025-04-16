#!/usr/bin/env python
# vi: syntax=python sw=4 ts=4 sts=4
"""
This file is auto-generated; do not hand-edit it.
"""

from __future__ import annotations

try:
    from typing import Annotated, Sequence
except ImportError:
    from typing_extensions import Annotated, Sequence

import pydantic
from pydantic import PlainValidator, PlainSerializer

Complex = Annotated[
    complex,
    PlainValidator(
        lambda x: x if isinstance(x, complex) else complex(x.get("real", x.get("imag")))
    ),
    PlainSerializer(lambda x: {"real": x.real, "imag": x.imag}, return_type=dict),
]


class EGeneral(pydantic.BaseModel):
    """
    EGeneral corresponds to bmad `E_GENERAL`
    which is in Users/klauer/Repos/bmad/forest/code/Sc_euclidean.f90 on line 59.

    Attributes
    ----------
    kind : int
        Bmad type: INTEGER
    t1 : RXy
        Bmad type: R_XY
    t2 : RZ
        Bmad type: R_Z
    t3 : TXyz
        Bmad type: T_XYZ
    """

    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    t1: RXy = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("t1", "T1"),
        serialization_alias="T1",
    )
    t2: RZ = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("t2", "T2"),
        serialization_alias="T2",
    )
    t3: TXyz = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("t3", "T3"),
        serialization_alias="T3",
    )


class RXy(pydantic.BaseModel):
    """
    RXy corresponds to bmad `R_XY`
    which is in Users/klauer/Repos/bmad/forest/code/Sc_euclidean.f90 on line 45.

    Attributes
    ----------
    a : float
        Bmad type: REAL
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )


class RZ(pydantic.BaseModel):
    """
    RZ corresponds to bmad `R_Z`
    which is in Users/klauer/Repos/bmad/forest/code/Sc_euclidean.f90 on line 49.

    Attributes
    ----------
    a : float
        Bmad type: REAL
    """

    a: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )


class TXyz(pydantic.BaseModel):
    """
    TXyz corresponds to bmad `T_XYZ`
    which is in Users/klauer/Repos/bmad/forest/code/Sc_euclidean.f90 on line 53.

    Attributes
    ----------
    d : float
        Bmad type: REAL
    dl : float
        Bmad type: REAL
    dl_sixtrack : float
        Bmad type: REAL
    l_design : float
        Bmad type: REAL
    sixtrack : bool
        Bmad type: LOGICAL
    """

    d: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    dl: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dl", "DL"),
        serialization_alias="DL",
    )
    dl_sixtrack: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dl_sixtrack", "DL_SIXTRACK"),
        serialization_alias="DL_SIXTRACK",
    )
    l_design: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("l_design", "L_DESIGN"),
        serialization_alias="L_DESIGN",
    )
    sixtrack: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("sixtrack", "SIXTRACK"),
        serialization_alias="SIXTRACK",
    )


class BCyl(pydantic.BaseModel):
    """
    BCyl corresponds to bmad `B_CYL`
    which is in Users/klauer/Repos/bmad/forest/code/Se_status.f90 on line 148.

    Attributes
    ----------
    a_x : float
        Bmad type: real
    a_y : float
        Bmad type: real
    b_x : float
        Bmad type: real
    b_y : float
        Bmad type: real
    firsttime : int
        Bmad type: integer
    i : int
        ,ie,je
        Bmad type: integer, DIMENSION
    j : int
        ,ie,je
        Bmad type: integer, DIMENSION
    n_mono : int
        ,nmul_e,n_mono_e
        Bmad type: integer, POINTER
    nmul : int
        ,nmul_e,n_mono_e
        Bmad type: integer, POINTER
    va : float
        Bmad type: real
    vb : float
        Bmad type: real
    """

    a_x: float = pydantic.Field(
        default=0.0,
    )
    a_y: float = pydantic.Field(
        default=0.0,
    )
    b_x: float = pydantic.Field(
        default=0.0,
    )
    b_y: float = pydantic.Field(
        default=0.0,
    )
    firsttime: int = pydantic.Field(
        default=0,
    )
    i: int = pydantic.Field(
        default=0,
        description=",ie,je",
    )
    j: int = pydantic.Field(
        default=0,
        description=",ie,je",
    )
    n_mono: int = pydantic.Field(
        default=0,
        description=",nmul_e,n_mono_e",
    )
    nmul: int = pydantic.Field(
        default=0,
        description=",nmul_e,n_mono_e",
    )
    va: float = pydantic.Field(
        default=0.0,
    )
    vb: float = pydantic.Field(
        default=0.0,
    )


class ThreeDInfo(pydantic.BaseModel):
    """
    ThreeDInfo corresponds to bmad `three_d_info`
    which is in Users/klauer/Repos/bmad/forest/code/Sma_multiparticle.f90 on line 119.

    Attributes
    ----------
    a : float
        Centre of entrance and exit faces
        Bmad type: real
    b : float
        Centre of entrance and exit faces
        Bmad type: real
    ent : float
        entrace and exit frames for drawing magnet faces
        Bmad type: real
    exi : float
        entrace and exit frames for drawing magnet faces
        Bmad type: real
    mid : float
        frames at the point of tracking
        Bmad type: real
    o : float
        frames at the point of tracking
        Bmad type: real
    r : float
        ray position global returned
        Bmad type: real
    r0 : float
        ray position global returned
        Bmad type: real
    reference_ray : float
        Bmad type: real
    scale : float
        magnification using reference_ray
        Bmad type: real
    u : bool
        unstable flag for both ray and reference_ray
        Bmad type: logical
    wx : float
        width of box for plotting purposes
        Bmad type: real
    wy : float
        width of box for plotting purposes
        Bmad type: real
    x : float
        ray tracked with reference_ray using a  type(beam)
        Bmad type: real
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Centre of entrance and exit faces",
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Centre of entrance and exit faces",
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
        description="entrace and exit frames for drawing magnet faces",
    )
    exi: Sequence[float] = pydantic.Field(
        default=0.0,
        description="entrace and exit frames for drawing magnet faces",
    )
    mid: Sequence[float] = pydantic.Field(
        default=0.0,
        description="frames at the point of tracking",
    )
    o: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="frames at the point of tracking",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="ray position global returned",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="ray position global returned",
    )
    reference_ray: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )
    scale: float = pydantic.Field(
        default=0.0,
        description="magnification using reference_ray",
    )
    u: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=2,
        description="unstable flag for both ray and reference_ray",
    )
    wx: float = pydantic.Field(
        default=0.0,
        description="width of box for plotting purposes",
    )
    wy: float = pydantic.Field(
        default=0.0,
        description="width of box for plotting purposes",
    )
    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="ray tracked with reference_ray using a  type(beam)",
    )


class ElList(pydantic.BaseModel):
    """
    ElList corresponds to bmad `EL_LIST`
    which is in Users/klauer/Repos/bmad/forest/code/Sn_mad_like.f90 on line 58.

    Attributes
    ----------
    aperture_dx : float
        Bmad type: REAL
    aperture_dy : float
        Bmad type: REAL
    aperture_kind : int
        Bmad type: INTEGER
    aperture_on : bool
        Bmad type: LOGICAL
    aperture_polygn : int
        Bmad type: INTEGER
        Fortran default: 0
    aperture_polygx : float
        length defined with APERTURE_POLYGN
        Bmad type: REAL
        Fortran default: null()
    aperture_polygy : float
        Bmad type: REAL
        Fortran default: null()
    aperture_r : float
        Bmad type: REAL
    aperture_x : float
        Bmad type: REAL
    aperture_y : float
        Bmad type: REAL
    a_ac : float
        factors for base field oscillation (D0_BN) : BN(N) =
        (DC_AC+A_AC*clock)*D0_BN(N) + D_AC*clock*D_BN(N)
        Bmad type: REAL
    b0 : float
        Bmad type: real
    bend_fringe : bool
        Bmad type: LOGICAL
    bsol : float
        Bmad type: real
    cavity_totalpath : int
        Bmad type: integer
    dc_ac : float
        factors for base field oscillation (D0_BN) : BN(N) =
        (DC_AC+A_AC*clock)*D0_BN(N) + D_AC*clock*D_BN(N)
        Bmad type: REAL
    delta_e : float
        Bmad type: real
    dphas : float
        Bmad type: REAL
    d_ac : float
        factor for oscillation amplitude set by d_bn and d_an
        Bmad type: REAL
    fint : float
        Bmad type: real
    fint2 : float
        Bmad type: real
    k : float
        Bmad type: real
    kill_ent_fringe : bool
        Bmad type: LOGICAL
    kill_ent_spin : bool
        Bmad type: LOGICAL
    kill_exi_fringe : bool
        Bmad type: LOGICAL
    kill_exi_spin : bool
        Bmad type: LOGICAL
    kind : int
        Bmad type: INTEGER
    ks : float
        Bmad type: real
    L : float
        Bmad type: real
    lc : float
        Bmad type: real
    ld : float
        Bmad type: real
    name : str
        Bmad type: CHARACTER
    n_bessel : int
        Bmad type: INTEGER
    permfringe : int
        Bmad type: integer
    psi : float
        Bmad type: REAL
    t1 : float
        Bmad type: real
    t2 : float
        Bmad type: real
    vorname : str
        Bmad type: CHARACTER
    x_col : float
        Bmad type: real
    y_col : float
        Bmad type: real
    ang : float
        Bmad type: real
    angi : float
        Bmad type: real
    clockno_ac : int
        number (index) of the clock that this element is driven by
        Bmad type: INTEGER
    d_an : float
        oscillation amplitudes of multipoles (modulation)
        Bmad type: REAL
    d_bn : float
        oscillation amplitudes of multipoles (modulation)
        Bmad type: REAL
    d_phas : float
        oscillation amplitudes of RF voltage and phase (modulation)
        Bmad type: real
    d_volt : float
        oscillation amplitudes of RF voltage and phase (modulation)
        Bmad type: real
    dvds : float
        Bmad type: REAL
    file : str
        Bmad type: CHARACTER
    file_rev : str
        Bmad type: CHARACTER
    freq0 : float
        Bmad type: real
    h1 : float
        Bmad type: real
    h2 : float
        Bmad type: real
    harmon : float
        Bmad type: real
    hf : float
        highly illegal additions by frs
        Bmad type: real
    hgap : float
        Bmad type: real
    hgap2 : float
        Bmad type: real
    highest_fringe : int
        Bmad type: integer
    lag : float
        Bmad type: real
    ls : float
        highly illegal additions by frs
        Bmad type: real
    method : int
        Bmad type: INTEGER
    n_ac : int
        number of oscillating multipoles
        Bmad type: INTEGER
    nmul : int
        Bmad type: INTEGER
    nst : int
        Bmad type: INTEGER
    patchg : int
        Bmad type: integer
    t : float
        Bmad type: real
    theta_ac : float
        lag wrt the oscillation clock
        Bmad type: REAL
    thin_h_angle : float
        highly illegal additions by frs
        Bmad type: real
    thin_h_foc : float
        highly illegal additions by frs
        Bmad type: real
    thin_v_angle : float
        highly illegal additions by frs
        Bmad type: real
    thin_v_foc : float
        highly illegal additions by frs
        Bmad type: real
    ti : float
        Bmad type: real
    tilt : float
        Bmad type: real
    usethin : bool
        Bmad type: logical
    vf : float
        highly illegal additions by frs
        Bmad type: real
    volt : float
        Bmad type: real
    """

    aperture_dx: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("aperture_dx", "APERTURE_DX"),
        serialization_alias="APERTURE_DX",
    )
    aperture_dy: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("aperture_dy", "APERTURE_DY"),
        serialization_alias="APERTURE_DY",
    )
    aperture_kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("aperture_kind", "APERTURE_KIND"),
        serialization_alias="APERTURE_KIND",
    )
    aperture_on: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("aperture_on", "APERTURE_ON"),
        serialization_alias="APERTURE_ON",
    )
    aperture_polygn: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("aperture_polygn", "APERTURE_POLYGN"),
        serialization_alias="APERTURE_POLYGN",
    )
    aperture_polygx: float = pydantic.Field(
        default=0.0,
        description="length defined with APERTURE_POLYGN",
        validation_alias=pydantic.AliasChoices("aperture_polygx", "APERTURE_POLYGX"),
        serialization_alias="APERTURE_POLYGX",
    )
    aperture_polygy: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("aperture_polygy", "APERTURE_POLYGY"),
        serialization_alias="APERTURE_POLYGY",
    )
    aperture_r: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
        validation_alias=pydantic.AliasChoices("aperture_r", "APERTURE_R"),
        serialization_alias="APERTURE_R",
    )
    aperture_x: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("aperture_x", "APERTURE_X"),
        serialization_alias="APERTURE_X",
    )
    aperture_y: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("aperture_y", "APERTURE_Y"),
        serialization_alias="APERTURE_Y",
    )
    a_ac: float = pydantic.Field(
        default=0.0,
        description=(
            "factors for base field oscillation (D0_BN) : BN(N) = "
            "(DC_AC+A_AC*clock)*D0_BN(N) + D_AC*clock*D_BN(N)"
        ),
        validation_alias=pydantic.AliasChoices("a_ac", "A_ac"),
        serialization_alias="A_ac",
    )
    b0: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b0", "B0"),
        serialization_alias="B0",
    )
    bend_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("bend_fringe", "BEND_FRINGE"),
        serialization_alias="BEND_FRINGE",
    )
    bsol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("bsol", "BSOL"),
        serialization_alias="BSOL",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    dc_ac: float = pydantic.Field(
        default=0.0,
        description=(
            "factors for base field oscillation (D0_BN) : BN(N) = "
            "(DC_AC+A_AC*clock)*D0_BN(N) + D_AC*clock*D_BN(N)"
        ),
        validation_alias=pydantic.AliasChoices("dc_ac", "DC_ac"),
        serialization_alias="DC_ac",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    dphas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dphas", "DPHAS"),
        serialization_alias="DPHAS",
    )
    d_ac: float = pydantic.Field(
        default=0.0,
        description="factor for oscillation amplitude set by d_bn and d_an",
        validation_alias=pydantic.AliasChoices("d_ac", "D_ac"),
        serialization_alias="D_ac",
    )
    fint: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    fint2: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fint2", "FINT2"),
        serialization_alias="FINT2",
    )
    k: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    kill_ent_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_ent_fringe", "KILL_ENT_FRINGE"),
        serialization_alias="KILL_ENT_FRINGE",
    )
    kill_ent_spin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_ent_spin", "KILL_ENT_SPIN"),
        serialization_alias="KILL_ENT_SPIN",
    )
    kill_exi_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_exi_fringe", "KILL_EXI_FRINGE"),
        serialization_alias="KILL_EXI_FRINGE",
    )
    kill_exi_spin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_exi_spin", "KILL_EXI_SPIN"),
        serialization_alias="KILL_EXI_SPIN",
    )
    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    ks: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ks", "KS"),
        serialization_alias="KS",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    lc: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("lc", "LC"),
        serialization_alias="LC",
    )
    ld: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ld", "LD"),
        serialization_alias="LD",
    )
    name: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    permfringe: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("permfringe", "PERMFRINGE"),
        serialization_alias="PERMFRINGE",
    )
    psi: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("psi", "PSI"),
        serialization_alias="PSI",
    )
    t1: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("t1", "T1"),
        serialization_alias="T1",
    )
    t2: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("t2", "T2"),
        serialization_alias="T2",
    )
    vorname: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    x_col: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("x_col", "X_COL"),
        serialization_alias="X_COL",
    )
    y_col: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("y_col", "Y_COL"),
        serialization_alias="Y_COL",
    )
    ang: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    angi: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    clockno_ac: int = pydantic.Field(
        default=0,
        description="number (index) of the clock that this element is driven by",
    )
    d_an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of multipoles (modulation)",
    )
    d_bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of multipoles (modulation)",
    )
    d_phas: float = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of RF voltage and phase (modulation)",
    )
    d_volt: float = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of RF voltage and phase (modulation)",
    )
    dvds: float = pydantic.Field(
        default=0.0,
    )
    file: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    file_rev: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    freq0: float = pydantic.Field(
        default=0.0,
    )
    h1: float = pydantic.Field(
        default=0.0,
    )
    h2: float = pydantic.Field(
        default=0.0,
    )
    harmon: float = pydantic.Field(
        default=0.0,
    )
    hf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    hgap: float = pydantic.Field(
        default=0.0,
    )
    hgap2: float = pydantic.Field(
        default=0.0,
    )
    highest_fringe: int = pydantic.Field(
        default=0,
    )
    lag: float = pydantic.Field(
        default=0.0,
    )
    ls: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    method: int = pydantic.Field(
        default=0,
    )
    n_ac: int = pydantic.Field(
        default=0,
        description="number of oscillating multipoles",
    )
    nmul: int = pydantic.Field(
        default=0,
    )
    nst: int = pydantic.Field(
        default=0,
    )
    patchg: int = pydantic.Field(
        default=0,
    )
    t: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    theta_ac: float = pydantic.Field(
        default=0.0,
        description="lag wrt the oscillation clock",
    )
    thin_h_angle: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_h_foc: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_v_angle: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_v_foc: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    ti: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    tilt: float = pydantic.Field(
        default=0.0,
    )
    usethin: bool = pydantic.Field(
        default=False,
    )
    vf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    volt: float = pydantic.Field(
        default=0.0,
    )


class MadxSurvey(pydantic.BaseModel):
    """
    MadxSurvey corresponds to bmad `MADX_SURVEY`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 32.

    Attributes
    ----------
    alpha : float
        Bmad type: REAL
    chart : Chart
        Bmad type: CHART
    ld : float
        Bmad type: REAL
    phi : float
        Bmad type: REAL
    psi : float
        Bmad type: REAL
    theta : float
        Bmad type: REAL
    tilt : float
        Bmad type: REAL
    """

    alpha: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("alpha", "ALPHA"),
        serialization_alias="ALPHA",
    )
    chart: Chart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("chart", "CHART"),
        serialization_alias="CHART",
    )
    ld: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ld", "LD"),
        serialization_alias="LD",
    )
    phi: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phi", "PHI"),
        serialization_alias="PHI",
    )
    psi: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("psi", "PSI"),
        serialization_alias="PSI",
    )
    theta: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("theta", "THETA"),
        serialization_alias="THETA",
    )
    tilt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tilt", "TILT"),
        serialization_alias="TILT",
    )


class Keywords(pydantic.BaseModel):
    """
    Keywords corresponds to bmad `keywords`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 18.

    Attributes
    ----------
    fibre_dir : int
        Bmad type: INTEGER
    fibre_flip : bool
        Bmad type: logical
    list_ : ElList
        Bmad type: el_list
    exact : bool
        Bmad type: logical
    mad8 : bool
        Bmad type: logical
    madlength : bool
        Bmad type: logical
    magnet : str
        Bmad type: character
    method : int
        Bmad type: integer
    model : str
        Bmad type: character
    nstep : int
        Bmad type: integer
    tiltd : float
        Bmad type: real
    """

    fibre_dir: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("fibre_dir", "FIBRE_DIR"),
        serialization_alias="FIBRE_DIR",
    )
    fibre_flip: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("fibre_flip", "FIBRE_flip"),
        serialization_alias="FIBRE_flip",
    )
    list_: ElList = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("list_", "LIST"),
        serialization_alias="LIST",
    )
    exact: bool = pydantic.Field(
        default=False,
    )
    mad8: bool = pydantic.Field(
        default=False,
    )
    madlength: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("madlength", "madLENGTH"),
        serialization_alias="madLENGTH",
    )
    magnet: str = pydantic.Field(
        default_factory=list,
        max_length=20,
    )
    method: int = pydantic.Field(
        default=0,
    )
    model: str = pydantic.Field(
        default_factory=list,
        max_length=20,
    )
    nstep: int = pydantic.Field(
        default=0,
    )
    tiltd: float = pydantic.Field(
        default=0.0,
    )


class FibreMonitorData(pydantic.BaseModel):
    """
    FibreMonitorData corresponds to bmad `fibre_monitor_data`
    which is in Users/klauer/Repos/bmad/forest/code/Sra_fitting.f90 on line 15.

    Attributes
    ----------
    a : float
        Bmad type: real
    at : float
        Bmad type: real
    bpm : float
        store fake experiment from alex_track_monitors
        Bmad type: real
    full : bool
        Bmad type: logical
    kind : int
        kind=1 x, kind = 2 y
        Bmad type: integer, pointer
    mom : float
        Bmad type: real
    p : Fibre
        fibre location
        Bmad type: fibre
    r : float
        store fake experiment from alex_track_monitors
        Bmad type: real
    turn : int
        kind=1 x, kind = 2 y
        Bmad type: integer, pointer
    xf : float
        real data put here
        Bmad type: real
    xn : float
        real data put here
        Bmad type: real
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    at: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("at", "At"),
        serialization_alias="At",
    )
    bpm: Sequence[float] = pydantic.Field(
        default=0.0,
        description="store fake experiment from alex_track_monitors",
    )
    full: bool = pydantic.Field(
        default=False,
    )
    kind: int = pydantic.Field(
        default=0,
        description="kind=1 x, kind = 2 y",
    )
    mom: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    p: Fibre = pydantic.Field(
        default=None,
        description="fibre location",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        description="store fake experiment from alex_track_monitors",
    )
    turn: int = pydantic.Field(
        default=0,
        description="kind=1 x, kind = 2 y",
    )
    xf: Sequence[float] = pydantic.Field(
        default=0.0,
        description="real data put here",
    )
    xn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="real data put here",
    )


class Hermite(pydantic.BaseModel):
    """
    Hermite corresponds to bmad `hermite`
    which is in Users/klauer/Repos/bmad/forest/code/St_pointers.f90 on line 80.

    Attributes
    ----------
    a : float
        Bmad type: real
        Fortran default: 0
    ai : float
        Bmad type: real
        Fortran default: 0
    b : float
        Bmad type: real
    eps : float
        Bmad type: real
        Fortran default: 1.e-6_dp
    f : float
        Bmad type: real
        Fortran default: 0
    gen : int
        Bmad type: integer
        Fortran default: 0
    h : float
        Bmad type: real
    he : float
        Bmad type: real
        Fortran default: null()
    linear : bool
        Bmad type: logical
        Fortran default: .true.
    m : float
        Bmad type: real
        Fortran default: 0
    maxite : int
        Bmad type: integer
        Fortran default: 100
    mi : float
        Bmad type: real
        Fortran default: 0
    ms : Damap
        Bmad type: damap
    n : int
        Bmad type: integer
    nint : int
        Bmad type: integer
        Fortran default: 10
    no : int
        Bmad type: integer
    noh : int
        Bmad type: integer
    p : Probe8
        Bmad type: probe_8
    pos : int
        Bmad type: integer
    r : Layout
        Bmad type: layout
    state : InternalState
        Bmad type: internal_state
    x0 : float
        Bmad type: real
        Fortran default: null()
    """

    a: Sequence[float] = pydantic.Field(
        default=0,
    )
    ai: Sequence[float] = pydantic.Field(
        default=0,
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    f: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
    )
    gen: int = pydantic.Field(
        default=0,
    )
    h: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
    )
    he: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    linear: bool = pydantic.Field(
        default=True,
    )
    m: Sequence[float] = pydantic.Field(
        default=0,
    )
    maxite: int = pydantic.Field(
        default=100,
    )
    mi: Sequence[float] = pydantic.Field(
        default=0,
    )
    ms: Sequence[Damap] = pydantic.Field(
        default=None,
    )
    n: int = pydantic.Field(
        default=0,
    )
    nint: int = pydantic.Field(
        default=10,
    )
    no: int = pydantic.Field(
        default=0,
    )
    noh: int = pydantic.Field(
        default=0,
    )
    p: Sequence[Probe8] = pydantic.Field(
        default=None,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    r: Layout = pydantic.Field(
        default=None,
    )
    state: InternalState = pydantic.Field(
        default=None,
    )
    x0: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class InternalState(pydantic.BaseModel):
    """
    InternalState corresponds to bmad `INTERNAL_STATE`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 49.

    Attributes
    ----------
    delta : bool
        REAL_8 Taylor in (x,p_x,y,p_y,delta)
        Bmad type: LOGICAL
    envelope : bool
        Stochastic envelope terms tracked in probe_8
        Bmad type: LOGICAL
    fringe : bool
        Fringe fields are turned on (mainly for quadrupoles)
        Bmad type: LOGICAL
    full_way : bool
        Bmad type: LOGICAL
    modulation : bool
        One modulated family tracked by probe
        Bmad type: LOGICAL
    nocavity : bool
        Cavity is turned into a drift
        Bmad type: LOGICAL
    only_2d : bool
        REAL_8 Taylor in (x,p_x)
        Bmad type: LOGICAL
    only_4d : bool
        REAL_8 Taylor in (x,p_x,y,p_y)
        Bmad type: LOGICAL
    para_in : bool
        If true, parameters in the map are included
        Bmad type: LOGICAL
    radiation : bool
        Radiation is turned on
        Bmad type: LOGICAL
    spin : bool
        Spin is tracked
        Bmad type: LOGICAL
    stochastic : bool
        Random Stochastic kicks to x(5)
        Bmad type: LOGICAL
    time : bool
        Time is used instead of path length
        Bmad type: LOGICAL
    totalpath : int
        total time or path length is used
        Bmad type: INTEGER
    """

    delta: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x,y,p_y,delta)",
        validation_alias=pydantic.AliasChoices("delta", "DELTA"),
        serialization_alias="DELTA",
    )
    envelope: bool = pydantic.Field(
        default=False,
        description="Stochastic envelope terms tracked in probe_8",
        validation_alias=pydantic.AliasChoices("envelope", "ENVELOPE"),
        serialization_alias="ENVELOPE",
    )
    fringe: bool = pydantic.Field(
        default=False,
        description="Fringe fields are turned on (mainly for quadrupoles)",
        validation_alias=pydantic.AliasChoices("fringe", "FRINGE"),
        serialization_alias="FRINGE",
    )
    full_way: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("full_way", "FULL_WAY"),
        serialization_alias="FULL_WAY",
    )
    modulation: bool = pydantic.Field(
        default=False,
        description="One modulated family tracked by probe",
        validation_alias=pydantic.AliasChoices("modulation", "MODULATION"),
        serialization_alias="MODULATION",
    )
    nocavity: bool = pydantic.Field(
        default=False,
        description="Cavity is turned into a drift",
        validation_alias=pydantic.AliasChoices("nocavity", "NOCAVITY"),
        serialization_alias="NOCAVITY",
    )
    only_2d: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x)",
        validation_alias=pydantic.AliasChoices("only_2d", "ONLY_2D"),
        serialization_alias="ONLY_2D",
    )
    only_4d: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x,y,p_y)",
        validation_alias=pydantic.AliasChoices("only_4d", "ONLY_4D"),
        serialization_alias="ONLY_4D",
    )
    para_in: bool = pydantic.Field(
        default=False,
        description="If true, parameters in the map are included",
        validation_alias=pydantic.AliasChoices("para_in", "PARA_IN"),
        serialization_alias="PARA_IN",
    )
    radiation: bool = pydantic.Field(
        default=False,
        description="Radiation is turned on",
        validation_alias=pydantic.AliasChoices("radiation", "RADIATION"),
        serialization_alias="RADIATION",
    )
    spin: bool = pydantic.Field(
        default=False,
        description="Spin is tracked",
        validation_alias=pydantic.AliasChoices("spin", "SPIN"),
        serialization_alias="SPIN",
    )
    stochastic: bool = pydantic.Field(
        default=False,
        description="Random Stochastic kicks to x(5)",
        validation_alias=pydantic.AliasChoices("stochastic", "STOCHASTIC"),
        serialization_alias="STOCHASTIC",
    )
    time: bool = pydantic.Field(
        default=False,
        description="Time is used instead of path length",
        validation_alias=pydantic.AliasChoices("time", "TIME"),
        serialization_alias="TIME",
    )
    totalpath: int = pydantic.Field(
        default=0,
        description="total time or path length is used",
        validation_alias=pydantic.AliasChoices("totalpath", "TOTALPATH"),
        serialization_alias="TOTALPATH",
    )


class Bunch(pydantic.BaseModel):
    """
    Bunch corresponds to bmad `bunch`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 42.

    Attributes
    ----------
    n : int
        Bmad type: integer
    r : int
        Bmad type: integer
    reloaded : int
        Bmad type: integer
    stable : bool
        Bmad type: logical, pointer
    turn : float
        Bmad type: real
    xs : Probe
        Bmad type: probe
    """

    n: int = pydantic.Field(
        default=0,
    )
    r: int = pydantic.Field(
        default=0,
    )
    reloaded: int = pydantic.Field(
        default=0,
    )
    stable: Sequence[bool] = pydantic.Field(
        default=False,
    )
    turn: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    xs: Sequence[Probe] = pydantic.Field(
        default=None,
    )


class Probe(pydantic.BaseModel):
    """
    Probe corresponds to bmad `probe`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 90.

    Attributes
    ----------
    e : float
        Bmad type: real
    q : Quaternion
        Bmad type: quaternion
    s : Spinor
        Bmad type: spinor
    u : bool
        Bmad type: logical
    use_q : bool
        type(integration_node),pointer :: last_node=>null()
        Bmad type: logical
    x : float
        Bmad type: real
    """

    e: float = pydantic.Field(
        default=0.0,
    )
    q: Quaternion = pydantic.Field(
        default=None,
    )
    s: Sequence[Spinor] = pydantic.Field(
        default=None,
        max_length=3,
    )
    u: bool = pydantic.Field(
        default=False,
    )
    use_q: bool = pydantic.Field(
        default=False,
        description="type(integration_node),pointer :: last_node=>null()",
    )
    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )


class Quaternion(pydantic.BaseModel):
    """
    Quaternion corresponds to bmad `quaternion`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 86.

    Attributes
    ----------
    x : float
        Bmad type: real
    """

    x: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Spinor(pydantic.BaseModel):
    """
    Spinor corresponds to bmad `spinor`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 81.

    Attributes
    ----------
    x : float
        x(3) = (s_x, s_y, s_z)   with  |s|=1
        Bmad type: real
    """

    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="x(3) = (s_x, s_y, s_z)   with  |s|=1",
    )


class TreeElement(pydantic.BaseModel):
    """
    TreeElement corresponds to bmad `tree_element`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 68.

    Attributes
    ----------
    cc : float
        Bmad type: real
    jl : int
        Bmad type: integer,  DIMENSION
    jv : int
        Bmad type: integer,  DIMENSION
    n : int
        Bmad type: INTEGER,POINTER
    np : int
        Bmad type: INTEGER,POINTER
    beta0 : float
        Bmad type: real
    ds : float
        Bmad type: real
    e_ij : float
        Bmad type: real
    eps : float
        Bmad type: real
    factored : bool
        integer, pointer :: ng
        Bmad type: logical, pointer
    fix : float
        Bmad type: real
    fix0 : float
        Bmad type: real
    fixr : float
        Bmad type: real
    no : int
        Bmad type: INTEGER,POINTER
    rad : float
        Bmad type: real
    symptrack : bool
        Bmad type: logical, pointer
    usenonsymp : bool
        Bmad type: logical, pointer
    """

    cc: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("cc", "CC"),
        serialization_alias="CC",
    )
    jl: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("jl", "JL"),
        serialization_alias="JL",
    )
    jv: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("jv", "JV"),
        serialization_alias="JV",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    np: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("np", "NP"),
        serialization_alias="NP",
    )
    beta0: float = pydantic.Field(
        default=0.0,
    )
    ds: float = pydantic.Field(
        default=0.0,
    )
    e_ij: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    factored: bool = pydantic.Field(
        default=False,
        description="integer, pointer :: ng",
    )
    fix: float = pydantic.Field(
        default=0.0,
    )
    fix0: float = pydantic.Field(
        default=0.0,
    )
    fixr: float = pydantic.Field(
        default=0.0,
    )
    no: int = pydantic.Field(
        default=0,
    )
    rad: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    symptrack: bool = pydantic.Field(
        default=False,
    )
    usenonsymp: bool = pydantic.Field(
        default=False,
    )


class Control(pydantic.BaseModel):
    """
    Control corresponds to bmad `CONTROL`
    which is in Users/klauer/Repos/bmad/forest/code/a_scratch_size.f90 on line 268.

    Attributes
    ----------
    always_exactmis : bool
        =.TRUE. exact formula in tracking used for that element
        Bmad type: logical
        Fortran default: null()
    always_exact_patching : bool
        =.TRUE. patching done correctly used to output horror messages
        Bmad type: logical
        Fortran default: null()
    always_knobs : bool
        =.false. ptc knob default status
        Bmad type: logical
        Fortran default: null()
    aperture_flag : bool
        =.TRUE. aperture checks globally done (default)
        Bmad type: logical
        Fortran default: null()
    cavity_totalpath : int
        REAL PILL B0X =1 , FAKE =0  default
        Bmad type: integer, pointer
        Fortran default: null()
    check_madx_aperture : bool
        =.TRUE. false means particle lost in aperture
        Bmad type: logical
        Fortran default: null()
    check_stable : bool
        =.TRUE. particle status
        Bmad type: logical
        Fortran default: null()
    exact_model : bool
        = .false. exact model used
        Bmad type: logical
        Fortran default: null()
    feed_p0c : bool
        =.FALSE.  work takes p0c instead of energy
        Bmad type: logical
        Fortran default: null()
    fibre_dir : int
        =1 or -1 for reversed
        Bmad type: integer,pointer
        Fortran default: null()
    fibre_flip : bool
        =.true. x_prime true means noncanonical outside magnets. x(5) variables stays
        the same.
        Bmad type: logical
        Fortran default: null()
    highest_fringe : int
        =2  quadrupole fringe ON IF FRINGE PRESENT
        Bmad type: integer,pointer
        Fortran default: null()
    initial_charge : float
        =1 or -1 AND  ADJUST THE MASS IS THE PREFERED MODE creates a reverse propagator
        and a reversed ring in combination with above
        Bmad type: real
        Fortran default: null()
    mad : bool
        =.false. mad definition of multipole for input only
        Bmad type: logical
        Fortran default: null()
    mad8_wedge : bool
        QUAD_KICK + FRINGE IF FRINGE IS OUT.
        Bmad type: logical
        Fortran default: null()
    madlength : bool
        =.false. rbend crazy length in mad8 as input
        Bmad type: logical
        Fortran default: null()
    madthick : int
        Bmad type: integer, pointer
        Fortran default: null()
    madthin_normal : int
        Bmad type: integer, pointer
        Fortran default: null()
    madthin_skew : int
        Bmad type: integer, pointer
        Fortran default: null()
    metd : int
        number of steps and integration method
        Bmad type: integer, pointer
        Fortran default: null()
    npara : int
        PARAMETER LOCATION IN PTC in fpp
        Bmad type: integer,pointer
        Fortran default: null()
    nstd : int
        number of steps and integration method
        Bmad type: integer, pointer
        Fortran default: null()
    old : bool
        = true  = bERZ
        Bmad type: logical
        Fortran default: null()
    old_implementation_of_sixtrack : bool
        =.true.
        Bmad type: logical
        Fortran default: null()
    root_check : bool
        =.TRUE. performs check in roots and hyperbolic if true
        Bmad type: logical
        Fortran default: null()
    sector_nmul : int
        = 4  MULTIPOLES IN TEAPOT BEND ALLOWED BY DEFAULT
        Bmad type: integer, pointer
        Fortran default: null()
    sector_nmul_max : int
        = 10 maxwell equations is solved to order 10 in exact sectors
        Bmad type: integer, pointer
        Fortran default: null()
    stable_da_pancake : bool
        =.TRUE. particle status
        Bmad type: logical
        Fortran default: null()
    watch_user : bool
        FALSE NORMALLY : WATCHES USER FOR FAILING TO CHECK APERTURES
        Bmad type: logical
        Fortran default: null()
    absolute_aperture : float
        =1e3_dp generic aperture check
        Bmad type: REAL
        Fortran default: null()
    check_da : bool
        =.true.
        Bmad type: logical
        Fortran default: null()
    compute_stoch_kick : bool
        = .false. store stochastic kick for stochastic tracking
        Bmad type: logical
        Fortran default: null()
    da_absolute_aperture : float
        in case one tracks with da.
        Bmad type: REAL
        Fortran default: null()
    do_beam_beam : bool
        obvious meaning: false normally creates a reverse propagator
        Bmad type: logical
        Fortran default: null()
    electron : bool
        electron if true otherwise proton
        Bmad type: logical
        Fortran default: null()
    eps_pos : float
        fill once and never touch again
        Bmad type: real
        Fortran default: null()
    global_verbose : bool
        Bmad type: logical
        Fortran default: null()
    hyperbolic_aperture : float
        controls crashes in exponentials influence fibre creation
        Bmad type: real
        Fortran default: null()
    knob : bool
        Bmad type: logical
        Fortran default: null()
    lda_used : int
        maximum number of da variables in Berz's
        Bmad type: integer,pointer
        Fortran default: null()
    massfactor : float
        =one  sets variable muon and electron must be true global on the fly
        Bmad type: real
        Fortran default: null()
    nd : int
        degrees of freedom
        Bmad type: integer,pointer
        Fortran default: null()
    nd2 : int
        phase space dimension
        Bmad type: integer,pointer
        Fortran default: null()
    nd2harm : int
        harmonic plane
        Bmad type: integer,pointer
        Fortran default: null()
    nd2t : int
        harmonic planes minus clocks
        Bmad type: integer,pointer
        Fortran default: null()
    ndc2t : int
        0 or 2 : jordan planes
        Bmad type: integer,pointer
        Fortran default: null()
    ndpt : int
        constant energy variable position is different from zero
        Bmad type: integer,pointer
        Fortran default: null()
    ndpt_bmad : int
        Bmad type: integer, pointer
        Fortran default: null()
    ndptb : int
        Bmad type: integer,pointer
        Fortran default: null()
    no : int
        order of da
        Bmad type: integer,pointer
        Fortran default: null()
    no_hyperbolic_in_normal_form : bool
        unstable produces exception
        Bmad type: logical
        Fortran default: null()
    np : int
        number of parameters in fpp
        Bmad type: integer,pointer
        Fortran default: null()
    np_pol : int
        parameters produced through pol_block
        Bmad type: integer,pointer
        Fortran default: null()
    npara_fpp : int
        PARAMETER LOCATION IN FPP or PTC
        Bmad type: integer,pointer
        Fortran default: null()
    nspin : int
        number of spin variables (0 or 3) integer,pointer :: SPIN_pos => null()       !
        position of spin variables (0 or 3)
        Bmad type: integer,pointer
        Fortran default: null()
    nv : int
        number of variables
        Bmad type: integer,pointer
        Fortran default: null()
    phase0 : float
        default phase in cavity
        Bmad type: real
        Fortran default: null()
    pos_of_delta : int
        constant delta
        Bmad type: integer,pointer
        Fortran default: null()
    real_warning : bool
        = true
        Bmad type: logical
        Fortran default: null()
    recirculator_cheat : bool
        =.false.  if true energy patches use the time formula always
        Bmad type: logical
        Fortran default: null()
    rf : int
        # of modulated planes
        Bmad type: integer,pointer
        Fortran default: null()
    s_aperture_check : bool
        =.TRUE. aperture checks globally done (default)
        Bmad type: logical
        Fortran default: null()
    setknob : bool
        Bmad type: logical
        Fortran default: null()
    sixtrack_compatible : bool
        to insure some sixtrack compatibility default=false
        Bmad type: logical
        Fortran default: null()
    stable_da : bool
        =.true.  interrupts DA if check_da is true
        Bmad type: logical
        Fortran default: null()
    total_da_size : float
        in megabytes
        Bmad type: real
        Fortran default: null()
    valishev : bool
        integer, pointer :: NDPT_OTHER
        Bmad type: logical
        Fortran default: null()
    wedge_coeff : float
        QUAD_KICK IN WEDGE
        Bmad type: real
        Fortran default: null()
    wherelost : int
        counting lost particles in integration nodes
        Bmad type: integer,pointer
        Fortran default: null()
    """

    always_exactmis: bool = pydantic.Field(
        default=False,
        description="=.TRUE. exact formula in tracking used for that element",
        validation_alias=pydantic.AliasChoices("always_exactmis", "ALWAYS_EXACTMIS"),
        serialization_alias="ALWAYS_EXACTMIS",
    )
    always_exact_patching: bool = pydantic.Field(
        default=False,
        description="=.TRUE. patching done correctly used to output horror messages",
        validation_alias=pydantic.AliasChoices(
            "always_exact_patching", "ALWAYS_EXACT_PATCHING"
        ),
        serialization_alias="ALWAYS_EXACT_PATCHING",
    )
    always_knobs: bool = pydantic.Field(
        default=False,
        description="=.false. ptc knob default status",
        validation_alias=pydantic.AliasChoices("always_knobs", "ALWAYS_knobs"),
        serialization_alias="ALWAYS_knobs",
    )
    aperture_flag: bool = pydantic.Field(
        default=False,
        description="=.TRUE. aperture checks globally done (default)",
        validation_alias=pydantic.AliasChoices("aperture_flag", "APERTURE_FLAG"),
        serialization_alias="APERTURE_FLAG",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="REAL PILL B0X =1 , FAKE =0  default",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    check_madx_aperture: bool = pydantic.Field(
        default=False,
        description="=.TRUE. false means particle lost in aperture",
        validation_alias=pydantic.AliasChoices(
            "check_madx_aperture", "CHECK_MADX_APERTURE"
        ),
        serialization_alias="CHECK_MADX_APERTURE",
    )
    check_stable: bool = pydantic.Field(
        default=False,
        description="=.TRUE. particle status",
        validation_alias=pydantic.AliasChoices("check_stable", "CHECK_STABLE"),
        serialization_alias="CHECK_STABLE",
    )
    exact_model: bool = pydantic.Field(
        default=False,
        description="= .false. exact model used",
        validation_alias=pydantic.AliasChoices("exact_model", "EXACT_MODEL"),
        serialization_alias="EXACT_MODEL",
    )
    feed_p0c: bool = pydantic.Field(
        default=False,
        description="=.FALSE.  work takes p0c instead of energy",
        validation_alias=pydantic.AliasChoices("feed_p0c", "FEED_P0C"),
        serialization_alias="FEED_P0C",
    )
    fibre_dir: int = pydantic.Field(
        default=0,
        description="=1 or -1 for reversed",
        validation_alias=pydantic.AliasChoices("fibre_dir", "FIBRE_DIR"),
        serialization_alias="FIBRE_DIR",
    )
    fibre_flip: bool = pydantic.Field(
        default=False,
        description=(
            "=.true. x_prime true means noncanonical outside magnets. x(5) variables "
            "stays the same."
        ),
        validation_alias=pydantic.AliasChoices("fibre_flip", "FIBRE_flip"),
        serialization_alias="FIBRE_flip",
    )
    highest_fringe: int = pydantic.Field(
        default=0,
        description="=2  quadrupole fringe ON IF FRINGE PRESENT",
        validation_alias=pydantic.AliasChoices("highest_fringe", "HIGHEST_FRINGE"),
        serialization_alias="HIGHEST_FRINGE",
    )
    initial_charge: float = pydantic.Field(
        default=0.0,
        description=(
            "=1 or -1 AND  ADJUST THE MASS IS THE PREFERED MODE creates a reverse "
            "propagator and a reversed ring in combination with above"
        ),
        validation_alias=pydantic.AliasChoices("initial_charge", "INITIAL_CHARGE"),
        serialization_alias="INITIAL_CHARGE",
    )
    mad: bool = pydantic.Field(
        default=False,
        description="=.false. mad definition of multipole for input only",
        validation_alias=pydantic.AliasChoices("mad", "MAD"),
        serialization_alias="MAD",
    )
    mad8_wedge: bool = pydantic.Field(
        default=False,
        description="QUAD_KICK + FRINGE IF FRINGE IS OUT.",
        validation_alias=pydantic.AliasChoices("mad8_wedge", "MAD8_WEDGE"),
        serialization_alias="MAD8_WEDGE",
    )
    madlength: bool = pydantic.Field(
        default=False,
        description="=.false. rbend crazy length in mad8 as input",
        validation_alias=pydantic.AliasChoices("madlength", "MADLENGTH"),
        serialization_alias="MADLENGTH",
    )
    madthick: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("madthick", "MADTHICK"),
        serialization_alias="MADTHICK",
    )
    madthin_normal: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("madthin_normal", "MADTHIN_NORMAL"),
        serialization_alias="MADTHIN_NORMAL",
    )
    madthin_skew: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("madthin_skew", "MADTHIN_SKEW"),
        serialization_alias="MADTHIN_SKEW",
    )
    metd: int = pydantic.Field(
        default=0,
        description="number of steps and integration method",
        validation_alias=pydantic.AliasChoices("metd", "METD"),
        serialization_alias="METD",
    )
    npara: int = pydantic.Field(
        default=0,
        description="PARAMETER LOCATION IN PTC in fpp",
        validation_alias=pydantic.AliasChoices("npara", "NPARA"),
        serialization_alias="NPARA",
    )
    nstd: int = pydantic.Field(
        default=0,
        description="number of steps and integration method",
        validation_alias=pydantic.AliasChoices("nstd", "NSTD"),
        serialization_alias="NSTD",
    )
    old: bool = pydantic.Field(
        default=False,
        description="= true  = bERZ",
        validation_alias=pydantic.AliasChoices("old", "OLD"),
        serialization_alias="OLD",
    )
    old_implementation_of_sixtrack: bool = pydantic.Field(
        default=False,
        description="=.true.",
        validation_alias=pydantic.AliasChoices(
            "old_implementation_of_sixtrack", "OLD_IMPLEMENTATION_OF_SIXTRACK"
        ),
        serialization_alias="OLD_IMPLEMENTATION_OF_SIXTRACK",
    )
    root_check: bool = pydantic.Field(
        default=False,
        description="=.TRUE. performs check in roots and hyperbolic if true",
        validation_alias=pydantic.AliasChoices("root_check", "ROOT_CHECK"),
        serialization_alias="ROOT_CHECK",
    )
    sector_nmul: int = pydantic.Field(
        default=0,
        description="= 4  MULTIPOLES IN TEAPOT BEND ALLOWED BY DEFAULT",
        validation_alias=pydantic.AliasChoices("sector_nmul", "SECTOR_NMUL"),
        serialization_alias="SECTOR_NMUL",
    )
    sector_nmul_max: int = pydantic.Field(
        default=0,
        description="= 10 maxwell equations is solved to order 10 in exact sectors",
        validation_alias=pydantic.AliasChoices("sector_nmul_max", "SECTOR_NMUL_MAX"),
        serialization_alias="SECTOR_NMUL_MAX",
    )
    stable_da_pancake: bool = pydantic.Field(
        default=False,
        description="=.TRUE. particle status",
        validation_alias=pydantic.AliasChoices(
            "stable_da_pancake", "STABLE_DA_pancake"
        ),
        serialization_alias="STABLE_DA_pancake",
    )
    watch_user: bool = pydantic.Field(
        default=False,
        description="FALSE NORMALLY : WATCHES USER FOR FAILING TO CHECK APERTURES",
        validation_alias=pydantic.AliasChoices("watch_user", "WATCH_USER"),
        serialization_alias="WATCH_USER",
    )
    absolute_aperture: float = pydantic.Field(
        default=0.0,
        description="=1e3_dp generic aperture check",
    )
    check_da: bool = pydantic.Field(
        default=False,
        description="=.true.",
    )
    compute_stoch_kick: bool = pydantic.Field(
        default=False,
        description="= .false. store stochastic kick for stochastic tracking",
    )
    da_absolute_aperture: float = pydantic.Field(
        default=0.0,
        description="in case one tracks with da.",
    )
    do_beam_beam: bool = pydantic.Field(
        default=False,
        description="obvious meaning: false normally creates a reverse propagator",
    )
    electron: bool = pydantic.Field(
        default=False,
        description="electron if true otherwise proton",
    )
    eps_pos: float = pydantic.Field(
        default=0.0,
        description="fill once and never touch again",
    )
    global_verbose: bool = pydantic.Field(
        default=False,
    )
    hyperbolic_aperture: float = pydantic.Field(
        default=0.0,
        description="controls crashes in exponentials influence fibre creation",
    )
    knob: bool = pydantic.Field(
        default=False,
    )
    lda_used: int = pydantic.Field(
        default=0,
        description="maximum number of da variables in Berz's",
    )
    massfactor: float = pydantic.Field(
        default=0.0,
        description="=one  sets variable muon and electron must be true global on the fly",
    )
    nd: int = pydantic.Field(
        default=0,
        description="degrees of freedom",
    )
    nd2: int = pydantic.Field(
        default=0,
        description="phase space dimension",
    )
    nd2harm: int = pydantic.Field(
        default=0,
        description="harmonic plane",
    )
    nd2t: int = pydantic.Field(
        default=0,
        description="harmonic planes minus clocks",
    )
    ndc2t: int = pydantic.Field(
        default=0,
        description="0 or 2 : jordan planes",
    )
    ndpt: int = pydantic.Field(
        default=0,
        description="constant energy variable position is different from zero",
    )
    ndpt_bmad: int = pydantic.Field(
        default=0,
    )
    ndptb: int = pydantic.Field(
        default=0,
    )
    no: int = pydantic.Field(
        default=0,
        description="order of da",
    )
    no_hyperbolic_in_normal_form: bool = pydantic.Field(
        default=False,
        description="unstable produces exception",
    )
    np: int = pydantic.Field(
        default=0,
        description="number of parameters in fpp",
    )
    np_pol: int = pydantic.Field(
        default=0,
        description="parameters produced through pol_block",
    )
    npara_fpp: int = pydantic.Field(
        default=0,
        description="PARAMETER LOCATION IN FPP or PTC",
    )
    nspin: int = pydantic.Field(
        default=0,
        description=(
            "number of spin variables (0 or 3) integer,pointer :: SPIN_pos => null() "
            "! position of spin variables (0 or 3)"
        ),
    )
    nv: int = pydantic.Field(
        default=0,
        description="number of variables",
    )
    phase0: float = pydantic.Field(
        default=0.0,
        description="default phase in cavity",
    )
    pos_of_delta: int = pydantic.Field(
        default=0,
        description="constant delta",
    )
    real_warning: bool = pydantic.Field(
        default=False,
        description="= true",
    )
    recirculator_cheat: bool = pydantic.Field(
        default=False,
        description="=.false.  if true energy patches use the time formula always",
    )
    rf: int = pydantic.Field(
        default=0,
        description="# of modulated planes",
    )
    s_aperture_check: bool = pydantic.Field(
        default=False,
        description="=.TRUE. aperture checks globally done (default)",
        validation_alias=pydantic.AliasChoices("s_aperture_check", "s_aperture_CHECK"),
        serialization_alias="s_aperture_CHECK",
    )
    setknob: bool = pydantic.Field(
        default=False,
    )
    sixtrack_compatible: bool = pydantic.Field(
        default=False,
        description="to insure some sixtrack compatibility default=false",
    )
    stable_da: bool = pydantic.Field(
        default=False,
        description="=.true.  interrupts DA if check_da is true",
    )
    total_da_size: float = pydantic.Field(
        default=0.0,
        description="in megabytes",
    )
    valishev: bool = pydantic.Field(
        default=False,
        description="integer, pointer :: NDPT_OTHER",
    )
    wedge_coeff: Sequence[float] = pydantic.Field(
        default=0.0,
        description="QUAD_KICK IN WEDGE",
    )
    wherelost: int = pydantic.Field(
        default=0,
        description="counting lost particles in integration nodes",
    )


class File(pydantic.BaseModel):
    """
    File corresponds to bmad `file_`
    which is in Users/klauer/Repos/bmad/forest/code/a_scratch_size.f90 on line 1236.

    Attributes
    ----------
    mf : bool
        AIMIN CHANGES FOR MS4.0 logical(lp) :: mf=.false.
        Bmad type: logical
    """

    mf: bool = pydantic.Field(
        default=False,
        description="AIMIN CHANGES FOR MS4.0 logical(lp) :: mf=.false.",
        validation_alias=pydantic.AliasChoices("mf", "MF"),
        serialization_alias="MF",
    )


class FileK(pydantic.BaseModel):
    """
    FileK corresponds to bmad `file_K`
    which is in Users/klauer/Repos/bmad/forest/code/a_scratch_size.f90 on line 1242.

    Attributes
    ----------
    mf : bool
        AIMIN CHANGES FOR MS4.0 logical(lp) :: mf=.false.
        Bmad type: logical
    """

    mf: bool = pydantic.Field(
        default=False,
        description="AIMIN CHANGES FOR MS4.0 logical(lp) :: mf=.false.",
        validation_alias=pydantic.AliasChoices("mf", "MF"),
        serialization_alias="MF",
    )


class My1dTaylor(pydantic.BaseModel):
    """
    My1dTaylor corresponds to bmad `my_1D_taylor`
    which is in Users/klauer/Repos/bmad/forest/code/a_scratch_size.f90 on line 1483.

    Attributes
    ----------
    a : float
        Bmad type: real
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class MyLinearTaylor(pydantic.BaseModel):
    """
    MyLinearTaylor corresponds to bmad `my_linear_taylor`
    which is in Users/klauer/Repos/bmad/forest/code/a_scratch_size.f90 on line 1993.

    Attributes
    ----------
    a : Complex
        @2  &nbsp; Taylor series eC[WJieC[Äñ©¢)
        ®¬_iÓÇ¤µå¤·¤Äñ·¤j
        Bmad type: complex
    """

    a: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description=("@2  &nbsp; Taylor series eC[WJieC[Äñ©¢) " "®¬_iÓÇ¤µå¤·¤Äñ·¤j"),
    )


class CTaylor(pydantic.BaseModel):
    """
    CTaylor corresponds to bmad `C_taylor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 391.

    Attributes
    ----------
    i : int
        @1  integer I is a pointer to the complexified Berz package
        Bmad type: INTEGER
    """

    i: int = pydantic.Field(
        default=0,
        description="@1  integer I is a pointer to the complexified Berz package",
        validation_alias=pydantic.AliasChoices("i", "I"),
        serialization_alias="I",
    )


class Damap(pydantic.BaseModel):
    """
    Damap corresponds to bmad `DAMAP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 189.

    Attributes
    ----------
    v : Taylor
        Ndim2=6 but allocated to nd2=2,4,6 ! etienne_oct_2004
        Bmad type: TAYLOR
    """

    v: Sequence[Taylor] = pydantic.Field(
        default=None,
        description="Ndim2=6 but allocated to nd2=2,4,6 ! etienne_oct_2004",
        validation_alias=pydantic.AliasChoices("v", "V"),
        serialization_alias="V",
    )


class Dragtfinn(pydantic.BaseModel):
    """
    Dragtfinn corresponds to bmad `DRAGTFINN`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 226.

    Attributes
    ----------
    linear : Damap
        Bmad type: damap
    constant : float
        Bmad type: real
    nonlinear : Vecfield
        Bmad type: vecfield
    pb : Pbfield
        Bmad type: pbfield
    """

    linear: Damap = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("linear", "Linear"),
        serialization_alias="Linear",
    )
    constant: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    nonlinear: Vecfield = pydantic.Field(
        default=None,
    )
    pb: Pbfield = pydantic.Field(
        default=None,
    )


class Gmap(pydantic.BaseModel):
    """
    Gmap corresponds to bmad `GMAP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 195.

    Attributes
    ----------
    n : int
        Bmad type: integer
    v : Taylor
        Bmad type: TAYLOR
    """

    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    v: Sequence[Taylor] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("v", "V"),
        serialization_alias="V",
    )


class Onelieexponent(pydantic.BaseModel):
    """
    Onelieexponent corresponds to bmad `ONELIEEXPONENT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 240.

    Attributes
    ----------
    eps : float
        Bmad type: real
    vector : Vecfield
        Bmad type: vecfield
    pb : Pbfield
        Bmad type: pbfield
    """

    eps: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("eps", "EPS"),
        serialization_alias="EPS",
    )
    vector: Vecfield = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("vector", "VECTOR"),
        serialization_alias="VECTOR",
    )
    pb: Pbfield = pydantic.Field(
        default=None,
    )


class Real8(pydantic.BaseModel):
    """
    Real8 corresponds to bmad `REAL_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 114.

    Attributes
    ----------
    alloc : bool
        @1 IF TAYLOR IS ALLOCATED IN DA-PACKAGE integer g,nb  !  group index, number in
        group &2
        Bmad type: LOGICAL
    i : int
        @1   USED FOR KNOBS AND SPECIAL KIND=0
        Bmad type: INTEGER
    kind : int
        @1  0,1,2,3 (1=REAL,2=TAYLOR,3=TAYLOR KNOB, 0=SPECIAL)
        Bmad type: INTEGER
    r : float
        @1    USED IF REAL &2
        Bmad type: REAL
    s : float
        @1   SCALING FOR KNOBS AND SPECIAL KIND=0
        Bmad type: REAL
    t : Taylor
        @1  USED IF TAYLOR
        Bmad type: TAYLOR
    """

    alloc: bool = pydantic.Field(
        default=False,
        description=(
            "@1 IF TAYLOR IS ALLOCATED IN DA-PACKAGE integer g,nb  !  group index, "
            "number in group &2"
        ),
        validation_alias=pydantic.AliasChoices("alloc", "ALLOC"),
        serialization_alias="ALLOC",
    )
    i: int = pydantic.Field(
        default=0,
        description="@1   USED FOR KNOBS AND SPECIAL KIND=0",
        validation_alias=pydantic.AliasChoices("i", "I"),
        serialization_alias="I",
    )
    kind: int = pydantic.Field(
        default=0,
        description="@1  0,1,2,3 (1=REAL,2=TAYLOR,3=TAYLOR KNOB, 0=SPECIAL)",
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    r: float = pydantic.Field(
        default=0.0,
        description="@1    USED IF REAL &2",
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
    )
    s: float = pydantic.Field(
        default=0.0,
        description="@1   SCALING FOR KNOBS AND SPECIAL KIND=0",
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    t: Taylor = pydantic.Field(
        default=None,
        description="@1  USED IF TAYLOR",
        validation_alias=pydantic.AliasChoices("t", "T"),
        serialization_alias="T",
    )


class TemporalBeam(pydantic.BaseModel):
    """
    TemporalBeam corresponds to bmad `TEMPORAL_BEAM`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 383.

    Attributes
    ----------
    tp : TemporalProbe
        Bmad type: TEMPORAL_PROBE
    a : float
        Bmad type: real
    c : IntegrationNode
        pointer close to a(3)
        Bmad type: integration_node
    ent : float
        Bmad type: real
    n : int
        Bmad type: integer
    p0c : float
        Bmad type: real
    state : InternalState
        Bmad type: internal_state
    total_time : float
        Bmad type: real
    """

    tp: Sequence[TemporalProbe] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("tp", "TP"),
        serialization_alias="TP",
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    c: IntegrationNode = pydantic.Field(
        default=None,
        description="pointer close to a(3)",
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
    )
    p0c: float = pydantic.Field(
        default=0.0,
    )
    state: InternalState = pydantic.Field(
        default=None,
    )
    total_time: float = pydantic.Field(
        default=0.0,
    )


class TemporalProbe(pydantic.BaseModel):
    """
    TemporalProbe corresponds to bmad `TEMPORAL_PROBE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 374.

    Attributes
    ----------
    ic : float
        (x,y,z,px,py,pz) at dt0
        Bmad type: real
    node : IntegrationNode
        Bmad type: INTEGRATION_NODE
    pos : float
        (x,y,z,px,py,pz) at dt0 and total time
        Bmad type: real
    t : float
        (x,y,z,px,py,pz) at dt0 and total time
        Bmad type: real
    xs : Probe
        probe at r=0
        Bmad type: probe
    dt0 : float
        penetration ration, penetration time
        Bmad type: real
    r : float
        penetration ration, penetration time
        Bmad type: real
    s : Spinor
        spin vectors at dt0
        Bmad type: spinor
    """

    ic: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="(x,y,z,px,py,pz) at dt0",
        validation_alias=pydantic.AliasChoices("ic", "IC"),
        serialization_alias="IC",
    )
    node: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("node", "NODE"),
        serialization_alias="NODE",
    )
    pos: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="(x,y,z,px,py,pz) at dt0 and total time",
        validation_alias=pydantic.AliasChoices("pos", "POS"),
        serialization_alias="POS",
    )
    t: float = pydantic.Field(
        default=0.0,
        description="(x,y,z,px,py,pz) at dt0 and total time",
        validation_alias=pydantic.AliasChoices("t", "T"),
        serialization_alias="T",
    )
    xs: Probe = pydantic.Field(
        default=None,
        description="probe at r=0",
        validation_alias=pydantic.AliasChoices("xs", "XS"),
        serialization_alias="XS",
    )
    dt0: float = pydantic.Field(
        default=0.0,
        description="penetration ration, penetration time",
    )
    r: float = pydantic.Field(
        default=0.0,
        description="penetration ration, penetration time",
    )
    s: Sequence[Spinor] = pydantic.Field(
        default=None,
        max_length=3,
        description="spin vectors at dt0",
    )


class UniversalTaylor(pydantic.BaseModel):
    """
    UniversalTaylor corresponds to bmad `UNIVERSAL_TAYLOR`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 94.

    Attributes
    ----------
    c : float
        Coefficients C(N)
        Bmad type: REAL
    j : int
        Exponents of each coefficients J(N,NV)
        Bmad type: INTEGER, POINTER,dimension
    n : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER, POINTER
    nv : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER, POINTER
    """

    c: float = pydantic.Field(
        default=0.0,
        description="Coefficients C(N)",
        validation_alias=pydantic.AliasChoices("c", "C"),
        serialization_alias="C",
    )
    j: int = pydantic.Field(
        default=0,
        description="Exponents of each coefficients J(N,NV)",
        validation_alias=pydantic.AliasChoices("j", "J"),
        serialization_alias="J",
    )
    n: int = pydantic.Field(
        default=0,
        description="Number of coeeficients and number of variables",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    nv: int = pydantic.Field(
        default=0,
        description="Number of coeeficients and number of variables",
        validation_alias=pydantic.AliasChoices("nv", "NV"),
        serialization_alias="NV",
    )


class CUniversalTaylor(pydantic.BaseModel):
    """
    CUniversalTaylor corresponds to bmad `c_UNIVERSAL_TAYLOR`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 100.

    Attributes
    ----------
    c : Complex
        Coefficients C(N)
        Bmad type: complex
        Fortran default: null()
    j : int
        Exponents of each coefficients J(N,NV)
        Bmad type: INTEGER, POINTER,dimension
        Fortran default: null()
    n : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER, POINTER
    nv : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER, POINTER
    nd2 : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER, POINTER
        Fortran default: null()
    """

    c: Complex = pydantic.Field(
        default=0.0,
        description="Coefficients C(N)",
        validation_alias=pydantic.AliasChoices("c", "C"),
        serialization_alias="C",
    )
    j: int = pydantic.Field(
        default=0,
        description="Exponents of each coefficients J(N,NV)",
        validation_alias=pydantic.AliasChoices("j", "J"),
        serialization_alias="J",
    )
    n: int = pydantic.Field(
        default=0,
        description="Number of coeeficients and number of variables",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    nv: int = pydantic.Field(
        default=0,
        description="Number of coeeficients and number of variables",
        validation_alias=pydantic.AliasChoices("nv", "NV"),
        serialization_alias="NV",
    )
    nd2: int = pydantic.Field(
        default=0,
        description="Number of coeeficients and number of variables",
    )


class CDalevel(pydantic.BaseModel):
    """
    CDalevel corresponds to bmad `c_dalevel`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 404.

    Attributes
    ----------
    closed : bool
        Bmad type: logical
    end : CDascratch
        Bmad type: c_dascratch
    end_ground : CDascratch
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: c_dascratch
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER,  POINTER
    present : CDascratch
        Bmad type: c_dascratch
    start : CDascratch
        Bmad type: c_dascratch
    start_ground : CDascratch
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: c_dascratch
    """

    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    end: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    end_ground: CDascratch = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    present: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("present", "PRESENT"),
        serialization_alias="PRESENT",
    )
    start: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )
    start_ground: CDascratch = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("start_ground", "START_GROUND"),
        serialization_alias="START_GROUND",
    )


class CDamap(pydantic.BaseModel):
    """
    CDamap corresponds to bmad `c_damap`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 434.

    Attributes
    ----------
    cm : Complex
        Moment matrix (transpose of Yu Matrix)
        Bmad type: complex
        Fortran default: null()
    e_ij : Complex
        @1 stochastic fluctuation in radiation theory Number of planes allocated
        Bmad type: complex
    m : float
        SO(3) is deprecated in FPP and computed from quaternion if needed
        Bmad type: real
        Fortran default: null()
    n : int
        @1 number of planes allocated Initial orbit if tpsa =  true
        Bmad type: integer
        Fortran default: 0
    q : CQuaternion
        Stochastic part
        Bmad type: c_quaternion
    s : CSpinmatrix
        @1 spin matrix
        Bmad type: c_spinmatrix
    v : CTaylor
        @1 orbital part of the map
        Bmad type: c_taylor
    x0 : Complex
        Lie map matrix  (Yu's square matrix)
        Bmad type: complex
    """

    cm: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Moment matrix (transpose of Yu Matrix)",
    )
    e_ij: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1 stochastic fluctuation in radiation theory Number of planes allocated",
    )
    m: Sequence[float] = pydantic.Field(
        default=0.0,
        description="SO(3) is deprecated in FPP and computed from quaternion if needed",
    )
    n: int = pydantic.Field(
        default=0,
        description="@1 number of planes allocated Initial orbit if tpsa =  true",
    )
    q: CQuaternion = pydantic.Field(
        default=None,
        description="Stochastic part",
    )
    s: CSpinmatrix = pydantic.Field(
        default=None,
        description="@1 spin matrix",
    )
    v: Sequence[CTaylor] = pydantic.Field(
        default=None,
        description="@1 orbital part of the map",
    )
    x0: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Lie map matrix  (Yu's square matrix)",
    )


class CDascratch(pydantic.BaseModel):
    """
    CDascratch corresponds to bmad `c_dascratch`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 398.

    Attributes
    ----------
    next : CDascratch
        Bmad type: c_dascratch
    previous : CDascratch
        Bmad type: c_dascratch
    t : CTaylor
        Bmad type: c_taylor
    """

    next: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    previous: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    t: CTaylor = pydantic.Field(
        default=None,
    )


class CFactoredLie(pydantic.BaseModel):
    """
    CFactoredLie corresponds to bmad `c_factored_lie`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 483.

    Attributes
    ----------
    dir : int
        Bmad type: integer
        Fortran default: 0
    f : CVectorField
        Bmad type: c_vector_field
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: 0
    """

    dir: int = pydantic.Field(
        default=0,
    )
    f: Sequence[CVectorField] = pydantic.Field(
        default=None,
    )
    n: int = pydantic.Field(
        default=0,
    )


class CNormalForm(pydantic.BaseModel):
    """
    CNormalForm corresponds to bmad `c_normal_form`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 490.

    Attributes
    ----------
    as_ : CDamap
        @1  For Spin   (m = As a n a^-1 As^-1)
        Bmad type: c_damap
    atot : CDamap
        @1  For Spin   (m = Atot n Atot^-1)
        Bmad type: c_damap
    h : CVectorField
        Bmad type: c_vector_field
    h_l : CVectorField
        Bmad type: c_vector_field
    h_nl : CVectorField
        !!Envelope radiation stuff to normalise radiation (Sand's like theory)
        Bmad type: c_vector_field
    m : int
        @1 stores resonances to be left in the map, including spin (ms)
        Bmad type: integer
    nres : int
        @1 stores resonances to be left in the map, including spin (ms)
        Bmad type: integer
    a1 : CDamap
        @1 brings to fix point at least linear
        Bmad type: c_damap
    a2 : CDamap
        @1 linear normal form
        Bmad type: c_damap
    a_t : CDamap
        @1 transformation a (m=a n a^-1)
        Bmad type: c_damap
    b_ijr : Complex
        @1   stochastic kick in resonance basis
        Bmad type: complex
    damping : float
        @1 Stores simple information
        Bmad type: real
    emittance : float
        @1  Equilibrium emittances as defined by Chao (computed from s_ijr(2*i-1,2*i)
        i=1,2,3 ) ! controls resonances left in normal form
        Bmad type: real
    g : CFactoredLie
        @1 nonlinear part of a in phasors
        Bmad type: c_factored_lie
    ker : CFactoredLie
        @1  kernel i.e. normal form in phasors
        Bmad type: c_factored_lie
    ms : int
        @1 stores resonances to be left in the map, including spin (ms) ! redundant
        stuff
        Bmad type: integer
    n : CDamap
        @1 transformation n (m=a n a^-1)
        Bmad type: c_damap
    positive : bool
        forces positive tunes (close to 1 if <0) !!  Things not to be used in the case
        of spin with quaternion
        Bmad type: logical
    quaternion_angle : float
        @1 Stores simple information
        Bmad type: real
    s_ij0 : Complex
        @1  equilibrium beam sizes
        Bmad type: complex
    s_ijr : Complex
        @1  equilibrium beam sizes in resonance basis
        Bmad type: complex
    spin_tune : float
        @1 Stores simple information
        Bmad type: real
    tune : float
        @1 Stores simple information
        Bmad type: real
    """

    as_: CDamap = pydantic.Field(
        default=None,
        description="@1  For Spin   (m = As a n a^-1 As^-1)",
        validation_alias=pydantic.AliasChoices("as_", "As"),
        serialization_alias="As",
    )
    atot: CDamap = pydantic.Field(
        default=None,
        description="@1  For Spin   (m = Atot n Atot^-1)",
        validation_alias=pydantic.AliasChoices("atot", "Atot"),
        serialization_alias="Atot",
    )
    h: CVectorField = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("h", "H"),
        serialization_alias="H",
    )
    h_l: CVectorField = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("h_l", "H_l"),
        serialization_alias="H_l",
    )
    h_nl: CVectorField = pydantic.Field(
        default=None,
        description="!!Envelope radiation stuff to normalise radiation (Sand's like theory)",
        validation_alias=pydantic.AliasChoices("h_nl", "H_nl"),
        serialization_alias="H_nl",
    )
    m: Sequence[int] = pydantic.Field(
        default=0,
        description="@1 stores resonances to be left in the map, including spin (ms)",
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    nres: int = pydantic.Field(
        default=0,
        description="@1 stores resonances to be left in the map, including spin (ms)",
        validation_alias=pydantic.AliasChoices("nres", "NRES"),
        serialization_alias="NRES",
    )
    a1: CDamap = pydantic.Field(
        default=None,
        description="@1 brings to fix point at least linear",
    )
    a2: CDamap = pydantic.Field(
        default=None,
        description="@1 linear normal form",
    )
    a_t: CDamap = pydantic.Field(
        default=None,
        description="@1 transformation a (m=a n a^-1)",
    )
    b_ijr: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1   stochastic kick in resonance basis",
    )
    damping: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )
    emittance: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description=(
            "@1  Equilibrium emittances as defined by Chao (computed from "
            "s_ijr(2*i-1,2*i) i=1,2,3 ) ! controls resonances left in normal form"
        ),
    )
    g: CFactoredLie = pydantic.Field(
        default=None,
        description="@1 nonlinear part of a in phasors",
    )
    ker: CFactoredLie = pydantic.Field(
        default=None,
        description="@1  kernel i.e. normal form in phasors",
    )
    ms: Sequence[int] = pydantic.Field(
        default=0,
        description=(
            "@1 stores resonances to be left in the map, including spin (ms) ! "
            "redundant stuff"
        ),
    )
    n: CDamap = pydantic.Field(
        default=None,
        description="@1 transformation n (m=a n a^-1)",
    )
    positive: bool = pydantic.Field(
        default=False,
        description=(
            "forces positive tunes (close to 1 if <0) !!  Things not to be used in the "
            "case of spin with quaternion"
        ),
    )
    quaternion_angle: float = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )
    s_ij0: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1  equilibrium beam sizes",
    )
    s_ijr: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1  equilibrium beam sizes in resonance basis",
    )
    spin_tune: float = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )
    tune: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )


class CQuaternion(pydantic.BaseModel):
    """
    CQuaternion corresponds to bmad `c_quaternion`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 429.

    Attributes
    ----------
    x : CTaylor
        Bmad type: c_taylor
    """

    x: Sequence[CTaylor] = pydantic.Field(
        default=None,
    )


class CRay(pydantic.BaseModel):
    """
    CRay corresponds to bmad `c_ray`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 520.

    Attributes
    ----------
    n : int
        # of dimensions used in x(lnv) Obsolescent
        Bmad type: integer
    q : ComplexQuaternion
        # quaternion
        Bmad type: complex_quaternion
    s1 : Complex
        # 3 spin directions
        Bmad type: complex
    s2 : Complex
        # 3 spin directions
        Bmad type: complex
    s3 : Complex
        # 3 spin directions
        Bmad type: complex
    x : Complex
        # orbital and/or magnet modulation clocks
        Bmad type: complex
    """

    n: int = pydantic.Field(
        default=0,
        description="# of dimensions used in x(lnv) Obsolescent",
    )
    q: ComplexQuaternion = pydantic.Field(
        default=None,
        description="# quaternion",
    )
    s1: Sequence[Complex] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="# 3 spin directions",
    )
    s2: Sequence[Complex] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="# 3 spin directions",
    )
    s3: Sequence[Complex] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="# 3 spin directions",
    )
    x: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="# orbital and/or magnet modulation clocks",
    )


class CSpinmatrix(pydantic.BaseModel):
    """
    CSpinmatrix corresponds to bmad `c_spinmatrix`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 415.

    Attributes
    ----------
    s : CTaylor
        Bmad type: c_taylor
    """

    s: Sequence[CTaylor] = pydantic.Field(
        default=None,
    )


class CSpinor(pydantic.BaseModel):
    """
    CSpinor corresponds to bmad `c_spinor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 419.

    Attributes
    ----------
    v : CTaylor
        Bmad type: c_taylor
    """

    v: Sequence[CTaylor] = pydantic.Field(
        default=None,
        max_length=3,
    )


class CVectorField(pydantic.BaseModel):
    """
    CVectorField corresponds to bmad `c_vector_field`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 461.

    Attributes
    ----------
    L : CSpinmatrix
        Bmad type: c_spinmatrix
    eps : float
        orbital part
        Bmad type: real
    n : int
        Bmad type: integer
        Fortran default: 0
    nrmax : int
        @1 if eps=-integer  then |eps| # of Lie brackets are taken @ otherwise
        eps=eps_tpsalie=10^-9
        Bmad type: integer
    q : CQuaternion
        type(c_spinor) h
        Bmad type: c_quaternion
    v : CTaylor
        quaternion part
        Bmad type: c_taylor
    """

    L: CSpinmatrix = pydantic.Field(
        default=None,
    )
    eps: float = pydantic.Field(
        default=0.0,
        description="orbital part",
    )
    n: int = pydantic.Field(
        default=0,
    )
    nrmax: int = pydantic.Field(
        default=0,
        description=(
            "@1 if eps=-integer  then |eps| # of Lie brackets are taken @ otherwise "
            "eps=eps_tpsalie=10^-9"
        ),
    )
    q: CQuaternion = pydantic.Field(
        default=None,
        description="type(c_spinor) h",
    )
    v: Sequence[CTaylor] = pydantic.Field(
        default=None,
        description="quaternion part",
    )


class CVectorFieldFourier(pydantic.BaseModel):
    """
    CVectorFieldFourier corresponds to bmad `c_vector_field_fourier`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 478.

    Attributes
    ----------
    f : CVectorField
        Bmad type: c_vector_field
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: 0
    """

    f: Sequence[CVectorField] = pydantic.Field(
        default=None,
    )
    n: int = pydantic.Field(
        default=0,
    )


class CYuW(pydantic.BaseModel):
    """
    CYuW corresponds to bmad `c_yu_w`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 424.

    Attributes
    ----------
    n : int
        @1 of non zero w
        Bmad type: integer
        Fortran default: 0
    w : CTaylor
        @1 orbital part of the map
        Bmad type: c_taylor
        Fortran default: null()
    """

    n: int = pydantic.Field(
        default=0,
        description="@1 of non zero w",
    )
    w: Sequence[CTaylor] = pydantic.Field(
        default=None,
        description="@1 orbital part of the map",
    )


class Complex8(pydantic.BaseModel):
    """
    Complex8 corresponds to bmad `complex_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 140.

    Attributes
    ----------
    alloc : bool
        Bmad type: logical
    i : int
        Bmad type: integer
    j : int
        Bmad type: integer
    kind : int
        Bmad type: integer
    r : Complex
        Bmad type: complex
    s : Complex
        integer g,nb  !  group index
        Bmad type: complex
    t : Complextaylor
        Bmad type: complextaylor
    """

    alloc: bool = pydantic.Field(
        default=False,
    )
    i: int = pydantic.Field(
        default=0,
    )
    j: int = pydantic.Field(
        default=0,
    )
    kind: int = pydantic.Field(
        default=0,
    )
    r: Complex = pydantic.Field(
        default=0.0,
    )
    s: Complex = pydantic.Field(
        default=0.0,
        description="integer g,nb  !  group index",
    )
    t: Complextaylor = pydantic.Field(
        default=None,
    )


class ComplexQuaternion(pydantic.BaseModel):
    """
    ComplexQuaternion corresponds to bmad `complex_quaternion`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 130.

    Attributes
    ----------
    x : Complex
        Bmad type: complex
    """

    x: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )


class Complextaylor(pydantic.BaseModel):
    """
    Complextaylor corresponds to bmad `complextaylor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 106.

    Attributes
    ----------
    i : Taylor
        @1 Imaginary part
        Bmad type: taylor
    r : Taylor
        @1 Real part
        Bmad type: taylor
    """

    i: Taylor = pydantic.Field(
        default=None,
        description="@1 Imaginary part",
    )
    r: Taylor = pydantic.Field(
        default=None,
        description="@1 Real part",
    )


class Dalevel(pydantic.BaseModel):
    """
    Dalevel corresponds to bmad `dalevel`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 177.

    Attributes
    ----------
    closed : bool
        Bmad type: logical
    end : Dascratch
        Bmad type: dascratch
    end_ground : Dascratch
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: dascratch
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER,  POINTER
    present : Dascratch
        Bmad type: dascratch
    start : Dascratch
        Bmad type: dascratch
    start_ground : Dascratch
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: dascratch
    """

    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    end: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    end_ground: Dascratch = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    present: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("present", "PRESENT"),
        serialization_alias="PRESENT",
    )
    start: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )
    start_ground: Dascratch = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("start_ground", "START_GROUND"),
        serialization_alias="START_GROUND",
    )


class Dascratch(pydantic.BaseModel):
    """
    Dascratch corresponds to bmad `dascratch`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 171.

    Attributes
    ----------
    next : Dascratch
        Bmad type: dascratch
    previous : Dascratch
        Bmad type: dascratch
    t : Taylor
        Bmad type: taylor
    """

    next: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    previous: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    t: Taylor = pydantic.Field(
        default=None,
    )


class FibreArray(pydantic.BaseModel):
    """
    FibreArray corresponds to bmad `fibre_array`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 529.

    Attributes
    ----------
    err : float
        Bmad type: real
        Fortran default: null()
    p : Fibre
        Bmad type: fibre
        Fortran default: null()
    pos : int
        Bmad type: integer, pointer
        Fortran default: null()
    s : float
        Bmad type: real
        Fortran default: null()
    t : IntegrationNode
        Bmad type: integration_node
        Fortran default: null()
    v : float
        Bmad type: real
        Fortran default: null()
    vmax : float
        Bmad type: real
        Fortran default: null();
    """

    err: float = pydantic.Field(
        default=0.0,
    )
    p: Fibre = pydantic.Field(
        default=None,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    s: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    t: IntegrationNode = pydantic.Field(
        default=None,
    )
    v: float = pydantic.Field(
        default=0.0,
    )
    vmax: float = pydantic.Field(
        default=0.0,
    )


class Genfield(pydantic.BaseModel):
    """
    Genfield corresponds to bmad `genfield`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 259.

    Attributes
    ----------
    constant : float
        Bmad type: real
    d : Taylor
        Bmad type: taylor
    eps : float
        Bmad type: real
    h : Taylor
        Bmad type: taylor
    ifac : int
        @1 ifac = the map is raised to the power 1/ifac and iterated ifac times
        (default=1)
        Bmad type: integer
    imax : int
        @1 imax=Maximum Number of Iteration (default=1000)
        Bmad type: integer
    linear : Damap
        Bmad type: damap
    linear_in : bool
        @1 Linear part is left in the map  (default=.false.)
        Bmad type: logical
    lineart : Damap
        Bmad type: damap
    m : Damap
        Bmad type: damap
    mt : Damap
        Bmad type: damap
    no_cut : int
        @1 Original map is not symplectic on and above no_cut
        Bmad type: integer
    """

    constant: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    d: Sequence[Taylor] = pydantic.Field(
        default=None,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    h: Taylor = pydantic.Field(
        default=None,
    )
    ifac: int = pydantic.Field(
        default=0,
        description=(
            "@1 ifac = the map is raised to the power 1/ifac and iterated ifac times "
            "(default=1)"
        ),
    )
    imax: int = pydantic.Field(
        default=0,
        description="@1 imax=Maximum Number of Iteration (default=1000)",
    )
    linear: Damap = pydantic.Field(
        default=None,
    )
    linear_in: bool = pydantic.Field(
        default=False,
        description="@1 Linear part is left in the map  (default=.false.)",
    )
    lineart: Damap = pydantic.Field(
        default=None,
    )
    m: Damap = pydantic.Field(
        default=None,
    )
    mt: Damap = pydantic.Field(
        default=None,
    )
    no_cut: int = pydantic.Field(
        default=0,
        description="@1 Original map is not symplectic on and above no_cut",
    )


class NodeArray(pydantic.BaseModel):
    """
    NodeArray corresponds to bmad `node_array`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 539.

    Attributes
    ----------
    err : float
        Bmad type: real
        Fortran default: null()
    f : CVectorField
        Bmad type: c_vector_field
        Fortran default: null()
    m : CDamap
        Bmad type: c_damap
        Fortran default: null()
    pos : int
        Bmad type: integer, pointer
        Fortran default: null()
    s : Complex
        Bmad type: complex
        Fortran default: null()
    t : IntegrationNode
        Bmad type: integration_node
        Fortran default: null()
    v : float
        Bmad type: real
        Fortran default: null()
    vmax : float
        Bmad type: real
        Fortran default: null();
    """

    err: float = pydantic.Field(
        default=0.0,
    )
    f: CVectorField = pydantic.Field(
        default=None,
    )
    m: CDamap = pydantic.Field(
        default=None,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    s: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    t: IntegrationNode = pydantic.Field(
        default=None,
    )
    v: float = pydantic.Field(
        default=0.0,
    )
    vmax: float = pydantic.Field(
        default=0.0,
    )


class Normalform(pydantic.BaseModel):
    """
    Normalform corresponds to bmad `normalform`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 247.

    Attributes
    ----------
    a : Reversedragtfinn
        @1 Linear A_t and nonlinear A_t
        Bmad type: reversedragtfinn
    a1 : Damap
        @1 Dispersion
        Bmad type: damap
    auto : bool
        Bmad type: logical
    a_t : Damap
        Total A  :  A_t= A1 o A_rest
        Bmad type: damap
    damping : float
        @1 linear tune and linear damping
        Bmad type: real
    dhdj : Damap
        @1 Contains the tunes in convenient form: extracted from NORMAL (=R)
        Bmad type: damap
    m : int
        @1 NRES,M(NDIM,NRESO) -> resonances left in the map
        Bmad type: integer
    normal : Dragtfinn
        @1 Normal is the Normal Form R
        Bmad type: dragtfinn
    nres : int
        @1 NRES,M(NDIM,NRESO) -> resonances left in the map
        Bmad type: integer
    plane : int
        @1 NRES,M(NDIM,NRESO) -> resonances left in the map
        Bmad type: integer
    tune : float
        @1 linear tune and linear damping
        Bmad type: real
    jtune : int
        @1 nord=1 A1 first order in parameters
        Bmad type: integer
    nord : int
        @1 nord=1 A1 first order in parameters
        Bmad type: integer
    """

    a: Reversedragtfinn = pydantic.Field(
        default=None,
        description="@1 Linear A_t and nonlinear A_t",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    a1: Damap = pydantic.Field(
        default=None,
        description="@1 Dispersion",
        validation_alias=pydantic.AliasChoices("a1", "A1"),
        serialization_alias="A1",
    )
    auto: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("auto", "AUTO"),
        serialization_alias="AUTO",
    )
    a_t: Damap = pydantic.Field(
        default=None,
        description="Total A  :  A_t= A1 o A_rest",
        validation_alias=pydantic.AliasChoices("a_t", "A_t"),
        serialization_alias="A_t",
    )
    damping: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 linear tune and linear damping",
        validation_alias=pydantic.AliasChoices("damping", "DAMPING"),
        serialization_alias="DAMPING",
    )
    dhdj: Damap = pydantic.Field(
        default=None,
        description="@1 Contains the tunes in convenient form: extracted from NORMAL (=R)",
        validation_alias=pydantic.AliasChoices("dhdj", "DHDJ"),
        serialization_alias="DHDJ",
    )
    m: Sequence[int] = pydantic.Field(
        default=0,
        description="@1 NRES,M(NDIM,NRESO) -> resonances left in the map",
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    normal: Dragtfinn = pydantic.Field(
        default=None,
        description="@1 Normal is the Normal Form R",
        validation_alias=pydantic.AliasChoices("normal", "NORMAL"),
        serialization_alias="NORMAL",
    )
    nres: int = pydantic.Field(
        default=0,
        description="@1 NRES,M(NDIM,NRESO) -> resonances left in the map",
        validation_alias=pydantic.AliasChoices("nres", "NRES"),
        serialization_alias="NRES",
    )
    plane: Sequence[int] = pydantic.Field(
        default=0,
        description="@1 NRES,M(NDIM,NRESO) -> resonances left in the map",
        validation_alias=pydantic.AliasChoices("plane", "PLANE"),
        serialization_alias="PLANE",
    )
    tune: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 linear tune and linear damping",
        validation_alias=pydantic.AliasChoices("tune", "TUNE"),
        serialization_alias="TUNE",
    )
    jtune: int = pydantic.Field(
        default=0,
        description="@1 nord=1 A1 first order in parameters",
    )
    nord: int = pydantic.Field(
        default=0,
        description="@1 nord=1 A1 first order in parameters",
    )


class Pbfield(pydantic.BaseModel):
    """
    Pbfield corresponds to bmad `pbfield`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 207.

    Attributes
    ----------
    h : Taylor
        Bmad type: taylor
    ifac : int
        Bmad type: integer
    nd_used : int
        Bmad type: integer
    """

    h: Taylor = pydantic.Field(
        default=None,
    )
    ifac: int = pydantic.Field(
        default=0,
    )
    nd_used: int = pydantic.Field(
        default=0,
    )


class Pbresonance(pydantic.BaseModel):
    """
    Pbresonance corresponds to bmad `pbresonance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 276.

    Attributes
    ----------
    cos : Pbfield
        Bmad type: pbfield
    ifac : int
        Bmad type: integer
    sin : Pbfield
        Bmad type: pbfield
    """

    cos: Pbfield = pydantic.Field(
        default=None,
    )
    ifac: int = pydantic.Field(
        default=0,
    )
    sin: Pbfield = pydantic.Field(
        default=None,
    )


class Probe_(pydantic.BaseModel):
    """
    Probe_ corresponds to bmad `probe`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 346.

    Attributes
    ----------
    ac : RfPhasor
        Bmad type: rf_phasor
    e : float
        Bmad type: real
    last_node : IntegrationNode
        Bmad type: integration_node
        Fortran default: null()
    nac : int
        Bmad type: integer
        Fortran default: 0
    q : Quaternion
        Bmad type: quaternion
    s : Spinor
        Bmad type: spinor
    u : bool
        Bmad type: logical
    use_q : bool
        Bmad type: logical
    x : float
        Bmad type: real
    """

    ac: Sequence[RfPhasor] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ac", "AC"),
        serialization_alias="AC",
    )
    e: float = pydantic.Field(
        default=0.0,
    )
    last_node: IntegrationNode = pydantic.Field(
        default=None,
    )
    nac: int = pydantic.Field(
        default=0,
    )
    q: Quaternion = pydantic.Field(
        default=None,
    )
    s: Sequence[Spinor] = pydantic.Field(
        default=None,
        max_length=3,
    )
    u: bool = pydantic.Field(
        default=False,
    )
    use_q: bool = pydantic.Field(
        default=False,
    )
    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )


class Probe8(pydantic.BaseModel):
    """
    Probe8 corresponds to bmad `probe_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 357.

    Attributes
    ----------
    e_ij : float
        Envelope for stochastic radiation
        Bmad type: real
    ac : RfPhasor8
        Modulation of magnet
        Bmad type: rf_phasor_8
    e : float
        real(dp) damps(3,3) real(dp) b_kin(3,3) real(dp) D_spin(3)
        Bmad type: real
    last_node : IntegrationNode
        Bmad type: integration_node
        Fortran default: null()
    nac : int
        number of modulated clocks <=nacmax
        Bmad type: integer
        Fortran default: 0
    q : Quaternion8
        Bmad type: quaternion_8
    s : Spinor8
        Polymorphic spin s(1:3)
        Bmad type: spinor_8
    u : bool
        Bmad type: logical
    use_q : bool
        Bmad type: logical
    x : Real8
        Polymorphic orbital ray
        Bmad type: real_8
    x0 : float
        initial value of the ray for TPSA calculations with c_damap stuff for exception
        Bmad type: real
    """

    e_ij: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Envelope for stochastic radiation",
        validation_alias=pydantic.AliasChoices("e_ij", "E_ij"),
        serialization_alias="E_ij",
    )
    ac: Sequence[RfPhasor8] = pydantic.Field(
        default=None,
        description="Modulation of magnet",
    )
    e: float = pydantic.Field(
        default=0.0,
        description="real(dp) damps(3,3) real(dp) b_kin(3,3) real(dp) D_spin(3)",
    )
    last_node: IntegrationNode = pydantic.Field(
        default=None,
    )
    nac: int = pydantic.Field(
        default=0,
        description="number of modulated clocks <=nacmax",
    )
    q: Quaternion8 = pydantic.Field(
        default=None,
    )
    s: Sequence[Spinor8] = pydantic.Field(
        default=None,
        max_length=3,
        description="Polymorphic spin s(1:3)",
    )
    u: bool = pydantic.Field(
        default=False,
    )
    use_q: bool = pydantic.Field(
        default=False,
    )
    x: Sequence[Real8] = pydantic.Field(
        default=None,
        max_length=6,
        description="Polymorphic orbital ray",
    )
    x0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="initial value of the ray for TPSA calculations with c_damap stuff for exception",
    )


class Quaternion_(pydantic.BaseModel):
    """
    Quaternion_ corresponds to bmad `quaternion`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 126.

    Attributes
    ----------
    x : float
        Bmad type: real
    """

    x: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Quaternion8(pydantic.BaseModel):
    """
    Quaternion8 corresponds to bmad `quaternion_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 134.

    Attributes
    ----------
    x : Real8
        Bmad type: real_8
    """

    x: Sequence[Real8] = pydantic.Field(
        default=None,
    )


class Reversedragtfinn(pydantic.BaseModel):
    """
    Reversedragtfinn corresponds to bmad `reversedragtfinn`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 233.

    Attributes
    ----------
    constant : float
        Bmad type: real
    linear : Damap
        Bmad type: damap
    nonlinear : Vecfield
        Bmad type: vecfield
    pb : Pbfield
        Bmad type: pbfield
    """

    constant: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("constant", "CONSTANT"),
        serialization_alias="CONSTANT",
    )
    linear: Damap = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("linear", "Linear"),
        serialization_alias="Linear",
    )
    nonlinear: Vecfield = pydantic.Field(
        default=None,
    )
    pb: Pbfield = pydantic.Field(
        default=None,
    )


class RfPhasor(pydantic.BaseModel):
    """
    RfPhasor corresponds to bmad `rf_phasor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 332.

    Attributes
    ----------
    om : float
        real(dp) f(nacmode),phase(nacmode)
        Bmad type: real
    t : float
        Bmad type: real
    x : float
        Bmad type: real
    """

    om: float = pydantic.Field(
        default=0.0,
        description="real(dp) f(nacmode),phase(nacmode)",
    )
    t: float = pydantic.Field(
        default=0.0,
    )
    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
    )


class RfPhasor8(pydantic.BaseModel):
    """
    RfPhasor8 corresponds to bmad `rf_phasor_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 339.

    Attributes
    ----------
    om : Real8
        the omega of the modulation real(dp) f(nacmode),phase(nacmode)
        Bmad type: real_8
    t : float
        the pseudo-time
        Bmad type: real
    x : Real8
        The two hands of the clock
        Bmad type: real_8
    """

    om: Real8 = pydantic.Field(
        default=None,
        description="the omega of the modulation real(dp) f(nacmode),phase(nacmode)",
    )
    t: float = pydantic.Field(
        default=0.0,
        description="the pseudo-time",
    )
    x: Sequence[Real8] = pydantic.Field(
        default=None,
        max_length=2,
        description="The two hands of the clock",
    )


class Spinor_(pydantic.BaseModel):
    """
    Spinor_ corresponds to bmad `spinor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 161.

    Attributes
    ----------
    x : float
        x(3) = (s_x, s_y, s_z)   with  |s|=1
        Bmad type: real
    """

    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="x(3) = (s_x, s_y, s_z)   with  |s|=1",
    )


class Spinor8(pydantic.BaseModel):
    """
    Spinor8 corresponds to bmad `spinor_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 165.

    Attributes
    ----------
    x : Real8
        x(3) = (s_x, s_y, s_z)   with  |s|=1
        Bmad type: real_8
    """

    x: Sequence[Real8] = pydantic.Field(
        default=None,
        max_length=3,
        description="x(3) = (s_x, s_y, s_z)   with  |s|=1",
    )


class SubTaylor(pydantic.BaseModel):
    """
    SubTaylor corresponds to bmad `sub_taylor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 78.

    Attributes
    ----------
    j : int
        Bmad type: INTEGER
    max : int
        Bmad type: INTEGER
    min : int
        Bmad type: INTEGER
    """

    j: Sequence[int] = pydantic.Field(
        default=0,
    )
    max: int = pydantic.Field(
        default=0,
    )
    min: int = pydantic.Field(
        default=0,
    )


class Taylor(pydantic.BaseModel):
    """
    Taylor corresponds to bmad `taylor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 84.

    Attributes
    ----------
    i : int
        @1  integer I is a pointer in old da-package of Berz GTPSA REMOVED !
        type (c_ptr) j !@1  gtpsa
        Bmad type: INTEGER
    """

    i: int = pydantic.Field(
        default=0,
        description=(
            "@1  integer I is a pointer in old da-package of Berz GTPSA REMOVED ! "
            "type (c_ptr) j !@1  gtpsa"
        ),
        validation_alias=pydantic.AliasChoices("i", "I"),
        serialization_alias="I",
    )


class Taylorresonance(pydantic.BaseModel):
    """
    Taylorresonance corresponds to bmad `taylorresonance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 286.

    Attributes
    ----------
    cos : Taylor
        Bmad type: taylor
    sin : Taylor
        Bmad type: taylor
    """

    cos: Taylor = pydantic.Field(
        default=None,
    )
    sin: Taylor = pydantic.Field(
        default=None,
    )


class Tree(pydantic.BaseModel):
    """
    Tree corresponds to bmad `tree`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 215.

    Attributes
    ----------
    branch : Taylor
        Bmad type: taylor
    """

    branch: Sequence[Taylor] = pydantic.Field(
        default=None,
    )


class TreeElement_(pydantic.BaseModel):
    """
    TreeElement_ corresponds to bmad `tree_element`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 304.

    Attributes
    ----------
    cc : float
        Bmad type: real
    jl : int
        Bmad type: integer,  DIMENSION
    jv : int
        Bmad type: integer,  DIMENSION
    n : int
        Bmad type: INTEGER,POINTER
    np : int
        Bmad type: INTEGER,POINTER
    beta0 : float
        Bmad type: real
    ds : float
        Bmad type: real
    e_ij : float
        Bmad type: real
    eps : float
        Bmad type: real
    factored : bool
        Bmad type: logical, pointer
    fix : float
        Bmad type: real
    fix0 : float
        Bmad type: real
    fixr : float
        Bmad type: real
    no : int
        Bmad type: INTEGER,POINTER
    rad : float
        Bmad type: real
    symptrack : bool
        Bmad type: logical, pointer
    usenonsymp : bool
        Bmad type: logical, pointer
    """

    cc: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("cc", "CC"),
        serialization_alias="CC",
    )
    jl: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("jl", "JL"),
        serialization_alias="JL",
    )
    jv: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("jv", "JV"),
        serialization_alias="JV",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    np: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("np", "NP"),
        serialization_alias="NP",
    )
    beta0: float = pydantic.Field(
        default=0.0,
    )
    ds: float = pydantic.Field(
        default=0.0,
    )
    e_ij: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    factored: bool = pydantic.Field(
        default=False,
    )
    fix: float = pydantic.Field(
        default=0.0,
    )
    fix0: float = pydantic.Field(
        default=0.0,
    )
    fixr: float = pydantic.Field(
        default=0.0,
    )
    no: int = pydantic.Field(
        default=0,
    )
    rad: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    symptrack: bool = pydantic.Field(
        default=False,
    )
    usenonsymp: bool = pydantic.Field(
        default=False,
    )


class Vecfield(pydantic.BaseModel):
    """
    Vecfield corresponds to bmad `vecfield`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 201.

    Attributes
    ----------
    ifac : int
        @1 Type of Factorization 0,1,-1 (One exponent, Dragt-Finn, Reversed Dragt-Finn)
        Bmad type: integer
    v : Taylor
        @1 <font face="Times New Roman">V<sub>i</sub>&#8706;<sub>i</sub></font>
        Operator
        Bmad type: taylor
    """

    ifac: int = pydantic.Field(
        default=0,
        description="@1 Type of Factorization 0,1,-1 (One exponent, Dragt-Finn, Reversed Dragt-Finn)",
    )
    v: Sequence[Taylor] = pydantic.Field(
        default=None,
        description="@1 <font face='Times New Roman'>V<sub>i</sub>&#8706;<sub>i</sub></font> Operator",
    )


class Vecresonance(pydantic.BaseModel):
    """
    Vecresonance corresponds to bmad `vecresonance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 281.

    Attributes
    ----------
    cos : Vecfield
        Bmad type: vecfield
    ifac : int
        Bmad type: integer
    sin : Vecfield
        Bmad type: vecfield
    """

    cos: Vecfield = pydantic.Field(
        default=None,
    )
    ifac: int = pydantic.Field(
        default=0,
    )
    sin: Vecfield = pydantic.Field(
        default=None,
    )
