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
    sixtrack : bool
        Bmad type: LOGICAL
    l_design : float
        Bmad type: REAL
    dl_sixtrack : float
        Bmad type: REAL
    d : float
        Bmad type: REAL
    dl : float
        Bmad type: REAL
    """

    sixtrack: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("sixtrack", "SIXTRACK"),
        serialization_alias="SIXTRACK",
    )
    l_design: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("l_design", "L_DESIGN"),
        serialization_alias="L_DESIGN",
    )
    dl_sixtrack: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dl_sixtrack", "DL_SIXTRACK"),
        serialization_alias="DL_SIXTRACK",
    )
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


class EGeneral(pydantic.BaseModel):
    """
    EGeneral corresponds to bmad `E_GENERAL`
    which is in Users/klauer/Repos/bmad/forest/code/Sc_euclidean.f90 on line 59.

    Attributes
    ----------
    kind : int
        Bmad type: INTEGER
    t1 : RXy
        Bmad type: TYPE
    t2 : RZ
        Bmad type: TYPE
    t3 : TXyz
        Bmad type: TYPE
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


class BCyl(pydantic.BaseModel):
    """
    BCyl corresponds to bmad `B_CYL`
    which is in Users/klauer/Repos/bmad/forest/code/Se_status.f90 on line 148.

    Attributes
    ----------
    firsttime : int
        Bmad type: integer
    nmul : int
        ,nmul_e,n_mono_e
        Bmad type: integer
    n_mono : int
        ,nmul_e,n_mono_e
        Bmad type: integer
    i : int
        ,ie,je
        Bmad type: integer
    j : int
        ,ie,je
        Bmad type: integer
    a_x : float
        Bmad type: real
    a_y : float
        Bmad type: real
    b_x : float
        Bmad type: real
    b_y : float
        Bmad type: real
    va : float
        Bmad type: real
    vb : float
        Bmad type: real
    """

    firsttime: int = pydantic.Field(
        default=0,
    )
    nmul: int = pydantic.Field(
        default=0,
        description=",nmul_e,n_mono_e",
    )
    n_mono: int = pydantic.Field(
        default=0,
        description=",nmul_e,n_mono_e",
    )
    i: Sequence[int] = pydantic.Field(
        default=0,
        description=",ie,je",
    )
    j: Sequence[int] = pydantic.Field(
        default=0,
        description=",ie,je",
    )
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
    va: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    vb: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Bunch(pydantic.BaseModel):
    """
    Bunch corresponds to bmad `bunch`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 42.

    Attributes
    ----------
    xs : Probe
        Bmad type: type
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
    """

    xs: Sequence[Probe] = pydantic.Field(
        default=None,
    )
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


class InternalState(pydantic.BaseModel):
    """
    InternalState corresponds to bmad `INTERNAL_STATE`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 49.

    Attributes
    ----------
    totalpath : int
        total time or path length is used
        Bmad type: INTEGER
    time : bool
        Time is used instead of path length
        Bmad type: LOGICAL
    radiation : bool
        Radiation is turned on
        Bmad type: LOGICAL
    nocavity : bool
        Cavity is turned into a drift
        Bmad type: LOGICAL
    fringe : bool
        Fringe fields are turned on (mainly for quadrupoles)
        Bmad type: LOGICAL
    stochastic : bool
        Random Stochastic kicks to x(5)
        Bmad type: LOGICAL
    envelope : bool
        Stochastic envelope terms tracked in probe_8
        Bmad type: LOGICAL
    para_in : bool
        If true, parameters in the map are included
        Bmad type: LOGICAL
    only_4d : bool
        REAL_8 Taylor in (x,p_x,y,p_y)
        Bmad type: LOGICAL
    delta : bool
        REAL_8 Taylor in (x,p_x,y,p_y,delta)
        Bmad type: LOGICAL
    spin : bool
        Spin is tracked
        Bmad type: LOGICAL
    modulation : bool
        One modulated family tracked by probe
        Bmad type: LOGICAL
    only_2d : bool
        REAL_8 Taylor in (x,p_x)
        Bmad type: LOGICAL
    full_way : bool
        Bmad type: LOGICAL
    """

    totalpath: int = pydantic.Field(
        default=0,
        description="total time or path length is used",
        validation_alias=pydantic.AliasChoices("totalpath", "TOTALPATH"),
        serialization_alias="TOTALPATH",
    )
    time: bool = pydantic.Field(
        default=False,
        description="Time is used instead of path length",
        validation_alias=pydantic.AliasChoices("time", "TIME"),
        serialization_alias="TIME",
    )
    radiation: bool = pydantic.Field(
        default=False,
        description="Radiation is turned on",
        validation_alias=pydantic.AliasChoices("radiation", "RADIATION"),
        serialization_alias="RADIATION",
    )
    nocavity: bool = pydantic.Field(
        default=False,
        description="Cavity is turned into a drift",
        validation_alias=pydantic.AliasChoices("nocavity", "NOCAVITY"),
        serialization_alias="NOCAVITY",
    )
    fringe: bool = pydantic.Field(
        default=False,
        description="Fringe fields are turned on (mainly for quadrupoles)",
        validation_alias=pydantic.AliasChoices("fringe", "FRINGE"),
        serialization_alias="FRINGE",
    )
    stochastic: bool = pydantic.Field(
        default=False,
        description="Random Stochastic kicks to x(5)",
        validation_alias=pydantic.AliasChoices("stochastic", "STOCHASTIC"),
        serialization_alias="STOCHASTIC",
    )
    envelope: bool = pydantic.Field(
        default=False,
        description="Stochastic envelope terms tracked in probe_8",
        validation_alias=pydantic.AliasChoices("envelope", "ENVELOPE"),
        serialization_alias="ENVELOPE",
    )
    para_in: bool = pydantic.Field(
        default=False,
        description="If true, parameters in the map are included",
        validation_alias=pydantic.AliasChoices("para_in", "PARA_IN"),
        serialization_alias="PARA_IN",
    )
    only_4d: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x,y,p_y)",
        validation_alias=pydantic.AliasChoices("only_4d", "ONLY_4D"),
        serialization_alias="ONLY_4D",
    )
    delta: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x,y,p_y,delta)",
        validation_alias=pydantic.AliasChoices("delta", "DELTA"),
        serialization_alias="DELTA",
    )
    spin: bool = pydantic.Field(
        default=False,
        description="Spin is tracked",
        validation_alias=pydantic.AliasChoices("spin", "SPIN"),
        serialization_alias="SPIN",
    )
    modulation: bool = pydantic.Field(
        default=False,
        description="One modulated family tracked by probe",
        validation_alias=pydantic.AliasChoices("modulation", "MODULATION"),
        serialization_alias="MODULATION",
    )
    only_2d: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x)",
        validation_alias=pydantic.AliasChoices("only_2d", "ONLY_2D"),
        serialization_alias="ONLY_2D",
    )
    full_way: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("full_way", "FULL_WAY"),
        serialization_alias="FULL_WAY",
    )


class TreeElement(pydantic.BaseModel):
    """
    TreeElement corresponds to bmad `tree_element`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 68.

    Attributes
    ----------
    cc : float
        Bmad type: real
    fixr : float
        Bmad type: real
    fix : float
        Bmad type: real
    fix0 : float
        Bmad type: real
    jl : int
        Bmad type: integer
    jv : int
        Bmad type: integer
    n : int
        Bmad type: INTEGER
    np : int
        Bmad type: INTEGER
    no : int
        Bmad type: INTEGER
    e_ij : float
        Bmad type: real
    rad : float
        Bmad type: real
    ds : float
        Bmad type: real
    beta0 : float
        Bmad type: real
    eps : float
        Bmad type: real
    symptrack : bool
        Bmad type: logical
    usenonsymp : bool
        Bmad type: logical
    factored : bool
        Bmad type: logical
    """

    cc: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("cc", "CC"),
        serialization_alias="CC",
    )
    fixr: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix0: Sequence[float] = pydantic.Field(
        default=0.0,
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
    no: int = pydantic.Field(
        default=0,
    )
    e_ij: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    rad: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ds: float = pydantic.Field(
        default=0.0,
    )
    beta0: float = pydantic.Field(
        default=0.0,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    symptrack: bool = pydantic.Field(
        default=False,
    )
    usenonsymp: bool = pydantic.Field(
        default=False,
    )
    factored: bool = pydantic.Field(
        default=False,
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


class Probe(pydantic.BaseModel):
    """
    Probe corresponds to bmad `probe`
    which is in Users/klauer/Repos/bmad/forest/code/Su_duan_zhe_map.f90 on line 90.

    Attributes
    ----------
    x : float
        Bmad type: real
    s : Spinor
        Bmad type: type
    q : Quaternion
        Bmad type: type
    u : bool
        Bmad type: logical
    use_q : bool
        Bmad type: logical
    e : float
        Bmad type: real
    """

    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )
    s: Sequence[Spinor] = pydantic.Field(
        default=None,
        max_length=3,
    )
    q: Quaternion = pydantic.Field(
        default=None,
    )
    u: bool = pydantic.Field(
        default=False,
    )
    use_q: bool = pydantic.Field(
        default=False,
    )
    e: float = pydantic.Field(
        default=0.0,
    )


class FibreMonitorData(pydantic.BaseModel):
    """
    FibreMonitorData corresponds to bmad `fibre_monitor_data`
    which is in Users/klauer/Repos/bmad/forest/code/Sra_fitting.f90 on line 15.

    Attributes
    ----------
    p : Fibre
        fibre location
        Bmad type: type
    turn : int
        kind=1 x, kind = 2 y
        Bmad type: integer
    kind : int
        kind=1 x, kind = 2 y
        Bmad type: integer
    bpm : float
        store fake experiment from alex_track_monitors
        Bmad type: real
    r : float
        store fake experiment from alex_track_monitors
        Bmad type: real
    xf : float
        real data put here
        Bmad type: real
    xn : float
        real data put here
        Bmad type: real
    mom : float
        Bmad type: real
    a : float
        Bmad type: real
    at : float
        Bmad type: real
    full : bool
        Bmad type: logical
    """

    p: Fibre = pydantic.Field(
        default=None,
        description="fibre location",
    )
    turn: int = pydantic.Field(
        default=0,
        description="kind=1 x, kind = 2 y",
    )
    kind: int = pydantic.Field(
        default=0,
        description="kind=1 x, kind = 2 y",
    )
    bpm: Sequence[float] = pydantic.Field(
        default=0.0,
        description="store fake experiment from alex_track_monitors",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        description="store fake experiment from alex_track_monitors",
    )
    xf: Sequence[float] = pydantic.Field(
        default=0.0,
        description="real data put here",
    )
    xn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="real data put here",
    )
    mom: Sequence[float] = pydantic.Field(
        default=0.0,
    )
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
    full: bool = pydantic.Field(
        default=False,
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
    wx : float
        width of box for plotting purposes
        Bmad type: real
    wy : float
        width of box for plotting purposes
        Bmad type: real
    o : float
        frames at the point of tracking
        Bmad type: real
    mid : float
        frames at the point of tracking
        Bmad type: real
    reference_ray : float
        Bmad type: real
    x : float
        ray tracked with reference_ray using a  type(beam)
        Bmad type: real
    r0 : float
        ray position global returned
        Bmad type: real
    r : float
        ray position global returned
        Bmad type: real
    scale : float
        magnification using reference_ray
        Bmad type: real
    u : bool
        unstable flag for both ray and reference_ray
        Bmad type: logical
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
    wx: float = pydantic.Field(
        default=0.0,
        description="width of box for plotting purposes",
    )
    wy: float = pydantic.Field(
        default=0.0,
        description="width of box for plotting purposes",
    )
    o: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="frames at the point of tracking",
    )
    mid: Sequence[float] = pydantic.Field(
        default=0.0,
        description="frames at the point of tracking",
    )
    reference_ray: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )
    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="ray tracked with reference_ray using a  type(beam)",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="ray position global returned",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="ray position global returned",
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


