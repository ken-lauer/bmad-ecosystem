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
        Bmad type: integer
    j : int
        ,ie,je
        Bmad type: integer
    n_mono : int
        ,nmul_e,n_mono_e
        Bmad type: integer
    nmul : int
        ,nmul_e,n_mono_e
        Bmad type: integer
    va : float
        Bmad type: real
    vb : float
        Bmad type: real
    """

    a_x: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a_y: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_x: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_y: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    firsttime: int = pydantic.Field(
        default=0,
    )
    i: Sequence[int] = pydantic.Field(
        default=0,
        description=",ie,je",
    )
    j: Sequence[int] = pydantic.Field(
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
    va: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    vb: Sequence[float] = pydantic.Field(
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
    aperture_polygx: Sequence[float] = pydantic.Field(
        default=0.0,
        description="length defined with APERTURE_POLYGN",
        validation_alias=pydantic.AliasChoices("aperture_polygx", "APERTURE_POLYGX"),
        serialization_alias="APERTURE_POLYGX",
    )
    aperture_polygy: Sequence[float] = pydantic.Field(
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


class Chartlist(pydantic.BaseModel):
    """
    Chartlist corresponds to bmad `CHARTlist`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 19.

    Attributes
    ----------
    ang_in : float
        Bmad type: real
    ang_out : float
        Bmad type: real
    d_in : float
        Bmad type: real
    d_out : float
        Bmad type: real
    """

    ang_in: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("ang_in", "ANG_IN"),
        serialization_alias="ANG_IN",
    )
    ang_out: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("ang_out", "ANG_OUT"),
        serialization_alias="ANG_OUT",
    )
    d_in: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("d_in", "D_IN"),
        serialization_alias="D_IN",
    )
    d_out: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("d_out", "D_OUT"),
        serialization_alias="D_OUT",
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


class MagnetChartlist(pydantic.BaseModel):
    """
    MagnetChartlist corresponds to bmad `MAGNET_CHARTLIST`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 25.

    Attributes
    ----------
    kin_kex_bendfringe_exact : bool
        KILL_ENT_FRINGE, KILL_EXI_FRINGE, bend_fringe,EXACT
        Bmad type: LOGICAL
    lc_ld_b0_p0 : float
        LC LD B0 P0C
        Bmad type: real
    method_nst_nmul_permfringe_highest : int
        METHOD,NST,NMUL,permfringr, highest_fringe
        Bmad type: INTEGER
    tiltd_edge : float
        TILTD EDGE
        Bmad type: real
    kill_spin : bool
        Bmad type: LOGICAL
    """

    kin_kex_bendfringe_exact: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=4,
        description="KILL_ENT_FRINGE, KILL_EXI_FRINGE, bend_fringe,EXACT",
        validation_alias=pydantic.AliasChoices(
            "kin_kex_bendfringe_exact", "KIN_KEX_BENDFRINGE_EXACT"
        ),
        serialization_alias="KIN_KEX_BENDFRINGE_EXACT",
    )
    lc_ld_b0_p0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
        description="LC LD B0 P0C",
        validation_alias=pydantic.AliasChoices("lc_ld_b0_p0", "LC_LD_B0_P0"),
        serialization_alias="LC_LD_B0_P0",
    )
    method_nst_nmul_permfringe_highest: Sequence[int] = pydantic.Field(
        default=0,
        max_length=5,
        description="METHOD,NST,NMUL,permfringr, highest_fringe",
        validation_alias=pydantic.AliasChoices(
            "method_nst_nmul_permfringe_highest", "METHOD_NST_NMUL_permfringe_highest"
        ),
        serialization_alias="METHOD_NST_NMUL_permfringe_highest",
    )
    tiltd_edge: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="TILTD EDGE",
        validation_alias=pydantic.AliasChoices("tiltd_edge", "TILTD_EDGE"),
        serialization_alias="TILTD_EDGE",
    )
    kill_spin: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=2,
    )


class AbList(pydantic.BaseModel):
    """
    AbList corresponds to bmad `ab_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 101.

    Attributes
    ----------
    e : Complex
        Bmad type: complex
    b : Complex
        Bmad type: complex
    dz_t_te : float
        Bmad type: real
    n_m : int
        Bmad type: integer
    scale_angc_xc_vc_dc_hc : float
        Bmad type: real
    """

    e: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    b: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    dz_t_te: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n_m: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
    )
    scale_angc_xc_vc_dc_hc: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )


class ApList(pydantic.BaseModel):
    """
    ApList corresponds to bmad `ap_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 117.

    Attributes
    ----------
    kind : int
        Bmad type: integer
    dx : float
        Bmad type: real
    dy : float
        Bmad type: real
    on : bool
        Bmad type: logical
    r : float
        Bmad type: real
    x : float
        Bmad type: real
    y : float
        Bmad type: real
    """

    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    dx: float = pydantic.Field(
        default=0.0,
    )
    dy: float = pydantic.Field(
        default=0.0,
    )
    on: bool = pydantic.Field(
        default=False,
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
    )
    x: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )


class CavList(pydantic.BaseModel):
    """
    CavList corresponds to bmad `cav_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 59.

    Attributes
    ----------
    a : float
        Bmad type: real
    cavity_totalpath : int
        Bmad type: integer
    f : float
        Bmad type: real
    nf : int
        Bmad type: integer
    n_bessel : int
        Bmad type: integer
    ph : float
        Bmad type: real
    r : float
        Bmad type: real
    always_on : bool
        Bmad type: logical
    phase0 : float
        Bmad type: real
    t : float
        Bmad type: real
    xprime : bool
        Bmad type: logical
    """

    a: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    nf: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nf", "NF"),
        serialization_alias="NF",
    )
    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    ph: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ph", "PH"),
        serialization_alias="PH",
    )
    r: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )
    t: float = pydantic.Field(
        default=0.0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class EleList(pydantic.BaseModel):
    """
    EleList corresponds to bmad `ele_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 37.

    Attributes
    ----------
    b_sol : float
        Bmad type: real
    kind : int
        Bmad type: INTEGER
    L : float
        Bmad type: real
    thin : bool
        Bmad type: LOGICAL
    volt_freq_phas : float
        alg not used
        Bmad type: real
    an : float
        Bmad type: real
    bn : float
        Bmad type: real
    fileb : str
        Bmad type: character
    filef : str
        Bmad type: character
    fint_hgap_h1_h2_va_vs : float
        Bmad type: real
    name_vorname : str
        Bmad type: character
    recut_even_electric_mis : bool
        Bmad type: logical
    skipptcbf : int
        Bmad type: integer
    slow_ac : int
        Bmad type: integer
    usebf_do1bf : bool
        Bmad type: logical
    """

    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    volt_freq_phas: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="alg not used",
        validation_alias=pydantic.AliasChoices("volt_freq_phas", "VOLT_FREQ_PHAS"),
        serialization_alias="VOLT_FREQ_PHAS",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fileb: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    filef: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    fint_hgap_h1_h2_va_vs: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=8,
    )
    name_vorname: Sequence[str] = pydantic.Field(
        default="",
        max_length=2,
    )
    recut_even_electric_mis: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=4,
        validation_alias=pydantic.AliasChoices(
            "recut_even_electric_mis", "recut_even_electric_MIS"
        ),
        serialization_alias="recut_even_electric_MIS",
    )
    skipptcbf: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
    )
    slow_ac: int = pydantic.Field(
        default_factory=list,
        max_length=2,
    )
    usebf_do1bf: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=4,
    )


class Fibrelist(pydantic.BaseModel):
    """
    Fibrelist corresponds to bmad `fibrelist`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 1.

    Attributes
    ----------
    charge : float
        Bmad type: real
    dir : int
        DIR,CHARGE
        Bmad type: integer
    gamma0i_gambet_mass_ag : float
        GAMMA0I,GAMBET,MASS ,AG  BETA0 is computed
        Bmad type: real
    patch : int
        Bmad type: integer
    """

    charge: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("charge", "CHARGE"),
        serialization_alias="CHARGE",
    )
    dir: int = pydantic.Field(
        default=0,
        description="DIR,CHARGE",
        validation_alias=pydantic.AliasChoices("dir", "DIR"),
        serialization_alias="DIR",
    )
    gamma0i_gambet_mass_ag: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
        description="GAMMA0I,GAMBET,MASS ,AG  BETA0 is computed",
        validation_alias=pydantic.AliasChoices(
            "gamma0i_gambet_mass_ag", "GAMMA0I_GAMBET_MASS_AG"
        ),
        serialization_alias="GAMMA0I_GAMBET_MASS_AG",
    )
    patch: int = pydantic.Field(
        default=0,
    )


class HelList(pydantic.BaseModel):
    """
    HelList corresponds to bmad `hel_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 71.

    Attributes
    ----------
    n_bessel : int
        Bmad type: integer
    fake_shift : float
        Bmad type: real
    """

    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    fake_shift: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )


class K16List(pydantic.BaseModel):
    """
    K16List corresponds to bmad `k16_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 111.

    Attributes
    ----------
    driftkick : bool
        Bmad type: logical
    likemad : bool
        Bmad type: logical
    """

    driftkick: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    likemad: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("likemad", "LIKEMAD"),
        serialization_alias="LIKEMAD",
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


class Patchlist(pydantic.BaseModel):
    """
    Patchlist corresponds to bmad `patchlist`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 10.

    Attributes
    ----------
    a_ang : float
        Bmad type: real
    a_d : float
        Bmad type: real
    a_l : float
        Bmad type: real
    a_t : float
        Bmad type: real
    a_x1 : int
        Bmad type: integer
    a_x2 : int
        Bmad type: integer
    b_ang : float
        Bmad type: real
    b_d : float
        Bmad type: real
    b_l : float
        Bmad type: real
    b_t : float
        Bmad type: real
    b_x1 : int
        Bmad type: integer
    b_x2 : int
        Bmad type: integer
    energy : int
        Bmad type: INTEGER
    geometry : int
        Bmad type: INTEGER
    time : int
        Bmad type: INTEGER
    track : bool
        Bmad type: logical
    """

    a_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("a_ang", "A_ANG"),
        serialization_alias="A_ANG",
    )
    a_d: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("a_d", "A_D"),
        serialization_alias="A_D",
    )
    a_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a_l", "A_L"),
        serialization_alias="A_L",
    )
    a_t: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a_t", "A_T"),
        serialization_alias="A_T",
    )
    a_x1: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("a_x1", "A_X1"),
        serialization_alias="A_X1",
    )
    a_x2: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("a_x2", "A_X2"),
        serialization_alias="A_X2",
    )
    b_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("b_ang", "B_ANG"),
        serialization_alias="B_ANG",
    )
    b_d: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("b_d", "B_D"),
        serialization_alias="B_D",
    )
    b_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_l", "B_L"),
        serialization_alias="B_L",
    )
    b_t: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_t", "B_T"),
        serialization_alias="B_T",
    )
    b_x1: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("b_x1", "B_X1"),
        serialization_alias="B_X1",
    )
    b_x2: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("b_x2", "B_X2"),
        serialization_alias="B_X2",
    )
    energy: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        validation_alias=pydantic.AliasChoices("energy", "ENERGY"),
        serialization_alias="ENERGY",
    )
    geometry: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        validation_alias=pydantic.AliasChoices("geometry", "GEOMETRY"),
        serialization_alias="GEOMETRY",
    )
    time: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        validation_alias=pydantic.AliasChoices("time", "TIME"),
        serialization_alias="TIME",
    )
    track: bool = pydantic.Field(
        default=False,
    )


class SiamList(pydantic.BaseModel):
    """
    SiamList corresponds to bmad `siam_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 134.

    Attributes
    ----------
    angle : float
        Bmad type: real
    d : float
        Bmad type: real
    """

    angle: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )


class Sol5List(pydantic.BaseModel):
    """
    Sol5List corresponds to bmad `sol5_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 87.

    Attributes
    ----------
    dx_dy_pitchx_pitchy : float
        Bmad type: real
    """

    dx_dy_pitchx_pitchy: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
    )


class TcavList(pydantic.BaseModel):
    """
    TcavList corresponds to bmad `tcav_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 126.

    Attributes
    ----------
    psi_dphas_dvds_phase0 : float
        Bmad type: real
    always_on : bool
        Bmad type: logical
    implicit : bool
        Bmad type: logical
    """

    psi_dphas_dvds_phase0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
        validation_alias=pydantic.AliasChoices(
            "psi_dphas_dvds_phase0", "PSI_DPHAS_DVDS_phase0"
        ),
        serialization_alias="PSI_DPHAS_DVDS_phase0",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    implicit: bool = pydantic.Field(
        default=False,
    )


class Thin3List(pydantic.BaseModel):
    """
    Thin3List corresponds to bmad `thin3_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 78.

    Attributes
    ----------
    dx_dy_pitchx_pitchy : float
        Bmad type: real
    hf : float
        Bmad type: real
    ls : float
        Bmad type: real
    patch : bool
        Bmad type: logical
    thin_h_angle : float
        Bmad type: real
    thin_h_foc : float
        Bmad type: real
    thin_v_angle : float
        Bmad type: real
    thin_v_foc : float
        Bmad type: real
    vf : float
        Bmad type: real
    """

    dx_dy_pitchx_pitchy: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
    )
    hf: float = pydantic.Field(
        default=0.0,
    )
    ls: float = pydantic.Field(
        default=0.0,
    )
    patch: bool = pydantic.Field(
        default=False,
    )
    thin_h_angle: float = pydantic.Field(
        default=0.0,
    )
    thin_h_foc: float = pydantic.Field(
        default=0.0,
    )
    thin_v_angle: float = pydantic.Field(
        default=0.0,
    )
    thin_v_foc: float = pydantic.Field(
        default=0.0,
    )
    vf: float = pydantic.Field(
        default=0.0,
    )


class Tp10List(pydantic.BaseModel):
    """
    Tp10List corresponds to bmad `tp10_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 93.

    Attributes
    ----------
    driftkick : bool
        Bmad type: logical
    ae : float
        Bmad type: real
    be : float
        Bmad type: real
    """

    driftkick: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    ae: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    be: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class TrackList(pydantic.BaseModel):
    """
    TrackList corresponds to bmad `track_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 141.

    Attributes
    ----------
    direction : int
        Bmad type: integer
    name : str
        Bmad type: character
    range : int
        Bmad type: integer
    """

    direction: int = pydantic.Field(
        default=0,
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    range: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
    )


class WigList(pydantic.BaseModel):
    """
    WigList corresponds to bmad `wig_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 150.

    Attributes
    ----------
    a : float
        Bmad type: real
    ae : float
        Bmad type: real
    ex : float
        Bmad type: real
    ey : float
        Bmad type: real
    f : float
        Bmad type: real
    fe : float
        Bmad type: real
    form : int
        Bmad type: integer
    forme : int
        Bmad type: integer
    internal : float
        Bmad type: real
    k : float
        Bmad type: real
    ke : float
        Bmad type: real
    n : int
        Bmad type: integer
    ne : int
        Bmad type: integer
    offset : float
        Bmad type: real
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ae: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ex: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ey: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fe: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    form: Sequence[int] = pydantic.Field(
        default=0,
    )
    forme: Sequence[int] = pydantic.Field(
        default=0,
    )
    internal: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )
    k: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ke: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
    )
    ne: int = pydantic.Field(
        default=0,
    )
    offset: float = pydantic.Field(
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
        Bmad type: integer
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
        Bmad type: integer
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
        Bmad type: logical
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
        Bmad type: integer
    jv : int
        Bmad type: integer
    n : int
        Bmad type: INTEGER
    np : int
        Bmad type: INTEGER
    beta0 : float
        Bmad type: real
    ds : float
        Bmad type: real
    e_ij : float
        Bmad type: real
    eps : float
        Bmad type: real
    factored : bool
        Bmad type: logical
    fix : float
        Bmad type: real
    fix0 : float
        Bmad type: real
    fixr : float
        Bmad type: real
    no : int
        Bmad type: INTEGER
    rad : float
        Bmad type: real
    symptrack : bool
        Bmad type: logical
    usenonsymp : bool
        Bmad type: logical
    """

    cc: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("cc", "CC"),
        serialization_alias="CC",
    )
    jl: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("jl", "JL"),
        serialization_alias="JL",
    )
    jv: Sequence[int] = pydantic.Field(
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
    fix: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fixr: Sequence[float] = pydantic.Field(
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
        =.TRUE. patching done correctly
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
        Bmad type: integer
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
        Bmad type: integer
        Fortran default: null()
    fibre_flip : bool
        =.true.
        Bmad type: logical
        Fortran default: null()
    highest_fringe : int
        =2  quadrupole fringe ON IF FRINGE PRESENT
        Bmad type: integer
        Fortran default: null()
    initial_charge : float
        =1 or -1 AND  ADJUST THE MASS IS THE PREFERED MODE
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
        Bmad type: integer
        Fortran default: null()
    madthin_normal : int
        Bmad type: integer
        Fortran default: null()
    madthin_skew : int
        Bmad type: integer
        Fortran default: null()
    metd : int
        number of steps and integration method
        Bmad type: integer
        Fortran default: null()
    npara : int
        PARAMETER LOCATION IN PTC in fpp
        Bmad type: integer
        Fortran default: null()
    nstd : int
        number of steps and integration method
        Bmad type: integer
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
        Bmad type: integer
        Fortran default: null()
    sector_nmul_max : int
        = 10 maxwell equations is solved to order 10 in exact sectors
        Bmad type: integer
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
        obvious meaning: false normally
        Bmad type: logical
        Fortran default: null()
    electron : bool
        electron if true otherwise proton
        Bmad type: logical
        Fortran default: null()
    eps_pos : float
        Bmad type: real
        Fortran default: null()
    global_verbose : bool
        Bmad type: logical
        Fortran default: null()
    hyperbolic_aperture : float
        controls crashes in exponentials
        Bmad type: real
        Fortran default: null()
    knob : bool
        Bmad type: logical
        Fortran default: null()
    lda_used : int
        maximum number of da variables in Berz's
        Bmad type: integer
        Fortran default: null()
    massfactor : float
        =one  sets variable muon and electron must be true
        Bmad type: real
        Fortran default: null()
    nd : int
        degrees of freedom
        Bmad type: integer
        Fortran default: null()
    nd2 : int
        phase space dimension
        Bmad type: integer
        Fortran default: null()
    nd2harm : int
        harmonic plane
        Bmad type: integer
        Fortran default: null()
    nd2t : int
        harmonic planes minus clocks
        Bmad type: integer
        Fortran default: null()
    ndc2t : int
        0 or 2 : jordan planes
        Bmad type: integer
        Fortran default: null()
    ndpt : int
        constant energy variable position is different from zero
        Bmad type: integer
        Fortran default: null()
    ndpt_bmad : int
        Bmad type: integer
        Fortran default: null()
    ndptb : int
        Bmad type: integer
        Fortran default: null()
    no : int
        order of da
        Bmad type: integer
        Fortran default: null()
    no_hyperbolic_in_normal_form : bool
        unstable produces exception
        Bmad type: logical
        Fortran default: null()
    np : int
        number of parameters in fpp
        Bmad type: integer
        Fortran default: null()
    np_pol : int
        parameters produced through pol_block
        Bmad type: integer
        Fortran default: null()
    npara_fpp : int
        PARAMETER LOCATION IN FPP or PTC
        Bmad type: integer
        Fortran default: null()
    nspin : int
        number of spin variables (0 or 3)
        Bmad type: integer
        Fortran default: null()
    nv : int
        number of variables
        Bmad type: integer
        Fortran default: null()
    phase0 : float
        default phase in cavity
        Bmad type: real
        Fortran default: null()
    pos_of_delta : int
        constant delta
        Bmad type: integer
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
        Bmad type: integer
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
        Bmad type: logical
        Fortran default: null()
    wedge_coeff : float
        QUAD_KICK IN WEDGE
        Bmad type: real
        Fortran default: null()
    wherelost : int
        counting lost particles in integration nodes
        Bmad type: integer
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
        description="=.TRUE. patching done correctly",
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
        description="=.true.",
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
        description="=1 or -1 AND  ADJUST THE MASS IS THE PREFERED MODE",
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
        description="obvious meaning: false normally",
    )
    electron: bool = pydantic.Field(
        default=False,
        description="electron if true otherwise proton",
    )
    eps_pos: float = pydantic.Field(
        default=0.0,
    )
    global_verbose: bool = pydantic.Field(
        default=False,
    )
    hyperbolic_aperture: float = pydantic.Field(
        default=0.0,
        description="controls crashes in exponentials",
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
        description="=one  sets variable muon and electron must be true",
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
        description="number of spin variables (0 or 3)",
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
        Bmad type: logical
    """

    mf: bool = pydantic.Field(
        default=False,
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
        Bmad type: logical
    """

    mf: bool = pydantic.Field(
        default=False,
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


class Abell(pydantic.BaseModel):
    """
    Abell corresponds to bmad `ABELL`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 88.

    Attributes
    ----------
    an : float
        MULTIPLICATIVE FACTOR USUALLY 1
        Bmad type: real
        Fortran default: null()
    b : Complex
        Bmad type: complex
        Fortran default: null()
    bn : float
        MULTIPLICATIVE FACTOR USUALLY 1
        Bmad type: real
        Fortran default: null()
    dz : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    e : Complex
        Bmad type: complex
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    m : int
        Bmad type: INTEGER
        Fortran default: null()
    n : int
        Bmad type: INTEGER
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    scale : float
        Bmad type: REAL
        Fortran default: null()
    t : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    te : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    angc : float
        Bmad type: REAL
        Fortran default: null()
    dc : float
        Bmad type: REAL
        Fortran default: null()
    hc : float
        Bmad type: REAL
        Fortran default: null()
    vc : float
        Bmad type: REAL
        Fortran default: null()
    xc : float
        Bmad type: REAL
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="MULTIPLICATIVE FACTOR USUALLY 1",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    b: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="MULTIPLICATIVE FACTOR USUALLY 1",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    dz: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", phi0(:) => null()",
        validation_alias=pydantic.AliasChoices("dz", "DZ"),
        serialization_alias="DZ",
    )
    e: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    m: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    scale: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("scale", "SCALE"),
        serialization_alias="SCALE",
    )
    t: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", phi0(:) => null()",
        validation_alias=pydantic.AliasChoices("t", "T"),
        serialization_alias="T",
    )
    te: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", phi0(:) => null()",
        validation_alias=pydantic.AliasChoices("te", "TE"),
        serialization_alias="TE",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    angc: float = pydantic.Field(
        default=0.0,
    )
    dc: float = pydantic.Field(
        default=0.0,
    )
    hc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
        default=0.0,
    )
    xc: float = pydantic.Field(
        default=0.0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class Abellp(pydantic.BaseModel):
    """
    Abellp corresponds to bmad `ABELLP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 100.

    Attributes
    ----------
    an : Real8
        Bmad type: REAL_8
        Fortran default: null()
    b : Complex
        Bmad type: complex
        Fortran default: null()
    bn : Real8
        Bmad type: REAL_8
        Fortran default: null()
    dz : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    e : Complex
        Bmad type: complex
        Fortran default: null()
    L : Real8
        Storage space for computed
        Bmad type: REAL_8
        Fortran default: null()
    m : int
        Bmad type: INTEGER
        Fortran default: null()
    n : int
        Bmad type: INTEGER
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    scale : Real8
        Bmad type: REAL_8
        Fortran default: null()
    t : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    te : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    angc : float
        Bmad type: real
        Fortran default: null()
    dc : float
        Bmad type: real
        Fortran default: null()
    hc : float
        Bmad type: real
        Fortran default: null()
    vc : float
        Bmad type: real
        Fortran default: null()
    xc : float
        Bmad type: real
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    b: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    dz: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", phi0(:) => null()",
        validation_alias=pydantic.AliasChoices("dz", "DZ"),
        serialization_alias="DZ",
    )
    e: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="Storage space for computed",
    )
    m: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    scale: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("scale", "SCALE"),
        serialization_alias="SCALE",
    )
    t: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", phi0(:) => null()",
        validation_alias=pydantic.AliasChoices("t", "T"),
        serialization_alias="T",
    )
    te: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", phi0(:) => null()",
        validation_alias=pydantic.AliasChoices("te", "TE"),
        serialization_alias="TE",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    angc: float = pydantic.Field(
        default=0.0,
    )
    dc: float = pydantic.Field(
        default=0.0,
    )
    hc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
        default=0.0,
    )
    xc: float = pydantic.Field(
        default=0.0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class AffineFrame(pydantic.BaseModel):
    """
    AffineFrame corresponds to bmad `AFFINE_FRAME`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 4.

    Attributes
    ----------
    a : float
        Bmad type: REAL
        Fortran default: null()
    angle : float
        Bmad type: REAL
        Fortran default: null()
    b : float
        Bmad type: REAL
        Fortran default: null()
    d : float
        Bmad type: REAL
        Fortran default: null()
    ent : float
        Bmad type: REAL
        Fortran default: null()
    exi : float
        Bmad type: REAL
        Fortran default: null()
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    angle: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("angle", "ANGLE"),
        serialization_alias="ANGLE",
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ent", "ENT"),
        serialization_alias="ENT",
    )
    exi: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("exi", "EXI"),
        serialization_alias="EXI",
    )


class BeamBeamNode(pydantic.BaseModel):
    """
    BeamBeamNode corresponds to bmad `BEAM_BEAM_NODE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 523.

    Attributes
    ----------
    a : float
        patch angles
        Bmad type: REAL
        Fortran default: null()
    a_x1 : int
        patch inverse propagator (not needed)
        Bmad type: INTEGER
        Fortran default: null()
    a_x2 : int
        patch inverse propagator (not needed)
        Bmad type: INTEGER
        Fortran default: null()
    bbk : float
        kick on closed orbit
        Bmad type: REAL
        Fortran default: null()
    d : float
        patch translation
        Bmad type: REAL
        Fortran default: null()
    fk : float
        Bmad type: REAL
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: null()
    patch : bool
        true= patch
        Bmad type: LOGICAL
        Fortran default: null()
    s : float
        Bmad type: REAL
        Fortran default: null()
    sx : float
        Bmad type: REAL
        Fortran default: null()
    sy : float
        Bmad type: REAL
        Fortran default: null()
    xm : float
        trivial transverse displacement: not needed
        Bmad type: REAL
        Fortran default: null()
    ym : float
        trivial transverse displacement: not needed
        Bmad type: REAL
        Fortran default: null()
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        description="patch angles",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    a_x1: int = pydantic.Field(
        default=0,
        description="patch inverse propagator (not needed)",
        validation_alias=pydantic.AliasChoices("a_x1", "A_X1"),
        serialization_alias="A_X1",
    )
    a_x2: int = pydantic.Field(
        default=0,
        description="patch inverse propagator (not needed)",
        validation_alias=pydantic.AliasChoices("a_x2", "A_X2"),
        serialization_alias="A_X2",
    )
    bbk: Sequence[float] = pydantic.Field(
        default=0.0,
        description="kick on closed orbit",
        validation_alias=pydantic.AliasChoices("bbk", "BBK"),
        serialization_alias="BBK",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="patch translation",
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    fk: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fk", "FK"),
        serialization_alias="FK",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    patch: bool = pydantic.Field(
        default=False,
        description="true= patch",
        validation_alias=pydantic.AliasChoices("patch", "PATCH"),
        serialization_alias="PATCH",
    )
    s: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    sx: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sx", "SX"),
        serialization_alias="SX",
    )
    sy: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sy", "SY"),
        serialization_alias="SY",
    )
    xm: Sequence[float] = pydantic.Field(
        default=0.0,
        description="trivial transverse displacement: not needed",
        validation_alias=pydantic.AliasChoices("xm", "XM"),
        serialization_alias="XM",
    )
    ym: Sequence[float] = pydantic.Field(
        default=0.0,
        description="trivial transverse displacement: not needed",
        validation_alias=pydantic.AliasChoices("ym", "YM"),
        serialization_alias="YM",
    )


class BeamLocation(pydantic.BaseModel):
    """
    BeamLocation corresponds to bmad `BEAM_LOCATION`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 461.

    Attributes
    ----------
    node : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    """

    node: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("node", "NODE"),
        serialization_alias="NODE",
    )


class Cav4(pydantic.BaseModel):
    """
    Cav4 corresponds to bmad `CAV4`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 113.

    Attributes
    ----------
    a : float
        Bmad type: real
        Fortran default: null()
    acc : Acceleration
        Bmad type: acceleration
        Fortran default: null()
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    an0 : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn0 : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    delta_e : float
        Bmad type: real
        Fortran default: null()
    f : float
        Bmad type: real
        Fortran default: null()
    freq : float
        Bmad type: real
        Fortran default: null()
    h1 : float
        Bmad type: real
        Fortran default: null()
    h2 : float
        Bmad type: real
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    nf : int
        Bmad type: INTEGER
        Fortran default: null()
    n_bessel : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    ph : float
        Bmad type: real
        Fortran default: null()
    phas : float
        Bmad type: real
        Fortran default: null()
    r : float
        Bmad type: real
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    volt : float
        Bmad type: real
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    phase0 : float
        Bmad type: real
        Fortran default: null()
    t : float
        Bmad type: real
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    a: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    acc: Acceleration = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("acc", "ACC"),
        serialization_alias="ACC",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    an0: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an0", "AN0"),
        serialization_alias="AN0",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    bn0: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn0", "BN0"),
        serialization_alias="BN0",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    freq: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    h1: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    nf: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nf", "NF"),
        serialization_alias="NF",
    )
    n_bessel: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    ph: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ph", "PH"),
        serialization_alias="PH",
    )
    phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    r: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )
    t: float = pydantic.Field(
        default=0.0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class Cav4p(pydantic.BaseModel):
    """
    Cav4p corresponds to bmad `CAV4P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 132.

    Attributes
    ----------
    a : Real8
        Bmad type: REAL_8
        Fortran default: null()
    acc : Acceleration
        Bmad type: acceleration
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    an0 : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn0 : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    delta_e : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    f : Real8
        Bmad type: REAL_8
        Fortran default: null()
    freq : Real8
        Cavity Information
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    nf : int
        Bmad type: INTEGER
        Fortran default: null()
    n_bessel : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    ph : Real8
        Bmad type: REAL_8
        Fortran default: null()
    phas : Real8
        Cavity Information
        Bmad type: REAL_8
        Fortran default: null()
    r : Real8
        Bmad type: REAL_8
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    volt : Real8
        Cavity Information
        Bmad type: REAL_8
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    phase0 : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    t : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    a: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    acc: Acceleration = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("acc", "ACC"),
        serialization_alias="ACC",
    )
    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    an0: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an0", "AN0"),
        serialization_alias="AN0",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    bn0: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn0", "BN0"),
        serialization_alias="BN0",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    f: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    freq: Real8 = pydantic.Field(
        default=None,
        description="Cavity Information",
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    nf: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nf", "NF"),
        serialization_alias="NF",
    )
    n_bessel: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    ph: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ph", "PH"),
        serialization_alias="PH",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        description="Cavity Information",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    r: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    volt: Real8 = pydantic.Field(
        default=None,
        description="Cavity Information",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    phase0: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
    )
    t: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class CavTrav(pydantic.BaseModel):
    """
    CavTrav corresponds to bmad `CAV_TRAV`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 151.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    delta_e : float
        Bmad type: real
        Fortran default: null()
    dphas : float
        Bmad type: real
        Fortran default: null()
    dvds : float
        Bmad type: real
        Fortran default: null()
    freq : float
        Bmad type: real
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phas : float
        Bmad type: real
    psi : float
        Bmad type: real
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    volt : float
        Bmad type: real
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    implicit : bool
        Bmad type: logical
        Fortran default: null()
    phase0 : float
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
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
    dvds: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dvds", "DVDS"),
        serialization_alias="DVDS",
    )
    freq: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    psi: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("psi", "PSI"),
        serialization_alias="PSI",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    implicit: bool = pydantic.Field(
        default=False,
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )


class CavTravp(pydantic.BaseModel):
    """
    CavTravp corresponds to bmad `CAV_TRAVP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 163.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: real_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: real_8
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    delta_e : float
        Bmad type: real
        Fortran default: null()
    dphas : Real8
        Bmad type: REAL_8
        Fortran default: null()
    dvds : Real8
        Bmad type: REAL_8
        Fortran default: null()
    freq : Real8
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Storage space for computed
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phas : Real8
        Bmad type: REAL_8
        Fortran default: null()
    psi : Real8
        Bmad type: REAL_8
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    volt : Real8
        Bmad type: REAL_8
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    implicit : bool
        Bmad type: logical
        Fortran default: null()
    phase0 : float
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    dphas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("dphas", "DPHAS"),
        serialization_alias="DPHAS",
    )
    dvds: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("dvds", "DVDS"),
        serialization_alias="DVDS",
    )
    freq: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="Storage space for computed",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    psi: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("psi", "PSI"),
        serialization_alias="PSI",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    volt: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    implicit: bool = pydantic.Field(
        default=False,
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )


class Chart(pydantic.BaseModel):
    """
    Chart corresponds to bmad `CHART`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 37.

    Attributes
    ----------
    ang_in : float
        Bmad type: real
        Fortran default: null()
    ang_out : float
        Bmad type: real
        Fortran default: null()
    d_in : float
        Bmad type: real
        Fortran default: null()
    d_out : float
        Bmad type: real
        Fortran default: null()
    f : MagnetFrame
        Bmad type: magnet_frame
        Fortran default: null()
    """

    ang_in: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ang_in", "ANG_IN"),
        serialization_alias="ANG_IN",
    )
    ang_out: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ang_out", "ANG_OUT"),
        serialization_alias="ANG_OUT",
    )
    d_in: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_in", "D_IN"),
        serialization_alias="D_IN",
    )
    d_out: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_out", "D_OUT"),
        serialization_alias="D_OUT",
    )
    f: MagnetFrame = pydantic.Field(
        default=None,
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


class Dkd2(pydantic.BaseModel):
    """
    Dkd2 corresponds to bmad `DKD2`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 46.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h1 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h2 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    vs : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    f: int = pydantic.Field(
        default=0,
    )


class Dkd2p(pydantic.BaseModel):
    """
    Dkd2p corresponds to bmad `DKD2P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 56.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    f: int = pydantic.Field(
        default=0,
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


class Drift1(pydantic.BaseModel):
    """
    Drift1 corresponds to bmad `DRIFT1`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 22.

    Attributes
    ----------
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Drift1p(pydantic.BaseModel):
    """
    Drift1p corresponds to bmad `DRIFT1P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 27.

    Attributes
    ----------
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Ecol(pydantic.BaseModel):
    """
    Ecol corresponds to bmad `ECOL`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 341.

    Attributes
    ----------
    L : float
        collimator of MAD
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    L: float = pydantic.Field(
        default=0.0,
        description="collimator of MAD",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Ecolp(pydantic.BaseModel):
    """
    Ecolp corresponds to bmad `ECOLP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 347.

    Attributes
    ----------
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Element(pydantic.BaseModel):
    """
    Element corresponds to bmad `ELEMENT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 210.

    Attributes
    ----------
    ab : Abell
        TYPE ABELL
        Bmad type: ABELL
        Fortran default: null()
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    a_ac : float
        slow RF: amplitude and phase
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    b_sol : float
        Bmad type: real
        Fortran default: null()
    c4 : Cav4
        CAVITY  $
        Bmad type: CAV4
        Fortran default: null()
    cav21 : CavTrav
        CAVITY TRAVELLING WAVE  (not symplectic)
        Bmad type: CAV_TRAV
        Fortran default: null()
    d0 : Drift1
        DRIFT
        Bmad type: DRIFT1
        Fortran default: null()
    d0_an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    d0_bn : float
        Multipole component
        Bmad type: real
        Fortran default: null();
    d0_volt : float
        Bmad type: real
        Fortran default: null();
    d0_phas : float
        Bmad type: real
        Fortran default: null();
    dc_ac : float
        slow RF: amplitude and phase
        Bmad type: real
        Fortran default: null()
    delta_e : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    d_ac : float
        slow RF: amplitude and phase
        Bmad type: real
        Fortran default: null()
    d_an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    d_bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    d_volt : float
        Bmad type: real
        Fortran default: null()
    d_phas : float
        Bmad type: real
        Fortran default: null()
    ecol19 : Ecol
        ECOLLIMATOR
        Bmad type: ECOL
        Fortran default: null()
    enge17 : Enge
        not implemented
        Bmad type: ENGE
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    freq : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    h1 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h2 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    he22 : HelicalDipole
        exact =false otherwise not correct
        Bmad type: HELICAL_DIPOLE
        Fortran default: null()
    hgap : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    k16 : Strex
        EXACT STRAIGHT INTEGRATOR  $
        Bmad type: STREX
        Fortran default: null()
    k2 : Dkd2
        INTEGRATOR  $
        Bmad type: DKD2
        Fortran default: null()
    k3 : Kickt3
        THIN KICK
        Bmad type: KICKT3
        Fortran default: null()
    kind : int
        Bmad type: INTEGER
        Fortran default: null()
    L : float
        Length of integration often same as LD
        Bmad type: real
        Fortran default: null()
    lag : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    mis : bool
        migalignment on or off
        Bmad type: logical
        Fortran default: null()
    mon14 : Mon
        MONITOR OR INSTRUMENT
        Bmad type: MON
        Fortran default: null()
    name : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    pa : Pancake
        GENERAL B represented as Taylor
        Bmad type: PANCAKE
        Fortran default: null()
    parent_fibre : Fibre
        in the database universe
        Bmad type: FIBRE
        Fortran default: null()
    phas : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    plot : bool
        Bmad type: LOGICAL
        Fortran default: null()
    rcol18 : Rcol
        RCOLLIMATOR
        Bmad type: RCOL
        Fortran default: null()
    s5 : Sol5
        solenoid  $
        Bmad type: SOL5
        Fortran default: null()
    s8 : Nsmi
        NORMAL SMI Sixtrack shit
        Bmad type: NSMI
        Fortran default: null()
    s9 : Ssmi
        SKEW SMI Sixtrack shit
        Bmad type: SSMI
        Fortran default: null()
    sdr : Superdrift
        GENERAL DRIFT
        Bmad type: SUPERDRIFT
        Fortran default: null()
    sep15 : Eseptum
        MONITOR OR INSTRUMENT electric kicker
        Bmad type: ESEPTUM
        Fortran default: null()
    siamese_frame : AffineFrame
        Bmad type: AFFINE_FRAME
        Fortran default: null()
    t6 : Ktk
        INTEGRATOR   thick slow
        Bmad type: KTK
        Fortran default: null()
    t7 : Tktf
        INTEGRATOR   thick fast   $
        Bmad type: TKTF
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    tp10 : Teapot
        sector teapot exact sector bend electric or magnetic $
        Bmad type: TEAPOT
        Fortran default: null()
    va : float
        use in quad fringe from sad
        Bmad type: real
        Fortran default: null()
    volt : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    vorname : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    vs : float
        use in quad fringe from sad
        Bmad type: real
        Fortran default: null()
    wi : Sagan
        USER DEFINED  undulator exact =.false.
        Bmad type: SAGAN
        Fortran default: null()
    assembly : Girder
        actual girders
        Bmad type: girder
        Fortran default: null()
    backward : TreeElement
        Taylor tracking on a fibre
        Bmad type: tree_element
        Fortran default: null()
    do1mapb : bool
        Bmad type: logical
        Fortran default: null()
    do1mapf : bool
        Bmad type: logical
        Fortran default: null()
    doko : FibreAppearance
        all appearances
        Bmad type: fibre_appearance
        Fortran default: null()
    electric : bool
        type teapot can be electric
        Bmad type: LOGICAL
        Fortran default: null()
    ene : float
        for tapering
        Bmad type: real
    even : bool
        Bmad type: logical
        Fortran default: null()
    fileb : str
        Bmad type: character
    filef : str
        maps replacing ptc
        Bmad type: character
    forward : TreeElement
        Taylor tracking on a fibre
        Bmad type: tree_element
        Fortran default: null()
    girder_frame : AffineFrame
        Bmad type: AFFINE_FRAME
        Fortran default: null()
    girders : Element
        magnets on a girder
        Bmad type: element
        Fortran default: null()
    old_integrator : int
        Bmad type: INTEGER
        Fortran default: null()
    probe : bool
        Bmad type: logical
        Fortran default: null()
    ramp : Ramping
        Bmad type: ramping
        Fortran default: null()
    recut : bool
        Bmad type: logical
    siamese : Element
        magnets somewhat glued together
        Bmad type: element
        Fortran default: null()
    skip_ptc_b : int
        Bmad type: integer
        Fortran default: null()
    skip_ptc_f : int
        Bmad type: integer
        Fortran default: null()
    slow_ac : int
        magnet modulation
        Bmad type: integer
        Fortran default: null()
    theta_ac : float
        slow RF: amplitude and phase
        Bmad type: real
        Fortran default: null()
    useb : bool
        Bmad type: logical
        Fortran default: null()
    usef : bool
        Bmad type: logical
        Fortran default: null()
    """

    ab: Abell = pydantic.Field(
        default=None,
        description="TYPE ABELL",
        validation_alias=pydantic.AliasChoices("ab", "AB"),
        serialization_alias="AB",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    a_ac: float = pydantic.Field(
        default=0.0,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("a_ac", "A_ac"),
        serialization_alias="A_ac",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    c4: Cav4 = pydantic.Field(
        default=None,
        description="CAVITY  $",
        validation_alias=pydantic.AliasChoices("c4", "C4"),
        serialization_alias="C4",
    )
    cav21: CavTrav = pydantic.Field(
        default=None,
        description="CAVITY TRAVELLING WAVE  (not symplectic)",
        validation_alias=pydantic.AliasChoices("cav21", "CAV21"),
        serialization_alias="CAV21",
    )
    d0: Drift1 = pydantic.Field(
        default=None,
        description="DRIFT",
        validation_alias=pydantic.AliasChoices("d0", "D0"),
        serialization_alias="D0",
    )
    d0_an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d0_an", "D0_AN"),
        serialization_alias="D0_AN",
    )
    d0_bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d0_bn", "D0_BN"),
        serialization_alias="D0_BN",
    )
    d0_volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d0_volt", "D0_Volt"),
        serialization_alias="D0_Volt",
    )
    d0_phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d0_phas", "D0_phas"),
        serialization_alias="D0_phas",
    )
    dc_ac: float = pydantic.Field(
        default=0.0,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("dc_ac", "DC_ac"),
        serialization_alias="DC_ac",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    d_ac: float = pydantic.Field(
        default=0.0,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("d_ac", "D_AC"),
        serialization_alias="D_AC",
    )
    d_an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d_an", "D_AN"),
        serialization_alias="D_AN",
    )
    d_bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d_bn", "D_BN"),
        serialization_alias="D_BN",
    )
    d_volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_volt", "D_Volt"),
        serialization_alias="D_Volt",
    )
    d_phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_phas", "D_phas"),
        serialization_alias="D_phas",
    )
    ecol19: Ecol = pydantic.Field(
        default=None,
        description="ECOLLIMATOR",
        validation_alias=pydantic.AliasChoices("ecol19", "ECOL19"),
        serialization_alias="ECOL19",
    )
    enge17: Enge = pydantic.Field(
        default=None,
        description="not implemented",
        validation_alias=pydantic.AliasChoices("enge17", "ENGE17"),
        serialization_alias="ENGE17",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    freq: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    h1: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    he22: HelicalDipole = pydantic.Field(
        default=None,
        description="exact =false otherwise not correct",
        validation_alias=pydantic.AliasChoices("he22", "HE22"),
        serialization_alias="HE22",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    k16: Strex = pydantic.Field(
        default=None,
        description="EXACT STRAIGHT INTEGRATOR  $",
        validation_alias=pydantic.AliasChoices("k16", "K16"),
        serialization_alias="K16",
    )
    k2: Dkd2 = pydantic.Field(
        default=None,
        description="INTEGRATOR  $",
        validation_alias=pydantic.AliasChoices("k2", "K2"),
        serialization_alias="K2",
    )
    k3: Kickt3 = pydantic.Field(
        default=None,
        description="THIN KICK",
        validation_alias=pydantic.AliasChoices("k3", "K3"),
        serialization_alias="K3",
    )
    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Length of integration often same as LD",
    )
    lag: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("lag", "LAG"),
        serialization_alias="LAG",
    )
    mis: bool = pydantic.Field(
        default=False,
        description="migalignment on or off",
        validation_alias=pydantic.AliasChoices("mis", "MIS"),
        serialization_alias="MIS",
    )
    mon14: Mon = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT",
        validation_alias=pydantic.AliasChoices("mon14", "MON14"),
        serialization_alias="MON14",
    )
    name: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    pa: Pancake = pydantic.Field(
        default=None,
        description="GENERAL B represented as Taylor",
        validation_alias=pydantic.AliasChoices("pa", "PA"),
        serialization_alias="PA",
    )
    parent_fibre: Fibre = pydantic.Field(
        default=None,
        description="in the database universe",
        validation_alias=pydantic.AliasChoices("parent_fibre", "PARENT_FIBRE"),
        serialization_alias="PARENT_FIBRE",
    )
    phas: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    plot: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("plot", "PLOT"),
        serialization_alias="PLOT",
    )
    rcol18: Rcol = pydantic.Field(
        default=None,
        description="RCOLLIMATOR",
        validation_alias=pydantic.AliasChoices("rcol18", "RCOL18"),
        serialization_alias="RCOL18",
    )
    s5: Sol5 = pydantic.Field(
        default=None,
        description="solenoid  $",
        validation_alias=pydantic.AliasChoices("s5", "S5"),
        serialization_alias="S5",
    )
    s8: Nsmi = pydantic.Field(
        default=None,
        description="NORMAL SMI Sixtrack shit",
        validation_alias=pydantic.AliasChoices("s8", "S8"),
        serialization_alias="S8",
    )
    s9: Ssmi = pydantic.Field(
        default=None,
        description="SKEW SMI Sixtrack shit",
        validation_alias=pydantic.AliasChoices("s9", "S9"),
        serialization_alias="S9",
    )
    sdr: Superdrift = pydantic.Field(
        default=None,
        description="GENERAL DRIFT",
        validation_alias=pydantic.AliasChoices("sdr", "SDR"),
        serialization_alias="SDR",
    )
    sep15: Eseptum = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT electric kicker",
        validation_alias=pydantic.AliasChoices("sep15", "SEP15"),
        serialization_alias="SEP15",
    )
    siamese_frame: AffineFrame = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("siamese_frame", "SIAMESE_FRAME"),
        serialization_alias="SIAMESE_FRAME",
    )
    t6: Ktk = pydantic.Field(
        default=None,
        description="INTEGRATOR   thick slow",
        validation_alias=pydantic.AliasChoices("t6", "T6"),
        serialization_alias="T6",
    )
    t7: Tktf = pydantic.Field(
        default=None,
        description="INTEGRATOR   thick fast   $",
        validation_alias=pydantic.AliasChoices("t7", "T7"),
        serialization_alias="T7",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    tp10: Teapot = pydantic.Field(
        default=None,
        description="sector teapot exact sector bend electric or magnetic $",
        validation_alias=pydantic.AliasChoices("tp10", "TP10"),
        serialization_alias="TP10",
    )
    va: float = pydantic.Field(
        default=0.0,
        description="use in quad fringe from sad",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    volt: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    vorname: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="use in quad fringe from sad",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    wi: Sagan = pydantic.Field(
        default=None,
        description="USER DEFINED  undulator exact =.false.",
        validation_alias=pydantic.AliasChoices("wi", "WI"),
        serialization_alias="WI",
    )
    assembly: Girder = pydantic.Field(
        default=None,
        description="actual girders",
    )
    backward: Sequence[TreeElement] = pydantic.Field(
        default=None,
        description="Taylor tracking on a fibre",
    )
    do1mapb: bool = pydantic.Field(
        default=False,
    )
    do1mapf: bool = pydantic.Field(
        default=False,
    )
    doko: FibreAppearance = pydantic.Field(
        default=None,
        description="all appearances",
    )
    electric: bool = pydantic.Field(
        default=False,
        description="type teapot can be electric",
    )
    ene: float = pydantic.Field(
        default=0.0,
        description="for tapering",
    )
    even: bool = pydantic.Field(
        default=False,
    )
    fileb: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    filef: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="maps replacing ptc",
    )
    forward: Sequence[TreeElement] = pydantic.Field(
        default=None,
        description="Taylor tracking on a fibre",
    )
    girder_frame: AffineFrame = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("girder_frame", "girder_FRAME"),
        serialization_alias="girder_FRAME",
    )
    girders: Element = pydantic.Field(
        default=None,
        description="magnets on a girder",
    )
    old_integrator: int = pydantic.Field(
        default=0,
    )
    probe: bool = pydantic.Field(
        default=False,
    )
    ramp: Ramping = pydantic.Field(
        default=None,
    )
    recut: bool = pydantic.Field(
        default=False,
    )
    siamese: Element = pydantic.Field(
        default=None,
        description="magnets somewhat glued together",
    )
    skip_ptc_b: int = pydantic.Field(
        default=0,
    )
    skip_ptc_f: int = pydantic.Field(
        default=0,
    )
    slow_ac: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="magnet modulation",
    )
    theta_ac: float = pydantic.Field(
        default=0.0,
        description="slow RF: amplitude and phase",
    )
    useb: bool = pydantic.Field(
        default=False,
    )
    usef: bool = pydantic.Field(
        default=False,
    )


