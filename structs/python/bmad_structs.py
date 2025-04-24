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
from .forest_structs import (
    CNormalForm,
    CQuaternion,
    CTaylor,
    Fibre,
    InternalState,
    Layout,
    Probe8,
    TreeElement,
)
from .sim_utils_structs import (
    BicubicCmplxCoefStruct,
    NametableStruct,
    RandomStateStruct,
    SplineStruct,
    TricubicCmplxCoefStruct,
)

Complex = Annotated[
    complex,
    PlainValidator(
        lambda x: x if isinstance(x, complex) else complex(x.get("real", x.get("imag")))
    ),
    PlainSerializer(lambda x: {"real": x.real, "imag": x.imag}, return_type=dict),
]


class IbsStruct(pydantic.BaseModel):
    """
    IbsStruct corresponds to bmad `ibs_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/ibs_rates_mod.f90 on line 7.

    Attributes
    ----------
    inv_ta : float
        Bmad type: real
    inv_tb : float
        Bmad type: real
    inv_tz : float
        Bmad type: real
    """

    inv_ta: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("inv_ta", "inv_Ta"),
        serialization_alias="inv_Ta",
    )
    inv_tb: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("inv_tb", "inv_Tb"),
        serialization_alias="inv_Tb",
    )
    inv_tz: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("inv_tz", "inv_Tz"),
        serialization_alias="inv_Tz",
    )


class MomentumApertureStruct(pydantic.BaseModel):
    """
    MomentumApertureStruct corresponds to bmad `momentum_aperture_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/touschek_mod.f90 on line 23.

    Attributes
    ----------
    s : float
        Bmad type: REAL
    pos : float
        Bmad type: REAL
    neg : float
        Bmad type: REAL
    """

    s: float = pydantic.Field(
        default=0.0,
    )
    pos: float = pydantic.Field(
        default=0.0,
    )
    neg: float = pydantic.Field(
        default=0.0,
    )


class IbsSimParamStruct(pydantic.BaseModel):
    """
    IbsSimParamStruct corresponds to bmad `ibs_sim_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/ibs_mod.f90 on line 10.

    Attributes
    ----------
    tau_a : float
        horizontal damping rate (needed for coulomb log tail cut)
        Bmad type: real
        Fortran default: 0.0d0
    clog_to_use : int
        see multi_coulomb_log subroutine for valid settings.  Set to 1 to disable tail-
        cut.  Set to 1 for linacs.
        Bmad type: integer
        Fortran default: 1
    set_dispersion : bool
        True: add vertical dispersion to transfer matrix.  Valid for kubo method.
        Bmad type: logical
        Fortran default: .false.
    eta_set : float
        If set_dispersion, then this value is used to add y-z coupling to the transfer
        matrix.
        Bmad type: real
        Fortran default: 0.0d0
    etap_set : float
        If set_dispersion, then this value is used to add y-z coupling to the transfer
        matrix.
        Bmad type: real
        Fortran default: 0.0d0
    do_pwd : bool
        If true, then use potential well distortion to calculate bunch lengths.  If
        false,
        Bmad type: logical
        Fortran default: .false.
    inductance : float
        Inductive part of impedance for pwd calc.
        Bmad type: real
        Fortran default: 0.0d0
    formula : str
        Which IBS formulation to use.  See subroutine ibs1 for a list.
        Bmad type: character
        Fortran default: 'bjmt'
    """

    tau_a: float = pydantic.Field(
        default=0.0,
        description="horizontal damping rate (needed for coulomb log tail cut)",
    )
    clog_to_use: int = pydantic.Field(
        default=1,
        description=(
            "see multi_coulomb_log subroutine for valid settings.  Set to 1 to disable "
            "tail-cut.  Set to 1 for linacs."
        ),
    )
    set_dispersion: bool = pydantic.Field(
        default=False,
        description="True: add vertical dispersion to transfer matrix.  Valid for kubo method.",
    )
    eta_set: float = pydantic.Field(
        default=0.0,
        description=(
            "If set_dispersion, then this value is used to add y-z coupling to the "
            "transfer matrix."
        ),
    )
    etap_set: float = pydantic.Field(
        default=0.0,
        description=(
            "If set_dispersion, then this value is used to add y-z coupling to the "
            "transfer matrix."
        ),
    )
    do_pwd: bool = pydantic.Field(
        default=False,
        description=(
            "If true, then use potential well distortion to calculate bunch lengths. "
            "If false,"
        ),
    )
    inductance: float = pydantic.Field(
        default=0.0,
        description="Inductive part of impedance for pwd calc.",
    )
    formula: str = pydantic.Field(
        default="bjmt",
        max_length=4,
        description="Which IBS formulation to use.  See subroutine ibs1 for a list.",
    )


class IbsLifetimeStruct(pydantic.BaseModel):
    """
    IbsLifetimeStruct corresponds to bmad `ibs_lifetime_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/ibs_mod.f90 on line 23.

    Attributes
    ----------
    tlx : float
        Bmad type: real
    tly : float
        Bmad type: real
    tlp : float
        Bmad type: real
    """

    tlx: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tlx", "Tlx"),
        serialization_alias="Tlx",
    )
    tly: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tly", "Tly"),
        serialization_alias="Tly",
    )
    tlp: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tlp", "Tlp"),
        serialization_alias="Tlp",
    )


class IbsMaxratioStruct(pydantic.BaseModel):
    """
    IbsMaxratioStruct corresponds to bmad `ibs_maxratio_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/ibs_mod.f90 on line 30.

    Attributes
    ----------
    rx : float
        Bmad type: real
    ry : float
        Bmad type: real
    r_p : float
        Bmad type: real
    """

    rx: float = pydantic.Field(
        default=0.0,
    )
    ry: float = pydantic.Field(
        default=0.0,
    )
    r_p: float = pydantic.Field(
        default=0.0,
    )


class AstraLatticeParamStruct(pydantic.BaseModel):
    """
    AstraLatticeParamStruct corresponds to bmad `astra_lattice_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/interface/astra_interface_mod.f90 on line 7.

    Attributes
    ----------
    fieldmap_dimension : int
        Dimensions for field map. 1 or 3
        Bmad type: integer
        Fortran default: 1
    """

    fieldmap_dimension: int = pydantic.Field(
        default=1,
        description="Dimensions for field map. 1 or 3",
    )


class GptLatParamStruct(pydantic.BaseModel):
    """
    GptLatParamStruct corresponds to bmad `gpt_lat_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/interface/gpt_interface_mod.f90 on line 7.

    Attributes
    ----------
    fieldmap_dimension : int
        Dimensions for field map. 1 or 3
        Bmad type: integer
        Fortran default: 3
    only_write_autophase_parameters : bool
        Option to only write phasing info
        Bmad type: logical
        Fortran default: .false.
    gpt_filename : str
        Blank => Append '.gpt' to Bmad lattice file name.
        Bmad type: character
        Fortran default: ''
    header_file_name : str
        Header file to include in gpt file.
        Bmad type: character
        Fortran default: ''
    tracking_end_element : str
        Bmad lattice element name or index.
        Bmad type: character
        Fortran default: ''
    """

    fieldmap_dimension: int = pydantic.Field(
        default=3,
        description="Dimensions for field map. 1 or 3",
    )
    only_write_autophase_parameters: bool = pydantic.Field(
        default=False,
        description="Option to only write phasing info",
    )
    gpt_filename: str = pydantic.Field(
        default="",
        max_length=100,
        description="Blank => Append '.gpt' to Bmad lattice file name.",
    )
    header_file_name: str = pydantic.Field(
        default="",
        max_length=100,
        description="Header file to include in gpt file.",
    )
    tracking_end_element: str = pydantic.Field(
        default="",
        max_length=40,
        description="Bmad lattice element name or index.",
    )


class PtcRadMapStruct(pydantic.BaseModel):
    """
    PtcRadMapStruct corresponds to bmad `ptc_rad_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/ptc/ptc_map_with_radiation_mod.f90 on line 9.

    Attributes
    ----------
    sub_map : TreeElement
        Type tree_element in PTC
        Bmad type: type
    lattice_file : str
        Name of the lattice file
        Bmad type: character
    dref_time : float
        Time ref particle takes.
        Bmad type: real
    p0c_start : float
        ref momentum at start
        Bmad type: real
    p0c_end : float
        ref momentum at end
        Bmad type: real
    s_end : float
        Ending s-position
        Bmad type: real
    map_order : int
        Bmad type: integer
    radiation_damping_on : bool
        Bmad type: logical
    ix_branch : int
        Bmad type: integer
    ix_ele_start : int
        Start point for making the map
        Bmad type: integer
    ix_ele_end : int
        End point for making the map
        Bmad type: integer
    nodamp_mat : float
        Nondamped orbital matrix. M_orbit = M_damp * M_nodamp
        Bmad type: real
    damp_mat : float
        Damping "correction" to orbital matrix.
        Bmad type: real
    stoc_mat : float
        Stochatic matrix for the orbit.
        Bmad type: real
    ref0 : float
        Reference orbit at start.
        Bmad type: real
    ref1 : float
        Reference orbit at end.
        Bmad type: real
    """

    sub_map: Sequence[TreeElement] = pydantic.Field(
        default=None,
        max_length=3,
        description="Type tree_element in PTC",
    )
    lattice_file: str = pydantic.Field(
        default_factory=list,
        max_length=200,
        description="Name of the lattice file",
    )
    dref_time: float = pydantic.Field(
        default=0.0,
        description="Time ref particle takes.",
    )
    p0c_start: float = pydantic.Field(
        default=0.0,
        description="ref momentum at start",
    )
    p0c_end: float = pydantic.Field(
        default=0.0,
        description="ref momentum at end",
    )
    s_end: float = pydantic.Field(
        default=0.0,
        description="Ending s-position",
    )
    map_order: int = pydantic.Field(
        default=0,
    )
    radiation_damping_on: bool = pydantic.Field(
        default=False,
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_ele_start: int = pydantic.Field(
        default=0,
        description="Start point for making the map",
    )
    ix_ele_end: int = pydantic.Field(
        default=0,
        description="End point for making the map",
    )
    nodamp_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Nondamped orbital matrix. M_orbit = M_damp * M_nodamp",
    )
    damp_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Damping 'correction' to orbital matrix.",
    )
    stoc_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Stochatic matrix for the orbit.",
    )
    ref0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="Reference orbit at start.",
    )
    ref1: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="Reference orbit at end.",
    )


class PmdUnitStruct(pydantic.BaseModel):
    """
    PmdUnitStruct corresponds to bmad `pmd_unit_struct`
    which is in Users/klauer/Repos/bmad/bmad/hdf5/hdf5_openpmd_mod.f90 on line 9.

    Attributes
    ----------
    unitsymbol : str
        Native units name. EG 'eV'
        Bmad type: character
        Fortran default: ''
    unitsi : float
        Conversion to SI
        Bmad type: real
        Fortran default: 0
    unitdimension : float
        SI Base Exponents
        Bmad type: real
        Fortran default: 0
    """

    unitsymbol: str = pydantic.Field(
        default="",
        max_length=8,
        description="Native units name. EG 'eV'",
        validation_alias=pydantic.AliasChoices("unitsymbol", "unitSymbol"),
        serialization_alias="unitSymbol",
    )
    unitsi: float = pydantic.Field(
        default=0,
        description="Conversion to SI",
        validation_alias=pydantic.AliasChoices("unitsi", "unitSI"),
        serialization_alias="unitSI",
    )
    unitdimension: Sequence[float] = pydantic.Field(
        default=0,
        max_length=7,
        description="SI Base Exponents",
        validation_alias=pydantic.AliasChoices("unitdimension", "unitDimension"),
        serialization_alias="unitDimension",
    )


class Hdf5InfoStruct(pydantic.BaseModel):
    """
    Hdf5InfoStruct corresponds to bmad `hdf5_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/hdf5/hdf5_interface.f90 on line 41.

    Attributes
    ----------
    element_type : int
        Type of the element. See above.
        Bmad type: integer
        Fortran default: -1
    data_class_type : int
        Class type of associated data. Not used for groups. See above.
        Bmad type: integer
        Fortran default: -1
    data_dim : int
        Dimensions. Not used for groups. EG: Scaler data has [1, 0, 0].
        Bmad type: integer
        Fortran default: 0
    data_size : int
        Size of datums. Not used for groups. For strings size = # of characters.
        Bmad type: integer
        Fortran default: -1
    num_attributes : int
        Number of associated attributes. Used for groups and datasets only.
        Bmad type: integer
        Fortran default: -1
    """

    element_type: int = pydantic.Field(
        default=-1,
        description="Type of the element. See above.",
    )
    data_class_type: int = pydantic.Field(
        default=-1,
        description="Class type of associated data. Not used for groups. See above.",
    )
    data_dim: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        description="Dimensions. Not used for groups. EG: Scaler data has [1, 0, 0].",
    )
    data_size: int = pydantic.Field(
        default=-1,
        description="Size of datums. Not used for groups. For strings size = # of characters.",
    )
    num_attributes: int = pydantic.Field(
        default=-1,
        description="Number of associated attributes. Used for groups and datasets only.",
    )


class MultipassRegionEleStruct(pydantic.BaseModel):
    """
    MultipassRegionEleStruct corresponds to bmad `multipass_region_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/output/write_lattice_file_mod.f90 on line 6.

    Attributes
    ----------
    ix_region : int
        Bmad type: integer
    region_start_pt : bool
        Bmad type: logical
    region_stop_pt : bool
        Bmad type: logical
    """

    ix_region: int = pydantic.Field(
        default=0,
    )
    region_start_pt: bool = pydantic.Field(
        default=False,
    )
    region_stop_pt: bool = pydantic.Field(
        default=False,
    )


class MultipassRegionBranchStruct(pydantic.BaseModel):
    """
    MultipassRegionBranchStruct corresponds to bmad `multipass_region_branch_struct`
    which is in Users/klauer/Repos/bmad/bmad/output/write_lattice_file_mod.f90 on line 12.

    Attributes
    ----------
    ele : MultipassRegionEleStruct
        Bmad type: type
    """

    ele: Sequence[MultipassRegionEleStruct] = pydantic.Field(
        default=None,
    )


class MultipassRegionLatStruct(pydantic.BaseModel):
    """
    MultipassRegionLatStruct corresponds to bmad `multipass_region_lat_struct`
    which is in Users/klauer/Repos/bmad/bmad/output/write_lattice_file_mod.f90 on line 16.

    Attributes
    ----------
    branch : MultipassRegionBranchStruct
        Bmad type: type
    """

    branch: Sequence[MultipassRegionBranchStruct] = pydantic.Field(
        default=None,
    )


class DiffuseParamStruct(pydantic.BaseModel):
    """
    DiffuseParamStruct corresponds to bmad `diffuse_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_reflection_mod.f90 on line 13.

    Attributes
    ----------
    x : float
        Bmad type: real
    y : float
        Bmad type: real
    lambda_ : float
        Bmad type: real
    c_norm : float
        Bmad type: real
    chx_norm : float
        Bmad type: real
    prob_spline : SplineStruct
        Bmad type: type
    n_pt_spline : int
        Bmad type: integer
    """

    x: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )
    lambda_: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("lambda_", "lambda"),
        serialization_alias="lambda",
    )
    c_norm: float = pydantic.Field(
        default=0.0,
    )
    chx_norm: float = pydantic.Field(
        default=0.0,
    )
    prob_spline: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    n_pt_spline: int = pydantic.Field(
        default=0,
    )


class ChebDiffuseStruct(pydantic.BaseModel):
    """
    ChebDiffuseStruct corresponds to bmad `cheb_diffuse_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_reflection_mod.f90 on line 20.

    Attributes
    ----------
    cch_int : float
        Bmad type: real
    cch : float
        Bmad type: real
    """

    cch_int: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    cch: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class DiffuseCommonStruct(pydantic.BaseModel):
    """
    DiffuseCommonStruct corresponds to bmad `diffuse_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_reflection_mod.f90 on line 28.

    Attributes
    ----------
    use_spline_fit : bool
        Bmad type: logical
        Fortran default: .true.
    area_err_tol : float
        Bmad type: real
        Fortran default: 4d-3
    """

    use_spline_fit: bool = pydantic.Field(
        default=True,
    )
    area_err_tol: float = pydantic.Field(
        default=0.004,
    )


class PhotonInitXAngleSplineStruct(pydantic.BaseModel):
    """
    PhotonInitXAngleSplineStruct corresponds to bmad `photon_init_x_angle_spline_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_spline_mod.f90 on line 15.

    Attributes
    ----------
    prob : SplineStruct
        Bmad type: type
    pl : SplineStruct
        Bmad type: type
    pc : SplineStruct
        Bmad type: type
    pl45 : SplineStruct
        Bmad type: type
    """

    prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pc: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl45: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )


class PhotonInitYAngleSplineStruct(pydantic.BaseModel):
    """
    PhotonInitYAngleSplineStruct corresponds to bmad `photon_init_y_angle_spline_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_spline_mod.f90 on line 19.

    Attributes
    ----------
    prob : SplineStruct
        Bmad type: type
    pl : SplineStruct
        Bmad type: type
    pc : SplineStruct
        Bmad type: type
    pl45 : SplineStruct
        Bmad type: type
    x_angle : PhotonInitXAngleSplineStruct
        Bmad type: type
    """

    prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pc: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl45: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    x_angle: Sequence[PhotonInitXAngleSplineStruct] = pydantic.Field(
        default=None,
    )


class PhotonInitSplinesStruct(pydantic.BaseModel):
    """
    PhotonInitSplinesStruct corresponds to bmad `photon_init_splines_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_spline_mod.f90 on line 24.

    Attributes
    ----------
    source_type : str
        'bend', 'wiggler', 'undulator'
        Bmad type: character
    spline_space_dimensions : int
        Dimensions: [energy, y_angle, x_angle, x, y]
        Bmad type: integer
    energy_prob : SplineStruct
        Bmad type: type
    y_angle : PhotonInitYAngleSplineStruct
        Bmad type: type
    """

    source_type: str = pydantic.Field(
        default_factory=list,
        max_length=16,
        description="'bend', 'wiggler', 'undulator'",
    )
    spline_space_dimensions: int = pydantic.Field(
        default=0,
        description="Dimensions: [energy, y_angle, x_angle, x, y]",
    )
    energy_prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    y_angle: Sequence[PhotonInitYAngleSplineStruct] = pydantic.Field(
        default=None,
    )


class CrystalParamStruct(pydantic.BaseModel):
    """
    CrystalParamStruct corresponds to bmad `crystal_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_utils_mod.f90 on line 9.

    Attributes
    ----------
    cap_gamma : float
        Bmad type: real
    dtheta_sin_2theta : float
        Bmad type: real
    b_eff : float
        Bmad type: real
    wavelength : float
        Bmad type: real
    old_vvec : float
        Bmad type: real
    new_vvec : float
        Bmad type: real
    """

    cap_gamma: float = pydantic.Field(
        default=0.0,
    )
    dtheta_sin_2theta: float = pydantic.Field(
        default=0.0,
    )
    b_eff: float = pydantic.Field(
        default=0.0,
    )
    wavelength: float = pydantic.Field(
        default=0.0,
    )
    old_vvec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    new_vvec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )


class PhotonInitSplinePtStruct(pydantic.BaseModel):
    """
    PhotonInitSplinePtStruct corresponds to bmad `photon_init_spline_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_mod.f90 on line 22.

    Attributes
    ----------
    c0 : float
        Bmad type: real
    c1 : float
        Bmad type: real
    c2 : float
        Bmad type: real
    c3 : float
        Bmad type: real
    """

    c0: float = pydantic.Field(
        default=0.0,
    )
    c1: float = pydantic.Field(
        default=0.0,
    )
    c2: float = pydantic.Field(
        default=0.0,
    )
    c3: float = pydantic.Field(
        default=0.0,
    )


class PhotonInitSplineStruct(pydantic.BaseModel):
    """
    PhotonInitSplineStruct corresponds to bmad `photon_init_spline_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_mod.f90 on line 26.

    Attributes
    ----------
    x_min : float
        Lower bound
        Bmad type: real
    x_max : float
        Upper bound of Region of validity of this spline fit.
        Bmad type: real
    del_x : float
        Spacing between spline points
        Bmad type: real
    pt : PhotonInitSplinePtStruct
        Bmad type: type
    spline_type : int
        Bmad type: integer
    """

    x_min: float = pydantic.Field(
        default=0.0,
        description="Lower bound",
    )
    x_max: float = pydantic.Field(
        default=0.0,
        description="Upper bound of Region of validity of this spline fit.",
    )
    del_x: float = pydantic.Field(
        default=0.0,
        description="Spacing between spline points",
    )
    pt: Sequence[PhotonInitSplinePtStruct] = pydantic.Field(
        default=None,
    )
    spline_type: int = pydantic.Field(
        default=0,
    )


class PhotonCoordStruct(pydantic.BaseModel):
    """
    PhotonCoordStruct corresponds to bmad `photon_coord_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/capillary_mod.f90 on line 5.

    Attributes
    ----------
    orb : CoordStruct
        Phase space: orb%vec = (x, vx/c, y, vy/c, s, vs/c)
        Bmad type: type
    track_len : float
        Total track length from the start of the element.
        Bmad type: real
    ix_section : int
        Cross section index
        Bmad type: integer
    """

    orb: CoordStruct = pydantic.Field(
        default=None,
        description="Phase space: orb%vec = (x, vx/c, y, vy/c, s, vs/c)",
    )
    track_len: float = pydantic.Field(
        default=0.0,
        description="Total track length from the start of the element.",
    )
    ix_section: int = pydantic.Field(
        default=0,
        description="Cross section index",
    )


class PhotonTrackStruct(pydantic.BaseModel):
    """
    PhotonTrackStruct corresponds to bmad `photon_track_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/capillary_mod.f90 on line 11.

    Attributes
    ----------
    old : PhotonCoordStruct
        Bmad type: type
    now : PhotonCoordStruct
        Bmad type: type
    """

    old: PhotonCoordStruct = pydantic.Field(
        default=None,
    )
    now: PhotonCoordStruct = pydantic.Field(
        default=None,
    )


class CsrEleInfoStruct(pydantic.BaseModel):
    """
    CsrEleInfoStruct corresponds to bmad `csr_ele_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 22.

    Attributes
    ----------
    ele : EleStruct
        lattice element
        Bmad type: type
    orbit0 : CoordStruct
        centroid orbit at entrance/exit ends
        Bmad type: type
    orbit1 : CoordStruct
        centroid orbit at entrance/exit ends
        Bmad type: type
    floor0 : FloorPositionStruct
        Floor position of centroid at entrance/exit ends
        Bmad type: type
    floor1 : FloorPositionStruct
        Floor position of centroid at entrance/exit ends
        Bmad type: type
    ref_floor0 : FloorPositionStruct
        Floor position of element ref coords at entrance/exit ends
        Bmad type: type
    ref_floor1 : FloorPositionStruct
        Floor position of element ref coords at entrance/exit ends
        Bmad type: type
    spline : SplineStruct
        Spline for centroid orbit. spline%x = distance along chord.
        Bmad type: type
    theta_chord : float
        Reference angle of chord in z-x plane
        Bmad type: real
    l_chord : float
        Chord Length. Negative if bunch moves backwards in element.
        Bmad type: real
    dl_s : float
        L_s(of element) - L_chord
        Bmad type: real
    """

    ele: EleStruct = pydantic.Field(
        default=None,
        description="lattice element",
    )
    orbit0: CoordStruct = pydantic.Field(
        default=None,
        description="centroid orbit at entrance/exit ends",
    )
    orbit1: CoordStruct = pydantic.Field(
        default=None,
        description="centroid orbit at entrance/exit ends",
    )
    floor0: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of centroid at entrance/exit ends",
    )
    floor1: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of centroid at entrance/exit ends",
    )
    ref_floor0: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of element ref coords at entrance/exit ends",
    )
    ref_floor1: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of element ref coords at entrance/exit ends",
    )
    spline: SplineStruct = pydantic.Field(
        default=None,
        description="Spline for centroid orbit. spline%x = distance along chord.",
    )
    theta_chord: float = pydantic.Field(
        default=0.0,
        description="Reference angle of chord in z-x plane",
    )
    l_chord: float = pydantic.Field(
        default=0.0,
        description="Chord Length. Negative if bunch moves backwards in element.",
        validation_alias=pydantic.AliasChoices("l_chord", "L_chord"),
        serialization_alias="L_chord",
    )
    dl_s: float = pydantic.Field(
        default=0.0,
        description="L_s(of element) - L_chord",
        validation_alias=pydantic.AliasChoices("dl_s", "dL_s"),
        serialization_alias="dL_s",
    )


class CsrBunchSliceStruct(pydantic.BaseModel):
    """
    CsrBunchSliceStruct corresponds to bmad `csr_bunch_slice_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 34.

    Attributes
    ----------
    x0 : float
        Transverse center of the particle distrubution
        Bmad type: real
        Fortran default: 0
    y0 : float
        Transverse center of the particle distrubution
        Bmad type: real
        Fortran default: 0
    z0_edge : float
        Left (min z) edge of bin
        Bmad type: real
        Fortran default: 0
    z1_edge : float
        Right (max z) edge of bin
        Bmad type: real
        Fortran default: 0
    z_center : float
        z at center of bin.
        Bmad type: real
        Fortran default: 0
    sig_x : float
        particle's RMS width
        Bmad type: real
        Fortran default: 0
    sig_y : float
        particle's RMS width
        Bmad type: real
        Fortran default: 0
    charge : float
        charge of the particles
        Bmad type: real
        Fortran default: 0
    dcharge_density_dz : float
        Charge density gradient
        Bmad type: real
        Fortran default: 0
    edge_dcharge_density_dz : float
        gradient between this and preceeding bin. [Evaluated at bin edge.]
        Bmad type: real
        Fortran default: 0
    kick_csr : float
        CSR kick
        Bmad type: real
        Fortran default: 0
    coef_lsc_plus : float
        LSC Kick coefs.
        Bmad type: real
        Fortran default: 0
    coef_lsc_minus : float
        LSC Kick coefs.
        Bmad type: real
        Fortran default: 0
    kick_lsc : float
        Bmad type: real
        Fortran default: 0
    n_particle : float
        Number of particles in slice can be a fraction since particles span multiple
        bins.
        Bmad type: real
        Fortran default: 0
    """

    x0: float = pydantic.Field(
        default=0,
        description="Transverse center of the particle distrubution",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Transverse center of the particle distrubution",
    )
    z0_edge: float = pydantic.Field(
        default=0,
        description="Left (min z) edge of bin",
    )
    z1_edge: float = pydantic.Field(
        default=0,
        description="Right (max z) edge of bin",
    )
    z_center: float = pydantic.Field(
        default=0,
        description="z at center of bin.",
    )
    sig_x: float = pydantic.Field(
        default=0,
        description="particle's RMS width",
    )
    sig_y: float = pydantic.Field(
        default=0,
        description="particle's RMS width",
    )
    charge: float = pydantic.Field(
        default=0,
        description="charge of the particles",
    )
    dcharge_density_dz: float = pydantic.Field(
        default=0,
        description="Charge density gradient",
    )
    edge_dcharge_density_dz: float = pydantic.Field(
        default=0,
        description="gradient between this and preceeding bin. [Evaluated at bin edge.]",
    )
    kick_csr: float = pydantic.Field(
        default=0,
        description="CSR kick",
    )
    coef_lsc_plus: Sequence[float] = pydantic.Field(
        default=0,
        description="LSC Kick coefs.",
    )
    coef_lsc_minus: Sequence[float] = pydantic.Field(
        default=0,
        description="LSC Kick coefs.",
    )
    kick_lsc: float = pydantic.Field(
        default=0,
    )
    n_particle: float = pydantic.Field(
        default=0,
        description=(
            "Number of particles in slice can be a fraction since particles span "
            "multiple bins."
        ),
    )


class CsrKick1Struct(pydantic.BaseModel):
    """
    CsrKick1Struct corresponds to bmad `csr_kick1_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 57.

    Attributes
    ----------
    i_csr : float
        Kick integral.
        Bmad type: real
    i_int_csr : float
        Integrated Kick integral.
        Bmad type: real
    image_kick_csr : float
        kick.
        Bmad type: real
    l_vec : float
        L vector in global coordinates.
        Bmad type: real
    L : float
        Distance between source and kick points.
        Bmad type: real
    dl : float
        = epsilon_L = Ls - L
        Bmad type: real
    dz_particles : float
        Kicked particle - source particle position at constant time.
        Bmad type: real
    s_chord_source : float
        Source point coordinate along chord.
        Bmad type: real
    theta_l : float
        Angle of L vector
        Bmad type: real
    theta_sl : float
        Angle between velocity of particle at source pt and L
        Bmad type: real
    theta_lk : float
        Angle between L and velocity of kicked particle
        Bmad type: real
    ix_ele_source : int
        Source element index.
        Bmad type: integer
    floor_s : FloorPositionStruct
        Floor position of source pt
        Bmad type: type
    """

    i_csr: float = pydantic.Field(
        default=0.0,
        description="Kick integral.",
        validation_alias=pydantic.AliasChoices("i_csr", "I_csr"),
        serialization_alias="I_csr",
    )
    i_int_csr: float = pydantic.Field(
        default=0.0,
        description="Integrated Kick integral.",
        validation_alias=pydantic.AliasChoices("i_int_csr", "I_int_csr"),
        serialization_alias="I_int_csr",
    )
    image_kick_csr: float = pydantic.Field(
        default=0.0,
        description="kick.",
    )
    l_vec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="L vector in global coordinates.",
        validation_alias=pydantic.AliasChoices("l_vec", "L_vec"),
        serialization_alias="L_vec",
    )
    L: float = pydantic.Field(
        default=0.0,
        description="Distance between source and kick points.",
    )
    dl: float = pydantic.Field(
        default=0.0,
        description="= epsilon_L = Ls - L",
        validation_alias=pydantic.AliasChoices("dl", "dL"),
        serialization_alias="dL",
    )
    dz_particles: float = pydantic.Field(
        default=0.0,
        description="Kicked particle - source particle position at constant time.",
    )
    s_chord_source: float = pydantic.Field(
        default=0.0,
        description="Source point coordinate along chord.",
    )
    theta_l: float = pydantic.Field(
        default=0.0,
        description="Angle of L vector",
        validation_alias=pydantic.AliasChoices("theta_l", "theta_L"),
        serialization_alias="theta_L",
    )
    theta_sl: float = pydantic.Field(
        default=0.0,
        description="Angle between velocity of particle at source pt and L",
    )
    theta_lk: float = pydantic.Field(
        default=0.0,
        description="Angle between L and velocity of kicked particle",
    )
    ix_ele_source: int = pydantic.Field(
        default=0,
        description="Source element index.",
    )
    floor_s: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of source pt",
    )


class CsrParticlePositionStruct(pydantic.BaseModel):
    """
    CsrParticlePositionStruct corresponds to bmad `csr_particle_position_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 73.

    Attributes
    ----------
    r : float
        particle position
        Bmad type: real
    charge : float
        particle charge
        Bmad type: real
    """

    r: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="particle position",
    )
    charge: float = pydantic.Field(
        default=0.0,
        description="particle charge",
    )


class CsrStruct(pydantic.BaseModel):
    """
    CsrStruct corresponds to bmad `csr_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 78.

    Attributes
    ----------
    gamma : float
        Relativistic gamma factor.
        Bmad type: real
    gamma2 : float
        Relativistic gamma factor.
        Bmad type: real
    rel_mass : float
        m_particle / m_electron
        Bmad type: real
    beta : float
        Relativistic beta factor.
        Bmad type: real
    dz_slice : float
        Bin width
        Bmad type: real
        Fortran default: 0
    ds_track_step : float
        True step size
        Bmad type: real
    s_kick : float
        Kick point longitudinal location (element ref coords) from entrance end
        Bmad type: real
    s_chord_kick : float
        Kick point along beam centroid line
        Bmad type: real
    y_source : float
        Height of source particle.
        Bmad type: real
    kick_factor : float
        Coefficient to scale the kick
        Bmad type: real
    actual_track_step : float
        ds_track_step scalled by Length_centroid_chord / Length_element ratio
        Bmad type: real
    x0_bunch : float
        Bunch centroid
        Bmad type: real
    y0_bunch : float
        Bunch centroid
        Bmad type: real
    floor_k : FloorPositionStruct
        Floor coords at kick point
        Bmad type: type
    species : int
        Particle type
        Bmad type: integer
    ix_ele_kick : int
        Same as element being tracked through.
        Bmad type: integer
    slice : CsrBunchSliceStruct
        slice(i) refers to the i^th bunch slice.
        Bmad type: type
    kick1 : CsrKick1Struct
        kick1(i) referes to the kick between two slices i bins apart.
        Bmad type: type
    eleinfo : CsrEleInfoStruct
        Element-by-element information.
        Bmad type: type
    kick_ele : EleStruct
        Element where the kick pt is == ele tracked through.
        Bmad type: type
    mesh3d : Mesh3dStruct
        Bmad type: type
    position : CsrParticlePositionStruct
        Bmad type: type
    """

    gamma: float = pydantic.Field(
        default=0.0,
        description="Relativistic gamma factor.",
    )
    gamma2: float = pydantic.Field(
        default=0.0,
        description="Relativistic gamma factor.",
    )
    rel_mass: float = pydantic.Field(
        default=0.0,
        description="m_particle / m_electron",
    )
    beta: float = pydantic.Field(
        default=0.0,
        description="Relativistic beta factor.",
    )
    dz_slice: float = pydantic.Field(
        default=0,
        description="Bin width",
    )
    ds_track_step: float = pydantic.Field(
        default=0.0,
        description="True step size",
    )
    s_kick: float = pydantic.Field(
        default=0.0,
        description="Kick point longitudinal location (element ref coords) from entrance end",
    )
    s_chord_kick: float = pydantic.Field(
        default=0.0,
        description="Kick point along beam centroid line",
    )
    y_source: float = pydantic.Field(
        default=0.0,
        description="Height of source particle.",
    )
    kick_factor: float = pydantic.Field(
        default=0.0,
        description="Coefficient to scale the kick",
    )
    actual_track_step: float = pydantic.Field(
        default=0.0,
        description="ds_track_step scalled by Length_centroid_chord / Length_element ratio",
    )
    x0_bunch: float = pydantic.Field(
        default=0.0,
        description="Bunch centroid",
    )
    y0_bunch: float = pydantic.Field(
        default=0.0,
        description="Bunch centroid",
    )
    floor_k: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor coords at kick point",
    )
    species: int = pydantic.Field(
        default=0,
        description="Particle type",
    )
    ix_ele_kick: int = pydantic.Field(
        default=0,
        description="Same as element being tracked through.",
    )
    slice: Sequence[CsrBunchSliceStruct] = pydantic.Field(
        default=None,
        description="slice(i) refers to the i^th bunch slice.",
    )
    kick1: Sequence[CsrKick1Struct] = pydantic.Field(
        default=None,
        description="kick1(i) referes to the kick between two slices i bins apart.",
    )
    eleinfo: Sequence[CsrEleInfoStruct] = pydantic.Field(
        default=None,
        description="Element-by-element information.",
    )
    kick_ele: EleStruct = pydantic.Field(
        default=None,
        description="Element where the kick pt is == ele tracked through.",
    )
    mesh3d: Mesh3dStruct = pydantic.Field(
        default=None,
    )
    position: Sequence[CsrParticlePositionStruct] = pydantic.Field(
        default=None,
    )