class ElList(pydantic.BaseModel):
    """
    ElList corresponds to bmad `EL_LIST`
    which is in Users/klauer/Repos/bmad/forest/code/Sn_mad_like.f90 on line 58.

    Attributes
    ----------
    L : float
        Bmad type: real
    ld : float
        Bmad type: real
    lc : float
        Bmad type: real
    k : float
        Bmad type: real
    ks : float
        Bmad type: real
    ang : float
        Bmad type: real
    t : float
        Bmad type: real
    angi : float
        Bmad type: real
    ti : float
        Bmad type: real
    patchg : int
        Bmad type: integer
    cavity_totalpath : int
        Bmad type: integer
    t1 : float
        Bmad type: real
    t2 : float
        Bmad type: real
    b0 : float
        Bmad type: real
    volt : float
        Bmad type: real
    freq0 : float
        Bmad type: real
    harmon : float
        Bmad type: real
    lag : float
        Bmad type: real
    delta_e : float
        Bmad type: real
    bsol : float
        Bmad type: real
    tilt : float
        Bmad type: real
    fint : float
        Bmad type: real
    hgap : float
        Bmad type: real
    fint2 : float
        Bmad type: real
    hgap2 : float
        Bmad type: real
    h1 : float
        Bmad type: real
    h2 : float
        Bmad type: real
    x_col : float
        Bmad type: real
    y_col : float
        Bmad type: real
    thin_h_foc : float
        highly illegal additions by frs
        Bmad type: real
    thin_v_foc : float
        highly illegal additions by frs
        Bmad type: real
    thin_h_angle : float
        highly illegal additions by frs
        Bmad type: real
    thin_v_angle : float
        highly illegal additions by frs
        Bmad type: real
    hf : float
        highly illegal additions by frs
        Bmad type: real
    vf : float
        highly illegal additions by frs
        Bmad type: real
    ls : float
        highly illegal additions by frs
        Bmad type: real
    file : str
        Bmad type: CHARACTER
    file_rev : str
        Bmad type: CHARACTER
    name : str
        Bmad type: CHARACTER
    vorname : str
        Bmad type: CHARACTER
    kind : int
        Bmad type: INTEGER
    nmul : int
        Bmad type: INTEGER
    nst : int
        Bmad type: INTEGER
    method : int
        Bmad type: INTEGER
    aperture_on : bool
        Bmad type: LOGICAL
    aperture_kind : int
        Bmad type: INTEGER
    aperture_r : float
        Bmad type: REAL
    aperture_x : float
        Bmad type: REAL
    aperture_y : float
        Bmad type: REAL
    aperture_dx : float
        Bmad type: REAL
    aperture_dy : float
        Bmad type: REAL
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
    kill_ent_fringe : bool
        Bmad type: LOGICAL
    kill_exi_fringe : bool
        Bmad type: LOGICAL
    bend_fringe : bool
        Bmad type: LOGICAL
    kill_ent_spin : bool
        Bmad type: LOGICAL
    kill_exi_spin : bool
        Bmad type: LOGICAL
    permfringe : int
        Bmad type: integer
    highest_fringe : int
        Bmad type: integer
    dphas : float
        Bmad type: REAL
    psi : float
        Bmad type: REAL
    dvds : float
        Bmad type: REAL
    usethin : bool
        Bmad type: logical
    n_bessel : int
        Bmad type: INTEGER
    n_ac : int
        number of oscillating multipoles
        Bmad type: INTEGER
    d_bn : float
        oscillation amplitudes of multipoles (modulation)
        Bmad type: REAL
    d_an : float
        oscillation amplitudes of multipoles (modulation)
        Bmad type: REAL
    d_volt : float
        oscillation amplitudes of RF voltage and phase (modulation)
        Bmad type: real
    d_phas : float
        oscillation amplitudes of RF voltage and phase (modulation)
        Bmad type: real
    d_ac : float
        factor for oscillation amplitude set by d_bn and d_an
        Bmad type: REAL
    dc_ac : float
        factors for base field oscillation (D0_BN) : BN(N) =
        (DC_AC+A_AC*clock)*D0_BN(N) + D_AC*clock*D_BN(N)
        Bmad type: REAL
    a_ac : float
        factors for base field oscillation (D0_BN) : BN(N) =
        (DC_AC+A_AC*clock)*D0_BN(N) + D_AC*clock*D_BN(N)
        Bmad type: REAL
    clockno_ac : int
        number (index) of the clock that this element is driven by
        Bmad type: INTEGER
    theta_ac : float
        lag wrt the oscillation clock
        Bmad type: REAL
    """

    L: float = pydantic.Field(
        default=0.0,
    )
    ld: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ld", "LD"),
        serialization_alias="LD",
    )
    lc: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("lc", "LC"),
        serialization_alias="LC",
    )
    k: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    ks: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ks", "KS"),
        serialization_alias="KS",
    )
    ang: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    t: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    angi: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    ti: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    patchg: int = pydantic.Field(
        default=0,
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
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
    b0: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b0", "B0"),
        serialization_alias="B0",
    )
    volt: float = pydantic.Field(
        default=0.0,
    )
    freq0: float = pydantic.Field(
        default=0.0,
    )
    harmon: float = pydantic.Field(
        default=0.0,
    )
    lag: float = pydantic.Field(
        default=0.0,
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    bsol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("bsol", "BSOL"),
        serialization_alias="BSOL",
    )
    tilt: float = pydantic.Field(
        default=0.0,
    )
    fint: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: float = pydantic.Field(
        default=0.0,
    )
    fint2: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fint2", "FINT2"),
        serialization_alias="FINT2",
    )
    hgap2: float = pydantic.Field(
        default=0.0,
    )
    h1: float = pydantic.Field(
        default=0.0,
    )
    h2: float = pydantic.Field(
        default=0.0,
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
    thin_h_foc: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_v_foc: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_h_angle: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_v_angle: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    hf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    vf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    ls: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    file: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    file_rev: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    name: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    vorname: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    nmul: int = pydantic.Field(
        default=0,
    )
    nst: int = pydantic.Field(
        default=0,
    )
    method: int = pydantic.Field(
        default=0,
    )
    aperture_on: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("aperture_on", "APERTURE_ON"),
        serialization_alias="APERTURE_ON",
    )
    aperture_kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("aperture_kind", "APERTURE_KIND"),
        serialization_alias="APERTURE_KIND",
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
    kill_ent_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_ent_fringe", "KILL_ENT_FRINGE"),
        serialization_alias="KILL_ENT_FRINGE",
    )
    kill_exi_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_exi_fringe", "KILL_EXI_FRINGE"),
        serialization_alias="KILL_EXI_FRINGE",
    )
    bend_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("bend_fringe", "BEND_FRINGE"),
        serialization_alias="BEND_FRINGE",
    )
    kill_ent_spin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_ent_spin", "KILL_ENT_SPIN"),
        serialization_alias="KILL_ENT_SPIN",
    )
    kill_exi_spin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_exi_spin", "KILL_EXI_SPIN"),
        serialization_alias="KILL_EXI_SPIN",
    )
    permfringe: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("permfringe", "PERMFRINGE"),
        serialization_alias="PERMFRINGE",
    )
    highest_fringe: int = pydantic.Field(
        default=0,
    )
    dphas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("dphas", "DPHAS"),
        serialization_alias="DPHAS",
    )
    psi: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("psi", "PSI"),
        serialization_alias="PSI",
    )
    dvds: float = pydantic.Field(
        default=0.0,
    )
    usethin: bool = pydantic.Field(
        default=False,
    )
    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    n_ac: int = pydantic.Field(
        default=0,
        description="number of oscillating multipoles",
    )
    d_bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of multipoles (modulation)",
    )
    d_an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of multipoles (modulation)",
    )
    d_volt: float = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of RF voltage and phase (modulation)",
    )
    d_phas: float = pydantic.Field(
        default=0.0,
        description="oscillation amplitudes of RF voltage and phase (modulation)",
    )
    d_ac: float = pydantic.Field(
        default=0.0,
        description="factor for oscillation amplitude set by d_bn and d_an",
        validation_alias=pydantic.AliasChoices("d_ac", "D_ac"),
        serialization_alias="D_ac",
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
    a_ac: float = pydantic.Field(
        default=0.0,
        description=(
            "factors for base field oscillation (D0_BN) : BN(N) = "
            "(DC_AC+A_AC*clock)*D0_BN(N) + D_AC*clock*D_BN(N)"
        ),
        validation_alias=pydantic.AliasChoices("a_ac", "A_ac"),
        serialization_alias="A_ac",
    )
    clockno_ac: int = pydantic.Field(
        default=0,
        description="number (index) of the clock that this element is driven by",
    )
    theta_ac: float = pydantic.Field(
        default=0.0,
        description="lag wrt the oscillation clock",
    )


class Control(pydantic.BaseModel):
    """
    Control corresponds to bmad `CONTROL`
    which is in Users/klauer/Repos/bmad/forest/code/a_scratch_size.f90 on line 268.

    Attributes
    ----------
    total_da_size : float
        in megabytes
        Bmad type: real
        Fortran default: null()
    lda_used : int
        maximum number of da variables in Berz's
        Bmad type: integer
        Fortran default: null()
    old : bool
        = true  = bERZ
        Bmad type: logical
        Fortran default: null()
    real_warning : bool
        = true
        Bmad type: logical
        Fortran default: null()
    no : int
        order of da
        Bmad type: integer
        Fortran default: null()
    nv : int
        number of variables
        Bmad type: integer
        Fortran default: null()
    nd : int
        degrees of freedom
        Bmad type: integer
        Fortran default: null()
    nd2 : int
        phase space dimension
        Bmad type: integer
        Fortran default: null()
    np : int
        number of parameters in fpp
        Bmad type: integer
        Fortran default: null()
    nspin : int
        number of spin variables (0 or 3)
        Bmad type: integer
        Fortran default: null()
    ndpt : int
        constant energy variable position is different from zero
        Bmad type: integer
        Fortran default: null()
    ndptb : int
        Bmad type: integer
        Fortran default: null()
    npara : int
        PARAMETER LOCATION IN PTC in fpp
        Bmad type: integer
        Fortran default: null()
    npara_fpp : int
        PARAMETER LOCATION IN FPP or PTC
        Bmad type: integer
        Fortran default: null()
    np_pol : int
        parameters produced through pol_block
        Bmad type: integer
        Fortran default: null()
    nd2t : int
        harmonic planes minus clocks
        Bmad type: integer
        Fortran default: null()
    nd2harm : int
        harmonic plane
        Bmad type: integer
        Fortran default: null()
    ndc2t : int
        0 or 2 : jordan planes
        Bmad type: integer
        Fortran default: null()
    pos_of_delta : int
        constant delta
        Bmad type: integer
        Fortran default: null()
    rf : int
        # of modulated planes
        Bmad type: integer
        Fortran default: null()
    knob : bool
        Bmad type: logical
        Fortran default: null()
    valishev : bool
        Bmad type: logical
        Fortran default: null()
    setknob : bool
        Bmad type: logical
        Fortran default: null()
    da_absolute_aperture : float
        in case one tracks with da.
        Bmad type: REAL
        Fortran default: null()
    wherelost : int
        counting lost particles in integration nodes
        Bmad type: integer
        Fortran default: null()
    root_check : bool
        =.TRUE. performs check in roots and hyperbolic if true
        Bmad type: logical
        Fortran default: null()
    check_stable : bool
        =.TRUE. particle status
        Bmad type: logical
        Fortran default: null()
    check_madx_aperture : bool
        =.TRUE. false means particle lost in aperture
        Bmad type: logical
        Fortran default: null()
    aperture_flag : bool
        =.TRUE. aperture checks globally done (default)
        Bmad type: logical
        Fortran default: null()
    s_aperture_check : bool
        =.TRUE. aperture checks globally done (default)
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
    hyperbolic_aperture : float
        controls crashes in exponentials
        Bmad type: real
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
    nstd : int
        number of steps and integration method
        Bmad type: integer
        Fortran default: null()
    metd : int
        number of steps and integration method
        Bmad type: integer
        Fortran default: null()
    madlength : bool
        =.false. rbend crazy length in mad8 as input
        Bmad type: logical
        Fortran default: null()
    mad : bool
        =.false. mad definition of multipole for input only
        Bmad type: logical
        Fortran default: null()
    exact_model : bool
        = .false. exact model used
        Bmad type: logical
        Fortran default: null()
    always_exactmis : bool
        =.TRUE. exact formula in tracking used for that element
        Bmad type: logical
        Fortran default: null()
    always_knobs : bool
        =.false. ptc knob default status
        Bmad type: logical
        Fortran default: null()
    recirculator_cheat : bool
        =.false.  if true energy patches use the time formula always
        Bmad type: logical
        Fortran default: null()
    sixtrack_compatible : bool
        to insure some sixtrack compatibility default=false
        Bmad type: logical
        Fortran default: null()
    cavity_totalpath : int
        REAL PILL B0X =1 , FAKE =0  default
        Bmad type: integer
        Fortran default: null()
    highest_fringe : int
        =2  quadrupole fringe ON IF FRINGE PRESENT
        Bmad type: integer
        Fortran default: null()
    do_beam_beam : bool
        obvious meaning: false normally
        Bmad type: logical
        Fortran default: null()
    fibre_dir : int
        =1 or -1 for reversed
        Bmad type: integer
        Fortran default: null()
    initial_charge : float
        =1 or -1 AND  ADJUST THE MASS IS THE PREFERED MODE
        Bmad type: real
        Fortran default: null()
    fibre_flip : bool
        =.true.
        Bmad type: logical
        Fortran default: null()
    eps_pos : float
        Bmad type: real
        Fortran default: null()
    sector_nmul_max : int
        = 10 maxwell equations is solved to order 10 in exact sectors
        Bmad type: integer
        Fortran default: null()
    sector_nmul : int
        = 4  MULTIPOLES IN TEAPOT BEND ALLOWED BY DEFAULT
        Bmad type: integer
        Fortran default: null()
    wedge_coeff : float
        QUAD_KICK IN WEDGE
        Bmad type: real
        Fortran default: null()
    mad8_wedge : bool
        QUAD_KICK + FRINGE IF FRINGE IS OUT.
        Bmad type: logical
        Fortran default: null()
    electron : bool
        electron if true otherwise proton
        Bmad type: logical
        Fortran default: null()
    massfactor : float
        =one  sets variable muon and electron must be true
        Bmad type: real
        Fortran default: null()
    compute_stoch_kick : bool
        = .false. store stochastic kick for stochastic tracking
        Bmad type: logical
        Fortran default: null()
    feed_p0c : bool
        =.FALSE.  work takes p0c instead of energy
        Bmad type: logical
        Fortran default: null()
    always_exact_patching : bool
        =.TRUE. patching done correctly
        Bmad type: logical
        Fortran default: null()
    stable_da : bool
        =.true.  interrupts DA if check_da is true
        Bmad type: logical
        Fortran default: null()
    stable_da_pancake : bool
        =.TRUE. particle status
        Bmad type: logical
        Fortran default: null()
    check_da : bool
        =.true.
        Bmad type: logical
        Fortran default: null()
    old_implementation_of_sixtrack : bool
        =.true.
        Bmad type: logical
        Fortran default: null()
    phase0 : float
        default phase in cavity
        Bmad type: real
        Fortran default: null()
    global_verbose : bool
        Bmad type: logical
        Fortran default: null()
    no_hyperbolic_in_normal_form : bool
        unstable produces exception
        Bmad type: logical
        Fortran default: null()
    ndpt_bmad : int
        Bmad type: integer
        Fortran default: null()
    """

    total_da_size: float = pydantic.Field(
        default=0.0,
        description="in megabytes",
    )
    lda_used: int = pydantic.Field(
        default=0,
        description="maximum number of da variables in Berz's",
    )
    old: bool = pydantic.Field(
        default=False,
        description="= true  = bERZ",
        validation_alias=pydantic.AliasChoices("old", "OLD"),
        serialization_alias="OLD",
    )
    real_warning: bool = pydantic.Field(
        default=False,
        description="= true",
    )
    no: int = pydantic.Field(
        default=0,
        description="order of da",
    )
    nv: int = pydantic.Field(
        default=0,
        description="number of variables",
    )
    nd: int = pydantic.Field(
        default=0,
        description="degrees of freedom",
    )
    nd2: int = pydantic.Field(
        default=0,
        description="phase space dimension",
    )
    np: int = pydantic.Field(
        default=0,
        description="number of parameters in fpp",
    )
    nspin: int = pydantic.Field(
        default=0,
        description="number of spin variables (0 or 3)",
    )
    ndpt: int = pydantic.Field(
        default=0,
        description="constant energy variable position is different from zero",
    )
    ndptb: int = pydantic.Field(
        default=0,
    )
    npara: int = pydantic.Field(
        default=0,
        description="PARAMETER LOCATION IN PTC in fpp",
        validation_alias=pydantic.AliasChoices("npara", "NPARA"),
        serialization_alias="NPARA",
    )
    npara_fpp: int = pydantic.Field(
        default=0,
        description="PARAMETER LOCATION IN FPP or PTC",
    )
    np_pol: int = pydantic.Field(
        default=0,
        description="parameters produced through pol_block",
    )
    nd2t: int = pydantic.Field(
        default=0,
        description="harmonic planes minus clocks",
    )
    nd2harm: int = pydantic.Field(
        default=0,
        description="harmonic plane",
    )
    ndc2t: int = pydantic.Field(
        default=0,
        description="0 or 2 : jordan planes",
    )
    pos_of_delta: int = pydantic.Field(
        default=0,
        description="constant delta",
    )
    rf: int = pydantic.Field(
        default=0,
        description="# of modulated planes",
    )
    knob: bool = pydantic.Field(
        default=False,
    )
    valishev: bool = pydantic.Field(
        default=False,
    )
    setknob: bool = pydantic.Field(
        default=False,
    )
    da_absolute_aperture: float = pydantic.Field(
        default=0.0,
        description="in case one tracks with da.",
    )
    wherelost: int = pydantic.Field(
        default=0,
        description="counting lost particles in integration nodes",
    )
    root_check: bool = pydantic.Field(
        default=False,
        description="=.TRUE. performs check in roots and hyperbolic if true",
        validation_alias=pydantic.AliasChoices("root_check", "ROOT_CHECK"),
        serialization_alias="ROOT_CHECK",
    )
    check_stable: bool = pydantic.Field(
        default=False,
        description="=.TRUE. particle status",
        validation_alias=pydantic.AliasChoices("check_stable", "CHECK_STABLE"),
        serialization_alias="CHECK_STABLE",
    )
    check_madx_aperture: bool = pydantic.Field(
        default=False,
        description="=.TRUE. false means particle lost in aperture",
        validation_alias=pydantic.AliasChoices(
            "check_madx_aperture", "CHECK_MADX_APERTURE"
        ),
        serialization_alias="CHECK_MADX_APERTURE",
    )
    aperture_flag: bool = pydantic.Field(
        default=False,
        description="=.TRUE. aperture checks globally done (default)",
        validation_alias=pydantic.AliasChoices("aperture_flag", "APERTURE_FLAG"),
        serialization_alias="APERTURE_FLAG",
    )
    s_aperture_check: bool = pydantic.Field(
        default=False,
        description="=.TRUE. aperture checks globally done (default)",
        validation_alias=pydantic.AliasChoices("s_aperture_check", "s_aperture_CHECK"),
        serialization_alias="s_aperture_CHECK",
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
    hyperbolic_aperture: float = pydantic.Field(
        default=0.0,
        description="controls crashes in exponentials",
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
    nstd: int = pydantic.Field(
        default=0,
        description="number of steps and integration method",
        validation_alias=pydantic.AliasChoices("nstd", "NSTD"),
        serialization_alias="NSTD",
    )
    metd: int = pydantic.Field(
        default=0,
        description="number of steps and integration method",
        validation_alias=pydantic.AliasChoices("metd", "METD"),
        serialization_alias="METD",
    )
    madlength: bool = pydantic.Field(
        default=False,
        description="=.false. rbend crazy length in mad8 as input",
        validation_alias=pydantic.AliasChoices("madlength", "MADLENGTH"),
        serialization_alias="MADLENGTH",
    )
    mad: bool = pydantic.Field(
        default=False,
        description="=.false. mad definition of multipole for input only",
        validation_alias=pydantic.AliasChoices("mad", "MAD"),
        serialization_alias="MAD",
    )
    exact_model: bool = pydantic.Field(
        default=False,
        description="= .false. exact model used",
        validation_alias=pydantic.AliasChoices("exact_model", "EXACT_MODEL"),
        serialization_alias="EXACT_MODEL",
    )
    always_exactmis: bool = pydantic.Field(
        default=False,
        description="=.TRUE. exact formula in tracking used for that element",
        validation_alias=pydantic.AliasChoices("always_exactmis", "ALWAYS_EXACTMIS"),
        serialization_alias="ALWAYS_EXACTMIS",
    )
    always_knobs: bool = pydantic.Field(
        default=False,
        description="=.false. ptc knob default status",
        validation_alias=pydantic.AliasChoices("always_knobs", "ALWAYS_knobs"),
        serialization_alias="ALWAYS_knobs",
    )
    recirculator_cheat: bool = pydantic.Field(
        default=False,
        description="=.false.  if true energy patches use the time formula always",
    )
    sixtrack_compatible: bool = pydantic.Field(
        default=False,
        description="to insure some sixtrack compatibility default=false",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="REAL PILL B0X =1 , FAKE =0  default",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    highest_fringe: int = pydantic.Field(
        default=0,
        description="=2  quadrupole fringe ON IF FRINGE PRESENT",
        validation_alias=pydantic.AliasChoices("highest_fringe", "HIGHEST_FRINGE"),
        serialization_alias="HIGHEST_FRINGE",
    )
    do_beam_beam: bool = pydantic.Field(
        default=False,
        description="obvious meaning: false normally",
    )
    fibre_dir: int = pydantic.Field(
        default=0,
        description="=1 or -1 for reversed",
        validation_alias=pydantic.AliasChoices("fibre_dir", "FIBRE_DIR"),
        serialization_alias="FIBRE_DIR",
    )
    initial_charge: float = pydantic.Field(
        default=0.0,
        description="=1 or -1 AND  ADJUST THE MASS IS THE PREFERED MODE",
        validation_alias=pydantic.AliasChoices("initial_charge", "INITIAL_CHARGE"),
        serialization_alias="INITIAL_CHARGE",
    )
    fibre_flip: bool = pydantic.Field(
        default=False,
        description="=.true.",
        validation_alias=pydantic.AliasChoices("fibre_flip", "FIBRE_flip"),
        serialization_alias="FIBRE_flip",
    )
    eps_pos: float = pydantic.Field(
        default=0.0,
    )
    sector_nmul_max: int = pydantic.Field(
        default=0,
        description="= 10 maxwell equations is solved to order 10 in exact sectors",
        validation_alias=pydantic.AliasChoices("sector_nmul_max", "SECTOR_NMUL_MAX"),
        serialization_alias="SECTOR_NMUL_MAX",
    )
    sector_nmul: int = pydantic.Field(
        default=0,
        description="= 4  MULTIPOLES IN TEAPOT BEND ALLOWED BY DEFAULT",
        validation_alias=pydantic.AliasChoices("sector_nmul", "SECTOR_NMUL"),
        serialization_alias="SECTOR_NMUL",
    )
    wedge_coeff: Sequence[float] = pydantic.Field(
        default=0.0,
        description="QUAD_KICK IN WEDGE",
    )
    mad8_wedge: bool = pydantic.Field(
        default=False,
        description="QUAD_KICK + FRINGE IF FRINGE IS OUT.",
        validation_alias=pydantic.AliasChoices("mad8_wedge", "MAD8_WEDGE"),
        serialization_alias="MAD8_WEDGE",
    )
    electron: bool = pydantic.Field(
        default=False,
        description="electron if true otherwise proton",
    )
    massfactor: float = pydantic.Field(
        default=0.0,
        description="=one  sets variable muon and electron must be true",
    )
    compute_stoch_kick: bool = pydantic.Field(
        default=False,
        description="= .false. store stochastic kick for stochastic tracking",
    )
    feed_p0c: bool = pydantic.Field(
        default=False,
        description="=.FALSE.  work takes p0c instead of energy",
        validation_alias=pydantic.AliasChoices("feed_p0c", "FEED_P0C"),
        serialization_alias="FEED_P0C",
    )
    always_exact_patching: bool = pydantic.Field(
        default=False,
        description="=.TRUE. patching done correctly",
        validation_alias=pydantic.AliasChoices(
            "always_exact_patching", "ALWAYS_EXACT_PATCHING"
        ),
        serialization_alias="ALWAYS_EXACT_PATCHING",
    )
    stable_da: bool = pydantic.Field(
        default=False,
        description="=.true.  interrupts DA if check_da is true",
    )
    stable_da_pancake: bool = pydantic.Field(
        default=False,
        description="=.TRUE. particle status",
        validation_alias=pydantic.AliasChoices(
            "stable_da_pancake", "STABLE_DA_pancake"
        ),
        serialization_alias="STABLE_DA_pancake",
    )
    check_da: bool = pydantic.Field(
        default=False,
        description="=.true.",
    )
    old_implementation_of_sixtrack: bool = pydantic.Field(
        default=False,
        description="=.true.",
        validation_alias=pydantic.AliasChoices(
            "old_implementation_of_sixtrack", "OLD_IMPLEMENTATION_OF_SIXTRACK"
        ),
        serialization_alias="OLD_IMPLEMENTATION_OF_SIXTRACK",
    )
    phase0: float = pydantic.Field(
        default=0.0,
        description="default phase in cavity",
    )
    global_verbose: bool = pydantic.Field(
        default=False,
    )
    no_hyperbolic_in_normal_form: bool = pydantic.Field(
        default=False,
        description="unstable produces exception",
    )
    ndpt_bmad: int = pydantic.Field(
        default=0,
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


class SubTaylor(pydantic.BaseModel):
    """
    SubTaylor corresponds to bmad `sub_taylor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 78.

    Attributes
    ----------
    j : int
        Bmad type: INTEGER
    min : int
        Bmad type: INTEGER
    max : int
        Bmad type: INTEGER
    """

    j: Sequence[int] = pydantic.Field(
        default=0,
    )
    min: int = pydantic.Field(
        default=0,
    )
    max: int = pydantic.Field(
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


class UniversalTaylor(pydantic.BaseModel):
    """
    UniversalTaylor corresponds to bmad `UNIVERSAL_TAYLOR`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 94.

    Attributes
    ----------
    n : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER
    nv : int
        Number of coeeficients and number of variables
        Bmad type: INTEGER
    c : float
        Coefficients C(N)
        Bmad type: REAL
    j : int
        Exponents of each coefficients J(N,NV)
        Bmad type: INTEGER
    """

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


class CUniversalTaylor(pydantic.BaseModel):
    """
    CUniversalTaylor corresponds to bmad `c_UNIVERSAL_TAYLOR`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 100.

    Attributes
    ----------
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
    c : Complex
        Coefficients C(N)
        Bmad type: complex
        Fortran default: null()
    j : int
        Exponents of each coefficients J(N,NV)
        Bmad type: INTEGER
        Fortran default: null()
    """

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


class Complextaylor(pydantic.BaseModel):
    """
    Complextaylor corresponds to bmad `complextaylor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 106.

    Attributes
    ----------
    r : Taylor
        @1 Real part
        Bmad type: type
    i : Taylor
        @1 Imaginary part
        Bmad type: type
    """

    r: Taylor = pydantic.Field(
        default=None,
        description="@1 Real part",
    )
    i: Taylor = pydantic.Field(
        default=None,
        description="@1 Imaginary part",
    )


class Real8(pydantic.BaseModel):
    """
    Real8 corresponds to bmad `REAL_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 114.

    Attributes
    ----------
    t : Taylor
        @1  USED IF TAYLOR
        Bmad type: TYPE
    r : float
        @1    USED IF REAL
        Bmad type: REAL
    kind : int
        @1  0,1,2,3 (1=REAL,2=TAYLOR,3=TAYLOR KNOB, 0=SPECIAL)
        Bmad type: INTEGER
    i : int
        @1   USED FOR KNOBS AND SPECIAL KIND=0
        Bmad type: INTEGER
    s : float
        @1   SCALING FOR KNOBS AND SPECIAL KIND=0
        Bmad type: REAL
    alloc : bool
        @1 IF TAYLOR IS ALLOCATED IN DA-PACKAGE
        Bmad type: LOGICAL
    """

    t: Taylor = pydantic.Field(
        default=None,
        description="@1  USED IF TAYLOR",
        validation_alias=pydantic.AliasChoices("t", "T"),
        serialization_alias="T",
    )
    r: float = pydantic.Field(
        default=0.0,
        description="@1    USED IF REAL",
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
    )
    kind: int = pydantic.Field(
        default=0,
        description="@1  0,1,2,3 (1=REAL,2=TAYLOR,3=TAYLOR KNOB, 0=SPECIAL)",
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    i: int = pydantic.Field(
        default=0,
        description="@1   USED FOR KNOBS AND SPECIAL KIND=0",
        validation_alias=pydantic.AliasChoices("i", "I"),
        serialization_alias="I",
    )
    s: float = pydantic.Field(
        default=0.0,
        description="@1   SCALING FOR KNOBS AND SPECIAL KIND=0",
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    alloc: bool = pydantic.Field(
        default=False,
        description="@1 IF TAYLOR IS ALLOCATED IN DA-PACKAGE",
        validation_alias=pydantic.AliasChoices("alloc", "ALLOC"),
        serialization_alias="ALLOC",
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


class Quaternion8(pydantic.BaseModel):
    """
    Quaternion8 corresponds to bmad `quaternion_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 134.

    Attributes
    ----------
    x : Real8
        Bmad type: type
    """

    x: Sequence[Real8] = pydantic.Field(
        default=None,
    )


class Complex8(pydantic.BaseModel):
    """
    Complex8 corresponds to bmad `complex_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 140.

    Attributes
    ----------
    t : Complextaylor
        Bmad type: type
    r : Complex
        Bmad type: complex
    alloc : bool
        Bmad type: logical
    kind : int
        Bmad type: integer
    i : int
        Bmad type: integer
    j : int
        Bmad type: integer
    s : Complex
        Bmad type: complex
    """

    t: Complextaylor = pydantic.Field(
        default=None,
    )
    r: Complex = pydantic.Field(
        default=0.0,
    )
    alloc: bool = pydantic.Field(
        default=False,
    )
    kind: int = pydantic.Field(
        default=0,
    )
    i: int = pydantic.Field(
        default=0,
    )
    j: int = pydantic.Field(
        default=0,
    )
    s: Complex = pydantic.Field(
        default=0.0,
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
        Bmad type: type
    """

    x: Sequence[Real8] = pydantic.Field(
        default=None,
        max_length=3,
        description="x(3) = (s_x, s_y, s_z)   with  |s|=1",
    )


class Dascratch(pydantic.BaseModel):
    """
    Dascratch corresponds to bmad `dascratch`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 171.

    Attributes
    ----------
    t : Taylor
        Bmad type: type
    previous : Dascratch
        Bmad type: TYPE
    next : Dascratch
        Bmad type: TYPE
    """

    t: Taylor = pydantic.Field(
        default=None,
    )
    previous: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    next: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )


class Dalevel(pydantic.BaseModel):
    """
    Dalevel corresponds to bmad `dalevel`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 177.

    Attributes
    ----------
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
    closed : bool
        Bmad type: logical
    present : Dascratch
        Bmad type: TYPE
    end : Dascratch
        Bmad type: TYPE
    start : Dascratch
        Bmad type: TYPE
    start_ground : Dascratch
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: TYPE
    end_ground : Dascratch
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: TYPE
    """

    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    present: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("present", "PRESENT"),
        serialization_alias="PRESENT",
    )
    end: Dascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
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
    end_ground: Dascratch = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )


class Damap(pydantic.BaseModel):
    """
    Damap corresponds to bmad `DAMAP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 189.

    Attributes
    ----------
    v : Taylor
        Ndim2=6 but allocated to nd2=2,4,6 ! etienne_oct_2004
        Bmad type: TYPE
    """

    v: Sequence[Taylor] = pydantic.Field(
        default=None,
        description="Ndim2=6 but allocated to nd2=2,4,6 ! etienne_oct_2004",
        validation_alias=pydantic.AliasChoices("v", "V"),
        serialization_alias="V",
    )


class Gmap(pydantic.BaseModel):
    """
    Gmap corresponds to bmad `GMAP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 195.

    Attributes
    ----------
    v : Taylor
        Bmad type: TYPE
    n : int
        Bmad type: integer
    """

    v: Sequence[Taylor] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("v", "V"),
        serialization_alias="V",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )


class Vecfield(pydantic.BaseModel):
    """
    Vecfield corresponds to bmad `vecfield`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 201.

    Attributes
    ----------
    v : Taylor
        @1 <font face="Times New Roman">V<sub>i</sub>&#8706;<sub>i</sub></font>
        Operator
        Bmad type: type
    ifac : int
        @1 Type of Factorization 0,1,-1 (One exponent, Dragt-Finn, Reversed Dragt-Finn)
        Bmad type: integer
    """

    v: Sequence[Taylor] = pydantic.Field(
        default=None,
        description="@1 <font face='Times New Roman'>V<sub>i</sub>&#8706;<sub>i</sub></font> Operator",
    )
    ifac: int = pydantic.Field(
        default=0,
        description="@1 Type of Factorization 0,1,-1 (One exponent, Dragt-Finn, Reversed Dragt-Finn)",
    )


class Pbfield(pydantic.BaseModel):
    """
    Pbfield corresponds to bmad `pbfield`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 207.

    Attributes
    ----------
    h : Taylor
        Bmad type: type
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


class Tree(pydantic.BaseModel):
    """
    Tree corresponds to bmad `tree`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 215.

    Attributes
    ----------
    branch : Taylor
        Bmad type: type
    """

    branch: Sequence[Taylor] = pydantic.Field(
        default=None,
    )


class Dragtfinn(pydantic.BaseModel):
    """
    Dragtfinn corresponds to bmad `DRAGTFINN`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 226.

    Attributes
    ----------
    constant : float
        Bmad type: real
    linear : Damap
        Bmad type: type
    nonlinear : Vecfield
        Bmad type: type
    pb : Pbfield
        Bmad type: type
    """

    constant: Sequence[float] = pydantic.Field(
        default=0.0,
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


class Reversedragtfinn(pydantic.BaseModel):
    """
    Reversedragtfinn corresponds to bmad `reversedragtfinn`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 233.

    Attributes
    ----------
    constant : float
        Bmad type: real
    linear : Damap
        Bmad type: type
    nonlinear : Vecfield
        Bmad type: type
    pb : Pbfield
        Bmad type: type
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


class Onelieexponent(pydantic.BaseModel):
    """
    Onelieexponent corresponds to bmad `ONELIEEXPONENT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 240.

    Attributes
    ----------
    eps : float
        Bmad type: real
    vector : Vecfield
        Bmad type: type
    pb : Pbfield
        Bmad type: type
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


class Normalform(pydantic.BaseModel):
    """
    Normalform corresponds to bmad `normalform`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 247.

    Attributes
    ----------
    a_t : Damap
        Total A  :  A_t= A1 o A_rest
        Bmad type: type
    a1 : Damap
        @1 Dispersion
        Bmad type: type
    a : Reversedragtfinn
        @1 Linear A_t and nonlinear A_t
        Bmad type: type
    normal : Dragtfinn
        @1 Normal is the Normal Form R
        Bmad type: type
    dhdj : Damap
        @1 Contains the tunes in convenient form: extracted from NORMAL (=R)
        Bmad type: type
    tune : float
        @1 linear tune and linear damping
        Bmad type: real
    damping : float
        @1 linear tune and linear damping
        Bmad type: real
    nord : int
        @1 nord=1 A1 first order in parameters
        Bmad type: integer
    jtune : int
        @1 nord=1 A1 first order in parameters
        Bmad type: integer
    nres : int
        @1 NRES,M(NDIM,NRESO) -> resonances left in the map
        Bmad type: integer
    m : int
        @1 NRES,M(NDIM,NRESO) -> resonances left in the map
        Bmad type: integer
    plane : int
        @1 NRES,M(NDIM,NRESO) -> resonances left in the map
        Bmad type: integer
    auto : bool
        Bmad type: logical
    """

    a_t: Damap = pydantic.Field(
        default=None,
        description="Total A  :  A_t= A1 o A_rest",
        validation_alias=pydantic.AliasChoices("a_t", "A_t"),
        serialization_alias="A_t",
    )
    a1: Damap = pydantic.Field(
        default=None,
        description="@1 Dispersion",
        validation_alias=pydantic.AliasChoices("a1", "A1"),
        serialization_alias="A1",
    )
    a: Reversedragtfinn = pydantic.Field(
        default=None,
        description="@1 Linear A_t and nonlinear A_t",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    normal: Dragtfinn = pydantic.Field(
        default=None,
        description="@1 Normal is the Normal Form R",
        validation_alias=pydantic.AliasChoices("normal", "NORMAL"),
        serialization_alias="NORMAL",
    )
    dhdj: Damap = pydantic.Field(
        default=None,
        description="@1 Contains the tunes in convenient form: extracted from NORMAL (=R)",
        validation_alias=pydantic.AliasChoices("dhdj", "DHDJ"),
        serialization_alias="DHDJ",
    )
    tune: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 linear tune and linear damping",
        validation_alias=pydantic.AliasChoices("tune", "TUNE"),
        serialization_alias="TUNE",
    )
    damping: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 linear tune and linear damping",
        validation_alias=pydantic.AliasChoices("damping", "DAMPING"),
        serialization_alias="DAMPING",
    )
    nord: int = pydantic.Field(
        default=0,
        description="@1 nord=1 A1 first order in parameters",
    )
    jtune: int = pydantic.Field(
        default=0,
        description="@1 nord=1 A1 first order in parameters",
    )
    nres: int = pydantic.Field(
        default=0,
        description="@1 NRES,M(NDIM,NRESO) -> resonances left in the map",
        validation_alias=pydantic.AliasChoices("nres", "NRES"),
        serialization_alias="NRES",
    )
    m: Sequence[int] = pydantic.Field(
        default=0,
        description="@1 NRES,M(NDIM,NRESO) -> resonances left in the map",
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    plane: Sequence[int] = pydantic.Field(
        default=0,
        description="@1 NRES,M(NDIM,NRESO) -> resonances left in the map",
        validation_alias=pydantic.AliasChoices("plane", "PLANE"),
        serialization_alias="PLANE",
    )
    auto: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("auto", "AUTO"),
        serialization_alias="AUTO",
    )


class Genfield(pydantic.BaseModel):
    """
    Genfield corresponds to bmad `genfield`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 259.

    Attributes
    ----------
    h : Taylor
        Bmad type: type
    m : Damap
        Bmad type: type
    d : Taylor
        Bmad type: type
    linear : Damap
        Bmad type: type
    lineart : Damap
        Bmad type: type
    mt : Damap
        Bmad type: type
    constant : float
        Bmad type: real
    eps : float
        Bmad type: real
    imax : int
        @1 imax=Maximum Number of Iteration (default=1000)
        Bmad type: integer
    ifac : int
        @1 ifac = the map is raised to the power 1/ifac and iterated ifac times
        (default=1)
        Bmad type: integer
    linear_in : bool
        @1 Linear part is left in the map  (default=.false.)
        Bmad type: logical
    no_cut : int
        @1 Original map is not symplectic on and above no_cut
        Bmad type: integer
    """

    h: Taylor = pydantic.Field(
        default=None,
    )
    m: Damap = pydantic.Field(
        default=None,
    )
    d: Sequence[Taylor] = pydantic.Field(
        default=None,
    )
    linear: Damap = pydantic.Field(
        default=None,
    )
    lineart: Damap = pydantic.Field(
        default=None,
    )
    mt: Damap = pydantic.Field(
        default=None,
    )
    constant: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    imax: int = pydantic.Field(
        default=0,
        description="@1 imax=Maximum Number of Iteration (default=1000)",
    )
    ifac: int = pydantic.Field(
        default=0,
        description=(
            "@1 ifac = the map is raised to the power 1/ifac and iterated ifac times "
            "(default=1)"
        ),
    )
    linear_in: bool = pydantic.Field(
        default=False,
        description="@1 Linear part is left in the map  (default=.false.)",
    )
    no_cut: int = pydantic.Field(
        default=0,
        description="@1 Original map is not symplectic on and above no_cut",
    )


class Pbresonance(pydantic.BaseModel):
    """
    Pbresonance corresponds to bmad `pbresonance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 276.

    Attributes
    ----------
    cos : Pbfield
        Bmad type: type
    sin : Pbfield
        Bmad type: type
    ifac : int
        Bmad type: integer
    """

    cos: Pbfield = pydantic.Field(
        default=None,
    )
    sin: Pbfield = pydantic.Field(
        default=None,
    )
    ifac: int = pydantic.Field(
        default=0,
    )


class Vecresonance(pydantic.BaseModel):
    """
    Vecresonance corresponds to bmad `vecresonance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 281.

    Attributes
    ----------
    cos : Vecfield
        Bmad type: type
    sin : Vecfield
        Bmad type: type
    ifac : int
        Bmad type: integer
    """

    cos: Vecfield = pydantic.Field(
        default=None,
    )
    sin: Vecfield = pydantic.Field(
        default=None,
    )
    ifac: int = pydantic.Field(
        default=0,
    )


class Taylorresonance(pydantic.BaseModel):
    """
    Taylorresonance corresponds to bmad `taylorresonance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 286.

    Attributes
    ----------
    cos : Taylor
        Bmad type: type
    sin : Taylor
        Bmad type: type
    """

    cos: Taylor = pydantic.Field(
        default=None,
    )
    sin: Taylor = pydantic.Field(
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
    fixr : float
        Bmad type: real
    fix : float
        Bmad type: real
    fix0 : float
        Bmad type: real
    jl : int
        Bmad type: integer
    jv : int
        Bmad type: integer
    n : int
        Bmad type: INTEGER
    np : int
        Bmad type: INTEGER
    no : int
        Bmad type: INTEGER
    e_ij : float
        Bmad type: real
    rad : float
        Bmad type: real
    ds : float
        Bmad type: real
    beta0 : float
        Bmad type: real
    eps : float
        Bmad type: real
    symptrack : bool
        Bmad type: logical
    usenonsymp : bool
        Bmad type: logical
    factored : bool
        Bmad type: logical
    """

    cc: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("cc", "CC"),
        serialization_alias="CC",
    )
    fixr: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix0: Sequence[float] = pydantic.Field(
        default=0.0,
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
    no: int = pydantic.Field(
        default=0,
    )
    e_ij: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    rad: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ds: float = pydantic.Field(
        default=0.0,
    )
    beta0: float = pydantic.Field(
        default=0.0,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    symptrack: bool = pydantic.Field(
        default=False,
    )
    usenonsymp: bool = pydantic.Field(
        default=False,
    )
    factored: bool = pydantic.Field(
        default=False,
    )


class AffineFrame(pydantic.BaseModel):
    """
    AffineFrame corresponds to bmad `AFFINE_FRAME`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 4.

    Attributes
    ----------
    angle : float
        Bmad type: REAL
        Fortran default: null()
    d : float
        Bmad type: REAL
        Fortran default: null()
    a : float
        Bmad type: REAL
        Fortran default: null()
    ent : float
        Bmad type: REAL
        Fortran default: null()
    b : float
        Bmad type: REAL
        Fortran default: null()
    exi : float
        Bmad type: REAL
        Fortran default: null()
    """

    angle: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("angle", "ANGLE"),
        serialization_alias="ANGLE",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ent", "ENT"),
        serialization_alias="ENT",
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    exi: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("exi", "EXI"),
        serialization_alias="EXI",
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
    ent : float
        Bmad type: REAL
        Fortran default: null()
    o : float
        Bmad type: REAL
        Fortran default: null()
    mid : float
        Bmad type: REAL
        Fortran default: null()
    b : float
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
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ent", "ENT"),
        serialization_alias="ENT",
    )
    o: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("o", "O"),
        serialization_alias="O",
    )
    mid: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("mid", "MID"),
        serialization_alias="MID",
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    exi: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("exi", "EXI"),
        serialization_alias="EXI",
    )


class Patch(pydantic.BaseModel):
    """
    Patch corresponds to bmad `PATCH`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 23.

    Attributes
    ----------
    patch : int
        IF TRUE, SPACIAL PATCHES NEEDED
        Bmad type: INTEGER
        Fortran default: null()
    a_x1 : int
        FOR ROTATION OF PI AT ENTRANCE = -1, DEFAULT = 1 ,
        Bmad type: INTEGER
        Fortran default: null()
    a_x2 : int
        FOR ROTATION OF PI AT ENTRANCE = -1, DEFAULT = 1 ,
        Bmad type: INTEGER
        Fortran default: null()
    b_x1 : int
        FOR ROTATION OF PI AT EXIT = -1    , DEFAULT = 1
        Bmad type: INTEGER
        Fortran default: null()
    b_x2 : int
        FOR ROTATION OF PI AT EXIT = -1    , DEFAULT = 1
        Bmad type: INTEGER
        Fortran default: null()
    a_d : float
        ENTRACE AND EXIT TRANSLATIONS  A_D(3)
        Bmad type: REAL
        Fortran default: null()
    b_d : float
        ENTRACE AND EXIT TRANSLATIONS  A_D(3)
        Bmad type: REAL
        Fortran default: null()
    a_ang : float
        ENTRACE AND EXIT ROTATIONS    A_ANG(3)
        Bmad type: REAL
        Fortran default: null()
    b_ang : float
        ENTRACE AND EXIT ROTATIONS    A_ANG(3)
        Bmad type: REAL
        Fortran default: null()
    energy : int
        IF TRUE, ENERGY PATCHES NEEDED
        Bmad type: INTEGER
        Fortran default: null()
    time : int
        IF TRUE, TIME PATCHES NEEDED
        Bmad type: INTEGER
        Fortran default: null()
    a_t : float
        TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED
        Bmad type: REAL
        Fortran default: null()
    b_t : float
        TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED
        Bmad type: REAL
        Fortran default: null()
    a_l : float
        Bmad type: REAL
        Fortran default: null()
    b_l : float
        Bmad type: REAL
        Fortran default: null()
    p0b : float
        for bmad patching
        Bmad type: REAL
        Fortran default: null()
    b0b : float
        for bmad patching
        Bmad type: REAL
        Fortran default: null()
    track : bool
        Bmad type: logical
        Fortran default: null()
    """

    patch: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="IF TRUE, SPACIAL PATCHES NEEDED",
        validation_alias=pydantic.AliasChoices("patch", "PATCH"),
        serialization_alias="PATCH",
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
    a_d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT TRANSLATIONS  A_D(3)",
        validation_alias=pydantic.AliasChoices("a_d", "A_D"),
        serialization_alias="A_D",
    )
    b_d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT TRANSLATIONS  A_D(3)",
        validation_alias=pydantic.AliasChoices("b_d", "B_D"),
        serialization_alias="B_D",
    )
    a_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT ROTATIONS    A_ANG(3)",
        validation_alias=pydantic.AliasChoices("a_ang", "A_ANG"),
        serialization_alias="A_ANG",
    )
    b_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENTRACE AND EXIT ROTATIONS    A_ANG(3)",
        validation_alias=pydantic.AliasChoices("b_ang", "B_ANG"),
        serialization_alias="B_ANG",
    )
    energy: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="IF TRUE, ENERGY PATCHES NEEDED",
        validation_alias=pydantic.AliasChoices("energy", "ENERGY"),
        serialization_alias="ENERGY",
    )
    time: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="IF TRUE, TIME PATCHES NEEDED",
        validation_alias=pydantic.AliasChoices("time", "TIME"),
        serialization_alias="TIME",
    )
    a_t: float = pydantic.Field(
        default=0.0,
        description="TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED",
        validation_alias=pydantic.AliasChoices("a_t", "A_T"),
        serialization_alias="A_T",
    )
    b_t: float = pydantic.Field(
        default=0.0,
        description="TIME SHIFT NEEDED SOMETIMES WHEN RELATIVE TIME IS USED",
        validation_alias=pydantic.AliasChoices("b_t", "B_T"),
        serialization_alias="B_T",
    )
    a_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a_l", "A_L"),
        serialization_alias="A_L",
    )
    b_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_l", "B_L"),
        serialization_alias="B_L",
    )
    p0b: float = pydantic.Field(
        default=0.0,
        description="for bmad patching",
    )
    b0b: float = pydantic.Field(
        default=0.0,
        description="for bmad patching",
    )
    track: bool = pydantic.Field(
        default=False,
    )


class Chart(pydantic.BaseModel):
    """
    Chart corresponds to bmad `CHART`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 37.

    Attributes
    ----------
    f : MagnetFrame
        Bmad type: type
        Fortran default: null()
    d_in : float
        Bmad type: real
        Fortran default: null()
    ang_in : float
        Bmad type: real
        Fortran default: null()
    d_out : float
        Bmad type: real
        Fortran default: null()
    ang_out : float
        Bmad type: real
        Fortran default: null()
    """

    f: MagnetFrame = pydantic.Field(
        default=None,
    )
    d_in: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_in", "D_IN"),
        serialization_alias="D_IN",
    )
    ang_in: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ang_in", "ANG_IN"),
        serialization_alias="ANG_IN",
    )
    d_out: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_out", "D_OUT"),
        serialization_alias="D_OUT",
    )
    ang_out: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ang_out", "ANG_OUT"),
        serialization_alias="ANG_OUT",
    )