class Elementp(pydantic.BaseModel):
    """
    Elementp corresponds to bmad `ELEMENTP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 286.

    Attributes
    ----------
    ab : Abellp
        TYPE ABELL
        Bmad type: ABELLP
        Fortran default: null()
    an : Real8
        MULTIPOLE COMPONENT
        Bmad type: REAL_8
        Fortran default: null()
    a_ac : Real8
        slow RF: amplitude and phase
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        MULTIPOLE COMPONENT
        Bmad type: REAL_8
        Fortran default: null()
    b_sol : Real8
        Bmad type: REAL_8
        Fortran default: null()
    c4 : Cav4p
        DRIFT
        Bmad type: CAV4P
        Fortran default: null()
    cav21 : CavTravp
        CAVITY TRAVELLING WAVE
        Bmad type: CAV_TRAVP
        Fortran default: null()
    d0 : Drift1p
        DRIFT
        Bmad type: DRIFT1P
        Fortran default: null()
    d0_an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    d0_bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    d0_volt : Real8
        Bmad type: REAL_8
        Fortran default: null();
    d0_phas : Real8
        Bmad type: REAL_8
        Fortran default: null();
    dc_ac : Real8
        slow RF: amplitude and phase
        Bmad type: REAL_8
        Fortran default: null()
    delta_e : float
        CAVITY ENERGY GAIN
        Bmad type: real
        Fortran default: null()
    d_ac : Real8
        slow RF: amplitude and phase
        Bmad type: REAL_8
        Fortran default: null()
    d_an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    d_bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    d_volt : Real8
        Bmad type: REAL_8
        Fortran default: null()
    d_phas : Real8
        Bmad type: REAL_8
        Fortran default: null()
    ecol19 : Ecolp
        ECOLLIMATOR
        Bmad type: ECOLP
        Fortran default: null()
    enge17 : Engep
        SOLENOID SIXTRACK STYLE
        Bmad type: ENGEP
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    freq : Real8
        CAVITY INFORMATION
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    he22 : HelicalDipolep
        GENERAL B
        Bmad type: HELICAL_DIPOLEP
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    k16 : Strexp
        EXACT STRAIGHT INTEGRATOR
        Bmad type: STREXP
        Fortran default: null()
    k2 : Dkd2p
        INTEGRATOR
        Bmad type: DKD2P
        Fortran default: null()
    k3 : Kickt3p
        THIN KICK
        Bmad type: KICKT3P
        Fortran default: null()
    kind : int
        WHAT IT IS
        Bmad type: INTEGER
        Fortran default: null()
    knob : bool
        FALSE IF NO KNOB
        Bmad type: logical
        Fortran default: null()
    L : Real8
        LENGTH OF INTEGRATION OFTEN SAME AS LD, CAN BE ZERO
        Bmad type: REAL_8
        Fortran default: null()
    mis : bool
        Bmad type: logical
        Fortran default: null()
    mon14 : Monp
        MONITOR OR INSTRUMENT
        Bmad type: MONP
        Fortran default: null()
    name : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    pa : Pancakep
        GENERAL B
        Bmad type: PANCAKEP
        Fortran default: null()
    parent_fibre : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    phas : Real8
        CAVITY INFORMATION
        Bmad type: REAL_8
        Fortran default: null()
    rcol18 : Rcolp
        RCOLLIMATOR
        Bmad type: RCOLP
        Fortran default: null()
    s5 : Sol5p
        CAVITY
        Bmad type: SOL5P
        Fortran default: null()
    s8 : Nsmip
        NORMAL SMI
        Bmad type: NSMIP
        Fortran default: null()
    s9 : Ssmip
        SKEW SMI
        Bmad type: SSMIP
        Fortran default: null()
    sdr : Superdriftp
        GENERAL DRIFT
        Bmad type: SUPERDRIFTP
        Fortran default: null()
    sep15 : Eseptump
        MONITOR OR INSTRUMENT
        Bmad type: ESEPTUMP
        Fortran default: null()
    t6 : Ktkp
        INTEGRATOR
        Bmad type: KTKP
        Fortran default: null()
    t7 : Tktfp
        INTEGRATOR   THICK FAST
        Bmad type: TKTFP
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    tp10 : Teapotp
        SECTOR BEND WITH CYLINDRICAL GEOMETRY
        Bmad type: TEAPOTP
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    volt : Real8
        CAVITY INFORMATION
        Bmad type: REAL_8
        Fortran default: null()
    vorname : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    wi : Saganp
        USER DEFINED
        Bmad type: SAGANP
        Fortran default: null()
    backward : TreeElement
        Bmad type: tree_element
        Fortran default: null()
    do1mapb : bool
        Bmad type: logical
        Fortran default: null()
    do1mapf : bool
        Bmad type: logical
        Fortran default: null()
    electric : bool
        Bmad type: LOGICAL
        Fortran default: null()
    forward : TreeElement
        Bmad type: tree_element
        Fortran default: null()
    old_integrator : int
        Bmad type: INTEGER
        Fortran default: null()
    probe : bool
        FALSE IF NO KNOB
        Bmad type: logical
        Fortran default: null()
    ramp : Ramping
        Bmad type: ramping
        Fortran default: null()
    skip_ptc_b : int
        Bmad type: integer
        Fortran default: null()
    skip_ptc_f : int
        Bmad type: integer
        Fortran default: null()
    slow_ac : int
        Bmad type: integer
        Fortran default: null()
    theta_ac : Real8
        slow RF: amplitude and phase
        Bmad type: REAL_8
        Fortran default: null()
    useb : bool
        Bmad type: logical
        Fortran default: null()
    usef : bool
        Bmad type: logical
        Fortran default: null()
    """

    ab: Abellp = pydantic.Field(
        default=None,
        description="TYPE ABELL",
        validation_alias=pydantic.AliasChoices("ab", "AB"),
        serialization_alias="AB",
    )
    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="MULTIPOLE COMPONENT",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    a_ac: Real8 = pydantic.Field(
        default=None,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("a_ac", "A_ac"),
        serialization_alias="A_ac",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="MULTIPOLE COMPONENT",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    b_sol: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    c4: Cav4p = pydantic.Field(
        default=None,
        description="DRIFT",
        validation_alias=pydantic.AliasChoices("c4", "C4"),
        serialization_alias="C4",
    )
    cav21: CavTravp = pydantic.Field(
        default=None,
        description="CAVITY TRAVELLING WAVE",
        validation_alias=pydantic.AliasChoices("cav21", "CAV21"),
        serialization_alias="CAV21",
    )
    d0: Drift1p = pydantic.Field(
        default=None,
        description="DRIFT",
        validation_alias=pydantic.AliasChoices("d0", "D0"),
        serialization_alias="D0",
    )
    d0_an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d0_an", "D0_AN"),
        serialization_alias="D0_AN",
    )
    d0_bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d0_bn", "D0_BN"),
        serialization_alias="D0_BN",
    )
    d0_volt: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d0_volt", "D0_Volt"),
        serialization_alias="D0_Volt",
    )
    d0_phas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d0_phas", "D0_phas"),
        serialization_alias="D0_phas",
    )
    dc_ac: Real8 = pydantic.Field(
        default=None,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("dc_ac", "DC_ac"),
        serialization_alias="DC_ac",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        description="CAVITY ENERGY GAIN",
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    d_ac: Real8 = pydantic.Field(
        default=None,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("d_ac", "D_AC"),
        serialization_alias="D_AC",
    )
    d_an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d_an", "D_AN"),
        serialization_alias="D_AN",
    )
    d_bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("d_bn", "D_BN"),
        serialization_alias="D_BN",
    )
    d_volt: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d_volt", "D_Volt"),
        serialization_alias="D_Volt",
    )
    d_phas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d_phas", "D_phas"),
        serialization_alias="D_phas",
    )
    ecol19: Ecolp = pydantic.Field(
        default=None,
        description="ECOLLIMATOR",
        validation_alias=pydantic.AliasChoices("ecol19", "ECOL19"),
        serialization_alias="ECOL19",
    )
    enge17: Engep = pydantic.Field(
        default=None,
        description="SOLENOID SIXTRACK STYLE",
        validation_alias=pydantic.AliasChoices("enge17", "ENGE17"),
        serialization_alias="ENGE17",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    freq: Real8 = pydantic.Field(
        default=None,
        description="CAVITY INFORMATION",
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    he22: HelicalDipolep = pydantic.Field(
        default=None,
        description="GENERAL B",
        validation_alias=pydantic.AliasChoices("he22", "HE22"),
        serialization_alias="HE22",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    k16: Strexp = pydantic.Field(
        default=None,
        description="EXACT STRAIGHT INTEGRATOR",
        validation_alias=pydantic.AliasChoices("k16", "K16"),
        serialization_alias="K16",
    )
    k2: Dkd2p = pydantic.Field(
        default=None,
        description="INTEGRATOR",
        validation_alias=pydantic.AliasChoices("k2", "K2"),
        serialization_alias="K2",
    )
    k3: Kickt3p = pydantic.Field(
        default=None,
        description="THIN KICK",
        validation_alias=pydantic.AliasChoices("k3", "K3"),
        serialization_alias="K3",
    )
    kind: int = pydantic.Field(
        default=0,
        description="WHAT IT IS",
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    knob: bool = pydantic.Field(
        default=False,
        description="FALSE IF NO KNOB",
        validation_alias=pydantic.AliasChoices("knob", "KNOB"),
        serialization_alias="KNOB",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="LENGTH OF INTEGRATION OFTEN SAME AS LD, CAN BE ZERO",
    )
    mis: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("mis", "MIS"),
        serialization_alias="MIS",
    )
    mon14: Monp = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT",
        validation_alias=pydantic.AliasChoices("mon14", "MON14"),
        serialization_alias="MON14",
    )
    name: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    pa: Pancakep = pydantic.Field(
        default=None,
        description="GENERAL B",
        validation_alias=pydantic.AliasChoices("pa", "PA"),
        serialization_alias="PA",
    )
    parent_fibre: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_fibre", "PARENT_FIBRE"),
        serialization_alias="PARENT_FIBRE",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        description="CAVITY INFORMATION",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    rcol18: Rcolp = pydantic.Field(
        default=None,
        description="RCOLLIMATOR",
        validation_alias=pydantic.AliasChoices("rcol18", "RCOL18"),
        serialization_alias="RCOL18",
    )
    s5: Sol5p = pydantic.Field(
        default=None,
        description="CAVITY",
        validation_alias=pydantic.AliasChoices("s5", "S5"),
        serialization_alias="S5",
    )
    s8: Nsmip = pydantic.Field(
        default=None,
        description="NORMAL SMI",
        validation_alias=pydantic.AliasChoices("s8", "S8"),
        serialization_alias="S8",
    )
    s9: Ssmip = pydantic.Field(
        default=None,
        description="SKEW SMI",
        validation_alias=pydantic.AliasChoices("s9", "S9"),
        serialization_alias="S9",
    )
    sdr: Superdriftp = pydantic.Field(
        default=None,
        description="GENERAL DRIFT",
        validation_alias=pydantic.AliasChoices("sdr", "SDR"),
        serialization_alias="SDR",
    )
    sep15: Eseptump = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT",
        validation_alias=pydantic.AliasChoices("sep15", "SEP15"),
        serialization_alias="SEP15",
    )
    t6: Ktkp = pydantic.Field(
        default=None,
        description="INTEGRATOR",
        validation_alias=pydantic.AliasChoices("t6", "T6"),
        serialization_alias="T6",
    )
    t7: Tktfp = pydantic.Field(
        default=None,
        description="INTEGRATOR   THICK FAST",
        validation_alias=pydantic.AliasChoices("t7", "T7"),
        serialization_alias="T7",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    tp10: Teapotp = pydantic.Field(
        default=None,
        description="SECTOR BEND WITH CYLINDRICAL GEOMETRY",
        validation_alias=pydantic.AliasChoices("tp10", "TP10"),
        serialization_alias="TP10",
    )
    va: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    volt: Real8 = pydantic.Field(
        default=None,
        description="CAVITY INFORMATION",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    vorname: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    vs: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    wi: Saganp = pydantic.Field(
        default=None,
        description="USER DEFINED",
        validation_alias=pydantic.AliasChoices("wi", "WI"),
        serialization_alias="WI",
    )
    backward: Sequence[TreeElement] = pydantic.Field(
        default=None,
    )
    do1mapb: bool = pydantic.Field(
        default=False,
    )
    do1mapf: bool = pydantic.Field(
        default=False,
    )
    electric: bool = pydantic.Field(
        default=False,
    )
    forward: Sequence[TreeElement] = pydantic.Field(
        default=None,
    )
    old_integrator: int = pydantic.Field(
        default=0,
    )
    probe: bool = pydantic.Field(
        default=False,
        description="FALSE IF NO KNOB",
    )
    ramp: Ramping = pydantic.Field(
        default=None,
    )
    skip_ptc_b: int = pydantic.Field(
        default=0,
    )
    skip_ptc_f: int = pydantic.Field(
        default=0,
    )
    slow_ac: int = pydantic.Field(
        default_factory=list,
        max_length=2,
    )
    theta_ac: Real8 = pydantic.Field(
        default=None,
        description="slow RF: amplitude and phase",
    )
    useb: bool = pydantic.Field(
        default=False,
    )
    usef: bool = pydantic.Field(
        default=False,
    )


class Enge(pydantic.BaseModel):
    """
    Enge corresponds to bmad `ENGE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 390.

    Attributes
    ----------
    a : float
        ENGE  COEFFICIENTS
        Bmad type: real
        Fortran default: null()
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    d : float
        Bmad type: real
        Fortran default: null()
    f : My1dTaylor
        Bmad type: my_1D_taylor
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    nbessel : int
        Bmad type: integer
        Fortran default: null()
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENGE  COEFFICIENTS",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    d: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    f: My1dTaylor = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    nbessel: int = pydantic.Field(
        default=0,
    )


class Engep(pydantic.BaseModel):
    """
    Engep corresponds to bmad `ENGEP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 399.

    Attributes
    ----------
    a : float
        ENGE  COEFFICIENTS
        Bmad type: real
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    d : float
        Bmad type: real
        Fortran default: null()
    f : My1dTaylor
        Bmad type: my_1D_taylor
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    nbessel : int
        Bmad type: integer
        Fortran default: null()
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENGE  COEFFICIENTS",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    d: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    f: My1dTaylor = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    nbessel: int = pydantic.Field(
        default=0,
    )


class Eseptum(pydantic.BaseModel):
    """
    Eseptum corresponds to bmad `ESEPTUM`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 353.

    Attributes
    ----------
    L : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phas : float
        TILT TO MIMIC E_X AND E_Y OF MAD-X
        Bmad type: real
        Fortran default: null()
    volt : float
        VOLTAGE IN MV/M
        Bmad type: real
        Fortran default: null()
    """

    L: float = pydantic.Field(
        default=0.0,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phas: float = pydantic.Field(
        default=0.0,
        description="TILT TO MIMIC E_X AND E_Y OF MAD-X",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    volt: float = pydantic.Field(
        default=0.0,
        description="VOLTAGE IN MV/M",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )


class Eseptump(pydantic.BaseModel):
    """
    Eseptump corresponds to bmad `ESEPTUMP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 360.

    Attributes
    ----------
    L : Real8
        monitor and instrument of MAD
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phas : Real8
        TILT TO MIMIC E_X AND E_Y OF MAD-X
        Bmad type: REAL_8
        Fortran default: null()
    volt : Real8
        VOLTAGE IN MV/M
        Bmad type: REAL_8
        Fortran default: null()
    """

    L: Real8 = pydantic.Field(
        default=None,
        description="monitor and instrument of MAD",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        description="TILT TO MIMIC E_X AND E_Y OF MAD-X",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    volt: Real8 = pydantic.Field(
        default=None,
        description="VOLTAGE IN MV/M",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )


class ExtraWork(pydantic.BaseModel):
    """
    ExtraWork corresponds to bmad `EXTRA_WORK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 536.

    Attributes
    ----------
    a : MadxAperture
        Bmad type: MADX_APERTURE
        Fortran default: null()
    bb : BeamBeamNode
        Bmad type: BEAM_BEAM_NODE
        Fortran default: null()
    kind : int
        Bmad type: INTEGER
        Fortran default: null()
    node : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    orb : float
        Bmad type: REAL
        Fortran default: null()
    """

    a: MadxAperture = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    bb: BeamBeamNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("bb", "BB"),
        serialization_alias="BB",
    )
    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    node: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("node", "NODE"),
        serialization_alias="NODE",
    )
    orb: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("orb", "ORB"),
        serialization_alias="ORB",
    )


class EBeam(pydantic.BaseModel):
    """
    EBeam corresponds to bmad `E_BEAM`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 554.

    Attributes
    ----------
    n : int
        Bmad type: integer
    z : Probe
        Bmad type: probe
        Fortran default: null()
    """

    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    z: Sequence[Probe] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("z", "Z"),
        serialization_alias="Z",
    )


class Fibre(pydantic.BaseModel):
    """
    Fibre corresponds to bmad `FIBRE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 385.

    Attributes
    ----------
    ag : float
        spin g-2
        Bmad type: real
        Fortran default: null()
    beta0 : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    charge : float
        Bmad type: real
        Fortran default: null()
    chart : Chart
        Bmad type: CHART
        Fortran default: null()
    dir : int
        Bmad type: INTEGER
        Fortran default: null()
    gambet : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    gamma0i : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    mag : Element
        Bmad type: ELEMENT
        Fortran default: null()
    magp : Elementp
        Bmad type: ELEMENTP
        Fortran default: null()
    mass : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    n : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    next : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    p : Fibre
        tying them in the so-called database universe M_u
        Bmad type: FIBRE
        Fortran default: null()
    parent_layout : Layout
        Bmad type: LAYOUT
        Fortran default: null()
    patch : Patch
        Bmad type: PATCH
        Fortran default: null()
    previous : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    t1 : IntegrationNode
        FIRST AND LAST INTEGRATION_NODE CHILDREN CORRESPOUNDING TO PATCHES
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    t2 : IntegrationNode
        FIRST AND LAST INTEGRATION_NODE CHILDREN CORRESPOUNDING TO PATCHES
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    tm : IntegrationNode
        MIDDLE INTEGRATION_NODE
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    i : Info
        Bmad type: info
        Fortran default: null()
    loc : int
        Bmad type: INTEGER
        Fortran default: null()
    pos : int
        POSITION IN LAYOUT
        Bmad type: INTEGER
        Fortran default: null()
    """

    ag: float = pydantic.Field(
        default=0.0,
        description="spin g-2",
        validation_alias=pydantic.AliasChoices("ag", "AG"),
        serialization_alias="AG",
    )
    beta0: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("beta0", "BETA0"),
        serialization_alias="BETA0",
    )
    charge: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("charge", "CHARGE"),
        serialization_alias="CHARGE",
    )
    chart: Chart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("chart", "CHART"),
        serialization_alias="CHART",
    )
    dir: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("dir", "DIR"),
        serialization_alias="DIR",
    )
    gambet: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("gambet", "GAMBET"),
        serialization_alias="GAMBET",
    )
    gamma0i: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("gamma0i", "GAMMA0I"),
        serialization_alias="GAMMA0I",
    )
    mag: Element = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("mag", "MAG"),
        serialization_alias="MAG",
    )
    magp: Elementp = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("magp", "MAGP"),
        serialization_alias="MAGP",
    )
    mass: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("mass", "MASS"),
        serialization_alias="MASS",
    )
    n: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    next: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    p: Fibre = pydantic.Field(
        default=None,
        description="tying them in the so-called database universe M_u",
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    parent_layout: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_layout", "PARENT_LAYOUT"),
        serialization_alias="PARENT_LAYOUT",
    )
    patch: Patch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("patch", "PATCH"),
        serialization_alias="PATCH",
    )
    previous: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    t1: IntegrationNode = pydantic.Field(
        default=None,
        description="FIRST AND LAST INTEGRATION_NODE CHILDREN CORRESPOUNDING TO PATCHES",
        validation_alias=pydantic.AliasChoices("t1", "T1"),
        serialization_alias="T1",
    )
    t2: IntegrationNode = pydantic.Field(
        default=None,
        description="FIRST AND LAST INTEGRATION_NODE CHILDREN CORRESPOUNDING TO PATCHES",
        validation_alias=pydantic.AliasChoices("t2", "T2"),
        serialization_alias="T2",
    )
    tm: IntegrationNode = pydantic.Field(
        default=None,
        description="MIDDLE INTEGRATION_NODE",
        validation_alias=pydantic.AliasChoices("tm", "TM"),
        serialization_alias="TM",
    )
    i: Info = pydantic.Field(
        default=None,
    )
    loc: int = pydantic.Field(
        default=0,
    )
    pos: int = pydantic.Field(
        default=0,
        description="POSITION IN LAYOUT",
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


class HelicalDipole(pydantic.BaseModel):
    """
    HelicalDipole corresponds to bmad `HELICAL_DIPOLE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 444.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    freq : float
        Bmad type: real
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    n_bessel : int
        Bmad type: integer
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phas : float
        Bmad type: real
        Fortran default: null()
    fake_shift : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    freq: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    fake_shift: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
    )


class HelicalDipolep(pydantic.BaseModel):
    """
    HelicalDipolep corresponds to bmad `HELICAL_DIPOLEP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 452.

    Attributes
    ----------
    an : Real8
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Bmad type: REAL_8
        Fortran default: null()
    freq : Real8
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    n_bessel : int
        Bmad type: integer
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phas : Real8
        Bmad type: REAL_8
        Fortran default: null()
    fake_shift : Real8
        Bmad type: REAL_8
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    freq: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    fake_shift: Sequence[Real8] = pydantic.Field(
        default=None,
    )


class IntegrationNode(pydantic.BaseModel):
    """
    IntegrationNode corresponds to bmad `INTEGRATION_NODE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 364.

    Attributes
    ----------
    bb : BeamBeamNode
        Bmad type: BEAM_BEAM_NODE
        Fortran default: null()
    cas : int
        Bmad type: INTEGER
        Fortran default: null()
    next : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    parent_fibre : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    parent_node_layout : NodeLayout
        Bmad type: NODE_LAYOUT
        Fortran default: null()
    previous : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    s : float
        Bmad type: real
        Fortran default: null()
    teapot_like : int
        Bmad type: INTEGER
        Fortran default: null()
    a : float
        Bmad type: real
        Fortran default: null()
    b : float
        Bmad type: real
        Fortran default: null()
    delta_rad_in : float
        Bmad type: real
        Fortran default: null()
    delta_rad_out : float
        Bmad type: real
        Fortran default: null()
    ds_ac : float
        Bmad type: real
        Fortran default: null()
    ent : float
        Bmad type: real
    exi : float
        Bmad type: real
    lf : CLatticeFunction
        Bmad type: c_lattice_function
        Fortran default: null()
    lost : int
        Bmad type: INTEGER
        Fortran default: null()
    pos : int
        Bmad type: INTEGER
        Fortran default: null()
    pos_in_fibre : int
        Bmad type: INTEGER
        Fortran default: null()
    ref : float
        Bmad type: real
        Fortran default: null()
    """

    bb: BeamBeamNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("bb", "BB"),
        serialization_alias="BB",
    )
    cas: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("cas", "CAS"),
        serialization_alias="CAS",
    )
    next: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    parent_fibre: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_fibre", "PARENT_FIBRE"),
        serialization_alias="PARENT_FIBRE",
    )
    parent_node_layout: NodeLayout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices(
            "parent_node_layout", "PARENT_NODE_LAYOUT"
        ),
        serialization_alias="PARENT_NODE_LAYOUT",
    )
    previous: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    s: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    teapot_like: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("teapot_like", "TEAPOT_LIKE"),
        serialization_alias="TEAPOT_LIKE",
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    delta_rad_in: float = pydantic.Field(
        default=0.0,
    )
    delta_rad_out: float = pydantic.Field(
        default=0.0,
    )
    ds_ac: float = pydantic.Field(
        default=0.0,
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    exi: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    lf: CLatticeFunction = pydantic.Field(
        default=None,
    )
    lost: int = pydantic.Field(
        default=0,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    pos_in_fibre: int = pydantic.Field(
        default=0,
    )
    ref: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class InternalState_(pydantic.BaseModel):
    """
    InternalState_ corresponds to bmad `INTERNAL_STATE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 104.

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


class Kickt3(pydantic.BaseModel):
    """
    Kickt3 corresponds to bmad `KICKT3`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 66.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    b_sol : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    dx : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    dy : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    hf : float
        highly illegal additions by frs for fringe
        Bmad type: real
        Fortran default: null()
    ls : float
        Bmad type: real
        Fortran default: null()
    patch : bool
        highly illegal additions by frs
        Bmad type: logical
        Fortran default: null()
    pitch_x : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    pitch_y : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    thin_h_angle : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    thin_h_foc : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    thin_v_angle : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    thin_v_foc : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    vf : float
        highly illegal additions by frs for fringe
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    dx: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    dy: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    hf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs for fringe",
    )
    ls: float = pydantic.Field(
        default=0.0,
    )
    patch: bool = pydantic.Field(
        default=False,
        description="highly illegal additions by frs",
    )
    pitch_x: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    pitch_y: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
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
    vf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs for fringe",
    )