class Mesh3dStruct(pydantic.BaseModel):
    """
    Mesh3dStruct corresponds to bmad `mesh3d_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/open_spacecharge_mod.f90 on line 14.

    Attributes
    ----------
    nlo : int
        Lowest  grid index in x, y, z (m) of rho and the quantity being computed (phi
        or E)
        Bmad type: integer
        Fortran default: [ 1,  1,  1]
    nhi : int
        Highest grid index in x, y, z (m) of rho and the quantity being computed (phi
        or E)
        Bmad type: integer
        Fortran default: [64, 64, 64]
    npad : int
        Array padding for cyclic convolution
        Bmad type: integer
        Fortran default: [ 1,  1,  1]
    min : float
        Minimim in each dimension
        Bmad type: real
    max : float
        Maximum in each dimension
        Bmad type: real
    delta : float
        Grid spacing
        Bmad type: real
    gamma : float
        Relativistic gamma
        Bmad type: real
    charge : float
        Total charge on mesh
        Bmad type: real
    rho : float
        Charge density grid
        Bmad type: real
    phi : float
        electric potential grid
        Bmad type: real
    efield : float
        electric field grid
        Bmad type: real
    bfield : float
        magnetic field grid
        Bmad type: real
    """

    nlo: Sequence[int] = pydantic.Field(
        default=[1, 1, 1],
        max_length=3,
        description=(
            "Lowest  grid index in x, y, z (m) of rho and the quantity being computed "
            "(phi or E)"
        ),
    )
    nhi: Sequence[int] = pydantic.Field(
        default=[64, 64, 64],
        max_length=3,
        description=(
            "Highest grid index in x, y, z (m) of rho and the quantity being computed "
            "(phi or E)"
        ),
    )
    npad: Sequence[int] = pydantic.Field(
        default=[1, 1, 1],
        max_length=3,
        description="Array padding for cyclic convolution",
    )
    min: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Minimim in each dimension",
    )
    max: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Maximum in each dimension",
    )
    delta: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Grid spacing",
    )
    gamma: float = pydantic.Field(
        default=0.0,
        description="Relativistic gamma",
    )
    charge: float = pydantic.Field(
        default=0.0,
        description="Total charge on mesh",
    )
    rho: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Charge density grid",
    )
    phi: Sequence[float] = pydantic.Field(
        default=0.0,
        description="electric potential grid",
    )
    efield: Sequence[float] = pydantic.Field(
        default=0.0,
        description="electric field grid",
    )
    bfield: Sequence[float] = pydantic.Field(
        default=0.0,
        description="magnetic field grid",
    )


class SeqEleStruct(pydantic.BaseModel):
    """
    SeqEleStruct corresponds to bmad `seq_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 14.

    Attributes
    ----------
    name : str
        name of element, subline, or sublist
        Bmad type: character
    actual_arg : str
        Bmad type: character
    tag : str
        tag name.
        Bmad type: character
        Fortran default: ''
    slice_start : str
        For "my_line[start:end]" slice constructs.
        Bmad type: character
        Fortran default: ''
    slice_end : str
        For "my_line[start:end]" slice constructs.
        Bmad type: character
        Fortran default: ''
    type : int
        LINE$, REPLACEMENT_LINE$, LIST$, ELEMENT$
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        if an element: pointer to ELE array
        Bmad type: integer
        Fortran default: 0
    ix_arg : int
        index in arg list (for replacement lines)
        Bmad type: integer
        Fortran default: 0
    rep_count : int
        how many copies of an element
        Bmad type: integer
        Fortran default: 1
    ele_order_reflect : bool
        Travel through ele sequence in reverse order
        Bmad type: logical
        Fortran default: .false.
    ele_orientation : int
        element has reverse orientation.
        Bmad type: integer
        Fortran default: 1
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="name of element, subline, or sublist",
    )
    actual_arg: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    tag: str = pydantic.Field(
        default="",
        max_length=40,
        description="tag name.",
    )
    slice_start: str = pydantic.Field(
        default="",
        max_length=40,
        description="For 'my_line[start:end]' slice constructs.",
    )
    slice_end: str = pydantic.Field(
        default="",
        max_length=40,
        description="For 'my_line[start:end]' slice constructs.",
    )
    type: int = pydantic.Field(
        default=0,
        description="LINE$, REPLACEMENT_LINE$, LIST$, ELEMENT$",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="if an element: pointer to ELE array",
    )
    ix_arg: int = pydantic.Field(
        default=0,
        description="index in arg list (for replacement lines)",
    )
    rep_count: int = pydantic.Field(
        default=1,
        description="how many copies of an element",
    )
    ele_order_reflect: bool = pydantic.Field(
        default=False,
        description="Travel through ele sequence in reverse order",
    )
    ele_orientation: int = pydantic.Field(
        default=1,
        description="element has reverse orientation.",
    )


class BaseLineEleStruct(pydantic.BaseModel):
    """
    BaseLineEleStruct corresponds to bmad `base_line_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 29.

    Attributes
    ----------
    name : str
        Name of sequence or element
        Bmad type: character
        Fortran default: ''
    tag : str
        Tag name.
        Bmad type: character
        Fortran default: ''
    ix_multi : int
        Multipass indentifier
        Bmad type: integer
        Fortran default: 0
    orientation : int
        Element reversed?
        Bmad type: integer
        Fortran default: 1
    ix_ele_in_in_lat : int
        Bmad type: integer
        Fortran default: -1
    ele_order_reflect : bool
        Part of reflection or reversed line?
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of sequence or element",
    )
    tag: str = pydantic.Field(
        default="",
        max_length=40,
        description="Tag name.",
    )
    ix_multi: int = pydantic.Field(
        default=0,
        description="Multipass indentifier",
    )
    orientation: int = pydantic.Field(
        default=1,
        description="Element reversed?",
    )
    ix_ele_in_in_lat: int = pydantic.Field(
        default=-1,
    )
    ele_order_reflect: bool = pydantic.Field(
        default=False,
        description="Part of reflection or reversed line?",
    )


class SeqStruct(pydantic.BaseModel):
    """
    SeqStruct corresponds to bmad `seq_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 38.

    Attributes
    ----------
    name : str
        name of sequence
        Bmad type: character
    ele : SeqEleStruct
        Elements in the sequence
        Bmad type: type
    dummy_arg : str
        Bmad type: character
    corresponding_actual_arg : str
        Bmad type: character
    type : int
        LINE$, REPLACEMENT_LINE$ or LIST$
        Bmad type: integer
    ix_list : int
        Current index for lists
        Bmad type: integer
    list_upcount : int
        Bmad type: integer
        Fortran default: 0
    index : int
        Alphabetical order sorted index
        Bmad type: integer
    file_name : str
        File where sequence is defined
        Bmad type: character
        Fortran default: ''
    ix_file_line : int
        Line number in file where sequence is defined
        Bmad type: integer
    multipass : bool
        Bmad type: logical
    ptc_layout : bool
        Put in separate PTC layout
        Bmad type: logical
    active : bool
        Used to prevent infinite loops.
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="name of sequence",
    )
    ele: Sequence[SeqEleStruct] = pydantic.Field(
        default=None,
        description="Elements in the sequence",
    )
    dummy_arg: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    corresponding_actual_arg: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    type: int = pydantic.Field(
        default=0,
        description="LINE$, REPLACEMENT_LINE$ or LIST$",
    )
    ix_list: int = pydantic.Field(
        default=0,
        description="Current index for lists",
    )
    list_upcount: int = pydantic.Field(
        default=0,
    )
    index: int = pydantic.Field(
        default=0,
        description="Alphabetical order sorted index",
    )
    file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="File where sequence is defined",
    )
    ix_file_line: int = pydantic.Field(
        default=0,
        description="Line number in file where sequence is defined",
    )
    multipass: bool = pydantic.Field(
        default=False,
    )
    ptc_layout: bool = pydantic.Field(
        default=False,
        description="Put in separate PTC layout",
    )
    active: bool = pydantic.Field(
        default=False,
        description="Used to prevent infinite loops.",
    )


class StackFileStruct(pydantic.BaseModel):
    """
    StackFileStruct corresponds to bmad `stack_file_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 60.

    Attributes
    ----------
    full_name : str
        Bmad type: character
        Fortran default: ''
    dir : str
        Bmad type: character
        Fortran default: './'
    input_line1_saved : str
        Bmad type: character
        Fortran default: ''
    input_line2_saved : str
        Bmad type: character
        Fortran default: ''
    rest_of_line_saved : str
        Bmad type: character
        Fortran default: ''
    parse_line_saved : str
        Bmad type: character
        Fortran default: ''
    next_chunk_saved : str
        Bmad type: character
        Fortran default: ''
    last_char_in_parse_line_saved : str
        Bmad type: character
        Fortran default: ''
    ios_next_chunk_saved : int
        Bmad type: integer
        Fortran default: 0
    ios_this_chunk_saved : int
        Bmad type: integer
        Fortran default: 0
    i_line : int
        Bmad type: integer
        Fortran default: 0
    f_unit : int
        Bmad type: integer
        Fortran default: 0
    inline_call_active : bool
        Bmad type: logical
        Fortran default: .false.
    """

    full_name: str = pydantic.Field(
        default="",
        max_length=400,
    )
    dir: str = pydantic.Field(
        default="./",
        max_length=400,
    )
    input_line1_saved: str = pydantic.Field(
        default="",
    )
    input_line2_saved: str = pydantic.Field(
        default="",
    )
    rest_of_line_saved: str = pydantic.Field(
        default="",
    )
    parse_line_saved: str = pydantic.Field(
        default="",
    )
    next_chunk_saved: str = pydantic.Field(
        default="",
    )
    last_char_in_parse_line_saved: str = pydantic.Field(
        default="",
        max_length=1,
    )
    ios_next_chunk_saved: int = pydantic.Field(
        default=0,
    )
    ios_this_chunk_saved: int = pydantic.Field(
        default=0,
    )
    i_line: int = pydantic.Field(
        default=0,
    )
    f_unit: int = pydantic.Field(
        default=0,
    )
    inline_call_active: bool = pydantic.Field(
        default=False,
    )


class ParserControllerStruct(pydantic.BaseModel):
    """
    ParserControllerStruct corresponds to bmad `parser_controller_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 78.

    Attributes
    ----------
    name : str
        Bmad type: character
    attrib_name : str
        Bmad type: character
    stack : ExpressionAtomStruct
        Arithmetic expression stack
        Bmad type: type
    y_knot : float
        Bmad type: real
    n_stk : int
        Bmad type: integer
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    attrib_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    stack: Sequence[ExpressionAtomStruct] = pydantic.Field(
        default=None,
        description="Arithmetic expression stack",
    )
    y_knot: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n_stk: int = pydantic.Field(
        default=0,
    )


class ParserEleStruct(pydantic.BaseModel):
    """
    ParserEleStruct corresponds to bmad `parser_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 86.

    Attributes
    ----------
    control : ParserControllerStruct
        Bmad type: type
    field_overlaps : str
        Bmad type: character
    ref_name : str
        Bmad type: character
        Fortran default: ''
    ix_super_ref_multipass : int
        Multipass index for superimpose reference element.
        Bmad type: integer
        Fortran default: 0
    ele_name : str
        For fork element or superimpose statement.
        Bmad type: character
        Fortran default: ''
    names1 : str
        Currently just used by feedback element.
        Bmad type: character
    names2 : str
        Currently just used by feedback element.
        Bmad type: character
    lat_file : str
        File where element was defined.
        Bmad type: character
        Fortran default: ''
    offset : float
        Bmad type: real
        Fortran default: 0
    ix_line_in_file : int
        Line in file where element was defined.
        Bmad type: integer
    ix_count : int
        Bmad type: integer
    ele_pt : int
        Bmad type: integer
    ref_pt : int
        Bmad type: integer
    index : int
        Bmad type: integer
    superposition_command_here : bool
        Bmad type: logical
        Fortran default: .false.
    superposition_has_been_set : bool
        Bmad type: logical
        Fortran default: .false.
    wrap_superimpose : bool
        Bmad type: logical
        Fortran default: .true.
    create_jumbo_slave : bool
        Bmad type: logical
        Fortran default: .false.
    is_range : bool
        For girders
        Bmad type: logical
        Fortran default: .false.
    default_attrib : str
        For group/overlay elements: slave attribute
        Bmad type: character
        Fortran default: ''
    """

    control: Sequence[ParserControllerStruct] = pydantic.Field(
        default=None,
    )
    field_overlaps: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    ref_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ix_super_ref_multipass: int = pydantic.Field(
        default=0,
        description="Multipass index for superimpose reference element.",
    )
    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="For fork element or superimpose statement.",
    )
    names1: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="Currently just used by feedback element.",
    )
    names2: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="Currently just used by feedback element.",
    )
    lat_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="File where element was defined.",
    )
    offset: float = pydantic.Field(
        default=0,
    )
    ix_line_in_file: int = pydantic.Field(
        default=0,
        description="Line in file where element was defined.",
    )
    ix_count: int = pydantic.Field(
        default=0,
    )
    ele_pt: int = pydantic.Field(
        default=0,
    )
    ref_pt: int = pydantic.Field(
        default=0,
    )
    index: int = pydantic.Field(
        default=0,
    )
    superposition_command_here: bool = pydantic.Field(
        default=False,
    )
    superposition_has_been_set: bool = pydantic.Field(
        default=False,
    )
    wrap_superimpose: bool = pydantic.Field(
        default=True,
    )
    create_jumbo_slave: bool = pydantic.Field(
        default=False,
    )
    is_range: bool = pydantic.Field(
        default=False,
        description="For girders",
    )
    default_attrib: str = pydantic.Field(
        default="",
        max_length=40,
        description="For group/overlay elements: slave attribute",
    )


class ParserLatStruct(pydantic.BaseModel):
    """
    ParserLatStruct corresponds to bmad `parser_lat_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 108.

    Attributes
    ----------
    ele : ParserEleStruct
        Bmad type: type
    """

    ele: Sequence[ParserEleStruct] = pydantic.Field(
        default=None,
    )


class BpConstStruct(pydantic.BaseModel):
    """
    BpConstStruct corresponds to bmad `bp_const_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 121.

    Attributes
    ----------
    name : str
        Constant name
        Bmad type: character
        Fortran default: ''
    value : float
        Constant value
        Bmad type: real
        Fortran default: 0
    index : int
        Constant sort index
        Bmad type: integer
        Fortran default: 0
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Constant name",
    )
    value: float = pydantic.Field(
        default=0,
        description="Constant value",
    )
    index: int = pydantic.Field(
        default=0,
        description="Constant sort index",
    )


class BpCommonStruct(pydantic.BaseModel):
    """
    BpCommonStruct corresponds to bmad `bp_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 127.

    Attributes
    ----------
    file : StackFileStruct
        Bmad type: type
        Fortran default: stack_file_struct()
    current_file : StackFileStruct
        Bmad type: type
        Fortran default: null()
    old_lat : LatStruct
        Bmad type: type
        Fortran default: null()
    extra : ExtraParsingInfoStruct
        Bmad type: type
        Fortran default: extra_parsing_info_struct()
    i_file_level : int
        Bmad type: integer
        Fortran default: 0
    num_lat_files : int
        Number of files opened
        Bmad type: integer
        Fortran default: 0
    i_const_tot : int
        Bmad type: integer
        Fortran default: 0
    i_const_init : int
        Bmad type: integer
        Fortran default: 0
    ios_next_chunk : int
        Bmad type: integer
        Fortran default: 0
    ios_this_chunk : int
        Bmad type: integer
        Fortran default: 0
    lat_file_names : str
        List of all files used to create lat
        Bmad type: character
    line1_file_name : str
        Name of file from which %input_line1 was read
        Bmad type: character
        Fortran default: ''
    line2_file_name : str
        Name of file from which %input_line2 was read
        Bmad type: character
        Fortran default: ''
    parse_line : str
        Current string to be parsed.
        Bmad type: character
        Fortran default: ''
    input_line1 : str
        Line before current line. For debug messages.
        Bmad type: character
        Fortran default: ''
    input_line2 : str
        Current line. For debug messages.
        Bmad type: character
        Fortran default: ''
    rest_of_line : str
        Line after semicolon saved until current statement is completely parsed.
        Bmad type: character
        Fortran default: ''
    next_chunk : str
        Line waiting to be appended to the parse_line.
        Bmad type: character
        Fortran default: ''
    last_char_in_parse_line : str
        Needed for long lines read in pieces.
        Bmad type: character
        Fortran default: ''
    parser_name : str
        Blank means not in bmad_parser nor bmad_parser2.
        Bmad type: character
        Fortran default: ''
    last_word : str
        Last word to be parsed
        Bmad type: character
        Fortran default: ''
    bmad_parser_calling : bool
        used for expand_lattice
        Bmad type: logical
        Fortran default: .false.
    fatal_error_flag : bool
        Set True on fatal (must abort now) error
        Bmad type: logical
        Fortran default: .false.
    error_flag : bool
        Set True on error
        Bmad type: logical
        Fortran default: .false.
    input_line_meaningful : bool
        Bmad type: logical
        Fortran default: .false.
    do_superimpose : bool
        Bmad type: logical
        Fortran default: .true.
    write_digested : bool
        For bmad_parser
        Bmad type: logical
        Fortran default: .true.
    write_digested2 : bool
        For bmad_parser2
        Bmad type: logical
        Fortran default: .true.
    always_parse : bool
        For debugging to force parsing
        Bmad type: logical
        Fortran default: .false.
    input_from_file : bool
        Input is from a lattice file?
        Bmad type: logical
        Fortran default: .true.
    inline_call_active : bool
        Bmad type: logical
        Fortran default: .false.
    print_err : bool
        Print error messages?
        Bmad type: logical
        Fortran default: .true.
    undefined_vars_evaluate_to_zero : bool
        Bmad type: logical
        Fortran default: .true.
    use_local_lat_file : bool
        Bmad type: logical
        Fortran default: .false.
    used_line_set_by_calling_routine : bool
        Bmad type: logical
        Fortran default: .false.
    calc_reference_orbit : bool
        Bmad type: logical
        Fortran default: .false.
    detected_expand_lattice_cmd : bool
        Bmad type: logical
        Fortran default: .false.
    time0 : float
        For timing parsing
        Bmad type: real
        Fortran default: 0
    time1 : float
        For timing parsing
        Bmad type: real
        Fortran default: 0
    time2 : float
        For timing parsing
        Bmad type: real
        Fortran default: 0
    time3 : float
        For timing parsing
        Bmad type: real
        Fortran default: 0
    """

    file: Sequence[StackFileStruct] = pydantic.Field(
        default=None,
    )
    current_file: StackFileStruct = pydantic.Field(
        default=None,
    )
    old_lat: LatStruct = pydantic.Field(
        default=None,
    )
    extra: ExtraParsingInfoStruct = pydantic.Field(
        default=None,
    )
    i_file_level: int = pydantic.Field(
        default=0,
    )
    num_lat_files: int = pydantic.Field(
        default=0,
        description="Number of files opened",
    )
    i_const_tot: int = pydantic.Field(
        default=0,
    )
    i_const_init: int = pydantic.Field(
        default=0,
    )
    ios_next_chunk: int = pydantic.Field(
        default=0,
    )
    ios_this_chunk: int = pydantic.Field(
        default=0,
    )
    lat_file_names: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=400,
        description="List of all files used to create lat",
    )
    line1_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Name of file from which %input_line1 was read",
    )
    line2_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Name of file from which %input_line2 was read",
    )
    parse_line: str = pydantic.Field(
        default="",
        description="Current string to be parsed.",
    )
    input_line1: str = pydantic.Field(
        default="",
        description="Line before current line. For debug messages.",
    )
    input_line2: str = pydantic.Field(
        default="",
        description="Current line. For debug messages.",
    )
    rest_of_line: str = pydantic.Field(
        default="",
        description="Line after semicolon saved until current statement is completely parsed.",
    )
    next_chunk: str = pydantic.Field(
        default="",
        description="Line waiting to be appended to the parse_line.",
    )
    last_char_in_parse_line: str = pydantic.Field(
        default="",
        max_length=1,
        description="Needed for long lines read in pieces.",
    )
    parser_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Blank means not in bmad_parser nor bmad_parser2.",
    )
    last_word: str = pydantic.Field(
        default="",
        max_length=100,
        description="Last word to be parsed",
    )
    bmad_parser_calling: bool = pydantic.Field(
        default=False,
        description="used for expand_lattice",
    )
    fatal_error_flag: bool = pydantic.Field(
        default=False,
        description="Set True on fatal (must abort now) error",
    )
    error_flag: bool = pydantic.Field(
        default=False,
        description="Set True on error",
    )
    input_line_meaningful: bool = pydantic.Field(
        default=False,
    )
    do_superimpose: bool = pydantic.Field(
        default=True,
    )
    write_digested: bool = pydantic.Field(
        default=True,
        description="For bmad_parser",
    )
    write_digested2: bool = pydantic.Field(
        default=True,
        description="For bmad_parser2",
    )
    always_parse: bool = pydantic.Field(
        default=False,
        description="For debugging to force parsing",
    )
    input_from_file: bool = pydantic.Field(
        default=True,
        description="Input is from a lattice file?",
    )
    inline_call_active: bool = pydantic.Field(
        default=False,
    )
    print_err: bool = pydantic.Field(
        default=True,
        description="Print error messages?",
    )
    undefined_vars_evaluate_to_zero: bool = pydantic.Field(
        default=True,
    )
    use_local_lat_file: bool = pydantic.Field(
        default=False,
    )
    used_line_set_by_calling_routine: bool = pydantic.Field(
        default=False,
    )
    calc_reference_orbit: bool = pydantic.Field(
        default=False,
    )
    detected_expand_lattice_cmd: bool = pydantic.Field(
        default=False,
    )
    time0: float = pydantic.Field(
        default=0,
        description="For timing parsing",
    )
    time1: float = pydantic.Field(
        default=0,
        description="For timing parsing",
    )
    time2: float = pydantic.Field(
        default=0,
        description="For timing parsing",
    )
    time3: float = pydantic.Field(
        default=0,
        description="For timing parsing",
    )


class BpCommon2Struct(pydantic.BaseModel):
    """
    BpCommon2Struct corresponds to bmad `bp_common2_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 176.

    Attributes
    ----------
    const : BpConstStruct
        Constant name
        Bmad type: type
    """

    const: Sequence[BpConstStruct] = pydantic.Field(
        default=None,
        description="Constant name",
    )


class SummationRdtStruct(pydantic.BaseModel):
    """
    SummationRdtStruct corresponds to bmad `summation_rdt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/srdt_mod.f90 on line 11.

    Attributes
    ----------
    h11001 : Complex
        Bmad type: complex
    h00111 : Complex
        Bmad type: complex
    h20001 : Complex
        Bmad type: complex
    h00201 : Complex
        Bmad type: complex
    h10002 : Complex
        Bmad type: complex
    h21000 : Complex
        Bmad type: complex
    h30000 : Complex
        Bmad type: complex
    h10110 : Complex
        Bmad type: complex
    h10020 : Complex
        Bmad type: complex
    h10200 : Complex
        Bmad type: complex
    h31000 : Complex
        Bmad type: complex
    h40000 : Complex
        Bmad type: complex
    h20110 : Complex
        Bmad type: complex
    h11200 : Complex
        Bmad type: complex
    h20020 : Complex
        Bmad type: complex
    h20200 : Complex
        Bmad type: complex
    h00310 : Complex
        Bmad type: complex
    h00400 : Complex
        Bmad type: complex
    h22000 : Complex
        Bmad type: complex
    h00220 : Complex
        Bmad type: complex
    h11110 : Complex
        Bmad type: complex
    """

    h11001: Complex = pydantic.Field(
        default=0.0,
    )
    h00111: Complex = pydantic.Field(
        default=0.0,
    )
    h20001: Complex = pydantic.Field(
        default=0.0,
    )
    h00201: Complex = pydantic.Field(
        default=0.0,
    )
    h10002: Complex = pydantic.Field(
        default=0.0,
    )
    h21000: Complex = pydantic.Field(
        default=0.0,
    )
    h30000: Complex = pydantic.Field(
        default=0.0,
    )
    h10110: Complex = pydantic.Field(
        default=0.0,
    )
    h10020: Complex = pydantic.Field(
        default=0.0,
    )
    h10200: Complex = pydantic.Field(
        default=0.0,
    )
    h31000: Complex = pydantic.Field(
        default=0.0,
    )
    h40000: Complex = pydantic.Field(
        default=0.0,
    )
    h20110: Complex = pydantic.Field(
        default=0.0,
    )
    h11200: Complex = pydantic.Field(
        default=0.0,
    )
    h20020: Complex = pydantic.Field(
        default=0.0,
    )
    h20200: Complex = pydantic.Field(
        default=0.0,
    )
    h00310: Complex = pydantic.Field(
        default=0.0,
    )
    h00400: Complex = pydantic.Field(
        default=0.0,
    )
    h22000: Complex = pydantic.Field(
        default=0.0,
    )
    h00220: Complex = pydantic.Field(
        default=0.0,
    )
    h11110: Complex = pydantic.Field(
        default=0.0,
    )


class SlicedElesStruct(pydantic.BaseModel):
    """
    SlicedElesStruct corresponds to bmad `sliced_eles_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/srdt_mod.f90 on line 41.

    Attributes
    ----------
    ix : int
        Bmad type: integer
    k1l : float
        Bmad type: real
    k2l : float
        Bmad type: real
    s : float
        Bmad type: real
    L : float
        Bmad type: real
    eta_a : float
        Bmad type: real
    beta_a : float
        Bmad type: real
    beta_b : float
        Bmad type: real
    phi_a : float
        Bmad type: real
    phi_b : float
        Bmad type: real
    good_k2 : bool
        Bmad type: logical
    srdt : SummationRdtStruct
        Bmad type: type
    ea : Complex
        Bmad type: complex
    eb : Complex
        Bmad type: complex
    e2a : Complex
        Bmad type: complex
    e2b : Complex
        Bmad type: complex
    e3a : Complex
        Bmad type: complex
    """

    ix: int = pydantic.Field(
        default=0,
    )
    k1l: float = pydantic.Field(
        default=0.0,
    )
    k2l: float = pydantic.Field(
        default=0.0,
    )
    s: float = pydantic.Field(
        default=0.0,
    )
    L: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("L", "l"),
        serialization_alias="l",
    )
    eta_a: float = pydantic.Field(
        default=0.0,
    )
    beta_a: float = pydantic.Field(
        default=0.0,
    )
    beta_b: float = pydantic.Field(
        default=0.0,
    )
    phi_a: float = pydantic.Field(
        default=0.0,
    )
    phi_b: float = pydantic.Field(
        default=0.0,
    )
    good_k2: bool = pydantic.Field(
        default=False,
    )
    srdt: SummationRdtStruct = pydantic.Field(
        default=None,
    )
    ea: Complex = pydantic.Field(
        default=0.0,
    )
    eb: Complex = pydantic.Field(
        default=0.0,
    )
    e2a: Complex = pydantic.Field(
        default=0.0,
    )
    e2b: Complex = pydantic.Field(
        default=0.0,
    )
    e3a: Complex = pydantic.Field(
        default=0.0,
    )


class FringeFieldInfoStruct(pydantic.BaseModel):
    """
    FringeFieldInfoStruct corresponds to bmad `fringe_field_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 35.

    Attributes
    ----------
    hard_ele : EleStruct
        Bmad type: type
        Fortran default: null()
    s_edge_hard : float
        Bmad type: real
        Fortran default: 0
    ds_edge : float
        Distance from particle to edge in hard_ele frame.
        Bmad type: real
        Fortran default: 0
    particle_at : int
        first_track_edge$, second_track_edge$, or none$
        Bmad type: integer
        Fortran default: -1
    hard_location : int
        Particle location wrt hard_ele. Points to element in location(:).
        Bmad type: integer
        Fortran default: null()
    location : int
        Particle location in an element. entrance_end$, inside$, or exit_end$
        Bmad type: integer
    has_fringe : bool
        Has a fringe to worry about?
        Bmad type: logical
        Fortran default: .false.
    """

    hard_ele: EleStruct = pydantic.Field(
        default=None,
    )
    s_edge_hard: float = pydantic.Field(
        default=0,
    )
    ds_edge: float = pydantic.Field(
        default=0,
        description="Distance from particle to edge in hard_ele frame.",
    )
    particle_at: int = pydantic.Field(
        default=-1,
        description="first_track_edge$, second_track_edge$, or none$",
    )
    hard_location: int = pydantic.Field(
        default=0,
        description="Particle location wrt hard_ele. Points to element in location(:).",
    )
    location: Sequence[int] = pydantic.Field(
        default=0,
        description="Particle location in an element. entrance_end$, inside$, or exit_end$",
    )
    has_fringe: bool = pydantic.Field(
        default=False,
        description="Has a fringe to worry about?",
    )


class ExpressionAtomStruct(pydantic.BaseModel):
    """
    ExpressionAtomStruct corresponds to bmad `expression_atom_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 55.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    type : int
        plus$, minum$, sin$, cos$, etc. To convert to string use: expression_op_name
        Bmad type: integer
        Fortran default: 0
    value : float
        Bmad type: real
        Fortran default: 0
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    type: int = pydantic.Field(
        default=0,
        description="plus$, minum$, sin$, cos$, etc. To convert to string use: expression_op_name",
    )
    value: float = pydantic.Field(
        default=0,
    )


class TwissStruct(pydantic.BaseModel):
    """
    TwissStruct corresponds to bmad `twiss_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 181.

    Attributes
    ----------
    beta : float
        Bmad type: real
        Fortran default: 0
    alpha : float
        Bmad type: real
        Fortran default: 0
    gamma : float
        Bmad type: real
        Fortran default: 0
    phi : float
        Bmad type: real
        Fortran default: 0
    eta : float
        Bmad type: real
        Fortran default: 0
    etap : float
        Bmad type: real
        Fortran default: 0
    deta_ds : float
        Bmad type: real
        Fortran default: 0
    sigma : float
        Bmad type: real
        Fortran default: 0
    sigma_p : float
        Bmad type: real
        Fortran default: 0
    emit : float
        Bmad type: real
        Fortran default: 0
    norm_emit : float
        Bmad type: real
        Fortran default: 0
    """

    beta: float = pydantic.Field(
        default=0,
    )
    alpha: float = pydantic.Field(
        default=0,
    )
    gamma: float = pydantic.Field(
        default=0,
    )
    phi: float = pydantic.Field(
        default=0,
    )
    eta: float = pydantic.Field(
        default=0,
    )
    etap: float = pydantic.Field(
        default=0,
    )
    deta_ds: float = pydantic.Field(
        default=0,
    )
    sigma: float = pydantic.Field(
        default=0,
    )
    sigma_p: float = pydantic.Field(
        default=0,
    )
    emit: float = pydantic.Field(
        default=0,
    )
    norm_emit: float = pydantic.Field(
        default=0,
    )


class Interval1CoefStruct(pydantic.BaseModel):
    """
    Interval1CoefStruct corresponds to bmad `interval1_coef_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 200.

    Attributes
    ----------
    c0 : float
        Bmad type: real
    c1 : float
        Bmad type: real
    n_exp : float
        Bmad type: real
    """

    c0: float = pydantic.Field(
        default=0.0,
    )
    c1: float = pydantic.Field(
        default=0.0,
    )
    n_exp: float = pydantic.Field(
        default=0.0,
    )


class PhotonReflectTableStruct(pydantic.BaseModel):
    """
    PhotonReflectTableStruct corresponds to bmad `photon_reflect_table_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 204.

    Attributes
    ----------
    angle : float
        Vector of angle values for %p_reflect
        Bmad type: real
    energy : float
        Vector of energy values for %p_reflect
        Bmad type: real
    int1 : Interval1CoefStruct
        Bmad type: type
    p_reflect : float
        (angle, ev) probability. Log used for smooth surface reflection
        Bmad type: real
    max_energy : float
        maximum energy for this table
        Bmad type: real
        Fortran default: -1
    p_reflect_scratch : float
        Scratch space
        Bmad type: real
    bragg_angle : float
        Bragg angle at energy values.
        Bmad type: real
    """

    angle: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Vector of angle values for %p_reflect",
    )
    energy: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Vector of energy values for %p_reflect",
    )
    int1: Sequence[Interval1CoefStruct] = pydantic.Field(
        default=None,
    )
    p_reflect: Sequence[float] = pydantic.Field(
        default=0.0,
        description="(angle, ev) probability. Log used for smooth surface reflection",
    )
    max_energy: float = pydantic.Field(
        default=-1,
        description="maximum energy for this table",
    )
    p_reflect_scratch: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Scratch space",
    )
    bragg_angle: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Bragg angle at energy values.",
    )


class PhotonReflectSurfaceStruct(pydantic.BaseModel):
    """
    PhotonReflectSurfaceStruct corresponds to bmad `photon_reflect_surface_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 218.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    description : str
        Descriptive name
        Bmad type: character
        Fortran default: ''
    reflectivity_file : str
        Bmad type: character
        Fortran default: ''
    table : PhotonReflectTableStruct
        Bmad type: type
    surface_roughness_rms : float
        sigma in Dugan's notation
        Bmad type: real
        Fortran default: 0
    roughness_correlation_len : float
        T in Dugan's notation
        Bmad type: real
        Fortran default: 0
    ix_surface : int
        Bmad type: integer
        Fortran default: -1
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    description: str = pydantic.Field(
        default="",
        max_length=80,
        description="Descriptive name",
    )
    reflectivity_file: str = pydantic.Field(
        default="",
        max_length=200,
    )
    table: Sequence[PhotonReflectTableStruct] = pydantic.Field(
        default=None,
    )
    surface_roughness_rms: float = pydantic.Field(
        default=0,
        description="sigma in Dugan's notation",
    )
    roughness_correlation_len: float = pydantic.Field(
        default=0,
        description="T in Dugan's notation",
    )
    ix_surface: int = pydantic.Field(
        default=-1,
    )


class PauliStruct(pydantic.BaseModel):
    """
    PauliStruct corresponds to bmad `pauli_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 259.

    Attributes
    ----------
    sigma : Complex
        Bmad type: complex
    """

    sigma: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )


class SpinEigenStruct(pydantic.BaseModel):
    """
    SpinEigenStruct corresponds to bmad `spin_eigen_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 269.

    Attributes
    ----------
    vec : Complex
        Bmad type: complex
        Fortran default: 0
    val : Complex
        Bmad type: complex
        Fortran default: 0
    """

    vec: Sequence[Complex] = pydantic.Field(
        default=0,
        max_length=8,
    )
    val: Complex = pydantic.Field(
        default=0,
    )


class SpinAxisStruct(pydantic.BaseModel):
    """
    SpinAxisStruct corresponds to bmad `spin_axis_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 274.

    Attributes
    ----------
    L : float
        Transverse axis.
        Bmad type: real
        Fortran default: 0
    n0 : float
        Invariant spin axis on closed orbit.
        Bmad type: real
        Fortran default: 0
    m : float
        Transverse axis.
        Bmad type: real
        Fortran default: 0
    """

    L: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Transverse axis.",
        validation_alias=pydantic.AliasChoices("L", "l"),
        serialization_alias="l",
    )
    n0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Invariant spin axis on closed orbit.",
    )
    m: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Transverse axis.",
    )


class SpinMatchingStruct(pydantic.BaseModel):
    """
    SpinMatchingStruct corresponds to bmad `spin_matching_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 280.

    Attributes
    ----------
    axis : SpinAxisStruct
        Bmad type: type
        Fortran default: spin_axis_struct()
    eigen : SpinEigenStruct
        Bmad type: type
        Fortran default: spin_eigen_struct()
    dn_dpz : float
        Invariant spin derivative
        Bmad type: real
        Fortran default: 0
    alpha : float
        Alpha vector
        Bmad type: real
        Fortran default: 0
    beta : float
        Beta vector
        Bmad type: real
        Fortran default: 0
    orb0 : float
        Closed orbit
        Bmad type: real
        Fortran default: 0
    m_1turn : float
        1-turn matrix
        Bmad type: real
        Fortran default: 0
    m_ele : float
        Transfer matrix through element.
        Bmad type: real
        Fortran default: 0
    sq_ele : float
        Bmad type: real
        Fortran default: 0
    sq_1turn : float
        Bmad type: real
        Fortran default: 0
    valid : bool
        Bmad type: logical
        Fortran default: .false.
    """

    axis: SpinAxisStruct = pydantic.Field(
        default=None,
    )
    eigen: Sequence[SpinEigenStruct] = pydantic.Field(
        default=None,
        max_length=8,
    )
    dn_dpz: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Invariant spin derivative",
    )
    alpha: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Alpha vector",
    )
    beta: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Beta vector",
    )
    orb0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Closed orbit",
    )
    m_1turn: Sequence[float] = pydantic.Field(
        default=0,
        description="1-turn matrix",
        validation_alias=pydantic.AliasChoices("m_1turn", "M_1turn"),
        serialization_alias="M_1turn",
    )
    m_ele: Sequence[float] = pydantic.Field(
        default=0,
        description="Transfer matrix through element.",
        validation_alias=pydantic.AliasChoices("m_ele", "M_ele"),
        serialization_alias="M_ele",
    )
    sq_ele: Sequence[float] = pydantic.Field(
        default=0,
    )
    sq_1turn: Sequence[float] = pydantic.Field(
        default=0,
    )
    valid: bool = pydantic.Field(
        default=False,
    )


class SpinPolarStruct(pydantic.BaseModel):
    """
    SpinPolarStruct corresponds to bmad `spin_polar_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 296.

    Attributes
    ----------
    polarization : float
        Bmad type: real
        Fortran default: 1
    theta : float
        Spherical coords: Angle from z-axis.
        Bmad type: real
        Fortran default: 0
    phi : float
        Spherical coords: Angle in (x,y) plane.
        Bmad type: real
        Fortran default: 0
    xi : float
        Spinor phase angle (See Bmad manual).
        Bmad type: real
        Fortran default: 0
    """

    polarization: float = pydantic.Field(
        default=1,
    )
    theta: float = pydantic.Field(
        default=0,
        description="Spherical coords: Angle from z-axis.",
    )
    phi: float = pydantic.Field(
        default=0,
        description="Spherical coords: Angle in (x,y) plane.",
    )
    xi: float = pydantic.Field(
        default=0,
        description="Spinor phase angle (See Bmad manual).",
    )


class SpinOrbitMap1Struct(pydantic.BaseModel):
    """
    SpinOrbitMap1Struct corresponds to bmad `spin_orbit_map1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 305.

    Attributes
    ----------
    orb_mat : float
        Orbital matrix
        Bmad type: real
        Fortran default: 0
    vec0 : float
        Orbital 0th order map: r_out = mat6 * r_in + vec0
        Bmad type: real
        Fortran default: 0
    spin_q : float
        0th and 1st order quaternion spin map
        Bmad type: real
        Fortran default: 0
    """

    orb_mat: Sequence[float] = pydantic.Field(
        default=0,
        description="Orbital matrix",
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Orbital 0th order map: r_out = mat6 * r_in + vec0",
    )
    spin_q: Sequence[float] = pydantic.Field(
        default=0,
        description="0th and 1st order quaternion spin map",
    )


class LinearIsf1Struct(pydantic.BaseModel):
    """
    LinearIsf1Struct corresponds to bmad `linear_isf1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 313.

    Attributes
    ----------
    orb0 : float
        Closed orbit.
        Bmad type: real
        Fortran default: 0
    isf : float
        Linear ISF map at a given point.
        Bmad type: real
        Fortran default: 0
    s : float
        Offset from beginning of element.
        Bmad type: real
        Fortran default: 0
    """

    orb0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Closed orbit.",
    )
    isf: Sequence[float] = pydantic.Field(
        default=0,
        description="Linear ISF map at a given point.",
    )
    s: float = pydantic.Field(
        default=0,
        description="Offset from beginning of element.",
    )


class LinearEleIsfStruct(pydantic.BaseModel):
    """
    LinearEleIsfStruct corresponds to bmad `linear_ele_isf_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 322.

    Attributes
    ----------
    node : LinearIsf1Struct
        Array per PTC integration node.
        Bmad type: type
    """

    node: Sequence[LinearIsf1Struct] = pydantic.Field(
        default=None,
        description="Array per PTC integration node.",
    )


class Wall3dVertexStruct(pydantic.BaseModel):
    """
    Wall3dVertexStruct corresponds to bmad `wall3d_vertex_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 401.

    Attributes
    ----------
    x : float
        Coordinates of the vertex.
        Bmad type: real
        Fortran default: 0
    y : float
        Coordinates of the vertex.
        Bmad type: real
        Fortran default: 0
    radius_x : float
        Radius of arc or ellipse x-axis half width. 0 => Straight line.
        Bmad type: real
        Fortran default: 0
    radius_y : float
        Ellipse y-axis half height.
        Bmad type: real
        Fortran default: 0
    tilt : float
        Tilt of ellipse
        Bmad type: real
        Fortran default: 0
    angle : float
        Angle of (x, y) point.
        Bmad type: real
        Fortran default: 0
    x0 : float
        Center of ellipse
        Bmad type: real
        Fortran default: 0
    y0 : float
        Center of ellipse
        Bmad type: real
        Fortran default: 0
    type : int
        No longer used.
        Bmad type: integer
        Fortran default: normal$
    """

    x: float = pydantic.Field(
        default=0,
        description="Coordinates of the vertex.",
    )
    y: float = pydantic.Field(
        default=0,
        description="Coordinates of the vertex.",
    )
    radius_x: float = pydantic.Field(
        default=0,
        description="Radius of arc or ellipse x-axis half width. 0 => Straight line.",
    )
    radius_y: float = pydantic.Field(
        default=0,
        description="Ellipse y-axis half height.",
    )
    tilt: float = pydantic.Field(
        default=0,
        description="Tilt of ellipse",
    )
    angle: float = pydantic.Field(
        default=0,
        description="Angle of (x, y) point.",
    )
    x0: float = pydantic.Field(
        default=0,
        description="Center of ellipse",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Center of ellipse",
    )
    type: int = pydantic.Field(
        default=0,
        description="No longer used.",
    )


class Wall3dSectionStruct(pydantic.BaseModel):
    """
    Wall3dSectionStruct corresponds to bmad `wall3d_section_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 417.

    Attributes
    ----------
    name : str
        Identifying name
        Bmad type: character
        Fortran default: ''
    material : str
        Material.
        Bmad type: character
        Fortran default: ''
    v : Wall3dVertexStruct
        Array of vertices. Always stored relative.
        Bmad type: type
    surface : PhotonReflectSurfaceStruct
        Bmad type: type
        Fortran default: null()
    type : int
        normal$, clear$, opaque$, wall_start$, wall_end$
        Bmad type: integer
        Fortran default: normal$
    n_vertex_input : int
        Number of vertices specified by the user.
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        index of lattice element containing section
        Bmad type: integer
        Fortran default: 0
    ix_branch : int
        Index of branch lattice element is in.
        Bmad type: integer
        Fortran default: 0
    vertices_state : int
        absolute$, or shifted_to_relative$. If set to absolute$ on input,
        Bmad type: integer
        Fortran default: relative$
    patch_in_region : bool
        Patch element exists between this section and previous one?
        Bmad type: logical
        Fortran default: .false.
    thickness : float
        Material thickness.
        Bmad type: real
        Fortran default: -1
    s : float
        Longitudinal position
        Bmad type: real
        Fortran default: 0
    r0 : float
        Center of section
        Bmad type: real
        Fortran default: 0
    dx0_ds : float
        Center of wall derivative
        Bmad type: real
        Fortran default: 0
    dy0_ds : float
        Center of wall derivative
        Bmad type: real
        Fortran default: 0
    x0_coef : float
        Spline coefs for x-center
        Bmad type: real
        Fortran default: 0
    y0_coef : float
        Spline coefs for y-center
        Bmad type: real
        Fortran default: 0
    dr_ds : float
        derivative of wall radius
        Bmad type: real
        Fortran default: real_garbage$
    p1_coef : float
        Spline coefs for p0 function
        Bmad type: real
        Fortran default: 0
    p2_coef : float
        Spline coefs for p1 function
        Bmad type: real
        Fortran default: 0
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Identifying name",
    )
    material: str = pydantic.Field(
        default="",
        max_length=20,
        description="Material.",
    )
    v: Sequence[Wall3dVertexStruct] = pydantic.Field(
        default=None,
        description="Array of vertices. Always stored relative.",
    )
    surface: PhotonReflectSurfaceStruct = pydantic.Field(
        default=None,
    )
    type: int = pydantic.Field(
        default=0,
        description="normal$, clear$, opaque$, wall_start$, wall_end$",
    )
    n_vertex_input: int = pydantic.Field(
        default=0,
        description="Number of vertices specified by the user.",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="index of lattice element containing section",
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description="Index of branch lattice element is in.",
    )
    vertices_state: int = pydantic.Field(
        default=0,
        description="absolute$, or shifted_to_relative$. If set to absolute$ on input,",
    )
    patch_in_region: bool = pydantic.Field(
        default=False,
        description="Patch element exists between this section and previous one?",
    )
    thickness: float = pydantic.Field(
        default=-1,
        description="Material thickness.",
    )
    s: float = pydantic.Field(
        default=0,
        description="Longitudinal position",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description="Center of section",
    )
    dx0_ds: float = pydantic.Field(
        default=0,
        description="Center of wall derivative",
    )
    dy0_ds: float = pydantic.Field(
        default=0,
        description="Center of wall derivative",
    )
    x0_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Spline coefs for x-center",
    )
    y0_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Spline coefs for y-center",
    )
    dr_ds: float = pydantic.Field(
        default=0.0,
        description="derivative of wall radius",
    )
    p1_coef: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Spline coefs for p0 function",
    )
    p2_coef: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Spline coefs for p1 function",
    )


class Wall3dStruct(pydantic.BaseModel):
    """
    Wall3dStruct corresponds to bmad `wall3d_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 449.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    type : int
        or mask_plate$
        Bmad type: integer
        Fortran default: chamber_wall$
    ix_wall3d : int
        Index in branch%wall3d(:) array.
        Bmad type: integer
        Fortran default: 0
    n_link : int
        For memory management of ele%wall3d
        Bmad type: integer
        Fortran default: 1
    thickness : float
        For diffraction_plate elements
        Bmad type: real
        Fortran default: -1
    clear_material : str
        Bmad type: character
        Fortran default: ''
    opaque_material : str
        Bmad type: character
        Fortran default: ''
    superimpose : bool
        Can overlap another wall
        Bmad type: logical
        Fortran default: .false.
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    section : Wall3dSectionStruct
        Indexed from 1.
        Bmad type: type
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    type: int = pydantic.Field(
        default=0,
        description="or mask_plate$",
    )
    ix_wall3d: int = pydantic.Field(
        default=0,
        description="Index in branch%wall3d(:) array.",
    )
    n_link: int = pydantic.Field(
        default=1,
        description="For memory management of ele%wall3d",
    )
    thickness: float = pydantic.Field(
        default=-1,
        description="For diffraction_plate elements",
    )
    clear_material: str = pydantic.Field(
        default="",
        max_length=20,
    )
    opaque_material: str = pydantic.Field(
        default="",
        max_length=20,
    )
    superimpose: bool = pydantic.Field(
        default=False,
        description="Can overlap another wall",
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    section: Sequence[Wall3dSectionStruct] = pydantic.Field(
        default=None,
        description="Indexed from 1.",
    )


class TaylorTermStruct(pydantic.BaseModel):
    """
    TaylorTermStruct corresponds to bmad `taylor_term_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 464.

    Attributes
    ----------
    coef : float
        Bmad type: real
        Fortran default: 0
    expn : int
        Bmad type: integer
        Fortran default: 0
    """

    coef: float = pydantic.Field(
        default=0,
    )
    expn: Sequence[int] = pydantic.Field(
        default=0,
        max_length=6,
    )


class ComplexTaylorTermStruct(pydantic.BaseModel):
    """
    ComplexTaylorTermStruct corresponds to bmad `complex_taylor_term_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 469.

    Attributes
    ----------
    coef : Complex
        Bmad type: complex
    expn : int
        Bmad type: integer
    """

    coef: Complex = pydantic.Field(
        default=0.0,
    )
    expn: Sequence[int] = pydantic.Field(
        default=0,
        max_length=6,
    )


class TaylorStruct(pydantic.BaseModel):
    """
    TaylorStruct corresponds to bmad `taylor_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 478.

    Attributes
    ----------
    ref : float
        Bmad type: real
        Fortran default: 0
    term : TaylorTermStruct
        Bmad type: type
        Fortran default: null()
    """

    ref: float = pydantic.Field(
        default=0,
    )
    term: Sequence[TaylorTermStruct] = pydantic.Field(
        default=None,
    )


class ComplexTaylorStruct(pydantic.BaseModel):
    """
    ComplexTaylorStruct corresponds to bmad `complex_taylor_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 487.

    Attributes
    ----------
    ref : Complex
        Bmad type: complex
        Fortran default: 0
    term : ComplexTaylorTermStruct
        Bmad type: type
        Fortran default: null()
    """

    ref: Complex = pydantic.Field(
        default=0,
    )
    term: Sequence[ComplexTaylorTermStruct] = pydantic.Field(
        default=None,
    )


class CoordStruct(pydantic.BaseModel):
    """
    CoordStruct corresponds to bmad `coord_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 529.

    Attributes
    ----------
    vec : float
        (x, px, y, py, z, pz). Generally phase space for charged particles. See Bmad
        manual.
        Bmad type: real
        Fortran default: 0
    s : float
        Longitudinal position
        Bmad type: real
        Fortran default: 0
    t : float
        Absolute time (not relative to reference). If bmad_private%rf_clock_frequency
        is
        Bmad type: real
        Fortran default: 0
    spin : float
        Spin.
        Bmad type: real
        Fortran default: 0
    field : float
        Photon E-field intensity (x,y).
        Bmad type: real
        Fortran default: 0
    phase : float
        Photon E-field phase (x,y). phase(1) is also used with
        Bmad type: real
        Fortran default: 0
    charge : float
        Macroparticle weight (which is different from particle species charge).
        Bmad type: real
        Fortran default: 0
    dt_ref : float
        Used in:
        Bmad type: real
        Fortran default: 0
    r : float
        For general use. Not used by Bmad.
        Bmad type: real
        Fortran default: 0
    p0c : float
        For non-photons: Reference momentum.
        Bmad type: real
        Fortran default: 0
    e_potential : float
        Potential energy.
        Bmad type: real
        Fortran default: 0
    beta : float
        Velocity / c_light.
        Bmad type: real
        Fortran default: -1
    ix_ele : int
        Index of the lattice element the particle is in.
        Bmad type: integer
        Fortran default: -1
    ix_branch : int
        Index of the lattice branch the particle is in.
        Bmad type: integer
        Fortran default: -1
    ix_turn : int
        Turn index for multiturn tracking.
        Bmad type: integer
        Fortran default: 0
    ix_user : int
        For general use, not used by Bmad.
        Bmad type: integer
        Fortran default: -1
    state : int
        alive$, lost$, lost_neg_x_aperture$, lost_pz$, etc.
        Bmad type: integer
        Fortran default: not_set$
    direction : int
        +1 or -1. Sign of longitudinal direction of motion (ds/dt).
        Bmad type: integer
        Fortran default: 1
    time_dir : int
        +1 or -1. Time direction. -1 => Traveling backwards in time.
        Bmad type: integer
        Fortran default: 1
    species : int
        positron$, proton$, etc.
        Bmad type: integer
        Fortran default: not_set$
    location : int
        upstream_end$, inside$, or downstream_end$
        Bmad type: integer
        Fortran default: upstream_end$
    """

    vec: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description=(
            "(x, px, y, py, z, pz). Generally phase space for charged particles. See "
            "Bmad manual."
        ),
    )
    s: float = pydantic.Field(
        default=0,
        description="Longitudinal position",
    )
    t: float = pydantic.Field(
        default=0,
        description="Absolute time (not relative to reference). If bmad_private%rf_clock_frequency is",
    )
    spin: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Spin.",
    )
    field: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description="Photon E-field intensity (x,y).",
    )
    phase: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description="Photon E-field phase (x,y). phase(1) is also used with",
    )
    charge: float = pydantic.Field(
        default=0,
        description="Macroparticle weight (which is different from particle species charge).",
    )
    dt_ref: float = pydantic.Field(
        default=0,
        description="Used in:",
    )
    r: float = pydantic.Field(
        default=0,
        description="For general use. Not used by Bmad.",
    )
    p0c: float = pydantic.Field(
        default=0,
        description="For non-photons: Reference momentum.",
    )
    e_potential: float = pydantic.Field(
        default=0,
        description="Potential energy.",
        validation_alias=pydantic.AliasChoices("e_potential", "E_potential"),
        serialization_alias="E_potential",
    )
    beta: float = pydantic.Field(
        default=-1,
        description="Velocity / c_light.",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description="Index of the lattice element the particle is in.",
    )
    ix_branch: int = pydantic.Field(
        default=-1,
        description="Index of the lattice branch the particle is in.",
    )
    ix_turn: int = pydantic.Field(
        default=0,
        description="Turn index for multiturn tracking.",
    )
    ix_user: int = pydantic.Field(
        default=-1,
        description="For general use, not used by Bmad.",
    )
    state: int = pydantic.Field(
        default=0,
        description="alive$, lost$, lost_neg_x_aperture$, lost_pz$, etc.",
    )
    direction: int = pydantic.Field(
        default=1,
        description="+1 or -1. Sign of longitudinal direction of motion (ds/dt).",
    )
    time_dir: int = pydantic.Field(
        default=1,
        description="+1 or -1. Time direction. -1 => Traveling backwards in time.",
    )
    species: int = pydantic.Field(
        default=0,
        description="positron$, proton$, etc.",
    )
    location: int = pydantic.Field(
        default=0,
        description="upstream_end$, inside$, or downstream_end$",
    )