class PolSagan(pydantic.BaseModel):
    """
    PolSagan corresponds to bmad `POL_sagan`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 4.

    Attributes
    ----------
    ia : int
        Bmad type: INTEGER
    sa : float
        Bmad type: real
    """

    ia: Sequence[int] = pydantic.Field(
        default=0,
    )
    sa: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sa", "Sa"),
        serialization_alias="Sa",
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
        Bmad type: type
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


class UnduR(pydantic.BaseModel):
    """
    UnduR corresponds to bmad `undu_R`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 16.

    Attributes
    ----------
    k : float
        Bmad type: real
        Fortran default: null()
    a : float
        Bmad type: real
        Fortran default: null()
    f : float
        Bmad type: real
        Fortran default: null()
    x0 : float
        Bmad type: real
        Fortran default: null()
    y0 : float
        Bmad type: real
        Fortran default: null()
    ke : float
        Bmad type: real
        Fortran default: null()
    ae : float
        Bmad type: real
        Fortran default: null()
    fe : float
        Bmad type: real
        Fortran default: null()
    x0e : float
        Bmad type: real
        Fortran default: null()
    y0e : float
        Bmad type: real
        Fortran default: null()
    ex : float
        Bmad type: real
        Fortran default: null()
    ey : float
        Bmad type: real
        Fortran default: null()
    offset : float
        Bmad type: real
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: null()
    ne : int
        Bmad type: integer
        Fortran default: null()
    form : int
        Bmad type: integer
        Fortran default: null()
    forme : int
        Bmad type: integer
        Fortran default: null()
    """

    k: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    x0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ke: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ke", "KE"),
        serialization_alias="KE",
    )
    ae: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    fe: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fe", "FE"),
        serialization_alias="FE",
    )
    x0e: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("x0e", "x0E"),
        serialization_alias="x0E",
    )
    y0e: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("y0e", "y0E"),
        serialization_alias="y0E",
    )
    ex: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ey: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    offset: float = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
    )
    ne: int = pydantic.Field(
        default=0,
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


class UnduP(pydantic.BaseModel):
    """
    UnduP corresponds to bmad `undu_p`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 34.

    Attributes
    ----------
    k : Real8
        Bmad type: TYPE
        Fortran default: null()
    a : Real8
        Bmad type: TYPE
        Fortran default: null()
    f : Real8
        Bmad type: TYPE
        Fortran default: null()
    x0 : Real8
        Bmad type: TYPE
        Fortran default: null()
    y0 : Real8
        Bmad type: TYPE
        Fortran default: null()
    ke : Real8
        Bmad type: TYPE
        Fortran default: null()
    ae : Real8
        Bmad type: TYPE
        Fortran default: null()
    fe : Real8
        Bmad type: TYPE
        Fortran default: null()
    x0e : Real8
        Bmad type: TYPE
        Fortran default: null()
    y0e : Real8
        Bmad type: TYPE
        Fortran default: null()
    ex : float
        Bmad type: real
        Fortran default: null()
    ey : float
        Bmad type: real
        Fortran default: null()
    offset : Real8
        Bmad type: TYPE
    n : int
        Bmad type: integer
        Fortran default: null()
    ne : int
        Bmad type: integer
        Fortran default: null()
    form : int
        Bmad type: integer
        Fortran default: null()
    forme : int
        Bmad type: integer
        Fortran default: null()
    """

    k: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    a: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    f: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    x0: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    y0: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    ke: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ke", "KE"),
        serialization_alias="KE",
    )
    ae: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    fe: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("fe", "FE"),
        serialization_alias="FE",
    )
    x0e: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("x0e", "x0E"),
        serialization_alias="x0E",
    )
    y0e: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("y0e", "y0E"),
        serialization_alias="y0E",
    )
    ex: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ey: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    offset: Real8 = pydantic.Field(
        default=None,
    )
    n: int = pydantic.Field(
        default=0,
    )
    ne: int = pydantic.Field(
        default=0,
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


class Sagan(pydantic.BaseModel):
    """
    Sagan corresponds to bmad `SAGAN`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 52.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        MUST ALWAYS BE THERE
        Bmad type: real
        Fortran default: null()
    n_min : int
        Bmad type: integer
        Fortran default: null()
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
    xprime : bool
        Bmad type: LOGICAL
        Fortran default: null()
    w : UnduR
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="MUST ALWAYS BE THERE",
    )
    n_min: int = pydantic.Field(
        default=0,
    )
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
    xprime: bool = pydantic.Field(
        default=False,
    )
    w: UnduR = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("w", "W"),
        serialization_alias="W",
    )


class Saganp(pydantic.BaseModel):
    """
    Saganp corresponds to bmad `SAGANP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 63.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        MUST ALWAYS BE THERE
        Bmad type: TYPE
        Fortran default: null()
    n_min : int
        Bmad type: integer
        Fortran default: null()
    an : Real8
        Multipole component (OPTIONAL)
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component (OPTIONAL)
        Bmad type: TYPE
        Fortran default: null()
    internal : Real8
        INTERNAL IS AN EXAMPLE
        Bmad type: TYPE
        Fortran default: null()
    xprime : bool
        Bmad type: LOGICAL
        Fortran default: null()
    w : UnduP
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="MUST ALWAYS BE THERE",
    )
    n_min: int = pydantic.Field(
        default=0,
    )
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
    xprime: bool = pydantic.Field(
        default=False,
    )
    w: UnduP = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("w", "W"),
        serialization_alias="W",
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


class CLatticeFunction(pydantic.BaseModel):
    """
    CLatticeFunction corresponds to bmad `c_lattice_function`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 16.

    Attributes
    ----------
    e : float
        Bmad type: real
        Fortran default: 0
    k : float
        Bmad type: real
        Fortran default: 0
    h : float
        Bmad type: real
        Fortran default: 0
    b : float
        Bmad type: real
        Fortran default: 0
    s : float
        Bmad type: real
        Fortran default: 0
    phase : float
        Bmad type: real
        Fortran default: 0
    damping : float
        Bmad type: real
        Fortran default: 0
    spin : float
        Bmad type: real
        Fortran default: 0
    fix : float
        Bmad type: real
        Fortran default: 0
    f : Fibre
        Bmad type: type
        Fortran default: null()
    t : IntegrationNode
        Bmad type: type
        Fortran default: null()
    symplectic : bool
        Bmad type: logical
        Fortran default: .true.
    sigmas : float
        Bmad type: real
    """

    e: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    k: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("k", "K"),
        serialization_alias="K",
    )
    h: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("h", "H"),
        serialization_alias="H",
    )
    b: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    s: Sequence[float] = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    phase: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
    )
    damping: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
    )
    spin: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    fix: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
    )
    f: Fibre = pydantic.Field(
        default=None,
    )
    t: IntegrationNode = pydantic.Field(
        default=None,
    )
    symplectic: bool = pydantic.Field(
        default=True,
    )
    sigmas: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Girder(pydantic.BaseModel):
    """
    Girder corresponds to bmad `girder`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 53.

    Attributes
    ----------
    i : int
        Bmad type: INTEGER
        Fortran default: null()
    pos : int
        Bmad type: INTEGER
        Fortran default: null()
    mul : int
        number of magnets in the girder
        Bmad type: INTEGER
        Fortran default: null()
    added : int
        Bmad type: INTEGER
        Fortran default: null()
    discarded : int
        Bmad type: INTEGER
        Fortran default: null()
    a : float
        Bmad type: real
        Fortran default: null()
    ent : float
        Bmad type: real
        Fortran default: null()
    info : GirderInfo
        Bmad type: TYPE
        Fortran default: null()
    previous : Girder
        Terminated link list
        Bmad type: TYPE
        Fortran default: null()
    next : Girder
        Bmad type: TYPE
        Fortran default: null()
    """

    i: int = pydantic.Field(
        default=0,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    mul: int = pydantic.Field(
        default=0,
        description="number of magnets in the girder",
    )
    added: int = pydantic.Field(
        default=0,
    )
    discarded: int = pydantic.Field(
        default=0,
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    info: GirderInfo = pydantic.Field(
        default=None,
    )
    previous: Girder = pydantic.Field(
        default=None,
        description="Terminated link list",
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    next: Girder = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
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
    d : float
        Bmad type: real
        Fortran default: null()
    mag : Element
        Bmad type: type
        Fortran default: null()
    a : float
        Bmad type: real
        Fortran default: null()
    ent : float
        Bmad type: real
        Fortran default: null()
    parent_girder : Girder
        Bmad type: type
        Fortran default: null()
    next : GirderInfo
        Terminated link list
        Bmad type: TYPE
        Fortran default: null()
    """

    name: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    mag: Element = pydantic.Field(
        default=None,
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    parent_girder: Girder = pydantic.Field(
        default=None,
    )
    next: GirderInfo = pydantic.Field(
        default=None,
        description="Terminated link list",
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )


class GirderList(pydantic.BaseModel):
    """
    GirderList corresponds to bmad `girder_list`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 74.

    Attributes
    ----------
    name : str
        IDENTIFICATION
        Bmad type: CHARACTER
        Fortran default: null()
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
        Fortran default: null()
    discarded : int
        duplicate magnets
        Bmad type: INTEGER
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    last : Girder
        LAST VISITED
        Bmad type: TYPE
        Fortran default: null()
    end : Girder
        Bmad type: TYPE
        Fortran default: null()
    start : Girder
        Bmad type: TYPE
        Fortran default: null()
    lastfibre : Fibre
        Bmad type: type
        Fortran default: null()
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    discarded: int = pydantic.Field(
        default=0,
        description="duplicate magnets",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    last: Girder = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )
    end: Girder = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    start: Girder = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )
    lastfibre: Fibre = pydantic.Field(
        default=None,
    )


class MulBlock(pydantic.BaseModel):
    """
    MulBlock corresponds to bmad `MUL_BLOCK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 90.

    Attributes
    ----------
    an : float
        Bmad type: real
    bn : float
        Bmad type: real
    nmul : int
        Bmad type: INTEGER
    natural : int
        Bmad type: INTEGER
    add : int
        Bmad type: INTEGER
    """

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
    nmul: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nmul", "NMUL"),
        serialization_alias="NMUL",
    )
    natural: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("natural", "NATURAL"),
        serialization_alias="NATURAL",
    )
    add: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("add", "ADD"),
        serialization_alias="ADD",
    )


class Work(pydantic.BaseModel):
    """
    Work corresponds to bmad `work`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 96.

    Attributes
    ----------
    beta0 : float
        Bmad type: real
    energy : float
        Bmad type: real
    kinetic : float
        Bmad type: real
    p0c : float
        Bmad type: real
    brho : float
        Bmad type: real
    gamma0i : float
        Bmad type: real
    gambet : float
        Bmad type: real
    mass : float
        Bmad type: real
    rescale : bool
        Bmad type: LOGICAL
    power : int
        Bmad type: integer
    """

    beta0: float = pydantic.Field(
        default=0.0,
    )
    energy: float = pydantic.Field(
        default=0.0,
    )
    kinetic: float = pydantic.Field(
        default=0.0,
    )
    p0c: float = pydantic.Field(
        default=0.0,
    )
    brho: float = pydantic.Field(
        default=0.0,
    )
    gamma0i: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("gamma0i", "gamma0I"),
        serialization_alias="gamma0I",
    )
    gambet: float = pydantic.Field(
        default=0.0,
    )
    mass: float = pydantic.Field(
        default=0.0,
    )
    rescale: bool = pydantic.Field(
        default=False,
    )
    power: int = pydantic.Field(
        default=0,
    )


class InternalState_(pydantic.BaseModel):
    """
    InternalState_ corresponds to bmad `INTERNAL_STATE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 104.

    Attributes
    ----------
    totalpath : int
        total time or path length is used
        Bmad type: INTEGER
    time : bool
        Time is used instead of path length
        Bmad type: LOGICAL
    radiation : bool
        Radiation is turned on
        Bmad type: LOGICAL
    nocavity : bool
        Cavity is turned into a drift
        Bmad type: LOGICAL
    fringe : bool
        Fringe fields are turned on (mainly for quadrupoles)
        Bmad type: LOGICAL
    stochastic : bool
        Random Stochastic kicks to x(5)
        Bmad type: LOGICAL
    envelope : bool
        Stochastic envelope terms tracked in probe_8
        Bmad type: LOGICAL
    para_in : bool
        If true, parameters in the map are included
        Bmad type: LOGICAL
    only_4d : bool
        REAL_8 Taylor in (x,p_x,y,p_y)
        Bmad type: LOGICAL
    delta : bool
        REAL_8 Taylor in (x,p_x,y,p_y,delta)
        Bmad type: LOGICAL
    spin : bool
        Spin is tracked
        Bmad type: LOGICAL
    modulation : bool
        One modulated family tracked by probe
        Bmad type: LOGICAL
    only_2d : bool
        REAL_8 Taylor in (x,p_x)
        Bmad type: LOGICAL
    full_way : bool
        Bmad type: LOGICAL
    """

    totalpath: int = pydantic.Field(
        default=0,
        description="total time or path length is used",
        validation_alias=pydantic.AliasChoices("totalpath", "TOTALPATH"),
        serialization_alias="TOTALPATH",
    )
    time: bool = pydantic.Field(
        default=False,
        description="Time is used instead of path length",
        validation_alias=pydantic.AliasChoices("time", "TIME"),
        serialization_alias="TIME",
    )
    radiation: bool = pydantic.Field(
        default=False,
        description="Radiation is turned on",
        validation_alias=pydantic.AliasChoices("radiation", "RADIATION"),
        serialization_alias="RADIATION",
    )
    nocavity: bool = pydantic.Field(
        default=False,
        description="Cavity is turned into a drift",
        validation_alias=pydantic.AliasChoices("nocavity", "NOCAVITY"),
        serialization_alias="NOCAVITY",
    )
    fringe: bool = pydantic.Field(
        default=False,
        description="Fringe fields are turned on (mainly for quadrupoles)",
        validation_alias=pydantic.AliasChoices("fringe", "FRINGE"),
        serialization_alias="FRINGE",
    )
    stochastic: bool = pydantic.Field(
        default=False,
        description="Random Stochastic kicks to x(5)",
        validation_alias=pydantic.AliasChoices("stochastic", "STOCHASTIC"),
        serialization_alias="STOCHASTIC",
    )
    envelope: bool = pydantic.Field(
        default=False,
        description="Stochastic envelope terms tracked in probe_8",
        validation_alias=pydantic.AliasChoices("envelope", "ENVELOPE"),
        serialization_alias="ENVELOPE",
    )
    para_in: bool = pydantic.Field(
        default=False,
        description="If true, parameters in the map are included",
        validation_alias=pydantic.AliasChoices("para_in", "PARA_IN"),
        serialization_alias="PARA_IN",
    )
    only_4d: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x,y,p_y)",
        validation_alias=pydantic.AliasChoices("only_4d", "ONLY_4D"),
        serialization_alias="ONLY_4D",
    )
    delta: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x,y,p_y,delta)",
        validation_alias=pydantic.AliasChoices("delta", "DELTA"),
        serialization_alias="DELTA",
    )
    spin: bool = pydantic.Field(
        default=False,
        description="Spin is tracked",
        validation_alias=pydantic.AliasChoices("spin", "SPIN"),
        serialization_alias="SPIN",
    )
    modulation: bool = pydantic.Field(
        default=False,
        description="One modulated family tracked by probe",
        validation_alias=pydantic.AliasChoices("modulation", "MODULATION"),
        serialization_alias="MODULATION",
    )
    only_2d: bool = pydantic.Field(
        default=False,
        description="REAL_8 Taylor in (x,p_x)",
        validation_alias=pydantic.AliasChoices("only_2d", "ONLY_2D"),
        serialization_alias="ONLY_2D",
    )
    full_way: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("full_way", "FULL_WAY"),
        serialization_alias="FULL_WAY",
    )


class PolBlock(pydantic.BaseModel):
    """
    PolBlock corresponds to bmad `POL_BLOCK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 123.

    Attributes
    ----------
    name : str
        Bmad type: CHARACTER
    n_name : int
        Bmad type: integer
    vorname : str
        Bmad type: CHARACTER
    tpsafit : float
        Bmad type: real
        Fortran default: null()
    set_tpsafit : bool
        Bmad type: LOGICAL
        Fortran default: null()
    set_element : bool
        Bmad type: LOGICAL
        Fortran default: null()
    npara : int
        Bmad type: INTEGER
    ian : int
        Bmad type: INTEGER
    ibn : int
        Bmad type: INTEGER
    san : float
        Bmad type: real
    sbn : float
        Bmad type: real
    ivolt : int
        Bmad type: INTEGER
    ifreq : int
        Bmad type: INTEGER
    iphas : int
        Bmad type: INTEGER
    ib_sol : int
        Bmad type: INTEGER
    svolt : float
        Bmad type: real
    sfreq : float
        Bmad type: real
    sphas : float
        Bmad type: real
    sb_sol : float
        Bmad type: real
    g : int
        group index  number of blocks
        Bmad type: integer
    np : int
        group index  number of blocks
        Bmad type: integer
    nb : int
        group index  number of blocks
        Bmad type: integer
    sagan : PolBlockSagan
        Bmad type: TYPE
    """

    name: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    n_name: int = pydantic.Field(
        default=0,
    )
    vorname: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    tpsafit: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tpsafit", "TPSAFIT"),
        serialization_alias="TPSAFIT",
    )
    set_tpsafit: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("set_tpsafit", "SET_TPSAFIT"),
        serialization_alias="SET_TPSAFIT",
    )
    set_element: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("set_element", "SET_ELEMENT"),
        serialization_alias="SET_ELEMENT",
    )
    npara: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("npara", "NPARA"),
        serialization_alias="NPARA",
    )
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
    ivolt: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ivolt", "IVOLT"),
        serialization_alias="IVOLT",
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
    ib_sol: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ib_sol", "IB_SOL"),
        serialization_alias="IB_SOL",
    )
    svolt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("svolt", "SVOLT"),
        serialization_alias="SVOLT",
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
    sb_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("sb_sol", "SB_SOL"),
        serialization_alias="SB_SOL",
    )
    g: int = pydantic.Field(
        default=0,
        description="group index  number of blocks",
    )
    np: int = pydantic.Field(
        default=0,
        description="group index  number of blocks",
    )
    nb: int = pydantic.Field(
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
    beta : int
        Bmad type: INTEGER
    alfa : int
        Bmad type: INTEGER
    dispersion : int
        Bmad type: INTEGER
    """

    beta: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("beta", "BETA"),
        serialization_alias="BETA",
    )
    alfa: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("alfa", "ALFA"),
        serialization_alias="ALFA",
    )
    dispersion: Sequence[int] = pydantic.Field(
        default=0,
        max_length=4,
        validation_alias=pydantic.AliasChoices("dispersion", "DISPERSION"),
        serialization_alias="DISPERSION",
    )