class Kickt3p(pydantic.BaseModel):
    """
    Kickt3p corresponds to bmad `KICKT3P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 77.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    b_sol : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    dx : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    dy : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    hf : Real8
        highly illegal additions by frs for fringe
        Bmad type: REAL_8
        Fortran default: null()
    ls : float
        Bmad type: real
        Fortran default: null()
    patch : bool
        highly illegal additions by frs
        Bmad type: logical
        Fortran default: null()
    pitch_x : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    pitch_y : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    thin_h_angle : Real8
        highly illegal additions by frs
        Bmad type: REAL_8
        Fortran default: null()
    thin_h_foc : Real8
        highly illegal additions by frs
        Bmad type: REAL_8
        Fortran default: null()
    thin_v_angle : Real8
        highly illegal additions by frs
        Bmad type: REAL_8
        Fortran default: null()
    thin_v_foc : Real8
        highly illegal additions by frs
        Bmad type: REAL_8
        Fortran default: null()
    vf : Real8
        highly illegal additions by frs for fringe
        Bmad type: REAL_8
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    b_sol: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    dx: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    dy: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    hf: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs for fringe",
    )
    ls: float = pydantic.Field(
        default=0.0,
    )
    patch: bool = pydantic.Field(
        default=False,
        description="highly illegal additions by frs",
    )
    pitch_x: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    pitch_y: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    thin_h_angle: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    thin_h_foc: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    thin_v_angle: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    thin_v_foc: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    vf: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs for fringe",
    )


class Ktk(pydantic.BaseModel):
    """
    Ktk corresponds to bmad `KTK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 200.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h1 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h2 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    matx : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    maty : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    vs : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    lx : float
        Bmad type: real
        Fortran default: null()
    ly : float
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    matx: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx", "MATX"),
        serialization_alias="MATX",
    )
    maty: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty", "MATY"),
        serialization_alias="MATY",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    lx: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ly: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Ktkp(pydantic.BaseModel):
    """
    Ktkp corresponds to bmad `KTKP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 212.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    matx : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    maty : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    lx : Real8
        Bmad type: REAL_8
        Fortran default: null()
    ly : Real8
        Bmad type: REAL_8
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    matx: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx", "MATX"),
        serialization_alias="MATX",
    )
    maty: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty", "MATY"),
        serialization_alias="MATY",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    lx: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    ly: Sequence[Real8] = pydantic.Field(
        default=None,
    )