class CoordArrayStruct(pydantic.BaseModel):
    """
    CoordArrayStruct corresponds to bmad `coord_array_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 561.

    Attributes
    ----------
    orbit : CoordStruct
        Bmad type: type
    """

    orbit: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )


class BpmPhaseCouplingStruct(pydantic.BaseModel):
    """
    BpmPhaseCouplingStruct corresponds to bmad `bpm_phase_coupling_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 569.

    Attributes
    ----------
    k_22a : float
        In-phase y/x for a-mode oscillations.
        Bmad type: real
    k_12a : float
        Out-of-phase y/x for a-mode oscillations.
        Bmad type: real
    k_11b : float
        In-phase x/y for b-mode oscillations.
        Bmad type: real
    k_12b : float
        Out-of-phase x/y for b-mode oscillations.
        Bmad type: real
    cbar22_a : float
        Cbar22 as calculated from K_22a.
        Bmad type: real
    cbar12_a : float
        Cbar12 as calculated from K_12a.
        Bmad type: real
    cbar11_b : float
        Cbar11 as calculated from K_11b.
        Bmad type: real
    cbar12_b : float
        Cbar12 as calculated from K_12b.
        Bmad type: real
    phi_a : float
        a-mode betatron phase.
        Bmad type: real
    phi_b : float
        b-mode betatron phase.
        Bmad type: real
    """

    k_22a: float = pydantic.Field(
        default=0.0,
        description="In-phase y/x for a-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_22a", "K_22a"),
        serialization_alias="K_22a",
    )
    k_12a: float = pydantic.Field(
        default=0.0,
        description="Out-of-phase y/x for a-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_12a", "K_12a"),
        serialization_alias="K_12a",
    )
    k_11b: float = pydantic.Field(
        default=0.0,
        description="In-phase x/y for b-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_11b", "K_11b"),
        serialization_alias="K_11b",
    )
    k_12b: float = pydantic.Field(
        default=0.0,
        description="Out-of-phase x/y for b-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_12b", "K_12b"),
        serialization_alias="K_12b",
    )
    cbar22_a: float = pydantic.Field(
        default=0.0,
        description="Cbar22 as calculated from K_22a.",
        validation_alias=pydantic.AliasChoices("cbar22_a", "Cbar22_a"),
        serialization_alias="Cbar22_a",
    )
    cbar12_a: float = pydantic.Field(
        default=0.0,
        description="Cbar12 as calculated from K_12a.",
        validation_alias=pydantic.AliasChoices("cbar12_a", "Cbar12_a"),
        serialization_alias="Cbar12_a",
    )
    cbar11_b: float = pydantic.Field(
        default=0.0,
        description="Cbar11 as calculated from K_11b.",
        validation_alias=pydantic.AliasChoices("cbar11_b", "Cbar11_b"),
        serialization_alias="Cbar11_b",
    )
    cbar12_b: float = pydantic.Field(
        default=0.0,
        description="Cbar12 as calculated from K_12b.",
        validation_alias=pydantic.AliasChoices("cbar12_b", "Cbar12_b"),
        serialization_alias="Cbar12_b",
    )
    phi_a: float = pydantic.Field(
        default=0.0,
        description="a-mode betatron phase.",
    )
    phi_b: float = pydantic.Field(
        default=0.0,
        description="b-mode betatron phase.",
    )


class WakeSrZLongStruct(pydantic.BaseModel):
    """
    WakeSrZLongStruct corresponds to bmad `wake_sr_z_long_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 594.

    Attributes
    ----------
    w : float
        Input single particle Wake. Indexed from 1.
        Bmad type: real
    fw : Complex
        Fourier transform of w.
        Bmad type: complex
    fbunch : Complex
        Scratch space.
        Bmad type: complex
    w_out : Complex
        Scratch space.
        Bmad type: complex
    dz : float
        Distance between points. If zero there is no wake.
        Bmad type: real
        Fortran default: 0
    z0 : float
        Wake extent is [-z0, z0].
        Bmad type: real
        Fortran default: 0
    smoothing_sigma : float
        0 => No smoothing.
        Bmad type: real
        Fortran default: 0
    position_dependence : int
        Transverse: leading$, trailing$, none$
        Bmad type: integer
        Fortran default: none$
    time_based : bool
        Was input time based?
        Bmad type: logical
        Fortran default: .false.
    """

    w: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Input single particle Wake. Indexed from 1.",
    )
    fw: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Fourier transform of w.",
    )
    fbunch: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Scratch space.",
    )
    w_out: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Scratch space.",
    )
    dz: float = pydantic.Field(
        default=0,
        description="Distance between points. If zero there is no wake.",
    )
    z0: float = pydantic.Field(
        default=0,
        description="Wake extent is [-z0, z0].",
    )
    smoothing_sigma: float = pydantic.Field(
        default=0,
        description="0 => No smoothing.",
    )
    position_dependence: int = pydantic.Field(
        default=0,
        description="Transverse: leading$, trailing$, none$",
    )
    time_based: bool = pydantic.Field(
        default=False,
        description="Was input time based?",
    )


class WakeSrModeStruct(pydantic.BaseModel):
    """
    WakeSrModeStruct corresponds to bmad `wake_sr_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 606.

    Attributes
    ----------
    amp : float
        Amplitude
        Bmad type: real
        Fortran default: 0
    damp : float
        Dampling factor.
        Bmad type: real
        Fortran default: 0
    k : float
        k factor
        Bmad type: real
        Fortran default: 0
    phi : float
        Phase in radians/2pi
        Bmad type: real
        Fortran default: 0
    b_sin : float
        non-skew (x) sin-like component of the wake
        Bmad type: real
        Fortran default: 0
    b_cos : float
        non-skew (x) cos-like component of the wake
        Bmad type: real
        Fortran default: 0
    a_sin : float
        skew (y) sin-like component of the wake
        Bmad type: real
        Fortran default: 0
    a_cos : float
        skew (y) cos-like component of the wake
        Bmad type: real
        Fortran default: 0
    polarization : int
        Transverse: none$, x_axis$, y_axis$. Not used for longitudinal.
        Bmad type: integer
        Fortran default: none$
    position_dependence : int
        Transverse: leading$, trailing$, none$
        Bmad type: integer
        Fortran default: not_set$
    """

    amp: float = pydantic.Field(
        default=0,
        description="Amplitude",
    )
    damp: float = pydantic.Field(
        default=0,
        description="Dampling factor.",
    )
    k: float = pydantic.Field(
        default=0,
        description="k factor",
    )
    phi: float = pydantic.Field(
        default=0,
        description="Phase in radians/2pi",
    )
    b_sin: float = pydantic.Field(
        default=0,
        description="non-skew (x) sin-like component of the wake",
    )
    b_cos: float = pydantic.Field(
        default=0,
        description="non-skew (x) cos-like component of the wake",
    )
    a_sin: float = pydantic.Field(
        default=0,
        description="skew (y) sin-like component of the wake",
    )
    a_cos: float = pydantic.Field(
        default=0,
        description="skew (y) cos-like component of the wake",
    )
    polarization: int = pydantic.Field(
        default=0,
        description="Transverse: none$, x_axis$, y_axis$. Not used for longitudinal.",
    )
    position_dependence: int = pydantic.Field(
        default=0,
        description="Transverse: leading$, trailing$, none$",
    )


class WakeSrStruct(pydantic.BaseModel):
    """
    WakeSrStruct corresponds to bmad `wake_sr_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 620.

    Attributes
    ----------
    file : str
        Bmad type: character
        Fortran default: ''
    z_long : WakeSrZLongStruct
        Bmad type: type
    long : WakeSrModeStruct
        Bmad type: type
    trans : WakeSrModeStruct
        Bmad type: type
    z_ref_long : float
        z reference value for computing the wake amplitude.
        Bmad type: real
        Fortran default: 0
    z_ref_trans : float
        This is used to prevent value overflow with long bunches.
        Bmad type: real
        Fortran default: 0
    z_max : float
        Max allowable z value. 0-> ignore
        Bmad type: real
        Fortran default: 0
    amp_scale : float
        Wake amplitude scale factor.
        Bmad type: real
        Fortran default: 1
    z_scale : float
        z-distance scale factor.
        Bmad type: real
        Fortran default: 1
    scale_with_length : bool
        Scale wake with element length?
        Bmad type: logical
        Fortran default: .true.
    """

    file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    z_long: WakeSrZLongStruct = pydantic.Field(
        default=None,
    )
    long: Sequence[WakeSrModeStruct] = pydantic.Field(
        default=None,
    )
    trans: Sequence[WakeSrModeStruct] = pydantic.Field(
        default=None,
    )
    z_ref_long: float = pydantic.Field(
        default=0,
        description="z reference value for computing the wake amplitude.",
    )
    z_ref_trans: float = pydantic.Field(
        default=0,
        description="This is used to prevent value overflow with long bunches.",
    )
    z_max: float = pydantic.Field(
        default=0,
        description="Max allowable z value. 0-> ignore",
    )
    amp_scale: float = pydantic.Field(
        default=1,
        description="Wake amplitude scale factor.",
    )
    z_scale: float = pydantic.Field(
        default=1,
        description="z-distance scale factor.",
    )
    scale_with_length: bool = pydantic.Field(
        default=True,
        description="Scale wake with element length?",
    )


class WakeLrModeStruct(pydantic.BaseModel):
    """
    WakeLrModeStruct corresponds to bmad `wake_lr_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 636.

    Attributes
    ----------
    freq : float
        Actual Frequency in Hz.
        Bmad type: real
        Fortran default: 0
    freq_in : float
        Input frequency in Hz.
        Bmad type: real
        Fortran default: 0
    r_over_q : float
        Strength in V/C/m^(2*m_mode).
        Bmad type: real
        Fortran default: 0
    q : float
        Used for backwards compatability.
        Bmad type: real
        Fortran default: real_garbage$
    damp : float
        Damping factor = omega / 2 * Q = pi * freq / Q
        Bmad type: real
        Fortran default: 0
    phi : float
        Phase in radians/2pi.
        Bmad type: real
        Fortran default: 0
    angle : float
        polarization angle (radians/2pi).
        Bmad type: real
        Fortran default: 0
    b_sin : float
        non-skew sin-like component of the wake.
        Bmad type: real
        Fortran default: 0
    b_cos : float
        non-skew cos-like component of the wake.
        Bmad type: real
        Fortran default: 0
    a_sin : float
        skew sin-like component of the wake.
        Bmad type: real
        Fortran default: 0
    a_cos : float
        skew cos-like component of the wake.
        Bmad type: real
        Fortran default: 0
    m : int
        Mode order (1 = dipole, 2 = quad, etc.)
        Bmad type: integer
        Fortran default: 0
    polarized : bool
        Polaraized mode?
        Bmad type: logical
        Fortran default: .false.
    """

    freq: float = pydantic.Field(
        default=0,
        description="Actual Frequency in Hz.",
    )
    freq_in: float = pydantic.Field(
        default=0,
        description="Input frequency in Hz.",
    )
    r_over_q: float = pydantic.Field(
        default=0,
        description="Strength in V/C/m^(2*m_mode).",
        validation_alias=pydantic.AliasChoices("r_over_q", "R_over_Q"),
        serialization_alias="R_over_Q",
    )
    q: float = pydantic.Field(
        default=0.0,
        description="Used for backwards compatability.",
        validation_alias=pydantic.AliasChoices("q", "Q"),
        serialization_alias="Q",
    )
    damp: float = pydantic.Field(
        default=0,
        description="Damping factor = omega / 2 * Q = pi * freq / Q",
    )
    phi: float = pydantic.Field(
        default=0,
        description="Phase in radians/2pi.",
    )
    angle: float = pydantic.Field(
        default=0,
        description="polarization angle (radians/2pi).",
    )
    b_sin: float = pydantic.Field(
        default=0,
        description="non-skew sin-like component of the wake.",
    )
    b_cos: float = pydantic.Field(
        default=0,
        description="non-skew cos-like component of the wake.",
    )
    a_sin: float = pydantic.Field(
        default=0,
        description="skew sin-like component of the wake.",
    )
    a_cos: float = pydantic.Field(
        default=0,
        description="skew cos-like component of the wake.",
    )
    m: int = pydantic.Field(
        default=0,
        description="Mode order (1 = dipole, 2 = quad, etc.)",
    )
    polarized: bool = pydantic.Field(
        default=False,
        description="Polaraized mode?",
    )


class WakeLrStruct(pydantic.BaseModel):
    """
    WakeLrStruct corresponds to bmad `wake_lr_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 652.

    Attributes
    ----------
    file : str
        Bmad type: character
        Fortran default: ''
    mode : WakeLrModeStruct
        Bmad type: type
    t_ref : float
        time reference value for computing the wake amplitude.
        Bmad type: real
        Fortran default: 0
    freq_spread : float
        Random frequency spread of long range modes.
        Bmad type: real
        Fortran default: 0
    amp_scale : float
        Wake amplitude scale factor.
        Bmad type: real
        Fortran default: 1
    time_scale : float
        time scale factor.
        Bmad type: real
        Fortran default: 1
    self_wake_on : bool
        Long range self-wake used in tracking?
        Bmad type: logical
        Fortran default: .true.
    """

    file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    mode: Sequence[WakeLrModeStruct] = pydantic.Field(
        default=None,
    )
    t_ref: float = pydantic.Field(
        default=0,
        description="time reference value for computing the wake amplitude.",
    )
    freq_spread: float = pydantic.Field(
        default=0,
        description="Random frequency spread of long range modes.",
    )
    amp_scale: float = pydantic.Field(
        default=1,
        description="Wake amplitude scale factor.",
    )
    time_scale: float = pydantic.Field(
        default=1,
        description="time scale factor.",
    )
    self_wake_on: bool = pydantic.Field(
        default=True,
        description="Long range self-wake used in tracking?",
    )


class WakeStruct(pydantic.BaseModel):
    """
    WakeStruct corresponds to bmad `wake_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 665.

    Attributes
    ----------
    sr : WakeSrStruct
        Short-range wake
        Bmad type: type
        Fortran default: wake_sr_struct('', wake_sr_z_long_struct(), null(), null(), 0.0_rp, 0.0_rp, 0.0_rp, 1.0_rp, 1.0_rp, .true.)
    lr : WakeLrStruct
        Long-range wake
        Bmad type: type
        Fortran default: wake_lr_struct('', null(), 0.0_rp, 0.0_rp, 1.0_rp, 1.0_rp, .true.)
    """

    sr: WakeSrStruct = pydantic.Field(
        default=None,
        description="Short-range wake",
    )
    lr: WakeLrStruct = pydantic.Field(
        default=None,
        description="Long-range wake",
    )


class AcKickerTimeStruct(pydantic.BaseModel):
    """
    AcKickerTimeStruct corresponds to bmad `ac_kicker_time_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 672.

    Attributes
    ----------
    amp : float
        Bmad type: real
        Fortran default: 0
    time : float
        Bmad type: real
        Fortran default: 0
    spline : SplineStruct
        Bmad type: type
        Fortran default: spline_struct()
    """

    amp: float = pydantic.Field(
        default=0,
    )
    time: float = pydantic.Field(
        default=0,
    )
    spline: SplineStruct = pydantic.Field(
        default=None,
    )


class AcKickerFreqStruct(pydantic.BaseModel):
    """
    AcKickerFreqStruct corresponds to bmad `ac_kicker_freq_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 678.

    Attributes
    ----------
    f : float
        Bmad type: real
        Fortran default: 0
    amp : float
        Bmad type: real
        Fortran default: 0
    phi : float
        Bmad type: real
        Fortran default: 0
    rf_clock_harmonic : int
        When RF clock is used.
        Bmad type: integer
        Fortran default: 0
    """

    f: float = pydantic.Field(
        default=0,
    )
    amp: float = pydantic.Field(
        default=0,
    )
    phi: float = pydantic.Field(
        default=0,
    )
    rf_clock_harmonic: int = pydantic.Field(
        default=0,
        description="When RF clock is used.",
    )


class AcKickerStruct(pydantic.BaseModel):
    """
    AcKickerStruct corresponds to bmad `ac_kicker_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 685.

    Attributes
    ----------
    amp_vs_time : AcKickerTimeStruct
        Bmad type: type
    frequency : AcKickerFreqStruct
        Bmad type: type
    """

    amp_vs_time: Sequence[AcKickerTimeStruct] = pydantic.Field(
        default=None,
    )
    frequency: Sequence[AcKickerFreqStruct] = pydantic.Field(
        default=None,
    )


class CartesianMapTerm1Struct(pydantic.BaseModel):
    """
    CartesianMapTerm1Struct corresponds to bmad `cartesian_map_term1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 699.

    Attributes
    ----------
    coef : float
        Bmad type: real
        Fortran default: 0
    kx : float
        Bmad type: real
        Fortran default: 0
    ky : float
        Bmad type: real
        Fortran default: 0
    kz : float
        Bmad type: real
        Fortran default: 0
    x0 : float
        Bmad type: real
        Fortran default: 0
    y0 : float
        Bmad type: real
        Fortran default: 0
    phi_z : float
        Bmad type: real
        Fortran default: 0
    family : int
        family_x$, etc.
        Bmad type: integer
        Fortran default: 0
    form : int
        hyper_y$, etc.
        Bmad type: integer
        Fortran default: 0
    """

    coef: float = pydantic.Field(
        default=0,
    )
    kx: float = pydantic.Field(
        default=0,
    )
    ky: float = pydantic.Field(
        default=0,
    )
    kz: float = pydantic.Field(
        default=0,
    )
    x0: float = pydantic.Field(
        default=0,
    )
    y0: float = pydantic.Field(
        default=0,
    )
    phi_z: float = pydantic.Field(
        default=0,
    )
    family: int = pydantic.Field(
        default=0,
        description="family_x$, etc.",
    )
    form: int = pydantic.Field(
        default=0,
        description="hyper_y$, etc.",
    )