class MadxAperture(pydantic.BaseModel):
    """
    MadxAperture corresponds to bmad `MADX_APERTURE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 151.

    Attributes
    ----------
    pos : int
        Bmad type: integer
        Fortran default: null()
    kind : int
        1,2,3,4
        Bmad type: INTEGER
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
    dx : float
        Bmad type: REAL
        Fortran default: null()
    dy : float
        Bmad type: REAL
        Fortran default: null()
    polygx : float
        arbitrary polygon
        Bmad type: REAL
        Fortran default: null()
    polygy : float
        arbitrary polygon
        Bmad type: REAL
        Fortran default: null()
    polygn : int
        arbitrary polygon number of points
        Bmad type: INTEGER
        Fortran default: null()
    """

    pos: int = pydantic.Field(
        default=0,
    )
    kind: int = pydantic.Field(
        default=0,
        description="1,2,3,4",
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
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
    polygn: int = pydantic.Field(
        default=0,
        description="arbitrary polygon number of points",
        validation_alias=pydantic.AliasChoices("polygn", "POLYGN"),
        serialization_alias="POLYGN",
    )


class SAperture(pydantic.BaseModel):
    """
    SAperture corresponds to bmad `S_APERTURE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 160.

    Attributes
    ----------
    aperture : MadxAperture
        Bmad type: type
        Fortran default: null()
    """

    aperture: MadxAperture = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("aperture", "APERTURE"),
        serialization_alias="APERTURE",
    )


class MagnetChart(pydantic.BaseModel):
    """
    MagnetChart corresponds to bmad `MAGNET_CHART`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 165.

    Attributes
    ----------
    f : MagnetFrame
        position magnets within the fibre (same as fibre if not misaligned)
        Bmad type: type
        Fortran default: null()
    aperture : MadxAperture
        apertures in Magnets
        Bmad type: type
        Fortran default: null()
    a : SAperture
        never used : different aperture at every node
        Bmad type: type
        Fortran default: null()
    charge : float
        propagator
        Bmad type: real
        Fortran default: null()
    dir : int
        propagator
        Bmad type: integer
        Fortran default: null()
    beta0 : float
        Bmad type: real
        Fortran default: null()
    gamma0i : float
        Bmad type: real
        Fortran default: null()
    gambet : float
        Bmad type: real
        Fortran default: null()
    mass : float
        Bmad type: real
        Fortran default: null()
    ag : float
        Bmad type: real
        Fortran default: null()
    p0c : float
        Bmad type: real
        Fortran default: null()
    ld : float
        arc length  and cord length
        Bmad type: real
        Fortran default: null()
    b0 : float
        arc length  and cord length
        Bmad type: real
        Fortran default: null()
    lc : float
        arc length  and cord length
        Bmad type: real
        Fortran default: null()
    tiltd : float
        INTERNAL FRAME design tilt
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
    kill_ent_fringe : bool
        Bmad type: LOGICAL
        Fortran default: null()
    kill_exi_fringe : bool
        Bmad type: LOGICAL
        Fortran default: null()
    bend_fringe : bool
        Bmad type: LOGICAL
        Fortran default: null()
    kill_ent_spin : bool
        Bmad type: LOGICAL
        Fortran default: null()
    kill_exi_spin : bool
        Bmad type: LOGICAL
        Fortran default: null()
    permfringe : int
        highest_fringe = 2 by default            !
        Bmad type: integer
        Fortran default: null()
    highest_fringe : int
        highest_fringe = 2 by default            !
        Bmad type: integer
        Fortran default: null()
    method : int
        METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps
        Bmad type: INTEGER
        Fortran default: null()
    nst : int
        METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps
        Bmad type: INTEGER
        Fortran default: null()
    nmul : int
        NUMBER OF MULTIPOLE   ! nmul maximum multipole
        Bmad type: INTEGER
        Fortran default: null()
    """

    f: MagnetFrame = pydantic.Field(
        default=None,
        description="position magnets within the fibre (same as fibre if not misaligned)",
    )
    aperture: MadxAperture = pydantic.Field(
        default=None,
        description="apertures in Magnets",
        validation_alias=pydantic.AliasChoices("aperture", "APERTURE"),
        serialization_alias="APERTURE",
    )
    a: Sequence[SAperture] = pydantic.Field(
        default=None,
        description="never used : different aperture at every node",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    charge: float = pydantic.Field(
        default=0.0,
        description="propagator",
    )
    dir: int = pydantic.Field(
        default=0,
        description="propagator",
    )
    beta0: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("beta0", "BETA0"),
        serialization_alias="BETA0",
    )
    gamma0i: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("gamma0i", "GAMMA0I"),
        serialization_alias="GAMMA0I",
    )
    gambet: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("gambet", "GAMBET"),
        serialization_alias="GAMBET",
    )
    mass: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("mass", "MASS"),
        serialization_alias="MASS",
    )
    ag: float = pydantic.Field(
        default=0.0,
    )
    p0c: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("p0c", "P0C"),
        serialization_alias="P0C",
    )
    ld: float = pydantic.Field(
        default=0.0,
        description="arc length  and cord length",
        validation_alias=pydantic.AliasChoices("ld", "LD"),
        serialization_alias="LD",
    )
    b0: float = pydantic.Field(
        default=0.0,
        description="arc length  and cord length",
        validation_alias=pydantic.AliasChoices("b0", "B0"),
        serialization_alias="B0",
    )
    lc: float = pydantic.Field(
        default=0.0,
        description="arc length  and cord length",
        validation_alias=pydantic.AliasChoices("lc", "LC"),
        serialization_alias="LC",
    )
    tiltd: float = pydantic.Field(
        default=0.0,
        description="INTERNAL FRAME design tilt",
        validation_alias=pydantic.AliasChoices("tiltd", "TILTD"),
        serialization_alias="TILTD",
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
    kill_ent_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_ent_fringe", "KILL_ENT_FRINGE"),
        serialization_alias="KILL_ENT_FRINGE",
    )
    kill_exi_fringe: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_exi_fringe", "KILL_EXI_FRINGE"),
        serialization_alias="KILL_EXI_FRINGE",
    )
    bend_fringe: bool = pydantic.Field(
        default=False,
    )
    kill_ent_spin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_ent_spin", "KILL_ENT_SPIN"),
        serialization_alias="KILL_ENT_SPIN",
    )
    kill_exi_spin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("kill_exi_spin", "KILL_EXI_SPIN"),
        serialization_alias="KILL_EXI_SPIN",
    )
    permfringe: int = pydantic.Field(
        default=0,
        description="highest_fringe = 2 by default            !",
        validation_alias=pydantic.AliasChoices("permfringe", "permFRINGE"),
        serialization_alias="permFRINGE",
    )
    highest_fringe: int = pydantic.Field(
        default=0,
        description="highest_fringe = 2 by default            !",
    )
    method: int = pydantic.Field(
        default=0,
        description="METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps",
        validation_alias=pydantic.AliasChoices("method", "METHOD"),
        serialization_alias="METHOD",
    )
    nst: int = pydantic.Field(
        default=0,
        description="METHOD OF INTEGRATION 2,4,OR 6 YOSHIDA ! nst= number of steps",
        validation_alias=pydantic.AliasChoices("nst", "NST"),
        serialization_alias="NST",
    )
    nmul: int = pydantic.Field(
        default=0,
        description="NUMBER OF MULTIPOLE   ! nmul maximum multipole",
        validation_alias=pydantic.AliasChoices("nmul", "NMUL"),
        serialization_alias="NMUL",
    )


class Tilting(pydantic.BaseModel):
    """
    Tilting corresponds to bmad `tilting`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 188.

    Attributes
    ----------
    tilt : float
        Bmad type: real
    natural : bool
        for mad-like
        Bmad type: LOGICAL
    """

    tilt: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    natural: bool = pydantic.Field(
        default=False,
        description="for mad-like",
    )


class TimeEnergy(pydantic.BaseModel):
    """
    TimeEnergy corresponds to bmad `time_energy`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 193.

    Attributes
    ----------
    time : float
        Bmad type: real
        Fortran default: null()
    energy : float
        Bmad type: real
        Fortran default: null()
    an : float
        Bmad type: real
        Fortran default: null()
    bn : float
        Bmad type: real
        Fortran default: null()
    b_t : float
        Bmad type: real
        Fortran default: null()
    """

    time: float = pydantic.Field(
        default=0.0,
    )
    energy: float = pydantic.Field(
        default=0.0,
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_t: float = pydantic.Field(
        default=0.0,
    )


class Ramping(pydantic.BaseModel):
    """
    Ramping corresponds to bmad `ramping`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 200.

    Attributes
    ----------
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
        Bmad type: type
        Fortran default: null()
    file : str
        Bmad type: character
        Fortran default: null()
    """

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
    file: str = pydantic.Field(
        default_factory=list,
        max_length=255,
    )


class Element(pydantic.BaseModel):
    """
    Element corresponds to bmad `ELEMENT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 210.

    Attributes
    ----------
    kind : int
        Bmad type: INTEGER
        Fortran default: null()
    old_integrator : int
        Bmad type: INTEGER
        Fortran default: null()
    recut : bool
        Bmad type: logical
    even : bool
        Bmad type: logical
        Fortran default: null()
    probe : bool
        Bmad type: logical
        Fortran default: null()
    plot : bool
        Bmad type: LOGICAL
        Fortran default: null()
    electric : bool
        type teapot can be electric
        Bmad type: LOGICAL
        Fortran default: null()
    filef : str
        maps replacing ptc
        Bmad type: character
    fileb : str
        Bmad type: character
    p : MagnetChart
        Bmad type: type
        Fortran default: null()
    name : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    vorname : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    L : float
        Length of integration often same as LD
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
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
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
    va : float
        use in quad fringe from sad
        Bmad type: real
        Fortran default: null()
    vs : float
        use in quad fringe from sad
        Bmad type: real
        Fortran default: null()
    volt : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    freq : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    phas : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    delta_e : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    lag : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    dc_ac : float
        slow RF: amplitude and phase
        Bmad type: real
        Fortran default: null()
    a_ac : float
        slow RF: amplitude and phase
        Bmad type: real
        Fortran default: null()
    theta_ac : float
        slow RF: amplitude and phase
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
    d0_an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    d0_bn : float
        Multipole component
        Bmad type: real
        Fortran default: null();
    d_volt : float
        Bmad type: real
        Fortran default: null()
    d0_volt : float
        Bmad type: real
        Fortran default: null();
    d_phas : float
        Bmad type: real
        Fortran default: null()
    d0_phas : float
        Bmad type: real
        Fortran default: null();
    thin : bool
        Bmad type: logical
        Fortran default: null()
    slow_ac : int
        magnet modulation
        Bmad type: integer
        Fortran default: null()
    b_sol : float
        Bmad type: real
        Fortran default: null()
    mis : bool
        migalignment on or off
        Bmad type: logical
        Fortran default: null()
    d0 : Drift1
        DRIFT
        Bmad type: TYPE
        Fortran default: null()
    k2 : Dkd2
        INTEGRATOR  $
        Bmad type: TYPE
        Fortran default: null()
    k3 : Kickt3
        THIN KICK
        Bmad type: TYPE
        Fortran default: null()
    c4 : Cav4
        CAVITY  $
        Bmad type: TYPE
        Fortran default: null()
    s5 : Sol5
        solenoid  $
        Bmad type: TYPE
        Fortran default: null()
    t6 : Ktk
        INTEGRATOR   thick slow
        Bmad type: TYPE
        Fortran default: null()
    t7 : Tktf
        INTEGRATOR   thick fast   $
        Bmad type: TYPE
        Fortran default: null()
    s8 : Nsmi
        NORMAL SMI Sixtrack shit
        Bmad type: TYPE
        Fortran default: null()
    s9 : Ssmi
        SKEW SMI Sixtrack shit
        Bmad type: TYPE
        Fortran default: null()
    tp10 : Teapot
        sector teapot exact sector bend electric or magnetic $
        Bmad type: TYPE
        Fortran default: null()
    mon14 : Mon
        MONITOR OR INSTRUMENT
        Bmad type: TYPE
        Fortran default: null()
    sep15 : Eseptum
        MONITOR OR INSTRUMENT electric kicker
        Bmad type: TYPE
        Fortran default: null()
    k16 : Strex
        EXACT STRAIGHT INTEGRATOR  $
        Bmad type: TYPE
        Fortran default: null()
    enge17 : Enge
        not implemented
        Bmad type: TYPE
        Fortran default: null()
    rcol18 : Rcol
        RCOLLIMATOR
        Bmad type: TYPE
        Fortran default: null()
    ecol19 : Ecol
        ECOLLIMATOR
        Bmad type: TYPE
        Fortran default: null()
    cav21 : CavTrav
        CAVITY TRAVELLING WAVE  (not symplectic)
        Bmad type: TYPE
        Fortran default: null()
    wi : Sagan
        USER DEFINED  undulator exact =.false.
        Bmad type: TYPE
        Fortran default: null()
    pa : Pancake
        GENERAL B represented as Taylor
        Bmad type: TYPE
        Fortran default: null()
    ab : Abell
        TYPE ABELL
        Bmad type: TYPE
        Fortran default: null()
    he22 : HelicalDipole
        exact =false otherwise not correct
        Bmad type: TYPE
        Fortran default: null()
    sdr : Superdrift
        GENERAL DRIFT
        Bmad type: TYPE
        Fortran default: null()
    parent_fibre : Fibre
        in the database universe
        Bmad type: TYPE
        Fortran default: null()
    doko : FibreAppearance
        all appearances
        Bmad type: TYPE
        Fortran default: null()
    siamese : Element
        magnets somewhat glued together
        Bmad type: type
        Fortran default: null()
    girders : Element
        magnets on a girder
        Bmad type: type
        Fortran default: null()
    siamese_frame : AffineFrame
        Bmad type: TYPE
        Fortran default: null()
    girder_frame : AffineFrame
        Bmad type: TYPE
        Fortran default: null()
    assembly : Girder
        actual girders
        Bmad type: type
        Fortran default: null()
    ramp : Ramping
        Bmad type: type
        Fortran default: null()
    forward : TreeElement
        Taylor tracking on a fibre
        Bmad type: type
        Fortran default: null()
    backward : TreeElement
        Taylor tracking on a fibre
        Bmad type: type
        Fortran default: null()
    usef : bool
        Bmad type: logical
        Fortran default: null()
    useb : bool
        Bmad type: logical
        Fortran default: null()
    skip_ptc_f : int
        Bmad type: integer
        Fortran default: null()
    skip_ptc_b : int
        Bmad type: integer
        Fortran default: null()
    do1mapf : bool
        Bmad type: logical
        Fortran default: null()
    do1mapb : bool
        Bmad type: logical
        Fortran default: null()
    ene : float
        for tapering
        Bmad type: real
    """

    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    old_integrator: int = pydantic.Field(
        default=0,
    )
    recut: bool = pydantic.Field(
        default=False,
    )
    even: bool = pydantic.Field(
        default=False,
    )
    probe: bool = pydantic.Field(
        default=False,
    )
    plot: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("plot", "PLOT"),
        serialization_alias="PLOT",
    )
    electric: bool = pydantic.Field(
        default=False,
        description="type teapot can be electric",
    )
    filef: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="maps replacing ptc",
    )
    fileb: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    name: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    vorname: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Length of integration often same as LD",
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
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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
    va: float = pydantic.Field(
        default=0.0,
        description="use in quad fringe from sad",
        validation_alias=pydantic.AliasChoices("va", "VA"),
        serialization_alias="VA",
    )
    vs: float = pydantic.Field(
        default=0.0,
        description="use in quad fringe from sad",
        validation_alias=pydantic.AliasChoices("vs", "VS"),
        serialization_alias="VS",
    )
    volt: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    freq: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    phas: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    lag: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("lag", "LAG"),
        serialization_alias="LAG",
    )
    dc_ac: float = pydantic.Field(
        default=0.0,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("dc_ac", "DC_ac"),
        serialization_alias="DC_ac",
    )
    a_ac: float = pydantic.Field(
        default=0.0,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("a_ac", "A_ac"),
        serialization_alias="A_ac",
    )
    theta_ac: float = pydantic.Field(
        default=0.0,
        description="slow RF: amplitude and phase",
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
    d_volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_volt", "D_Volt"),
        serialization_alias="D_Volt",
    )
    d0_volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d0_volt", "D0_Volt"),
        serialization_alias="D0_Volt",
    )
    d_phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d_phas", "D_phas"),
        serialization_alias="D_phas",
    )
    d0_phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d0_phas", "D0_phas"),
        serialization_alias="D0_phas",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    slow_ac: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="magnet modulation",
    )
    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    mis: bool = pydantic.Field(
        default=False,
        description="migalignment on or off",
        validation_alias=pydantic.AliasChoices("mis", "MIS"),
        serialization_alias="MIS",
    )
    d0: Drift1 = pydantic.Field(
        default=None,
        description="DRIFT",
        validation_alias=pydantic.AliasChoices("d0", "D0"),
        serialization_alias="D0",
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
    c4: Cav4 = pydantic.Field(
        default=None,
        description="CAVITY  $",
        validation_alias=pydantic.AliasChoices("c4", "C4"),
        serialization_alias="C4",
    )
    s5: Sol5 = pydantic.Field(
        default=None,
        description="solenoid  $",
        validation_alias=pydantic.AliasChoices("s5", "S5"),
        serialization_alias="S5",
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
    tp10: Teapot = pydantic.Field(
        default=None,
        description="sector teapot exact sector bend electric or magnetic $",
        validation_alias=pydantic.AliasChoices("tp10", "TP10"),
        serialization_alias="TP10",
    )
    mon14: Mon = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT",
        validation_alias=pydantic.AliasChoices("mon14", "MON14"),
        serialization_alias="MON14",
    )
    sep15: Eseptum = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT electric kicker",
        validation_alias=pydantic.AliasChoices("sep15", "SEP15"),
        serialization_alias="SEP15",
    )
    k16: Strex = pydantic.Field(
        default=None,
        description="EXACT STRAIGHT INTEGRATOR  $",
        validation_alias=pydantic.AliasChoices("k16", "K16"),
        serialization_alias="K16",
    )
    enge17: Enge = pydantic.Field(
        default=None,
        description="not implemented",
        validation_alias=pydantic.AliasChoices("enge17", "ENGE17"),
        serialization_alias="ENGE17",
    )
    rcol18: Rcol = pydantic.Field(
        default=None,
        description="RCOLLIMATOR",
        validation_alias=pydantic.AliasChoices("rcol18", "RCOL18"),
        serialization_alias="RCOL18",
    )
    ecol19: Ecol = pydantic.Field(
        default=None,
        description="ECOLLIMATOR",
        validation_alias=pydantic.AliasChoices("ecol19", "ECOL19"),
        serialization_alias="ECOL19",
    )
    cav21: CavTrav = pydantic.Field(
        default=None,
        description="CAVITY TRAVELLING WAVE  (not symplectic)",
        validation_alias=pydantic.AliasChoices("cav21", "CAV21"),
        serialization_alias="CAV21",
    )
    wi: Sagan = pydantic.Field(
        default=None,
        description="USER DEFINED  undulator exact =.false.",
        validation_alias=pydantic.AliasChoices("wi", "WI"),
        serialization_alias="WI",
    )
    pa: Pancake = pydantic.Field(
        default=None,
        description="GENERAL B represented as Taylor",
        validation_alias=pydantic.AliasChoices("pa", "PA"),
        serialization_alias="PA",
    )
    ab: Abell = pydantic.Field(
        default=None,
        description="TYPE ABELL",
        validation_alias=pydantic.AliasChoices("ab", "AB"),
        serialization_alias="AB",
    )
    he22: HelicalDipole = pydantic.Field(
        default=None,
        description="exact =false otherwise not correct",
        validation_alias=pydantic.AliasChoices("he22", "HE22"),
        serialization_alias="HE22",
    )
    sdr: Superdrift = pydantic.Field(
        default=None,
        description="GENERAL DRIFT",
        validation_alias=pydantic.AliasChoices("sdr", "SDR"),
        serialization_alias="SDR",
    )
    parent_fibre: Fibre = pydantic.Field(
        default=None,
        description="in the database universe",
        validation_alias=pydantic.AliasChoices("parent_fibre", "PARENT_FIBRE"),
        serialization_alias="PARENT_FIBRE",
    )
    doko: FibreAppearance = pydantic.Field(
        default=None,
        description="all appearances",
    )
    siamese: Element = pydantic.Field(
        default=None,
        description="magnets somewhat glued together",
    )
    girders: Element = pydantic.Field(
        default=None,
        description="magnets on a girder",
    )
    siamese_frame: AffineFrame = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("siamese_frame", "SIAMESE_FRAME"),
        serialization_alias="SIAMESE_FRAME",
    )
    girder_frame: AffineFrame = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("girder_frame", "girder_FRAME"),
        serialization_alias="girder_FRAME",
    )
    assembly: Girder = pydantic.Field(
        default=None,
        description="actual girders",
    )
    ramp: Ramping = pydantic.Field(
        default=None,
    )
    forward: Sequence[TreeElement] = pydantic.Field(
        default=None,
        description="Taylor tracking on a fibre",
    )
    backward: Sequence[TreeElement] = pydantic.Field(
        default=None,
        description="Taylor tracking on a fibre",
    )
    usef: bool = pydantic.Field(
        default=False,
    )
    useb: bool = pydantic.Field(
        default=False,
    )
    skip_ptc_f: int = pydantic.Field(
        default=0,
    )
    skip_ptc_b: int = pydantic.Field(
        default=0,
    )
    do1mapf: bool = pydantic.Field(
        default=False,
    )
    do1mapb: bool = pydantic.Field(
        default=False,
    )
    ene: float = pydantic.Field(
        default=0.0,
        description="for tapering",
    )