class Layout(pydantic.BaseModel):
    """
    Layout corresponds to bmad `LAYOUT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 414.

    Attributes
    ----------
    closed : bool
        Bmad type: logical
        Fortran default: null()
    dna : LayoutArray
        Bmad type: layout_array
        Fortran default: null()
    end : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    end_ground : Fibre
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: FIBRE
        Fortran default: null()
    harmonic_number : float
        Bmad type: REAL
        Fortran default: null()
    index : int
        IDENTIFICATION, CHARGE SIGN
        Bmad type: INTEGER
        Fortran default: null()
    last : Fibre
        LAST VISITED
        Bmad type: FIBRE
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
        Fortran default: null()
    name : str
        IDENTIFICATION
        Bmad type: CHARACTER
        Fortran default: null()
    next : Layout
        Bmad type: LAYOUT
        Fortran default: null()
    nthin : int
        NUMBER IF THIN LENSES IN COLLECTION  (FOR SPEED ESTIMATES)
        Bmad type: INTEGER
        Fortran default: null()
    previous : Layout
        Bmad type: LAYOUT
        Fortran default: null()
    start : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    start_ground : Fibre
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: FIBRE
        Fortran default: null()
    t : NodeLayout
        ASSOCIATED  CHILD THIN LENS LAYOUT
        Bmad type: NODE_LAYOUT
        Fortran default: null()
    thin : float
        PARAMETER USED FOR AUTOMATIC CUTTING INTO THIN LENS
        Bmad type: REAL
        Fortran default: null()
    parent_universe : MadUniverse
        Bmad type: MAD_UNIVERSE
        Fortran default: null()
    """

    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    dna: Sequence[LayoutArray] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("dna", "DNA"),
        serialization_alias="DNA",
    )
    end: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    end_ground: Fibre = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )
    harmonic_number: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("harmonic_number", "HARMONIC_NUMBER"),
        serialization_alias="HARMONIC_NUMBER",
    )
    index: int = pydantic.Field(
        default=0,
        description="IDENTIFICATION, CHARGE SIGN",
        validation_alias=pydantic.AliasChoices("index", "INDEX"),
        serialization_alias="INDEX",
    )
    last: Fibre = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    next: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    nthin: int = pydantic.Field(
        default=0,
        description="NUMBER IF THIN LENSES IN COLLECTION  (FOR SPEED ESTIMATES)",
        validation_alias=pydantic.AliasChoices("nthin", "NTHIN"),
        serialization_alias="NTHIN",
    )
    previous: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    start: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )
    start_ground: Fibre = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("start_ground", "START_GROUND"),
        serialization_alias="START_GROUND",
    )
    t: NodeLayout = pydantic.Field(
        default=None,
        description="ASSOCIATED  CHILD THIN LENS LAYOUT",
        validation_alias=pydantic.AliasChoices("t", "T"),
        serialization_alias="T",
    )
    thin: float = pydantic.Field(
        default=0.0,
        description="PARAMETER USED FOR AUTOMATIC CUTTING INTO THIN LENS",
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    parent_universe: MadUniverse = pydantic.Field(
        default=None,
    )


class MadxAperture(pydantic.BaseModel):
    """
    MadxAperture corresponds to bmad `MADX_APERTURE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 151.

    Attributes
    ----------
    dx : float
        Bmad type: REAL
        Fortran default: null()
    dy : float
        Bmad type: REAL
        Fortran default: null()
    kind : int
        1,2,3,4
        Bmad type: INTEGER
        Fortran default: null()
    polygn : int
        arbitrary polygon number of points
        Bmad type: INTEGER
        Fortran default: null()
    polygx : float
        arbitrary polygon
        Bmad type: REAL
        Fortran default: null()
    polygy : float
        arbitrary polygon
        Bmad type: REAL
        Fortran default: null()
    r : float
        Bmad type: REAL
        Fortran default: null()
    x : float
        Bmad type: REAL
        Fortran default: null()
    y : float
        Bmad type: REAL
        Fortran default: null()
    pos : int
        Bmad type: integer
        Fortran default: null()
    """

    dx: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dx", "DX"),
        serialization_alias="DX",
    )
    dy: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dy", "DY"),
        serialization_alias="DY",
    )
    kind: int = pydantic.Field(
        default=0,
        description="1,2,3,4",
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    polygn: int = pydantic.Field(
        default=0,
        description="arbitrary polygon number of points",
        validation_alias=pydantic.AliasChoices("polygn", "POLYGN"),
        serialization_alias="POLYGN",
    )
    polygx: Sequence[float] = pydantic.Field(
        default=0.0,
        description="arbitrary polygon",
        validation_alias=pydantic.AliasChoices("polygx", "POLYGX"),
        serialization_alias="POLYGX",
    )
    polygy: Sequence[float] = pydantic.Field(
        default=0.0,
        description="arbitrary polygon",
        validation_alias=pydantic.AliasChoices("polygy", "POLYGY"),
        serialization_alias="POLYGY",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
    )
    x: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("x", "X"),
        serialization_alias="X",
    )
    y: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("y", "Y"),
        serialization_alias="Y",
    )
    pos: int = pydantic.Field(
        default=0,
    )