class CartesianMapTermStruct(pydantic.BaseModel):
    """
    CartesianMapTermStruct corresponds to bmad `cartesian_map_term_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 707.

    Attributes
    ----------
    file : str
        Input file name. Used also as ID for instances.
        Bmad type: character
        Fortran default: ''
    n_link : int
        For memory management of %term
        Bmad type: integer
        Fortran default: 1
    term : CartesianMapTerm1Struct
        Bmad type: type
    """

    file: str = pydantic.Field(
        default="",
        max_length=400,
        description="Input file name. Used also as ID for instances.",
    )
    n_link: int = pydantic.Field(
        default=1,
        description="For memory management of %term",
    )
    term: Sequence[CartesianMapTerm1Struct] = pydantic.Field(
        default=None,
    )


class CartesianMapStruct(pydantic.BaseModel):
    """
    CartesianMapStruct corresponds to bmad `cartesian_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 713.

    Attributes
    ----------
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    r0 : float
        Field origin offset.
        Bmad type: real
        Fortran default: 0
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    field_type : int
        or electric$
        Bmad type: integer
        Fortran default: magnetic$
    ptr : CartesianMapTermStruct
        Bmad type: type
        Fortran default: null()
    """

    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Field origin offset.",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    field_type: int = pydantic.Field(
        default=0,
        description="or electric$",
    )
    ptr: CartesianMapTermStruct = pydantic.Field(
        default=None,
    )


class CylindricalMapTerm1Struct(pydantic.BaseModel):
    """
    CylindricalMapTerm1Struct corresponds to bmad `cylindrical_map_term1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 724.

    Attributes
    ----------
    e_coef : Complex
        Bmad type: complex
        Fortran default: 0
    b_coef : Complex
        Bmad type: complex
        Fortran default: 0
    """

    e_coef: Complex = pydantic.Field(
        default=0,
    )
    b_coef: Complex = pydantic.Field(
        default=0,
    )


class CylindricalMapTermStruct(pydantic.BaseModel):
    """
    CylindricalMapTermStruct corresponds to bmad `cylindrical_map_term_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 729.

    Attributes
    ----------
    file : str
        Input file name. Used also as ID for instances.
        Bmad type: character
        Fortran default: ''
    n_link : int
        For memory management of this structure
        Bmad type: integer
        Fortran default: 1
    term : CylindricalMapTerm1Struct
        Bmad type: type
    """

    file: str = pydantic.Field(
        default="",
        max_length=400,
        description="Input file name. Used also as ID for instances.",
    )
    n_link: int = pydantic.Field(
        default=1,
        description="For memory management of this structure",
    )
    term: Sequence[CylindricalMapTerm1Struct] = pydantic.Field(
        default=None,
    )


class CylindricalMapStruct(pydantic.BaseModel):
    """
    CylindricalMapStruct corresponds to bmad `cylindrical_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 735.

    Attributes
    ----------
    m : int
        Azimuthal Mode: varies as cos(m*phi - theta0_azimuth)
        Bmad type: integer
        Fortran default: 0
    harmonic : int
        Harmonic of fundamental
        Bmad type: integer
        Fortran default: 0
    phi0_fieldmap : float
        Mode oscillates as: twopi * (f * t + phi0_fieldmap)
        Bmad type: real
        Fortran default: 0
    theta0_azimuth : float
        Azimuthal ((x, y) plane) orientation of mode.
        Bmad type: real
        Fortran default: 0
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    dz : float
        Distance between sampled field points.
        Bmad type: real
        Fortran default: 0
    r0 : float
        Field origin offset.
        Bmad type: real
        Fortran default: 0
    ptr : CylindricalMapTermStruct
        Bmad type: type
        Fortran default: null()
    """

    m: int = pydantic.Field(
        default=0,
        description="Azimuthal Mode: varies as cos(m*phi - theta0_azimuth)",
    )
    harmonic: int = pydantic.Field(
        default=0,
        description="Harmonic of fundamental",
    )
    phi0_fieldmap: float = pydantic.Field(
        default=0,
        description="Mode oscillates as: twopi * (f * t + phi0_fieldmap)",
    )
    theta0_azimuth: float = pydantic.Field(
        default=0,
        description="Azimuthal ((x, y) plane) orientation of mode.",
    )
    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    dz: float = pydantic.Field(
        default=0,
        description="Distance between sampled field points.",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Field origin offset.",
    )
    ptr: CylindricalMapTermStruct = pydantic.Field(
        default=None,
    )


class GenGrad1Struct(pydantic.BaseModel):
    """
    GenGrad1Struct corresponds to bmad `gen_grad1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 750.

    Attributes
    ----------
    m : int
        Azimuthal index
        Bmad type: integer
        Fortran default: 0
    sincos : int
        sin$ or cos$
        Bmad type: integer
        Fortran default: 0
    n_deriv_max : int
        Max GG derivative
        Bmad type: integer
        Fortran default: -1
    deriv : float
        Range: (iz0:iz1, 0:2*n_deriv_max+1)
        Bmad type: real
    """

    m: int = pydantic.Field(
        default=0,
        description="Azimuthal index",
    )
    sincos: int = pydantic.Field(
        default=0,
        description="sin$ or cos$",
    )
    n_deriv_max: int = pydantic.Field(
        default=-1,
        description="Max GG derivative",
    )
    deriv: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Range: (iz0:iz1, 0:2*n_deriv_max+1)",
    )


class GenGradMapStruct(pydantic.BaseModel):
    """
    GenGradMapStruct corresponds to bmad `gen_grad_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 758.

    Attributes
    ----------
    file : str
        Input file name. Used also as ID for instances.
        Bmad type: character
        Fortran default: ''
    gg : GenGrad1Struct
        Bmad type: type
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    field_type : int
        or electric$
        Bmad type: integer
        Fortran default: magnetic$
    iz0 : int
        gg%deriv(iz0:iz1, :) lower bound.
        Bmad type: integer
        Fortran default: int_garbage$
    iz1 : int
        gg%deriv(iz0:iz1, :) upper bound.
        Bmad type: integer
        Fortran default: int_garbage$
    dz : float
        Point spacing.
        Bmad type: real
        Fortran default: 0
    r0 : float
        field origin relative to ele_anchor_pt.
        Bmad type: real
        Fortran default: 0
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    curved_ref_frame : bool
        Bmad type: logical
        Fortran default: .false.
    """

    file: str = pydantic.Field(
        default="",
        max_length=400,
        description="Input file name. Used also as ID for instances.",
    )
    gg: Sequence[GenGrad1Struct] = pydantic.Field(
        default=None,
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    field_type: int = pydantic.Field(
        default=0,
        description="or electric$",
    )
    iz0: int = pydantic.Field(
        default=0,
        description="gg%deriv(iz0:iz1, :) lower bound.",
    )
    iz1: int = pydantic.Field(
        default=0,
        description="gg%deriv(iz0:iz1, :) upper bound.",
    )
    dz: float = pydantic.Field(
        default=0,
        description="Point spacing.",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="field origin relative to ele_anchor_pt.",
    )
    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    curved_ref_frame: bool = pydantic.Field(
        default=False,
    )


class GridFieldPt1Struct(pydantic.BaseModel):
    """
    GridFieldPt1Struct corresponds to bmad `grid_field_pt1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 774.

    Attributes
    ----------
    e : Complex
        Bmad type: complex
        Fortran default: 0
    b : Complex
        Bmad type: complex
        Fortran default: 0
    """

    e: Sequence[Complex] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    b: Sequence[Complex] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )


class GridFieldPtStruct(pydantic.BaseModel):
    """
    GridFieldPtStruct corresponds to bmad `grid_field_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 779.

    Attributes
    ----------
    file : str
        Input file name. Used also as ID for instances.
        Bmad type: character
        Fortran default: ''
    n_link : int
        For memory management of this structure
        Bmad type: integer
        Fortran default: 1
    pt : GridFieldPt1Struct
        Bmad type: type
    """

    file: str = pydantic.Field(
        default="",
        max_length=400,
        description="Input file name. Used also as ID for instances.",
    )
    n_link: int = pydantic.Field(
        default=1,
        description="For memory management of this structure",
    )
    pt: Sequence[GridFieldPt1Struct] = pydantic.Field(
        default=None,
    )


class GridFieldStruct(pydantic.BaseModel):
    """
    GridFieldStruct corresponds to bmad `grid_field_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 785.

    Attributes
    ----------
    geometry : int
        Type of grid: xyz$, or rotationally_symmetric_rz$
        Bmad type: integer
        Fortran default: 0
    harmonic : int
        Harmonic of fundamental for AC fields.
        Bmad type: integer
        Fortran default: 0
    phi0_fieldmap : float
        Mode oscillates as: twopi * (f * t + phi0_fieldmap)
        Bmad type: real
        Fortran default: 0
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    field_type : int
        or magnetic$ or electric$
        Bmad type: integer
        Fortran default: mixed$
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    interpolation_order : int
        Possibilities are 1 or 3.
        Bmad type: integer
        Fortran default: 1
    dr : float
        Grid spacing.
        Bmad type: real
        Fortran default: 0
    r0 : float
        Field origin relative to ele_anchor_pt.
        Bmad type: real
        Fortran default: 0
    curved_ref_frame : bool
        Bmad type: logical
        Fortran default: .false.
    ptr : GridFieldPtStruct
        Bmad type: type
        Fortran default: null()
    bi_coef : BicubicCmplxCoefStruct
        Save computed coefs for faster tracking
        Bmad type: type
    tri_coef : TricubicCmplxCoefStruct
        Save computed coefs for faster tracking
        Bmad type: type
    """

    geometry: int = pydantic.Field(
        default=0,
        description="Type of grid: xyz$, or rotationally_symmetric_rz$",
    )
    harmonic: int = pydantic.Field(
        default=0,
        description="Harmonic of fundamental for AC fields.",
    )
    phi0_fieldmap: float = pydantic.Field(
        default=0,
        description="Mode oscillates as: twopi * (f * t + phi0_fieldmap)",
    )
    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    field_type: int = pydantic.Field(
        default=0,
        description="or magnetic$ or electric$",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    interpolation_order: int = pydantic.Field(
        default=1,
        description="Possibilities are 1 or 3.",
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Grid spacing.",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Field origin relative to ele_anchor_pt.",
    )
    curved_ref_frame: bool = pydantic.Field(
        default=False,
    )
    ptr: GridFieldPtStruct = pydantic.Field(
        default=None,
    )
    bi_coef: Sequence[BicubicCmplxCoefStruct] = pydantic.Field(
        default=None,
        description="Save computed coefs for faster tracking",
    )
    tri_coef: Sequence[TricubicCmplxCoefStruct] = pydantic.Field(
        default=None,
        description="Save computed coefs for faster tracking",
    )


class EmTaylorTermStruct(pydantic.BaseModel):
    """
    EmTaylorTermStruct corresponds to bmad `em_taylor_term_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 806.

    Attributes
    ----------
    coef : float
        Bmad type: real
        Fortran default: 0
    expn : int
        Bmad type: integer
        Fortran default: 0
    """

    coef: float = pydantic.Field(
        default=0,
    )
    expn: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
    )


class EmTaylorStruct(pydantic.BaseModel):
    """
    EmTaylorStruct corresponds to bmad `em_taylor_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 811.

    Attributes
    ----------
    ref : float
        Bmad type: real
        Fortran default: 0
    term : EmTaylorTermStruct
        Bmad type: type
    """

    ref: float = pydantic.Field(
        default=0,
    )
    term: Sequence[EmTaylorTermStruct] = pydantic.Field(
        default=None,
    )


class FloorPositionStruct(pydantic.BaseModel):
    """
    FloorPositionStruct corresponds to bmad `floor_position_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 827.

    Attributes
    ----------
    r : float
        (x, y, z) offset from origin
        Bmad type: real
        Fortran default: 0
    w : float
        W matrix. Columns are unit vectors of the frame axes.
        Bmad type: real
        Fortran default: mat3_unit$
    theta : float
        angular orientation consistent with W matrix
        Bmad type: real
        Fortran default: 0
    phi : float
        angular orientation consistent with W matrix
        Bmad type: real
        Fortran default: 0
    psi : float
        angular orientation consistent with W matrix
        Bmad type: real
        Fortran default: 0
    """

    r: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="(x, y, z) offset from origin",
    )
    w: Sequence[float] = pydantic.Field(
        default=0.0,
        description="W matrix. Columns are unit vectors of the frame axes.",
    )
    theta: float = pydantic.Field(
        default=0,
        description="angular orientation consistent with W matrix",
    )
    phi: float = pydantic.Field(
        default=0,
        description="angular orientation consistent with W matrix",
    )
    psi: float = pydantic.Field(
        default=0,
        description="angular orientation consistent with W matrix",
    )


class HighEnergySpaceChargeStruct(pydantic.BaseModel):
    """
    HighEnergySpaceChargeStruct corresponds to bmad `high_energy_space_charge_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 835.

    Attributes
    ----------
    closed_orb : CoordStruct
        beam orbit
        Bmad type: type
    kick_const : float
        Bmad type: real
    sig_x : float
        Bmad type: real
    sig_y : float
        Bmad type: real
    phi : float
        Rotation angle to go from lab frame to rotated frame.
        Bmad type: real
    sin_phi : float
        Bmad type: real
    cos_phi : float
        Bmad type: real
    sig_z : float
        Bmad type: real
    """

    closed_orb: CoordStruct = pydantic.Field(
        default=None,
        description="beam orbit",
    )
    kick_const: float = pydantic.Field(
        default=0.0,
    )
    sig_x: float = pydantic.Field(
        default=0.0,
    )
    sig_y: float = pydantic.Field(
        default=0.0,
    )
    phi: float = pydantic.Field(
        default=0.0,
        description="Rotation angle to go from lab frame to rotated frame.",
    )
    sin_phi: float = pydantic.Field(
        default=0.0,
    )
    cos_phi: float = pydantic.Field(
        default=0.0,
    )
    sig_z: float = pydantic.Field(
        default=0.0,
    )


class XyDispStruct(pydantic.BaseModel):
    """
    XyDispStruct corresponds to bmad `xy_disp_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 846.

    Attributes
    ----------
    eta : float
        Bmad type: real
        Fortran default: 0
    etap : float
        Bmad type: real
        Fortran default: 0
    deta_ds : float
        Bmad type: real
        Fortran default: 0
    sigma : float
        Bmad type: real
        Fortran default: 0
    """

    eta: float = pydantic.Field(
        default=0,
    )
    etap: float = pydantic.Field(
        default=0,
    )
    deta_ds: float = pydantic.Field(
        default=0,
    )
    sigma: float = pydantic.Field(
        default=0,
    )


class LatEleLocStruct(pydantic.BaseModel):
    """
    LatEleLocStruct corresponds to bmad `lat_ele_loc_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 853.

    Attributes
    ----------
    ix_ele : int
        Bmad type: integer
        Fortran default: -1
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    """

    ix_ele: int = pydantic.Field(
        default=-1,
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )


class LatEleOrder1Struct(pydantic.BaseModel):
    """
    LatEleOrder1Struct corresponds to bmad `lat_ele_order1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 860.

    Attributes
    ----------
    ix_branch : int
        Branch index
        Bmad type: integer
        Fortran default: -1
    ix_order : int
        Order index. -1 -> Unique in lattice, 0 -> unique in branch.
        Bmad type: integer
        Fortran default: -1
    """

    ix_branch: int = pydantic.Field(
        default=-1,
        description="Branch index",
    )
    ix_order: int = pydantic.Field(
        default=-1,
        description="Order index. -1 -> Unique in lattice, 0 -> unique in branch.",
    )


class LatEleOrderArrayStruct(pydantic.BaseModel):
    """
    LatEleOrderArrayStruct corresponds to bmad `lat_ele_order_array_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 865.

    Attributes
    ----------
    ele : LatEleOrder1Struct
        Bmad type: type
    """

    ele: Sequence[LatEleOrder1Struct] = pydantic.Field(
        default=None,
    )


class LatEleOrderStruct(pydantic.BaseModel):
    """
    LatEleOrderStruct corresponds to bmad `lat_ele_order_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 884.

    Attributes
    ----------
    branch : LatEleOrderArrayStruct
        Bmad type: type
    """

    branch: Sequence[LatEleOrderArrayStruct] = pydantic.Field(
        default=None,
    )


class ElePointerStruct(pydantic.BaseModel):
    """
    ElePointerStruct corresponds to bmad `ele_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 895.

    Attributes
    ----------
    ele : EleStruct
        Bmad type: type
        Fortran default: null()
    loc : LatEleLocStruct
        Bmad type: type
        Fortran default: lat_ele_loc_struct()
    id : int
        For general use. Not used by Bmad.
        Bmad type: integer
        Fortran default: -1
    """

    ele: EleStruct = pydantic.Field(
        default=None,
    )
    loc: LatEleLocStruct = pydantic.Field(
        default=None,
    )
    id: int = pydantic.Field(
        default=-1,
        description="For general use. Not used by Bmad.",
    )


class BranchPointerStruct(pydantic.BaseModel):
    """
    BranchPointerStruct corresponds to bmad `branch_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 903.

    Attributes
    ----------
    branch : BranchStruct
        Bmad type: type
        Fortran default: null()
    """

    branch: BranchStruct = pydantic.Field(
        default=None,
    )


class LatPointerStruct(pydantic.BaseModel):
    """
    LatPointerStruct corresponds to bmad `lat_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 909.

    Attributes
    ----------
    lat : LatStruct
        Bmad type: type
        Fortran default: null()
    """

    lat: LatStruct = pydantic.Field(
        default=None,
    )


class Mode3Struct(pydantic.BaseModel):
    """
    Mode3Struct corresponds to bmad `mode3_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 915.

    Attributes
    ----------
    v : float
        Bmad type: real
    a : TwissStruct
        Bmad type: type
    b : TwissStruct
        Bmad type: type
    c : TwissStruct
        Bmad type: type
    x : TwissStruct
        Bmad type: type
    y : TwissStruct
        Bmad type: type
    """

    v: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a: TwissStruct = pydantic.Field(
        default=None,
    )
    b: TwissStruct = pydantic.Field(
        default=None,
    )
    c: TwissStruct = pydantic.Field(
        default=None,
    )
    x: TwissStruct = pydantic.Field(
        default=None,
    )
    y: TwissStruct = pydantic.Field(
        default=None,
    )


class BookkeepingStateStruct(pydantic.BaseModel):
    """
    BookkeepingStateStruct corresponds to bmad `bookkeeping_state_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 931.

    Attributes
    ----------
    attributes : int
        Element dependent attributes: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    control : int
        Lord/slave bookkeeping status: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    floor_position : int
        Global (floor) geometry: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    s_position : int
        Longitudinal position & element length: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    ref_energy : int
        Reference energy and ref time: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    mat6 : int
        Linear transfer map status: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    rad_int : int
        Radiation integrals cache status
        Bmad type: integer
        Fortran default: stale$
    ptc : int
        Associated PTC fibre (or layout) status.
        Bmad type: integer
        Fortran default: stale$
    has_misalign : bool
        Used to avoid unnecessary calls to offset_particle.
        Bmad type: logical
        Fortran default: .false.
    """

    attributes: int = pydantic.Field(
        default=0,
        description="Element dependent attributes: super_ok$, ok$ or stale$",
    )
    control: int = pydantic.Field(
        default=0,
        description="Lord/slave bookkeeping status: super_ok$, ok$ or stale$",
    )
    floor_position: int = pydantic.Field(
        default=0,
        description="Global (floor) geometry: super_ok$, ok$ or stale$",
    )
    s_position: int = pydantic.Field(
        default=0,
        description="Longitudinal position & element length: super_ok$, ok$ or stale$",
    )
    ref_energy: int = pydantic.Field(
        default=0,
        description="Reference energy and ref time: super_ok$, ok$ or stale$",
    )
    mat6: int = pydantic.Field(
        default=0,
        description="Linear transfer map status: super_ok$, ok$ or stale$",
    )
    rad_int: int = pydantic.Field(
        default=0,
        description="Radiation integrals cache status",
    )
    ptc: int = pydantic.Field(
        default=0,
        description="Associated PTC fibre (or layout) status.",
    )
    has_misalign: bool = pydantic.Field(
        default=False,
        description="Used to avoid unnecessary calls to offset_particle.",
    )


class MultipoleCacheStruct(pydantic.BaseModel):
    """
    MultipoleCacheStruct corresponds to bmad `multipole_cache_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 946.

    Attributes
    ----------
    a_pole_mag : float
        Bmad type: real
    b_pole_mag : float
        Bmad type: real
    a_kick_mag : float
        Bmad type: real
    b_kick_mag : float
        Bmad type: real
    ix_pole_mag_max : int
        Bmad type: integer
        Fortran default: -1
    ix_kick_mag_max : int
        Bmad type: integer
        Fortran default: -1
    mag_valid : bool
        Bmad type: logical
        Fortran default: .false.
    a_pole_elec : float
        Bmad type: real
    b_pole_elec : float
        Bmad type: real
    a_kick_elec : float
        Bmad type: real
    b_kick_elec : float
        Bmad type: real
    ix_pole_elec_max : int
        Bmad type: integer
        Fortran default: -1
    ix_kick_elec_max : int
        Bmad type: integer
        Fortran default: -1
    elec_valid : bool
        Bmad type: logical
        Fortran default: .false.
    """

    a_pole_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_pole_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a_kick_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_kick_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ix_pole_mag_max: int = pydantic.Field(
        default=-1,
    )
    ix_kick_mag_max: int = pydantic.Field(
        default=-1,
    )
    mag_valid: bool = pydantic.Field(
        default=False,
    )
    a_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a_kick_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_kick_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ix_pole_elec_max: int = pydantic.Field(
        default=-1,
    )
    ix_kick_elec_max: int = pydantic.Field(
        default=-1,
    )
    elec_valid: bool = pydantic.Field(
        default=False,
    )


class RadMapStruct(pydantic.BaseModel):
    """
    RadMapStruct corresponds to bmad `rad_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 961.

    Attributes
    ----------
    ref_orb : float
        Reference point around which damp_mat is calculated.
        Bmad type: real
        Fortran default: -1
    damp_dmat : float
        damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.
        Bmad type: real
        Fortran default: 0
    xfer_damp_vec : float
        Transfer map with damping 0th order vector.
        Bmad type: real
        Fortran default: 0
    xfer_damp_mat : float
        1st order matrix: xfer_no_damp_mat + xfer_damp_correction.
        Bmad type: real
        Fortran default: mat6_unit$
    stoc_mat : float
        Stochastic variance or "kick" (Cholesky decomposed) matrix.
        Bmad type: real
        Fortran default: 0
    """

    ref_orb: Sequence[float] = pydantic.Field(
        default=-1,
        max_length=6,
        description="Reference point around which damp_mat is calculated.",
    )
    damp_dmat: Sequence[float] = pydantic.Field(
        default=0,
        description="damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.",
    )
    xfer_damp_vec: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Transfer map with damping 0th order vector.",
    )
    xfer_damp_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description="1st order matrix: xfer_no_damp_mat + xfer_damp_correction.",
    )
    stoc_mat: Sequence[float] = pydantic.Field(
        default=0,
        description="Stochastic variance or 'kick' (Cholesky decomposed) matrix.",
    )


class RadMapEleStruct(pydantic.BaseModel):
    """
    RadMapEleStruct corresponds to bmad `rad_map_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 969.

    Attributes
    ----------
    rm0 : RadMapStruct
        Upstream half and downstream half matrices for an element.
        Bmad type: type
    rm1 : RadMapStruct
        Upstream half and downstream half matrices for an element.
        Bmad type: type
    stale : bool
        Bmad type: logical
        Fortran default: .true.
    """

    rm0: RadMapStruct = pydantic.Field(
        default=None,
        description="Upstream half and downstream half matrices for an element.",
    )
    rm1: RadMapStruct = pydantic.Field(
        default=None,
        description="Upstream half and downstream half matrices for an element.",
    )
    stale: bool = pydantic.Field(
        default=True,
    )


class SurfaceSegmentedPtStruct(pydantic.BaseModel):
    """
    SurfaceSegmentedPtStruct corresponds to bmad `surface_segmented_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 977.

    Attributes
    ----------
    x0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    y0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    z0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    dz_dx : float
        Slope at center
        Bmad type: real
        Fortran default: 0
    dz_dy : float
        Slope at center
        Bmad type: real
        Fortran default: 0
    """

    x0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    z0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    dz_dx: float = pydantic.Field(
        default=0,
        description="Slope at center",
    )
    dz_dy: float = pydantic.Field(
        default=0,
        description="Slope at center",
    )


class SurfaceSegmentedStruct(pydantic.BaseModel):
    """
    SurfaceSegmentedStruct corresponds to bmad `surface_segmented_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 982.

    Attributes
    ----------
    active : bool
        Bmad type: logical
        Fortran default: .false.
    dr : float
        Bmad type: real
        Fortran default: 0
    r0 : float
        Bmad type: real
        Fortran default: 0
    pt : SurfaceSegmentedPtStruct
        Bmad type: type
    """

    active: bool = pydantic.Field(
        default=False,
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    pt: Sequence[SurfaceSegmentedPtStruct] = pydantic.Field(
        default=None,
    )


class SurfaceHMisalignPtStruct(pydantic.BaseModel):
    """
    SurfaceHMisalignPtStruct corresponds to bmad `surface_h_misalign_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 990.

    Attributes
    ----------
    x0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    y0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    rot_y : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    rot_t : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    rot_y_rms : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    rot_t_rms : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    """

    x0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    rot_y: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )
    rot_t: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )
    rot_y_rms: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )
    rot_t_rms: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )


class SurfaceHMisalignStruct(pydantic.BaseModel):
    """
    SurfaceHMisalignStruct corresponds to bmad `surface_h_misalign_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 995.

    Attributes
    ----------
    active : bool
        Bmad type: logical
        Fortran default: .false.
    dr : float
        Bmad type: real
        Fortran default: 0
    r0 : float
        Bmad type: real
        Fortran default: 0
    pt : SurfaceHMisalignPtStruct
        Bmad type: type
    """

    active: bool = pydantic.Field(
        default=False,
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    pt: Sequence[SurfaceHMisalignPtStruct] = pydantic.Field(
        default=None,
    )


class SurfaceDisplacementPtStruct(pydantic.BaseModel):
    """
    SurfaceDisplacementPtStruct corresponds to bmad `surface_displacement_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1003.

    Attributes
    ----------
    x0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    y0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    z0 : float
        Bmad type: real
        Fortran default: 0
    dz_dx : float
        Bmad type: real
        Fortran default: 0
    dz_dy : float
        Bmad type: real
        Fortran default: 0
    d2z_dxdy : float
        Bmad type: real
        Fortran default: 0
    """

    x0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    z0: float = pydantic.Field(
        default=0,
    )
    dz_dx: float = pydantic.Field(
        default=0,
    )
    dz_dy: float = pydantic.Field(
        default=0,
    )
    d2z_dxdy: float = pydantic.Field(
        default=0,
    )


class SurfaceDisplacementStruct(pydantic.BaseModel):
    """
    SurfaceDisplacementStruct corresponds to bmad `surface_displacement_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1008.

    Attributes
    ----------
    active : bool
        Bmad type: logical
        Fortran default: .false.
    dr : float
        Bmad type: real
        Fortran default: 0
    r0 : float
        Bmad type: real
        Fortran default: 0
    pt : SurfaceDisplacementPtStruct
        Bmad type: type
    """

    active: bool = pydantic.Field(
        default=False,
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    pt: Sequence[SurfaceDisplacementPtStruct] = pydantic.Field(
        default=None,
    )


class PixelPtStruct(pydantic.BaseModel):
    """
    PixelPtStruct corresponds to bmad `pixel_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1016.

    Attributes
    ----------
    n_photon : int
        Bmad type: integer
        Fortran default: 0
    e_x : Complex
        Bmad type: complex
        Fortran default: 0
    e_y : Complex
        Bmad type: complex
        Fortran default: 0
    intensity_x : float
        Bmad type: real
        Fortran default: 0
    intensity_y : float
        Bmad type: real
        Fortran default: 0
    intensity : float
        Bmad type: real
        Fortran default: 0
    orbit : float
        x, Vx/c, y, Vy/c, dummy, E - E_ref.
        Bmad type: real
        Fortran default: 0
    orbit_rms : float
        RMS statistics.
        Bmad type: real
        Fortran default: 0
    init_orbit : float
        Initial orbit at start of lattice statistics.
        Bmad type: real
        Fortran default: 0
    init_orbit_rms : float
        Initial orbit at start of lattice RMS statistics.
        Bmad type: real
        Fortran default: 0
    """

    n_photon: int = pydantic.Field(
        default=0,
        max_length=8,
    )
    e_x: Complex = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("e_x", "E_x"),
        serialization_alias="E_x",
    )
    e_y: Complex = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("e_y", "E_y"),
        serialization_alias="E_y",
    )
    intensity_x: float = pydantic.Field(
        default=0,
    )
    intensity_y: float = pydantic.Field(
        default=0,
    )
    intensity: float = pydantic.Field(
        default=0,
    )
    orbit: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="x, Vx/c, y, Vy/c, dummy, E - E_ref.",
    )
    orbit_rms: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="RMS statistics.",
    )
    init_orbit: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Initial orbit at start of lattice statistics.",
    )
    init_orbit_rms: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Initial orbit at start of lattice RMS statistics.",
    )


class PixelDetecStruct(pydantic.BaseModel):
    """
    PixelDetecStruct corresponds to bmad `pixel_detec_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1026.

    Attributes
    ----------
    dr : float
        Bmad type: real
        Fortran default: 0
    r0 : float
        Bmad type: real
        Fortran default: 0
    n_track_tot : int
        How many photons were launched from source element.
        Bmad type: integer
        Fortran default: 0
    n_hit_detec : int
        How many photons hit the detector.
        Bmad type: integer
        Fortran default: 0
    n_hit_pixel : int
        How many photons hit the pixel grid of the detector.
        Bmad type: integer
        Fortran default: 0
    pt : PixelPtStruct
        Grid of pixels
        Bmad type: type
    """

    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    n_track_tot: int = pydantic.Field(
        default=0,
        max_length=8,
        description="How many photons were launched from source element.",
    )
    n_hit_detec: int = pydantic.Field(
        default=0,
        max_length=8,
        description="How many photons hit the detector.",
    )
    n_hit_pixel: int = pydantic.Field(
        default=0,
        max_length=8,
        description="How many photons hit the pixel grid of the detector.",
    )
    pt: Sequence[PixelPtStruct] = pydantic.Field(
        default=None,
        description="Grid of pixels",
    )


class SurfaceCurvatureStruct(pydantic.BaseModel):
    """
    SurfaceCurvatureStruct corresponds to bmad `surface_curvature_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1036.

    Attributes
    ----------
    xy : float
        Bmad type: real
        Fortran default: 0
    spherical : float
        Bmad type: real
        Fortran default: 0
    elliptical : float
        Total curvature = elliptical + spherical
        Bmad type: real
        Fortran default: 0
    has_curvature : bool
        Dependent var. Will be set by Bmad
        Bmad type: logical
        Fortran default: .false.
    """

    xy: Sequence[float] = pydantic.Field(
        default=0,
    )
    spherical: float = pydantic.Field(
        default=0,
    )
    elliptical: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Total curvature = elliptical + spherical",
    )
    has_curvature: bool = pydantic.Field(
        default=False,
        description="Dependent var. Will be set by Bmad",
    )


class TargetPointStruct(pydantic.BaseModel):
    """
    TargetPointStruct corresponds to bmad `target_point_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1045.

    Attributes
    ----------
    r : float
        (x, y, z)
        Bmad type: real
        Fortran default: 0
    """

    r: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="(x, y, z)",
    )


class PhotonTargetStruct(pydantic.BaseModel):
    """
    PhotonTargetStruct corresponds to bmad `photon_target_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1049.

    Attributes
    ----------
    type : int
        or rectangular$
        Bmad type: integer
        Fortran default: off$
    n_corner : int
        Bmad type: integer
        Fortran default: 0
    ele_loc : LatEleLocStruct
        Bmad type: type
        Fortran default: lat_ele_loc_struct()
    corner : TargetPointStruct
        Bmad type: type
        Fortran default: target_point_struct()
    center : TargetPointStruct
        Bmad type: type
        Fortran default: target_point_struct()
    """

    type: int = pydantic.Field(
        default=0,
        description="or rectangular$",
    )
    n_corner: int = pydantic.Field(
        default=0,
    )
    ele_loc: LatEleLocStruct = pydantic.Field(
        default=None,
    )
    corner: Sequence[TargetPointStruct] = pydantic.Field(
        default=None,
        max_length=8,
    )
    center: TargetPointStruct = pydantic.Field(
        default=None,
    )


class PhotonMaterialStruct(pydantic.BaseModel):
    """
    PhotonMaterialStruct corresponds to bmad `photon_material_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1057.

    Attributes
    ----------
    f0_m1 : Complex
        For multilayer_mirror only.
        Bmad type: complex
        Fortran default: 0
    f0_m2 : Complex
        For multilayer_mirror only.
        Bmad type: complex
        Fortran default: 0
    f_0 : Complex
        Bmad type: complex
        Fortran default: 0
    f_h : Complex
        Structure factor for H direction.
        Bmad type: complex
        Fortran default: 0
    f_hbar : Complex
        Structure factor for -H direction.
        Bmad type: complex
        Fortran default: 0
    f_hkl : Complex
        = sqrt(f_h * f_hbar)
        Bmad type: complex
        Fortran default: 0
    h_norm : float
        Normalized H vector for crystals.
        Bmad type: real
        Fortran default: 0
    l_ref : float
        Crystal reference orbit displacement vector in element coords.
        Bmad type: real
        Fortran default: 0
    """

    f0_m1: Complex = pydantic.Field(
        default=0,
        description="For multilayer_mirror only.",
    )
    f0_m2: Complex = pydantic.Field(
        default=0,
        description="For multilayer_mirror only.",
    )
    f_0: Complex = pydantic.Field(
        default=0,
    )
    f_h: Complex = pydantic.Field(
        default=0,
        description="Structure factor for H direction.",
    )
    f_hbar: Complex = pydantic.Field(
        default=0,
        description="Structure factor for -H direction.",
    )
    f_hkl: Complex = pydantic.Field(
        default=0,
        description="= sqrt(f_h * f_hbar)",
    )
    h_norm: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Normalized H vector for crystals.",
    )
    l_ref: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Crystal reference orbit displacement vector in element coords.",
    )