class Elementp(pydantic.BaseModel):
    """
    Elementp corresponds to bmad `ELEMENTP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 286.

    Attributes
    ----------
    kind : int
        WHAT IT IS
        Bmad type: INTEGER
        Fortran default: null()
    old_integrator : int
        Bmad type: INTEGER
        Fortran default: null()
    knob : bool
        FALSE IF NO KNOB
        Bmad type: logical
        Fortran default: null()
    probe : bool
        FALSE IF NO KNOB
        Bmad type: logical
        Fortran default: null()
    name : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    vorname : str
        Identification
        Bmad type: CHARACTER
        Fortran default: null()
    electric : bool
        Bmad type: LOGICAL
        Fortran default: null()
    L : Real8
        LENGTH OF INTEGRATION OFTEN SAME AS LD, CAN BE ZERO
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        MULTIPOLE COMPONENT
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        MULTIPOLE COMPONENT
        Bmad type: TYPE
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    volt : Real8
        CAVITY INFORMATION
        Bmad type: TYPE
        Fortran default: null()
    freq : Real8
        CAVITY INFORMATION
        Bmad type: TYPE
        Fortran default: null()
    phas : Real8
        CAVITY INFORMATION
        Bmad type: TYPE
        Fortran default: null()
    delta_e : float
        CAVITY ENERGY GAIN
        Bmad type: real
        Fortran default: null()
    dc_ac : Real8
        slow RF: amplitude and phase
        Bmad type: TYPE
        Fortran default: null()
    a_ac : Real8
        slow RF: amplitude and phase
        Bmad type: TYPE
        Fortran default: null()
    theta_ac : Real8
        slow RF: amplitude and phase
        Bmad type: TYPE
        Fortran default: null()
    d_ac : Real8
        slow RF: amplitude and phase
        Bmad type: TYPE
        Fortran default: null()
    d_an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    d_bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    d0_an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    d0_bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    d_volt : Real8
        Bmad type: TYPE
        Fortran default: null()
    d0_volt : Real8
        Bmad type: TYPE
        Fortran default: null();
    d_phas : Real8
        Bmad type: TYPE
        Fortran default: null()
    d0_phas : Real8
        Bmad type: TYPE
        Fortran default: null();
    b_sol : Real8
        Bmad type: TYPE
        Fortran default: null()
    thin : bool
        Bmad type: logical
        Fortran default: null()
    slow_ac : int
        Bmad type: integer
        Fortran default: null()
    mis : bool
        Bmad type: logical
        Fortran default: null()
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    d0 : Drift1p
        DRIFT
        Bmad type: TYPE
        Fortran default: null()
    k2 : Dkd2p
        INTEGRATOR
        Bmad type: TYPE
        Fortran default: null()
    k3 : Kickt3p
        THIN KICK
        Bmad type: TYPE
        Fortran default: null()
    c4 : Cav4p
        DRIFT
        Bmad type: TYPE
        Fortran default: null()
    s5 : Sol5p
        CAVITY
        Bmad type: TYPE
        Fortran default: null()
    t6 : Ktkp
        INTEGRATOR
        Bmad type: TYPE
        Fortran default: null()
    t7 : Tktfp
        INTEGRATOR   THICK FAST
        Bmad type: TYPE
        Fortran default: null()
    s8 : Nsmip
        NORMAL SMI
        Bmad type: TYPE
        Fortran default: null()
    s9 : Ssmip
        SKEW SMI
        Bmad type: TYPE
        Fortran default: null()
    tp10 : Teapotp
        SECTOR BEND WITH CYLINDRICAL GEOMETRY
        Bmad type: TYPE
        Fortran default: null()
    mon14 : Monp
        MONITOR OR INSTRUMENT
        Bmad type: TYPE
        Fortran default: null()
    sep15 : Eseptump
        MONITOR OR INSTRUMENT
        Bmad type: TYPE
        Fortran default: null()
    k16 : Strexp
        EXACT STRAIGHT INTEGRATOR
        Bmad type: TYPE
        Fortran default: null()
    enge17 : Engep
        SOLENOID SIXTRACK STYLE
        Bmad type: TYPE
        Fortran default: null()
    rcol18 : Rcolp
        RCOLLIMATOR
        Bmad type: TYPE
        Fortran default: null()
    ecol19 : Ecolp
        ECOLLIMATOR
        Bmad type: TYPE
        Fortran default: null()
    cav21 : CavTravp
        CAVITY TRAVELLING WAVE
        Bmad type: TYPE
        Fortran default: null()
    he22 : HelicalDipolep
        GENERAL B
        Bmad type: TYPE
        Fortran default: null()
    sdr : Superdriftp
        GENERAL DRIFT
        Bmad type: TYPE
        Fortran default: null()
    wi : Saganp
        USER DEFINED
        Bmad type: TYPE
        Fortran default: null()
    pa : Pancakep
        GENERAL B
        Bmad type: TYPE
        Fortran default: null()
    ab : Abellp
        TYPE ABELL
        Bmad type: TYPE
        Fortran default: null()
    parent_fibre : Fibre
        Bmad type: TYPE
        Fortran default: null()
    ramp : Ramping
        Bmad type: type
        Fortran default: null()
    forward : TreeElement
        Bmad type: type
        Fortran default: null()
    backward : TreeElement
        Bmad type: type
        Fortran default: null()
    usef : bool
        Bmad type: logical
        Fortran default: null()
    useb : bool
        Bmad type: logical
        Fortran default: null()
    skip_ptc_f : int
        Bmad type: integer
        Fortran default: null()
    skip_ptc_b : int
        Bmad type: integer
        Fortran default: null()
    do1mapf : bool
        Bmad type: logical
        Fortran default: null()
    do1mapb : bool
        Bmad type: logical
        Fortran default: null()
    """

    kind: int = pydantic.Field(
        default=0,
        description="WHAT IT IS",
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    old_integrator: int = pydantic.Field(
        default=0,
    )
    knob: bool = pydantic.Field(
        default=False,
        description="FALSE IF NO KNOB",
        validation_alias=pydantic.AliasChoices("knob", "KNOB"),
        serialization_alias="KNOB",
    )
    probe: bool = pydantic.Field(
        default=False,
        description="FALSE IF NO KNOB",
    )
    name: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    vorname: str = pydantic.Field(
        default="",
        description="Identification",
        validation_alias=pydantic.AliasChoices("vorname", "VORNAME"),
        serialization_alias="VORNAME",
    )
    electric: bool = pydantic.Field(
        default=False,
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="LENGTH OF INTEGRATION OFTEN SAME AS LD, CAN BE ZERO",
    )
    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="MULTIPOLE COMPONENT",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="MULTIPOLE COMPONENT",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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
    volt: Real8 = pydantic.Field(
        default=None,
        description="CAVITY INFORMATION",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    freq: Real8 = pydantic.Field(
        default=None,
        description="CAVITY INFORMATION",
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        description="CAVITY INFORMATION",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        description="CAVITY ENERGY GAIN",
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    dc_ac: Real8 = pydantic.Field(
        default=None,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("dc_ac", "DC_ac"),
        serialization_alias="DC_ac",
    )
    a_ac: Real8 = pydantic.Field(
        default=None,
        description="slow RF: amplitude and phase",
        validation_alias=pydantic.AliasChoices("a_ac", "A_ac"),
        serialization_alias="A_ac",
    )
    theta_ac: Real8 = pydantic.Field(
        default=None,
        description="slow RF: amplitude and phase",
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
    d_volt: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d_volt", "D_Volt"),
        serialization_alias="D_Volt",
    )
    d0_volt: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d0_volt", "D0_Volt"),
        serialization_alias="D0_Volt",
    )
    d_phas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d_phas", "D_phas"),
        serialization_alias="D_phas",
    )
    d0_phas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("d0_phas", "D0_phas"),
        serialization_alias="D0_phas",
    )
    b_sol: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    slow_ac: int = pydantic.Field(
        default_factory=list,
        max_length=2,
    )
    mis: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("mis", "MIS"),
        serialization_alias="MIS",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    d0: Drift1p = pydantic.Field(
        default=None,
        description="DRIFT",
        validation_alias=pydantic.AliasChoices("d0", "D0"),
        serialization_alias="D0",
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
    c4: Cav4p = pydantic.Field(
        default=None,
        description="DRIFT",
        validation_alias=pydantic.AliasChoices("c4", "C4"),
        serialization_alias="C4",
    )
    s5: Sol5p = pydantic.Field(
        default=None,
        description="CAVITY",
        validation_alias=pydantic.AliasChoices("s5", "S5"),
        serialization_alias="S5",
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
    tp10: Teapotp = pydantic.Field(
        default=None,
        description="SECTOR BEND WITH CYLINDRICAL GEOMETRY",
        validation_alias=pydantic.AliasChoices("tp10", "TP10"),
        serialization_alias="TP10",
    )
    mon14: Monp = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT",
        validation_alias=pydantic.AliasChoices("mon14", "MON14"),
        serialization_alias="MON14",
    )
    sep15: Eseptump = pydantic.Field(
        default=None,
        description="MONITOR OR INSTRUMENT",
        validation_alias=pydantic.AliasChoices("sep15", "SEP15"),
        serialization_alias="SEP15",
    )
    k16: Strexp = pydantic.Field(
        default=None,
        description="EXACT STRAIGHT INTEGRATOR",
        validation_alias=pydantic.AliasChoices("k16", "K16"),
        serialization_alias="K16",
    )
    enge17: Engep = pydantic.Field(
        default=None,
        description="SOLENOID SIXTRACK STYLE",
        validation_alias=pydantic.AliasChoices("enge17", "ENGE17"),
        serialization_alias="ENGE17",
    )
    rcol18: Rcolp = pydantic.Field(
        default=None,
        description="RCOLLIMATOR",
        validation_alias=pydantic.AliasChoices("rcol18", "RCOL18"),
        serialization_alias="RCOL18",
    )
    ecol19: Ecolp = pydantic.Field(
        default=None,
        description="ECOLLIMATOR",
        validation_alias=pydantic.AliasChoices("ecol19", "ECOL19"),
        serialization_alias="ECOL19",
    )
    cav21: CavTravp = pydantic.Field(
        default=None,
        description="CAVITY TRAVELLING WAVE",
        validation_alias=pydantic.AliasChoices("cav21", "CAV21"),
        serialization_alias="CAV21",
    )
    he22: HelicalDipolep = pydantic.Field(
        default=None,
        description="GENERAL B",
        validation_alias=pydantic.AliasChoices("he22", "HE22"),
        serialization_alias="HE22",
    )
    sdr: Superdriftp = pydantic.Field(
        default=None,
        description="GENERAL DRIFT",
        validation_alias=pydantic.AliasChoices("sdr", "SDR"),
        serialization_alias="SDR",
    )
    wi: Saganp = pydantic.Field(
        default=None,
        description="USER DEFINED",
        validation_alias=pydantic.AliasChoices("wi", "WI"),
        serialization_alias="WI",
    )
    pa: Pancakep = pydantic.Field(
        default=None,
        description="GENERAL B",
        validation_alias=pydantic.AliasChoices("pa", "PA"),
        serialization_alias="PA",
    )
    ab: Abellp = pydantic.Field(
        default=None,
        description="TYPE ABELL",
        validation_alias=pydantic.AliasChoices("ab", "AB"),
        serialization_alias="AB",
    )
    parent_fibre: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_fibre", "PARENT_FIBRE"),
        serialization_alias="PARENT_FIBRE",
    )
    ramp: Ramping = pydantic.Field(
        default=None,
    )
    forward: Sequence[TreeElement] = pydantic.Field(
        default=None,
    )
    backward: Sequence[TreeElement] = pydantic.Field(
        default=None,
    )
    usef: bool = pydantic.Field(
        default=False,
    )
    useb: bool = pydantic.Field(
        default=False,
    )
    skip_ptc_f: int = pydantic.Field(
        default=0,
    )
    skip_ptc_b: int = pydantic.Field(
        default=0,
    )
    do1mapf: bool = pydantic.Field(
        default=False,
    )
    do1mapb: bool = pydantic.Field(
        default=False,
    )