class MadUniverse(pydantic.BaseModel):
    """
    MadUniverse corresponds to bmad `MAD_UNIVERSE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 448.

    Attributes
    ----------
    end : Layout
        Bmad type: LAYOUT
        Fortran default: null()
    last : Fibre
        LAST VISITED
        Bmad type: FIBRE
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    n : int
        NUMBERS OF LAYOUT
        Bmad type: INTEGER
        Fortran default: null()
    nf : int
        number of fibres in tied layouts
        Bmad type: INTEGER
        Fortran default: null()
    shared : int
        NUMBERS OF REPOSITORY LAYOUTS
        Bmad type: INTEGER
        Fortran default: null()
    start : Layout
        Bmad type: LAYOUT
        Fortran default: null()
    """

    end: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    last: Fibre = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    n: int = pydantic.Field(
        default=0,
        description="NUMBERS OF LAYOUT",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    nf: int = pydantic.Field(
        default=0,
        description="number of fibres in tied layouts",
        validation_alias=pydantic.AliasChoices("nf", "NF"),
        serialization_alias="NF",
    )
    shared: int = pydantic.Field(
        default=0,
        description="NUMBERS OF REPOSITORY LAYOUTS",
        validation_alias=pydantic.AliasChoices("shared", "SHARED"),
        serialization_alias="SHARED",
    )
    start: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )


class MagnetChart(pydantic.BaseModel):
    """
    MagnetChart corresponds to bmad `MAGNET_CHART`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 165.

    Attributes
    ----------
    a : SAperture
        never used : different aperture at every node
        Bmad type: S_APERTURE
        Fortran default: null()
    aperture : MadxAperture
        apertures in Magnets
        Bmad type: MADX_APERTURE
        Fortran default: null()
    b0 : float
        arc length  and cord length
        Bmad type: real
        Fortran default: null()
    beta0 : float
        Bmad type: real
        Fortran default: null()
    edge : float
        INTERNAL FRAME  design entrance and exit angle
        Bmad type: real
        Fortran default: null()
    exact : bool
        small angle or not
        Bmad type: LOGICAL
        Fortran default: null()
    gambet : float
        Bmad type: real
        Fortran default: null()
    gamma0i : float
        Bmad type: real
        Fortran default: null()
    kill_ent_fringe : bool
        Bmad type: LOGICAL
        Fortran default: null()
    kill_ent_spin : bool
        Bmad type: LOGICAL
        Fortran default: null()
    kill_exi_fringe : bool
        Bmad type: LOGICAL
        Fortran default: null()
    kill_exi_spin : bool
        Bmad type: LOGICAL
        Fortran default: null()
    lc : float
        arc length  and cord length
        Bmad type: real
        Fortran default: null()
    ld : float
        arc length  and cord length
        Bmad type: real
        Fortran default: null()
    mass : float
        Bmad type: real
        Fortran default: null()
    method : int
        METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps
        Bmad type: INTEGER
        Fortran default: null()
    nmul : int
        NUMBER OF MULTIPOLE   ! nmul maximum multipole
        Bmad type: INTEGER
        Fortran default: null()
    nst : int
        METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps
        Bmad type: INTEGER
        Fortran default: null()
    p0c : float
        Bmad type: real
        Fortran default: null()
    tiltd : float
        INTERNAL FRAME design tilt
        Bmad type: real
        Fortran default: null()
    ag : float
        Bmad type: real
        Fortran default: null()
    bend_fringe : bool
        Bmad type: LOGICAL
        Fortran default: null()
    charge : float
        propagator
        Bmad type: real
        Fortran default: null()
    dir : int
        propagator
        Bmad type: integer
        Fortran default: null()
    f : MagnetFrame
        position magnets within the fibre (same as fibre if not misaligned)
        Bmad type: magnet_frame
        Fortran default: null()
    highest_fringe : int
        highest_fringe = 2 by default            !
        Bmad type: integer
        Fortran default: null()
    permfringe : int
        highest_fringe = 2 by default            !
        Bmad type: integer
        Fortran default: null()
    """

    a: Sequence[SAperture] = pydantic.Field(
        default=None,
        description="never used : different aperture at every node",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    aperture: MadxAperture = pydantic.Field(
        default=None,
        description="apertures in Magnets",
        validation_alias=pydantic.AliasChoices("aperture", "APERTURE"),
        serialization_alias="APERTURE",
    )
    b0: float = pydantic.Field(
        default=0.0,
        description="arc length  and cord length",
        validation_alias=pydantic.AliasChoices("b0", "B0"),
        serialization_alias="B0",
    )
    beta0: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("beta0", "BETA0"),
        serialization_alias="BETA0",
    )
    edge: Sequence[float] = pydantic.Field(
        default=0.0,
        description="INTERNAL FRAME  design entrance and exit angle",
        validation_alias=pydantic.AliasChoices("edge", "EDGE"),
        serialization_alias="EDGE",
    )
    exact: bool = pydantic.Field(
        default=False,
        description="small angle or not",
        validation_alias=pydantic.AliasChoices("exact", "EXACT"),
        serialization_alias="EXACT",
    )
    gambet: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("gambet", "GAMBET"),
        serialization_alias="GAMBET",
    )
    gamma0i: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("gamma0i", "GAMMA0I"),
        serialization_alias="GAMMA0I",
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
    lc: float = pydantic.Field(
        default=0.0,
        description="arc length  and cord length",
        validation_alias=pydantic.AliasChoices("lc", "LC"),
        serialization_alias="LC",
    )
    ld: float = pydantic.Field(
        default=0.0,
        description="arc length  and cord length",
        validation_alias=pydantic.AliasChoices("ld", "LD"),
        serialization_alias="LD",
    )
    mass: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("mass", "MASS"),
        serialization_alias="MASS",
    )
    method: int = pydantic.Field(
        default=0,
        description="METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps",
        validation_alias=pydantic.AliasChoices("method", "METHOD"),
        serialization_alias="METHOD",
    )
    nmul: int = pydantic.Field(
        default=0,
        description="NUMBER OF MULTIPOLE   ! nmul maximum multipole",
        validation_alias=pydantic.AliasChoices("nmul", "NMUL"),
        serialization_alias="NMUL",
    )
    nst: int = pydantic.Field(
        default=0,
        description="METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps",
        validation_alias=pydantic.AliasChoices("nst", "NST"),
        serialization_alias="NST",
    )
    p0c: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("p0c", "P0C"),
        serialization_alias="P0C",
    )
    tiltd: float = pydantic.Field(
        default=0.0,
        description="INTERNAL FRAME design tilt",
        validation_alias=pydantic.AliasChoices("tiltd", "TILTD"),
        serialization_alias="TILTD",
    )
    ag: float = pydantic.Field(
        default=0.0,
    )
    bend_fringe: bool = pydantic.Field(
        default=False,
    )
    charge: float = pydantic.Field(
        default=0.0,
        description="propagator",
    )
    dir: int = pydantic.Field(
        default=0,
        description="propagator",
    )
    f: MagnetFrame = pydantic.Field(
        default=None,
        description="position magnets within the fibre (same as fibre if not misaligned)",
    )
    highest_fringe: int = pydantic.Field(
        default=0,
        description="highest_fringe = 2 by default            !",
    )
    permfringe: int = pydantic.Field(
        default=0,
        description="highest_fringe = 2 by default            !",
        validation_alias=pydantic.AliasChoices("permfringe", "permFRINGE"),
        serialization_alias="permFRINGE",
    )