class PhotonElementStruct(pydantic.BaseModel):
    """
    PhotonElementStruct corresponds to bmad `photon_element_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1072.

    Attributes
    ----------
    curvature : SurfaceCurvatureStruct
        Bmad type: type
        Fortran default: surface_curvature_struct()
    target : PhotonTargetStruct
        Bmad type: type
        Fortran default: photon_target_struct()
    material : PhotonMaterialStruct
        Bmad type: type
        Fortran default: photon_material_struct()
    segmented : SurfaceSegmentedStruct
        Bmad type: type
        Fortran default: surface_segmented_struct(.false., 0, 0, null())
    h_misalign : SurfaceHMisalignStruct
        Bmad type: type
        Fortran default: surface_h_misalign_struct(.false., 0, 0, null())
    displacement : SurfaceDisplacementStruct
        Bmad type: type
        Fortran default: surface_displacement_struct(.false., 0, 0, null())
    pixel : PixelDetecStruct
        Bmad type: type
        Fortran default: pixel_detec_struct([0.0_rp, 0.0_rp], [0.0_rp, 0.0_rp], 0, 0, 0, null())
    reflectivity_table_type : int
        Bmad type: integer
        Fortran default: not_set$
    reflectivity_table_sigma : PhotonReflectTableStruct
        If polarization is ignored use sigma table.
        Bmad type: type
    reflectivity_table_pi : PhotonReflectTableStruct
        Bmad type: type
    init_energy_prob : SplineStruct
        Initial energy probability density
        Bmad type: type
    integrated_init_energy_prob : float
        Bmad type: real
    """

    curvature: SurfaceCurvatureStruct = pydantic.Field(
        default=None,
    )
    target: PhotonTargetStruct = pydantic.Field(
        default=None,
    )
    material: PhotonMaterialStruct = pydantic.Field(
        default=None,
    )
    segmented: SurfaceSegmentedStruct = pydantic.Field(
        default=None,
    )
    h_misalign: SurfaceHMisalignStruct = pydantic.Field(
        default=None,
    )
    displacement: SurfaceDisplacementStruct = pydantic.Field(
        default=None,
    )
    pixel: PixelDetecStruct = pydantic.Field(
        default=None,
    )
    reflectivity_table_type: int = pydantic.Field(
        default=0,
    )
    reflectivity_table_sigma: PhotonReflectTableStruct = pydantic.Field(
        default=None,
        description="If polarization is ignored use sigma table.",
    )
    reflectivity_table_pi: PhotonReflectTableStruct = pydantic.Field(
        default=None,
    )
    init_energy_prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
        description="Initial energy probability density",
    )
    integrated_init_energy_prob: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class BunchStruct(pydantic.BaseModel):
    """
    BunchStruct corresponds to bmad `bunch_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1090.

    Attributes
    ----------
    particle : CoordStruct
        Bmad type: type
    ix_z : int
        bunch%ix_z(1) is index of head particle, etc.
        Bmad type: integer
    charge_tot : float
        Total charge in a bunch (Coul).
        Bmad type: real
        Fortran default: 0
    charge_live : float
        Charge of live particles (Coul).
        Bmad type: real
        Fortran default: 0
    z_center : float
        Longitudinal center of bunch at creation time. Note: Generally, z_center of
        Bmad type: real
        Fortran default: 0
    t_center : float
        Center of bunch at creation time relative to head bunch.
        Bmad type: real
        Fortran default: 0
    t0 : float
        Used by track1_bunch_space_charge for tracking so particles have constant t.
        Bmad type: real
        Fortran default: real_garbage$
    drift_between_t_and_s : bool
        Bmad type: logical
        Fortran default: .false.
    ix_ele : int
        Nominal element bunch is at. But, EG, dead particles can be someplace else.
        Bmad type: integer
        Fortran default: 0
    ix_bunch : int
        Bunch index. Head bunch = 1, etc.
        Bmad type: integer
        Fortran default: 0
    ix_turn : int
        Turn index for long term tracking. ix_turn = 0 before end of first turn, etc.
        Bmad type: integer
        Fortran default: 0
    n_live : int
        Bmad type: integer
        Fortran default: 0
    n_good : int
        Number of accepted steps when using adaptive step size control.
        Bmad type: integer
        Fortran default: 0
    n_bad : int
        Number of rejected steps when using adaptive step size control.
        Bmad type: integer
        Fortran default: 0
    """

    particle: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )
    ix_z: Sequence[int] = pydantic.Field(
        default=0,
        description="bunch%ix_z(1) is index of head particle, etc.",
    )
    charge_tot: float = pydantic.Field(
        default=0,
        description="Total charge in a bunch (Coul).",
    )
    charge_live: float = pydantic.Field(
        default=0,
        description="Charge of live particles (Coul).",
    )
    z_center: float = pydantic.Field(
        default=0,
        description="Longitudinal center of bunch at creation time. Note: Generally, z_center of",
    )
    t_center: float = pydantic.Field(
        default=0,
        description="Center of bunch at creation time relative to head bunch.",
    )
    t0: float = pydantic.Field(
        default=0.0,
        description="Used by track1_bunch_space_charge for tracking so particles have constant t.",
    )
    drift_between_t_and_s: bool = pydantic.Field(
        default=False,
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="Nominal element bunch is at. But, EG, dead particles can be someplace else.",
    )
    ix_bunch: int = pydantic.Field(
        default=0,
        description="Bunch index. Head bunch = 1, etc.",
    )
    ix_turn: int = pydantic.Field(
        default=0,
        description="Turn index for long term tracking. ix_turn = 0 before end of first turn, etc.",
    )
    n_live: int = pydantic.Field(
        default=0,
    )
    n_good: int = pydantic.Field(
        default=0,
        description="Number of accepted steps when using adaptive step size control.",
    )
    n_bad: int = pydantic.Field(
        default=0,
        description="Number of rejected steps when using adaptive step size control.",
    )


class BeamStruct(pydantic.BaseModel):
    """
    BeamStruct corresponds to bmad `beam_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1110.

    Attributes
    ----------
    bunch : BunchStruct
        Bmad type: type
    """

    bunch: Sequence[BunchStruct] = pydantic.Field(
        default=None,
    )


class EllipseBeamInitStruct(pydantic.BaseModel):
    """
    EllipseBeamInitStruct corresponds to bmad `ellipse_beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1114.

    Attributes
    ----------
    part_per_ellipse : int
        number of particles per ellipse
        Bmad type: integer
        Fortran default: 0
    n_ellipse : int
        number of ellipses (>= 1)
        Bmad type: integer
        Fortran default: 1
    sigma_cutoff : float
        sigma cutoff of the representation
        Bmad type: real
        Fortran default: 0
    """

    part_per_ellipse: int = pydantic.Field(
        default=0,
        description="number of particles per ellipse",
    )
    n_ellipse: int = pydantic.Field(
        default=1,
        description="number of ellipses (>= 1)",
    )
    sigma_cutoff: float = pydantic.Field(
        default=0,
        description="sigma cutoff of the representation",
    )


class KvBeamInitStruct(pydantic.BaseModel):
    """
    KvBeamInitStruct corresponds to bmad `kv_beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1120.

    Attributes
    ----------
    part_per_phi : int
        number of particles per angle variable.
        Bmad type: integer
        Fortran default: 0
    n_i2 : int
        number of I2
        Bmad type: integer
        Fortran default: 0
    a : float
        A = I1/e
        Bmad type: real
        Fortran default: 0
    """

    part_per_phi: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
        description="number of particles per angle variable.",
    )
    n_i2: int = pydantic.Field(
        default=0,
        description="number of I2",
        validation_alias=pydantic.AliasChoices("n_i2", "n_I2"),
        serialization_alias="n_I2",
    )
    a: float = pydantic.Field(
        default=0,
        description="A = I1/e",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )


class GridBeamInitStruct(pydantic.BaseModel):
    """
    GridBeamInitStruct corresponds to bmad `grid_beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1126.

    Attributes
    ----------
    n_x : int
        Number of columns.
        Bmad type: integer
        Fortran default: 0
    n_px : int
        Number of rows.
        Bmad type: integer
        Fortran default: 0
    x_min : float
        Lower x limit.
        Bmad type: real
        Fortran default: 0
    x_max : float
        Upper x limit.
        Bmad type: real
        Fortran default: 0
    px_min : float
        Lower px limit.
        Bmad type: real
        Fortran default: 0
    px_max : float
        Upper px limit.
        Bmad type: real
        Fortran default: 0
    """

    n_x: int = pydantic.Field(
        default=0,
        description="Number of columns.",
    )
    n_px: int = pydantic.Field(
        default=0,
        description="Number of rows.",
    )
    x_min: float = pydantic.Field(
        default=0,
        description="Lower x limit.",
    )
    x_max: float = pydantic.Field(
        default=0,
        description="Upper x limit.",
    )
    px_min: float = pydantic.Field(
        default=0,
        description="Lower px limit.",
    )
    px_max: float = pydantic.Field(
        default=0,
        description="Upper px limit.",
    )


class BeamInitStruct(pydantic.BaseModel):
    """
    BeamInitStruct corresponds to bmad `beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1135.

    Attributes
    ----------
    position_file : str
        File with particle positions.
        Bmad type: character
        Fortran default: ''
    distribution_type : str
        distribution type (in x-px, y-py, and z-pz planes)
        Bmad type: character
        Fortran default: 'RAN_GAUSS'
    spin : float
        Spin (x, y, z)
        Bmad type: real
        Fortran default: 0
    ellipse : EllipseBeamInitStruct
        Ellipse beam distribution
        Bmad type: type
        Fortran default: ellipse_beam_init_struct()
    kv : KvBeamInitStruct
        KV beam distribution
        Bmad type: type
        Fortran default: kv_beam_init_struct()
    grid : GridBeamInitStruct
        Grid beam distribution
        Bmad type: type
        Fortran default: grid_beam_init_struct()
    center_jitter : float
        Bunch center rms jitter
        Bmad type: real
        Fortran default: 0.0
    emit_jitter : float
        a and b bunch emittance rms jitter normalized to emittance
        Bmad type: real
        Fortran default: 0.0
    sig_z_jitter : float
        bunch length RMS jitter
        Bmad type: real
        Fortran default: 0.0
    sig_pz_jitter : float
        RMS pz spread jitter
        Bmad type: real
        Fortran default: 0.0
    n_particle : int
        Number of particles per bunch.
        Bmad type: integer
        Fortran default: 0
    renorm_center : bool
        Renormalize centroid?
        Bmad type: logical
        Fortran default: .true.
    renorm_sigma : bool
        Renormalize sigma?
        Bmad type: logical
        Fortran default: .true.
    random_engine : str
        Or 'quasi'. Random number engine to use.
        Bmad type: character
        Fortran default: 'pseudo'
    random_gauss_converter : str
        Bmad type: character
        Fortran default: 'exact'
    random_sigma_cutoff : float
        Cut-off in sigmas.
        Bmad type: real
        Fortran default: -1
    a_norm_emit : float
        a-mode normalized emittance (emit * beta * gamma)
        Bmad type: real
        Fortran default: 0
    b_norm_emit : float
        b-mode normalized emittance (emit * beta * gamma)
        Bmad type: real
        Fortran default: 0
    a_emit : float
        a-mode emittance
        Bmad type: real
        Fortran default: 0
    b_emit : float
        b-mode emittance
        Bmad type: real
        Fortran default: 0
    dpz_dz : float
        Correlation of Pz with long position.
        Bmad type: real
        Fortran default: 0
    center : float
        Bench phase space center offset relative to reference.
        Bmad type: real
        Fortran default: 0
    t_offset : float
        Time center offset
        Bmad type: real
        Fortran default: 0
    dt_bunch : float
        Time between bunches.
        Bmad type: real
        Fortran default: 0
    sig_z : float
        Z sigma in m.
        Bmad type: real
        Fortran default: 0
    sig_pz : float
        pz sigma
        Bmad type: real
        Fortran default: 0
    bunch_charge : float
        charge (Coul) in a bunch.
        Bmad type: real
        Fortran default: 0
    n_bunch : int
        Number of bunches.
        Bmad type: integer
        Fortran default: 0
    ix_turn : int
        Turn index used to adjust particles time if needed.
        Bmad type: integer
        Fortran default: 0
    species : str
        "positron", etc. "" => use referece particle.
        Bmad type: character
        Fortran default: ""
    full_6d_coupling_calc : bool
        Use V from 6x6 1-turn mat to match distribution?
        Bmad type: logical
        Fortran default: .false.
    use_particle_start : bool
        Use lat%particle_start instead of beam_init%center, %spin?
        Bmad type: logical
        Fortran default: .false.
    use_t_coords : bool
        If true, the distributions will be taken as in t-coordinates
        Bmad type: logical
        Fortran default: .false.
    use_z_as_t : bool
        Only used if  use_t_coords = .true.
        Bmad type: logical
        Fortran default: .false.
    file_name : str
        OLD!! DO NOT USE!!
        Bmad type: character
        Fortran default: ''
    """

    position_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="File with particle positions.",
    )
    distribution_type: Sequence[str] = pydantic.Field(
        default="RAN_GAUSS",
        max_length=3,
        description="distribution type (in x-px, y-py, and z-pz planes)",
    )
    spin: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Spin (x, y, z)",
    )
    ellipse: Sequence[EllipseBeamInitStruct] = pydantic.Field(
        default=None,
        max_length=3,
        description="Ellipse beam distribution",
    )
    kv: KvBeamInitStruct = pydantic.Field(
        default=None,
        description="KV beam distribution",
        validation_alias=pydantic.AliasChoices("kv", "KV"),
        serialization_alias="KV",
    )
    grid: Sequence[GridBeamInitStruct] = pydantic.Field(
        default=None,
        max_length=3,
        description="Grid beam distribution",
    )
    center_jitter: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="Bunch center rms jitter",
    )
    emit_jitter: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
        description="a and b bunch emittance rms jitter normalized to emittance",
    )
    sig_z_jitter: float = pydantic.Field(
        default=0.0,
        description="bunch length RMS jitter",
    )
    sig_pz_jitter: float = pydantic.Field(
        default=0.0,
        description="RMS pz spread jitter",
    )
    n_particle: int = pydantic.Field(
        default=0,
        description="Number of particles per bunch.",
    )
    renorm_center: bool = pydantic.Field(
        default=True,
        description="Renormalize centroid?",
    )
    renorm_sigma: bool = pydantic.Field(
        default=True,
        description="Renormalize sigma?",
    )
    random_engine: str = pydantic.Field(
        default="pseudo",
        max_length=16,
        description="Or 'quasi'. Random number engine to use.",
    )
    random_gauss_converter: str = pydantic.Field(
        default="exact",
        max_length=16,
    )
    random_sigma_cutoff: float = pydantic.Field(
        default=-1,
        description="Cut-off in sigmas.",
    )
    a_norm_emit: float = pydantic.Field(
        default=0,
        description="a-mode normalized emittance (emit * beta * gamma)",
    )
    b_norm_emit: float = pydantic.Field(
        default=0,
        description="b-mode normalized emittance (emit * beta * gamma)",
    )
    a_emit: float = pydantic.Field(
        default=0,
        description="a-mode emittance",
    )
    b_emit: float = pydantic.Field(
        default=0,
        description="b-mode emittance",
    )
    dpz_dz: float = pydantic.Field(
        default=0,
        description="Correlation of Pz with long position.",
        validation_alias=pydantic.AliasChoices("dpz_dz", "dPz_dz"),
        serialization_alias="dPz_dz",
    )
    center: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Bench phase space center offset relative to reference.",
    )
    t_offset: float = pydantic.Field(
        default=0,
        description="Time center offset",
    )
    dt_bunch: float = pydantic.Field(
        default=0,
        description="Time between bunches.",
    )
    sig_z: float = pydantic.Field(
        default=0,
        description="Z sigma in m.",
    )
    sig_pz: float = pydantic.Field(
        default=0,
        description="pz sigma",
    )
    bunch_charge: float = pydantic.Field(
        default=0,
        description="charge (Coul) in a bunch.",
    )
    n_bunch: int = pydantic.Field(
        default=0,
        description="Number of bunches.",
    )
    ix_turn: int = pydantic.Field(
        default=0,
        description="Turn index used to adjust particles time if needed.",
    )
    species: str = pydantic.Field(
        default="",
        max_length=16,
        description="'positron', etc. '' => use referece particle.",
    )
    full_6d_coupling_calc: bool = pydantic.Field(
        default=False,
        description="Use V from 6x6 1-turn mat to match distribution?",
        validation_alias=pydantic.AliasChoices(
            "full_6d_coupling_calc", "full_6D_coupling_calc"
        ),
        serialization_alias="full_6D_coupling_calc",
    )
    use_particle_start: bool = pydantic.Field(
        default=False,
        description="Use lat%particle_start instead of beam_init%center, %spin?",
    )
    use_t_coords: bool = pydantic.Field(
        default=False,
        description="If true, the distributions will be taken as in t-coordinates",
    )
    use_z_as_t: bool = pydantic.Field(
        default=False,
        description="Only used if  use_t_coords = .true.",
    )
    file_name: str = pydantic.Field(
        default="",
        max_length=200,
        description="OLD!! DO NOT USE!!",
    )


class BunchParamsStruct(pydantic.BaseModel):
    """
    BunchParamsStruct corresponds to bmad `bunch_params_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1187.

    Attributes
    ----------
    centroid : CoordStruct
        Lab frame
        Bmad type: type
        Fortran default: coord_struct()
    x : TwissStruct
        Projected Twiss parameters
        Bmad type: type
        Fortran default: twiss_struct()
    y : TwissStruct
        Projected Twiss parameters
        Bmad type: type
        Fortran default: twiss_struct()
    z : TwissStruct
        Projected Twiss parameters
        Bmad type: type
        Fortran default: twiss_struct()
    a : TwissStruct
        Normal mode twiss parameters
        Bmad type: type
        Fortran default: twiss_struct()
    b : TwissStruct
        Normal mode twiss parameters
        Bmad type: type
        Fortran default: twiss_struct()
    c : TwissStruct
        Normal mode twiss parameters
        Bmad type: type
        Fortran default: twiss_struct()
    sigma : float
        beam size matrix
        Bmad type: real
        Fortran default: 0
    rel_max : float
        Max orbit relative to centroid. 7 -> time.
        Bmad type: real
        Fortran default: 0
    rel_min : float
        Min orbit relative to_centroid. 7 -> time.
        Bmad type: real
        Fortran default: 0
    s : float
        Longitudinal position.
        Bmad type: real
        Fortran default: -1
    t : float
        Time.
        Bmad type: real
        Fortran default: -1
    sigma_t : float
        RMS of time spread.
        Bmad type: real
        Fortran default: 0
    charge_live : float
        Charge of all non-lost particle
        Bmad type: real
        Fortran default: 0
    charge_tot : float
        Charge of all particles.
        Bmad type: real
        Fortran default: 0
    n_particle_tot : int
        Total number of particles
        Bmad type: integer
        Fortran default: 0
    n_particle_live : int
        Number of non-lost particles
        Bmad type: integer
        Fortran default: 0
    n_particle_lost_in_ele : int
        Number lost in element (not calculated by Bmad)
        Bmad type: integer
        Fortran default: 0
    n_good_steps : int
        Number of good steps (set when tracking with space charge)
        Bmad type: integer
        Fortran default: 0
    n_bad_steps : int
        Number of bad steps (set when tracking with space charge)
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Lattice element where params evaluated at.
        Bmad type: integer
        Fortran default: -1
    location : int
        Location in element: upstream_end$, inside$, or downstream_end$
        Bmad type: integer
        Fortran default: not_set$
    twiss_valid : bool
        Is the data here valid? Note: IF there is no energy
        Bmad type: logical
        Fortran default: .false.
    """

    centroid: CoordStruct = pydantic.Field(
        default=None,
        description="Lab frame",
    )
    x: TwissStruct = pydantic.Field(
        default=None,
        description="Projected Twiss parameters",
    )
    y: TwissStruct = pydantic.Field(
        default=None,
        description="Projected Twiss parameters",
    )
    z: TwissStruct = pydantic.Field(
        default=None,
        description="Projected Twiss parameters",
    )
    a: TwissStruct = pydantic.Field(
        default=None,
        description="Normal mode twiss parameters",
    )
    b: TwissStruct = pydantic.Field(
        default=None,
        description="Normal mode twiss parameters",
    )
    c: TwissStruct = pydantic.Field(
        default=None,
        description="Normal mode twiss parameters",
    )
    sigma: Sequence[float] = pydantic.Field(
        default=0,
        description="beam size matrix",
    )
    rel_max: Sequence[float] = pydantic.Field(
        default=0,
        max_length=7,
        description="Max orbit relative to centroid. 7 -> time.",
    )
    rel_min: Sequence[float] = pydantic.Field(
        default=0,
        max_length=7,
        description="Min orbit relative to_centroid. 7 -> time.",
    )
    s: float = pydantic.Field(
        default=-1,
        description="Longitudinal position.",
    )
    t: float = pydantic.Field(
        default=-1,
        description="Time.",
    )
    sigma_t: float = pydantic.Field(
        default=0,
        description="RMS of time spread.",
    )
    charge_live: float = pydantic.Field(
        default=0,
        description="Charge of all non-lost particle",
    )
    charge_tot: float = pydantic.Field(
        default=0,
        description="Charge of all particles.",
    )
    n_particle_tot: int = pydantic.Field(
        default=0,
        description="Total number of particles",
    )
    n_particle_live: int = pydantic.Field(
        default=0,
        description="Number of non-lost particles",
    )
    n_particle_lost_in_ele: int = pydantic.Field(
        default=0,
        description="Number lost in element (not calculated by Bmad)",
    )
    n_good_steps: int = pydantic.Field(
        default=0,
        description="Number of good steps (set when tracking with space charge)",
    )
    n_bad_steps: int = pydantic.Field(
        default=0,
        description="Number of bad steps (set when tracking with space charge)",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description="Lattice element where params evaluated at.",
    )
    location: int = pydantic.Field(
        default=0,
        description="Location in element: upstream_end$, inside$, or downstream_end$",
    )
    twiss_valid: bool = pydantic.Field(
        default=False,
        description="Is the data here valid? Note: IF there is no energy",
    )


class BunchTrackStruct(pydantic.BaseModel):
    """
    BunchTrackStruct corresponds to bmad `bunch_track_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1213.

    Attributes
    ----------
    pt : BunchParamsStruct
        Array indexed from 0
        Bmad type: type
    ds_save : float
        Min distance between points.
        Bmad type: real
        Fortran default: -1
    n_pt : int
        Track upper bound
        Bmad type: integer
        Fortran default: -1
    """

    pt: Sequence[BunchParamsStruct] = pydantic.Field(
        default=None,
        description="Array indexed from 0",
    )
    ds_save: float = pydantic.Field(
        default=-1,
        description="Min distance between points.",
    )
    n_pt: int = pydantic.Field(
        default=-1,
        description="Track upper bound",
    )


class ConverterProbPcRStruct(pydantic.BaseModel):
    """
    ConverterProbPcRStruct corresponds to bmad `converter_prob_pc_r_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1224.

    Attributes
    ----------
    pc_out : float
        Grid pc_out values.
        Bmad type: real
    r : float
        Grid r_out values.
        Bmad type: real
    prob : float
        Probability grid.
        Bmad type: real
    spin_z : float
        Z polarization grid.
        Bmad type: real
    pc_out_min : float
        Bmad type: real
    pc_out_max : float
        Bmad type: real
    integrated_prob : float
        Integrated probability over (pc_out, r) with restrictions factered in.
        Bmad type: real
        Fortran default: 0
    p_norm : float
        Normalized probability taking into account.
        Bmad type: real
    integ_pc_out : float
        Normalized probability integrated from min pc_out up.
        Bmad type: real
    integ_r : float
        Bmad type: real
    integ_r_ave : float
        Bmad type: real
    """

    pc_out: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Grid pc_out values.",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Grid r_out values.",
    )
    prob: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Probability grid.",
    )
    spin_z: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Z polarization grid.",
    )
    pc_out_min: float = pydantic.Field(
        default=0.0,
    )
    pc_out_max: float = pydantic.Field(
        default=0.0,
    )
    integrated_prob: float = pydantic.Field(
        default=0,
        description="Integrated probability over (pc_out, r) with restrictions factered in.",
    )
    p_norm: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Normalized probability taking into account.",
    )
    integ_pc_out: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Normalized probability integrated from min pc_out up.",
    )
    integ_r: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    integ_r_ave: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class ConverterDir1dStruct(pydantic.BaseModel):
    """
    ConverterDir1dStruct corresponds to bmad `converter_dir_1D_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1241.

    Attributes
    ----------
    pc_out : float
        pc_out value at fit
        Bmad type: real
        Fortran default: 0
    poly : float
        param(r) = Sum: poly(i) * r^i
        Bmad type: real
        Fortran default: 0
    """

    pc_out: float = pydantic.Field(
        default=0,
        description="pc_out value at fit",
    )
    poly: Sequence[float] = pydantic.Field(
        default=0,
        description="param(r) = Sum: poly(i) * r^i",
    )


class ConverterDir2dStruct(pydantic.BaseModel):
    """
    ConverterDir2dStruct corresponds to bmad `converter_dir_2D_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1246.

    Attributes
    ----------
    k : float
        Bmad type: real
        Fortran default: 0
    poly : float
        Bmad type: real
        Fortran default: 0
    """

    k: float = pydantic.Field(
        default=0,
    )
    poly: Sequence[float] = pydantic.Field(
        default=0,
    )


class ConverterDirCoefStruct(pydantic.BaseModel):
    """
    ConverterDirCoefStruct corresponds to bmad `converter_dir_coef_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1251.

    Attributes
    ----------
    fit_1d_r : ConverterDir1dStruct
        Bmad type: type
    fit_2d_r : ConverterDir2dStruct
        Bmad type: type
    fit_2d_pc : ConverterDir2dStruct
        Bmad type: type
    c0 : float
        Bmad type: real
        Fortran default: 0
    """

    fit_1d_r: Sequence[ConverterDir1dStruct] = pydantic.Field(
        default=None,
    )
    fit_2d_r: ConverterDir2dStruct = pydantic.Field(
        default=None,
    )
    fit_2d_pc: ConverterDir2dStruct = pydantic.Field(
        default=None,
    )
    c0: float = pydantic.Field(
        default=0,
    )


class ConverterDirectionOutStruct(pydantic.BaseModel):
    """
    ConverterDirectionOutStruct corresponds to bmad `converter_direction_out_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1258.

    Attributes
    ----------
    beta : ConverterDirCoefStruct
        Bmad type: type
    alpha_x : ConverterDirCoefStruct
        Bmad type: type
    alpha_y : ConverterDirCoefStruct
        Bmad type: type
    dxds_min : ConverterDirCoefStruct
        Bmad type: type
    dxds_max : ConverterDirCoefStruct
        Bmad type: type
    dyds_max : ConverterDirCoefStruct
        Bmad type: type
    c_x : ConverterDirCoefStruct
        Bmad type: type
    """

    beta: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    alpha_x: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    alpha_y: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    dxds_min: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    dxds_max: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    dyds_max: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    c_x: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )


class ConverterSubDistributionStruct(pydantic.BaseModel):
    """
    ConverterSubDistributionStruct corresponds to bmad `converter_sub_distribution_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1267.

    Attributes
    ----------
    pc_in : float
        Bmad type: real
        Fortran default: -1
    spin_in : float
        Bmad type: real
    prob_pc_r : ConverterProbPcRStruct
        Bmad type: type
    dir_out : ConverterDirectionOutStruct
        Bmad type: type
    """

    pc_in: float = pydantic.Field(
        default=-1,
    )
    spin_in: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    prob_pc_r: ConverterProbPcRStruct = pydantic.Field(
        default=None,
    )
    dir_out: ConverterDirectionOutStruct = pydantic.Field(
        default=None,
    )


class MaterialStruct(pydantic.BaseModel):
    """
    MaterialStruct corresponds to bmad `material_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1276.

    Attributes
    ----------
    species : int
        Bmad type: integer
        Fortran default: not_set$
    number : int
        Relative number
        Bmad type: integer
        Fortran default: int_garbage$
    density : float
        Bmad type: real
        Fortran default: real_garbage$
    density_used : float
        Bmad type: real
        Fortran default: real_garbage$
    area_density : float
        Bmad type: real
        Fortran default: real_garbage$
    area_density_used : float
        Bmad type: real
        Fortran default: real_garbage$
    radiation_length : float
        Bmad type: real
        Fortran default: real_garbage$
    radiation_length_used : float
        Bmad type: real
        Fortran default: real_garbage$
    """

    species: int = pydantic.Field(
        default=0,
    )
    number: int = pydantic.Field(
        default=0,
        description="Relative number",
    )
    density: float = pydantic.Field(
        default=0.0,
    )
    density_used: float = pydantic.Field(
        default=0.0,
    )
    area_density: float = pydantic.Field(
        default=0.0,
    )
    area_density_used: float = pydantic.Field(
        default=0.0,
    )
    radiation_length: float = pydantic.Field(
        default=0.0,
    )
    radiation_length_used: float = pydantic.Field(
        default=0.0,
    )


class FoilStruct(pydantic.BaseModel):
    """
    FoilStruct corresponds to bmad `foil_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1284.

    Attributes
    ----------
    material : MaterialStruct
        Bmad type: type
    """

    material: Sequence[MaterialStruct] = pydantic.Field(
        default=None,
    )


class ConverterDistributionStruct(pydantic.BaseModel):
    """
    ConverterDistributionStruct corresponds to bmad `converter_distribution_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1290.

    Attributes
    ----------
    thickness : float
        Bmad type: real
        Fortran default: -1
    sub_dist : ConverterSubDistributionStruct
        Distribution at various pc_in values.
        Bmad type: type
    """

    thickness: float = pydantic.Field(
        default=-1,
    )
    sub_dist: Sequence[ConverterSubDistributionStruct] = pydantic.Field(
        default=None,
        description="Distribution at various pc_in values.",
    )


class ConverterStruct(pydantic.BaseModel):
    """
    ConverterStruct corresponds to bmad `converter_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1298.

    Attributes
    ----------
    species_out : int
        Output species
        Bmad type: integer
        Fortran default: 0
    material_type : str
        Bmad type: character
        Fortran default: ''
    dist : ConverterDistributionStruct
        Distribution at various thicknesses
        Bmad type: type
    """

    species_out: int = pydantic.Field(
        default=0,
        description="Output species",
    )
    material_type: str = pydantic.Field(
        default="",
        max_length=40,
    )
    dist: Sequence[ConverterDistributionStruct] = pydantic.Field(
        default=None,
        description="Distribution at various thicknesses",
    )


class ControlStruct(pydantic.BaseModel):
    """
    ControlStruct corresponds to bmad `control_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1308.

    Attributes
    ----------
    value : float
        Used by group, and overlay elements.
        Bmad type: real
        Fortran default: 0
    y_knot : float
        Bmad type: real
    stack : ExpressionAtomStruct
        Evaluation stack
        Bmad type: type
    slave : LatEleLocStruct
        Bmad type: type
        Fortran default: lat_ele_loc_struct()
    lord : LatEleLocStruct
        Bmad type: type
        Fortran default: lat_ele_loc_struct()
    slave_name : str
        Name of slave.
        Bmad type: character
        Fortran default: ''
    attribute : str
        Name of attribute controlled. Set to "FIELD_OVERLAPS" for field overlaps.
        Bmad type: character
        Fortran default: ''
    ix_attrib : int
        Index of attribute controlled. See note above!
        Bmad type: integer
        Fortran default: -1
    """

    value: float = pydantic.Field(
        default=0,
        description="Used by group, and overlay elements.",
    )
    y_knot: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    stack: Sequence[ExpressionAtomStruct] = pydantic.Field(
        default=None,
        description="Evaluation stack",
    )
    slave: LatEleLocStruct = pydantic.Field(
        default=None,
    )
    lord: LatEleLocStruct = pydantic.Field(
        default=None,
    )
    slave_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of slave.",
    )
    attribute: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps.",
    )
    ix_attrib: int = pydantic.Field(
        default=-1,
        description="Index of attribute controlled. See note above!",
    )