class FibreAppearance(pydantic.BaseModel):
    """
    FibreAppearance corresponds to bmad `fibre_appearance`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 349.

    Attributes
    ----------
    parent_fibre : Fibre
        Bmad type: TYPE
        Fortran default: null()
    next : FibreAppearance
        Bmad type: TYPE
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


class Info(pydantic.BaseModel):
    """
    Info corresponds to bmad `info`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 354.

    Attributes
    ----------
    s : float
        Bmad type: real
        Fortran default: null()
    beta : float
        Bmad type: real
        Fortran default: null()
    fix0 : float
        Bmad type: real
        Fortran default: null()
    fix : float
        Bmad type: real
        Fortran default: null()
    pos : float
        Bmad type: real
        Fortran default: null()
    m : float
        Bmad type: real
        Fortran default: null()
    """

    s: float = pydantic.Field(
        default=0.0,
    )
    beta: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fix: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    pos: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    m: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class IntegrationNode(pydantic.BaseModel):
    """
    IntegrationNode corresponds to bmad `INTEGRATION_NODE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 364.

    Attributes
    ----------
    pos_in_fibre : int
        Bmad type: INTEGER
        Fortran default: null()
    cas : int
        Bmad type: INTEGER
        Fortran default: null()
    pos : int
        Bmad type: INTEGER
        Fortran default: null()
    lost : int
        Bmad type: INTEGER
        Fortran default: null()
    s : float
        Bmad type: real
        Fortran default: null()
    ds_ac : float
        Bmad type: real
        Fortran default: null()
    ref : float
        Bmad type: real
        Fortran default: null()
    ent : float
        Bmad type: real
    a : float
        Bmad type: real
        Fortran default: null()
    exi : float
        Bmad type: real
    b : float
        Bmad type: real
        Fortran default: null()
    delta_rad_in : float
        Bmad type: real
        Fortran default: null()
    delta_rad_out : float
        Bmad type: real
        Fortran default: null()
    teapot_like : int
        Bmad type: INTEGER
        Fortran default: null()
    next : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    previous : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    parent_node_layout : NodeLayout
        Bmad type: TYPE
        Fortran default: null()
    parent_fibre : Fibre
        Bmad type: TYPE
        Fortran default: null()
    lf : CLatticeFunction
        Bmad type: type
        Fortran default: null()
    bb : BeamBeamNode
        Bmad type: TYPE
        Fortran default: null()
    """

    pos_in_fibre: int = pydantic.Field(
        default=0,
    )
    cas: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("cas", "CAS"),
        serialization_alias="CAS",
    )
    pos: int = pydantic.Field(
        default=0,
    )
    lost: int = pydantic.Field(
        default=0,
    )
    s: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    ds_ac: float = pydantic.Field(
        default=0.0,
    )
    ref: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    exi: Sequence[float] = pydantic.Field(
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
    teapot_like: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("teapot_like", "TEAPOT_LIKE"),
        serialization_alias="TEAPOT_LIKE",
    )
    next: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    previous: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    parent_node_layout: NodeLayout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices(
            "parent_node_layout", "PARENT_NODE_LAYOUT"
        ),
        serialization_alias="PARENT_NODE_LAYOUT",
    )
    parent_fibre: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_fibre", "PARENT_FIBRE"),
        serialization_alias="PARENT_FIBRE",
    )
    lf: CLatticeFunction = pydantic.Field(
        default=None,
    )
    bb: BeamBeamNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("bb", "BB"),
        serialization_alias="BB",
    )


class Fibre(pydantic.BaseModel):
    """
    Fibre corresponds to bmad `FIBRE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 385.

    Attributes
    ----------
    dir : int
        Bmad type: INTEGER
        Fortran default: null()
    patch : Patch
        Bmad type: TYPE
        Fortran default: null()
    chart : Chart
        Bmad type: TYPE
        Fortran default: null()
    mag : Element
        Bmad type: TYPE
        Fortran default: null()
    magp : Elementp
        Bmad type: TYPE
        Fortran default: null()
    previous : Fibre
        Bmad type: TYPE
        Fortran default: null()
    next : Fibre
        Bmad type: TYPE
        Fortran default: null()
    parent_layout : Layout
        Bmad type: TYPE
        Fortran default: null()
    i : Info
        Bmad type: type
        Fortran default: null()
    t1 : IntegrationNode
        FIRST AND LAST INTEGRATION_NODE CHILDREN CORRESPOUNDING TO PATCHES
        Bmad type: TYPE
        Fortran default: null()
    t2 : IntegrationNode
        FIRST AND LAST INTEGRATION_NODE CHILDREN CORRESPOUNDING TO PATCHES
        Bmad type: TYPE
        Fortran default: null()
    tm : IntegrationNode
        MIDDLE INTEGRATION_NODE
        Bmad type: TYPE
        Fortran default: null()
    pos : int
        POSITION IN LAYOUT
        Bmad type: INTEGER
        Fortran default: null()
    beta0 : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    gamma0i : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    gambet : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    mass : float
        ,P0C
        Bmad type: real
        Fortran default: null()
    charge : float
        Bmad type: real
        Fortran default: null()
    ag : float
        spin g-2
        Bmad type: real
        Fortran default: null()
    p : Fibre
        tying them in the so-called database universe M_u
        Bmad type: TYPE
        Fortran default: null()
    n : Fibre
        Bmad type: TYPE
        Fortran default: null()
    loc : int
        Bmad type: INTEGER
        Fortran default: null()
    """

    dir: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("dir", "DIR"),
        serialization_alias="DIR",
    )
    patch: Patch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("patch", "PATCH"),
        serialization_alias="PATCH",
    )
    chart: Chart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("chart", "CHART"),
        serialization_alias="CHART",
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
    previous: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    next: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    parent_layout: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_layout", "PARENT_LAYOUT"),
        serialization_alias="PARENT_LAYOUT",
    )
    i: Info = pydantic.Field(
        default=None,
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
    pos: int = pydantic.Field(
        default=0,
        description="POSITION IN LAYOUT",
    )
    beta0: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("beta0", "BETA0"),
        serialization_alias="BETA0",
    )
    gamma0i: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("gamma0i", "GAMMA0I"),
        serialization_alias="GAMMA0I",
    )
    gambet: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("gambet", "GAMBET"),
        serialization_alias="GAMBET",
    )
    mass: float = pydantic.Field(
        default=0.0,
        description=",P0C",
        validation_alias=pydantic.AliasChoices("mass", "MASS"),
        serialization_alias="MASS",
    )
    charge: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("charge", "CHARGE"),
        serialization_alias="CHARGE",
    )
    ag: float = pydantic.Field(
        default=0.0,
        description="spin g-2",
        validation_alias=pydantic.AliasChoices("ag", "AG"),
        serialization_alias="AG",
    )
    p: Fibre = pydantic.Field(
        default=None,
        description="tying them in the so-called database universe M_u",
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    n: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    loc: int = pydantic.Field(
        default=0,
    )


class Layout(pydantic.BaseModel):
    """
    Layout corresponds to bmad `LAYOUT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 414.

    Attributes
    ----------
    name : str
        IDENTIFICATION
        Bmad type: CHARACTER
        Fortran default: null()
    index : int
        IDENTIFICATION, CHARGE SIGN
        Bmad type: INTEGER
        Fortran default: null()
    harmonic_number : float
        Bmad type: REAL
        Fortran default: null()
    closed : bool
        Bmad type: logical
        Fortran default: null()
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
        Fortran default: null()
    nthin : int
        NUMBER IF THIN LENSES IN COLLECTION  (FOR SPEED ESTIMATES)
        Bmad type: INTEGER
        Fortran default: null()
    thin : float
        PARAMETER USED FOR AUTOMATIC CUTTING INTO THIN LENS
        Bmad type: REAL
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    last : Fibre
        LAST VISITED
        Bmad type: TYPE
        Fortran default: null()
    end : Fibre
        Bmad type: TYPE
        Fortran default: null()
    start : Fibre
        Bmad type: TYPE
        Fortran default: null()
    start_ground : Fibre
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: TYPE
        Fortran default: null()
    end_ground : Fibre
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: TYPE
        Fortran default: null()
    next : Layout
        Bmad type: TYPE
        Fortran default: null()
    previous : Layout
        Bmad type: TYPE
        Fortran default: null()
    t : NodeLayout
        ASSOCIATED  CHILD THIN LENS LAYOUT
        Bmad type: type
        Fortran default: null()
    parent_universe : MadUniverse
        Bmad type: TYPE
        Fortran default: null()
    dna : LayoutArray
        Bmad type: TYPE
        Fortran default: null()
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    index: int = pydantic.Field(
        default=0,
        description="IDENTIFICATION, CHARGE SIGN",
        validation_alias=pydantic.AliasChoices("index", "INDEX"),
        serialization_alias="INDEX",
    )
    harmonic_number: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("harmonic_number", "HARMONIC_NUMBER"),
        serialization_alias="HARMONIC_NUMBER",
    )
    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    nthin: int = pydantic.Field(
        default=0,
        description="NUMBER IF THIN LENSES IN COLLECTION  (FOR SPEED ESTIMATES)",
        validation_alias=pydantic.AliasChoices("nthin", "NTHIN"),
        serialization_alias="NTHIN",
    )
    thin: float = pydantic.Field(
        default=0.0,
        description="PARAMETER USED FOR AUTOMATIC CUTTING INTO THIN LENS",
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    last: Fibre = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )
    end: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
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
    end_ground: Fibre = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )
    next: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    previous: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    t: NodeLayout = pydantic.Field(
        default=None,
        description="ASSOCIATED  CHILD THIN LENS LAYOUT",
        validation_alias=pydantic.AliasChoices("t", "T"),
        serialization_alias="T",
    )
    parent_universe: MadUniverse = pydantic.Field(
        default=None,
    )
    dna: Sequence[LayoutArray] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("dna", "DNA"),
        serialization_alias="DNA",
    )


class LayoutArray(pydantic.BaseModel):
    """
    LayoutArray corresponds to bmad `layout_array`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 439.

    Attributes
    ----------
    L : Layout
        Bmad type: type
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


class GirderSiamese(pydantic.BaseModel):
    """
    GirderSiamese corresponds to bmad `girder_siamese`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 444.

    Attributes
    ----------
    mag : Element
        Bmad type: type
        Fortran default: null()
    """

    mag: Element = pydantic.Field(
        default=None,
    )


class MadUniverse(pydantic.BaseModel):
    """
    MadUniverse corresponds to bmad `MAD_UNIVERSE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 448.

    Attributes
    ----------
    n : int
        NUMBERS OF LAYOUT
        Bmad type: INTEGER
        Fortran default: null()
    shared : int
        NUMBERS OF REPOSITORY LAYOUTS
        Bmad type: INTEGER
        Fortran default: null()
    end : Layout
        Bmad type: TYPE
        Fortran default: null()
    start : Layout
        Bmad type: TYPE
        Fortran default: null()
    nf : int
        number of fibres in tied layouts
        Bmad type: INTEGER
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    last : Fibre
        LAST VISITED
        Bmad type: TYPE
        Fortran default: null()
    """

    n: int = pydantic.Field(
        default=0,
        description="NUMBERS OF LAYOUT",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    shared: int = pydantic.Field(
        default=0,
        description="NUMBERS OF REPOSITORY LAYOUTS",
        validation_alias=pydantic.AliasChoices("shared", "SHARED"),
        serialization_alias="SHARED",
    )
    end: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
    )
    start: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("start", "START"),
        serialization_alias="START",
    )
    nf: int = pydantic.Field(
        default=0,
        description="number of fibres in tied layouts",
        validation_alias=pydantic.AliasChoices("nf", "NF"),
        serialization_alias="NF",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    last: Fibre = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )


class BeamLocation(pydantic.BaseModel):
    """
    BeamLocation corresponds to bmad `BEAM_LOCATION`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 461.

    Attributes
    ----------
    node : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    """

    node: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("node", "NODE"),
        serialization_alias="NODE",
    )


class NodeLayout(pydantic.BaseModel):
    """
    NodeLayout corresponds to bmad `NODE_LAYOUT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 465.

    Attributes
    ----------
    name : str
        IDENTIFICATION
        Bmad type: CHARACTER
        Fortran default: null()
    index : int
        IDENTIFICATION
        Bmad type: INTEGER
        Fortran default: null()
    closed : bool
        Bmad type: logical
        Fortran default: null()
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
        Fortran default: null()
    lastpos : int
        POSITION OF LAST VISITED
        Bmad type: INTEGER
        Fortran default: null()
    last : IntegrationNode
        LAST VISITED
        Bmad type: TYPE
        Fortran default: null()
    end : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    start : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    start_ground : IntegrationNode
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: TYPE
        Fortran default: null()
    end_ground : IntegrationNode
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: TYPE
        Fortran default: null()
    parent_layout : Layout
        Bmad type: TYPE
        Fortran default: null()
    orbit_lattice : OrbitLattice
        Bmad type: TYPE
        Fortran default: null()
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("name", "NAME"),
        serialization_alias="NAME",
    )
    index: int = pydantic.Field(
        default=0,
        description="IDENTIFICATION",
        validation_alias=pydantic.AliasChoices("index", "INDEX"),
        serialization_alias="INDEX",
    )
    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    lastpos: int = pydantic.Field(
        default=0,
        description="POSITION OF LAST VISITED",
        validation_alias=pydantic.AliasChoices("lastpos", "LASTPOS"),
        serialization_alias="LASTPOS",
    )
    last: IntegrationNode = pydantic.Field(
        default=None,
        description="LAST VISITED",
        validation_alias=pydantic.AliasChoices("last", "LAST"),
        serialization_alias="LAST",
    )
    end: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
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
    end_ground: IntegrationNode = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )
    parent_layout: Layout = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("parent_layout", "PARENT_LAYOUT"),
        serialization_alias="PARENT_LAYOUT",
    )
    orbit_lattice: OrbitLattice = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("orbit_lattice", "ORBIT_LATTICE"),
        serialization_alias="ORBIT_LATTICE",
    )


class OrbitNode(pydantic.BaseModel):
    """
    OrbitNode corresponds to bmad `ORBIT_NODE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 482.

    Attributes
    ----------
    node : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    lattice : float
        Bmad type: REAL
        Fortran default: null()
    dpos : int
        Bmad type: integer
        Fortran default: null()
    entering_task : int
        Bmad type: integer
        Fortran default: null()
    ptc_task : int
        Bmad type: integer
        Fortran default: null()
    cavity : bool
        Bmad type: logical
        Fortran default: null()
    """

    node: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("node", "NODE"),
        serialization_alias="NODE",
    )
    lattice: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("lattice", "LATTICE"),
        serialization_alias="LATTICE",
    )
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
    ptc_task: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("ptc_task", "PTC_TASK"),
        serialization_alias="PTC_TASK",
    )
    cavity: bool = pydantic.Field(
        default=False,
    )


class OrbitLattice(pydantic.BaseModel):
    """
    OrbitLattice corresponds to bmad `ORBIT_LATTICE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 491.

    Attributes
    ----------
    orbit_nodes : OrbitNode
        Bmad type: TYPE
        Fortran default: null()
    orbit_n_node : int
        GET_N_NODE
        Bmad type: INTEGER
        Fortran default: null()
    orbit_use_orbit_units : bool
        Bmad type: LOGICAL
        Fortran default: null()
    accel : bool
        Bmad type: LOGICAL
        Fortran default: null()
    orbit_warning : int
        Bmad type: INTEGER
        Fortran default: null()
    orbit_lmax : float
        GET_LMAX
        Bmad type: REAL
        Fortran default: null()
    orbit_max_patch_tz : float
        Bmad type: REAL
        Fortran default: null()
    orbit_mass_in_amu : float
        GET_MASS_AMU
        Bmad type: REAL
        Fortran default: null()
    orbit_gammat : float
        GET_GAMMAT
        Bmad type: REAL
        Fortran default: null()
    orbit_harmonic : float
        GET_HARMONIC
        Bmad type: REAL
        Fortran default: null()
    orbit_l : float
        GET_CIRCUMFERENCE
        Bmad type: REAL
        Fortran default: null()
    orbit_charge : float
        GET_CHARGE
        Bmad type: real
        Fortran default: null()
    orbit_omega : float
        GET_omega
        Bmad type: REAL
        Fortran default: null()
    orbit_p0c : float
        GET_P0C
        Bmad type: REAL
        Fortran default: null()
    orbit_beta0 : float
        GET_BETA0
        Bmad type: REAL
        Fortran default: null()
    orbit_kinetic : float
        GET_kinetic
        Bmad type: REAL
        Fortran default: null()
    orbit_brho : float
        GET_brho
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
    orbit_deltae : float
        GET_deltae
        Bmad type: REAL
        Fortran default: null()
    orbit_omega_after : float
        Bmad type: REAL
        Fortran default: null()
    state : InternalState
        Bmad type: TYPE
        Fortran default: null()
    tp : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    parent_layout : Layout
        Bmad type: TYPE
        Fortran default: null()
    dt : float
        Bmad type: real
        Fortran default: null()
    """

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
    orbit_use_orbit_units: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices(
            "orbit_use_orbit_units", "ORBIT_USE_ORBIT_UNITS"
        ),
        serialization_alias="ORBIT_USE_ORBIT_UNITS",
    )
    accel: bool = pydantic.Field(
        default=False,
    )
    orbit_warning: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("orbit_warning", "ORBIT_WARNING"),
        serialization_alias="ORBIT_WARNING",
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
    orbit_mass_in_amu: float = pydantic.Field(
        default=0.0,
        description="GET_MASS_AMU",
        validation_alias=pydantic.AliasChoices(
            "orbit_mass_in_amu", "ORBIT_mass_in_amu"
        ),
        serialization_alias="ORBIT_mass_in_amu",
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
    orbit_l: float = pydantic.Field(
        default=0.0,
        description="GET_CIRCUMFERENCE",
        validation_alias=pydantic.AliasChoices("orbit_l", "ORBIT_L"),
        serialization_alias="ORBIT_L",
    )
    orbit_charge: float = pydantic.Field(
        default=0.0,
        description="GET_CHARGE",
        validation_alias=pydantic.AliasChoices("orbit_charge", "ORBIT_CHARGE"),
        serialization_alias="ORBIT_CHARGE",
    )
    orbit_omega: float = pydantic.Field(
        default=0.0,
        description="GET_omega",
        validation_alias=pydantic.AliasChoices("orbit_omega", "ORBIT_OMEGA"),
        serialization_alias="ORBIT_OMEGA",
    )
    orbit_p0c: float = pydantic.Field(
        default=0.0,
        description="GET_P0C",
        validation_alias=pydantic.AliasChoices("orbit_p0c", "ORBIT_P0C"),
        serialization_alias="ORBIT_P0C",
    )
    orbit_beta0: float = pydantic.Field(
        default=0.0,
        description="GET_BETA0",
        validation_alias=pydantic.AliasChoices("orbit_beta0", "ORBIT_BETA0"),
        serialization_alias="ORBIT_BETA0",
    )
    orbit_kinetic: float = pydantic.Field(
        default=0.0,
        description="GET_kinetic",
    )
    orbit_brho: float = pydantic.Field(
        default=0.0,
        description="GET_brho",
    )
    orbit_energy: float = pydantic.Field(
        default=0.0,
        description="GET_total_energy",
    )
    orbit_gamma: float = pydantic.Field(
        default=0.0,
        description="GET_gamma",
    )
    orbit_deltae: float = pydantic.Field(
        default=0.0,
        description="GET_deltae",
    )
    orbit_omega_after: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices(
            "orbit_omega_after", "ORBIT_OMEGA_after"
        ),
        serialization_alias="ORBIT_OMEGA_after",
    )
    state: InternalState = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("state", "STATE"),
        serialization_alias="STATE",
    )
    tp: IntegrationNode = pydantic.Field(
        default=None,
    )
    parent_layout: Layout = pydantic.Field(
        default=None,
    )
    dt: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class BeamBeamNode(pydantic.BaseModel):
    """
    BeamBeamNode corresponds to bmad `BEAM_BEAM_NODE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 523.

    Attributes
    ----------
    s : float
        Bmad type: REAL
        Fortran default: null()
    n : int
        Bmad type: integer
        Fortran default: null()
    sx : float
        Bmad type: REAL
        Fortran default: null()
    sy : float
        Bmad type: REAL
        Fortran default: null()
    fk : float
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
    bbk : float
        kick on closed orbit
        Bmad type: REAL
        Fortran default: null()
    a : float
        patch angles
        Bmad type: REAL
        Fortran default: null()
    d : float
        patch translation
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
    patch : bool
        true= patch
        Bmad type: LOGICAL
        Fortran default: null()
    """

    s: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("s", "S"),
        serialization_alias="S",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
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
    fk: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("fk", "FK"),
        serialization_alias="FK",
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
    bbk: Sequence[float] = pydantic.Field(
        default=0.0,
        description="kick on closed orbit",
        validation_alias=pydantic.AliasChoices("bbk", "BBK"),
        serialization_alias="BBK",
    )
    a: Sequence[float] = pydantic.Field(
        default=0.0,
        description="patch angles",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="patch translation",
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
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
    patch: bool = pydantic.Field(
        default=False,
        description="true= patch",
        validation_alias=pydantic.AliasChoices("patch", "PATCH"),
        serialization_alias="PATCH",
    )


class ExtraWork(pydantic.BaseModel):
    """
    ExtraWork corresponds to bmad `EXTRA_WORK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 536.

    Attributes
    ----------
    kind : int
        Bmad type: INTEGER
        Fortran default: null()
    node : IntegrationNode
        Bmad type: TYPE
        Fortran default: null()
    bb : BeamBeamNode
        Bmad type: TYPE
        Fortran default: null()
    a : MadxAperture
        Bmad type: TYPE
        Fortran default: null()
    orb : float
        Bmad type: REAL
        Fortran default: null()
    """

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
    bb: BeamBeamNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("bb", "BB"),
        serialization_alias="BB",
    )
    a: MadxAperture = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
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
        Bmad type: type
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


class TempsEnergie(pydantic.BaseModel):
    """
    TempsEnergie corresponds to bmad `temps_energie`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 4.

    Attributes
    ----------
    temps : float
        Bmad type: real
        Fortran default: null()
    energie : float
        Bmad type: real
        Fortran default: null()
    volt : float
        Bmad type: real
        Fortran default: null()
    phase : float
        Bmad type: real
        Fortran default: null()
    tc : float
        Bmad type: real
        Fortran default: null()
    """

    temps: float = pydantic.Field(
        default=0.0,
    )
    energie: float = pydantic.Field(
        default=0.0,
    )
    volt: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    phase: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    tc: float = pydantic.Field(
        default=0.0,
    )


class Acceleration(pydantic.BaseModel):
    """
    Acceleration corresponds to bmad `acceleration`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 10.

    Attributes
    ----------
    n : int
        Bmad type: integer
        Fortran default: null()
    pos : int
        Bmad type: integer
        Fortran default: null()
    nst : int
        Bmad type: integer
        Fortran default: null()
    r : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    de : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    e_in : float
        , unit_time
        Bmad type: real
        Fortran default: null()
    w1 : Work
        Bmad type: type
        Fortran default: null()
    w2 : Work
        Bmad type: type
        Fortran default: null()
    previous : Fibre
        Bmad type: TYPE
        Fortran default: null()
    next : Fibre
        Bmad type: TYPE
        Fortran default: null()
    tableau : TempsEnergie
        Bmad type: type
        Fortran default: null()
    fichier : str
        Bmad type: character
        Fortran default: null()
    """

    n: int = pydantic.Field(
        default=0,
    )
    pos: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("pos", "POS"),
        serialization_alias="POS",
    )
    nst: int = pydantic.Field(
        default=0,
    )
    r: float = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    de: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    e_in: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", unit_time",
    )
    w1: Work = pydantic.Field(
        default=None,
    )
    w2: Work = pydantic.Field(
        default=None,
    )
    previous: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    next: Fibre = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )
    tableau: Sequence[TempsEnergie] = pydantic.Field(
        default=None,
    )
    fichier: str = pydantic.Field(
        default_factory=list,
        max_length=255,
    )


class Drift1(pydantic.BaseModel):
    """
    Drift1 corresponds to bmad `DRIFT1`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 22.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )


class Drift1p(pydantic.BaseModel):
    """
    Drift1p corresponds to bmad `DRIFT1P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 27.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )


class Superdrift(pydantic.BaseModel):
    """
    Superdrift corresponds to bmad `SUPERDRIFT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 32.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    d : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    ang : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    a_x1 : int
        Bmad type: INTEGER
        Fortran default: null()
    a_x2 : int
        Bmad type: INTEGER
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
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


class Superdriftp(pydantic.BaseModel):
    """
    Superdriftp corresponds to bmad `SUPERDRIFTP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 39.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    d : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    ang : float
        TRANSLATIONS  A_D(3) and Angles
        Bmad type: REAL
        Fortran default: null()
    a_x1 : int
        Bmad type: INTEGER
        Fortran default: null()
    a_x2 : int
        Bmad type: INTEGER
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    d: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
    )
    ang: Sequence[float] = pydantic.Field(
        default=0.0,
        description="TRANSLATIONS  A_D(3) and Angles",
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


class Dkd2(pydantic.BaseModel):
    """
    Dkd2 corresponds to bmad `DKD2`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 46.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
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
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
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

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
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
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
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
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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


class Kickt3(pydantic.BaseModel):
    """
    Kickt3 corresponds to bmad `KICKT3`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 66.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    thin_h_foc : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    thin_v_foc : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    thin_h_angle : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    thin_v_angle : float
        highly illegal additions by frs
        Bmad type: real
        Fortran default: null()
    hf : float
        highly illegal additions by frs for fringe
        Bmad type: real
        Fortran default: null()
    vf : float
        highly illegal additions by frs for fringe
        Bmad type: real
        Fortran default: null()
    patch : bool
        highly illegal additions by frs
        Bmad type: logical
        Fortran default: null()
    b_sol : float
        Bmad type: real
        Fortran default: null()
    ls : float
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

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
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
    thin_h_foc: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_v_foc: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_h_angle: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    thin_v_angle: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs",
    )
    hf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs for fringe",
    )
    vf: float = pydantic.Field(
        default=0.0,
        description="highly illegal additions by frs for fringe",
    )
    patch: bool = pydantic.Field(
        default=False,
        description="highly illegal additions by frs",
    )
    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    ls: float = pydantic.Field(
        default=0.0,
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


class Kickt3p(pydantic.BaseModel):
    """
    Kickt3p corresponds to bmad `KICKT3P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 77.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    thin_h_foc : Real8
        highly illegal additions by frs
        Bmad type: TYPE
        Fortran default: null()
    thin_v_foc : Real8
        highly illegal additions by frs
        Bmad type: TYPE
        Fortran default: null()
    thin_h_angle : Real8
        highly illegal additions by frs
        Bmad type: TYPE
        Fortran default: null()
    thin_v_angle : Real8
        highly illegal additions by frs
        Bmad type: TYPE
        Fortran default: null()
    hf : Real8
        highly illegal additions by frs for fringe
        Bmad type: TYPE
        Fortran default: null()
    vf : Real8
        highly illegal additions by frs for fringe
        Bmad type: TYPE
        Fortran default: null()
    patch : bool
        highly illegal additions by frs
        Bmad type: logical
        Fortran default: null()
    b_sol : Real8
        Bmad type: TYPE
        Fortran default: null()
    ls : float
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

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
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
    thin_h_foc: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    thin_v_foc: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    thin_h_angle: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    thin_v_angle: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs",
    )
    hf: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs for fringe",
    )
    vf: Real8 = pydantic.Field(
        default=None,
        description="highly illegal additions by frs for fringe",
    )
    patch: bool = pydantic.Field(
        default=False,
        description="highly illegal additions by frs",
    )
    b_sol: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    ls: float = pydantic.Field(
        default=0.0,
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


class Abell(pydantic.BaseModel):
    """
    Abell corresponds to bmad `ABELL`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 88.

    Attributes
    ----------
    thin : bool
        Bmad type: logical
        Fortran default: null()
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    an : float
        MULTIPLICATIVE FACTOR USUALLY 1
        Bmad type: real
        Fortran default: null()
    bn : float
        MULTIPLICATIVE FACTOR USUALLY 1
        Bmad type: real
        Fortran default: null()
    dz : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    t : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    te : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    b : Complex
        Bmad type: complex
        Fortran default: null()
    e : Complex
        Bmad type: complex
        Fortran default: null()
    n : int
        Bmad type: INTEGER
    m : int
        Bmad type: INTEGER
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
    xc : float
        Bmad type: REAL
        Fortran default: null()
    vc : float
        Bmad type: REAL
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="MULTIPLICATIVE FACTOR USUALLY 1",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
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
    b: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    e: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    m: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
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
    xc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
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
    thin : bool
        Bmad type: logical
        Fortran default: null()
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Storage space for computed
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Bmad type: TYPE
        Fortran default: null()
    dz : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    t : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    te : float
        , phi0(:) => null()
        Bmad type: real
        Fortran default: null()
    b : Complex
        Bmad type: complex
        Fortran default: null()
    e : Complex
        Bmad type: complex
        Fortran default: null()
    n : int
        Bmad type: INTEGER
    m : int
        Bmad type: INTEGER
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
    xc : float
        Bmad type: real
        Fortran default: null()
    vc : float
        Bmad type: real
        Fortran default: null()
    scale : Real8
        Bmad type: TYPE
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="Storage space for computed",
    )
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
    dz: Sequence[float] = pydantic.Field(
        default=0.0,
        description=", phi0(:) => null()",
        validation_alias=pydantic.AliasChoices("dz", "DZ"),
        serialization_alias="DZ",
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
    b: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    e: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    n: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    m: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
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
    xc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
        default=0.0,
    )
    scale: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("scale", "SCALE"),
        serialization_alias="SCALE",
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class Cav4(pydantic.BaseModel):
    """
    Cav4 corresponds to bmad `CAV4`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 113.

    Attributes
    ----------
    thin : bool
        Bmad type: logical
        Fortran default: null()
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Storage space for computed
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
    volt : float
        Bmad type: real
        Fortran default: null()
    freq : float
        Bmad type: real
        Fortran default: null()
    phas : float
        Bmad type: real
        Fortran default: null()
    delta_e : float
        Bmad type: real
        Fortran default: null()
    phase0 : float
        Bmad type: real
        Fortran default: null()
    t : float
        Bmad type: real
        Fortran default: null()
    f : float
        Bmad type: real
        Fortran default: null()
    a : float
        Bmad type: real
        Fortran default: null()
    r : float
        Bmad type: real
        Fortran default: null()
    ph : float
        Bmad type: real
        Fortran default: null()
    nf : int
        Bmad type: INTEGER
        Fortran default: null()
    n_bessel : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    acc : Acceleration
        Bmad type: type
        Fortran default: null()
    h1 : float
        Bmad type: real
        Fortran default: null()
    h2 : float
        Bmad type: real
        Fortran default: null()
    an0 : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn0 : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    """

    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
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
    volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    freq: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )
    t: float = pydantic.Field(
        default=0.0,
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    a: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    r: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
    )
    ph: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ph", "PH"),
        serialization_alias="PH",
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
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )
    acc: Acceleration = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("acc", "ACC"),
        serialization_alias="ACC",
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
    an0: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an0", "AN0"),
        serialization_alias="AN0",
    )
    bn0: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn0", "BN0"),
        serialization_alias="BN0",
    )


class Cav4p(pydantic.BaseModel):
    """
    Cav4p corresponds to bmad `CAV4P`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 132.

    Attributes
    ----------
    thin : bool
        Bmad type: logical
        Fortran default: null()
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    volt : Real8
        Cavity Information
        Bmad type: TYPE
        Fortran default: null()
    freq : Real8
        Cavity Information
        Bmad type: TYPE
        Fortran default: null()
    phas : Real8
        Cavity Information
        Bmad type: TYPE
        Fortran default: null()
    delta_e : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    phase0 : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    t : float
        Cavity information
        Bmad type: real
        Fortran default: null()
    f : Real8
        Bmad type: TYPE
        Fortran default: null()
    ph : Real8
        Bmad type: TYPE
        Fortran default: null()
    a : Real8
        Bmad type: TYPE
        Fortran default: null()
    r : Real8
        Bmad type: TYPE
        Fortran default: null()
    nf : int
        Bmad type: INTEGER
        Fortran default: null()
    n_bessel : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    acc : Acceleration
        Bmad type: type
        Fortran default: null()
    h1 : Real8
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        Bmad type: TYPE
        Fortran default: null()
    an0 : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn0 : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    """

    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
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
    volt: Real8 = pydantic.Field(
        default=None,
        description="Cavity Information",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    freq: Real8 = pydantic.Field(
        default=None,
        description="Cavity Information",
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        description="Cavity Information",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    phase0: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
    )
    t: float = pydantic.Field(
        default=0.0,
        description="Cavity information",
    )
    f: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    ph: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ph", "PH"),
        serialization_alias="PH",
    )
    a: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    r: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
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
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )
    acc: Acceleration = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("acc", "ACC"),
        serialization_alias="ACC",
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
    an0: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an0", "AN0"),
        serialization_alias="AN0",
    )
    bn0: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn0", "BN0"),
        serialization_alias="BN0",
    )


class CavTrav(pydantic.BaseModel):
    """
    CavTrav corresponds to bmad `CAV_TRAV`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 151.

    Attributes
    ----------
    thin : bool
        Bmad type: logical
        Fortran default: null()
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Storage space for computed
        Bmad type: real
        Fortran default: null()
    volt : float
        Bmad type: real
        Fortran default: null()
    freq : float
        Bmad type: real
        Fortran default: null()
    phas : float
        Bmad type: real
    delta_e : float
        Bmad type: real
        Fortran default: null()
    phase0 : float
        Bmad type: real
        Fortran default: null()
    psi : float
        Bmad type: real
        Fortran default: null()
    dphas : float
        Bmad type: real
        Fortran default: null()
    dvds : float
        Bmad type: real
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    implicit : bool
        Bmad type: logical
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    """

    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Storage space for computed",
    )
    volt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    freq: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    delta_e: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )
    psi: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("psi", "PSI"),
        serialization_alias="PSI",
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
    always_on: bool = pydantic.Field(
        default=False,
    )
    implicit: bool = pydantic.Field(
        default=False,
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
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


class CavTravp(pydantic.BaseModel):
    """
    CavTravp corresponds to bmad `CAV_TRAVP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 163.

    Attributes
    ----------
    thin : bool
        Bmad type: logical
        Fortran default: null()
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Storage space for computed
        Bmad type: TYPE
        Fortran default: null()
    volt : Real8
        Bmad type: TYPE
        Fortran default: null()
    freq : Real8
        Bmad type: TYPE
        Fortran default: null()
    phas : Real8
        Bmad type: TYPE
        Fortran default: null()
    psi : Real8
        Bmad type: TYPE
        Fortran default: null()
    dphas : Real8
        Bmad type: TYPE
        Fortran default: null()
    dvds : Real8
        Bmad type: TYPE
        Fortran default: null()
    delta_e : float
        Bmad type: real
        Fortran default: null()
    phase0 : float
        Bmad type: real
        Fortran default: null()
    always_on : bool
        Bmad type: logical
        Fortran default: null()
    implicit : bool
        Bmad type: logical
        Fortran default: null()
    cavity_totalpath : int
        Cavity information
        Bmad type: integer
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: type
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: type
        Fortran default: null()
    """

    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="Storage space for computed",
    )
    volt: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    freq: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
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
    delta_e: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("delta_e", "DELTA_E"),
        serialization_alias="DELTA_E",
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    implicit: bool = pydantic.Field(
        default=False,
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        description="Cavity information",
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
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


class Sol5(pydantic.BaseModel):
    """
    Sol5 corresponds to bmad `SOL5`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 177.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    b_sol : float
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
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
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

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
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
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    b_sol : Real8
        Bmad type: TYPE
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: TYPE
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

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
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
    L: Real8 = pydantic.Field(
        default=None,
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
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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


class Ktk(pydantic.BaseModel):
    """
    Ktk corresponds to bmad `KTK`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 200.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
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
    matx : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    maty : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    lx : float
        Bmad type: real
        Fortran default: null()
    ly : float
        Bmad type: real
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
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
    va : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    vs : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
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
    lx: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ly: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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


class Ktkp(pydantic.BaseModel):
    """
    Ktkp corresponds to bmad `KTKP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 212.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    matx : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    maty : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    lx : Real8
        Bmad type: TYPE
        Fortran default: null()
    ly : Real8
        Bmad type: TYPE
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
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
    lx: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    ly: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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


class Tktf(pydantic.BaseModel):
    """
    Tktf corresponds to bmad `TKTF`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 224.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
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
    matx : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    maty : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    matx2 : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    maty2 : float
        LINEAR MATRIX
        Bmad type: real
        Fortran default: null()
    lx : float
        Bmad type: real
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
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
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

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
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
    matx2: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx2", "MATX2"),
        serialization_alias="MATX2",
    )
    maty2: Sequence[float] = pydantic.Field(
        default=0.0,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty2", "MATY2"),
        serialization_alias="MATY2",
    )
    lx: Sequence[float] = pydantic.Field(
        default=0.0,
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
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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


class Tktfp(pydantic.BaseModel):
    """
    Tktfp corresponds to bmad `TKTFP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 243.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    matx : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    maty : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    matx2 : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    maty2 : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    lx : Real8
        Bmad type: TYPE
        Fortran default: null()
    rmatx : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    rmaty : Real8
        LINEAR MATRIX
        Bmad type: TYPE
        Fortran default: null()
    rlx : Real8
        Bmad type: TYPE
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
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
    matx2: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("matx2", "MATX2"),
        serialization_alias="MATX2",
    )
    maty2: Sequence[Real8] = pydantic.Field(
        default=None,
        description="LINEAR MATRIX",
        validation_alias=pydantic.AliasChoices("maty2", "MATY2"),
        serialization_alias="MATY2",
    )
    lx: Sequence[Real8] = pydantic.Field(
        default=None,
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
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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


class Nsmi(pydantic.BaseModel):
    """
    Nsmi corresponds to bmad `NSMI`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 262.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    bn : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )


class Nsmip(pydantic.BaseModel):
    """
    Nsmip corresponds to bmad `NSMIP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 267.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    bn: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("bn", "BN"),
        serialization_alias="BN",
    )