class MagnetFrame(pydantic.BaseModel):
    """
    MagnetFrame corresponds to bmad `MAGNET_FRAME`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 14.

    Attributes
    ----------
    a : float
        Bmad type: REAL
        Fortran default: null()
    b : float
        Bmad type: REAL
        Fortran default: null()
    ent : float
        Bmad type: REAL
        Fortran default: null()
    exi : float
        Bmad type: REAL
        Fortran default: null()
    mid : float
        Bmad type: REAL
        Fortran default: null()
    o : float
        Bmad type: REAL
        Fortran default: null()
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ent", "ENT"),
        serialization_alias="ENT",
    )
    exi: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("exi", "EXI"),
        serialization_alias="EXI",
    )
    mid: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("mid", "MID"),
        serialization_alias="MID",
    )
    o: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("o", "O"),
        serialization_alias="O",
    )


class Mon(pydantic.BaseModel):
    """
    Mon corresponds to bmad `MON`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 317.

    Attributes
    ----------
    L : float
        monitor and instrument of MAD
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    x : float
        Bmad type: real
        Fortran default: null()
    y : float
        Bmad type: real
        Fortran default: null()
    """

    L: float = pydantic.Field(
        default=0.0,
        description="monitor and instrument of MAD",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    x: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )


class Monp(pydantic.BaseModel):
    """
    Monp corresponds to bmad `MONP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 323.

    Attributes
    ----------
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    x : float
        Bmad type: real
        Fortran default: null()
    y : float
        Bmad type: real
        Fortran default: null()
    """

    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    x: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )


class MulBlock(pydantic.BaseModel):
    """
    MulBlock corresponds to bmad `MUL_BLOCK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 90.

    Attributes
    ----------
    add : int
        Bmad type: INTEGER
    an : float
        Bmad type: real
    bn : float
        Bmad type: real
    natural : int
        Bmad type: INTEGER
    nmul : int
        Bmad type: INTEGER
    """

    add: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("add", "ADD"),
        serialization_alias="ADD",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    natural: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("natural", "NATURAL"),
        serialization_alias="NATURAL",
    )
    nmul: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nmul", "NMUL"),
        serialization_alias="NMUL",
    )


class NodeLayout(pydantic.BaseModel):
    """
    NodeLayout corresponds to bmad `NODE_LAYOUT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 465.

    Attributes
    ----------
    closed : bool
        Bmad type: logical
        Fortran default: null()
    end : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    end_ground : IntegrationNode
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    index : int
        IDENTIFICATION
        Bmad type: INTEGER
        Fortran default: null()
    last : IntegrationNode
        LAST VISITED
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
        Fortran default: null()
    name : str
        IDENTIFICATION
        Bmad type: CHARACTER
        Fortran default: null()
    orbit_lattice : OrbitLattice
        Bmad type: ORBIT_LATTICE
        Fortran default: null()
    parent_layout : Layout
        Bmad type: LAYOUT
        Fortran default: null()
    start : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    start_ground : IntegrationNode
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    """

    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    end: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    end_ground: IntegrationNode = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )
    index: int = pydantic.Field(
        default=0,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("index", "INDEX"),
        serialization_alias="INDEX",
    )
    last: IntegrationNode = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    orbit_lattice: OrbitLattice = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("orbit_lattice", "ORBIT_LATTICE"),
        serialization_alias="ORBIT_LATTICE",
    )
    parent_layout: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_layout", "PARENT_LAYOUT"),
        serialization_alias="PARENT_LAYOUT",
    )
    start: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )
    start_ground: IntegrationNode = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("start_ground", "START_GROUND"),
        serialization_alias="START_GROUND",
    )


class Nsmi(pydantic.BaseModel):
    """
    Nsmi corresponds to bmad `NSMI`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 262.

    Attributes
    ----------
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Nsmip(pydantic.BaseModel):
    """
    Nsmip corresponds to bmad `NSMIP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 267.

    Attributes
    ----------
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
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


class OrbitLattice(pydantic.BaseModel):
    """
    OrbitLattice corresponds to bmad `ORBIT_LATTICE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 491.

    Attributes
    ----------
    orbit_beta0 : float
        GET_BETA0
        Bmad type: REAL
        Fortran default: null()
    orbit_charge : float
        GET_CHARGE
        Bmad type: real
        Fortran default: null()
    orbit_l : float
        GET_CIRCUMFERENCE
        Bmad type: REAL
        Fortran default: null()
    orbit_lmax : float
        GET_LMAX
        Bmad type: REAL
        Fortran default: null()
    orbit_max_patch_tz : float
        Bmad type: REAL
        Fortran default: null()
    orbit_nodes : OrbitNode
        Bmad type: ORBIT_NODE
        Fortran default: null()
    orbit_n_node : int
        GET_N_NODE
        Bmad type: INTEGER
        Fortran default: null()
    orbit_omega : float
        GET_omega
        Bmad type: REAL
        Fortran default: null()
    orbit_omega_after : float
        Bmad type: REAL
        Fortran default: null()
    orbit_p0c : float
        GET_P0C
        Bmad type: REAL
        Fortran default: null()
    orbit_use_orbit_units : bool
        Bmad type: LOGICAL
        Fortran default: null()
    orbit_warning : int
        Bmad type: INTEGER
        Fortran default: null()
    orbit_gammat : float
        GET_GAMMAT
        Bmad type: REAL
        Fortran default: null()
    orbit_harmonic : float
        GET_HARMONIC
        Bmad type: REAL
        Fortran default: null()
    orbit_mass_in_amu : float
        GET_MASS_AMU
        Bmad type: REAL
        Fortran default: null()
    state : InternalState
        Bmad type: INTERNAL_STATE
        Fortran default: null()
    accel : bool
        Bmad type: LOGICAL
        Fortran default: null()
    dt : float
        Bmad type: real
        Fortran default: null()
    orbit_brho : float
        GET_brho
        Bmad type: REAL
        Fortran default: null()
    orbit_deltae : float
        GET_deltae
        Bmad type: REAL
        Fortran default: null()
    orbit_energy : float
        GET_total_energy
        Bmad type: REAL
        Fortran default: null()
    orbit_gamma : float
        GET_gamma
        Bmad type: REAL
        Fortran default: null()
    orbit_kinetic : float
        GET_kinetic
        Bmad type: REAL
        Fortran default: null()
    parent_layout : Layout
        Bmad type: layout
        Fortran default: null()
    tp : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    """

    orbit_beta0: float = pydantic.Field(
        default=0.0,
        description="GET_BETA0",
        validation_alias=pydantic.AliasChoices("orbit_beta0", "ORBIT_BETA0"),
        serialization_alias="ORBIT_BETA0",
    )
    orbit_charge: float = pydantic.Field(
        default=0.0,
        description="GET_CHARGE",
        validation_alias=pydantic.AliasChoices("orbit_charge", "ORBIT_CHARGE"),
        serialization_alias="ORBIT_CHARGE",
    )
    orbit_l: float = pydantic.Field(
        default=0.0,
        description="GET_CIRCUMFERENCE",
        validation_alias=pydantic.AliasChoices("orbit_l", "ORBIT_L"),
        serialization_alias="ORBIT_L",
    )
    orbit_lmax: float = pydantic.Field(
        default=0.0,
        description="GET_LMAX",
        validation_alias=pydantic.AliasChoices("orbit_lmax", "ORBIT_LMAX"),
        serialization_alias="ORBIT_LMAX",
    )
    orbit_max_patch_tz: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices(
            "orbit_max_patch_tz", "ORBIT_MAX_PATCH_TZ"
        ),
        serialization_alias="ORBIT_MAX_PATCH_TZ",
    )
    orbit_nodes: Sequence[OrbitNode] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("orbit_nodes", "ORBIT_NODES"),
        serialization_alias="ORBIT_NODES",
    )
    orbit_n_node: int = pydantic.Field(
        default=0,
        description="GET_N_NODE",
        validation_alias=pydantic.AliasChoices("orbit_n_node", "ORBIT_N_NODE"),
        serialization_alias="ORBIT_N_NODE",
    )
    orbit_omega: float = pydantic.Field(
        default=0.0,
        description="GET_omega",
        validation_alias=pydantic.AliasChoices("orbit_omega", "ORBIT_OMEGA"),
        serialization_alias="ORBIT_OMEGA",
    )
    orbit_omega_after: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices(
            "orbit_omega_after", "ORBIT_OMEGA_after"
        ),
        serialization_alias="ORBIT_OMEGA_after",
    )
    orbit_p0c: float = pydantic.Field(
        default=0.0,
        description="GET_P0C",
        validation_alias=pydantic.AliasChoices("orbit_p0c", "ORBIT_P0C"),
        serialization_alias="ORBIT_P0C",
    )
    orbit_use_orbit_units: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices(
            "orbit_use_orbit_units", "ORBIT_USE_ORBIT_UNITS"
        ),
        serialization_alias="ORBIT_USE_ORBIT_UNITS",
    )
    orbit_warning: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("orbit_warning", "ORBIT_WARNING"),
        serialization_alias="ORBIT_WARNING",
    )
    orbit_gammat: float = pydantic.Field(
        default=0.0,
        description="GET_GAMMAT",
        validation_alias=pydantic.AliasChoices("orbit_gammat", "ORBIT_gammat"),
        serialization_alias="ORBIT_gammat",
    )
    orbit_harmonic: float = pydantic.Field(
        default=0.0,
        description="GET_HARMONIC",
        validation_alias=pydantic.AliasChoices("orbit_harmonic", "ORBIT_harmonic"),
        serialization_alias="ORBIT_harmonic",
    )
    orbit_mass_in_amu: float = pydantic.Field(
        default=0.0,
        description="GET_MASS_AMU",
        validation_alias=pydantic.AliasChoices(
            "orbit_mass_in_amu", "ORBIT_mass_in_amu"
        ),
        serialization_alias="ORBIT_mass_in_amu",
    )
    state: InternalState = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("state", "STATE"),
        serialization_alias="STATE",
    )
    accel: bool = pydantic.Field(
        default=False,
    )
    dt: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    orbit_brho: float = pydantic.Field(
        default=0.0,
        description="GET_brho",
    )
    orbit_deltae: float = pydantic.Field(
        default=0.0,
        description="GET_deltae",
    )
    orbit_energy: float = pydantic.Field(
        default=0.0,
        description="GET_total_energy",
    )
    orbit_gamma: float = pydantic.Field(
        default=0.0,
        description="GET_gamma",
    )
    orbit_kinetic: float = pydantic.Field(
        default=0.0,
        description="GET_kinetic",
    )
    parent_layout: Layout = pydantic.Field(
        default=None,
    )
    tp: IntegrationNode = pydantic.Field(
        default=None,
    )


class OrbitNode(pydantic.BaseModel):
    """
    OrbitNode corresponds to bmad `ORBIT_NODE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 482.

    Attributes
    ----------
    dpos : int
        Bmad type: integer
        Fortran default: null()
    entering_task : int
        Bmad type: integer
        Fortran default: null()
    lattice : float
        Bmad type: REAL
        Fortran default: null()
    node : IntegrationNode
        Bmad type: INTEGRATION_NODE
        Fortran default: null()
    ptc_task : int
        Bmad type: integer
        Fortran default: null()
    cavity : bool
        Bmad type: logical
        Fortran default: null()
    """

    dpos: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("dpos", "DPOS"),
        serialization_alias="DPOS",
    )
    entering_task: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("entering_task", "ENTERING_TASK"),
        serialization_alias="ENTERING_TASK",
    )
    lattice: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("lattice", "LATTICE"),
        serialization_alias="LATTICE",
    )
    node: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("node", "NODE"),
        serialization_alias="NODE",
    )
    ptc_task: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ptc_task", "PTC_TASK"),
        serialization_alias="PTC_TASK",
    )
    cavity: bool = pydantic.Field(
        default=False,
    )