class ControlVar1Struct(pydantic.BaseModel):
    """
    ControlVar1Struct corresponds to bmad `control_var1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1320.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    value : float
        Bmad type: real
        Fortran default: 0
    old_value : float
        Bmad type: real
        Fortran default: 0
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    value: float = pydantic.Field(
        default=0,
    )
    old_value: float = pydantic.Field(
        default=0,
    )


class ControlRamp1Struct(pydantic.BaseModel):
    """
    ControlRamp1Struct corresponds to bmad `control_ramp1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1326.

    Attributes
    ----------
    y_knot : float
        Bmad type: real
    stack : ExpressionAtomStruct
        Evaluation stack
        Bmad type: type
    attribute : str
        Name of attribute controlled. Set to "FIELD_OVERLAPS" for field overlaps.
        Bmad type: character
        Fortran default: ''
    slave_name : str
        Name of slave.
        Bmad type: character
        Fortran default: ''
    is_controller : bool
        Is the slave a controller? If so bookkeeping is different.
        Bmad type: logical
        Fortran default: .false.
    """

    y_knot: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    stack: Sequence[ExpressionAtomStruct] = pydantic.Field(
        default=None,
        description="Evaluation stack",
    )
    attribute: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps.",
    )
    slave_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of slave.",
    )
    is_controller: bool = pydantic.Field(
        default=False,
        description="Is the slave a controller? If so bookkeeping is different.",
    )


class RamperLordStruct(pydantic.BaseModel):
    """
    RamperLordStruct corresponds to bmad `ramper_lord_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1337.

    Attributes
    ----------
    ix_ele : int
        Lord index
        Bmad type: integer
        Fortran default: 0
    ix_con : int
        Index in lord%control%ramp(:) array
        Bmad type: integer
        Fortran default: 0
    attrib_ptr : float
        Pointer to attribute in this element.
        Bmad type: real
        Fortran default: null()
    """

    ix_ele: int = pydantic.Field(
        default=0,
        description="Lord index",
    )
    ix_con: int = pydantic.Field(
        default=0,
        description="Index in lord%control%ramp(:) array",
    )
    attrib_ptr: float = pydantic.Field(
        default=0.0,
        description="Pointer to attribute in this element.",
    )


class ControllerStruct(pydantic.BaseModel):
    """
    ControllerStruct corresponds to bmad `controller_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1343.

    Attributes
    ----------
    var : ControlVar1Struct
        Bmad type: type
    ramp : ControlRamp1Struct
        For ramper lord elements
        Bmad type: type
    ramper_lord : RamperLordStruct
        Ramper lord info for this slave
        Bmad type: type
    x_knot : float
        Bmad type: real
    """

    var: Sequence[ControlVar1Struct] = pydantic.Field(
        default=None,
    )
    ramp: Sequence[ControlRamp1Struct] = pydantic.Field(
        default=None,
        description="For ramper lord elements",
    )
    ramper_lord: Sequence[RamperLordStruct] = pydantic.Field(
        default=None,
        description="Ramper lord info for this slave",
    )
    x_knot: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class EleStruct(pydantic.BaseModel):
    """
    EleStruct corresponds to bmad `ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1368.

    Attributes
    ----------
    name : str
        name of element.
        Bmad type: character
        Fortran default: '<Initialized>'
    type : str
        type name.
        Bmad type: character
        Fortran default: ''
    alias : str
        Another name.
        Bmad type: character
        Fortran default: ''
    component_name : str
        Used by overlays, multipass patch, etc.
        Bmad type: character
        Fortran default: ''
    descrip : str
        Description string.
        Bmad type: character
        Fortran default: null()
    a : TwissStruct
        Twiss parameters at end of element
        Bmad type: type
        Fortran default: twiss_struct()
    b : TwissStruct
        Twiss parameters at end of element
        Bmad type: type
        Fortran default: twiss_struct()
    z : TwissStruct
        Twiss parameters at end of element
        Bmad type: type
        Fortran default: twiss_struct()
    x : XyDispStruct
        Projected dispersions.
        Bmad type: type
        Fortran default: xy_disp_struct()
    y : XyDispStruct
        Projected dispersions.
        Bmad type: type
        Fortran default: xy_disp_struct()
    ac_kick : AcKickerStruct
        ac_kicker element parameters.
        Bmad type: type
        Fortran default: null()
    bookkeeping_state : BookkeepingStateStruct
        Attribute bookkeeping
        Bmad type: type
        Fortran default: bookkeeping_state_struct()
    branch : BranchStruct
        Pointer to branch containing element.
        Bmad type: type
        Fortran default: null()
    control : ControllerStruct
        group & overlay variables.
        Bmad type: type
        Fortran default: null()
    converter : ConverterStruct
        EG: Positron converter in linac.
        Bmad type: type
        Fortran default: null()
    foil : FoilStruct
        Bmad type: type
        Fortran default: null()
    lord : EleStruct
        Pointer to a slice lord.
        Bmad type: type
        Fortran default: null()
    ptc_fibre : Fibre
        PTC track corresponding to this ele.
        Bmad type: type
        Fortran default: null()
    floor : FloorPositionStruct
        Bmad type: type
        Fortran default: floor_position_struct(vec3_zero$, mat3_unit$, 0.0_rp, 0.0_rp, 0.0_rp)
    high_energy_space_charge : HighEnergySpaceChargeStruct
        Bmad type: type
        Fortran default: null()
    mode3 : Mode3Struct
        6D normal mode structure.
        Bmad type: type
        Fortran default: null()
    photon : PhotonElementStruct
        Bmad type: type
        Fortran default: null()
    multipole_cache : MultipoleCacheStruct
        Bmad type: type
    rad_map : RadMapEleStruct
        Radiation kick parameters
        Bmad type: type
        Fortran default: null()
    taylor : TaylorStruct
        Phase space Taylor map.
        Bmad type: type
        Fortran default: taylor_struct()
    spin_taylor_ref_orb_in : float
        Bmad type: real
        Fortran default: real_garbage$
    spin_taylor : TaylorStruct
        Quaternion Spin Taylor map.
        Bmad type: type
        Fortran default: taylor_struct()
    wake : WakeStruct
        Wakes
        Bmad type: type
        Fortran default: null()
    wall3d : Wall3dStruct
        Chamber or capillary wall
        Bmad type: type
        Fortran default: null()
    cartesian_map : CartesianMapStruct
        Used to define E/M fields
        Bmad type: type
        Fortran default: null()
    cylindrical_map : CylindricalMapStruct
        Used to define E/M fields
        Bmad type: type
        Fortran default: null()
    gen_grad_map : GenGradMapStruct
        Used to define E/M fields.
        Bmad type: type
        Fortran default: null()
    grid_field : GridFieldStruct
        Used to define E/M fields.
        Bmad type: type
        Fortran default: null()
    map_ref_orb_in : CoordStruct
        Entrance end transfer map ref orbit
        Bmad type: type
        Fortran default: coord_struct()
    map_ref_orb_out : CoordStruct
        Exit end transfer map ref orbit
        Bmad type: type
        Fortran default: coord_struct()
    time_ref_orb_in : CoordStruct
        Reference orbit at entrance end for ref_time calc.
        Bmad type: type
        Fortran default: coord_struct()
    time_ref_orb_out : CoordStruct
        Reference orbit at exit end for ref_time calc.
        Bmad type: type
        Fortran default: coord_struct()
    value : float
        attribute values.
        Bmad type: real
        Fortran default: 0
    old_value : float
        Used to see if %value(:) array has changed.
        Bmad type: real
        Fortran default: 0
    spin_q : float
        0th and 1st order Spin transport quaternion.
        Bmad type: real
        Fortran default: real_garbage$
    vec0 : float
        0th order transport vector.
        Bmad type: real
        Fortran default: 0
    mat6 : float
        1st order transport matrix.
        Bmad type: real
        Fortran default: 0
    c_mat : float
        2x2 C coupling matrix
        Bmad type: real
        Fortran default: 0
    gamma_c : float
        gamma associated with C matrix
        Bmad type: real
        Fortran default: 1
    s_start : float
        longitudinal ref position at entrance_end
        Bmad type: real
        Fortran default: 0
    s : float
        longitudinal ref position at the exit end.
        Bmad type: real
        Fortran default: 0
    ref_time : float
        Time ref particle passes exit end.
        Bmad type: real
        Fortran default: 0
    a_pole : float
        knl for multipole elements.
        Bmad type: real
        Fortran default: null()
    b_pole : float
        tilt for multipole elements.
        Bmad type: real
        Fortran default: null()
    a_pole_elec : float
        Electrostatic multipoles. ksnl for multipole elements.
        Bmad type: real
        Fortran default: null()
    b_pole_elec : float
        Electrostatic multipoles.
        Bmad type: real
        Fortran default: null()
    custom : float
        Custom attributes.
        Bmad type: real
        Fortran default: null()
    r : float
        For general use. Not used by Bmad.
        Bmad type: real
        Fortran default: null()
    key : int
        Element class (quadrupole, etc.).
        Bmad type: integer
        Fortran default: 0
    sub_key : int
        Records bend input type.
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Index in branch ele(0:) array. Set to ix_slice_slave$ = -2 for slice_slave$
        elements.
        Bmad type: integer
        Fortran default: -1
    ix_branch : int
        Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).
        Bmad type: integer
        Fortran default: 0
    lord_status : int
        Type of lord element this is. overlay_lord$, etc.
        Bmad type: integer
        Fortran default: not_a_lord$
    n_slave : int
        Number of slaves (except field overlap slaves) of this element.
        Bmad type: integer
        Fortran default: 0
    n_slave_field : int
        Number of field slaves of this element.
        Bmad type: integer
        Fortran default: 0
    ix1_slave : int
        Pointer index to this element's slaves.
        Bmad type: integer
        Fortran default: 0
    slave_status : int
        Type of slave element this is. multipass_slave$, slice_slave$, etc.
        Bmad type: integer
        Fortran default: free$
    n_lord : int
        Number of lords (except field overlap and ramper lords).
        Bmad type: integer
        Fortran default: 0
    n_lord_field : int
        Number of field lords of this element.
        Bmad type: integer
        Fortran default: 0
    n_lord_ramper : int
        Number of ramper lords.
        Bmad type: integer
        Fortran default: 0
    ic1_lord : int
        Pointer index to this element's lords.
        Bmad type: integer
        Fortran default: 0
    ix_pointer : int
        For general use. Not used by Bmad.
        Bmad type: integer
        Fortran default: 0
    ixx : int
        Index for Bmad internal use.
        Bmad type: integer
        Fortran default: 0
    iyy : int
        Index for Bmad internal use.
        Bmad type: integer
        Fortran default: 0
    izz : int
        Index for Bmad internal use.
        Bmad type: integer
        Fortran default: 0
    mat6_calc_method : int
        taylor$, symp_lie_ptc$, etc.
        Bmad type: integer
        Fortran default: bmad_standard$
    tracking_method : int
        taylor$, linear$, etc.
        Bmad type: integer
        Fortran default: bmad_standard$
    spin_tracking_method : int
        symp_lie_ptc$, etc.
        Bmad type: integer
        Fortran default: tracking$
    csr_method : int
        or one_dim$ ("1_dim"), steady_state_3d$
        Bmad type: integer
        Fortran default: off$
    space_charge_method : int
        slice$, slice_longitudinal$, slice_transverse$, fft_3D$, cathode_fft_3d$
        Bmad type: integer
        Fortran default: off$
    ptc_integration_type : int
        drift_kick$, matrix_kick$, or ripken_kick$
        Bmad type: integer
        Fortran default: matrix_kick$
    field_calc : int
        no_field$, fieldmap$, refer_to_lords$, or custom$
        Bmad type: integer
        Fortran default: bmad_standard$
    aperture_at : int
        Aperture location: entrance_end$, ...
        Bmad type: integer
        Fortran default: exit_end$
    aperture_type : int
        rectangular$, elliptical$, auto_aperture$, ...
        Bmad type: integer
        Fortran default: rectangular$
    ref_species : int
        Reference species
        Bmad type: integer
        Fortran default: not_set$
    orientation : int
        -1 -> Element is longitudinally reversed. +1 -> Normal.
        Bmad type: integer
        Fortran default: 1
    symplectify : bool
        Symplectify mat6 matrices.
        Bmad type: logical
        Fortran default: .false.
    mode_flip : bool
        Have the normal modes traded places?
        Bmad type: logical
        Fortran default: .false.
    multipoles_on : bool
        For turning multipoles on/off
        Bmad type: logical
        Fortran default: .true.
    scale_multipoles : bool
        Are ab_multipoles within other elements (EG: quads, etc.)
        Bmad type: logical
        Fortran default: .true.
    taylor_map_includes_offsets : bool
        Taylor map calculated with element misalignments?
        Bmad type: logical
        Fortran default: .true.
    field_master : bool
        Calculate strength from the field value?
        Bmad type: logical
        Fortran default: .false.
    is_on : bool
        For turning element on/off.
        Bmad type: logical
        Fortran default: .true.
    logic : bool
        For general use. Not used by Bmad (except during lattice parsing).
        Bmad type: logical
        Fortran default: .false.
    bmad_logic : bool
        For Bmad internal use only.
        Bmad type: logical
        Fortran default: .false.
    select : bool
        For Bmad internal use only.
        Bmad type: logical
        Fortran default: .false.
    offset_moves_aperture : bool
        element offsets affects aperture?
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="<Initialized>",
        max_length=40,
        description="name of element.",
    )
    type: str = pydantic.Field(
        default="",
        max_length=40,
        description="type name.",
    )
    alias: str = pydantic.Field(
        default="",
        max_length=40,
        description="Another name.",
    )
    component_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Used by overlays, multipass patch, etc.",
    )
    descrip: str = pydantic.Field(
        default_factory=list,
        max_length=200,
        description="Description string.",
    )
    a: TwissStruct = pydantic.Field(
        default=None,
        description="Twiss parameters at end of element",
    )
    b: TwissStruct = pydantic.Field(
        default=None,
        description="Twiss parameters at end of element",
    )
    z: TwissStruct = pydantic.Field(
        default=None,
        description="Twiss parameters at end of element",
    )
    x: XyDispStruct = pydantic.Field(
        default=None,
        description="Projected dispersions.",
    )
    y: XyDispStruct = pydantic.Field(
        default=None,
        description="Projected dispersions.",
    )
    ac_kick: AcKickerStruct = pydantic.Field(
        default=None,
        description="ac_kicker element parameters.",
    )
    bookkeeping_state: BookkeepingStateStruct = pydantic.Field(
        default=None,
        description="Attribute bookkeeping",
    )
    branch: BranchStruct = pydantic.Field(
        default=None,
        description="Pointer to branch containing element.",
    )
    control: ControllerStruct = pydantic.Field(
        default=None,
        description="group & overlay variables.",
    )
    converter: ConverterStruct = pydantic.Field(
        default=None,
        description="EG: Positron converter in linac.",
    )
    foil: FoilStruct = pydantic.Field(
        default=None,
    )
    lord: EleStruct = pydantic.Field(
        default=None,
        description="Pointer to a slice lord.",
    )
    ptc_fibre: Fibre = pydantic.Field(
        default=None,
        description="PTC track corresponding to this ele.",
    )
    floor: FloorPositionStruct = pydantic.Field(
        default=None,
    )
    high_energy_space_charge: HighEnergySpaceChargeStruct = pydantic.Field(
        default=None,
    )
    mode3: Mode3Struct = pydantic.Field(
        default=None,
        description="6D normal mode structure.",
    )
    photon: PhotonElementStruct = pydantic.Field(
        default=None,
    )
    multipole_cache: MultipoleCacheStruct = pydantic.Field(
        default=None,
    )
    rad_map: RadMapEleStruct = pydantic.Field(
        default=None,
        description="Radiation kick parameters",
    )
    taylor: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="Phase space Taylor map.",
    )
    spin_taylor_ref_orb_in: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )
    spin_taylor: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        description="Quaternion Spin Taylor map.",
    )
    wake: WakeStruct = pydantic.Field(
        default=None,
        description="Wakes",
    )
    wall3d: Sequence[Wall3dStruct] = pydantic.Field(
        default=None,
        description="Chamber or capillary wall",
    )
    cartesian_map: Sequence[CartesianMapStruct] = pydantic.Field(
        default=None,
        description="Used to define E/M fields",
    )
    cylindrical_map: Sequence[CylindricalMapStruct] = pydantic.Field(
        default=None,
        description="Used to define E/M fields",
    )
    gen_grad_map: Sequence[GenGradMapStruct] = pydantic.Field(
        default=None,
        description="Used to define E/M fields.",
    )
    grid_field: Sequence[GridFieldStruct] = pydantic.Field(
        default=None,
        description="Used to define E/M fields.",
    )
    map_ref_orb_in: CoordStruct = pydantic.Field(
        default=None,
        description="Entrance end transfer map ref orbit",
    )
    map_ref_orb_out: CoordStruct = pydantic.Field(
        default=None,
        description="Exit end transfer map ref orbit",
    )
    time_ref_orb_in: CoordStruct = pydantic.Field(
        default=None,
        description="Reference orbit at entrance end for ref_time calc.",
    )
    time_ref_orb_out: CoordStruct = pydantic.Field(
        default=None,
        description="Reference orbit at exit end for ref_time calc.",
    )
    value: Sequence[float] = pydantic.Field(
        default=0,
        description="attribute values.",
    )
    old_value: Sequence[float] = pydantic.Field(
        default=0,
        description="Used to see if %value(:) array has changed.",
    )
    spin_q: Sequence[float] = pydantic.Field(
        default=0.0,
        description="0th and 1st order Spin transport quaternion.",
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="0th order transport vector.",
    )
    mat6: Sequence[float] = pydantic.Field(
        default=0,
        description="1st order transport matrix.",
    )
    c_mat: Sequence[float] = pydantic.Field(
        default=0,
        description="2x2 C coupling matrix",
    )
    gamma_c: float = pydantic.Field(
        default=1,
        description="gamma associated with C matrix",
    )
    s_start: float = pydantic.Field(
        default=0,
        description="longitudinal ref position at entrance_end",
    )
    s: float = pydantic.Field(
        default=0,
        description="longitudinal ref position at the exit end.",
    )
    ref_time: float = pydantic.Field(
        default=0,
        description="Time ref particle passes exit end.",
    )
    a_pole: Sequence[float] = pydantic.Field(
        default=0.0,
        description="knl for multipole elements.",
    )
    b_pole: Sequence[float] = pydantic.Field(
        default=0.0,
        description="tilt for multipole elements.",
    )
    a_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Electrostatic multipoles. ksnl for multipole elements.",
    )
    b_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Electrostatic multipoles.",
    )
    custom: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Custom attributes.",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        description="For general use. Not used by Bmad.",
    )
    key: int = pydantic.Field(
        default=0,
        description="Element class (quadrupole, etc.).",
    )
    sub_key: int = pydantic.Field(
        default=0,
        description="Records bend input type.",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description=(
            "Index in branch ele(0:) array. Set to ix_slice_slave$ = -2 for "
            "slice_slave$ elements."
        ),
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description="Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).",
    )
    lord_status: int = pydantic.Field(
        default=0,
        description="Type of lord element this is. overlay_lord$, etc.",
    )
    n_slave: int = pydantic.Field(
        default=0,
        description="Number of slaves (except field overlap slaves) of this element.",
    )
    n_slave_field: int = pydantic.Field(
        default=0,
        description="Number of field slaves of this element.",
    )
    ix1_slave: int = pydantic.Field(
        default=0,
        description="Pointer index to this element's slaves.",
    )
    slave_status: int = pydantic.Field(
        default=0,
        description="Type of slave element this is. multipass_slave$, slice_slave$, etc.",
    )
    n_lord: int = pydantic.Field(
        default=0,
        description="Number of lords (except field overlap and ramper lords).",
    )
    n_lord_field: int = pydantic.Field(
        default=0,
        description="Number of field lords of this element.",
    )
    n_lord_ramper: int = pydantic.Field(
        default=0,
        description="Number of ramper lords.",
    )
    ic1_lord: int = pydantic.Field(
        default=0,
        description="Pointer index to this element's lords.",
    )
    ix_pointer: int = pydantic.Field(
        default=0,
        description="For general use. Not used by Bmad.",
    )
    ixx: int = pydantic.Field(
        default=0,
        description="Index for Bmad internal use.",
    )
    iyy: int = pydantic.Field(
        default=0,
        description="Index for Bmad internal use.",
    )
    izz: int = pydantic.Field(
        default=0,
        description="Index for Bmad internal use.",
    )
    mat6_calc_method: int = pydantic.Field(
        default=0,
        description="taylor$, symp_lie_ptc$, etc.",
    )
    tracking_method: int = pydantic.Field(
        default=0,
        description="taylor$, linear$, etc.",
    )
    spin_tracking_method: int = pydantic.Field(
        default=0,
        description="symp_lie_ptc$, etc.",
    )
    csr_method: int = pydantic.Field(
        default=0,
        description="or one_dim$ ('1_dim'), steady_state_3d$",
    )
    space_charge_method: int = pydantic.Field(
        default=0,
        description="slice$, slice_longitudinal$, slice_transverse$, fft_3D$, cathode_fft_3d$",
    )
    ptc_integration_type: int = pydantic.Field(
        default=0,
        description="drift_kick$, matrix_kick$, or ripken_kick$",
    )
    field_calc: int = pydantic.Field(
        default=0,
        description="no_field$, fieldmap$, refer_to_lords$, or custom$",
    )
    aperture_at: int = pydantic.Field(
        default=0,
        description="Aperture location: entrance_end$, ...",
    )
    aperture_type: int = pydantic.Field(
        default=0,
        description="rectangular$, elliptical$, auto_aperture$, ...",
    )
    ref_species: int = pydantic.Field(
        default=0,
        description="Reference species",
    )
    orientation: int = pydantic.Field(
        default=1,
        description="-1 -> Element is longitudinally reversed. +1 -> Normal.",
    )
    symplectify: bool = pydantic.Field(
        default=False,
        description="Symplectify mat6 matrices.",
    )
    mode_flip: bool = pydantic.Field(
        default=False,
        description="Have the normal modes traded places?",
    )
    multipoles_on: bool = pydantic.Field(
        default=True,
        description="For turning multipoles on/off",
    )
    scale_multipoles: bool = pydantic.Field(
        default=True,
        description="Are ab_multipoles within other elements (EG: quads, etc.)",
    )
    taylor_map_includes_offsets: bool = pydantic.Field(
        default=True,
        description="Taylor map calculated with element misalignments?",
    )
    field_master: bool = pydantic.Field(
        default=False,
        description="Calculate strength from the field value?",
    )
    is_on: bool = pydantic.Field(
        default=True,
        description="For turning element on/off.",
    )
    logic: bool = pydantic.Field(
        default=False,
        description="For general use. Not used by Bmad (except during lattice parsing).",
    )
    bmad_logic: bool = pydantic.Field(
        default=False,
        description="For Bmad internal use only.",
    )
    select: bool = pydantic.Field(
        default=False,
        description="For Bmad internal use only.",
    )
    offset_moves_aperture: bool = pydantic.Field(
        default=False,
        description="element offsets affects aperture?",
    )


class LatParamStruct(pydantic.BaseModel):
    """
    LatParamStruct corresponds to bmad `lat_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1474.

    Attributes
    ----------
    n_part : float
        Particles/bunch (for BeamBeam elements).
        Bmad type: real
        Fortran default: 0
    total_length : float
        total_length of branch. Warning: branch may not start at s = 0.
        Bmad type: real
        Fortran default: 0
    unstable_factor : float
        If positive: Growth rate/turn if unstable in closed branches or
        Bmad type: real
        Fortran default: 0
    t1_with_rf : float
        Full 1-turn matrix with RF on.
        Bmad type: real
        Fortran default: 0
    t1_no_rf : float
        Full 1-turn matrix with RF off.
        Bmad type: real
        Fortran default: 0
    spin_tune : float
        Closed orbit spin tune.
        Bmad type: real
        Fortran default: 0
    particle : int
        Reference particle: positron$, electron$, etc.
        Bmad type: integer
        Fortran default: not_set$
    default_tracking_species : int
        Default particle type to use in tracking.
        Bmad type: integer
        Fortran default: ref_particle$
    geometry : int
        open$ or closed$
        Bmad type: integer
        Fortran default: 0
    ixx : int
        Integer for general use
        Bmad type: integer
        Fortran default: 0
    stable : bool
        is closed lat stable?
        Bmad type: logical
        Fortran default: .false.
    live_branch : bool
        Should tracking be done on the branch?
        Bmad type: logical
        Fortran default: .true.
    g1_integral : float
        Approximate |g| (bending strength) integral of branch.
        Bmad type: real
        Fortran default: -1
    g2_integral : float
        Approximate g^2 integral of branch.
        Bmad type: real
        Fortran default: -1
    g3_integral : float
        Approximate g^2 integral of branch.
        Bmad type: real
        Fortran default: -1
    bookkeeping_state : BookkeepingStateStruct
        Bmad type: type
        Fortran default: bookkeeping_state_struct()
    beam_init : BeamInitStruct
        For beam initialization.
        Bmad type: type
        Fortran default: beam_init_struct()
    """

    n_part: float = pydantic.Field(
        default=0,
        description="Particles/bunch (for BeamBeam elements).",
    )
    total_length: float = pydantic.Field(
        default=0,
        description="total_length of branch. Warning: branch may not start at s = 0.",
    )
    unstable_factor: float = pydantic.Field(
        default=0,
        description="If positive: Growth rate/turn if unstable in closed branches or",
    )
    t1_with_rf: Sequence[float] = pydantic.Field(
        default=0,
        description="Full 1-turn matrix with RF on.",
        validation_alias=pydantic.AliasChoices("t1_with_rf", "t1_with_RF"),
        serialization_alias="t1_with_RF",
    )
    t1_no_rf: Sequence[float] = pydantic.Field(
        default=0,
        description="Full 1-turn matrix with RF off.",
        validation_alias=pydantic.AliasChoices("t1_no_rf", "t1_no_RF"),
        serialization_alias="t1_no_RF",
    )
    spin_tune: float = pydantic.Field(
        default=0,
        description="Closed orbit spin tune.",
    )
    particle: int = pydantic.Field(
        default=0,
        description="Reference particle: positron$, electron$, etc.",
    )
    default_tracking_species: int = pydantic.Field(
        default=0,
        description="Default particle type to use in tracking.",
    )
    geometry: int = pydantic.Field(
        default=0,
        description="open$ or closed$",
    )
    ixx: int = pydantic.Field(
        default=0,
        description="Integer for general use",
    )
    stable: bool = pydantic.Field(
        default=False,
        description="is closed lat stable?",
    )
    live_branch: bool = pydantic.Field(
        default=True,
        description="Should tracking be done on the branch?",
    )
    g1_integral: float = pydantic.Field(
        default=-1,
        description="Approximate |g| (bending strength) integral of branch.",
    )
    g2_integral: float = pydantic.Field(
        default=-1,
        description="Approximate g^2 integral of branch.",
    )
    g3_integral: float = pydantic.Field(
        default=-1,
        description="Approximate g^2 integral of branch.",
    )
    bookkeeping_state: BookkeepingStateStruct = pydantic.Field(
        default=None,
    )
    beam_init: BeamInitStruct = pydantic.Field(
        default=None,
        description="For beam initialization.",
    )


class PtcLayoutPointerStruct(pydantic.BaseModel):
    """
    PtcLayoutPointerStruct corresponds to bmad `ptc_layout_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1499.

    Attributes
    ----------
    ptr : Layout
        Bmad type: type
        Fortran default: null()
    """

    ptr: Layout = pydantic.Field(
        default=None,
    )


class PtcBranch1Struct(pydantic.BaseModel):
    """
    PtcBranch1Struct corresponds to bmad `ptc_branch1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1503.

    Attributes
    ----------
    m_u_layout : PtcLayoutPointerStruct
        Bmad type: type
    m_t_layout : Layout
        Tracking layout.
        Bmad type: type
        Fortran default: null()
    """

    m_u_layout: Sequence[PtcLayoutPointerStruct] = pydantic.Field(
        default=None,
    )
    m_t_layout: Layout = pydantic.Field(
        default=None,
        description="Tracking layout.",
    )


class ModeInfoStruct(pydantic.BaseModel):
    """
    ModeInfoStruct corresponds to bmad `mode_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1510.

    Attributes
    ----------
    stable : bool
        Is the mode stable?
        Bmad type: logical
        Fortran default: .false.
    tune : float
        "fractional" tune in radians
        Bmad type: real
        Fortran default: 0
    emit : float
        Emittance (unnormalized).
        Bmad type: real
        Fortran default: 0
    chrom : float
        Chromaticity.
        Bmad type: real
        Fortran default: 0
    sigma : float
        Beam size.
        Bmad type: real
        Fortran default: 0
    sigmap : float
        Beam divergence.
        Bmad type: real
        Fortran default: 0
    """

    stable: bool = pydantic.Field(
        default=False,
        description="Is the mode stable?",
    )
    tune: float = pydantic.Field(
        default=0,
        description="'fractional' tune in radians",
    )
    emit: float = pydantic.Field(
        default=0,
        description="Emittance (unnormalized).",
    )
    chrom: float = pydantic.Field(
        default=0,
        description="Chromaticity.",
    )
    sigma: float = pydantic.Field(
        default=0,
        description="Beam size.",
    )
    sigmap: float = pydantic.Field(
        default=0,
        description="Beam divergence.",
    )


class ResonanceHStruct(pydantic.BaseModel):
    """
    ResonanceHStruct corresponds to bmad `resonance_h_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1521.

    Attributes
    ----------
    id : str
        6 digit ID. EG: '003100'
        Bmad type: character
        Fortran default: ''
    c_val : Complex
        Resonance value
        Bmad type: complex
        Fortran default: 0
    """

    id: str = pydantic.Field(
        default="",
        max_length=6,
        description="6 digit ID. EG: '003100'",
    )
    c_val: Complex = pydantic.Field(
        default=0,
        description="Resonance value",
    )


class BmadNormalFormStruct(pydantic.BaseModel):
    """
    BmadNormalFormStruct corresponds to bmad `bmad_normal_form_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1531.

    Attributes
    ----------
    ele_origin : EleStruct
        Element at which the on-turn map was created.
        Bmad type: type
        Fortran default: null()
    m : TaylorStruct
        One-turn taylor map: M = A o N o A_inv, N = exp(:h:)
        Bmad type: type
        Fortran default: taylor_struct()
    a : TaylorStruct
        Map from Floquet -> Lab coordinates
        Bmad type: type
        Fortran default: taylor_struct()
    a_inv : TaylorStruct
        Map from Lab -> Floquet coordinates
        Bmad type: type
        Fortran default: taylor_struct()
    dhdj : TaylorStruct
        Nonlinear tune function operating on Floquet coordinates
        Bmad type: type
        Fortran default: taylor_struct()
    f : ComplexTaylorStruct
        Vector field factorization in phasor basis:
        Bmad type: type
        Fortran default: complex_taylor_struct()
    L : ComplexTaylorStruct
        L component
        Bmad type: type
        Fortran default: complex_taylor_struct()
    h : ResonanceHStruct
        Bmad type: type
    """

    ele_origin: EleStruct = pydantic.Field(
        default=None,
        description="Element at which the on-turn map was created.",
    )
    m: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="One-turn taylor map: M = A o N o A_inv, N = exp(:h:)",
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    a: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="Map from Floquet -> Lab coordinates",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    a_inv: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="Map from Lab -> Floquet coordinates",
        validation_alias=pydantic.AliasChoices("a_inv", "A_inv"),
        serialization_alias="A_inv",
    )
    dhdj: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="Nonlinear tune function operating on Floquet coordinates",
    )
    f: Sequence[ComplexTaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="Vector field factorization in phasor basis:",
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    L: Sequence[ComplexTaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="L component",
    )
    h: Sequence[ResonanceHStruct] = pydantic.Field(
        default=None,
    )


class PtcNormalFormStruct(pydantic.BaseModel):
    """
    PtcNormalFormStruct corresponds to bmad `ptc_normal_form_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1542.

    Attributes
    ----------
    ele_origin : EleStruct
        Element at which the on-turn map was created.
        Bmad type: type
        Fortran default: null()
    one_turn_map : Probe8
        One turn map
        Bmad type: type
    orb0 : float
        Closed orbit at element.
        Bmad type: real
    normal_form : CNormalForm
        Complex normal form
        Bmad type: type
    phase : CTaylor
        Phase/chromaticity maps
        Bmad type: type
    path_length : CTaylor
        Path length map. Gives momentum compaction.
        Bmad type: type
    spin_tune : CTaylor
        Amplitude dependent spin tune
        Bmad type: type
    isf : CQuaternion
        Invariant spin field in (x, px, ...) space.
        Bmad type: type
    state : InternalState
        PTC state
        Bmad type: type
    valid_map : bool
        Bmad type: logical
        Fortran default: .false.
    """

    ele_origin: EleStruct = pydantic.Field(
        default=None,
        description="Element at which the on-turn map was created.",
    )
    one_turn_map: Probe8 = pydantic.Field(
        default=None,
        description="One turn map",
    )
    orb0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="Closed orbit at element.",
    )
    normal_form: CNormalForm = pydantic.Field(
        default=None,
        description="Complex normal form",
    )
    phase: Sequence[CTaylor] = pydantic.Field(
        default=None,
        max_length=3,
        description="Phase/chromaticity maps",
    )
    path_length: CTaylor = pydantic.Field(
        default=None,
        description="Path length map. Gives momentum compaction.",
    )
    spin_tune: CTaylor = pydantic.Field(
        default=None,
        description="Amplitude dependent spin tune",
    )
    isf: CQuaternion = pydantic.Field(
        default=None,
        description="Invariant spin field in (x, px, ...) space.",
    )
    state: InternalState = pydantic.Field(
        default=None,
        description="PTC state",
    )
    valid_map: bool = pydantic.Field(
        default=False,
    )