class Ssmi(pydantic.BaseModel):
    """
    Ssmi corresponds to bmad `SSMI`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 272.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    an : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )


class Ssmip(pydantic.BaseModel):
    """
    Ssmip corresponds to bmad `SSMIP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 277.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    an: Sequence[Real8] = pydantic.Field(
        default=None,
        description="Multipole component",
        validation_alias=pydantic.AliasChoices("an", "AN"),
        serialization_alias="AN",
    )


class Teapot(pydantic.BaseModel):
    """
    Teapot corresponds to bmad `TEAPOT`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 283.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    b_sol : float
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
    bf_x : float
        B field polynomial
        Bmad type: real
        Fortran default: null()
    bf_y : float
        B field polynomial
        Bmad type: real
        Fortran default: null()
    driftkick : bool
        Split flag
        Bmad type: logical
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
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
    f : int
        Bmad type: integer
        Fortran default: null()
    va : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    vs : float
        valishev-like multipole
        Bmad type: real
        Fortran default: null()
    ae : float
        an,bn for electric stuff
        Bmad type: real
        Fortran default: null()
    be : float
        an,bn for electric stuff
        Bmad type: real
        Fortran default: null()
    e_x : float
        Bmad type: real
        Fortran default: null()
    e_y : float
        Bmad type: real
        Fortran default: null()
    phi : float
        Bmad type: real
        Fortran default: null()
    vm : float
        Bmad type: real
        Fortran default: null()
    electric : bool
        Bmad type: LOGICAL
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    b_sol: float = pydantic.Field(
        default=0.0,
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
    bf_x: Sequence[float] = pydantic.Field(
        default=0.0,
        description="B field polynomial",
    )
    bf_y: Sequence[float] = pydantic.Field(
        default=0.0,
        description="B field polynomial",
    )
    driftkick: bool = pydantic.Field(
        default=False,
        description="Split flag",
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    fint: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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
    f: int = pydantic.Field(
        default=0,
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
    ae: Sequence[float] = pydantic.Field(
        default=0.0,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    be: Sequence[float] = pydantic.Field(
        default=0.0,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("be", "BE"),
        serialization_alias="BE",
    )
    e_x: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    e_y: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    phi: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phi", "PHI"),
        serialization_alias="PHI",
    )
    vm: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    electric: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("electric", "ELECTRIC"),
        serialization_alias="ELECTRIC",
    )


class Teapotp(pydantic.BaseModel):
    """
    Teapotp corresponds to bmad `TEAPOTP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 300.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    b_sol : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bf_x : Real8
        B field polynomial
        Bmad type: TYPE
        Fortran default: null()
    bf_y : Real8
        B field polynomial
        Bmad type: TYPE
        Fortran default: null()
    driftkick : bool
        Bmad type: logical
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    ae : Real8
        an,bn for electric stuff
        Bmad type: TYPE
        Fortran default: null()
    be : Real8
        an,bn for electric stuff
        Bmad type: TYPE
        Fortran default: null()
    e_x : Real8
        Bmad type: TYPE
        Fortran default: null()
    e_y : Real8
        Bmad type: TYPE
        Fortran default: null()
    phi : Real8
        Bmad type: TYPE
        Fortran default: null()
    vm : Real8
        Bmad type: TYPE
        Fortran default: null()
    electric : bool
        Bmad type: LOGICAL
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    b_sol: Real8 = pydantic.Field(
        default=None,
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
    bf_x: Sequence[Real8] = pydantic.Field(
        default=None,
        description="B field polynomial",
    )
    bf_y: Sequence[Real8] = pydantic.Field(
        default=None,
        description="B field polynomial",
    )
    driftkick: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("driftkick", "DRIFTKICK"),
        serialization_alias="DRIFTKICK",
    )
    fint: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("fint", "FINT"),
        serialization_alias="FINT",
    )
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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
    f: int = pydantic.Field(
        default=0,
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
    ae: Sequence[Real8] = pydantic.Field(
        default=None,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("ae", "AE"),
        serialization_alias="AE",
    )
    be: Sequence[Real8] = pydantic.Field(
        default=None,
        description="an,bn for electric stuff",
        validation_alias=pydantic.AliasChoices("be", "BE"),
        serialization_alias="BE",
    )
    e_x: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    e_y: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    phi: Sequence[Real8] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("phi", "PHI"),
        serialization_alias="PHI",
    )
    vm: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    electric: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("electric", "ELECTRIC"),
        serialization_alias="ELECTRIC",
    )


class Mon(pydantic.BaseModel):
    """
    Mon corresponds to bmad `MON`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 317.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        monitor and instrument of MAD
        Bmad type: real
        Fortran default: null()
    x : float
        Bmad type: real
        Fortran default: null()
    y : float
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="monitor and instrument of MAD",
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
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    x : float
        Bmad type: real
        Fortran default: null()
    y : float
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    x: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )


class Rcol(pydantic.BaseModel):
    """
    Rcol corresponds to bmad `RCOL`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 329.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        collimator of MAD
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="collimator of MAD",
    )


class Rcolp(pydantic.BaseModel):
    """
    Rcolp corresponds to bmad `RCOLP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 335.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )


class Ecol(pydantic.BaseModel):
    """
    Ecol corresponds to bmad `ECOL`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 341.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        collimator of MAD
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="collimator of MAD",
    )