class Pancake(pydantic.BaseModel):
    """
    Pancake corresponds to bmad `PANCAKE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 424.

    Attributes
    ----------
    b : TreeElement
        Bmad type: tree_element
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    scale : float
        Bmad type: REAL
        Fortran default: null()
    angc : float
        Bmad type: REAL
        Fortran default: null()
    dc : float
        Bmad type: REAL
        Fortran default: null()
    hc : float
        Bmad type: REAL
        Fortran default: null()
    vc : float
        Bmad type: REAL
        Fortran default: null()
    xc : float
        Bmad type: REAL
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    b: Sequence[TreeElement] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    scale: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("scale", "SCALE"),
        serialization_alias="SCALE",
    )
    angc: float = pydantic.Field(
        default=0.0,
    )
    dc: float = pydantic.Field(
        default=0.0,
    )
    hc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
        default=0.0,
    )
    xc: float = pydantic.Field(
        default=0.0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class Pancakep(pydantic.BaseModel):
    """
    Pancakep corresponds to bmad `PANCAKEP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 433.

    Attributes
    ----------
    b : TreeElement
        Bmad type: tree_element
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    scale : Real8
        Bmad type: REAL_8
        Fortran default: null()
    angc : float
        Bmad type: real
        Fortran default: null()
    dc : float
        Bmad type: real
        Fortran default: null()
    hc : float
        Bmad type: real
        Fortran default: null()
    vc : float
        Bmad type: real
        Fortran default: null()
    xc : float
        Bmad type: real
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    b: Sequence[TreeElement] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    scale: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("scale", "SCALE"),
        serialization_alias="SCALE",
    )
    angc: float = pydantic.Field(
        default=0.0,
    )
    dc: float = pydantic.Field(
        default=0.0,
    )
    hc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
        default=0.0,
    )
    xc: float = pydantic.Field(
        default=0.0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class Patch(pydantic.BaseModel):
    """
    Patch corresponds to bmad `PATCH`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 23.

    Attributes
    ----------
    a_ang : float
        ENTRACE AND EXIT ROTATIONS    A_ANG(3)
        Bmad type: REAL
        Fortran default: null()
    a_d : float
        ENTRACE AND EXIT TRANSLATIONS  A_D(3)
        Bmad type: REAL
        Fortran default: null()
    a_l : float
        Bmad type: REAL
        Fortran default: null()
    a_t : float
        TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED
        Bmad type: REAL
        Fortran default: null()
    a_x1 : int
        FOR ROTATION OF PI AT ENTRANCE = -1, DEFAULT = 1 ,
        Bmad type: INTEGER
        Fortran default: null()
    a_x2 : int
        FOR ROTATION OF PI AT ENTRANCE = -1, DEFAULT = 1 ,
        Bmad type: INTEGER
        Fortran default: null()
    b_ang : float
        ENTRACE AND EXIT ROTATIONS    A_ANG(3)
        Bmad type: REAL
        Fortran default: null()
    b_d : float
        ENTRACE AND EXIT TRANSLATIONS  A_D(3)
        Bmad type: REAL
        Fortran default: null()
    b_l : float
        Bmad type: REAL
        Fortran default: null()
    b_t : float
        TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED
        Bmad type: REAL
        Fortran default: null()
    b_x1 : int
        FOR ROTATION OF PI AT EXIT = -1    , DEFAULT = 1
        Bmad type: INTEGER
        Fortran default: null()
    b_x2 : int
        FOR ROTATION OF PI AT EXIT = -1    , DEFAULT = 1
        Bmad type: INTEGER
        Fortran default: null()
    energy : int
        IF TRUE, ENERGY PATCHES NEEDED
        Bmad type: INTEGER
        Fortran default: null()
    patch : int
        IF TRUE, SPACIAL PATCHES NEEDED
        Bmad type: INTEGER
        Fortran default: null()
    time : int
        IF TRUE, TIME PATCHES NEEDED
        Bmad type: INTEGER
        Fortran default: null()
    b0b : float
        for bmad patching
        Bmad type: REAL
        Fortran default: null()
    p0b : float
        for bmad patching
        Bmad type: REAL
        Fortran default: null()
    track : bool
        Bmad type: logical
        Fortran default: null()
    """

    a_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT ROTATIONS    A_ANG(3)",
        validation_alias=pydantic.AliasChoices("a_ang", "A_ANG"),
        serialization_alias="A_ANG",
    )
    a_d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT TRANSLATIONS  A_D(3)",
        validation_alias=pydantic.AliasChoices("a_d", "A_D"),
        serialization_alias="A_D",
    )
    a_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a_l", "A_L"),
        serialization_alias="A_L",
    )
    a_t: float = pydantic.Field(
        default=0.0,
        description="TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED",
        validation_alias=pydantic.AliasChoices("a_t", "A_T"),
        serialization_alias="A_T",
    )
    a_x1: int = pydantic.Field(
        default=0,
        description="FOR ROTATION OF PI AT ENTRANCE = -1, DEFAULT = 1 ,",
        validation_alias=pydantic.AliasChoices("a_x1", "A_X1"),
        serialization_alias="A_X1",
    )
    a_x2: int = pydantic.Field(
        default=0,
        description="FOR ROTATION OF PI AT ENTRANCE = -1, DEFAULT = 1 ,",
        validation_alias=pydantic.AliasChoices("a_x2", "A_X2"),
        serialization_alias="A_X2",
    )
    b_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT ROTATIONS    A_ANG(3)",
        validation_alias=pydantic.AliasChoices("b_ang", "B_ANG"),
        serialization_alias="B_ANG",
    )
    b_d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT TRANSLATIONS  A_D(3)",
        validation_alias=pydantic.AliasChoices("b_d", "B_D"),
        serialization_alias="B_D",
    )
    b_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_l", "B_L"),
        serialization_alias="B_L",
    )
    b_t: float = pydantic.Field(
        default=0.0,
        description="TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED",
        validation_alias=pydantic.AliasChoices("b_t", "B_T"),
        serialization_alias="B_T",
    )
    b_x1: int = pydantic.Field(
        default=0,
        description="FOR ROTATION OF PI AT EXIT = -1    , DEFAULT = 1",
        validation_alias=pydantic.AliasChoices("b_x1", "B_X1"),
        serialization_alias="B_X1",
    )
    b_x2: int = pydantic.Field(
        default=0,
        description="FOR ROTATION OF PI AT EXIT = -1    , DEFAULT = 1",
        validation_alias=pydantic.AliasChoices("b_x2", "B_X2"),
        serialization_alias="B_X2",
    )
    energy: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="IF TRUE, ENERGY PATCHES NEEDED",
        validation_alias=pydantic.AliasChoices("energy", "ENERGY"),
        serialization_alias="ENERGY",
    )
    patch: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="IF TRUE, SPACIAL PATCHES NEEDED",
        validation_alias=pydantic.AliasChoices("patch", "PATCH"),
        serialization_alias="PATCH",
    )
    time: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="IF TRUE, TIME PATCHES NEEDED",
        validation_alias=pydantic.AliasChoices("time", "TIME"),
        serialization_alias="TIME",
    )
    b0b: float = pydantic.Field(
        default=0.0,
        description="for bmad patching",
    )
    p0b: float = pydantic.Field(
        default=0.0,
        description="for bmad patching",
    )
    track: bool = pydantic.Field(
        default=False,
    )


class PolBlock(pydantic.BaseModel):
    """
    PolBlock corresponds to bmad `POL_BLOCK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 123.

    Attributes
    ----------
    ian : int
        Bmad type: INTEGER
    ibn : int
        Bmad type: INTEGER
    ib_sol : int
        Bmad type: INTEGER
    ifreq : int
        Bmad type: INTEGER
    iphas : int
        Bmad type: INTEGER
    ivolt : int
        Bmad type: INTEGER
    name : str
        Bmad type: CHARACTER
    npara : int
        Bmad type: INTEGER
    san : float
        Bmad type: real
    sbn : float
        Bmad type: real
    sb_sol : float
        Bmad type: real
    set_element : bool
        Bmad type: LOGICAL
        Fortran default: null()
    set_tpsafit : bool
        Bmad type: LOGICAL
        Fortran default: null()
    sfreq : float
        Bmad type: real
    sphas : float
        Bmad type: real
    svolt : float
        Bmad type: real
    tpsafit : float
        Bmad type: real
        Fortran default: null()
    vorname : str
        Bmad type: CHARACTER
    g : int
        group index  number of blocks
        Bmad type: integer
    n_name : int
        Bmad type: integer
    nb : int
        group index  number of blocks
        Bmad type: integer
    np : int
        group index  number of blocks
        Bmad type: integer
    sagan : PolBlockSagan
        Bmad type: POL_BLOCK_sagan
    """

    ian: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ian", "IAN"),
        serialization_alias="IAN",
    )
    ibn: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ibn", "IBN"),
        serialization_alias="IBN",
    )
    ib_sol: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ib_sol", "IB_SOL"),
        serialization_alias="IB_SOL",
    )
    ifreq: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ifreq", "IFREQ"),
        serialization_alias="IFREQ",
    )
    iphas: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("iphas", "IPHAS"),
        serialization_alias="IPHAS",
    )
    ivolt: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ivolt", "IVOLT"),
        serialization_alias="IVOLT",
    )
    name: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    npara: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("npara", "NPARA"),
        serialization_alias="NPARA",
    )
    san: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("san", "SAN"),
        serialization_alias="SAN",
    )
    sbn: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sbn", "SBN"),
        serialization_alias="SBN",
    )
    sb_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sb_sol", "SB_SOL"),
        serialization_alias="SB_SOL",
    )
    set_element: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("set_element", "SET_ELEMENT"),
        serialization_alias="SET_ELEMENT",
    )
    set_tpsafit: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("set_tpsafit", "SET_TPSAFIT"),
        serialization_alias="SET_TPSAFIT",
    )
    sfreq: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sfreq", "SFREQ"),
        serialization_alias="SFREQ",
    )
    sphas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sphas", "SPHAS"),
        serialization_alias="SPHAS",
    )
    svolt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("svolt", "SVOLT"),
        serialization_alias="SVOLT",
    )
    tpsafit: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tpsafit", "TPSAFIT"),
        serialization_alias="TPSAFIT",
    )
    vorname: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    g: int = pydantic.Field(
        default=0,
        description="group index  number of blocks",
    )
    n_name: int = pydantic.Field(
        default=0,
    )
    nb: int = pydantic.Field(
        default=0,
        description="group index  number of blocks",
    )
    np: int = pydantic.Field(
        default=0,
        description="group index  number of blocks",
    )
    sagan: PolBlockSagan = pydantic.Field(
        default=None,
    )


class PolBlockInicond(pydantic.BaseModel):
    """
    PolBlockInicond corresponds to bmad `POL_BLOCK_INICOND`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 144.

    Attributes
    ----------
    alfa : int
        Bmad type: INTEGER
    beta : int
        Bmad type: INTEGER
    dispersion : int
        Bmad type: INTEGER
    """

    alfa: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("alfa", "ALFA"),
        serialization_alias="ALFA",
    )
    beta: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("beta", "BETA"),
        serialization_alias="BETA",
    )
    dispersion: Sequence[int] = pydantic.Field(
        default=0,
        max_length=4,
        validation_alias=pydantic.AliasChoices("dispersion", "DISPERSION"),
        serialization_alias="DISPERSION",
    )


class PolBlockSagan(pydantic.BaseModel):
    """
    PolBlockSagan corresponds to bmad `POL_BLOCK_sagan`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 10.

    Attributes
    ----------
    iinternal : int
        Bmad type: INTEGER
    sinternal : float
        Bmad type: real
    w : PolSagan
        Bmad type: POL_sagan
    """

    iinternal: Sequence[int] = pydantic.Field(
        default=0,
        max_length=6,
        validation_alias=pydantic.AliasChoices("iinternal", "Iinternal"),
        serialization_alias="Iinternal",
    )
    sinternal: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        validation_alias=pydantic.AliasChoices("sinternal", "SInternal"),
        serialization_alias="SInternal",
    )
    w: PolSagan = pydantic.Field(
        default=None,
    )


class PolSagan(pydantic.BaseModel):
    """
    PolSagan corresponds to bmad `POL_sagan`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 4.

    Attributes
    ----------
    sa : float
        Bmad type: real
    ia : int
        Bmad type: INTEGER
    """

    sa: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sa", "Sa"),
        serialization_alias="Sa",
    )
    ia: Sequence[int] = pydantic.Field(
        default=0,
    )


class Rcol(pydantic.BaseModel):
    """
    Rcol corresponds to bmad `RCOL`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 329.

    Attributes
    ----------
    L : float
        collimator of MAD
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    L: float = pydantic.Field(
        default=0.0,
        description="collimator of MAD",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Rcolp(pydantic.BaseModel):
    """
    Rcolp corresponds to bmad `RCOLP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 335.

    Attributes
    ----------
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Real8(pydantic.BaseModel):
    """
    Real8 corresponds to bmad `REAL_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 114.

    Attributes
    ----------
    alloc : bool
        @1 IF TAYLOR IS ALLOCATED IN DA-PACKAGE
        Bmad type: LOGICAL
    i : int
        @1   USED FOR KNOBS AND SPECIAL KIND=0
        Bmad type: INTEGER
    kind : int
        @1  0,1,2,3 (1=REAL,2=TAYLOR,3=TAYLOR KNOB, 0=SPECIAL)
        Bmad type: INTEGER
    r : float
        @1    USED IF REAL
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
        description="@1 IF TAYLOR IS ALLOCATED IN DA-PACKAGE",
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
        description="@1    USED IF REAL",
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


class Sagan(pydantic.BaseModel):
    """
    Sagan corresponds to bmad `SAGAN`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 52.

    Attributes
    ----------
    an : float
        Multipole component (OPTIONAL)
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component (OPTIONAL)
        Bmad type: real
        Fortran default: null()
    internal : float
        INTERNAL IS AN EXAMPLE
        Bmad type: real
        Fortran default: null()
    L : float
        MUST ALWAYS BE THERE
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    w : UnduR
        Bmad type: undu_R
        Fortran default: null()
    n_min : int
        Bmad type: integer
        Fortran default: null()
    xprime : bool
        Bmad type: LOGICAL
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component (OPTIONAL)",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component (OPTIONAL)",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    internal: Sequence[float] = pydantic.Field(
        default=0.0,
        description="INTERNAL IS AN EXAMPLE",
        validation_alias=pydantic.AliasChoices("internal", "INTERNAL"),
        serialization_alias="INTERNAL",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="MUST ALWAYS BE THERE",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    w: UnduR = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("w", "W"),
        serialization_alias="W",
    )
    n_min: int = pydantic.Field(
        default=0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class Saganp(pydantic.BaseModel):
    """
    Saganp corresponds to bmad `SAGANP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 63.

    Attributes
    ----------
    an : Real8
        Multipole component (OPTIONAL)
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component (OPTIONAL)
        Bmad type: REAL_8
        Fortran default: null()
    internal : Real8
        INTERNAL IS AN EXAMPLE
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        MUST ALWAYS BE THERE
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    w : UnduP
        Bmad type: undu_p
        Fortran default: null()
    n_min : int
        Bmad type: integer
        Fortran default: null()
    xprime : bool
        Bmad type: LOGICAL
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component (OPTIONAL)",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component (OPTIONAL)",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    internal: Sequence[Real8] = pydantic.Field(
        default=None,
        description="INTERNAL IS AN EXAMPLE",
        validation_alias=pydantic.AliasChoices("internal", "INTERNAL"),
        serialization_alias="INTERNAL",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="MUST ALWAYS BE THERE",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    w: UnduP = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("w", "W"),
        serialization_alias="W",
    )
    n_min: int = pydantic.Field(
        default=0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class Sol5(pydantic.BaseModel):
    """
    Sol5 corresponds to bmad `SOL5`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 177.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    b_sol : float
        Bmad type: real
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h1 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h2 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : float
        sad f1,f2
        Bmad type: real
        Fortran default: null()
    vs : float
        sad f1,f2
        Bmad type: real
        Fortran default: null()
    dx : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    dy : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    pitch_x : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    pitch_y : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: float = pydantic.Field(
        default=0.0,
        description="sad f1,f2",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="sad f1,f2",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    dx: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    dy: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    pitch_x: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    pitch_y: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )


class Sol5p(pydantic.BaseModel):
    """
    Sol5p corresponds to bmad `SOL5P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 188.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    b_sol : Real8
        Bmad type: REAL_8
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    dx : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    dy : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    pitch_x : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    pitch_y : float
        SADISTIC
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    b_sol: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    dx: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    dy: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    pitch_x: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )
    pitch_y: float = pydantic.Field(
        default=0.0,
        description="SADISTIC",
    )


class Ssmi(pydantic.BaseModel):
    """
    Ssmi corresponds to bmad `SSMI`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 272.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Ssmip(pydantic.BaseModel):
    """
    Ssmip corresponds to bmad `SSMIP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 277.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )


class Strex(pydantic.BaseModel):
    """
    Strex corresponds to bmad `STREX`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 367.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    driftkick : bool
        , LIKEMAD => null()
        Bmad type: logical
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h1 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h2 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    vs : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    driftkick: bool = pydantic.Field(
        default=False,
        description=", LIKEMAD => null()",
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    f: int = pydantic.Field(
        default=0,
    )


class Strexp(pydantic.BaseModel):
    """
    Strexp corresponds to bmad `STREXP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 378.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    driftkick : bool
        , LIKEMAD => null()
        Bmad type: logical
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    driftkick: bool = pydantic.Field(
        default=False,
        description=", LIKEMAD => null()",
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    va: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    f: int = pydantic.Field(
        default=0,
    )


class Superdrift(pydantic.BaseModel):
    """
    Superdrift corresponds to bmad `SUPERDRIFT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 32.

    Attributes
    ----------
    a_x1 : int
        Bmad type: INTEGER
        Fortran default: null()
    a_x2 : int
        Bmad type: INTEGER
        Fortran default: null()
    d : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    ang : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    """

    a_x1: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("a_x1", "A_X1"),
        serialization_alias="A_X1",
    )
    a_x2: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("a_x2", "A_X2"),
        serialization_alias="A_X2",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
    )


class Superdriftp(pydantic.BaseModel):
    """
    Superdriftp corresponds to bmad `SUPERDRIFTP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 39.

    Attributes
    ----------
    a_x1 : int
        Bmad type: INTEGER
        Fortran default: null()
    a_x2 : int
        Bmad type: INTEGER
        Fortran default: null()
    d : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    ang : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    """

    a_x1: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("a_x1", "A_X1"),
        serialization_alias="A_X1",
    )
    a_x2: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("a_x2", "A_X2"),
        serialization_alias="A_X2",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
    )


class SAperture(pydantic.BaseModel):
    """
    SAperture corresponds to bmad `S_APERTURE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 160.

    Attributes
    ----------
    aperture : MadxAperture
        Bmad type: MADX_APERTURE
        Fortran default: null()
    """

    aperture: MadxAperture = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("aperture", "APERTURE"),
        serialization_alias="APERTURE",
    )


class Teapot(pydantic.BaseModel):
    """
    Teapot corresponds to bmad `TEAPOT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 283.

    Attributes
    ----------
    ae : float
        an,bn for electric stuff
        Bmad type: real
        Fortran default: null()
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    be : float
        an,bn for electric stuff
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    driftkick : bool
        Split flag
        Bmad type: logical
        Fortran default: null()
    electric : bool
        Bmad type: LOGICAL
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h1 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h2 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phi : float
        Bmad type: real
        Fortran default: null()
    va : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    vs : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    b_sol : float
        Bmad type: real
        Fortran default: null()
    bf_x : float
        B field polynomial
        Bmad type: real
        Fortran default: null()
    bf_y : float
        B field polynomial
        Bmad type: real
        Fortran default: null()
    e_x : float
        Bmad type: real
        Fortran default: null()
    e_y : float
        Bmad type: real
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    vm : float
        Bmad type: real
        Fortran default: null()
    """

    ae: Sequence[float] = pydantic.Field(
        default=0.0,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    be: Sequence[float] = pydantic.Field(
        default=0.0,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("be", "BE"),
        serialization_alias="BE",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    driftkick: bool = pydantic.Field(
        default=False,
        description="Split flag",
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    electric: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("electric", "ELECTRIC"),
        serialization_alias="ELECTRIC",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phi: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phi", "PHI"),
        serialization_alias="PHI",
    )
    va: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    b_sol: float = pydantic.Field(
        default=0.0,
    )
    bf_x: Sequence[float] = pydantic.Field(
        default=0.0,
        description="B field polynomial",
    )
    bf_y: Sequence[float] = pydantic.Field(
        default=0.0,
        description="B field polynomial",
    )
    e_x: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    e_y: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    f: int = pydantic.Field(
        default=0,
    )
    vm: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Teapotp(pydantic.BaseModel):
    """
    Teapotp corresponds to bmad `TEAPOTP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 300.

    Attributes
    ----------
    ae : Real8
        an,bn for electric stuff
        Bmad type: REAL_8
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    be : Real8
        an,bn for electric stuff
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    driftkick : bool
        Bmad type: logical
        Fortran default: null()
    electric : bool
        Bmad type: LOGICAL
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    phi : Real8
        Bmad type: REAL_8
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    b_sol : Real8
        Bmad type: REAL_8
        Fortran default: null()
    bf_x : Real8
        B field polynomial
        Bmad type: REAL_8
        Fortran default: null()
    bf_y : Real8
        B field polynomial
        Bmad type: REAL_8
        Fortran default: null()
    e_x : Real8
        Bmad type: REAL_8
        Fortran default: null()
    e_y : Real8
        Bmad type: REAL_8
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    vm : Real8
        Bmad type: REAL_8
        Fortran default: null()
    """

    ae: Sequence[Real8] = pydantic.Field(
        default=None,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    be: Sequence[Real8] = pydantic.Field(
        default=None,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("be", "BE"),
        serialization_alias="BE",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    driftkick: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    electric: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("electric", "ELECTRIC"),
        serialization_alias="ELECTRIC",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    phi: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("phi", "PHI"),
        serialization_alias="PHI",
    )
    va: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    b_sol: Real8 = pydantic.Field(
        default=None,
    )
    bf_x: Sequence[Real8] = pydantic.Field(
        default=None,
        description="B field polynomial",
    )
    bf_y: Sequence[Real8] = pydantic.Field(
        default=None,
        description="B field polynomial",
    )
    e_x: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    e_y: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    f: int = pydantic.Field(
        default=0,
    )
    vm: Sequence[Real8] = pydantic.Field(
        default=None,
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


class Tktf(pydantic.BaseModel):
    """
    Tktf corresponds to bmad `TKTF`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 224.

    Attributes
    ----------
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h1 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    h2 : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    matx : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    matx2 : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    maty : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    maty2 : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    rmatx : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    rmaty : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    rlx : float
        Bmad type: real
        Fortran default: null()
    va : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    vs : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    lx : float
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: float = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    matx: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx", "MATX"),
        serialization_alias="MATX",
    )
    matx2: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx2", "MATX2"),
        serialization_alias="MATX2",
    )
    maty: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty", "MATY"),
        serialization_alias="MATY",
    )
    maty2: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty2", "MATY2"),
        serialization_alias="MATY2",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    rmatx: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("rmatx", "RMATX"),
        serialization_alias="RMATX",
    )
    rmaty: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("rmaty", "RMATY"),
        serialization_alias="RMATY",
    )
    rlx: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("rlx", "Rlx"),
        serialization_alias="Rlx",
    )
    va: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    f: int = pydantic.Field(
        default=0,
    )
    lx: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Tktfp(pydantic.BaseModel):
    """
    Tktfp corresponds to bmad `TKTFP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 243.

    Attributes
    ----------
    an : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: REAL_8
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: REAL_8
        Fortran default: null()
    L : Real8
        Bmad type: REAL_8
        Fortran default: null()
    matx : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    matx2 : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    maty : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    maty2 : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    p : MagnetChart
        Bmad type: MAGNET_CHART
        Fortran default: null()
    rmatx : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    rmaty : Real8
        LINEAR MATRIX
        Bmad type: REAL_8
        Fortran default: null()
    rlx : Real8
        Bmad type: REAL_8
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: REAL_8
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    lx : Real8
        Bmad type: REAL_8
        Fortran default: null()
    """

    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    h1: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h1", "H1"),
        serialization_alias="H1",
    )
    h2: Real8 = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("h2", "H2"),
        serialization_alias="H2",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    matx: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx", "MATX"),
        serialization_alias="MATX",
    )
    matx2: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx2", "MATX2"),
        serialization_alias="MATX2",
    )
    maty: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty", "MATY"),
        serialization_alias="MATY",
    )
    maty2: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty2", "MATY2"),
        serialization_alias="MATY2",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    rmatx: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("rmatx", "RMATX"),
        serialization_alias="RMATX",
    )
    rmaty: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("rmaty", "RMATY"),
        serialization_alias="RMATY",
    )
    rlx: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("rlx", "Rlx"),
        serialization_alias="Rlx",
    )
    va: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: Real8 = pydantic.Field(
        default=None,
        description="valishev-like multipole",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    f: int = pydantic.Field(
        default=0,
    )
    lx: Sequence[Real8] = pydantic.Field(
        default=None,
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
        Bmad type: INTEGER
    n : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER
    nv : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER
    """

    c: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Coefficients C(N)",
        validation_alias=pydantic.AliasChoices("c", "C"),
        serialization_alias="C",
    )
    j: Sequence[int] = pydantic.Field(
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


class Acceleration(pydantic.BaseModel):
    """
    Acceleration corresponds to bmad `acceleration`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 10.

    Attributes
    ----------
    next : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    pos : int
        Bmad type: integer
        Fortran default: null()
    previous : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    de : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    e_in : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    fichier : str
        Bmad type: character
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: null()
    nst : int
        Bmad type: integer
        Fortran default: null()
    r : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    tableau : TempsEnergie
        Bmad type: temps_energie
        Fortran default: null()
    w1 : Work
        Bmad type: work
        Fortran default: null()
    w2 : Work
        Bmad type: work
        Fortran default: null()
    """

    next: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    pos: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("pos", "POS"),
        serialization_alias="POS",
    )
    previous: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    de: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    e_in: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    fichier: str = pydantic.Field(
        default_factory=list,
        max_length=255,
    )
    n: int = pydantic.Field(
        default=0,
    )
    nst: int = pydantic.Field(
        default=0,
    )
    r: float = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    tableau: Sequence[TempsEnergie] = pydantic.Field(
        default=None,
    )
    w1: Work = pydantic.Field(
        default=None,
    )
    w2: Work = pydantic.Field(
        default=None,
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
        Bmad type: INTEGER
        Fortran default: null()
    n : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER
    nv : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER
    nd2 : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER
        Fortran default: null()
    """

    c: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Coefficients C(N)",
        validation_alias=pydantic.AliasChoices("c", "C"),
        serialization_alias="C",
    )
    j: Sequence[int] = pydantic.Field(
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
        Bmad type: INTEGER
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
        Bmad type: complex
        Fortran default: null()
    e_ij : Complex
        @1 stochastic fluctuation in radiation theory
        Bmad type: complex
    m : float
        Bmad type: real
        Fortran default: null()
    n : int
        @1 number of planes allocated
        Bmad type: integer
        Fortran default: 0
    q : CQuaternion
        Bmad type: c_quaternion
    s : CSpinmatrix
        @1 spin matrix
        Bmad type: c_spinmatrix
    v : CTaylor
        @1 orbital part of the map
        Bmad type: c_taylor
    x0 : Complex
        Bmad type: complex
    """

    cm: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    e_ij: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1 stochastic fluctuation in radiation theory",
    )
    m: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
        description="@1 number of planes allocated",
    )
    q: CQuaternion = pydantic.Field(
        default=None,
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


class CLatticeFunction(pydantic.BaseModel):
    """
    CLatticeFunction corresponds to bmad `c_lattice_function`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 16.

    Attributes
    ----------
    b : float
        Bmad type: real
        Fortran default: 0
    e : float
        Bmad type: real
        Fortran default: 0
    h : float
        Bmad type: real
        Fortran default: 0
    k : float
        Bmad type: real
        Fortran default: 0
    s : float
        Bmad type: real
        Fortran default: 0
    damping : float
        Bmad type: real
        Fortran default: 0
    f : Fibre
        Bmad type: fibre
        Fortran default: null()
    fix : float
        Bmad type: real
        Fortran default: 0
    phase : float
        Bmad type: real
        Fortran default: 0
    sigmas : float
        Bmad type: real
    spin : float
        Bmad type: real
        Fortran default: 0
    symplectic : bool
        Bmad type: logical
        Fortran default: .true.
    t : IntegrationNode
        Bmad type: integration_node
        Fortran default: null()
    """

    b: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    e: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    h: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("h", "H"),
        serialization_alias="H",
    )
    k: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    s: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    damping: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
    )
    f: Fibre = pydantic.Field(
        default=None,
    )
    fix: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
    )
    phase: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
    )
    sigmas: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    spin: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    symplectic: bool = pydantic.Field(
        default=True,
    )
    t: IntegrationNode = pydantic.Field(
        default=None,
    )


class CLinearMap(pydantic.BaseModel):
    """
    CLinearMap corresponds to bmad `c_linear_map`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 11.

    Attributes
    ----------
    mat : Complex
        Bmad type: complex
    q : Complex
        Bmad type: complex
    """

    mat: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    q: Sequence[Complex] = pydantic.Field(
        default=0.0,
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
        i=1,2,3 )
        Bmad type: real
    g : CFactoredLie
        @1 nonlinear part of a in phasors
        Bmad type: c_factored_lie
    ker : CFactoredLie
        @1  kernel i.e. normal form in phasors
        Bmad type: c_factored_lie
    ms : int
        @1 stores resonances to be left in the map, including spin (ms)
        Bmad type: integer
    n : CDamap
        @1 transformation n (m=a n a^-1)
        Bmad type: c_damap
    positive : bool
        forces positive tunes (close to 1 if <0)
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
            "s_ijr(2*i-1,2*i) i=1,2,3 )"
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
        description="@1 stores resonances to be left in the map, including spin (ms)",
    )
    n: CDamap = pydantic.Field(
        default=None,
        description="@1 transformation n (m=a n a^-1)",
    )
    positive: bool = pydantic.Field(
        default=False,
        description="forces positive tunes (close to 1 if <0)",
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
        # of dimensions used in x(lnv)
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
        description="# of dimensions used in x(lnv)",
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
        Bmad type: real
    n : int
        Bmad type: integer
        Fortran default: 0
    nrmax : int
        Bmad type: integer
    q : CQuaternion
        Bmad type: c_quaternion
    v : CTaylor
        Bmad type: c_taylor
    """

    L: CSpinmatrix = pydantic.Field(
        default=None,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
    )
    nrmax: int = pydantic.Field(
        default=0,
    )
    q: CQuaternion = pydantic.Field(
        default=None,
    )
    v: Sequence[CTaylor] = pydantic.Field(
        default=None,
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
        Bmad type: INTEGER
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


class FibreAppearance(pydantic.BaseModel):
    """
    FibreAppearance corresponds to bmad `fibre_appearance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 349.

    Attributes
    ----------
    parent_fibre : Fibre
        Bmad type: FIBRE
        Fortran default: null()
    next : FibreAppearance
        Bmad type: fibre_appearance
        Fortran default: null()
    """

    parent_fibre: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_fibre", "PARENT_FIBRE"),
        serialization_alias="PARENT_FIBRE",
    )
    next: FibreAppearance = pydantic.Field(
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
        Bmad type: integer
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


class Girder(pydantic.BaseModel):
    """
    Girder corresponds to bmad `girder`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 53.

    Attributes
    ----------
    next : Girder
        Bmad type: girder
        Fortran default: null()
    previous : Girder
        Terminated link list
        Bmad type: girder
        Fortran default: null()
    a : float
        Bmad type: real
        Fortran default: null()
    added : int
        Bmad type: INTEGER
        Fortran default: null()
    discarded : int
        Bmad type: INTEGER
        Fortran default: null()
    ent : float
        Bmad type: real
        Fortran default: null()
    i : int
        Bmad type: INTEGER
        Fortran default: null()
    info : GirderInfo
        Bmad type: girder_info
        Fortran default: null()
    mul : int
        number of magnets in the girder
        Bmad type: INTEGER
        Fortran default: null()
    pos : int
        Bmad type: INTEGER
        Fortran default: null()
    """

    next: Girder = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    previous: Girder = pydantic.Field(
        default=None,
        description="Terminated link list",
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    added: int = pydantic.Field(
        default=0,
    )
    discarded: int = pydantic.Field(
        default=0,
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    i: int = pydantic.Field(
        default=0,
    )
    info: GirderInfo = pydantic.Field(
        default=None,
    )
    mul: int = pydantic.Field(
        default=0,
        description="number of magnets in the girder",
    )
    pos: int = pydantic.Field(
        default=0,
    )


class GirderInfo(pydantic.BaseModel):
    """
    GirderInfo corresponds to bmad `girder_info`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 65.

    Attributes
    ----------
    name : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    next : GirderInfo
        Terminated link list
        Bmad type: girder_info
        Fortran default: null()
    a : float
        Bmad type: real
        Fortran default: null()
    d : float
        Bmad type: real
        Fortran default: null()
    ent : float
        Bmad type: real
        Fortran default: null()
    mag : Element
        Bmad type: element
        Fortran default: null()
    parent_girder : Girder
        Bmad type: girder
        Fortran default: null()
    """

    name: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    next: GirderInfo = pydantic.Field(
        default=None,
        description="Terminated link list",
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    mag: Element = pydantic.Field(
        default=None,
    )
    parent_girder: Girder = pydantic.Field(
        default=None,
    )


class GirderList(pydantic.BaseModel):
    """
    GirderList corresponds to bmad `girder_list`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 74.

    Attributes
    ----------
    end : Girder
        Bmad type: girder
        Fortran default: null()
    last : Girder
        LAST VISITED
        Bmad type: girder
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
        Fortran default: null()
    name : str
        IDENTIFICATION
        Bmad type: CHARACTER
        Fortran default: null()
    start : Girder
        Bmad type: girder
        Fortran default: null()
    discarded : int
        duplicate magnets
        Bmad type: INTEGER
        Fortran default: null()
    lastfibre : Fibre
        Bmad type: fibre
        Fortran default: null()
    """

    end: Girder = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    last: Girder = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    start: Girder = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )
    discarded: int = pydantic.Field(
        default=0,
        description="duplicate magnets",
    )
    lastfibre: Fibre = pydantic.Field(
        default=None,
    )


class GirderSiamese(pydantic.BaseModel):
    """
    GirderSiamese corresponds to bmad `girder_siamese`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 444.

    Attributes
    ----------
    mag : Element
        Bmad type: element
        Fortran default: null()
    """

    mag: Element = pydantic.Field(
        default=None,
    )


class Info(pydantic.BaseModel):
    """
    Info corresponds to bmad `info`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 354.

    Attributes
    ----------
    beta : float
        Bmad type: real
        Fortran default: null()
    fix : float
        Bmad type: real
        Fortran default: null()
    fix0 : float
        Bmad type: real
        Fortran default: null()
    m : float
        Bmad type: real
        Fortran default: null()
    pos : float
        Bmad type: real
        Fortran default: null()
    s : float
        Bmad type: real
        Fortran default: null()
    """

    beta: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    m: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    pos: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    s: float = pydantic.Field(
        default=0.0,
    )


class LayoutArray(pydantic.BaseModel):
    """
    LayoutArray corresponds to bmad `layout_array`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 439.

    Attributes
    ----------
    L : Layout
        Bmad type: layout
        Fortran default: null()
    counter : int
        Bmad type: integer
    """

    L: Layout = pydantic.Field(
        default=None,
    )
    counter: int = pydantic.Field(
        default=0,
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
        Bmad type: integer
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
        initial value of the ray for TPSA calculations with c_damap
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
        description="initial value of the ray for TPSA calculations with c_damap",
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


class Ramping(pydantic.BaseModel):
    """
    Ramping corresponds to bmad `ramping`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 200.

    Attributes
    ----------
    file : str
        Bmad type: character
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: null()
    r : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    t_max : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    table : TimeEnergy
        Bmad type: time_energy
        Fortran default: null()
    """

    file: str = pydantic.Field(
        default_factory=list,
        max_length=255,
    )
    n: int = pydantic.Field(
        default=0,
    )
    r: float = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    t_max: float = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    table: Sequence[TimeEnergy] = pydantic.Field(
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
        Bmad type: real
    t : float
        Bmad type: real
    x : float
        Bmad type: real
    """

    om: float = pydantic.Field(
        default=0.0,
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
        the omega of the modulation
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
        description="the omega of the modulation",
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
        @1  integer I is a pointer in old da-package of Berz
        Bmad type: INTEGER
    """

    i: int = pydantic.Field(
        default=0,
        description="@1  integer I is a pointer in old da-package of Berz",
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


class TempsEnergie(pydantic.BaseModel):
    """
    TempsEnergie corresponds to bmad `temps_energie`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 4.

    Attributes
    ----------
    energie : float
        Bmad type: real
        Fortran default: null()
    phase : float
        Bmad type: real
        Fortran default: null()
    tc : float
        Bmad type: real
        Fortran default: null()
    temps : float
        Bmad type: real
        Fortran default: null()
    volt : float
        Bmad type: real
        Fortran default: null()
    """

    energie: float = pydantic.Field(
        default=0.0,
    )
    phase: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    tc: float = pydantic.Field(
        default=0.0,
    )
    temps: float = pydantic.Field(
        default=0.0,
    )
    volt: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Tilting(pydantic.BaseModel):
    """
    Tilting corresponds to bmad `tilting`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 188.

    Attributes
    ----------
    natural : bool
        for mad-like
        Bmad type: LOGICAL
    tilt : float
        Bmad type: real
    """

    natural: bool = pydantic.Field(
        default=False,
        description="for mad-like",
    )
    tilt: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class TimeEnergy(pydantic.BaseModel):
    """
    TimeEnergy corresponds to bmad `time_energy`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 193.

    Attributes
    ----------
    an : float
        Bmad type: real
        Fortran default: null()
    b_t : float
        Bmad type: real
        Fortran default: null()
    bn : float
        Bmad type: real
        Fortran default: null()
    energy : float
        Bmad type: real
        Fortran default: null()
    time : float
        Bmad type: real
        Fortran default: null()
    """

    an: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_t: float = pydantic.Field(
        default=0.0,
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    energy: float = pydantic.Field(
        default=0.0,
    )
    time: float = pydantic.Field(
        default=0.0,
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
        Bmad type: integer
    jv : int
        Bmad type: integer
    n : int
        Bmad type: INTEGER
    np : int
        Bmad type: INTEGER
    beta0 : float
        Bmad type: real
    ds : float
        Bmad type: real
    e_ij : float
        Bmad type: real
    eps : float
        Bmad type: real
    factored : bool
        Bmad type: logical
    fix : float
        Bmad type: real
    fix0 : float
        Bmad type: real
    fixr : float
        Bmad type: real
    no : int
        Bmad type: INTEGER
    rad : float
        Bmad type: real
    symptrack : bool
        Bmad type: logical
    usenonsymp : bool
        Bmad type: logical
    """

    cc: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("cc", "CC"),
        serialization_alias="CC",
    )
    jl: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("jl", "JL"),
        serialization_alias="JL",
    )
    jv: Sequence[int] = pydantic.Field(
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
    fix: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fixr: Sequence[float] = pydantic.Field(
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


class UnduR(pydantic.BaseModel):
    """
    UnduR corresponds to bmad `undu_R`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 16.

    Attributes
    ----------
    a : float
        Bmad type: real
        Fortran default: null()
    ae : float
        Bmad type: real
        Fortran default: null()
    f : float
        Bmad type: real
        Fortran default: null()
    fe : float
        Bmad type: real
        Fortran default: null()
    form : int
        Bmad type: integer
        Fortran default: null()
    forme : int
        Bmad type: integer
        Fortran default: null()
    k : float
        Bmad type: real
        Fortran default: null()
    ke : float
        Bmad type: real
        Fortran default: null()
    ex : float
        Bmad type: real
        Fortran default: null()
    ey : float
        Bmad type: real
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: null()
    ne : int
        Bmad type: integer
        Fortran default: null()
    offset : float
        Bmad type: real
        Fortran default: null()
    x0 : float
        Bmad type: real
        Fortran default: null()
    x0e : float
        Bmad type: real
        Fortran default: null()
    y0 : float
        Bmad type: real
        Fortran default: null()
    y0e : float
        Bmad type: real
        Fortran default: null()
    """

    a: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    ae: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    fe: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fe", "FE"),
        serialization_alias="FE",
    )
    form: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("form", "FORM"),
        serialization_alias="FORM",
    )
    forme: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("forme", "FORME"),
        serialization_alias="FORME",
    )
    k: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    ke: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ke", "KE"),
        serialization_alias="KE",
    )
    ex: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ey: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
    )
    ne: int = pydantic.Field(
        default=0,
    )
    offset: float = pydantic.Field(
        default=0.0,
    )
    x0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    x0e: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("x0e", "x0E"),
        serialization_alias="x0E",
    )
    y0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y0e: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("y0e", "y0E"),
        serialization_alias="y0E",
    )


class UnduP(pydantic.BaseModel):
    """
    UnduP corresponds to bmad `undu_p`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 34.

    Attributes
    ----------
    a : Real8
        Bmad type: REAL_8
        Fortran default: null()
    ae : Real8
        Bmad type: REAL_8
        Fortran default: null()
    f : Real8
        Bmad type: REAL_8
        Fortran default: null()
    fe : Real8
        Bmad type: REAL_8
        Fortran default: null()
    form : int
        Bmad type: integer
        Fortran default: null()
    forme : int
        Bmad type: integer
        Fortran default: null()
    k : Real8
        Bmad type: REAL_8
        Fortran default: null()
    ke : Real8
        Bmad type: REAL_8
        Fortran default: null()
    ex : float
        Bmad type: real
        Fortran default: null()
    ey : float
        Bmad type: real
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: null()
    ne : int
        Bmad type: integer
        Fortran default: null()
    offset : Real8
        Bmad type: REAL_8
    x0 : Real8
        Bmad type: REAL_8
        Fortran default: null()
    x0e : Real8
        Bmad type: REAL_8
        Fortran default: null()
    y0 : Real8
        Bmad type: REAL_8
        Fortran default: null()
    y0e : Real8
        Bmad type: REAL_8
        Fortran default: null()
    """

    a: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    ae: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    f: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    fe: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("fe", "FE"),
        serialization_alias="FE",
    )
    form: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("form", "FORM"),
        serialization_alias="FORM",
    )
    forme: Sequence[int] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("forme", "FORME"),
        serialization_alias="FORME",
    )
    k: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    ke: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ke", "KE"),
        serialization_alias="KE",
    )
    ex: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ey: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
    )
    ne: int = pydantic.Field(
        default=0,
    )
    offset: Real8 = pydantic.Field(
        default=None,
    )
    x0: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    x0e: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("x0e", "x0E"),
        serialization_alias="x0E",
    )
    y0: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    y0e: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("y0e", "y0E"),
        serialization_alias="y0E",
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


class Work(pydantic.BaseModel):
    """
    Work corresponds to bmad `work`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 96.

    Attributes
    ----------
    beta0 : float
        Bmad type: real
    brho : float
        Bmad type: real
    energy : float
        Bmad type: real
    gambet : float
        Bmad type: real
    gamma0i : float
        Bmad type: real
    kinetic : float
        Bmad type: real
    mass : float
        Bmad type: real
    p0c : float
        Bmad type: real
    power : int
        Bmad type: integer
    rescale : bool
        Bmad type: LOGICAL
    """

    beta0: float = pydantic.Field(
        default=0.0,
    )
    brho: float = pydantic.Field(
        default=0.0,
    )
    energy: float = pydantic.Field(
        default=0.0,
    )
    gambet: float = pydantic.Field(
        default=0.0,
    )
    gamma0i: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("gamma0i", "gamma0I"),
        serialization_alias="gamma0I",
    )
    kinetic: float = pydantic.Field(
        default=0.0,
    )
    mass: float = pydantic.Field(
        default=0.0,
    )
    p0c: float = pydantic.Field(
        default=0.0,
    )
    power: int = pydantic.Field(
        default=0,
    )
    rescale: bool = pydantic.Field(
        default=False,
    )