class BranchStruct(pydantic.BaseModel):
    """
    BranchStruct corresponds to bmad `branch_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1557.

    Attributes
    ----------
    name : str
        Name of line that defines the branch.
        Bmad type: character
        Fortran default: ''
    ix_branch : int
        Index of this branch. 0 => Main branch
        Bmad type: integer
        Fortran default: -1
    ix_from_branch : int
        -1 => No creating fork element to this branch.
        Bmad type: integer
        Fortran default: -1
    ix_from_ele : int
        Index of creating fork element which forks to this branch.
        Bmad type: integer
        Fortran default: -1
    ix_to_ele : int
        Index of element in this branch that creating fork element forks to.
        Bmad type: integer
        Fortran default: -1
    n_ele_track : int
        Bmad type: integer
    n_ele_max : int
        Bmad type: integer
    lat : LatStruct
        Bmad type: type
        Fortran default: null()
    a : ModeInfoStruct
        Note: Tunes are the fractional part.
        Bmad type: type
    b : ModeInfoStruct
        Note: Tunes are the fractional part.
        Bmad type: type
    z : ModeInfoStruct
        Note: Tunes are the fractional part.
        Bmad type: type
    ele : EleStruct
        Bmad type: type
        Fortran default: null()
    param : LatParamStruct
        Bmad type: type
    wall3d : Wall3dStruct
        Bmad type: type
        Fortran default: null()
    ptc : PtcBranch1Struct
        Pointer to layout. Note: ptc info not transferred with "branch1 = branch2" set.
        Bmad type: type
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of line that defines the branch.",
    )
    ix_branch: int = pydantic.Field(
        default=-1,
        description="Index of this branch. 0 => Main branch",
    )
    ix_from_branch: int = pydantic.Field(
        default=-1,
        description="-1 => No creating fork element to this branch.",
    )
    ix_from_ele: int = pydantic.Field(
        default=-1,
        description="Index of creating fork element which forks to this branch.",
    )
    ix_to_ele: int = pydantic.Field(
        default=-1,
        description="Index of element in this branch that creating fork element forks to.",
    )
    n_ele_track: int = pydantic.Field(
        default=0,
    )
    n_ele_max: int = pydantic.Field(
        default=0,
    )
    lat: LatStruct = pydantic.Field(
        default=None,
    )
    a: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Note: Tunes are the fractional part.",
    )
    b: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Note: Tunes are the fractional part.",
    )
    z: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Note: Tunes are the fractional part.",
    )
    ele: Sequence[EleStruct] = pydantic.Field(
        default=None,
    )
    param: LatParamStruct = pydantic.Field(
        default=None,
    )
    wall3d: Sequence[Wall3dStruct] = pydantic.Field(
        default=None,
    )
    ptc: PtcBranch1Struct = pydantic.Field(
        default=None,
        description="Pointer to layout. Note: ptc info not transferred with 'branch1 = branch2' set.",
    )


class PreTrackerStruct(pydantic.BaseModel):
    """
    PreTrackerStruct corresponds to bmad `pre_tracker_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1576.

    Attributes
    ----------
    who : int
        Can be opal$, or impactt$
        Bmad type: integer
        Fortran default: 0
    ix_ele_start : int
        Bmad type: integer
        Fortran default: 0
    ix_ele_end : int
        Bmad type: integer
        Fortran default: 0
    input_file : str
        Bmad type: character
        Fortran default: ''
    """

    who: int = pydantic.Field(
        default=0,
        description="Can be opal$, or impactt$",
    )
    ix_ele_start: int = pydantic.Field(
        default=0,
    )
    ix_ele_end: int = pydantic.Field(
        default=0,
    )
    input_file: str = pydantic.Field(
        default="",
        max_length=400,
    )


class LatStruct(pydantic.BaseModel):
    """
    LatStruct corresponds to bmad `lat_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1592.

    Attributes
    ----------
    use_name : str
        Name of lat given by USE statement
        Bmad type: character
        Fortran default: ''
    lattice : str
        Lattice
        Bmad type: character
        Fortran default: ''
    machine : str
        Name of the machine the lattice is for ("LHC", etc).
        Bmad type: character
        Fortran default: ''
    input_file_name : str
        Name of the lattice input file
        Bmad type: character
        Fortran default: ''
    title : str
        General title
        Bmad type: character
        Fortran default: ''
    print_str : str
        Saved print statements.
        Bmad type: character
    constant : ExpressionAtomStruct
        Constants defined in the lattice
        Bmad type: type
    a : ModeInfoStruct
        Tunes (fractional part), etc.
        Bmad type: type
        Fortran default: null()
    b : ModeInfoStruct
        Tunes (fractional part), etc.
        Bmad type: type
        Fortran default: null()
    z : ModeInfoStruct
        Tunes (fractional part), etc.
        Bmad type: type
        Fortran default: null()
    param : LatParamStruct
        Parameters
        Bmad type: type
        Fortran default: null()
    lord_state : BookkeepingStateStruct
        lord bookkeeping status.
        Bmad type: type
    ele_init : EleStruct
        For use by any program
        Bmad type: type
    ele : EleStruct
        Array of elements [=> branch(0)].
        Bmad type: type
        Fortran default: null()
    branch : BranchStruct
        Branch(0:) array
        Bmad type: type
    control : ControlStruct
        Control list
        Bmad type: type
    particle_start : CoordStruct
        Starting particle_coords.
        Bmad type: type
    beam_init : BeamInitStruct
        Beam initialization.
        Bmad type: type
    pre_tracker : PreTrackerStruct
        For OPAL/IMPACT-T
        Bmad type: type
    nametable : NametableStruct
        For quick searching by element name.
        Bmad type: type
    custom : float
        Custom attributes.
        Bmad type: real
    version : int
        Version number
        Bmad type: integer
        Fortran default: -1
    n_ele_track : int
        Number of lat elements to track through.
        Bmad type: integer
        Fortran default: null()
    n_ele_max : int
        Index of last valid element in %ele(:) array
        Bmad type: integer
        Fortran default: null()
    n_control_max : int
        Last index used in control_array
        Bmad type: integer
        Fortran default: 0
    n_ic_max : int
        Last index used in ic_array
        Bmad type: integer
        Fortran default: 0
    input_taylor_order : int
        As set in the input file
        Bmad type: integer
        Fortran default: 0
    ic : int
        Index to %control(:) from slaves.
        Bmad type: integer
    photon_type : int
        Or coherent$. For X-ray simulations.
        Bmad type: integer
        Fortran default: incoherent$
    creation_hash : int
        Set by bmad_parser. creation_hash will vary if
        Bmad type: integer
        Fortran default: 0
    ramper_slave_bookkeeping : int
        Bmad type: integer
        Fortran default: stale$
    """

    use_name: str = pydantic.Field(
        default="",
        max_length=200,
        description="Name of lat given by USE statement",
    )
    lattice: str = pydantic.Field(
        default="",
        max_length=40,
        description="Lattice",
    )
    machine: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of the machine the lattice is for ('LHC', etc).",
    )
    input_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Name of the lattice input file",
    )
    title: str = pydantic.Field(
        default="",
        max_length=80,
        description="General title",
    )
    print_str: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=100,
        description="Saved print statements.",
    )
    constant: Sequence[ExpressionAtomStruct] = pydantic.Field(
        default=None,
        description="Constants defined in the lattice",
    )
    a: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Tunes (fractional part), etc.",
    )
    b: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Tunes (fractional part), etc.",
    )
    z: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Tunes (fractional part), etc.",
    )
    param: LatParamStruct = pydantic.Field(
        default=None,
        description="Parameters",
    )
    lord_state: BookkeepingStateStruct = pydantic.Field(
        default=None,
        description="lord bookkeeping status.",
    )
    ele_init: EleStruct = pydantic.Field(
        default=None,
        description="For use by any program",
    )
    ele: Sequence[EleStruct] = pydantic.Field(
        default=None,
        description="Array of elements [=> branch(0)].",
    )
    branch: Sequence[BranchStruct] = pydantic.Field(
        default=None,
        description="Branch(0:) array",
    )
    control: Sequence[ControlStruct] = pydantic.Field(
        default=None,
        description="Control list",
    )
    particle_start: CoordStruct = pydantic.Field(
        default=None,
        description="Starting particle_coords.",
    )
    beam_init: BeamInitStruct = pydantic.Field(
        default=None,
        description="Beam initialization.",
    )
    pre_tracker: PreTrackerStruct = pydantic.Field(
        default=None,
        description="For OPAL/IMPACT-T",
    )
    nametable: NametableStruct = pydantic.Field(
        default=None,
        description="For quick searching by element name.",
    )
    custom: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Custom attributes.",
    )
    version: int = pydantic.Field(
        default=-1,
        description="Version number",
    )
    n_ele_track: int = pydantic.Field(
        default=0,
        description="Number of lat elements to track through.",
    )
    n_ele_max: int = pydantic.Field(
        default=0,
        description="Index of last valid element in %ele(:) array",
    )
    n_control_max: int = pydantic.Field(
        default=0,
        description="Last index used in control_array",
    )
    n_ic_max: int = pydantic.Field(
        default=0,
        description="Last index used in ic_array",
    )
    input_taylor_order: int = pydantic.Field(
        default=0,
        description="As set in the input file",
    )
    ic: Sequence[int] = pydantic.Field(
        default=0,
        description="Index to %control(:) from slaves.",
    )
    photon_type: int = pydantic.Field(
        default=0,
        description="Or coherent$. For X-ray simulations.",
    )
    creation_hash: int = pydantic.Field(
        default=0,
        description="Set by bmad_parser. creation_hash will vary if",
    )
    ramper_slave_bookkeeping: int = pydantic.Field(
        default=0,
    )


class AnormalModeStruct(pydantic.BaseModel):
    """
    AnormalModeStruct corresponds to bmad `anormal_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1921.

    Attributes
    ----------
    emittance : float
        Beam emittance (unnormalized). Includes vertical photon opening angle.
        Bmad type: real
        Fortran default: 0
    emittance_no_vert : float
        Unnormalized beam emittance without the vertical photon opening angle taken
        into account.
        Bmad type: real
        Fortran default: 0
    synch_int : float
        Synchrotron integrals
        Bmad type: real
        Fortran default: 0
    j_damp : float
        damping partition number
        Bmad type: real
        Fortran default: 0
    alpha_damp : float
        damping per turn
        Bmad type: real
        Fortran default: 0
    chrom : float
        Chromaticity
        Bmad type: real
        Fortran default: 0
    tune : float
        "Fractional" tune in radians
        Bmad type: real
        Fortran default: 0
    """

    emittance: float = pydantic.Field(
        default=0,
        description="Beam emittance (unnormalized). Includes vertical photon opening angle.",
    )
    emittance_no_vert: float = pydantic.Field(
        default=0,
        description=(
            "Unnormalized beam emittance without the vertical photon opening angle "
            "taken into account."
        ),
    )
    synch_int: Sequence[float] = pydantic.Field(
        default=0,
        description="Synchrotron integrals",
    )
    j_damp: float = pydantic.Field(
        default=0,
        description="damping partition number",
    )
    alpha_damp: float = pydantic.Field(
        default=0,
        description="damping per turn",
    )
    chrom: float = pydantic.Field(
        default=0,
        description="Chromaticity",
    )
    tune: float = pydantic.Field(
        default=0,
        description="'Fractional' tune in radians",
    )


class LinacNormalModeStruct(pydantic.BaseModel):
    """
    LinacNormalModeStruct corresponds to bmad `linac_normal_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1931.

    Attributes
    ----------
    i2_e4 : float
        Integral: g^2 * gamma^4
        Bmad type: real
        Fortran default: 0
    i3_e7 : float
        Integral: g^3 * gamma^7
        Bmad type: real
        Fortran default: 0
    i5a_e6 : float
        Integral: (g^3 * H_a) * gamma^6
        Bmad type: real
        Fortran default: 0
    i5b_e6 : float
        Integral: (g^3 * H_b) * gamma^6
        Bmad type: real
        Fortran default: 0
    sig_e1 : float
        Energy spread after 1 pass (eV)
        Bmad type: real
        Fortran default: 0
    a_emittance_end : float
        a mode emittance at end of linac
        Bmad type: real
        Fortran default: 0
    b_emittance_end : float
        b mode emittance at end of linac
        Bmad type: real
        Fortran default: 0
    """

    i2_e4: float = pydantic.Field(
        default=0,
        description="Integral: g^2 * gamma^4",
        validation_alias=pydantic.AliasChoices("i2_e4", "i2_E4"),
        serialization_alias="i2_E4",
    )
    i3_e7: float = pydantic.Field(
        default=0,
        description="Integral: g^3 * gamma^7",
        validation_alias=pydantic.AliasChoices("i3_e7", "i3_E7"),
        serialization_alias="i3_E7",
    )
    i5a_e6: float = pydantic.Field(
        default=0,
        description="Integral: (g^3 * H_a) * gamma^6",
        validation_alias=pydantic.AliasChoices("i5a_e6", "i5a_E6"),
        serialization_alias="i5a_E6",
    )
    i5b_e6: float = pydantic.Field(
        default=0,
        description="Integral: (g^3 * H_b) * gamma^6",
        validation_alias=pydantic.AliasChoices("i5b_e6", "i5b_E6"),
        serialization_alias="i5b_E6",
    )
    sig_e1: float = pydantic.Field(
        default=0,
        description="Energy spread after 1 pass (eV)",
        validation_alias=pydantic.AliasChoices("sig_e1", "sig_E1"),
        serialization_alias="sig_E1",
    )
    a_emittance_end: float = pydantic.Field(
        default=0,
        description="a mode emittance at end of linac",
    )
    b_emittance_end: float = pydantic.Field(
        default=0,
        description="b mode emittance at end of linac",
    )


class NormalModesStruct(pydantic.BaseModel):
    """
    NormalModesStruct corresponds to bmad `normal_modes_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1941.

    Attributes
    ----------
    synch_int : float
        Synchrotron integrals I0, I1, I2, and I3
        Bmad type: real
        Fortran default: 0
    sige_e : float
        SigmaE/E
        Bmad type: real
        Fortran default: 0
    sig_z : float
        Sigma_Z
        Bmad type: real
        Fortran default: 0
    e_loss : float
        Energy loss / turn (eV)
        Bmad type: real
        Fortran default: 0
    rf_voltage : float
        Total rfcavity voltage (eV)
        Bmad type: real
        Fortran default: 0
    pz_aperture : float
        pz aperture limit. Used with Touschek calculations.
        Bmad type: real
        Fortran default: 0
    pz_average : float
        Average over branch due to damping.
        Bmad type: real
        Fortran default: 0
    momentum_compaction : float
        Bmad type: real
        Fortran default: 0
    dpz_damp : float
        Change in pz without RF
        Bmad type: real
        Fortran default: 0
    a : AnormalModeStruct
        Bmad type: type
        Fortran default: anormal_mode_struct()
    b : AnormalModeStruct
        Bmad type: type
        Fortran default: anormal_mode_struct()
    z : AnormalModeStruct
        Bmad type: type
        Fortran default: anormal_mode_struct()
    lin : LinacNormalModeStruct
        Bmad type: type
        Fortran default: linac_normal_mode_struct()
    """

    synch_int: Sequence[float] = pydantic.Field(
        default=0,
        description="Synchrotron integrals I0, I1, I2, and I3",
    )
    sige_e: float = pydantic.Field(
        default=0,
        description="SigmaE/E",
        validation_alias=pydantic.AliasChoices("sige_e", "sigE_E"),
        serialization_alias="sigE_E",
    )
    sig_z: float = pydantic.Field(
        default=0,
        description="Sigma_Z",
    )
    e_loss: float = pydantic.Field(
        default=0,
        description="Energy loss / turn (eV)",
    )
    rf_voltage: float = pydantic.Field(
        default=0,
        description="Total rfcavity voltage (eV)",
    )
    pz_aperture: float = pydantic.Field(
        default=0,
        description="pz aperture limit. Used with Touschek calculations.",
    )
    pz_average: float = pydantic.Field(
        default=0,
        description="Average over branch due to damping.",
    )
    momentum_compaction: float = pydantic.Field(
        default=0,
    )
    dpz_damp: float = pydantic.Field(
        default=0,
        description="Change in pz without RF",
    )
    a: AnormalModeStruct = pydantic.Field(
        default=None,
    )
    b: AnormalModeStruct = pydantic.Field(
        default=None,
    )
    z: AnormalModeStruct = pydantic.Field(
        default=None,
    )
    lin: LinacNormalModeStruct = pydantic.Field(
        default=None,
    )


class EmFieldStruct(pydantic.BaseModel):
    """
    EmFieldStruct corresponds to bmad `em_field_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1972.

    Attributes
    ----------
    e : float
        electric field.
        Bmad type: real
        Fortran default: 0
    b : float
        magnetic field.
        Bmad type: real
        Fortran default: 0
    de : float
        electric field gradient.
        Bmad type: real
        Fortran default: 0
    db : float
        magnetic field gradient.
        Bmad type: real
        Fortran default: 0
    phi : float
        Electric scalar potential.
        Bmad type: real
        Fortran default: 0
    phi_b : float
        Magnetic scalar potential.
        Bmad type: real
        Fortran default: 0
    a : float
        Magnetic vector potential.
        Bmad type: real
        Fortran default: 0
    """

    e: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="electric field.",
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    b: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="magnetic field.",
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    de: Sequence[float] = pydantic.Field(
        default=0,
        description="electric field gradient.",
        validation_alias=pydantic.AliasChoices("de", "dE"),
        serialization_alias="dE",
    )
    db: Sequence[float] = pydantic.Field(
        default=0,
        description="magnetic field gradient.",
        validation_alias=pydantic.AliasChoices("db", "dB"),
        serialization_alias="dB",
    )
    phi: float = pydantic.Field(
        default=0,
        description="Electric scalar potential.",
    )
    phi_b: float = pydantic.Field(
        default=0,
        description="Magnetic scalar potential.",
        validation_alias=pydantic.AliasChoices("phi_b", "phi_B"),
        serialization_alias="phi_B",
    )
    a: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Magnetic vector potential.",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )


class StrongBeamStruct(pydantic.BaseModel):
    """
    StrongBeamStruct corresponds to bmad `strong_beam_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1990.

    Attributes
    ----------
    ix_slice : int
        0 -> at element center and not at slice.
        Bmad type: integer
        Fortran default: 0
    x_center : float
        Strong beam slice center.
        Bmad type: real
        Fortran default: 0
    y_center : float
        Strong beam slice center.
        Bmad type: real
        Fortran default: 0
    x_sigma : float
        Strong beam slice sigma.
        Bmad type: real
        Fortran default: 0
    y_sigma : float
        Strong beam slice sigma.
        Bmad type: real
        Fortran default: 0
    dx : float
        Particle - beam slice distance.
        Bmad type: real
        Fortran default: 0
    dy : float
        Particle - beam slice distance.
        Bmad type: real
        Fortran default: 0
    """

    ix_slice: int = pydantic.Field(
        default=0,
        description="0 -> at element center and not at slice.",
    )
    x_center: float = pydantic.Field(
        default=0,
        description="Strong beam slice center.",
    )
    y_center: float = pydantic.Field(
        default=0,
        description="Strong beam slice center.",
    )
    x_sigma: float = pydantic.Field(
        default=0,
        description="Strong beam slice sigma.",
    )
    y_sigma: float = pydantic.Field(
        default=0,
        description="Strong beam slice sigma.",
    )
    dx: float = pydantic.Field(
        default=0,
        description="Particle - beam slice distance.",
    )
    dy: float = pydantic.Field(
        default=0,
        description="Particle - beam slice distance.",
    )


class TrackPointStruct(pydantic.BaseModel):
    """
    TrackPointStruct corresponds to bmad `track_point_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1997.

    Attributes
    ----------
    s_body : float
        Longitudinal coords within the element body.
        Bmad type: real
    orb : CoordStruct
        An array of track points indexed from 0 (%orb(0:)).
        Bmad type: type
    field : EmFieldStruct
        An array of em fields indexed from 0 (%field(0:)).
        Bmad type: type
    strong_beam : StrongBeamStruct
        Strong beam info for beambeam element.
        Bmad type: type
    vec0 : float
        0th order part of xfer map from the beginning.
        Bmad type: real
    mat6 : float
        1st order part of xfer map (transfer matrix).
        Bmad type: real
    """

    s_body: float = pydantic.Field(
        default=0.0,
        description="Longitudinal coords within the element body.",
    )
    orb: CoordStruct = pydantic.Field(
        default=None,
        description="An array of track points indexed from 0 (%orb(0:)).",
    )
    field: EmFieldStruct = pydantic.Field(
        default=None,
        description="An array of em fields indexed from 0 (%field(0:)).",
    )
    strong_beam: StrongBeamStruct = pydantic.Field(
        default=None,
        description="Strong beam info for beambeam element.",
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="0th order part of xfer map from the beginning.",
    )
    mat6: Sequence[float] = pydantic.Field(
        default=0.0,
        description="1st order part of xfer map (transfer matrix).",
    )


class TrackStruct(pydantic.BaseModel):
    """
    TrackStruct corresponds to bmad `track_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2008.

    Attributes
    ----------
    pt : TrackPointStruct
        Array of track points indexed from 0.
        Bmad type: type
    ds_save : float
        Min distance between points. Not positive => Save at all points.
        Bmad type: real
        Fortran default: 1d-3
    n_pt : int
        Track upper bound for %pt(0:) array.
        Bmad type: integer
        Fortran default: -1
    n_bad : int
        Number of "bad" steps where the step length was shortened.
        Bmad type: integer
        Fortran default: 0
    n_ok : int
        Number of "good" steps where the step length was not shortened.
        Bmad type: integer
        Fortran default: 0
    """

    pt: Sequence[TrackPointStruct] = pydantic.Field(
        default=None,
        description="Array of track points indexed from 0.",
    )
    ds_save: float = pydantic.Field(
        default=0.001,
        description="Min distance between points. Not positive => Save at all points.",
    )
    n_pt: int = pydantic.Field(
        default=-1,
        description="Track upper bound for %pt(0:) array.",
    )
    n_bad: int = pydantic.Field(
        default=0,
        description="Number of 'bad' steps where the step length was shortened.",
    )
    n_ok: int = pydantic.Field(
        default=0,
        description="Number of 'good' steps where the step length was not shortened.",
    )


class MultipassLordInfoStruct(pydantic.BaseModel):
    """
    MultipassLordInfoStruct corresponds to bmad `multipass_lord_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2027.

    Attributes
    ----------
    lord : EleStruct
        Lord element
        Bmad type: type
    n_pass : int
        Number of passes (= number of slaves)
        Bmad type: integer
    n_super_slave : int
        Number of super_slaves per super_lord.
        Bmad type: integer
    super_lord : ElePointerStruct
        Super_lord list if they exist.
        Bmad type: type
    slave : ElePointerStruct
        Slaves list in tracking part.
        Bmad type: type
    """

    lord: EleStruct = pydantic.Field(
        default=None,
        description="Lord element",
    )
    n_pass: int = pydantic.Field(
        default=0,
        description="Number of passes (= number of slaves)",
    )
    n_super_slave: int = pydantic.Field(
        default=0,
        description="Number of super_slaves per super_lord.",
    )
    super_lord: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
        description="Super_lord list if they exist.",
    )
    slave: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
        description="Slaves list in tracking part.",
    )


class MultipassEleInfoStruct(pydantic.BaseModel):
    """
    MultipassEleInfoStruct corresponds to bmad `multipass_ele_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2038.

    Attributes
    ----------
    multipass : bool
        True if involved in multipass. False otherwise
        Bmad type: logical
    ix_pass : int
        Pass number
        Bmad type: integer
    ix_lord : int
        Pointers to lord(:) array
        Bmad type: integer
    ix_super : int
        Indexes to slave(ix_pass, super_slave%ix_ele) matrix
        Bmad type: integer
    """

    multipass: bool = pydantic.Field(
        default=False,
        description="True if involved in multipass. False otherwise",
    )
    ix_pass: int = pydantic.Field(
        default=0,
        description="Pass number",
    )
    ix_lord: Sequence[int] = pydantic.Field(
        default=0,
        description="Pointers to lord(:) array",
    )
    ix_super: Sequence[int] = pydantic.Field(
        default=0,
        description="Indexes to slave(ix_pass, super_slave%ix_ele) matrix",
    )


class MultipassBranchInfoStruct(pydantic.BaseModel):
    """
    MultipassBranchInfoStruct corresponds to bmad `multipass_branch_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2045.

    Attributes
    ----------
    ele : MultipassEleInfoStruct
        Bmad type: type
    """

    ele: Sequence[MultipassEleInfoStruct] = pydantic.Field(
        default=None,
    )


class MultipassAllInfoStruct(pydantic.BaseModel):
    """
    MultipassAllInfoStruct corresponds to bmad `multipass_all_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2052.

    Attributes
    ----------
    lord : MultipassLordInfoStruct
        Array of lords
        Bmad type: type
    branch : MultipassBranchInfoStruct
        Bmad type: type
    """

    lord: Sequence[MultipassLordInfoStruct] = pydantic.Field(
        default=None,
        description="Array of lords",
    )
    branch: Sequence[MultipassBranchInfoStruct] = pydantic.Field(
        default=None,
    )


class AperturePointStruct(pydantic.BaseModel):
    """
    AperturePointStruct corresponds to bmad `aperture_point_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2061.

    Attributes
    ----------
    x : float
        (x,y) aperture point with respect to the reference orbit.
        Bmad type: real
    y : float
        (x,y) aperture point with respect to the reference orbit.
        Bmad type: real
    plane : int
        plane determining loss
        Bmad type: integer
    ix_ele : int
        ele index particle lost at
        Bmad type: integer
    i_turn : int
        turn particle lost at
        Bmad type: integer
    """

    x: float = pydantic.Field(
        default=0.0,
        description="(x,y) aperture point with respect to the reference orbit.",
    )
    y: float = pydantic.Field(
        default=0.0,
        description="(x,y) aperture point with respect to the reference orbit.",
    )
    plane: int = pydantic.Field(
        default=0,
        description="plane determining loss",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="ele index particle lost at",
    )
    i_turn: int = pydantic.Field(
        default=0,
        description="turn particle lost at",
    )


class ApertureParamStruct(pydantic.BaseModel):
    """
    ApertureParamStruct corresponds to bmad `aperture_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2070.

    Attributes
    ----------
    min_angle : float
        Bmad type: real
        Fortran default: 0
    max_angle : float
        Bmad type: real
        Fortran default: pi
    n_angle : int
        Bmad type: integer
        Fortran default: 9
    n_turn : int
        Number of turns a particle must survive.
        Bmad type: integer
        Fortran default: 100
    x_init : float
        Initial x coordinate to start with for theta_xy = 0.
        Bmad type: real
        Fortran default: 1e-3_rp
    y_init : float
        Initial y coordinate to start with for theta_xy = pi/2.
        Bmad type: real
        Fortran default: 1e-3_rp
    rel_accuracy : float
        Relative resolution of bracketed aperture.
        Bmad type: real
        Fortran default: 1e-2_rp
    abs_accuracy : float
        Absolute resolution of bracketed aperture (meters).
        Bmad type: real
        Fortran default: 1e-5_rp
    start_ele : str
        Element to start tracking at.
        Bmad type: character
        Fortran default: ''
    """

    min_angle: float = pydantic.Field(
        default=0,
    )
    max_angle: float = pydantic.Field(
        default=0.0,
    )
    n_angle: int = pydantic.Field(
        default=9,
    )
    n_turn: int = pydantic.Field(
        default=100,
        description="Number of turns a particle must survive.",
    )
    x_init: float = pydantic.Field(
        default=0.001,
        description="Initial x coordinate to start with for theta_xy = 0.",
    )
    y_init: float = pydantic.Field(
        default=0.001,
        description="Initial y coordinate to start with for theta_xy = pi/2.",
    )
    rel_accuracy: float = pydantic.Field(
        default=0.01,
        description="Relative resolution of bracketed aperture.",
    )
    abs_accuracy: float = pydantic.Field(
        default=1e-05,
        description="Absolute resolution of bracketed aperture (meters).",
    )
    start_ele: str = pydantic.Field(
        default="",
        max_length=40,
        description="Element to start tracking at.",
    )


class ApertureScanStruct(pydantic.BaseModel):
    """
    ApertureScanStruct corresponds to bmad `aperture_scan_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2084.

    Attributes
    ----------
    point : AperturePointStruct
        Set of aperture points at different angles.
        Bmad type: type
    ref_orb : CoordStruct
        Ref orbit around which the scan is made.
        Bmad type: type
    pz_start : float
        Starting pz.
        Bmad type: real
        Fortran default: 0
    """

    point: Sequence[AperturePointStruct] = pydantic.Field(
        default=None,
        description="Set of aperture points at different angles.",
    )
    ref_orb: CoordStruct = pydantic.Field(
        default=None,
        description="Ref orbit around which the scan is made.",
    )
    pz_start: float = pydantic.Field(
        default=0,
        description="Starting pz.",
    )


class SpaceChargeCommonStruct(pydantic.BaseModel):
    """
    SpaceChargeCommonStruct corresponds to bmad `space_charge_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2093.

    Attributes
    ----------
    ds_track_step : float
        CSR tracking step size
        Bmad type: real
        Fortran default: 0
    dt_track_step : float
        Time Runge kutta initial step.
        Bmad type: real
        Fortran default: 1d-12
    cathode_strength_cutoff : float
        Cutoff for the cathode field calc.
        Bmad type: real
        Fortran default: 0.01
    rel_tol_tracking : float
        Relative tolerance for tracking.
        Bmad type: real
        Fortran default: 1d-8
    abs_tol_tracking : float
        Absolute tolerance for tracking.
        Bmad type: real
        Fortran default: 1d-10
    beam_chamber_height : float
        Used in shielding calculation.
        Bmad type: real
        Fortran default: 0
    lsc_sigma_cutoff : float
        Cutoff for the 1-dim longitudinal SC calc.
        Bmad type: real
        Fortran default: 0.1
    particle_sigma_cutoff : float
        3D SC calc cutoff for particles with (x,y,z) position far from the center.
        Bmad type: real
        Fortran default: -1
    space_charge_mesh_size : int
        Gird size for fft_3d space charge calc.
        Bmad type: integer
        Fortran default: [32, 32, 64]
    csr3d_mesh_size : int
        Gird size for CSR.
        Bmad type: integer
        Fortran default: [32, 32, 64]
    n_bin : int
        Number of bins used
        Bmad type: integer
        Fortran default: 0
    particle_bin_span : int
        Longitudinal particle length / dz_bin
        Bmad type: integer
        Fortran default: 2
    n_shield_images : int
        Chamber wall shielding. 0 = no shielding.
        Bmad type: integer
        Fortran default: 0
    sc_min_in_bin : int
        Minimum number of particles in a bin for sigmas to be valid.
        Bmad type: integer
        Fortran default: 10
    lsc_kick_transverse_dependence : bool
        Bmad type: logical
        Fortran default: .false.
    debug : bool
        Bmad type: logical
        Fortran default: .false.
    diagnostic_output_file : str
        If non-blank write a diagnostic (EG wake) file
        Bmad type: character
        Fortran default: ''
    """

    ds_track_step: float = pydantic.Field(
        default=0,
        description="CSR tracking step size",
    )
    dt_track_step: float = pydantic.Field(
        default=1e-12,
        description="Time Runge kutta initial step.",
    )
    cathode_strength_cutoff: float = pydantic.Field(
        default=0.01,
        description="Cutoff for the cathode field calc.",
    )
    rel_tol_tracking: float = pydantic.Field(
        default=1e-08,
        description="Relative tolerance for tracking.",
    )
    abs_tol_tracking: float = pydantic.Field(
        default=1e-10,
        description="Absolute tolerance for tracking.",
    )
    beam_chamber_height: float = pydantic.Field(
        default=0,
        description="Used in shielding calculation.",
    )
    lsc_sigma_cutoff: float = pydantic.Field(
        default=0.1,
        description="Cutoff for the 1-dim longitudinal SC calc.",
    )
    particle_sigma_cutoff: float = pydantic.Field(
        default=-1,
        description="3D SC calc cutoff for particles with (x,y,z) position far from the center.",
    )
    space_charge_mesh_size: Sequence[int] = pydantic.Field(
        default=[32, 32, 64],
        max_length=3,
        description="Gird size for fft_3d space charge calc.",
    )
    csr3d_mesh_size: Sequence[int] = pydantic.Field(
        default=[32, 32, 64],
        max_length=3,
        description="Gird size for CSR.",
    )
    n_bin: int = pydantic.Field(
        default=0,
        description="Number of bins used",
    )
    particle_bin_span: int = pydantic.Field(
        default=2,
        description="Longitudinal particle length / dz_bin",
    )
    n_shield_images: int = pydantic.Field(
        default=0,
        description="Chamber wall shielding. 0 = no shielding.",
    )
    sc_min_in_bin: int = pydantic.Field(
        default=10,
        description="Minimum number of particles in a bin for sigmas to be valid.",
    )
    lsc_kick_transverse_dependence: bool = pydantic.Field(
        default=False,
    )
    debug: bool = pydantic.Field(
        default=False,
    )
    diagnostic_output_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="If non-blank write a diagnostic (EG wake) file",
    )


class TimeRungeKuttaCommonStruct(pydantic.BaseModel):
    """
    TimeRungeKuttaCommonStruct corresponds to bmad `time_runge_kutta_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2119.

    Attributes
    ----------
    num_steps_done : int
        Number of integration steps. Not used by Bmad. For external use.
        Bmad type: integer
        Fortran default: -1
    print_too_many_step_err : bool
        Bmad type: logical
        Fortran default: .true.
    """

    num_steps_done: int = pydantic.Field(
        default=-1,
        description="Number of integration steps. Not used by Bmad. For external use.",
    )
    print_too_many_step_err: bool = pydantic.Field(
        default=True,
    )


class ExtraParsingInfoStruct(pydantic.BaseModel):
    """
    ExtraParsingInfoStruct corresponds to bmad `extra_parsing_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2138.

    Attributes
    ----------
    ran_state : RandomStateStruct
        Bmad type: type
        Fortran default: random_state_struct()
    ran_seed : int
        Bmad type: integer
        Fortran default: 0
    undeterministic_ran_function_called : bool
        Bmad type: logical
        Fortran default: .false.
    d_orb_set : bool
        Bmad type: logical
        Fortran default: .false.
    max_aperture_limit_set : bool
        Bmad type: logical
        Fortran default: .false.
    default_ds_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    significant_length_set : bool
        Bmad type: logical
        Fortran default: .false.
    rel_tol_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    abs_tol_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    rel_tol_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    abs_tol_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    init_ds_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    min_ds_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    fatal_ds_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    synch_rad_scale_set : bool
        Bmad type: logical
        Fortran default: .false.
    autoscale_amp_abs_tol_set : bool
        Bmad type: logical
        Fortran default: .false.
    autoscale_amp_rel_tol_set : bool
        Bmad type: logical
        Fortran default: .false.
    autoscale_phase_tol_set : bool
        Bmad type: logical
        Fortran default: .false.
    rf_phase_below_transition_ref_set : bool
        Bmad type: logical
        Fortran default: .false.
    electric_dipole_moment_set : bool
        Bmad type: logical
        Fortran default: .false.
    taylor_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    runge_kutta_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    default_integ_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    sr_wakes_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    lr_wakes_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    high_energy_space_charge_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    csr_and_space_charge_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    spin_tracking_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    spin_sokolov_ternov_flipping_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    radiation_damping_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    radiation_zero_average_set : bool
        Bmad type: logical
        Fortran default: .false.
    radiation_fluctuations_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    conserve_taylor_maps_set : bool
        Bmad type: logical
        Fortran default: .false.
    absolute_time_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    absolute_time_ref_shift_set : bool
        Bmad type: logical
        Fortran default: .false.
    convert_to_kinetic_momentum_set : bool
        Bmad type: logical
        Fortran default: .false.
    aperture_limit_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    sad_eps_scale_set : bool
        Bmad type: logical
        Fortran default: .false.
    sad_amp_max_set : bool
        Bmad type: logical
        Fortran default: .false.
    sad_n_div_max_set : bool
        Bmad type: logical
        Fortran default: .false.
    max_num_runge_kutta_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    debug_set : bool
        Bmad type: logical
        Fortran default: .false.
    ds_track_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    dt_track_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    cathode_strength_cutoff_set : bool
        Bmad type: logical
        Fortran default: .false.
    sc_rel_tol_tracking_set : bool
        For: space_charge_com%rel_tol_tracking
        Bmad type: logical
        Fortran default: .false.
    sc_abs_tol_tracking_set : bool
        For: space_charge_com%abs_tol_tracking
        Bmad type: logical
        Fortran default: .false.
    beam_chamber_height_set : bool
        Bmad type: logical
        Fortran default: .false.
    lsc_sigma_cutoff_set : bool
        Bmad type: logical
        Fortran default: .false.
    particle_sigma_cutoff_set : bool
        Bmad type: logical
        Fortran default: .false.
    space_charge_mesh_size_set : bool
        Bmad type: logical
        Fortran default: .false.
    csr3d_mesh_size_set : bool
        Bmad type: logical
        Fortran default: .false.
    n_bin_set : bool
        Bmad type: logical
        Fortran default: .false.
    particle_bin_span_set : bool
        Bmad type: logical
        Fortran default: .false.
    n_shield_images_set : bool
        Bmad type: logical
        Fortran default: .false.
    sc_min_in_bin_set : bool
        Bmad type: logical
        Fortran default: .false.
    lsc_kick_transverse_dependence_set : bool
        Bmad type: logical
        Fortran default: .false.
    sc_debug_set : bool
        Bmad type: logical
        Fortran default: .false.
    diagnostic_output_file_set : bool
        Bmad type: logical
        Fortran default: .false.
    old_integrator_set : bool
        Bmad type: logical
        Fortran default: .false.
    use_orientation_patches_set : bool
        Bmad type: logical
        Fortran default: .false.
    print_info_messages_set : bool
        Bmad type: logical
        Fortran default: .false.
    max_fringe_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    exact_model_set : bool
        Bmad type: logical
        Fortran default: .false.
    exact_misalign_set : bool
        Bmad type: logical
        Fortran default: .false.
    vertical_kick_set : bool
        Bmad type: logical
        Fortran default: .false.
    cut_factor_set : bool
        Bmad type: logical
        Fortran default: .false.
    translate_patch_drift_time_set : bool
        Bmad type: logical
        Fortran default: .false.
    """

    ran_state: RandomStateStruct = pydantic.Field(
        default=None,
    )
    ran_seed: int = pydantic.Field(
        default=0,
    )
    undeterministic_ran_function_called: bool = pydantic.Field(
        default=False,
    )
    d_orb_set: bool = pydantic.Field(
        default=False,
    )
    max_aperture_limit_set: bool = pydantic.Field(
        default=False,
    )
    default_ds_step_set: bool = pydantic.Field(
        default=False,
    )
    significant_length_set: bool = pydantic.Field(
        default=False,
    )
    rel_tol_tracking_set: bool = pydantic.Field(
        default=False,
    )
    abs_tol_tracking_set: bool = pydantic.Field(
        default=False,
    )
    rel_tol_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    abs_tol_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    init_ds_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    min_ds_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    fatal_ds_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    synch_rad_scale_set: bool = pydantic.Field(
        default=False,
    )
    autoscale_amp_abs_tol_set: bool = pydantic.Field(
        default=False,
    )
    autoscale_amp_rel_tol_set: bool = pydantic.Field(
        default=False,
    )
    autoscale_phase_tol_set: bool = pydantic.Field(
        default=False,
    )
    rf_phase_below_transition_ref_set: bool = pydantic.Field(
        default=False,
    )
    electric_dipole_moment_set: bool = pydantic.Field(
        default=False,
    )
    taylor_order_set: bool = pydantic.Field(
        default=False,
    )
    runge_kutta_order_set: bool = pydantic.Field(
        default=False,
    )
    default_integ_order_set: bool = pydantic.Field(
        default=False,
    )
    sr_wakes_on_set: bool = pydantic.Field(
        default=False,
    )
    lr_wakes_on_set: bool = pydantic.Field(
        default=False,
    )
    high_energy_space_charge_on_set: bool = pydantic.Field(
        default=False,
    )
    csr_and_space_charge_on_set: bool = pydantic.Field(
        default=False,
    )
    spin_tracking_on_set: bool = pydantic.Field(
        default=False,
    )
    spin_sokolov_ternov_flipping_on_set: bool = pydantic.Field(
        default=False,
    )
    radiation_damping_on_set: bool = pydantic.Field(
        default=False,
    )
    radiation_zero_average_set: bool = pydantic.Field(
        default=False,
    )
    radiation_fluctuations_on_set: bool = pydantic.Field(
        default=False,
    )
    conserve_taylor_maps_set: bool = pydantic.Field(
        default=False,
    )
    absolute_time_tracking_set: bool = pydantic.Field(
        default=False,
    )
    absolute_time_ref_shift_set: bool = pydantic.Field(
        default=False,
    )
    convert_to_kinetic_momentum_set: bool = pydantic.Field(
        default=False,
    )
    aperture_limit_on_set: bool = pydantic.Field(
        default=False,
    )
    sad_eps_scale_set: bool = pydantic.Field(
        default=False,
    )
    sad_amp_max_set: bool = pydantic.Field(
        default=False,
    )
    sad_n_div_max_set: bool = pydantic.Field(
        default=False,
    )
    max_num_runge_kutta_step_set: bool = pydantic.Field(
        default=False,
    )
    debug_set: bool = pydantic.Field(
        default=False,
    )
    ds_track_step_set: bool = pydantic.Field(
        default=False,
    )
    dt_track_step_set: bool = pydantic.Field(
        default=False,
    )
    cathode_strength_cutoff_set: bool = pydantic.Field(
        default=False,
    )
    sc_rel_tol_tracking_set: bool = pydantic.Field(
        default=False,
        description="For: space_charge_com%rel_tol_tracking",
    )
    sc_abs_tol_tracking_set: bool = pydantic.Field(
        default=False,
        description="For: space_charge_com%abs_tol_tracking",
    )
    beam_chamber_height_set: bool = pydantic.Field(
        default=False,
    )
    lsc_sigma_cutoff_set: bool = pydantic.Field(
        default=False,
    )
    particle_sigma_cutoff_set: bool = pydantic.Field(
        default=False,
    )
    space_charge_mesh_size_set: bool = pydantic.Field(
        default=False,
    )
    csr3d_mesh_size_set: bool = pydantic.Field(
        default=False,
    )
    n_bin_set: bool = pydantic.Field(
        default=False,
    )
    particle_bin_span_set: bool = pydantic.Field(
        default=False,
    )
    n_shield_images_set: bool = pydantic.Field(
        default=False,
    )
    sc_min_in_bin_set: bool = pydantic.Field(
        default=False,
    )
    lsc_kick_transverse_dependence_set: bool = pydantic.Field(
        default=False,
    )
    sc_debug_set: bool = pydantic.Field(
        default=False,
    )
    diagnostic_output_file_set: bool = pydantic.Field(
        default=False,
    )
    old_integrator_set: bool = pydantic.Field(
        default=False,
    )
    use_orientation_patches_set: bool = pydantic.Field(
        default=False,
    )
    print_info_messages_set: bool = pydantic.Field(
        default=False,
    )
    max_fringe_order_set: bool = pydantic.Field(
        default=False,
    )
    exact_model_set: bool = pydantic.Field(
        default=False,
    )
    exact_misalign_set: bool = pydantic.Field(
        default=False,
    )
    vertical_kick_set: bool = pydantic.Field(
        default=False,
    )
    cut_factor_set: bool = pydantic.Field(
        default=False,
    )
    translate_patch_drift_time_set: bool = pydantic.Field(
        default=False,
    )


class BmadCommonStruct(pydantic.BaseModel):
    """
    BmadCommonStruct corresponds to bmad `bmad_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2221.

    Attributes
    ----------
    max_aperture_limit : float
        Max Aperture.
        Bmad type: real
        Fortran default: 1d3
    d_orb : float
        Orbit deltas for the mat6 via tracking calc.
        Bmad type: real
        Fortran default: 1d-5
    default_ds_step : float
        Default integration step for eles without an explicit step calc.
        Bmad type: real
        Fortran default: 0.2_rp
    significant_length : float
        meter
        Bmad type: real
        Fortran default: 1d-10
    rel_tol_tracking : float
        Closed orbit relative tolerance.
        Bmad type: real
        Fortran default: 1d-9
    abs_tol_tracking : float
        Closed orbit absolute tolerance.
        Bmad type: real
        Fortran default: 1d-12
    rel_tol_adaptive_tracking : float
        Runge-Kutta tracking relative tolerance.
        Bmad type: real
        Fortran default: 1d-8
    abs_tol_adaptive_tracking : float
        Runge-Kutta tracking absolute tolerance.
        Bmad type: real
        Fortran default: 1d-10
    init_ds_adaptive_tracking : float
        Initial step size
        Bmad type: real
        Fortran default: 1d-3
    min_ds_adaptive_tracking : float
        Min step size to take.
        Bmad type: real
        Fortran default: 0
    fatal_ds_adaptive_tracking : float
        If actual step size is below this particle is lost.
        Bmad type: real
        Fortran default: 1d-8
    autoscale_amp_abs_tol : float
        Autoscale absolute amplitude tolerance (eV).
        Bmad type: real
        Fortran default: 0.1_rp
    autoscale_amp_rel_tol : float
        Autoscale relative amplitude tolerance
        Bmad type: real
        Fortran default: 1d-6
    autoscale_phase_tol : float
        Autoscale phase tolerance.
        Bmad type: real
        Fortran default: 1d-5
    electric_dipole_moment : float
        Particle's EDM. Call set_ptc to transfer value to PTC.
        Bmad type: real
        Fortran default: 0
    synch_rad_scale : float
        Synch radiation kick scale. 1 => normal, 0 => no kicks.
        Bmad type: real
        Fortran default: 1.0_rp
    sad_eps_scale : float
        Used in sad_mult step length calc.
        Bmad type: real
        Fortran default: 5.0d-3
    sad_amp_max : float
        Used in sad_mult step length calc.
        Bmad type: real
        Fortran default: 5.0d-2
    sad_n_div_max : int
        Used in sad_mult step length calc.
        Bmad type: integer
        Fortran default: 1000
    taylor_order : int
        Taylor order to use. 0 -> default = ptc_private%taylor_order_saved.
        Bmad type: integer
        Fortran default: 0
    runge_kutta_order : int
        Runge Kutta order.
        Bmad type: integer
        Fortran default: 4
    default_integ_order : int
        PTC integration order.
        Bmad type: integer
        Fortran default: 2
    max_num_runge_kutta_step : int
        Maximum number of RK steps before particle is considered lost.
        Bmad type: integer
        Fortran default: 10000
    rf_phase_below_transition_ref : bool
        Autoscale uses below transition stable point for RFCavities?
        Bmad type: logical
        Fortran default: .false.
    sr_wakes_on : bool
        Short range wakefields?
        Bmad type: logical
        Fortran default: .true.
    lr_wakes_on : bool
        Long range wakefields
        Bmad type: logical
        Fortran default: .true.
    auto_bookkeeper : bool
        Automatic bookkeeping?
        Bmad type: logical
        Fortran default: .true.
    high_energy_space_charge_on : bool
        High energy space charge effect switch.
        Bmad type: logical
        Fortran default: .false.
    csr_and_space_charge_on : bool
        Space charge switch.
        Bmad type: logical
        Fortran default: .false.
    spin_tracking_on : bool
        spin tracking?
        Bmad type: logical
        Fortran default: .false.
    spin_sokolov_ternov_flipping_on : bool
        Spin flipping during synchrotron radiation emission?
        Bmad type: logical
        Fortran default: .false.
    radiation_damping_on : bool
        Radiation damping toggle.
        Bmad type: logical
        Fortran default: .false.
    radiation_zero_average : bool
        Shift damping to be zero on the zero orbit to get rid of sawtooth?
        Bmad type: logical
        Fortran default: .false.
    radiation_fluctuations_on : bool
        Radiation fluctuations toggle.
        Bmad type: logical
        Fortran default: .false.
    conserve_taylor_maps : bool
        Enable bookkeeper to set ele%taylor_map_includes_offsets = F?
        Bmad type: logical
        Fortran default: .true.
    absolute_time_tracking : bool
        Absolute or relative time tracking?
        Bmad type: logical
        Fortran default: .false.
    absolute_time_ref_shift : bool
        Apply reference time shift when using absolute time tracking?
        Bmad type: logical
        Fortran default: .true.
    convert_to_kinetic_momentum : bool
        Cancel kicks due to finite vector potential when doing symplectic tracking?
        Bmad type: logical
        Fortran default: .false.
    aperture_limit_on : bool
        use apertures in tracking?
        Bmad type: logical
        Fortran default: .true.
    debug : bool
        Used for code debugging.
        Bmad type: logical
        Fortran default: .false.
    """

    max_aperture_limit: float = pydantic.Field(
        default=1000.0,
        description="Max Aperture.",
    )
    d_orb: Sequence[float] = pydantic.Field(
        default=1e-05,
        max_length=6,
        description="Orbit deltas for the mat6 via tracking calc.",
    )
    default_ds_step: float = pydantic.Field(
        default=0.2,
        description="Default integration step for eles without an explicit step calc.",
    )
    significant_length: float = pydantic.Field(
        default=1e-10,
        description="meter",
    )
    rel_tol_tracking: float = pydantic.Field(
        default=1e-09,
        description="Closed orbit relative tolerance.",
    )
    abs_tol_tracking: float = pydantic.Field(
        default=1e-12,
        description="Closed orbit absolute tolerance.",
    )
    rel_tol_adaptive_tracking: float = pydantic.Field(
        default=1e-08,
        description="Runge-Kutta tracking relative tolerance.",
    )
    abs_tol_adaptive_tracking: float = pydantic.Field(
        default=1e-10,
        description="Runge-Kutta tracking absolute tolerance.",
    )
    init_ds_adaptive_tracking: float = pydantic.Field(
        default=0.001,
        description="Initial step size",
    )
    min_ds_adaptive_tracking: float = pydantic.Field(
        default=0,
        description="Min step size to take.",
    )
    fatal_ds_adaptive_tracking: float = pydantic.Field(
        default=1e-08,
        description="If actual step size is below this particle is lost.",
    )
    autoscale_amp_abs_tol: float = pydantic.Field(
        default=0.1,
        description="Autoscale absolute amplitude tolerance (eV).",
    )
    autoscale_amp_rel_tol: float = pydantic.Field(
        default=1e-06,
        description="Autoscale relative amplitude tolerance",
    )
    autoscale_phase_tol: float = pydantic.Field(
        default=1e-05,
        description="Autoscale phase tolerance.",
    )
    electric_dipole_moment: float = pydantic.Field(
        default=0,
        description="Particle's EDM. Call set_ptc to transfer value to PTC.",
    )
    synch_rad_scale: float = pydantic.Field(
        default=1.0,
        description="Synch radiation kick scale. 1 => normal, 0 => no kicks.",
    )
    sad_eps_scale: float = pydantic.Field(
        default=0.005,
        description="Used in sad_mult step length calc.",
    )
    sad_amp_max: float = pydantic.Field(
        default=0.05,
        description="Used in sad_mult step length calc.",
    )
    sad_n_div_max: int = pydantic.Field(
        default=1000,
        description="Used in sad_mult step length calc.",
    )
    taylor_order: int = pydantic.Field(
        default=0,
        description="Taylor order to use. 0 -> default = ptc_private%taylor_order_saved.",
    )
    runge_kutta_order: int = pydantic.Field(
        default=4,
        description="Runge Kutta order.",
    )
    default_integ_order: int = pydantic.Field(
        default=2,
        description="PTC integration order.",
    )
    max_num_runge_kutta_step: int = pydantic.Field(
        default=10000,
        description="Maximum number of RK steps before particle is considered lost.",
    )
    rf_phase_below_transition_ref: bool = pydantic.Field(
        default=False,
        description="Autoscale uses below transition stable point for RFCavities?",
    )
    sr_wakes_on: bool = pydantic.Field(
        default=True,
        description="Short range wakefields?",
    )
    lr_wakes_on: bool = pydantic.Field(
        default=True,
        description="Long range wakefields",
    )
    auto_bookkeeper: bool = pydantic.Field(
        default=True,
        description="Automatic bookkeeping?",
    )
    high_energy_space_charge_on: bool = pydantic.Field(
        default=False,
        description="High energy space charge effect switch.",
    )
    csr_and_space_charge_on: bool = pydantic.Field(
        default=False,
        description="Space charge switch.",
    )
    spin_tracking_on: bool = pydantic.Field(
        default=False,
        description="spin tracking?",
    )
    spin_sokolov_ternov_flipping_on: bool = pydantic.Field(
        default=False,
        description="Spin flipping during synchrotron radiation emission?",
    )
    radiation_damping_on: bool = pydantic.Field(
        default=False,
        description="Radiation damping toggle.",
    )
    radiation_zero_average: bool = pydantic.Field(
        default=False,
        description="Shift damping to be zero on the zero orbit to get rid of sawtooth?",
    )
    radiation_fluctuations_on: bool = pydantic.Field(
        default=False,
        description="Radiation fluctuations toggle.",
    )
    conserve_taylor_maps: bool = pydantic.Field(
        default=True,
        description="Enable bookkeeper to set ele%taylor_map_includes_offsets = F?",
    )
    absolute_time_tracking: bool = pydantic.Field(
        default=False,
        description="Absolute or relative time tracking?",
    )
    absolute_time_ref_shift: bool = pydantic.Field(
        default=True,
        description="Apply reference time shift when using absolute time tracking?",
    )
    convert_to_kinetic_momentum: bool = pydantic.Field(
        default=False,
        description="Cancel kicks due to finite vector potential when doing symplectic tracking?",
    )
    aperture_limit_on: bool = pydantic.Field(
        default=True,
        description="use apertures in tracking?",
    )
    debug: bool = pydantic.Field(
        default=False,
        description="Used for code debugging.",
    )


class BmadPrivateStruct(pydantic.BaseModel):
    """
    BmadPrivateStruct corresponds to bmad `bmad_private_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2270.

    Attributes
    ----------
    rf_clock_period : float
        The RF clock is used by the long_term_tracking program to avoid time round-off
        errors.
        Bmad type: real
        Fortran default: 0
    random_on : bool
        Temporarily turned off, for example, with the closed orbit calc.
        Bmad type: logical
        Fortran default: .true.
    """

    rf_clock_period: float = pydantic.Field(
        default=0,
        description=(
            "The RF clock is used by the long_term_tracking program to avoid time "
            "round-off errors."
        ),
    )
    random_on: bool = pydantic.Field(
        default=True,
        description="Temporarily turned off, for example, with the closed orbit calc.",
    )


class PtcCommonStruct(pydantic.BaseModel):
    """
    PtcCommonStruct corresponds to bmad `ptc_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2280.

    Attributes
    ----------
    max_fringe_order : int
        Points to PTC HIGHEST_FRINGE. 2 (default) => Quadrupole.
        Bmad type: integer
        Fortran default: null()
    old_integrator : int
        Points to PTC OLD_INTEGRATOR. -1 = False, 1 = True.
        Bmad type: integer
        Fortran default: null()
    exact_model : bool
        Points to PTC EXACT_MODEL. Default True.
        Bmad type: logical
        Fortran default: null()
    exact_misalign : bool
        Points to PTC ALWAYS_EXACTMIS. Default True. Notice different names.
        Bmad type: logical
        Fortran default: null()
    vertical_kick : float
        Points to PTC VERTICAL_KICK for 6D emittance calc. 0 => off, 1 => on (default).
        Bmad type: real
        Fortran default: null()
    cut_factor : float
        Cut factor for PTC tracking
        Bmad type: real
        Fortran default: 0.006
    print_step_warning : bool
        Print warning if element uses too many steps.
        Bmad type: logical
        Fortran default: .false.
    use_orientation_patches : bool
        offset, pitch, and tilt attributes are put in ptc patch?
        Bmad type: logical
        Fortran default: .true.
    print_info_messages : bool
        Allow PTC to print informational messages (which can clutter the output)?
        Bmad type: logical
        Fortran default: .false.
    translate_patch_drift_time : bool
        When a Bmad patch is translated to a PTC fibre, is the drift
        Bmad type: logical
        Fortran default: .true.
    """

    max_fringe_order: int = pydantic.Field(
        default=0,
        description="Points to PTC HIGHEST_FRINGE. 2 (default) => Quadrupole.",
    )
    old_integrator: int = pydantic.Field(
        default=0,
        description="Points to PTC OLD_INTEGRATOR. -1 = False, 1 = True.",
    )
    exact_model: bool = pydantic.Field(
        default=False,
        description="Points to PTC EXACT_MODEL. Default True.",
    )
    exact_misalign: bool = pydantic.Field(
        default=False,
        description="Points to PTC ALWAYS_EXACTMIS. Default True. Notice different names.",
    )
    vertical_kick: float = pydantic.Field(
        default=0.0,
        description="Points to PTC VERTICAL_KICK for 6D emittance calc. 0 => off, 1 => on (default).",
    )
    cut_factor: float = pydantic.Field(
        default=0.006,
        description="Cut factor for PTC tracking",
    )
    print_step_warning: bool = pydantic.Field(
        default=False,
        description="Print warning if element uses too many steps.",
    )
    use_orientation_patches: bool = pydantic.Field(
        default=True,
        description="offset, pitch, and tilt attributes are put in ptc patch?",
    )
    print_info_messages: bool = pydantic.Field(
        default=False,
        description="Allow PTC to print informational messages (which can clutter the output)?",
    )
    translate_patch_drift_time: bool = pydantic.Field(
        default=True,
        description="When a Bmad patch is translated to a PTC fibre, is the drift",
    )


class PtcPrivateStruct(pydantic.BaseModel):
    """
    PtcPrivateStruct corresponds to bmad `ptc_private_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2307.

    Attributes
    ----------
    base_state : InternalState
        Base PTC state.
        Bmad type: type
    e_tot_set : float
        Bmad type: real
        Fortran default: 0
    taylor_order_ptc : int
        What has been set in PTC. 0 -> not yet set. See above.
        Bmad type: integer
        Fortran default: 0
    taylor_order_saved : int
        Default to use at startup.
        Bmad type: integer
        Fortran default: 3
    init_ptc_needed : bool
        Bmad type: logical
        Fortran default: .true.
    init_spin_needed : bool
        Bmad type: logical
        Fortran default: .true.
    """

    base_state: InternalState = pydantic.Field(
        default=None,
        description="Base PTC state.",
    )
    e_tot_set: float = pydantic.Field(
        default=0,
    )
    taylor_order_ptc: int = pydantic.Field(
        default=0,
        description="What has been set in PTC. 0 -> not yet set. See above.",
    )
    taylor_order_saved: int = pydantic.Field(
        default=3,
        description="Default to use at startup.",
    )
    init_ptc_needed: bool = pydantic.Field(
        default=True,
    )
    init_spin_needed: bool = pydantic.Field(
        default=True,
    )


class RadInt1Struct(pydantic.BaseModel):
    """
    RadInt1Struct corresponds to bmad `rad_int1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2324.

    Attributes
    ----------
    i0 : float
        Bmad type: real
        Fortran default: 0
    i1 : float
        Bmad type: real
        Fortran default: 0
    i2 : float
        Bmad type: real
        Fortran default: 0
    i3 : float
        Bmad type: real
        Fortran default: 0
    i4a : float
        Bmad type: real
        Fortran default: 0
    i4b : float
        Bmad type: real
        Fortran default: 0
    i4z : float
        Bmad type: real
        Fortran default: 0
    i5a : float
        Bmad type: real
        Fortran default: 0
    i5b : float
        Bmad type: real
        Fortran default: 0
    i6b : float
        Bmad type: real
        Fortran default: 0
    lin_i2_e4 : float
        Bmad type: real
        Fortran default: 0
    lin_i3_e7 : float
        Bmad type: real
        Fortran default: 0
    lin_i5a_e6 : float
        Bmad type: real
        Fortran default: 0
    lin_i5b_e6 : float
        Bmad type: real
        Fortran default: 0
    lin_norm_emit_a : float
        Running sum
        Bmad type: real
        Fortran default: 0
    lin_norm_emit_b : float
        Running sum
        Bmad type: real
        Fortran default: 0
    lin_sig_e : float
        Running sum
        Bmad type: real
        Fortran default: 0
    n_steps : float
        number of qromb steps needed
        Bmad type: real
        Fortran default: 0
    """

    i0: float = pydantic.Field(
        default=0,
    )
    i1: float = pydantic.Field(
        default=0,
    )
    i2: float = pydantic.Field(
        default=0,
    )
    i3: float = pydantic.Field(
        default=0,
    )
    i4a: float = pydantic.Field(
        default=0,
    )
    i4b: float = pydantic.Field(
        default=0,
    )
    i4z: float = pydantic.Field(
        default=0,
    )
    i5a: float = pydantic.Field(
        default=0,
    )
    i5b: float = pydantic.Field(
        default=0,
    )
    i6b: float = pydantic.Field(
        default=0,
    )
    lin_i2_e4: float = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("lin_i2_e4", "lin_i2_E4"),
        serialization_alias="lin_i2_E4",
    )
    lin_i3_e7: float = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("lin_i3_e7", "lin_i3_E7"),
        serialization_alias="lin_i3_E7",
    )
    lin_i5a_e6: float = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("lin_i5a_e6", "lin_i5a_E6"),
        serialization_alias="lin_i5a_E6",
    )
    lin_i5b_e6: float = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("lin_i5b_e6", "lin_i5b_E6"),
        serialization_alias="lin_i5b_E6",
    )
    lin_norm_emit_a: float = pydantic.Field(
        default=0,
        description="Running sum",
    )
    lin_norm_emit_b: float = pydantic.Field(
        default=0,
        description="Running sum",
    )
    lin_sig_e: float = pydantic.Field(
        default=0,
        description="Running sum",
        validation_alias=pydantic.AliasChoices("lin_sig_e", "lin_sig_E"),
        serialization_alias="lin_sig_E",
    )
    n_steps: float = pydantic.Field(
        default=0,
        description="number of qromb steps needed",
    )


class RadIntBranchStruct(pydantic.BaseModel):
    """
    RadIntBranchStruct corresponds to bmad `rad_int_branch_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2347.

    Attributes
    ----------
    ele : RadInt1Struct
        Array is indexed from 0
        Bmad type: type
    """

    ele: Sequence[RadInt1Struct] = pydantic.Field(
        default=None,
        description="Array is indexed from 0",
    )


class RadIntAllEleStruct(pydantic.BaseModel):
    """
    RadIntAllEleStruct corresponds to bmad `rad_int_all_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2351.

    Attributes
    ----------
    branch : RadIntBranchStruct
        Array is indexed from 0
        Bmad type: type
    """

    branch: Sequence[RadIntBranchStruct] = pydantic.Field(
        default=None,
        description="Array is indexed from 0",
    )


class PmdHeaderStruct(pydantic.BaseModel):
    """
    PmdHeaderStruct corresponds to bmad `pmd_header_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2357.

    Attributes
    ----------
    openpmd : str
        Bmad type: character
    openpmdextension : str
        Bmad type: character
    basepath : str
        Bmad type: character
    particlespath : str
        Bmad type: character
    meshespath : str
        Bmad type: character
    author : str
        Bmad type: character
    software : str
        Bmad type: character
    softwareversion : str
        Bmad type: character
    date : str
        Bmad type: character
    latticefile : str
        Bmad type: character
    latticename : str
        Bmad type: character
    """

    openpmd: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("openpmd", "openPMD"),
        serialization_alias="openPMD",
    )
    openpmdextension: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("openpmdextension", "openPMDextension"),
        serialization_alias="openPMDextension",
    )
    basepath: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("basepath", "basePath"),
        serialization_alias="basePath",
    )
    particlespath: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("particlespath", "particlesPath"),
        serialization_alias="particlesPath",
    )
    meshespath: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("meshespath", "meshesPath"),
        serialization_alias="meshesPath",
    )
    author: str = pydantic.Field(
        default="",
    )
    software: str = pydantic.Field(
        default="",
    )
    softwareversion: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("softwareversion", "softwareVersion"),
        serialization_alias="softwareVersion",
    )
    date: str = pydantic.Field(
        default="",
    )
    latticefile: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("latticefile", "latticeFile"),
        serialization_alias="latticeFile",
    )
    latticename: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("latticename", "latticeName"),
        serialization_alias="latticeName",
    )


class RungeKuttaCommonStruct(pydantic.BaseModel):
    """
    RungeKuttaCommonStruct corresponds to bmad `runge_kutta_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/runge_kutta_mod.f90 on line 5.

    Attributes
    ----------
    num_steps_done : int
        Number of integration steps. Not used by Bmad. For external use.
        Bmad type: integer
        Fortran default: -1
    calc_field_derivatives : bool
        Experimental: For use with extensions to the spin BMT equation that involve
        field derivatives.
        Bmad type: logical
        Fortran default: .false.
    """

    num_steps_done: int = pydantic.Field(
        default=-1,
        description="Number of integration steps. Not used by Bmad. For external use.",
    )
    calc_field_derivatives: bool = pydantic.Field(
        default=False,
        description=(
            "Experimental: For use with extensions to the spin BMT equation that "
            "involve field derivatives."
        ),
    )


class RadIntTrackPointStruct(pydantic.BaseModel):
    """
    RadIntTrackPointStruct corresponds to bmad `rad_int_track_point_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 15.

    Attributes
    ----------
    s_body : float
        Bmad type: real
        Fortran default: 0
    mat6 : float
        Bmad type: real
        Fortran default: 0
    vec0 : float
        Bmad type: real
        Fortran default: 0
    ref_orb_in : CoordStruct
        Bmad type: type
        Fortran default: coord_struct()
    ref_orb_out : CoordStruct
        Bmad type: type
        Fortran default: coord_struct()
    g_x0 : float
        Additional g factors for bends.
        Bmad type: real
        Fortran default: 0
    g_y0 : float
        Additional g factors for bends.
        Bmad type: real
        Fortran default: 0
    dgx_dx : float
        bending strength gradient
        Bmad type: real
        Fortran default: 0
    dgx_dy : float
        bending strength gradient
        Bmad type: real
        Fortran default: 0
    dgy_dx : float
        bending strength gradient
        Bmad type: real
        Fortran default: 0
    dgy_dy : float
        bending strength gradient
        Bmad type: real
        Fortran default: 0
    """

    s_body: float = pydantic.Field(
        default=0,
    )
    mat6: Sequence[float] = pydantic.Field(
        default=0,
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
    )
    ref_orb_in: CoordStruct = pydantic.Field(
        default=None,
    )
    ref_orb_out: CoordStruct = pydantic.Field(
        default=None,
    )
    g_x0: float = pydantic.Field(
        default=0,
        description="Additional g factors for bends.",
    )
    g_y0: float = pydantic.Field(
        default=0,
        description="Additional g factors for bends.",
    )
    dgx_dx: float = pydantic.Field(
        default=0,
        description="bending strength gradient",
    )
    dgx_dy: float = pydantic.Field(
        default=0,
        description="bending strength gradient",
    )
    dgy_dx: float = pydantic.Field(
        default=0,
        description="bending strength gradient",
    )
    dgy_dy: float = pydantic.Field(
        default=0,
        description="bending strength gradient",
    )


class RadIntCache1Struct(pydantic.BaseModel):
    """
    RadIntCache1Struct corresponds to bmad `rad_int_cache1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 28.

    Attributes
    ----------
    pt : RadIntTrackPointStruct
        pt(0:n_pt)
        Bmad type: type
    n_pt : int
        Upper bound of pt(0:n_pt)
        Bmad type: integer
        Fortran default: -1
    cache_type : int
        Bmad type: integer
        Fortran default: no_cache$
    """

    pt: Sequence[RadIntTrackPointStruct] = pydantic.Field(
        default=None,
        description="pt(0:n_pt)",
    )
    n_pt: int = pydantic.Field(
        default=-1,
        description="Upper bound of pt(0:n_pt)",
    )
    cache_type: int = pydantic.Field(
        default=0,
    )


class RadIntCacheStruct(pydantic.BaseModel):
    """
    RadIntCacheStruct corresponds to bmad `rad_int_cache_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 34.

    Attributes
    ----------
    c_ele : RadIntCache1Struct
        Bmad type: type
    in_use : bool
        Bmad type: logical
        Fortran default: .false.
    """

    c_ele: Sequence[RadIntCache1Struct] = pydantic.Field(
        default=None,
    )
    in_use: bool = pydantic.Field(
        default=False,
    )


class RadIntInfoStruct(pydantic.BaseModel):
    """
    RadIntInfoStruct corresponds to bmad `rad_int_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 43.

    Attributes
    ----------
    branch : BranchStruct
        Bmad type: type
    ele : EleStruct
        Bmad type: type
    orbit : CoordStruct
        Bmad type: type
    a : TwissStruct
        Bmad type: type
    b : TwissStruct
        Bmad type: type
    cache_ele : RadIntCache1Struct
        pointer to cache in use
        Bmad type: type
    eta_a : float
        Bmad type: real
    eta_b : float
        Bmad type: real
    g : float
        bending strength (1/bending_radius)
        Bmad type: real
    g2 : float
        bending strength (1/bending_radius)
        Bmad type: real
    g_x : float
        components in x-y plane
        Bmad type: real
    g_y : float
        components in x-y plane
        Bmad type: real
    dg2_x : float
        Bmad type: real
    dg2_y : float
        Bmad type: real
    """

    branch: BranchStruct = pydantic.Field(
        default=None,
    )
    ele: EleStruct = pydantic.Field(
        default=None,
    )
    orbit: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )
    a: TwissStruct = pydantic.Field(
        default=None,
    )
    b: TwissStruct = pydantic.Field(
        default=None,
    )
    cache_ele: RadIntCache1Struct = pydantic.Field(
        default=None,
        description="pointer to cache in use",
    )
    eta_a: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
    )
    eta_b: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=4,
    )
    g: float = pydantic.Field(
        default=0.0,
        description="bending strength (1/bending_radius)",
    )
    g2: float = pydantic.Field(
        default=0.0,
        description="bending strength (1/bending_radius)",
    )
    g_x: float = pydantic.Field(
        default=0.0,
        description="components in x-y plane",
    )
    g_y: float = pydantic.Field(
        default=0.0,
        description="components in x-y plane",
    )
    dg2_x: float = pydantic.Field(
        default=0.0,
    )
    dg2_y: float = pydantic.Field(
        default=0.0,
    )


class WigglerModelingCommonStruct(pydantic.BaseModel):
    """
    WigglerModelingCommonStruct corresponds to bmad `wiggler_modeling_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/element_modeling_mod.f90 on line 18.

    Attributes
    ----------
    integral_g2_wgt : float
        Bmad type: real
        Fortran default: 1d4
    integral_g3_wgt : float
        Bmad type: real
        Fortran default: 1d4
    x_wgt : float
        Bmad type: real
        Fortran default: 1d10
    mat6_wgt : float
        Bmad type: real
        Fortran default: 1d6
    drift_len_wgt : float
        Bmad type: real
        Fortran default: 1d5
    g_step : float
        Step size for calculating derivatives
        Bmad type: real
        Fortran default: 1d-8
    k_step : float
        Step size for calculating derivatives
        Bmad type: real
        Fortran default: 1d-7
    len_step : float
        Step size for calculating derivatives
        Bmad type: real
        Fortran default: 1d-6
    integration_ds : float
        meters
        Bmad type: real
        Fortran default: 0.001
    drift_len_min : float
        Bmad type: real
        Fortran default: .01
    len_drifts : float
        Bmad type: real
    len_d_end : float
        Bmad type: real
    len_d_end2 : float
        Bmad type: real
    print_results : bool
        Bmad type: logical
        Fortran default: .false.
    """

    integral_g2_wgt: float = pydantic.Field(
        default=10000.0,
    )
    integral_g3_wgt: float = pydantic.Field(
        default=10000.0,
    )
    x_wgt: float = pydantic.Field(
        default=10000000000.0,
    )
    mat6_wgt: float = pydantic.Field(
        default=1000000.0,
    )
    drift_len_wgt: float = pydantic.Field(
        default=100000.0,
    )
    g_step: float = pydantic.Field(
        default=1e-08,
        description="Step size for calculating derivatives",
    )
    k_step: float = pydantic.Field(
        default=1e-07,
        description="Step size for calculating derivatives",
    )
    len_step: float = pydantic.Field(
        default=1e-06,
        description="Step size for calculating derivatives",
    )
    integration_ds: float = pydantic.Field(
        default=0.001,
        description="meters",
    )
    drift_len_min: float = pydantic.Field(
        default=0.01,
    )
    len_drifts: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    len_d_end: float = pydantic.Field(
        default=0.0,
    )
    len_d_end2: float = pydantic.Field(
        default=0.0,
    )
    print_results: bool = pydantic.Field(
        default=False,
    )


class MadEnergyStruct(pydantic.BaseModel):
    """
    MadEnergyStruct corresponds to bmad `mad_energy_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/mad_mod.f90 on line 14.

    Attributes
    ----------
    total : float
        Bmad type: real
    beta : float
        normalized velocity: v/c
        Bmad type: real
    gamma : float
        relativistic factor: 1/sqrt(1-beta^2)
        Bmad type: real
    kinetic : float
        kinetic energy
        Bmad type: real
    p0c : float
        particle momentum
        Bmad type: real
    particle : int
        particle species
        Bmad type: integer
    """

    total: float = pydantic.Field(
        default=0.0,
    )
    beta: float = pydantic.Field(
        default=0.0,
        description="normalized velocity: v/c",
    )
    gamma: float = pydantic.Field(
        default=0.0,
        description="relativistic factor: 1/sqrt(1-beta^2)",
    )
    kinetic: float = pydantic.Field(
        default=0.0,
        description="kinetic energy",
    )
    p0c: float = pydantic.Field(
        default=0.0,
        description="particle momentum",
    )
    particle: int = pydantic.Field(
        default=0,
        description="particle species",
    )


class MadMapStruct(pydantic.BaseModel):
    """
    MadMapStruct corresponds to bmad `mad_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/mad_mod.f90 on line 23.

    Attributes
    ----------
    k : float
        0th order map.
        Bmad type: real
    r : float
        1st order map.
        Bmad type: real
    t : float
        2nd order map.
        Bmad type: real
    """

    k: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="0th order map.",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        description="1st order map.",
    )
    t: Sequence[float] = pydantic.Field(
        default=0.0,
        description="2nd order map.",
    )


class EleAttributeStruct(pydantic.BaseModel):
    """
    EleAttributeStruct corresponds to bmad `ele_attribute_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/attribute_mod.f90 on line 25.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: null_name$
    state : int
        See above.
        Bmad type: integer
        Fortran default: does_not_exist$
    kind : int
        Is_switch$, is_real$, etc. See attribute_type routine.
        Bmad type: integer
        Fortran default: unknown$
    units : str
        EG: 'T*m'.
        Bmad type: character
        Fortran default: ''
    ix_attrib : int
        Attribute index. Frequently will be where in the
        Bmad type: integer
        Fortran default: -1
    value : float
        Used by type_ele.
        Bmad type: real
        Fortran default: real_garbage$
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    state: int = pydantic.Field(
        default=0,
        description="See above.",
    )
    kind: int = pydantic.Field(
        default=0,
        description="Is_switch$, is_real$, etc. See attribute_type routine.",
    )
    units: str = pydantic.Field(
        default="",
        max_length=16,
        description="EG: 'T*m'.",
    )
    ix_attrib: int = pydantic.Field(
        default=-1,
        description="Attribute index. Frequently will be where in the",
    )
    value: float = pydantic.Field(
        default=0.0,
        description="Used by type_ele.",
    )