class Ecolp(pydantic.BaseModel):
    """
    Ecolp corresponds to bmad `ECOLP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 347.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )


class Eseptum(pydantic.BaseModel):
    """
    Eseptum corresponds to bmad `ESEPTUM`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 353.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    volt : float
        VOLTAGE IN MV/M
        Bmad type: real
        Fortran default: null()
    phas : float
        TILT TO MIMIC E_X AND E_Y OF MAD-X
        Bmad type: real
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    volt: float = pydantic.Field(
        default=0.0,
        description="VOLTAGE IN MV/M",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    phas: float = pydantic.Field(
        default=0.0,
        description="TILT TO MIMIC E_X AND E_Y OF MAD-X",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )


class Eseptump(pydantic.BaseModel):
    """
    Eseptump corresponds to bmad `ESEPTUMP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 360.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        monitor and instrument of MAD
        Bmad type: TYPE
        Fortran default: null()
    volt : Real8
        VOLTAGE IN MV/M
        Bmad type: TYPE
        Fortran default: null()
    phas : Real8
        TILT TO MIMIC E_X AND E_Y OF MAD-X
        Bmad type: TYPE
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
        description="monitor and instrument of MAD",
    )
    volt: Real8 = pydantic.Field(
        default=None,
        description="VOLTAGE IN MV/M",
        validation_alias=pydantic.AliasChoices("volt", "VOLT"),
        serialization_alias="VOLT",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        description="TILT TO MIMIC E_X AND E_Y OF MAD-X",
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )


class Strex(pydantic.BaseModel):
    """
    Strex corresponds to bmad `STREX`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 367.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
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
    driftkick : bool
        , LIKEMAD => null()
        Bmad type: logical
        Fortran default: null()
    fint : float
        FRINGE FUDGE FOR MAD
        Bmad type: real
        Fortran default: null()
    hgap : float
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

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
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
    hgap: Sequence[float] = pydantic.Field(
        default=0.0,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    driftkick : bool
        , LIKEMAD => null()
        Bmad type: logical
        Fortran default: null()
    fint : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    hgap : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h1 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    h2 : Real8
        FRINGE FUDGE FOR MAD
        Bmad type: TYPE
        Fortran default: null()
    va : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    vs : Real8
        valishev-like multipole
        Bmad type: TYPE
        Fortran default: null()
    f : int
        Bmad type: integer
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
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
    hgap: Sequence[Real8] = pydantic.Field(
        default=None,
        description="FRINGE FUDGE FOR MAD",
        validation_alias=pydantic.AliasChoices("hgap", "HGAP"),
        serialization_alias="HGAP",
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


class Enge(pydantic.BaseModel):
    """
    Enge corresponds to bmad `ENGE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 390.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    d : float
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
    a : float
        ENGE  COEFFICIENTS
        Bmad type: real
        Fortran default: null()
    nbessel : int
        Bmad type: integer
        Fortran default: null()
    f : My1dTaylor
        Bmad type: type
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    d: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("d", "D"),
        serialization_alias="D",
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
    a: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENGE  COEFFICIENTS",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    nbessel: int = pydantic.Field(
        default=0,
    )
    f: My1dTaylor = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )


class Engep(pydantic.BaseModel):
    """
    Engep corresponds to bmad `ENGEP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 399.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Multipole component
        Bmad type: TYPE
        Fortran default: null()
    d : float
        Bmad type: real
        Fortran default: null()
    a : float
        ENGE  COEFFICIENTS
        Bmad type: real
        Fortran default: null()
    nbessel : int
        Bmad type: integer
        Fortran default: null()
    f : My1dTaylor
        Bmad type: type
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
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
    a: Sequence[float] = pydantic.Field(
        default=0.0,
        description="ENGE  COEFFICIENTS",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    nbessel: int = pydantic.Field(
        default=0,
    )
    f: My1dTaylor = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )


class Pancake(pydantic.BaseModel):
    """
    Pancake corresponds to bmad `PANCAKE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 424.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
        Bmad type: real
        Fortran default: null()
    b : TreeElement
        Bmad type: type
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
    xc : float
        Bmad type: REAL
        Fortran default: null()
    vc : float
        Bmad type: REAL
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    b: Sequence[TreeElement] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
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
    xc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
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
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    b : TreeElement
        Bmad type: type
        Fortran default: null()
    scale : Real8
        Bmad type: TYPE
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
    xc : float
        Bmad type: real
        Fortran default: null()
    vc : float
        Bmad type: real
        Fortran default: null()
    xprime : bool
        Bmad type: logical
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
    b: Sequence[TreeElement] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
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
    xc: float = pydantic.Field(
        default=0.0,
    )
    vc: float = pydantic.Field(
        default=0.0,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )


class HelicalDipole(pydantic.BaseModel):
    """
    HelicalDipole corresponds to bmad `HELICAL_DIPOLE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 444.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : float
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
    fake_shift : float
        Multipole component
        Bmad type: real
        Fortran default: null()
    freq : float
        Bmad type: real
        Fortran default: null()
    phas : float
        Bmad type: real
        Fortran default: null()
    n_bessel : int
        Bmad type: integer
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: float = pydantic.Field(
        default=0.0,
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
    fake_shift: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Multipole component",
    )
    freq: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    phas: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )


class HelicalDipolep(pydantic.BaseModel):
    """
    HelicalDipolep corresponds to bmad `HELICAL_DIPOLEP`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 452.

    Attributes
    ----------
    p : MagnetChart
        Bmad type: TYPE
        Fortran default: null()
    L : Real8
        Bmad type: TYPE
        Fortran default: null()
    an : Real8
        Bmad type: TYPE
        Fortran default: null()
    bn : Real8
        Bmad type: TYPE
        Fortran default: null()
    fake_shift : Real8
        Bmad type: TYPE
        Fortran default: null()
    freq : Real8
        Bmad type: TYPE
        Fortran default: null()
    phas : Real8
        Bmad type: TYPE
        Fortran default: null()
    n_bessel : int
        Bmad type: integer
        Fortran default: null()
    """

    p: MagnetChart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("p", "P"),
        serialization_alias="P",
    )
    L: Real8 = pydantic.Field(
        default=None,
    )
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
    fake_shift: Sequence[Real8] = pydantic.Field(
        default=None,
    )
    freq: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("freq", "FREQ"),
        serialization_alias="FREQ",
    )
    phas: Real8 = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("phas", "PHAS"),
        serialization_alias="PHAS",
    )
    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )


class RfPhasor(pydantic.BaseModel):
    """
    RfPhasor corresponds to bmad `rf_phasor`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 332.

    Attributes
    ----------
    x : float
        Bmad type: real
    om : float
        Bmad type: real
    t : float
        Bmad type: real
    """

    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
    )
    om: float = pydantic.Field(
        default=0.0,
    )
    t: float = pydantic.Field(
        default=0.0,
    )


class RfPhasor8(pydantic.BaseModel):
    """
    RfPhasor8 corresponds to bmad `rf_phasor_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 339.

    Attributes
    ----------
    x : Real8
        The two hands of the clock
        Bmad type: type
    om : Real8
        the omega of the modulation
        Bmad type: type
    t : float
        the pseudo-time
        Bmad type: real
    """

    x: Sequence[Real8] = pydantic.Field(
        default=None,
        max_length=2,
        description="The two hands of the clock",
    )
    om: Real8 = pydantic.Field(
        default=None,
        description="the omega of the modulation",
    )
    t: float = pydantic.Field(
        default=0.0,
        description="the pseudo-time",
    )


class Probe_(pydantic.BaseModel):
    """
    Probe_ corresponds to bmad `probe`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 346.

    Attributes
    ----------
    x : float
        Bmad type: real
    s : Spinor
        Bmad type: type
    q : Quaternion
        Bmad type: type
    ac : RfPhasor
        Bmad type: type
    nac : int
        Bmad type: integer
        Fortran default: 0
    u : bool
        Bmad type: logical
    use_q : bool
        Bmad type: logical
    last_node : IntegrationNode
        Bmad type: type
        Fortran default: null()
    e : float
        Bmad type: real
    """

    x: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )
    s: Sequence[Spinor] = pydantic.Field(
        default=None,
        max_length=3,
    )
    q: Quaternion = pydantic.Field(
        default=None,
    )
    ac: Sequence[RfPhasor] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("ac", "AC"),
        serialization_alias="AC",
    )
    nac: int = pydantic.Field(
        default=0,
    )
    u: bool = pydantic.Field(
        default=False,
    )
    use_q: bool = pydantic.Field(
        default=False,
    )
    last_node: IntegrationNode = pydantic.Field(
        default=None,
    )
    e: float = pydantic.Field(
        default=0.0,
    )


class Probe8(pydantic.BaseModel):
    """
    Probe8 corresponds to bmad `probe_8`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 357.

    Attributes
    ----------
    x : Real8
        Polymorphic orbital ray
        Bmad type: type
    s : Spinor8
        Polymorphic spin s(1:3)
        Bmad type: type
    q : Quaternion8
        Bmad type: type
    ac : RfPhasor8
        Modulation of magnet
        Bmad type: type
    nac : int
        number of modulated clocks <=nacmax
        Bmad type: integer
        Fortran default: 0
    e_ij : float
        Envelope for stochastic radiation
        Bmad type: real
    x0 : float
        initial value of the ray for TPSA calculations with c_damap
        Bmad type: real
    u : bool
        Bmad type: logical
    use_q : bool
        Bmad type: logical
    last_node : IntegrationNode
        Bmad type: type
        Fortran default: null()
    e : float
        Bmad type: real
    """

    x: Sequence[Real8] = pydantic.Field(
        default=None,
        max_length=6,
        description="Polymorphic orbital ray",
    )
    s: Sequence[Spinor8] = pydantic.Field(
        default=None,
        max_length=3,
        description="Polymorphic spin s(1:3)",
    )
    q: Quaternion8 = pydantic.Field(
        default=None,
    )
    ac: Sequence[RfPhasor8] = pydantic.Field(
        default=None,
        description="Modulation of magnet",
    )
    nac: int = pydantic.Field(
        default=0,
        description="number of modulated clocks <=nacmax",
    )
    e_ij: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Envelope for stochastic radiation",
        validation_alias=pydantic.AliasChoices("e_ij", "E_ij"),
        serialization_alias="E_ij",
    )
    x0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="initial value of the ray for TPSA calculations with c_damap",
    )
    u: bool = pydantic.Field(
        default=False,
    )
    use_q: bool = pydantic.Field(
        default=False,
    )
    last_node: IntegrationNode = pydantic.Field(
        default=None,
    )
    e: float = pydantic.Field(
        default=0.0,
    )


class TemporalProbe(pydantic.BaseModel):
    """
    TemporalProbe corresponds to bmad `TEMPORAL_PROBE`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 374.

    Attributes
    ----------
    xs : Probe
        probe at r=0
        Bmad type: TYPE
    node : IntegrationNode
        Bmad type: TYPE
    r : float
        penetration ration, penetration time
        Bmad type: real
    dt0 : float
        penetration ration, penetration time
        Bmad type: real
    pos : float
        (x,y,z,px,py,pz) at dt0 and total time
        Bmad type: real
    t : float
        (x,y,z,px,py,pz) at dt0 and total time
        Bmad type: real
    ic : float
        (x,y,z,px,py,pz) at dt0
        Bmad type: real
    s : Spinor
        spin vectors at dt0
        Bmad type: type
    """

    xs: Probe = pydantic.Field(
        default=None,
        description="probe at r=0",
        validation_alias=pydantic.AliasChoices("xs", "XS"),
        serialization_alias="XS",
    )
    node: IntegrationNode = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("node", "NODE"),
        serialization_alias="NODE",
    )
    r: float = pydantic.Field(
        default=0.0,
        description="penetration ration, penetration time",
    )
    dt0: float = pydantic.Field(
        default=0.0,
        description="penetration ration, penetration time",
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
    ic: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="(x,y,z,px,py,pz) at dt0",
        validation_alias=pydantic.AliasChoices("ic", "IC"),
        serialization_alias="IC",
    )
    s: Sequence[Spinor] = pydantic.Field(
        default=None,
        max_length=3,
        description="spin vectors at dt0",
    )


class TemporalBeam(pydantic.BaseModel):
    """
    TemporalBeam corresponds to bmad `TEMPORAL_BEAM`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 383.

    Attributes
    ----------
    tp : TemporalProbe
        Bmad type: TYPE
    a : float
        Bmad type: real
    ent : float
        Bmad type: real
    p0c : float
        Bmad type: real
    total_time : float
        Bmad type: real
    n : int
        Bmad type: integer
    c : IntegrationNode
        pointer close to a(3)
        Bmad type: type
    state : InternalState
        Bmad type: type
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
    ent: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    p0c: float = pydantic.Field(
        default=0.0,
    )
    total_time: float = pydantic.Field(
        default=0.0,
    )
    n: int = pydantic.Field(
        default=0,
    )
    c: IntegrationNode = pydantic.Field(
        default=None,
        description="pointer close to a(3)",
    )
    state: InternalState = pydantic.Field(
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


class CDascratch(pydantic.BaseModel):
    """
    CDascratch corresponds to bmad `c_dascratch`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 398.

    Attributes
    ----------
    t : CTaylor
        Bmad type: type
    previous : CDascratch
        Bmad type: TYPE
    next : CDascratch
        Bmad type: TYPE
    """

    t: CTaylor = pydantic.Field(
        default=None,
    )
    previous: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("previous", "PREVIOUS"),
        serialization_alias="PREVIOUS",
    )
    next: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("next", "NEXT"),
        serialization_alias="NEXT",
    )


class CDalevel(pydantic.BaseModel):
    """
    CDalevel corresponds to bmad `c_dalevel`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 404.

    Attributes
    ----------
    n : int
        TOTAL ELEMENT IN THE CHAIN
        Bmad type: INTEGER
    closed : bool
        Bmad type: logical
    present : CDascratch
        Bmad type: TYPE
    end : CDascratch
        Bmad type: TYPE
    start : CDascratch
        Bmad type: TYPE
    start_ground : CDascratch
        STORE THE GROUNDED VALUE OF START DURING CIRCULAR SCANNING
        Bmad type: TYPE
    end_ground : CDascratch
        STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING
        Bmad type: TYPE
    """

    n: int = pydantic.Field(
        default=0,
        description="TOTAL ELEMENT IN THE CHAIN",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    closed: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("closed", "CLOSED"),
        serialization_alias="CLOSED",
    )
    present: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("present", "PRESENT"),
        serialization_alias="PRESENT",
    )
    end: CDascratch = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("end", "END"),
        serialization_alias="END",
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
    end_ground: CDascratch = pydantic.Field(
        default=None,
        description="STORE THE GROUNDED VALUE OF END DURING CIRCULAR SCANNING",
        validation_alias=pydantic.AliasChoices("end_ground", "END_GROUND"),
        serialization_alias="END_GROUND",
    )


class CSpinmatrix(pydantic.BaseModel):
    """
    CSpinmatrix corresponds to bmad `c_spinmatrix`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 415.

    Attributes
    ----------
    s : CTaylor
        Bmad type: type
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
        Bmad type: type
    """

    v: Sequence[CTaylor] = pydantic.Field(
        default=None,
        max_length=3,
    )


class CYuW(pydantic.BaseModel):
    """
    CYuW corresponds to bmad `c_yu_w`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 424.

    Attributes
    ----------
    w : CTaylor
        @1 orbital part of the map
        Bmad type: type
        Fortran default: null()
    n : int
        @1 of non zero w
        Bmad type: integer
        Fortran default: 0
    """

    w: Sequence[CTaylor] = pydantic.Field(
        default=None,
        description="@1 orbital part of the map",
    )
    n: int = pydantic.Field(
        default=0,
        description="@1 of non zero w",
    )


class CQuaternion(pydantic.BaseModel):
    """
    CQuaternion corresponds to bmad `c_quaternion`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 429.

    Attributes
    ----------
    x : CTaylor
        Bmad type: type
    """

    x: Sequence[CTaylor] = pydantic.Field(
        default=None,
    )


class CDamap(pydantic.BaseModel):
    """
    CDamap corresponds to bmad `c_damap`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 434.

    Attributes
    ----------
    v : CTaylor
        @1 orbital part of the map
        Bmad type: type
    q : CQuaternion
        Bmad type: type
    e_ij : Complex
        @1 stochastic fluctuation in radiation theory
        Bmad type: complex
    n : int
        @1 number of planes allocated
        Bmad type: integer
        Fortran default: 0
    x0 : Complex
        Bmad type: complex
    cm : Complex
        Bmad type: complex
        Fortran default: null()
    m : float
        Bmad type: real
        Fortran default: null()
    s : CSpinmatrix
        @1 spin matrix
        Bmad type: type
    """

    v: Sequence[CTaylor] = pydantic.Field(
        default=None,
        description="@1 orbital part of the map",
    )
    q: CQuaternion = pydantic.Field(
        default=None,
    )
    e_ij: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1 stochastic fluctuation in radiation theory",
    )
    n: int = pydantic.Field(
        default=0,
        description="@1 number of planes allocated",
    )
    x0: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    cm: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    m: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    s: CSpinmatrix = pydantic.Field(
        default=None,
        description="@1 spin matrix",
    )


class CVectorField(pydantic.BaseModel):
    """
    CVectorField corresponds to bmad `c_vector_field`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 461.

    Attributes
    ----------
    n : int
        Bmad type: integer
        Fortran default: 0
    nrmax : int
        Bmad type: integer
    eps : float
        Bmad type: real
    v : CTaylor
        Bmad type: type
    q : CQuaternion
        Bmad type: type
    L : CSpinmatrix
        Bmad type: type
    """

    n: int = pydantic.Field(
        default=0,
    )
    nrmax: int = pydantic.Field(
        default=0,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    v: Sequence[CTaylor] = pydantic.Field(
        default=None,
    )
    q: CQuaternion = pydantic.Field(
        default=None,
    )
    L: CSpinmatrix = pydantic.Field(
        default=None,
    )


class CVectorFieldFourier(pydantic.BaseModel):
    """
    CVectorFieldFourier corresponds to bmad `c_vector_field_fourier`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 478.

    Attributes
    ----------
    n : int
        Bmad type: integer
        Fortran default: 0
    f : CVectorField
        Bmad type: type
        Fortran default: null()
    """

    n: int = pydantic.Field(
        default=0,
    )
    f: Sequence[CVectorField] = pydantic.Field(
        default=None,
    )


class CFactoredLie(pydantic.BaseModel):
    """
    CFactoredLie corresponds to bmad `c_factored_lie`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 483.

    Attributes
    ----------
    n : int
        Bmad type: integer
        Fortran default: 0
    dir : int
        Bmad type: integer
        Fortran default: 0
    f : CVectorField
        Bmad type: type
        Fortran default: null()
    """

    n: int = pydantic.Field(
        default=0,
    )
    dir: int = pydantic.Field(
        default=0,
    )
    f: Sequence[CVectorField] = pydantic.Field(
        default=None,
    )


class CNormalForm(pydantic.BaseModel):
    """
    CNormalForm corresponds to bmad `c_normal_form`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 490.

    Attributes
    ----------
    atot : CDamap
        @1  For Spin   (m = Atot n Atot^-1)
        Bmad type: type
    h : CVectorField
        Bmad type: type
    h_l : CVectorField
        Bmad type: type
    h_nl : CVectorField
        Bmad type: type
    s_ij0 : Complex
        @1  equilibrium beam sizes
        Bmad type: complex
    s_ijr : Complex
        @1  equilibrium beam sizes in resonance basis
        Bmad type: complex
    b_ijr : Complex
        @1   stochastic kick in resonance basis
        Bmad type: complex
    emittance : float
        @1  Equilibrium emittances as defined by Chao (computed from s_ijr(2*i-1,2*i)
        i=1,2,3 )
        Bmad type: real
    nres : int
        @1 stores resonances to be left in the map, including spin (ms)
        Bmad type: integer
    m : int
        @1 stores resonances to be left in the map, including spin (ms)
        Bmad type: integer
    ms : int
        @1 stores resonances to be left in the map, including spin (ms)
        Bmad type: integer
    tune : float
        @1 Stores simple information
        Bmad type: real
    damping : float
        @1 Stores simple information
        Bmad type: real
    spin_tune : float
        @1 Stores simple information
        Bmad type: real
    quaternion_angle : float
        @1 Stores simple information
        Bmad type: real
    positive : bool
        forces positive tunes (close to 1 if <0)
        Bmad type: logical
    a_t : CDamap
        @1 transformation a (m=a n a^-1)
        Bmad type: type
    a1 : CDamap
        @1 brings to fix point at least linear
        Bmad type: type
    a2 : CDamap
        @1 linear normal form
        Bmad type: type
    g : CFactoredLie
        @1 nonlinear part of a in phasors
        Bmad type: type
    ker : CFactoredLie
        @1  kernel i.e. normal form in phasors
        Bmad type: type
    n : CDamap
        @1 transformation n (m=a n a^-1)
        Bmad type: type
    as_ : CDamap
        @1  For Spin   (m = As a n a^-1 As^-1)
        Bmad type: type
    """

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
    s_ij0: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1  equilibrium beam sizes",
    )
    s_ijr: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1  equilibrium beam sizes in resonance basis",
    )
    b_ijr: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="@1   stochastic kick in resonance basis",
    )
    emittance: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description=(
            "@1  Equilibrium emittances as defined by Chao (computed from "
            "s_ijr(2*i-1,2*i) i=1,2,3 )"
        ),
    )
    nres: int = pydantic.Field(
        default=0,
        description="@1 stores resonances to be left in the map, including spin (ms)",
        validation_alias=pydantic.AliasChoices("nres", "NRES"),
        serialization_alias="NRES",
    )
    m: Sequence[int] = pydantic.Field(
        default=0,
        description="@1 stores resonances to be left in the map, including spin (ms)",
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    ms: Sequence[int] = pydantic.Field(
        default=0,
        description="@1 stores resonances to be left in the map, including spin (ms)",
    )
    tune: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )
    damping: Sequence[float] = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )
    spin_tune: float = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )
    quaternion_angle: float = pydantic.Field(
        default=0.0,
        description="@1 Stores simple information",
    )
    positive: bool = pydantic.Field(
        default=False,
        description="forces positive tunes (close to 1 if <0)",
    )
    a_t: CDamap = pydantic.Field(
        default=None,
        description="@1 transformation a (m=a n a^-1)",
    )
    a1: CDamap = pydantic.Field(
        default=None,
        description="@1 brings to fix point at least linear",
    )
    a2: CDamap = pydantic.Field(
        default=None,
        description="@1 linear normal form",
    )
    g: CFactoredLie = pydantic.Field(
        default=None,
        description="@1 nonlinear part of a in phasors",
    )
    ker: CFactoredLie = pydantic.Field(
        default=None,
        description="@1  kernel i.e. normal form in phasors",
    )
    n: CDamap = pydantic.Field(
        default=None,
        description="@1 transformation n (m=a n a^-1)",
    )
    as_: CDamap = pydantic.Field(
        default=None,
        description="@1  For Spin   (m = As a n a^-1 As^-1)",
        validation_alias=pydantic.AliasChoices("as_", "As"),
        serialization_alias="As",
    )


class CRay(pydantic.BaseModel):
    """
    CRay corresponds to bmad `c_ray`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 520.

    Attributes
    ----------
    x : Complex
        # orbital and/or magnet modulation clocks
        Bmad type: complex
    q : ComplexQuaternion
        # quaternion
        Bmad type: type
    n : int
        # of dimensions used in x(lnv)
        Bmad type: integer
    s1 : Complex
        # 3 spin directions
        Bmad type: complex
    s2 : Complex
        # 3 spin directions
        Bmad type: complex
    s3 : Complex
        # 3 spin directions
        Bmad type: complex
    """

    x: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="# orbital and/or magnet modulation clocks",
    )
    q: ComplexQuaternion = pydantic.Field(
        default=None,
        description="# quaternion",
    )
    n: int = pydantic.Field(
        default=0,
        description="# of dimensions used in x(lnv)",
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


class FibreArray(pydantic.BaseModel):
    """
    FibreArray corresponds to bmad `fibre_array`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 529.

    Attributes
    ----------
    p : Fibre
        Bmad type: type
        Fortran default: null()
    t : IntegrationNode
        Bmad type: type
        Fortran default: null()
    pos : int
        Bmad type: integer
        Fortran default: null()
    v : float
        Bmad type: real
        Fortran default: null()
    vmax : float
        Bmad type: real
        Fortran default: null();
    s : float
        Bmad type: real
        Fortran default: null()
    err : float
        Bmad type: real
        Fortran default: null()
    """

    p: Fibre = pydantic.Field(
        default=None,
    )
    t: IntegrationNode = pydantic.Field(
        default=None,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    v: float = pydantic.Field(
        default=0.0,
    )
    vmax: float = pydantic.Field(
        default=0.0,
    )
    s: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    err: float = pydantic.Field(
        default=0.0,
    )


class NodeArray(pydantic.BaseModel):
    """
    NodeArray corresponds to bmad `node_array`
    which is in Users/klauer/Repos/bmad/forest/code/h_definition.f90 on line 539.

    Attributes
    ----------
    t : IntegrationNode
        Bmad type: type
        Fortran default: null()
    pos : int
        Bmad type: integer
        Fortran default: null()
    v : float
        Bmad type: real
        Fortran default: null()
    vmax : float
        Bmad type: real
        Fortran default: null();
    s : Complex
        Bmad type: complex
        Fortran default: null()
    err : float
        Bmad type: real
        Fortran default: null()
    f : CVectorField
        Bmad type: type
        Fortran default: null()
    m : CDamap
        Bmad type: type
        Fortran default: null()
    """

    t: IntegrationNode = pydantic.Field(
        default=None,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    v: float = pydantic.Field(
        default=0.0,
    )
    vmax: float = pydantic.Field(
        default=0.0,
    )
    s: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    err: float = pydantic.Field(
        default=0.0,
    )
    f: CVectorField = pydantic.Field(
        default=None,
    )
    m: CDamap = pydantic.Field(
        default=None,
    )


class Keywords(pydantic.BaseModel):
    """
    Keywords corresponds to bmad `keywords`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 18.

    Attributes
    ----------
    magnet : str
        Bmad type: character
    model : str
        Bmad type: character
    fibre_flip : bool
        Bmad type: logical
    fibre_dir : int
        Bmad type: INTEGER
    method : int
        Bmad type: integer
    nstep : int
        Bmad type: integer
    exact : bool
        Bmad type: logical
    madlength : bool
        Bmad type: logical
    mad8 : bool
        Bmad type: logical
    tiltd : float
        Bmad type: real
    list_ : ElList
        Bmad type: type
    """

    magnet: str = pydantic.Field(
        default_factory=list,
        max_length=20,
    )
    model: str = pydantic.Field(
        default_factory=list,
        max_length=20,
    )
    fibre_flip: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("fibre_flip", "FIBRE_flip"),
        serialization_alias="FIBRE_flip",
    )
    fibre_dir: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("fibre_dir", "FIBRE_DIR"),
        serialization_alias="FIBRE_DIR",
    )
    method: int = pydantic.Field(
        default=0,
    )
    nstep: int = pydantic.Field(
        default=0,
    )
    exact: bool = pydantic.Field(
        default=False,
    )
    madlength: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("madlength", "madLENGTH"),
        serialization_alias="madLENGTH",
    )
    mad8: bool = pydantic.Field(
        default=False,
    )
    tiltd: float = pydantic.Field(
        default=0.0,
    )
    list_: ElList = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("list_", "LIST"),
        serialization_alias="LIST",
    )


class MadxSurvey(pydantic.BaseModel):
    """
    MadxSurvey corresponds to bmad `MADX_SURVEY`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 32.

    Attributes
    ----------
    alpha : float
        Bmad type: REAL
    tilt : float
        Bmad type: REAL
    ld : float
        Bmad type: REAL
    phi : float
        Bmad type: REAL
    theta : float
        Bmad type: REAL
    psi : float
        Bmad type: REAL
    chart : Chart
        Bmad type: TYPE
    """

    alpha: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("alpha", "ALPHA"),
        serialization_alias="ALPHA",
    )
    tilt: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tilt", "TILT"),
        serialization_alias="TILT",
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
    theta: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("theta", "THETA"),
        serialization_alias="THETA",
    )
    psi: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("psi", "PSI"),
        serialization_alias="PSI",
    )
    chart: Chart = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("chart", "CHART"),
        serialization_alias="CHART",
    )


class Fibrelist(pydantic.BaseModel):
    """
    Fibrelist corresponds to bmad `fibrelist`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 1.

    Attributes
    ----------
    gamma0i_gambet_mass_ag : float
        GAMMA0I,GAMBET,MASS ,AG  BETA0 is computed
        Bmad type: real
    charge : float
        Bmad type: real
    dir : int
        DIR,CHARGE
        Bmad type: integer
    patch : int
        Bmad type: integer
    """

    gamma0i_gambet_mass_ag: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
        description="GAMMA0I,GAMBET,MASS ,AG  BETA0 is computed",
        validation_alias=pydantic.AliasChoices(
            "gamma0i_gambet_mass_ag", "GAMMA0I_GAMBET_MASS_AG"
        ),
        serialization_alias="GAMMA0I_GAMBET_MASS_AG",
    )
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
    patch: int = pydantic.Field(
        default=0,
    )


class Patchlist(pydantic.BaseModel):
    """
    Patchlist corresponds to bmad `patchlist`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 10.

    Attributes
    ----------
    a_x1 : int
        Bmad type: integer
    a_x2 : int
        Bmad type: integer
    b_x1 : int
        Bmad type: integer
    b_x2 : int
        Bmad type: integer
    a_d : float
        Bmad type: real
    b_d : float
        Bmad type: real
    a_ang : float
        Bmad type: real
    b_ang : float
        Bmad type: real
    a_l : float
        Bmad type: real
    b_l : float
        Bmad type: real
    a_t : float
        Bmad type: real
    b_t : float
        Bmad type: real
    energy : int
        Bmad type: INTEGER
    time : int
        Bmad type: INTEGER
    geometry : int
        Bmad type: INTEGER
    track : bool
        Bmad type: logical
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
    a_d: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("a_d", "A_D"),
        serialization_alias="A_D",
    )
    b_d: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("b_d", "B_D"),
        serialization_alias="B_D",
    )
    a_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("a_ang", "A_ANG"),
        serialization_alias="A_ANG",
    )
    b_ang: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("b_ang", "B_ANG"),
        serialization_alias="B_ANG",
    )
    a_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a_l", "A_L"),
        serialization_alias="A_L",
    )
    b_l: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_l", "B_L"),
        serialization_alias="B_L",
    )
    a_t: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a_t", "A_T"),
        serialization_alias="A_T",
    )
    b_t: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_t", "B_T"),
        serialization_alias="B_T",
    )
    energy: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        validation_alias=pydantic.AliasChoices("energy", "ENERGY"),
        serialization_alias="ENERGY",
    )
    time: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        validation_alias=pydantic.AliasChoices("time", "TIME"),
        serialization_alias="TIME",
    )
    geometry: int = pydantic.Field(
        default_factory=list,
        max_length=2,
        validation_alias=pydantic.AliasChoices("geometry", "GEOMETRY"),
        serialization_alias="GEOMETRY",
    )
    track: bool = pydantic.Field(
        default=False,
    )


class Chartlist(pydantic.BaseModel):
    """
    Chartlist corresponds to bmad `CHARTlist`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 19.

    Attributes
    ----------
    d_in : float
        Bmad type: real
    d_out : float
        Bmad type: real
    ang_in : float
        Bmad type: real
    ang_out : float
        Bmad type: real
    """

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


class MagnetChartlist(pydantic.BaseModel):
    """
    MagnetChartlist corresponds to bmad `MAGNET_CHARTLIST`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 25.

    Attributes
    ----------
    lc_ld_b0_p0 : float
        LC LD B0 P0C
        Bmad type: real
    tiltd_edge : float
        TILTD EDGE
        Bmad type: real
    kin_kex_bendfringe_exact : bool
        KILL_ENT_FRINGE, KILL_EXI_FRINGE, bend_fringe,EXACT
        Bmad type: LOGICAL
    method_nst_nmul_permfringe_highest : int
        METHOD,NST,NMUL,permfringr, highest_fringe
        Bmad type: INTEGER
    kill_spin : bool
        Bmad type: LOGICAL
    """

    lc_ld_b0_p0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
        description="LC LD B0 P0C",
        validation_alias=pydantic.AliasChoices("lc_ld_b0_p0", "LC_LD_B0_P0"),
        serialization_alias="LC_LD_B0_P0",
    )
    tiltd_edge: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="TILTD EDGE",
        validation_alias=pydantic.AliasChoices("tiltd_edge", "TILTD_EDGE"),
        serialization_alias="TILTD_EDGE",
    )
    kin_kex_bendfringe_exact: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=4,
        description="KILL_ENT_FRINGE, KILL_EXI_FRINGE, bend_fringe,EXACT",
        validation_alias=pydantic.AliasChoices(
            "kin_kex_bendfringe_exact", "KIN_KEX_BENDFRINGE_EXACT"
        ),
        serialization_alias="KIN_KEX_BENDFRINGE_EXACT",
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
    kill_spin: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=2,
    )


class EleList(pydantic.BaseModel):
    """
    EleList corresponds to bmad `ele_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 37.

    Attributes
    ----------
    kind : int
        Bmad type: INTEGER
    name_vorname : str
        Bmad type: character
    L : float
        Bmad type: real
    b_sol : float
        Bmad type: real
    an : float
        Bmad type: real
    bn : float
        Bmad type: real
    volt_freq_phas : float
        alg not used
        Bmad type: real
    thin : bool
        Bmad type: LOGICAL
    fint_hgap_h1_h2_va_vs : float
        Bmad type: real
    recut_even_electric_mis : bool
        Bmad type: logical
    slow_ac : int
        Bmad type: integer
    usebf_do1bf : bool
        Bmad type: logical
    skipptcbf : int
        Bmad type: integer
    filef : str
        Bmad type: character
    fileb : str
        Bmad type: character
    """

    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
    )
    name_vorname: Sequence[str] = pydantic.Field(
        default="",
        max_length=2,
    )
    L: float = pydantic.Field(
        default=0.0,
    )
    b_sol: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("b_sol", "B_SOL"),
        serialization_alias="B_SOL",
    )
    an: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    bn: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    volt_freq_phas: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="alg not used",
        validation_alias=pydantic.AliasChoices("volt_freq_phas", "VOLT_FREQ_PHAS"),
        serialization_alias="VOLT_FREQ_PHAS",
    )
    thin: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("thin", "THIN"),
        serialization_alias="THIN",
    )
    fint_hgap_h1_h2_va_vs: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=8,
    )
    recut_even_electric_mis: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=4,
        validation_alias=pydantic.AliasChoices(
            "recut_even_electric_mis", "recut_even_electric_MIS"
        ),
        serialization_alias="recut_even_electric_MIS",
    )
    slow_ac: int = pydantic.Field(
        default_factory=list,
        max_length=2,
    )
    usebf_do1bf: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=4,
    )
    skipptcbf: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
    )
    filef: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    fileb: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )


class CavList(pydantic.BaseModel):
    """
    CavList corresponds to bmad `cav_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 59.

    Attributes
    ----------
    n_bessel : int
        Bmad type: integer
    nf : int
        Bmad type: integer
    cavity_totalpath : int
        Bmad type: integer
    phase0 : float
        Bmad type: real
    t : float
        Bmad type: real
    always_on : bool
        Bmad type: logical
    xprime : bool
        Bmad type: logical
    f : float
        Bmad type: real
    ph : float
        Bmad type: real
    a : float
        Bmad type: real
    r : float
        Bmad type: real
    """

    n_bessel: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("n_bessel", "N_BESSEL"),
        serialization_alias="N_BESSEL",
    )
    nf: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nf", "NF"),
        serialization_alias="NF",
    )
    cavity_totalpath: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("cavity_totalpath", "CAVITY_TOTALPATH"),
        serialization_alias="CAVITY_TOTALPATH",
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )
    t: float = pydantic.Field(
        default=0.0,
    )
    always_on: bool = pydantic.Field(
        default=False,
    )
    xprime: bool = pydantic.Field(
        default=False,
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    ph: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("ph", "PH"),
        serialization_alias="PH",
    )
    a: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    r: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("r", "R"),
        serialization_alias="R",
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


class Thin3List(pydantic.BaseModel):
    """
    Thin3List corresponds to bmad `thin3_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 78.

    Attributes
    ----------
    thin_h_foc : float
        Bmad type: real
    thin_v_foc : float
        Bmad type: real
    thin_h_angle : float
        Bmad type: real
    thin_v_angle : float
        Bmad type: real
    hf : float
        Bmad type: real
    vf : float
        Bmad type: real
    ls : float
        Bmad type: real
    patch : bool
        Bmad type: logical
    dx_dy_pitchx_pitchy : float
        Bmad type: real
    """

    thin_h_foc: float = pydantic.Field(
        default=0.0,
    )
    thin_v_foc: float = pydantic.Field(
        default=0.0,
    )
    thin_h_angle: float = pydantic.Field(
        default=0.0,
    )
    thin_v_angle: float = pydantic.Field(
        default=0.0,
    )
    hf: float = pydantic.Field(
        default=0.0,
    )
    vf: float = pydantic.Field(
        default=0.0,
    )
    ls: float = pydantic.Field(
        default=0.0,
    )
    patch: bool = pydantic.Field(
        default=False,
    )
    dx_dy_pitchx_pitchy: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
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


class AbList(pydantic.BaseModel):
    """
    AbList corresponds to bmad `ab_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 101.

    Attributes
    ----------
    n_m : int
        Bmad type: integer
    b : Complex
        Bmad type: complex
    e : Complex
        Bmad type: complex
    dz_t_te : float
        Bmad type: real
    scale_angc_xc_vc_dc_hc : float
        Bmad type: real
    """

    n_m: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
    )
    b: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    e: Sequence[Complex] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    dz_t_te: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    scale_angc_xc_vc_dc_hc: Sequence[float] = pydantic.Field(
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


class ApList(pydantic.BaseModel):
    """
    ApList corresponds to bmad `ap_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 117.

    Attributes
    ----------
    kind : int
        Bmad type: integer
    r : float
        Bmad type: real
    x : float
        Bmad type: real
    y : float
        Bmad type: real
    dx : float
        Bmad type: real
    dy : float
        Bmad type: real
    on : bool
        Bmad type: logical
    """

    kind: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("kind", "KIND"),
        serialization_alias="KIND",
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
    dx: float = pydantic.Field(
        default=0.0,
    )
    dy: float = pydantic.Field(
        default=0.0,
    )
    on: bool = pydantic.Field(
        default=False,
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


class TrackList(pydantic.BaseModel):
    """
    TrackList corresponds to bmad `track_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 141.

    Attributes
    ----------
    name : str
        Bmad type: character
    range : int
        Bmad type: integer
    direction : int
        Bmad type: integer
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=120,
    )
    range: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
    )
    direction: int = pydantic.Field(
        default=0,
    )


class WigList(pydantic.BaseModel):
    """
    WigList corresponds to bmad `wig_list`
    which is in Users/klauer/Repos/bmad/forest/code/Sp_keywords.f90 on line 150.

    Attributes
    ----------
    offset : float
        Bmad type: real
    internal : float
        Bmad type: real
    ex : float
        Bmad type: real
    ey : float
        Bmad type: real
    n : int
        Bmad type: integer
    a : float
        Bmad type: real
    f : float
        Bmad type: real
    form : int
        Bmad type: integer
    k : float
        Bmad type: real
    ne : int
        Bmad type: integer
    ae : float
        Bmad type: real
    fe : float
        Bmad type: real
    forme : int
        Bmad type: integer
    ke : float
        Bmad type: real
    """

    offset: float = pydantic.Field(
        default=0.0,
    )
    internal: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
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
    a: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    f: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    form: Sequence[int] = pydantic.Field(
        default=0,
    )
    k: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ne: int = pydantic.Field(
        default=0,
    )
    ae: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    fe: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    forme: Sequence[int] = pydantic.Field(
        default=0,
    )
    ke: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class Hermite(pydantic.BaseModel):
    """
    Hermite corresponds to bmad `hermite`
    which is in Users/klauer/Repos/bmad/forest/code/St_pointers.f90 on line 80.

    Attributes
    ----------
    n : int
        Bmad type: integer
    h : float
        Bmad type: real
    a : float
        Bmad type: real
        Fortran default: 0
    ai : float
        Bmad type: real
        Fortran default: 0
    m : float
        Bmad type: real
        Fortran default: 0
    mi : float
        Bmad type: real
        Fortran default: 0
    f : float
        Bmad type: real
        Fortran default: 0
    b : float
        Bmad type: real
    gen : int
        Bmad type: integer
        Fortran default: 0
    ms : Damap
        Bmad type: type
    p : Probe8
        Bmad type: type
    x0 : float
        Bmad type: real
        Fortran default: null()
    state : InternalState
        Bmad type: type
    r : Layout
        Bmad type: type
    pos : int
        Bmad type: integer
    noh : int
        Bmad type: integer
    no : int
        Bmad type: integer
    maxite : int
        Bmad type: integer
        Fortran default: 100
    nint : int
        Bmad type: integer
        Fortran default: 10
    linear : bool
        Bmad type: logical
        Fortran default: .true.
    eps : float
        Bmad type: real
        Fortran default: 1.e-6_dp
    he : float
        Bmad type: real
        Fortran default: null()
    """

    n: int = pydantic.Field(
        default=0,
    )
    h: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
    )
    a: Sequence[float] = pydantic.Field(
        default=0,
    )
    ai: Sequence[float] = pydantic.Field(
        default=0,
    )
    m: Sequence[float] = pydantic.Field(
        default=0,
    )
    mi: Sequence[float] = pydantic.Field(
        default=0,
    )
    f: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
    )
    b: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    gen: int = pydantic.Field(
        default=0,
    )
    ms: Sequence[Damap] = pydantic.Field(
        default=None,
    )
    p: Sequence[Probe8] = pydantic.Field(
        default=None,
    )
    x0: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    state: InternalState = pydantic.Field(
        default=None,
    )
    r: Layout = pydantic.Field(
        default=None,
    )
    pos: int = pydantic.Field(
        default=0,
    )
    noh: int = pydantic.Field(
        default=0,
    )
    no: int = pydantic.Field(
        default=0,
    )
    maxite: int = pydantic.Field(
        default=100,
    )
    nint: int = pydantic.Field(
        default=10,
    )
    linear: bool = pydantic.Field(
        default=True,
    )
    eps: float = pydantic.Field(
        default=0.0,
    )
    he: Sequence[float] = pydantic.Field(
        default=0.0,
    )