class CrystalStruct(pydantic.BaseModel):
    """
    CrystalStruct corresponds to bmad `crystal_struct`
    which is in Users/klauer/Repos/bmad/bmad/dummy_routines/xraylib_dummy.f90 on line 19.

    Attributes
    ----------
    volume : float
        Bmad type: real
    """

    volume: float = pydantic.Field(
        default=0.0,
    )


class Compounddatanist(pydantic.BaseModel):
    """
    Compounddatanist corresponds to bmad `compounddatanist`
    which is in Users/klauer/Repos/bmad/bmad/dummy_routines/xraylib_dummy.f90 on line 23.

    Attributes
    ----------
    nelements : int
        Bmad type: integer
    elements : int
        Bmad type: integer
    massfractions : float
        Bmad type: real
    density : float
        Bmad type: real
    """

    nelements: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nelements", "nElements"),
        serialization_alias="nElements",
    )
    elements: Sequence[int] = pydantic.Field(
        default=0,
        max_length=1,
    )
    massfractions: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=1,
        validation_alias=pydantic.AliasChoices("massfractions", "massFractions"),
        serialization_alias="massFractions",
    )
    density: float = pydantic.Field(
        default=0.0,
    )


class XrlcomplexC(pydantic.BaseModel):
    """
    XrlcomplexC corresponds to bmad `xrlComplex_C`
    which is in Users/klauer/Repos/bmad/bmad/dummy_routines/xraylib_dummy.f90 on line 28.

    Attributes
    ----------
    re : float
        Bmad type: REAL
    im : float
        Bmad type: REAL
    """

    re: float = pydantic.Field(
        default=0.0,
    )
    im: float = pydantic.Field(
        default=0.0,
    )
