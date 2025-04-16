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
from .sim_utils_structs import (
    BicubicCmplxCoefStruct,
    NametableStruct,
    RandomStateStruct,
    SplineStruct,
    TricubicCmplxCoefStruct,
)
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

Complex = Annotated[
    complex,
    PlainValidator(
        lambda x: x if isinstance(x, complex) else complex(x.get("real", x.get("imag")))
    ),
    PlainSerializer(lambda x: {"real": x.real, "imag": x.imag}, return_type=dict),
]


class BendExactCoefStruct(pydantic.BaseModel):
    """
    BendExactCoefStruct corresponds to bmad `bend_exact_coef_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/bend_exact_multipole_field.f90 on line 30.

    Attributes
    ----------
    cutoff_minus : float
        Crossover between exact formula and pade approximant
        Bmad type: real
        Fortran default: 0
    cutoff_plus : float
        Crossover between exact formula and pade approximant Exact formula coefs
        Bmad type: real
        Fortran default: 0
    d2_pade_denom_coef : float
        Non-zero coefs are in the range [0:n_d2_pade_denom]
        Bmad type: real
        Fortran default: 0
    d2_pade_numer_coef : float
        Non-zero coefs are in the range [0:n_d2_pade_numer]
        Bmad type: real
        Fortran default: 0
    exact_log_coef : float
        Non-zero coefs are in the range [0:n_exact_log] pade approximant
        Bmad type: real
        Fortran default: 0
    exact_non_coef : float
        Non-zero coefs are in the range [0:n_exact_non]
        Bmad type: real
        Fortran default: 0
    n_d2_pade_denom : int
        Bmad type: integer
        Fortran default: 0
    n_d2_pade_numer : int
        Bmad type: integer
        Fortran default: 0
    n_exact_log : int
        Bmad type: integer
        Fortran default: 0
    n_exact_non : int
        Bmad type: integer
        Fortran default: 0
    n_pade_denom : int
        Bmad type: integer
        Fortran default: 0
    n_pade_numer : int
        Bmad type: integer
        Fortran default: 0
    order : int
        Bmad type: integer
        Fortran default: 0
    pade_denom_coef : float
        Non-zero coefs are in the range [0:n_pade_denom] 2nd derivative pade
        approximant.
        Bmad type: real
        Fortran default: 0
    pade_numer_coef : float
        Non-zero coefs are in the range [0:n_pade_numer]
        Bmad type: real
        Fortran default: 0
    """

    cutoff_minus: float = pydantic.Field(
        default=0,
        description="Crossover between exact formula and pade approximant",
    )
    cutoff_plus: float = pydantic.Field(
        default=0,
        description="Crossover between exact formula and pade approximant Exact formula coefs",
    )
    d2_pade_denom_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Non-zero coefs are in the range [0:n_d2_pade_denom]",
    )
    d2_pade_numer_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Non-zero coefs are in the range [0:n_d2_pade_numer]",
    )
    exact_log_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Non-zero coefs are in the range [0:n_exact_log] pade approximant",
    )
    exact_non_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Non-zero coefs are in the range [0:n_exact_non]",
    )
    n_d2_pade_denom: int = pydantic.Field(
        default=0,
    )
    n_d2_pade_numer: int = pydantic.Field(
        default=0,
    )
    n_exact_log: int = pydantic.Field(
        default=0,
    )
    n_exact_non: int = pydantic.Field(
        default=0,
    )
    n_pade_denom: int = pydantic.Field(
        default=0,
    )
    n_pade_numer: int = pydantic.Field(
        default=0,
    )
    order: int = pydantic.Field(
        default=0,
    )
    pade_denom_coef: Sequence[float] = pydantic.Field(
        default=0,
        description=(
            "Non-zero coefs are in the range [0:n_pade_denom] 2nd derivative pade "
            "approximant."
        ),
    )
    pade_numer_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Non-zero coefs are in the range [0:n_pade_numer]",
    )


class PoleCoefStruct(pydantic.BaseModel):
    """
    PoleCoefStruct corresponds to bmad `pole_coef_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/bend_exact_multipole_field.f90 on line 209.

    Attributes
    ----------
    derivative : float
        Bmad type: real
        Fortran default: 0
    derivative2 : float
        Bmad type: real
        Fortran default: 0
    value : float
        Bmad type: real
        Fortran default: 0
    """

    derivative: float = pydantic.Field(
        default=0,
    )
    derivative2: float = pydantic.Field(
        default=0,
    )
    value: float = pydantic.Field(
        default=0,
    )


class PureBendMultipoleStruct(pydantic.BaseModel):
    """
    PureBendMultipoleStruct corresponds to bmad `pure_bend_multipole_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/bend_exact_multipole_field.f90 on line 595.

    Attributes
    ----------
    convert : float
        Bmad type: real
    """

    convert: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class ClosedOrbComStruct(pydantic.BaseModel):
    """
    ClosedOrbComStruct corresponds to bmad `closed_orb_com_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/closed_orbit_calc.f90 on line 107.

    Attributes
    ----------
    a_vec : float
        Bmad type: real
    dz_step : float
        Bmad type: real
    rf_wavelen : float
        Bmad type: real
    t1 : float
        Bmad type: real
    """

    a_vec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    dz_step: float = pydantic.Field(
        default=0.0,
    )
    rf_wavelen: float = pydantic.Field(
        default=0.0,
    )
    t1: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class MatrixSave(pydantic.BaseModel):
    """
    MatrixSave corresponds to bmad `matrix_save`
    which is in Users/klauer/Repos/bmad/bmad/code/closed_orbit_calc.f90 on line 99.

    Attributes
    ----------
    map_ref_orb_in : CoordStruct
        Bmad type: coord_struct
    map_ref_orb_out : CoordStruct
        Bmad type: coord_struct
    mat6 : float
        Bmad type: real
    vec0 : float
        Bmad type: real
    """

    map_ref_orb_in: CoordStruct = pydantic.Field(
        default=None,
    )
    map_ref_orb_out: CoordStruct = pydantic.Field(
        default=None,
    )
    mat6: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )


class ThisOrder1Struct(pydantic.BaseModel):
    """
    ThisOrder1Struct corresponds to bmad `this_order1_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/ele_order_calc.f90 on line 21.

    Attributes
    ----------
    ix_ele : int
        element index in branch
        Bmad type: integer
    ix_nt : int
        Nametable index
        Bmad type: integer
    """

    ix_ele: int = pydantic.Field(
        default=0,
        description="element index in branch",
    )
    ix_nt: int = pydantic.Field(
        default=0,
        description="Nametable index",
    )


class ThisOrderStruct(pydantic.BaseModel):
    """
    ThisOrderStruct corresponds to bmad `this_order_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/ele_order_calc.f90 on line 26.

    Attributes
    ----------
    ele : ThisOrder1Struct
        Bmad type: this_order1_struct
    """

    ele: Sequence[ThisOrder1Struct] = pydantic.Field(
        default=None,
    )


class LordSlave1Struct(pydantic.BaseModel):
    """
    LordSlave1Struct corresponds to bmad `lord_slave1_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/lat_sanity_check.f90 on line 23.

    Attributes
    ----------
    n_lord : int
        Bmad type: integer
        Fortran default: 0
    n_lord_field : int
        Bmad type: integer
        Fortran default: 0
    n_slave : int
        Bmad type: integer
        Fortran default: 0
    n_slave_field : int
        Bmad type: integer
        Fortran default: 0
    """

    n_lord: int = pydantic.Field(
        default=0,
    )
    n_lord_field: int = pydantic.Field(
        default=0,
    )
    n_slave: int = pydantic.Field(
        default=0,
    )
    n_slave_field: int = pydantic.Field(
        default=0,
    )


class LordSlaveStruct(pydantic.BaseModel):
    """
    LordSlaveStruct corresponds to bmad `lord_slave_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/lat_sanity_check.f90 on line 30.

    Attributes
    ----------
    ele : LordSlave1Struct
        Bmad type: lord_slave1_struct
    """

    ele: Sequence[LordSlave1Struct] = pydantic.Field(
        default=None,
    )


class EleIndexTemp(pydantic.BaseModel):
    """
    EleIndexTemp corresponds to bmad `ele_index_temp`
    which is in Users/klauer/Repos/bmad/bmad/code/remove_eles_from_lat.f90 on line 64.

    Attributes
    ----------
    loc : ThisEleLocStruct
        maps old -> new
        Bmad type: this_ele_loc_struct
    """

    loc: Sequence[ThisEleLocStruct] = pydantic.Field(
        default=None,
        description="maps old -> new",
    )


class ThisEleLocStruct(pydantic.BaseModel):
    """
    ThisEleLocStruct corresponds to bmad `this_ele_loc_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/remove_eles_from_lat.f90 on line 57.

    Attributes
    ----------
    new_ix_branch : int
        Bmad type: integer
        Fortran default: 0
    new_ix_ele : int
        Bmad type: integer
        Fortran default: -1
    old_ix_branch : int
        Bmad type: integer
        Fortran default: 0
    old_ix_ele : int
        Bmad type: integer
        Fortran default: -1
    """

    new_ix_branch: int = pydantic.Field(
        default=0,
    )
    new_ix_ele: int = pydantic.Field(
        default=-1,
    )
    old_ix_branch: int = pydantic.Field(
        default=0,
    )
    old_ix_ele: int = pydantic.Field(
        default=-1,
    )


class BasketStruct(pydantic.BaseModel):
    """
    BasketStruct corresponds to bmad `basket_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/rf_clock_setup.f90 on line 41.

    Attributes
    ----------
    clock_period : float
        Bmad type: real
    max_harmonic : int
        Bmad type: integer
        Fortran default: 1
    n_in_basket : int
        Bmad type: integer
        Fortran default: 1
    """

    clock_period: float = pydantic.Field(
        default=0.0,
    )
    max_harmonic: int = pydantic.Field(
        default=1,
    )
    n_in_basket: int = pydantic.Field(
        default=1,
    )


class RfEleInfoStruct(pydantic.BaseModel):
    """
    RfEleInfoStruct corresponds to bmad `rf_ele_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/rf_clock_setup.f90 on line 34.

    Attributes
    ----------
    ele : EleStruct
        Bmad type: ele_struct
    ix_basket : int
        Bmad type: integer
    ix_freq : int
        Index for ac_kicker where there can be multiple frequencies
        Bmad type: integer
    rf_freq : float
        Bmad type: real
    """

    ele: EleStruct = pydantic.Field(
        default=None,
    )
    ix_basket: int = pydantic.Field(
        default=0,
    )
    ix_freq: int = pydantic.Field(
        default=0,
        description="Index for ac_kicker where there can be multiple frequencies",
    )
    rf_freq: float = pydantic.Field(
        default=0.0,
    )


class MultiOrbStruct(pydantic.BaseModel):
    """
    MultiOrbStruct corresponds to bmad `multi_orb_struct`
    which is in Users/klauer/Repos/bmad/bmad/code/twiss_from_tracking.f90 on line 47.

    Attributes
    ----------
    orb : CoordStruct
        Bmad type: coord_struct
    """

    orb: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )


class Compounddatanist(pydantic.BaseModel):
    """
    Compounddatanist corresponds to bmad `compounddatanist`
    which is in Users/klauer/Repos/bmad/bmad/dummy_routines/xraylib_dummy.f90 on line 23.

    Attributes
    ----------
    density : float
        Bmad type: real
    elements : int
        Bmad type: integer
    massfractions : float
        Bmad type: real
    nelements : int
        Bmad type: integer
    """

    density: float = pydantic.Field(
        default=0.0,
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
    nelements: int = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("nelements", "nElements"),
        serialization_alias="nElements",
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


class XrlcomplexC(pydantic.BaseModel):
    """
    XrlcomplexC corresponds to bmad `xrlComplex_C`
    which is in Users/klauer/Repos/bmad/bmad/dummy_routines/xraylib_dummy.f90 on line 28.

    Attributes
    ----------
    im : float
        Bmad type: REAL
    re : float
        Bmad type: REAL
    """

    im: float = pydantic.Field(
        default=0.0,
    )
    re: float = pydantic.Field(
        default=0.0,
    )


class Hdf5InfoStruct(pydantic.BaseModel):
    """
    Hdf5InfoStruct corresponds to bmad `hdf5_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/hdf5/hdf5_interface.f90 on line 41.

    Attributes
    ----------
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
    element_type : int
        Type of the element. See above.
        Bmad type: integer
        Fortran default: -1
    num_attributes : int
        Number of associated attributes. Used for groups and datasets only.
        Bmad type: integer
        Fortran default: -1
    """

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
    element_type: int = pydantic.Field(
        default=-1,
        description="Type of the element. See above.",
    )
    num_attributes: int = pydantic.Field(
        default=-1,
        description="Number of associated attributes. Used for groups and datasets only.",
    )


class PmdUnitStruct(pydantic.BaseModel):
    """
    PmdUnitStruct corresponds to bmad `pmd_unit_struct`
    which is in Users/klauer/Repos/bmad/bmad/hdf5/hdf5_openpmd_mod.f90 on line 9.

    Attributes
    ----------
    unitdimension : float
        SI Base Exponents
        Bmad type: real
        Fortran default: 0
    unitsi : float
        Conversion to SI
        Bmad type: real
        Fortran default: 0
    unitsymbol : str
        Native units name. EG 'eV'
        Bmad type: character
        Fortran default: ''
    """

    unitdimension: Sequence[float] = pydantic.Field(
        default=0,
        max_length=7,
        description="SI Base Exponents",
        validation_alias=pydantic.AliasChoices("unitdimension", "unitDimension"),
        serialization_alias="unitDimension",
    )
    unitsi: float = pydantic.Field(
        default=0,
        description="Conversion to SI",
        validation_alias=pydantic.AliasChoices("unitsi", "unitSI"),
        serialization_alias="unitSI",
    )
    unitsymbol: str = pydantic.Field(
        default="",
        max_length=8,
        description="Native units name. EG 'eV'",
        validation_alias=pydantic.AliasChoices("unitsymbol", "unitSymbol"),
        serialization_alias="unitSymbol",
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
    gpt_filename : str
        Blank => Append '.gpt' to Bmad lattice file name.
        Bmad type: character
        Fortran default: ''
    header_file_name : str
        Header file to include in gpt file.
        Bmad type: character
        Fortran default: ''
    only_write_autophase_parameters : bool
        Option to only write phasing info
        Bmad type: logical
        Fortran default: .false.
    tracking_end_element : str
        Bmad lattice element name or index.
        Bmad type: character
        Fortran default: ''
    """

    fieldmap_dimension: int = pydantic.Field(
        default=3,
        description="Dimensions for field map. 1 or 3",
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
    only_write_autophase_parameters: bool = pydantic.Field(
        default=False,
        description="Option to only write phasing info",
    )
    tracking_end_element: str = pydantic.Field(
        default="",
        max_length=40,
        description="Bmad lattice element name or index.",
    )


class EmTaylorCoefStruct_(pydantic.BaseModel):
    """
    EmTaylorCoefStruct_ corresponds to bmad `em_taylor_coef_struct`
    which is in Users/klauer/Repos/bmad/bmad/low_level/gen_grad1_to_em_taylor.f90 on line 21.

    Attributes
    ----------
    c : float
        (deriv-order, x_power)  Note: x_power + y_power = deriv_order
        Bmad type: real
    """

    c: Sequence[float] = pydantic.Field(
        default=0.0,
        description="(deriv-order, x_power)  Note: x_power + y_power = deriv_order",
    )


class EmTaylorCoefStruct(pydantic.BaseModel):
    """
    EmTaylorCoefStruct corresponds to bmad `em_taylor_coef_struct`
    which is in Users/klauer/Repos/bmad/bmad/low_level/gen_grad_at_s_to_em_taylor.f90 on line 21.

    Attributes
    ----------
    c : float
        (deriv-order, x_power)  Note: x_power + y_power = deriv_order
        Bmad type: real
    """

    c: Sequence[float] = pydantic.Field(
        default=0.0,
        description="(deriv-order, x_power)  Note: x_power + y_power = deriv_order",
    )


class WigglerComputationsStruct(pydantic.BaseModel):
    """
    WigglerComputationsStruct corresponds to bmad `wiggler_computations_struct`
    which is in Users/klauer/Repos/bmad/bmad/low_level/symp_lie_bmad.f90 on line 32.

    Attributes
    ----------
    c_x : float
        Bmad type: real
        Fortran default: 0
    c_y : float
        Bmad type: real
        Fortran default: 0
    c_z : float
        Bmad type: real
        Fortran default: 0
    coef_ax : float
        Bmad type: real
        Fortran default: 0
    coef_ay : float
        Bmad type: real
        Fortran default: 0
    coef_az : float
        Bmad type: real
        Fortran default: 0
    integral_cx : float
        Bmad type: real
        Fortran default: 0
    integral_cy : float
        Bmad type: real
        Fortran default: 0
    integral_sx : float
        Bmad type: real
        Fortran default: 0
    integral_sy : float
        Bmad type: real
        Fortran default: 0
    s_x : float
        Bmad type: real
        Fortran default: 0
    s_y : float
        Bmad type: real
        Fortran default: 0
    s_z : float
        Bmad type: real
        Fortran default: 0
    sx_over_kx : float
        Bmad type: real
        Fortran default: 0
    sy_over_ky : float
        Bmad type: real
        Fortran default: 0
    sz_over_kz : float
        Bmad type: real
        Fortran default: 0
    trig_x : int
        Bmad type: integer
        Fortran default: 0
    trig_y : int
        Bmad type: integer
        Fortran default: 0
    """

    c_x: float = pydantic.Field(
        default=0,
    )
    c_y: float = pydantic.Field(
        default=0,
    )
    c_z: float = pydantic.Field(
        default=0,
    )
    coef_ax: float = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("coef_ax", "coef_Ax"),
        serialization_alias="coef_Ax",
    )
    coef_ay: float = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("coef_ay", "coef_Ay"),
        serialization_alias="coef_Ay",
    )
    coef_az: float = pydantic.Field(
        default=0,
        validation_alias=pydantic.AliasChoices("coef_az", "coef_Az"),
        serialization_alias="coef_Az",
    )
    integral_cx: float = pydantic.Field(
        default=0,
    )
    integral_cy: float = pydantic.Field(
        default=0,
    )
    integral_sx: float = pydantic.Field(
        default=0,
    )
    integral_sy: float = pydantic.Field(
        default=0,
    )
    s_x: float = pydantic.Field(
        default=0,
    )
    s_y: float = pydantic.Field(
        default=0,
    )
    s_z: float = pydantic.Field(
        default=0,
    )
    sx_over_kx: float = pydantic.Field(
        default=0,
    )
    sy_over_ky: float = pydantic.Field(
        default=0,
    )
    sz_over_kz: float = pydantic.Field(
        default=0,
    )
    trig_x: int = pydantic.Field(
        default=0,
    )
    trig_y: int = pydantic.Field(
        default=0,
    )


class ConverterCommonStruct(pydantic.BaseModel):
    """
    ConverterCommonStruct corresponds to bmad `converter_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/low_level/track_a_converter.f90 on line 38.

    Attributes
    ----------
    dist : ConverterDistributionStruct
        Bmad type: converter_distribution_struct
    dxds_integ : float
        Bmad type: real
    dxds_spline : SplineStruct
        Bmad type: spline_struct
    integ_prob_tot : float
        Bmad type: real
    ipc : int
        Bmad type: integer
    ppcr : ConverterProbPcRStruct
        Bmad type: converter_prob_pc_r_struct
    r_ran : float
        Bmad type: real
    """

    dist: ConverterDistributionStruct = pydantic.Field(
        default=None,
    )
    dxds_integ: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    dxds_spline: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    integ_prob_tot: float = pydantic.Field(
        default=0.0,
    )
    ipc: int = pydantic.Field(
        default=0,
    )
    ppcr: ConverterProbPcRStruct = pydantic.Field(
        default=None,
    )
    r_ran: float = pydantic.Field(
        default=0.0,
    )


class ConverterParamStorageStruct(pydantic.BaseModel):
    """
    ConverterParamStorageStruct corresponds to bmad `converter_param_storage_struct`
    which is in Users/klauer/Repos/bmad/bmad/low_level/track_a_converter.f90 on line 28.

    Attributes
    ----------
    alpha_x : float
        Bmad type: real
    alpha_y : float
        Bmad type: real
    beta : float
        Bmad type: real
    c_x : float
        Bmad type: real
    dxds : float
        Bmad type: real
    dxds_max : float
        Bmad type: real
    dxds_min : float
        Bmad type: real
    dyds : float
        Bmad type: real
    dyds_max : float
        Bmad type: real
    integ_prob_tot : float
        Bmad type: real
    lost : bool
        Bmad type: logical
        Fortran default: .false.
    pc_out : float
        Bmad type: real
    r : float
        Bmad type: real
    rel_spin_z : float
        Bmad type: real
    weight : float
        Bmad type: real
    """

    alpha_x: float = pydantic.Field(
        default=0.0,
    )
    alpha_y: float = pydantic.Field(
        default=0.0,
    )
    beta: float = pydantic.Field(
        default=0.0,
    )
    c_x: float = pydantic.Field(
        default=0.0,
    )
    dxds: float = pydantic.Field(
        default=0.0,
    )
    dxds_max: float = pydantic.Field(
        default=0.0,
    )
    dxds_min: float = pydantic.Field(
        default=0.0,
    )
    dyds: float = pydantic.Field(
        default=0.0,
    )
    dyds_max: float = pydantic.Field(
        default=0.0,
    )
    integ_prob_tot: float = pydantic.Field(
        default=0.0,
    )
    lost: bool = pydantic.Field(
        default=False,
    )
    pc_out: float = pydantic.Field(
        default=0.0,
    )
    r: float = pydantic.Field(
        default=0.0,
    )
    rel_spin_z: float = pydantic.Field(
        default=0.0,
    )
    weight: float = pydantic.Field(
        default=0.0,
    )


class InternalStateStruct(pydantic.BaseModel):
    """
    InternalStateStruct corresponds to bmad `internal_state_struct`
    which is in Users/klauer/Repos/bmad/bmad/low_level/track_a_lcavity.f90 on line 40.

    Attributes
    ----------
    e_end : float
        Bmad type: real
    e_start : float
        Bmad type: real
    beta_end : float
        Bmad type: real
    beta_start : float
        Bmad type: real
    cdt_ref : float
        Bmad type: real
    dphase : float
        Bmad type: real
    gradient_max : float
        Bmad type: real
    pc_end : float
        Bmad type: real
    pc_start : float
        Bmad type: real
    phase0 : float
        Bmad type: real
    step_len : float
        Bmad type: real
    """

    e_end: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e_end", "E_end"),
        serialization_alias="E_end",
    )
    e_start: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("e_start", "E_start"),
        serialization_alias="E_start",
    )
    beta_end: float = pydantic.Field(
        default=0.0,
    )
    beta_start: float = pydantic.Field(
        default=0.0,
    )
    cdt_ref: float = pydantic.Field(
        default=0.0,
    )
    dphase: float = pydantic.Field(
        default=0.0,
    )
    gradient_max: float = pydantic.Field(
        default=0.0,
    )
    pc_end: float = pydantic.Field(
        default=0.0,
    )
    pc_start: float = pydantic.Field(
        default=0.0,
    )
    phase0: float = pydantic.Field(
        default=0.0,
    )
    step_len: float = pydantic.Field(
        default=0.0,
    )


class EleAttributeStruct(pydantic.BaseModel):
    """
    EleAttributeStruct corresponds to bmad `ele_attribute_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/attribute_mod.f90 on line 25.

    Attributes
    ----------
    ix_attrib : int
        Attribute index. Frequently will be where in the ele%value(:) array the
        attribute is.
        Bmad type: integer
        Fortran default: -1
    kind : int
        Is_switch$, is_real$, etc. See attribute_type routine.
        Bmad type: integer
        Fortran default: unknown$
    name : str
        Bmad type: character
        Fortran default: null_name$
    state : int
        See above.
        Bmad type: integer
        Fortran default: does_not_exist$
    units : str
        EG: 'T*m'.
        Bmad type: character
        Fortran default: ''
    value : float
        Used by type_ele.
        Bmad type: real
        Fortran default: real_garbage$
    """

    ix_attrib: int = pydantic.Field(
        default=-1,
        description=(
            "Attribute index. Frequently will be where in the ele%value(:) array the "
            "attribute is."
        ),
    )
    kind: int = pydantic.Field(
        default=0,
        description="Is_switch$, is_real$, etc. See attribute_type routine.",
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    state: int = pydantic.Field(
        default=0,
        description="See above.",
    )
    units: str = pydantic.Field(
        default="",
        max_length=16,
        description="EG: 'T*m'.",
    )
    value: float = pydantic.Field(
        default=0.0,
        description="Used by type_ele.",
    )


class AcKickerFreqStruct(pydantic.BaseModel):
    """
    AcKickerFreqStruct corresponds to bmad `ac_kicker_freq_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 678.

    Attributes
    ----------
    amp : float
        Bmad type: real
        Fortran default: 0
    f : float
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

    amp: float = pydantic.Field(
        default=0,
    )
    f: float = pydantic.Field(
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
        Bmad type: ac_kicker_time_struct
    frequency : AcKickerFreqStruct
        Bmad type: ac_kicker_freq_struct
    """

    amp_vs_time: Sequence[AcKickerTimeStruct] = pydantic.Field(
        default=None,
    )
    frequency: Sequence[AcKickerFreqStruct] = pydantic.Field(
        default=None,
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
    spline : SplineStruct
        Bmad type: spline_struct
        Fortran default: spline_struct()
    time : float
        Bmad type: real
        Fortran default: 0
    """

    amp: float = pydantic.Field(
        default=0,
    )
    spline: SplineStruct = pydantic.Field(
        default=None,
    )
    time: float = pydantic.Field(
        default=0,
    )


class AnormalModeStruct(pydantic.BaseModel):
    """
    AnormalModeStruct corresponds to bmad `anormal_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1921.

    Attributes
    ----------
    alpha_damp : float
        damping per turn
        Bmad type: real
        Fortran default: 0
    chrom : float
        Chromaticity
        Bmad type: real
        Fortran default: 0
    emittance : float
        Beam emittance (unnormalized). Includes vertical photon opening angle.
        Bmad type: real
        Fortran default: 0
    emittance_no_vert : float
        Unnormalized beam emittance without the vertical photon opening angle taken
        into account.
        Bmad type: real
        Fortran default: 0
    j_damp : float
        damping partition number
        Bmad type: real
        Fortran default: 0
    synch_int : float
        Synchrotron integrals
        Bmad type: real
        Fortran default: 0
    tune : float
        "Fractional" tune in radians
        Bmad type: real
        Fortran default: 0
    """

    alpha_damp: float = pydantic.Field(
        default=0,
        description="damping per turn",
    )
    chrom: float = pydantic.Field(
        default=0,
        description="Chromaticity",
    )
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
    j_damp: float = pydantic.Field(
        default=0,
        description="damping partition number",
    )
    synch_int: Sequence[float] = pydantic.Field(
        default=0,
        description="Synchrotron integrals",
    )
    tune: float = pydantic.Field(
        default=0,
        description="'Fractional' tune in radians",
    )


class ApertureParamStruct(pydantic.BaseModel):
    """
    ApertureParamStruct corresponds to bmad `aperture_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2070.

    Attributes
    ----------
    abs_accuracy : float
        Absolute resolution of bracketed aperture (meters).
        Bmad type: real
        Fortran default: 1e-5_rp
    max_angle : float
        Bmad type: real
        Fortran default: pi
    min_angle : float
        Bmad type: real
        Fortran default: 0
    n_angle : int
        Bmad type: integer
        Fortran default: 9
    n_turn : int
        Number of turns a particle must survive.
        Bmad type: integer
        Fortran default: 100
    rel_accuracy : float
        Relative resolution of bracketed aperture.
        Bmad type: real
        Fortran default: 1e-2_rp
    start_ele : str
        Element to start tracking at.
        Bmad type: character
        Fortran default: ''
    x_init : float
        Initial x coordinate to start with for theta_xy = 0.
        Bmad type: real
        Fortran default: 1e-3_rp
    y_init : float
        Initial y coordinate to start with for theta_xy = pi/2.
        Bmad type: real
        Fortran default: 1e-3_rp
    """

    abs_accuracy: float = pydantic.Field(
        default=1e-05,
        description="Absolute resolution of bracketed aperture (meters).",
    )
    max_angle: float = pydantic.Field(
        default=0.0,
    )
    min_angle: float = pydantic.Field(
        default=0,
    )
    n_angle: int = pydantic.Field(
        default=9,
    )
    n_turn: int = pydantic.Field(
        default=100,
        description="Number of turns a particle must survive.",
    )
    rel_accuracy: float = pydantic.Field(
        default=0.01,
        description="Relative resolution of bracketed aperture.",
    )
    start_ele: str = pydantic.Field(
        default="",
        max_length=40,
        description="Element to start tracking at.",
    )
    x_init: float = pydantic.Field(
        default=0.001,
        description="Initial x coordinate to start with for theta_xy = 0.",
    )
    y_init: float = pydantic.Field(
        default=0.001,
        description="Initial y coordinate to start with for theta_xy = pi/2.",
    )


class AperturePointStruct(pydantic.BaseModel):
    """
    AperturePointStruct corresponds to bmad `aperture_point_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2061.

    Attributes
    ----------
    i_turn : int
        turn particle lost at
        Bmad type: integer
    ix_ele : int
        ele index particle lost at
        Bmad type: integer
    plane : int
        plane determining loss
        Bmad type: integer
    x : float
        (x,y) aperture point with respect to the reference orbit.
        Bmad type: real
    y : float
        (x,y) aperture point with respect to the reference orbit.
        Bmad type: real
    """

    i_turn: int = pydantic.Field(
        default=0,
        description="turn particle lost at",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="ele index particle lost at",
    )
    plane: int = pydantic.Field(
        default=0,
        description="plane determining loss",
    )
    x: float = pydantic.Field(
        default=0.0,
        description="(x,y) aperture point with respect to the reference orbit.",
    )
    y: float = pydantic.Field(
        default=0.0,
        description="(x,y) aperture point with respect to the reference orbit.",
    )


class ApertureScanStruct(pydantic.BaseModel):
    """
    ApertureScanStruct corresponds to bmad `aperture_scan_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2084.

    Attributes
    ----------
    point : AperturePointStruct
        Set of aperture points at different angles.
        Bmad type: aperture_point_struct
    pz_start : float
        Starting pz.
        Bmad type: real
        Fortran default: 0
    ref_orb : CoordStruct
        Ref orbit around which the scan is made.
        Bmad type: coord_struct
    """

    point: Sequence[AperturePointStruct] = pydantic.Field(
        default=None,
        description="Set of aperture points at different angles.",
    )
    pz_start: float = pydantic.Field(
        default=0,
        description="Starting pz.",
    )
    ref_orb: CoordStruct = pydantic.Field(
        default=None,
        description="Ref orbit around which the scan is made.",
    )


class BeamInitStruct(pydantic.BaseModel):
    """
    BeamInitStruct corresponds to bmad `beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1135.

    Attributes
    ----------
    kv : KvBeamInitStruct
        KV beam distribution
        Bmad type: kv_beam_init_struct
        Fortran default: kv_beam_init_struct()
    a_emit : float
        a-mode emittance
        Bmad type: real
        Fortran default: 0
    a_norm_emit : float
        a-mode normalized emittance (emit * beta * gamma)
        Bmad type: real
        Fortran default: 0
    b_emit : float
        b-mode emittance
        Bmad type: real
        Fortran default: 0
    b_norm_emit : float
        b-mode normalized emittance (emit * beta * gamma)
        Bmad type: real
        Fortran default: 0
    bunch_charge : float
        charge (Coul) in a bunch.
        Bmad type: real
        Fortran default: 0
    center : float
        Bench phase space center offset relative to reference.
        Bmad type: real
        Fortran default: 0
    center_jitter : float
        Bunch center rms jitter
        Bmad type: real
        Fortran default: 0.0
    dpz_dz : float
        Correlation of Pz with long position.
        Bmad type: real
        Fortran default: 0
    distribution_type : str
        distribution type (in x-px, y-py, and z-pz planes) "ELLIPSE", "KV", "GRID",
        "FILE", "RAN_GAUSS" or "" = "RAN_GAUSS"
        Bmad type: character
        Fortran default: 'RAN_GAUSS'
    dt_bunch : float
        Time between bunches.
        Bmad type: real
        Fortran default: 0
    ellipse : EllipseBeamInitStruct
        Ellipse beam distribution
        Bmad type: ellipse_beam_init_struct
        Fortran default: ellipse_beam_init_struct()
    emit_jitter : float
        a and b bunch emittance rms jitter normalized to emittance
        Bmad type: real
        Fortran default: 0.0
    file_name : str
        OLD!! DO NOT USE!!
        Bmad type: character
        Fortran default: ''
    full_6d_coupling_calc : bool
        Use V from 6x6 1-turn mat to match distribution? Else use 4x4 1-turn mat used.
        Bmad type: logical
        Fortran default: .false.
    grid : GridBeamInitStruct
        Grid beam distribution
        Bmad type: grid_beam_init_struct
        Fortran default: grid_beam_init_struct()
    ix_turn : int
        Turn index used to adjust particles time if needed.
        Bmad type: integer
        Fortran default: 0
    n_bunch : int
        Number of bunches.
        Bmad type: integer
        Fortran default: 0
    n_particle : int
        Number of particles per bunch.
        Bmad type: integer
        Fortran default: 0
    position_file : str
        File with particle positions.
        Bmad type: character
        Fortran default: ''
    random_engine : str
        Or 'quasi'. Random number engine to use.
        Bmad type: character
        Fortran default: 'pseudo'
    random_gauss_converter : str
        Or 'quick'. Uniform to gauss conversion method.
        Bmad type: character
        Fortran default: 'exact'
    random_sigma_cutoff : float
        Cut-off in sigmas.
        Bmad type: real
        Fortran default: -1
    renorm_center : bool
        Renormalize centroid?
        Bmad type: logical
        Fortran default: .true.
    renorm_sigma : bool
        Renormalize sigma?
        Bmad type: logical
        Fortran default: .true.
    sig_pz : float
        pz sigma
        Bmad type: real
        Fortran default: 0
    sig_pz_jitter : float
        RMS pz spread jitter
        Bmad type: real
        Fortran default: 0.0
    sig_z : float
        Z sigma in m.
        Bmad type: real
        Fortran default: 0
    sig_z_jitter : float
        bunch length RMS jitter
        Bmad type: real
        Fortran default: 0.0
    species : str
        "positron", etc. "" => use referece particle.
        Bmad type: character
        Fortran default: ""
    spin : float
        Spin (x, y, z)
        Bmad type: real
        Fortran default: 0
    t_offset : float
        Time center offset
        Bmad type: real
        Fortran default: 0
    use_particle_start : bool
        Use lat%particle_start instead of beam_init%center, %spin?
        Bmad type: logical
        Fortran default: .false.
    use_t_coords : bool
        If true, the distributions will be taken as in t-coordinates
        Bmad type: logical
        Fortran default: .false.
    use_z_as_t : bool
        Only used if  use_t_coords = .true. If true,  z describes the t distribution If
        false, z describes the s distribution
        Bmad type: logical
        Fortran default: .false.
    """

    kv: KvBeamInitStruct = pydantic.Field(
        default=None,
        description="KV beam distribution",
        validation_alias=pydantic.AliasChoices("kv", "KV"),
        serialization_alias="KV",
    )
    a_emit: float = pydantic.Field(
        default=0,
        description="a-mode emittance",
    )
    a_norm_emit: float = pydantic.Field(
        default=0,
        description="a-mode normalized emittance (emit * beta * gamma)",
    )
    b_emit: float = pydantic.Field(
        default=0,
        description="b-mode emittance",
    )
    b_norm_emit: float = pydantic.Field(
        default=0,
        description="b-mode normalized emittance (emit * beta * gamma)",
    )
    bunch_charge: float = pydantic.Field(
        default=0,
        description="charge (Coul) in a bunch.",
    )
    center: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Bench phase space center offset relative to reference.",
    )
    center_jitter: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
        description="Bunch center rms jitter",
    )
    dpz_dz: float = pydantic.Field(
        default=0,
        description="Correlation of Pz with long position.",
        validation_alias=pydantic.AliasChoices("dpz_dz", "dPz_dz"),
        serialization_alias="dPz_dz",
    )
    distribution_type: Sequence[str] = pydantic.Field(
        default="RAN_GAUSS",
        max_length=3,
        description=(
            "distribution type (in x-px, y-py, and z-pz planes) 'ELLIPSE', 'KV', "
            "'GRID', 'FILE', 'RAN_GAUSS' or '' = 'RAN_GAUSS'"
        ),
    )
    dt_bunch: float = pydantic.Field(
        default=0,
        description="Time between bunches.",
    )
    ellipse: Sequence[EllipseBeamInitStruct] = pydantic.Field(
        default=None,
        max_length=3,
        description="Ellipse beam distribution",
    )
    emit_jitter: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
        description="a and b bunch emittance rms jitter normalized to emittance",
    )
    file_name: str = pydantic.Field(
        default="",
        max_length=200,
        description="OLD!! DO NOT USE!!",
    )
    full_6d_coupling_calc: bool = pydantic.Field(
        default=False,
        description="Use V from 6x6 1-turn mat to match distribution? Else use 4x4 1-turn mat used.",
        validation_alias=pydantic.AliasChoices(
            "full_6d_coupling_calc", "full_6D_coupling_calc"
        ),
        serialization_alias="full_6D_coupling_calc",
    )
    grid: Sequence[GridBeamInitStruct] = pydantic.Field(
        default=None,
        max_length=3,
        description="Grid beam distribution",
    )
    ix_turn: int = pydantic.Field(
        default=0,
        description="Turn index used to adjust particles time if needed.",
    )
    n_bunch: int = pydantic.Field(
        default=0,
        description="Number of bunches.",
    )
    n_particle: int = pydantic.Field(
        default=0,
        description="Number of particles per bunch.",
    )
    position_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="File with particle positions.",
    )
    random_engine: str = pydantic.Field(
        default="pseudo",
        max_length=16,
        description="Or 'quasi'. Random number engine to use.",
    )
    random_gauss_converter: str = pydantic.Field(
        default="exact",
        max_length=16,
        description="Or 'quick'. Uniform to gauss conversion method.",
    )
    random_sigma_cutoff: float = pydantic.Field(
        default=-1,
        description="Cut-off in sigmas.",
    )
    renorm_center: bool = pydantic.Field(
        default=True,
        description="Renormalize centroid?",
    )
    renorm_sigma: bool = pydantic.Field(
        default=True,
        description="Renormalize sigma?",
    )
    sig_pz: float = pydantic.Field(
        default=0,
        description="pz sigma",
    )
    sig_pz_jitter: float = pydantic.Field(
        default=0.0,
        description="RMS pz spread jitter",
    )
    sig_z: float = pydantic.Field(
        default=0,
        description="Z sigma in m.",
    )
    sig_z_jitter: float = pydantic.Field(
        default=0.0,
        description="bunch length RMS jitter",
    )
    species: str = pydantic.Field(
        default="",
        max_length=16,
        description="'positron', etc. '' => use referece particle.",
    )
    spin: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Spin (x, y, z)",
    )
    t_offset: float = pydantic.Field(
        default=0,
        description="Time center offset",
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
        description=(
            "Only used if  use_t_coords = .true. If true,  z describes the t "
            "distribution If false, z describes the s distribution"
        ),
    )


class BeamStruct(pydantic.BaseModel):
    """
    BeamStruct corresponds to bmad `beam_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1110.

    Attributes
    ----------
    bunch : BunchStruct
        Bmad type: bunch_struct
    """

    bunch: Sequence[BunchStruct] = pydantic.Field(
        default=None,
    )


class BmadCommonStruct(pydantic.BaseModel):
    """
    BmadCommonStruct corresponds to bmad `bmad_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2221.

    Attributes
    ----------
    abs_tol_adaptive_tracking : float
        Runge-Kutta tracking absolute tolerance.
        Bmad type: real
        Fortran default: 1d-10
    abs_tol_tracking : float
        Closed orbit absolute tolerance.
        Bmad type: real
        Fortran default: 1d-12
    absolute_time_ref_shift : bool
        Apply reference time shift when using absolute time tracking?
        Bmad type: logical
        Fortran default: .true.
    absolute_time_tracking : bool
        Absolute or relative time tracking?
        Bmad type: logical
        Fortran default: .false.
    aperture_limit_on : bool
        use apertures in tracking?
        Bmad type: logical
        Fortran default: .true.
    auto_bookkeeper : bool
        Automatic bookkeeping?
        Bmad type: logical
        Fortran default: .true.
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
    conserve_taylor_maps : bool
        Enable bookkeeper to set ele%taylor_map_includes_offsets = F?
        Bmad type: logical
        Fortran default: .true.
    convert_to_kinetic_momentum : bool
        Cancel kicks due to finite vector potential when doing symplectic tracking? Set
        to True to test symp_lie_bmad against runge_kutta.
        Bmad type: logical
        Fortran default: .false.
    csr_and_space_charge_on : bool
        Space charge switch.
        Bmad type: logical
        Fortran default: .false.
    d_orb : float
        Orbit deltas for the mat6 via tracking calc.
        Bmad type: real
        Fortran default: 1d-5
    debug : bool
        Used for code debugging.
        Bmad type: logical
        Fortran default: .false.
    default_ds_step : float
        Default integration step for eles without an explicit step calc.
        Bmad type: real
        Fortran default: 0.2_rp
    default_integ_order : int
        PTC integration order.
        Bmad type: integer
        Fortran default: 2
    electric_dipole_moment : float
        Particle's EDM. Call set_ptc to transfer value to PTC.
        Bmad type: real
        Fortran default: 0
    fatal_ds_adaptive_tracking : float
        If actual step size is below this particle is lost.
        Bmad type: real
        Fortran default: 1d-8
    high_energy_space_charge_on : bool
        High energy space charge effect switch.
        Bmad type: logical
        Fortran default: .false.
    init_ds_adaptive_tracking : float
        Initial step size
        Bmad type: real
        Fortran default: 1d-3
    lr_wakes_on : bool
        Long range wakefields
        Bmad type: logical
        Fortran default: .true.
    max_aperture_limit : float
        Max Aperture.
        Bmad type: real
        Fortran default: 1d3
    max_num_runge_kutta_step : int
        Maximum number of RK steps before particle is considered lost.
        Bmad type: integer
        Fortran default: 10000
    min_ds_adaptive_tracking : float
        Min step size to take.
        Bmad type: real
        Fortran default: 0
    radiation_damping_on : bool
        Radiation damping toggle.
        Bmad type: logical
        Fortran default: .false.
    radiation_fluctuations_on : bool
        Radiation fluctuations toggle.
        Bmad type: logical
        Fortran default: .false.
    radiation_zero_average : bool
        Shift damping to be zero on the zero orbit to get rid of sawtooth?
        Bmad type: logical
        Fortran default: .false.
    rel_tol_adaptive_tracking : float
        Runge-Kutta tracking relative tolerance.
        Bmad type: real
        Fortran default: 1d-8
    rel_tol_tracking : float
        Closed orbit relative tolerance.
        Bmad type: real
        Fortran default: 1d-9
    rf_phase_below_transition_ref : bool
        Autoscale uses below transition stable point for RFCavities?
        Bmad type: logical
        Fortran default: .false.
    runge_kutta_order : int
        Runge Kutta order.
        Bmad type: integer
        Fortran default: 4
    sad_amp_max : float
        Used in sad_mult step length calc.
        Bmad type: real
        Fortran default: 5.0d-2
    sad_eps_scale : float
        Used in sad_mult step length calc.
        Bmad type: real
        Fortran default: 5.0d-3
    sad_n_div_max : int
        Used in sad_mult step length calc.
        Bmad type: integer
        Fortran default: 1000
    significant_length : float
        meter
        Bmad type: real
        Fortran default: 1d-10
    spin_sokolov_ternov_flipping_on : bool
        Spin flipping during synchrotron radiation emission?
        Bmad type: logical
        Fortran default: .false.
    spin_tracking_on : bool
        spin tracking?
        Bmad type: logical
        Fortran default: .false.
    sr_wakes_on : bool
        Short range wakefields?
        Bmad type: logical
        Fortran default: .true.
    synch_rad_scale : float
        Synch radiation kick scale. 1 => normal, 0 => no kicks.
        Bmad type: real
        Fortran default: 1.0_rp
    taylor_order : int
        Taylor order to use. 0 -> default = ptc_private%taylor_order_saved.
        Bmad type: integer
        Fortran default: 0
    """

    abs_tol_adaptive_tracking: float = pydantic.Field(
        default=1e-10,
        description="Runge-Kutta tracking absolute tolerance.",
    )
    abs_tol_tracking: float = pydantic.Field(
        default=1e-12,
        description="Closed orbit absolute tolerance.",
    )
    absolute_time_ref_shift: bool = pydantic.Field(
        default=True,
        description="Apply reference time shift when using absolute time tracking?",
    )
    absolute_time_tracking: bool = pydantic.Field(
        default=False,
        description="Absolute or relative time tracking?",
    )
    aperture_limit_on: bool = pydantic.Field(
        default=True,
        description="use apertures in tracking?",
    )
    auto_bookkeeper: bool = pydantic.Field(
        default=True,
        description="Automatic bookkeeping?",
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
    conserve_taylor_maps: bool = pydantic.Field(
        default=True,
        description="Enable bookkeeper to set ele%taylor_map_includes_offsets = F?",
    )
    convert_to_kinetic_momentum: bool = pydantic.Field(
        default=False,
        description=(
            "Cancel kicks due to finite vector potential when doing symplectic "
            "tracking? Set to True to test symp_lie_bmad against runge_kutta."
        ),
    )
    csr_and_space_charge_on: bool = pydantic.Field(
        default=False,
        description="Space charge switch.",
    )
    d_orb: Sequence[float] = pydantic.Field(
        default=1e-05,
        max_length=6,
        description="Orbit deltas for the mat6 via tracking calc.",
    )
    debug: bool = pydantic.Field(
        default=False,
        description="Used for code debugging.",
    )
    default_ds_step: float = pydantic.Field(
        default=0.2,
        description="Default integration step for eles without an explicit step calc.",
    )
    default_integ_order: int = pydantic.Field(
        default=2,
        description="PTC integration order.",
    )
    electric_dipole_moment: float = pydantic.Field(
        default=0,
        description="Particle's EDM. Call set_ptc to transfer value to PTC.",
    )
    fatal_ds_adaptive_tracking: float = pydantic.Field(
        default=1e-08,
        description="If actual step size is below this particle is lost.",
    )
    high_energy_space_charge_on: bool = pydantic.Field(
        default=False,
        description="High energy space charge effect switch.",
    )
    init_ds_adaptive_tracking: float = pydantic.Field(
        default=0.001,
        description="Initial step size",
    )
    lr_wakes_on: bool = pydantic.Field(
        default=True,
        description="Long range wakefields",
    )
    max_aperture_limit: float = pydantic.Field(
        default=1000.0,
        description="Max Aperture.",
    )
    max_num_runge_kutta_step: int = pydantic.Field(
        default=10000,
        description="Maximum number of RK steps before particle is considered lost.",
    )
    min_ds_adaptive_tracking: float = pydantic.Field(
        default=0,
        description="Min step size to take.",
    )
    radiation_damping_on: bool = pydantic.Field(
        default=False,
        description="Radiation damping toggle.",
    )
    radiation_fluctuations_on: bool = pydantic.Field(
        default=False,
        description="Radiation fluctuations toggle.",
    )
    radiation_zero_average: bool = pydantic.Field(
        default=False,
        description="Shift damping to be zero on the zero orbit to get rid of sawtooth?",
    )
    rel_tol_adaptive_tracking: float = pydantic.Field(
        default=1e-08,
        description="Runge-Kutta tracking relative tolerance.",
    )
    rel_tol_tracking: float = pydantic.Field(
        default=1e-09,
        description="Closed orbit relative tolerance.",
    )
    rf_phase_below_transition_ref: bool = pydantic.Field(
        default=False,
        description="Autoscale uses below transition stable point for RFCavities?",
    )
    runge_kutta_order: int = pydantic.Field(
        default=4,
        description="Runge Kutta order.",
    )
    sad_amp_max: float = pydantic.Field(
        default=0.05,
        description="Used in sad_mult step length calc.",
    )
    sad_eps_scale: float = pydantic.Field(
        default=0.005,
        description="Used in sad_mult step length calc.",
    )
    sad_n_div_max: int = pydantic.Field(
        default=1000,
        description="Used in sad_mult step length calc.",
    )
    significant_length: float = pydantic.Field(
        default=1e-10,
        description="meter",
    )
    spin_sokolov_ternov_flipping_on: bool = pydantic.Field(
        default=False,
        description="Spin flipping during synchrotron radiation emission?",
    )
    spin_tracking_on: bool = pydantic.Field(
        default=False,
        description="spin tracking?",
    )
    sr_wakes_on: bool = pydantic.Field(
        default=True,
        description="Short range wakefields?",
    )
    synch_rad_scale: float = pydantic.Field(
        default=1.0,
        description="Synch radiation kick scale. 1 => normal, 0 => no kicks.",
    )
    taylor_order: int = pydantic.Field(
        default=0,
        description="Taylor order to use. 0 -> default = ptc_private%taylor_order_saved.",
    )


class BmadNormalFormStruct(pydantic.BaseModel):
    """
    BmadNormalFormStruct corresponds to bmad `bmad_normal_form_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1531.

    Attributes
    ----------
    a : TaylorStruct
        Map from Floquet -> Lab coordinates
        Bmad type: taylor_struct
        Fortran default: taylor_struct()
    a_inv : TaylorStruct
        Map from Lab -> Floquet coordinates
        Bmad type: taylor_struct
        Fortran default: taylor_struct()
    f : ComplexTaylorStruct
        Vector field factorization in phasor basis:
        Bmad type: complex_taylor_struct
        Fortran default: complex_taylor_struct()
    L : ComplexTaylorStruct
        L component
        Bmad type: complex_taylor_struct
        Fortran default: complex_taylor_struct()
    m : TaylorStruct
        One-turn taylor map: M = A o N o A_inv, N = exp(:h:)
        Bmad type: taylor_struct
        Fortran default: taylor_struct()
    dhdj : TaylorStruct
        Nonlinear tune function operating on Floquet coordinates
        Bmad type: taylor_struct
        Fortran default: taylor_struct()
    ele_origin : EleStruct
        Element at which the on-turn map was created.
        Bmad type: ele_struct
        Fortran default: null()
    h : ResonanceHStruct
        Bmad type: resonance_h_struct
    """

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
    m: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="One-turn taylor map: M = A o N o A_inv, N = exp(:h:)",
        validation_alias=pydantic.AliasChoices("m", "M"),
        serialization_alias="M",
    )
    dhdj: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="Nonlinear tune function operating on Floquet coordinates",
    )
    ele_origin: EleStruct = pydantic.Field(
        default=None,
        description="Element at which the on-turn map was created.",
    )
    h: Sequence[ResonanceHStruct] = pydantic.Field(
        default=None,
    )


class BmadPrivateStruct(pydantic.BaseModel):
    """
    BmadPrivateStruct corresponds to bmad `bmad_private_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2270.

    Attributes
    ----------
    random_on : bool
        Temporarily turned off, for example, with the closed orbit calc.
        Bmad type: logical
        Fortran default: .true.
    rf_clock_period : float
        The RF clock is used by the long_term_tracking program to avoid time round-off
        errors.
        Bmad type: real
        Fortran default: 0
    """

    random_on: bool = pydantic.Field(
        default=True,
        description="Temporarily turned off, for example, with the closed orbit calc.",
    )
    rf_clock_period: float = pydantic.Field(
        default=0,
        description=(
            "The RF clock is used by the long_term_tracking program to avoid time "
            "round-off errors."
        ),
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
    has_misalign : bool
        Used to avoid unnecessary calls to offset_particle.
        Bmad type: logical
        Fortran default: .false.
    mat6 : int
        Linear transfer map status: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    ptc : int
        Associated PTC fibre (or layout) status.
        Bmad type: integer
        Fortran default: stale$
    rad_int : int
        Radiation integrals cache status
        Bmad type: integer
        Fortran default: stale$
    ref_energy : int
        Reference energy and ref time: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
    s_position : int
        Longitudinal position & element length: super_ok$, ok$ or stale$
        Bmad type: integer
        Fortran default: stale$
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
    has_misalign: bool = pydantic.Field(
        default=False,
        description="Used to avoid unnecessary calls to offset_particle.",
    )
    mat6: int = pydantic.Field(
        default=0,
        description="Linear transfer map status: super_ok$, ok$ or stale$",
    )
    ptc: int = pydantic.Field(
        default=0,
        description="Associated PTC fibre (or layout) status.",
    )
    rad_int: int = pydantic.Field(
        default=0,
        description="Radiation integrals cache status",
    )
    ref_energy: int = pydantic.Field(
        default=0,
        description="Reference energy and ref time: super_ok$, ok$ or stale$",
    )
    s_position: int = pydantic.Field(
        default=0,
        description="Longitudinal position & element length: super_ok$, ok$ or stale$",
    )


class BpmPhaseCouplingStruct(pydantic.BaseModel):
    """
    BpmPhaseCouplingStruct corresponds to bmad `bpm_phase_coupling_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 569.

    Attributes
    ----------
    cbar11_b : float
        Cbar11 as calculated from K_11b.
        Bmad type: real
    cbar12_a : float
        Cbar12 as calculated from K_12a.
        Bmad type: real
    cbar12_b : float
        Cbar12 as calculated from K_12b.
        Bmad type: real
    cbar22_a : float
        Cbar22 as calculated from K_22a.
        Bmad type: real
    k_11b : float
        In-phase x/y for b-mode oscillations.
        Bmad type: real
    k_12a : float
        Out-of-phase y/x for a-mode oscillations.
        Bmad type: real
    k_12b : float
        Out-of-phase x/y for b-mode oscillations.
        Bmad type: real
    k_22a : float
        In-phase y/x for a-mode oscillations.
        Bmad type: real
    phi_a : float
        a-mode betatron phase.
        Bmad type: real
    phi_b : float
        b-mode betatron phase.
        Bmad type: real
    """

    cbar11_b: float = pydantic.Field(
        default=0.0,
        description="Cbar11 as calculated from K_11b.",
        validation_alias=pydantic.AliasChoices("cbar11_b", "Cbar11_b"),
        serialization_alias="Cbar11_b",
    )
    cbar12_a: float = pydantic.Field(
        default=0.0,
        description="Cbar12 as calculated from K_12a.",
        validation_alias=pydantic.AliasChoices("cbar12_a", "Cbar12_a"),
        serialization_alias="Cbar12_a",
    )
    cbar12_b: float = pydantic.Field(
        default=0.0,
        description="Cbar12 as calculated from K_12b.",
        validation_alias=pydantic.AliasChoices("cbar12_b", "Cbar12_b"),
        serialization_alias="Cbar12_b",
    )
    cbar22_a: float = pydantic.Field(
        default=0.0,
        description="Cbar22 as calculated from K_22a.",
        validation_alias=pydantic.AliasChoices("cbar22_a", "Cbar22_a"),
        serialization_alias="Cbar22_a",
    )
    k_11b: float = pydantic.Field(
        default=0.0,
        description="In-phase x/y for b-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_11b", "K_11b"),
        serialization_alias="K_11b",
    )
    k_12a: float = pydantic.Field(
        default=0.0,
        description="Out-of-phase y/x for a-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_12a", "K_12a"),
        serialization_alias="K_12a",
    )
    k_12b: float = pydantic.Field(
        default=0.0,
        description="Out-of-phase x/y for b-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_12b", "K_12b"),
        serialization_alias="K_12b",
    )
    k_22a: float = pydantic.Field(
        default=0.0,
        description="In-phase y/x for a-mode oscillations.",
        validation_alias=pydantic.AliasChoices("k_22a", "K_22a"),
        serialization_alias="K_22a",
    )
    phi_a: float = pydantic.Field(
        default=0.0,
        description="a-mode betatron phase.",
    )
    phi_b: float = pydantic.Field(
        default=0.0,
        description="b-mode betatron phase.",
    )


class BranchPointerStruct(pydantic.BaseModel):
    """
    BranchPointerStruct corresponds to bmad `branch_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 903.

    Attributes
    ----------
    branch : BranchStruct
        Bmad type: branch_struct
        Fortran default: null()
    """

    branch: BranchStruct = pydantic.Field(
        default=None,
    )


class BranchStruct(pydantic.BaseModel):
    """
    BranchStruct corresponds to bmad `branch_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1557.

    Attributes
    ----------
    a : ModeInfoStruct
        Note: Tunes are the fractional part.
        Bmad type: mode_info_struct
    b : ModeInfoStruct
        Note: Tunes are the fractional part.
        Bmad type: mode_info_struct
    ele : EleStruct
        Bmad type: ele_struct
        Fortran default: null()
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
    lat : LatStruct
        Bmad type: lat_struct
        Fortran default: null()
    n_ele_max : int
        Bmad type: integer
    n_ele_track : int
        Bmad type: integer
    name : str
        Name of line that defines the branch.
        Bmad type: character
        Fortran default: ''
    param : LatParamStruct
        Bmad type: lat_param_struct
    ptc : PtcBranch1Struct
        Pointer to layout. Note: ptc info not transferred with "branch1 = branch2" set.
        Bmad type: ptc_branch1_struct
    wall3d : Wall3dStruct
        Bmad type: wall3d_struct
        Fortran default: null()
    z : ModeInfoStruct
        Note: Tunes are the fractional part.
        Bmad type: mode_info_struct
    """

    a: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Note: Tunes are the fractional part.",
    )
    b: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Note: Tunes are the fractional part.",
    )
    ele: Sequence[EleStruct] = pydantic.Field(
        default=None,
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
    lat: LatStruct = pydantic.Field(
        default=None,
    )
    n_ele_max: int = pydantic.Field(
        default=0,
    )
    n_ele_track: int = pydantic.Field(
        default=0,
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of line that defines the branch.",
    )
    param: LatParamStruct = pydantic.Field(
        default=None,
    )
    ptc: PtcBranch1Struct = pydantic.Field(
        default=None,
        description="Pointer to layout. Note: ptc info not transferred with 'branch1 = branch2' set.",
    )
    wall3d: Sequence[Wall3dStruct] = pydantic.Field(
        default=None,
    )
    z: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Note: Tunes are the fractional part.",
    )


class BunchParamsStruct(pydantic.BaseModel):
    """
    BunchParamsStruct corresponds to bmad `bunch_params_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1187.

    Attributes
    ----------
    a : TwissStruct
        Normal mode twiss parameters
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    b : TwissStruct
        Normal mode twiss parameters
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    c : TwissStruct
        Normal mode twiss parameters
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    centroid : CoordStruct
        Lab frame
        Bmad type: coord_struct
        Fortran default: coord_struct()
    charge_live : float
        Charge of all non-lost particle
        Bmad type: real
        Fortran default: 0
    charge_tot : float
        Charge of all particles.
        Bmad type: real
        Fortran default: 0
    ix_ele : int
        Lattice element where params evaluated at.
        Bmad type: integer
        Fortran default: -1
    location : int
        Location in element: upstream_end$, inside$, or downstream_end$
        Bmad type: integer
        Fortran default: not_set$
    n_bad_steps : int
        Number of bad steps (set when tracking with space charge)
        Bmad type: integer
        Fortran default: 0
    n_good_steps : int
        Number of good steps (set when tracking with space charge)
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
    n_particle_tot : int
        Total number of particles
        Bmad type: integer
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
    sigma : float
        beam size matrix
        Bmad type: real
        Fortran default: 0
    sigma_t : float
        RMS of time spread.
        Bmad type: real
        Fortran default: 0
    t : float
        Time.
        Bmad type: real
        Fortran default: -1
    twiss_valid : bool
        Is the data here valid? Note: IF there is no energy variation (RF off)
        twiss_valid may be true but in this case the z-twiss will not be valid.
        Bmad type: logical
        Fortran default: .false.
    x : TwissStruct
        Projected Twiss parameters
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    y : TwissStruct
        Projected Twiss parameters
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    z : TwissStruct
        Projected Twiss parameters
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    """

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
    centroid: CoordStruct = pydantic.Field(
        default=None,
        description="Lab frame",
    )
    charge_live: float = pydantic.Field(
        default=0,
        description="Charge of all non-lost particle",
    )
    charge_tot: float = pydantic.Field(
        default=0,
        description="Charge of all particles.",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description="Lattice element where params evaluated at.",
    )
    location: int = pydantic.Field(
        default=0,
        description="Location in element: upstream_end$, inside$, or downstream_end$",
    )
    n_bad_steps: int = pydantic.Field(
        default=0,
        description="Number of bad steps (set when tracking with space charge)",
    )
    n_good_steps: int = pydantic.Field(
        default=0,
        description="Number of good steps (set when tracking with space charge)",
    )
    n_particle_live: int = pydantic.Field(
        default=0,
        description="Number of non-lost particles",
    )
    n_particle_lost_in_ele: int = pydantic.Field(
        default=0,
        description="Number lost in element (not calculated by Bmad)",
    )
    n_particle_tot: int = pydantic.Field(
        default=0,
        description="Total number of particles",
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
    sigma: Sequence[float] = pydantic.Field(
        default=0,
        description="beam size matrix",
    )
    sigma_t: float = pydantic.Field(
        default=0,
        description="RMS of time spread.",
    )
    t: float = pydantic.Field(
        default=-1,
        description="Time.",
    )
    twiss_valid: bool = pydantic.Field(
        default=False,
        description=(
            "Is the data here valid? Note: IF there is no energy variation (RF off) "
            "twiss_valid may be true but in this case the z-twiss will not be valid."
        ),
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


class BunchStruct(pydantic.BaseModel):
    """
    BunchStruct corresponds to bmad `bunch_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1090.

    Attributes
    ----------
    charge_live : float
        Charge of live particles (Coul).
        Bmad type: real
        Fortran default: 0
    charge_tot : float
        Total charge in a bunch (Coul).
        Bmad type: real
        Fortran default: 0
    drift_between_t_and_s : bool
        Drift (ignore any fields) instead of tracking to speed up the calculation? This
        can only be done under certain circumstances.
        Bmad type: logical
        Fortran default: .false.
    ix_bunch : int
        Bunch index. Head bunch = 1, etc.
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Nominal element bunch is at. But, EG, dead particles can be someplace else.
        Bmad type: integer
        Fortran default: 0
    ix_turn : int
        Turn index for long term tracking. ix_turn = 0 before end of first turn, etc.
        Bmad type: integer
        Fortran default: 0
    ix_z : int
        bunch%ix_z(1) is index of head particle, etc.
        Bmad type: integer, allocatable
    n_bad : int
        Number of rejected steps when using adaptive step size control.
        Bmad type: integer
        Fortran default: 0
    n_good : int
        Number of accepted steps when using adaptive step size control.
        Bmad type: integer
        Fortran default: 0
    n_live : int
        Bmad type: integer
        Fortran default: 0
    particle : CoordStruct
        Bmad type: coord_struct
    t0 : float
        Used by track1_bunch_space_charge for tracking so particles have constant t.
        Bmad type: real
        Fortran default: real_garbage$
    t_center : float
        Center of bunch at creation time relative to head bunch.
        Bmad type: real
        Fortran default: 0
    z_center : float
        Longitudinal center of bunch at creation time. Note: Generally, z_center of
        bunch #1 is 0 and z_center of the other bunches is negative.
        Bmad type: real
        Fortran default: 0
    """

    charge_live: float = pydantic.Field(
        default=0,
        description="Charge of live particles (Coul).",
    )
    charge_tot: float = pydantic.Field(
        default=0,
        description="Total charge in a bunch (Coul).",
    )
    drift_between_t_and_s: bool = pydantic.Field(
        default=False,
        description=(
            "Drift (ignore any fields) instead of tracking to speed up the calculation? "
            "This can only be done under certain circumstances."
        ),
    )
    ix_bunch: int = pydantic.Field(
        default=0,
        description="Bunch index. Head bunch = 1, etc.",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="Nominal element bunch is at. But, EG, dead particles can be someplace else.",
    )
    ix_turn: int = pydantic.Field(
        default=0,
        description="Turn index for long term tracking. ix_turn = 0 before end of first turn, etc.",
    )
    ix_z: Sequence[int] = pydantic.Field(
        default=0,
        description="bunch%ix_z(1) is index of head particle, etc.",
    )
    n_bad: int = pydantic.Field(
        default=0,
        description="Number of rejected steps when using adaptive step size control.",
    )
    n_good: int = pydantic.Field(
        default=0,
        description="Number of accepted steps when using adaptive step size control.",
    )
    n_live: int = pydantic.Field(
        default=0,
    )
    particle: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )
    t0: float = pydantic.Field(
        default=0.0,
        description="Used by track1_bunch_space_charge for tracking so particles have constant t.",
    )
    t_center: float = pydantic.Field(
        default=0,
        description="Center of bunch at creation time relative to head bunch.",
    )
    z_center: float = pydantic.Field(
        default=0,
        description=(
            "Longitudinal center of bunch at creation time. Note: Generally, z_center "
            "of bunch #1 is 0 and z_center of the other bunches is negative."
        ),
    )


class BunchTrackStruct(pydantic.BaseModel):
    """
    BunchTrackStruct corresponds to bmad `bunch_track_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1213.

    Attributes
    ----------
    ds_save : float
        Min distance between points.
        Bmad type: real
        Fortran default: -1
    n_pt : int
        Track upper bound
        Bmad type: integer
        Fortran default: -1
    pt : BunchParamsStruct
        Array indexed from 0
        Bmad type: bunch_params_struct
    """

    ds_save: float = pydantic.Field(
        default=-1,
        description="Min distance between points.",
    )
    n_pt: int = pydantic.Field(
        default=-1,
        description="Track upper bound",
    )
    pt: Sequence[BunchParamsStruct] = pydantic.Field(
        default=None,
        description="Array indexed from 0",
    )


class CartesianMapStruct(pydantic.BaseModel):
    """
    CartesianMapStruct corresponds to bmad `cartesian_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 713.

    Attributes
    ----------
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    field_type : int
        or electric$
        Bmad type: integer
        Fortran default: magnetic$
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    ptr : CartesianMapTermStruct
        Bmad type: cartesian_map_term_struct
        Fortran default: null()
    r0 : float
        Field origin offset.
        Bmad type: real
        Fortran default: 0
    """

    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    field_type: int = pydantic.Field(
        default=0,
        description="or electric$",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    ptr: CartesianMapTermStruct = pydantic.Field(
        default=None,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Field origin offset.",
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
    family : int
        family_x$, etc.
        Bmad type: integer
        Fortran default: 0
    form : int
        hyper_y$, etc.
        Bmad type: integer
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
    phi_z : float
        Bmad type: real
        Fortran default: 0
    x0 : float
        Bmad type: real
        Fortran default: 0
    y0 : float
        Bmad type: real
        Fortran default: 0
    """

    coef: float = pydantic.Field(
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
    kx: float = pydantic.Field(
        default=0,
    )
    ky: float = pydantic.Field(
        default=0,
    )
    kz: float = pydantic.Field(
        default=0,
    )
    phi_z: float = pydantic.Field(
        default=0,
    )
    x0: float = pydantic.Field(
        default=0,
    )
    y0: float = pydantic.Field(
        default=0,
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
        Bmad type: cartesian_map_term1_struct
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
        Bmad type: complex_taylor_term_struct
        Fortran default: null()
    """

    ref: Complex = pydantic.Field(
        default=0,
    )
    term: Sequence[ComplexTaylorTermStruct] = pydantic.Field(
        default=None,
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


class ControlRamp1Struct(pydantic.BaseModel):
    """
    ControlRamp1Struct corresponds to bmad `control_ramp1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1326.

    Attributes
    ----------
    attribute : str
        Name of attribute controlled. Set to "FIELD_OVERLAPS" for field overlaps.
        Bmad type: character
        Fortran default: ''
    is_controller : bool
        Is the slave a controller? If so bookkeeping is different.
        Bmad type: logical
        Fortran default: .false.
    slave_name : str
        Name of slave.
        Bmad type: character
        Fortran default: ''
    stack : ExpressionAtomStruct
        Evaluation stack
        Bmad type: expression_atom_struct
    y_knot : float
        Bmad type: real
    """

    attribute: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps.",
    )
    is_controller: bool = pydantic.Field(
        default=False,
        description="Is the slave a controller? If so bookkeeping is different.",
    )
    slave_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of slave.",
    )
    stack: Sequence[ExpressionAtomStruct] = pydantic.Field(
        default=None,
        description="Evaluation stack",
    )
    y_knot: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class ControlStruct(pydantic.BaseModel):
    """
    ControlStruct corresponds to bmad `control_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1308.

    Attributes
    ----------
    attribute : str
        Name of attribute controlled. Set to "FIELD_OVERLAPS" for field overlaps. Set
        to "INPUT" or "OUTPUT" for feedback slaves.
        Bmad type: character
        Fortran default: ''
    ix_attrib : int
        Index of attribute controlled. See note above!
        Bmad type: integer
        Fortran default: -1
    lord : LatEleLocStruct
        Bmad type: lat_ele_loc_struct
        Fortran default: lat_ele_loc_struct()
    slave : LatEleLocStruct
        Bmad type: lat_ele_loc_struct
        Fortran default: lat_ele_loc_struct()
    slave_name : str
        Name of slave.
        Bmad type: character
        Fortran default: ''
    stack : ExpressionAtomStruct
        Evaluation stack
        Bmad type: expression_atom_struct
    value : float
        Used by group, and overlay elements.
        Bmad type: real
        Fortran default: 0
    y_knot : float
        Bmad type: real
    """

    attribute: str = pydantic.Field(
        default="",
        max_length=40,
        description=(
            "Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps. "
            "Set to 'INPUT' or 'OUTPUT' for feedback slaves."
        ),
    )
    ix_attrib: int = pydantic.Field(
        default=-1,
        description="Index of attribute controlled. See note above!",
    )
    lord: LatEleLocStruct = pydantic.Field(
        default=None,
    )
    slave: LatEleLocStruct = pydantic.Field(
        default=None,
    )
    slave_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of slave.",
    )
    stack: Sequence[ExpressionAtomStruct] = pydantic.Field(
        default=None,
        description="Evaluation stack",
    )
    value: float = pydantic.Field(
        default=0,
        description="Used by group, and overlay elements.",
    )
    y_knot: Sequence[float] = pydantic.Field(
        default=0.0,
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
    old_value : float
        Bmad type: real
        Fortran default: 0
    value : float
        Bmad type: real
        Fortran default: 0
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    old_value: float = pydantic.Field(
        default=0,
    )
    value: float = pydantic.Field(
        default=0,
    )


class ControllerStruct(pydantic.BaseModel):
    """
    ControllerStruct corresponds to bmad `controller_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1343.

    Attributes
    ----------
    ramp : ControlRamp1Struct
        For ramper lord elements
        Bmad type: control_ramp1_struct
    ramper_lord : RamperLordStruct
        Ramper lord info for this slave
        Bmad type: ramper_lord_struct
    var : ControlVar1Struct
        Bmad type: control_var1_struct
    x_knot : float
        Bmad type: real
    """

    ramp: Sequence[ControlRamp1Struct] = pydantic.Field(
        default=None,
        description="For ramper lord elements",
    )
    ramper_lord: Sequence[RamperLordStruct] = pydantic.Field(
        default=None,
        description="Ramper lord info for this slave",
    )
    var: Sequence[ControlVar1Struct] = pydantic.Field(
        default=None,
    )
    x_knot: Sequence[float] = pydantic.Field(
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
    c0 : float
        Bmad type: real
        Fortran default: 0
    fit_1d_r : ConverterDir1dStruct
        Bmad type: converter_dir_1D_struct
    fit_2d_pc : ConverterDir2dStruct
        Bmad type: converter_dir_2D_struct
    fit_2d_r : ConverterDir2dStruct
        Bmad type: converter_dir_2D_struct
    """

    c0: float = pydantic.Field(
        default=0,
    )
    fit_1d_r: Sequence[ConverterDir1dStruct] = pydantic.Field(
        default=None,
    )
    fit_2d_pc: ConverterDir2dStruct = pydantic.Field(
        default=None,
    )
    fit_2d_r: ConverterDir2dStruct = pydantic.Field(
        default=None,
    )


class ConverterDirectionOutStruct(pydantic.BaseModel):
    """
    ConverterDirectionOutStruct corresponds to bmad `converter_direction_out_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1258.

    Attributes
    ----------
    alpha_x : ConverterDirCoefStruct
        Bmad type: converter_dir_coef_struct
    alpha_y : ConverterDirCoefStruct
        Bmad type: converter_dir_coef_struct
    beta : ConverterDirCoefStruct
        Bmad type: converter_dir_coef_struct
    c_x : ConverterDirCoefStruct
        Bmad type: converter_dir_coef_struct
    dxds_max : ConverterDirCoefStruct
        Bmad type: converter_dir_coef_struct
    dxds_min : ConverterDirCoefStruct
        Bmad type: converter_dir_coef_struct
    dyds_max : ConverterDirCoefStruct
        Bmad type: converter_dir_coef_struct
    """

    alpha_x: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    alpha_y: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    beta: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    c_x: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    dxds_max: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    dxds_min: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )
    dyds_max: ConverterDirCoefStruct = pydantic.Field(
        default=None,
    )


class ConverterDistributionStruct(pydantic.BaseModel):
    """
    ConverterDistributionStruct corresponds to bmad `converter_distribution_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1290.

    Attributes
    ----------
    sub_dist : ConverterSubDistributionStruct
        Distribution at various pc_in values.
        Bmad type: converter_sub_distribution_struct
    thickness : float
        Bmad type: real
        Fortran default: -1
    """

    sub_dist: Sequence[ConverterSubDistributionStruct] = pydantic.Field(
        default=None,
        description="Distribution at various pc_in values.",
    )
    thickness: float = pydantic.Field(
        default=-1,
    )


class ConverterProbPcRStruct(pydantic.BaseModel):
    """
    ConverterProbPcRStruct corresponds to bmad `converter_prob_pc_r_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1224.

    Attributes
    ----------
    integ_pc_out : float
        Normalized probability integrated from min pc_out up.
        Bmad type: real
    integ_r : float
        Bmad type: real
    integ_r_ave : float
        Bmad type: real
    integrated_prob : float
        Integrated probability over (pc_out, r) with restrictions factered in.
        Bmad type: real
        Fortran default: 0
    p_norm : float
        Normalized probability taking into account. angle_out_max, pc_out_min, and
        pc_out_max restrictions.
        Bmad type: real
    pc_out : float
        Grid pc_out values.
        Bmad type: real
    pc_out_max : float
        Bmad type: real
    pc_out_min : float
        Bmad type: real
    prob : float
        Probability grid.
        Bmad type: real
    r : float
        Grid r_out values.
        Bmad type: real
    spin_z : float
        Z polarization grid. Stuff below is calculated rather than read in from the
        lattice file.
        Bmad type: real
    """

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
    integrated_prob: float = pydantic.Field(
        default=0,
        description="Integrated probability over (pc_out, r) with restrictions factered in.",
    )
    p_norm: Sequence[float] = pydantic.Field(
        default=0.0,
        description=(
            "Normalized probability taking into account. angle_out_max, pc_out_min, and "
            "pc_out_max restrictions."
        ),
    )
    pc_out: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Grid pc_out values.",
    )
    pc_out_max: float = pydantic.Field(
        default=0.0,
    )
    pc_out_min: float = pydantic.Field(
        default=0.0,
    )
    prob: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Probability grid.",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Grid r_out values.",
    )
    spin_z: Sequence[float] = pydantic.Field(
        default=0.0,
        description=(
            "Z polarization grid. Stuff below is calculated rather than read in from "
            "the lattice file."
        ),
    )


class ConverterStruct(pydantic.BaseModel):
    """
    ConverterStruct corresponds to bmad `converter_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1298.

    Attributes
    ----------
    dist : ConverterDistributionStruct
        Distribution at various thicknesses
        Bmad type: converter_distribution_struct
    material_type : str
        Bmad type: character
        Fortran default: ''
    species_out : int
        Output species
        Bmad type: integer
        Fortran default: 0
    """

    dist: Sequence[ConverterDistributionStruct] = pydantic.Field(
        default=None,
        description="Distribution at various thicknesses",
    )
    material_type: str = pydantic.Field(
        default="",
        max_length=40,
    )
    species_out: int = pydantic.Field(
        default=0,
        description="Output species",
    )


class ConverterSubDistributionStruct(pydantic.BaseModel):
    """
    ConverterSubDistributionStruct corresponds to bmad `converter_sub_distribution_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1267.

    Attributes
    ----------
    dir_out : ConverterDirectionOutStruct
        Bmad type: converter_direction_out_struct
    pc_in : float
        Bmad type: real
        Fortran default: -1
    prob_pc_r : ConverterProbPcRStruct
        Bmad type: converter_prob_pc_r_struct
    spin_in : float
        Bmad type: real
    """

    dir_out: ConverterDirectionOutStruct = pydantic.Field(
        default=None,
    )
    pc_in: float = pydantic.Field(
        default=-1,
    )
    prob_pc_r: ConverterProbPcRStruct = pydantic.Field(
        default=None,
    )
    spin_in: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )


class CoordArrayStruct(pydantic.BaseModel):
    """
    CoordArrayStruct corresponds to bmad `coord_array_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 561.

    Attributes
    ----------
    orbit : CoordStruct
        Bmad type: coord_struct
    """

    orbit: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )


class CoordStruct(pydantic.BaseModel):
    """
    CoordStruct corresponds to bmad `coord_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 529.

    Attributes
    ----------
    e_potential : float
        Potential energy.
        Bmad type: real
        Fortran default: 0
    beta : float
        Velocity / c_light.
        Bmad type: real
        Fortran default: -1
    charge : float
        Macroparticle weight (which is different from particle species charge). For
        some space charge calcs the weight is in Coulombs.
        Bmad type: real
        Fortran default: 0
    direction : int
        +1 or -1. Sign of longitudinal direction of motion (ds/dt). This is independent
        of the element orientation.
        Bmad type: integer
        Fortran default: 1
    dt_ref : float
        Used in: * time tracking for computing z. * by coherent photons =
        path_length/c_light.
        Bmad type: real
        Fortran default: 0
    field : float
        Photon E-field intensity (x,y).
        Bmad type: real
        Fortran default: 0
    ix_branch : int
        Index of the lattice branch the particle is in.
        Bmad type: integer
        Fortran default: -1
    ix_ele : int
        Index of the lattice element the particle is in. May be -1 if element is not
        associated with a lattice.
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
    location : int
        upstream_end$, inside$, or downstream_end$
        Bmad type: integer
        Fortran default: upstream_end$
    p0c : float
        For non-photons: Reference momentum. For photons: Photon momentum (not
        reference).
        Bmad type: real
        Fortran default: 0
    phase : float
        Photon E-field phase (x,y). phase(1) is also used with RF-time tracking to
        record the number of RF cycles.
        Bmad type: real
        Fortran default: 0
    r : float
        For general use. Not used by Bmad.
        Bmad type: real
        Fortran default: 0
    s : float
        Longitudinal position
        Bmad type: real
        Fortran default: 0
    species : int
        positron$, proton$, etc.
        Bmad type: integer
        Fortran default: not_set$
    spin : float
        Spin.
        Bmad type: real
        Fortran default: 0
    state : int
        alive$, lost$, lost_neg_x_aperture$, lost_pz$, etc.
        Bmad type: integer
        Fortran default: not_set$
    t : float
        Absolute time (not relative to reference). If bmad_private%rf_clock_frequency
        is set, %t will be the RF clock time in the range [0, 1/rf_clock_freq]
        Bmad type: real
        Fortran default: 0
    time_dir : int
        +1 or -1. Time direction. -1 => Traveling backwards in time.
        Bmad type: integer
        Fortran default: 1
    vec : float
        (x, px, y, py, z, pz). Generally phase space for charged particles. See Bmad
        manual.
        Bmad type: real
        Fortran default: 0
    """

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
    charge: float = pydantic.Field(
        default=0,
        description=(
            "Macroparticle weight (which is different from particle species charge). "
            "For some space charge calcs the weight is in Coulombs."
        ),
    )
    direction: int = pydantic.Field(
        default=1,
        description=(
            "+1 or -1. Sign of longitudinal direction of motion (ds/dt). This is "
            "independent of the element orientation."
        ),
    )
    dt_ref: float = pydantic.Field(
        default=0,
        description=(
            "Used in: * time tracking for computing z. * by coherent photons = "
            "path_length/c_light."
        ),
    )
    field: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description="Photon E-field intensity (x,y).",
    )
    ix_branch: int = pydantic.Field(
        default=-1,
        description="Index of the lattice branch the particle is in.",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description=(
            "Index of the lattice element the particle is in. May be -1 if element is "
            "not associated with a lattice."
        ),
    )
    ix_turn: int = pydantic.Field(
        default=0,
        description="Turn index for multiturn tracking.",
    )
    ix_user: int = pydantic.Field(
        default=-1,
        description="For general use, not used by Bmad.",
    )
    location: int = pydantic.Field(
        default=0,
        description="upstream_end$, inside$, or downstream_end$",
    )
    p0c: float = pydantic.Field(
        default=0,
        description=(
            "For non-photons: Reference momentum. For photons: Photon momentum (not "
            "reference)."
        ),
    )
    phase: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description=(
            "Photon E-field phase (x,y). phase(1) is also used with RF-time tracking to "
            "record the number of RF cycles."
        ),
    )
    r: float = pydantic.Field(
        default=0,
        description="For general use. Not used by Bmad.",
    )
    s: float = pydantic.Field(
        default=0,
        description="Longitudinal position",
    )
    species: int = pydantic.Field(
        default=0,
        description="positron$, proton$, etc.",
    )
    spin: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Spin.",
    )
    state: int = pydantic.Field(
        default=0,
        description="alive$, lost$, lost_neg_x_aperture$, lost_pz$, etc.",
    )
    t: float = pydantic.Field(
        default=0,
        description=(
            "Absolute time (not relative to reference). If "
            "bmad_private%rf_clock_frequency is set, %t will be the RF clock time in "
            "the range [0, 1/rf_clock_freq]"
        ),
    )
    time_dir: int = pydantic.Field(
        default=1,
        description="+1 or -1. Time direction. -1 => Traveling backwards in time.",
    )
    vec: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description=(
            "(x, px, y, py, z, pz). Generally phase space for charged particles. See "
            "Bmad manual."
        ),
    )


class CylindricalMapStruct(pydantic.BaseModel):
    """
    CylindricalMapStruct corresponds to bmad `cylindrical_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 735.

    Attributes
    ----------
    dz : float
        Distance between sampled field points.
        Bmad type: real
        Fortran default: 0
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    harmonic : int
        Harmonic of fundamental
        Bmad type: integer
        Fortran default: 0
    m : int
        Azimuthal Mode: varies as cos(m*phi - theta0_azimuth)
        Bmad type: integer
        Fortran default: 0
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    phi0_fieldmap : float
        Mode oscillates as: twopi * (f * t + phi0_fieldmap)
        Bmad type: real
        Fortran default: 0
    ptr : CylindricalMapTermStruct
        Bmad type: cylindrical_map_term_struct
        Fortran default: null()
    r0 : float
        Field origin offset.
        Bmad type: real
        Fortran default: 0
    theta0_azimuth : float
        Azimuthal ((x, y) plane) orientation of mode.
        Bmad type: real
        Fortran default: 0
    """

    dz: float = pydantic.Field(
        default=0,
        description="Distance between sampled field points.",
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    harmonic: int = pydantic.Field(
        default=0,
        description="Harmonic of fundamental",
    )
    m: int = pydantic.Field(
        default=0,
        description="Azimuthal Mode: varies as cos(m*phi - theta0_azimuth)",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    phi0_fieldmap: float = pydantic.Field(
        default=0,
        description="Mode oscillates as: twopi * (f * t + phi0_fieldmap)",
    )
    ptr: CylindricalMapTermStruct = pydantic.Field(
        default=None,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Field origin offset.",
    )
    theta0_azimuth: float = pydantic.Field(
        default=0,
        description="Azimuthal ((x, y) plane) orientation of mode.",
    )


class CylindricalMapTerm1Struct(pydantic.BaseModel):
    """
    CylindricalMapTerm1Struct corresponds to bmad `cylindrical_map_term1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 724.

    Attributes
    ----------
    b_coef : Complex
        Bmad type: complex
        Fortran default: 0
    e_coef : Complex
        Bmad type: complex
        Fortran default: 0
    """

    b_coef: Complex = pydantic.Field(
        default=0,
    )
    e_coef: Complex = pydantic.Field(
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
        Bmad type: cylindrical_map_term1_struct
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


class ElePointerStruct(pydantic.BaseModel):
    """
    ElePointerStruct corresponds to bmad `ele_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 895.

    Attributes
    ----------
    ele : EleStruct
        Bmad type: ele_struct
        Fortran default: null()
    id : int
        For general use. Not used by Bmad.
        Bmad type: integer
        Fortran default: -1
    loc : LatEleLocStruct
        Bmad type: lat_ele_loc_struct
        Fortran default: lat_ele_loc_struct()
    """

    ele: EleStruct = pydantic.Field(
        default=None,
    )
    id: int = pydantic.Field(
        default=-1,
        description="For general use. Not used by Bmad.",
    )
    loc: LatEleLocStruct = pydantic.Field(
        default=None,
    )


class EleStruct(pydantic.BaseModel):
    """
    EleStruct corresponds to bmad `ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1368.

    Attributes
    ----------
    a : TwissStruct
        Twiss parameters at end of element
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    a_pole : float
        knl for multipole elements.
        Bmad type: real
        Fortran default: null()
    a_pole_elec : float
        Electrostatic multipoles. ksnl for multipole elements.
        Bmad type: real
        Fortran default: null()
    ac_kick : AcKickerStruct
        ac_kicker element parameters.
        Bmad type: ac_kicker_struct
        Fortran default: null()
    alias : str
        Another name.
        Bmad type: character
        Fortran default: ''
    aperture_at : int
        Aperture location: entrance_end$, ...
        Bmad type: integer
        Fortran default: exit_end$
    aperture_type : int
        rectangular$, elliptical$, auto_aperture$, ...
        Bmad type: integer
        Fortran default: rectangular$
    b : TwissStruct
        Twiss parameters at end of element
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    b_pole : float
        tilt for multipole elements.
        Bmad type: real
        Fortran default: null()
    b_pole_elec : float
        Electrostatic multipoles.
        Bmad type: real
        Fortran default: null()
    bmad_logic : bool
        For Bmad internal use only.
        Bmad type: logical
        Fortran default: .false.
    bookkeeping_state : BookkeepingStateStruct
        Attribute bookkeeping
        Bmad type: bookkeeping_state_struct
        Fortran default: bookkeeping_state_struct()
    branch : BranchStruct
        Pointer to branch containing element.
        Bmad type: branch_struct
        Fortran default: null()
    c_mat : float
        2x2 C coupling matrix
        Bmad type: real
        Fortran default: 0
    cartesian_map : CartesianMapStruct
        Used to define E/M fields
        Bmad type: cartesian_map_struct
        Fortran default: null()
    component_name : str
        Used by overlays, multipass patch, etc.
        Bmad type: character
        Fortran default: ''
    control : ControllerStruct
        group & overlay variables.
        Bmad type: controller_struct
        Fortran default: null()
    converter : ConverterStruct
        EG: Positron converter in linac.
        Bmad type: converter_struct
        Fortran default: null()
    csr_method : int
        or one_dim$ ("1_dim"), steady_state_3d$
        Bmad type: integer
        Fortran default: off$
    custom : float
        Custom attributes.
        Bmad type: real
        Fortran default: null()
    cylindrical_map : CylindricalMapStruct
        Used to define E/M fields
        Bmad type: cylindrical_map_struct
        Fortran default: null()
    descrip : str
        Description string.
        Bmad type: character
        Fortran default: null()
    field_calc : int
        no_field$, fieldmap$, refer_to_lords$, or custom$
        Bmad type: integer
        Fortran default: bmad_standard$
    field_master : bool
        Calculate strength from the field value?
        Bmad type: logical
        Fortran default: .false.
    floor : FloorPositionStruct
        Bmad type: floor_position_struct
        Fortran default: floor_position_struct(vec3_zero$, mat3_unit$, 0.0_rp, 0.0_rp, 0.0_rp)
    foil : FoilStruct
        Bmad type: foil_struct
        Fortran default: null()
    gamma_c : float
        gamma associated with C matrix
        Bmad type: real
        Fortran default: 1
    gen_grad_map : GenGradMapStruct
        Used to define E/M fields.
        Bmad type: gen_grad_map_struct
        Fortran default: null()
    grid_field : GridFieldStruct
        Used to define E/M fields. The difference between map_ref_orb and time_ref_orb
        is that map_ref_orb is the reference orbit for the 1st order spin/orbit map
        which, in general, is non-zero while time_ref_orb follows the reference
        particle which is generally the zero orbit (non-zero, for example, in the
        second slice of a sliced wiggler).
        Bmad type: grid_field_struct
        Fortran default: null()
    high_energy_space_charge : HighEnergySpaceChargeStruct
        Bmad type: high_energy_space_charge_struct
        Fortran default: null()
    ic1_lord : int
        Pointer index to this element's lords.
        Bmad type: integer
        Fortran default: 0
    is_on : bool
        For turning element on/off.
        Bmad type: logical
        Fortran default: .true.
    ix1_slave : int
        Pointer index to this element's slaves.
        Bmad type: integer
        Fortran default: 0
    ix_branch : int
        Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Index in branch ele(0:) array. Set to ix_slice_slave$ = -2 for slice_slave$
        elements.
        Bmad type: integer
        Fortran default: -1
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
    key : int
        Element class (quadrupole, etc.).
        Bmad type: integer
        Fortran default: 0
    logic : bool
        For general use. Not used by Bmad (except during lattice parsing).
        Bmad type: logical
        Fortran default: .false.
    lord : EleStruct
        Pointer to a slice lord.
        Bmad type: ele_struct
        Fortran default: null()
    lord_status : int
        Type of lord element this is. overlay_lord$, etc.
        Bmad type: integer
        Fortran default: not_a_lord$
    map_ref_orb_in : CoordStruct
        Entrance end transfer map ref orbit
        Bmad type: coord_struct
        Fortran default: coord_struct()
    map_ref_orb_out : CoordStruct
        Exit end transfer map ref orbit
        Bmad type: coord_struct
        Fortran default: coord_struct()
    mat6 : float
        1st order transport matrix.
        Bmad type: real
        Fortran default: 0
    mat6_calc_method : int
        taylor$, symp_lie_ptc$, etc.
        Bmad type: integer
        Fortran default: bmad_standard$
    mode3 : Mode3Struct
        6D normal mode structure.
        Bmad type: mode3_struct
        Fortran default: null()
    mode_flip : bool
        Have the normal modes traded places?
        Bmad type: logical
        Fortran default: .false.
    multipole_cache : MultipoleCacheStruct
        Bmad type: multipole_cache_struct
    multipoles_on : bool
        For turning multipoles on/off
        Bmad type: logical
        Fortran default: .true.
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
    n_slave : int
        Number of slaves (except field overlap slaves) of this element.
        Bmad type: integer
        Fortran default: 0
    n_slave_field : int
        Number of field slaves of this element.
        Bmad type: integer
        Fortran default: 0
    name : str
        name of element.
        Bmad type: character
        Fortran default: '<Initialized>'
    offset_moves_aperture : bool
        element offsets affects aperture? ! final :: ele_finalizer
        Bmad type: logical
        Fortran default: .false.
    old_value : float
        Used to see if %value(:) array has changed. Note: The reference orbit for
        spin/orbit matrices is %map_ref_orb_in/out
        Bmad type: real
        Fortran default: 0
    orientation : int
        -1 -> Element is longitudinally reversed. +1 -> Normal.
        Bmad type: integer
        Fortran default: 1
    photon : PhotonElementStruct
        Bmad type: photon_element_struct
        Fortran default: null()
    ptc_fibre : Fibre
        PTC track corresponding to this ele.
        Bmad type: fibre
        Fortran default: null()
    ptc_integration_type : int
        drift_kick$, matrix_kick$, or ripken_kick$
        Bmad type: integer
        Fortran default: matrix_kick$
    r : float
        For general use. Not used by Bmad.
        Bmad type: real
        Fortran default: null()
    rad_map : RadMapEleStruct
        Radiation kick parameters Note: The reference orbits for spin and orbit Taylor
        maps are not necessarily the same. For example, Sprint spin Taylor maps can be
        with respect to the zero orbit independent of the orbital map.
        Bmad type: rad_map_ele_struct
        Fortran default: null()
    ref_species : int
        Reference species
        Bmad type: integer
        Fortran default: not_set$
    ref_time : float
        Time ref particle passes exit end.
        Bmad type: real
        Fortran default: 0
    s : float
        longitudinal ref position at the exit end.
        Bmad type: real
        Fortran default: 0
    s_start : float
        longitudinal ref position at entrance_end
        Bmad type: real
        Fortran default: 0
    scale_multipoles : bool
        Are ab_multipoles within other elements (EG: quads, etc.) scaled by the
        strength of the element?
        Bmad type: logical
        Fortran default: .true.
    select : bool
        For Bmad internal use only.
        Bmad type: logical
        Fortran default: .false.
    slave_status : int
        Type of slave element this is. multipass_slave$, slice_slave$, etc.
        Bmad type: integer
        Fortran default: free$
    space_charge_method : int
        slice$, slice_longitudinal$, slice_transverse$, fft_3D$, cathode_fft_3d$
        Bmad type: integer
        Fortran default: off$
    spin_q : float
        0th and 1st order Spin transport quaternion.
        Bmad type: real
        Fortran default: real_garbage$
    spin_taylor : TaylorStruct
        Quaternion Spin Taylor map.
        Bmad type: taylor_struct
        Fortran default: taylor_struct()
    spin_taylor_ref_orb_in : float
        Bmad type: real
        Fortran default: real_garbage$
    spin_tracking_method : int
        symp_lie_ptc$, etc.
        Bmad type: integer
        Fortran default: tracking$
    sub_key : int
        Records bend input type.
        Bmad type: integer
        Fortran default: 0
    symplectify : bool
        Symplectify mat6 matrices.
        Bmad type: logical
        Fortran default: .false.
    taylor : TaylorStruct
        Phase space Taylor map.
        Bmad type: taylor_struct
        Fortran default: taylor_struct()
    taylor_map_includes_offsets : bool
        Taylor map calculated with element misalignments?
        Bmad type: logical
        Fortran default: .true.
    time_ref_orb_in : CoordStruct
        Reference orbit at entrance end for ref_time calc.
        Bmad type: coord_struct
        Fortran default: coord_struct()
    time_ref_orb_out : CoordStruct
        Reference orbit at exit end for ref_time calc.
        Bmad type: coord_struct
        Fortran default: coord_struct()
    tracking_method : int
        taylor$, linear$, etc.
        Bmad type: integer
        Fortran default: bmad_standard$
    type : str
        type name.
        Bmad type: character
        Fortran default: ''
    value : float
        attribute values.
        Bmad type: real
        Fortran default: 0
    vec0 : float
        0th order transport vector.
        Bmad type: real
        Fortran default: 0
    wake : WakeStruct
        Wakes
        Bmad type: wake_struct
        Fortran default: null()
    wall3d : Wall3dStruct
        Chamber or capillary wall E/M field structs.
        Bmad type: wall3d_struct
        Fortran default: null()
    x : XyDispStruct
        Projected dispersions.
        Bmad type: xy_disp_struct
        Fortran default: xy_disp_struct()
    y : XyDispStruct
        Projected dispersions.
        Bmad type: xy_disp_struct
        Fortran default: xy_disp_struct()
    z : TwissStruct
        Twiss parameters at end of element
        Bmad type: twiss_struct
        Fortran default: twiss_struct()
    """

    a: TwissStruct = pydantic.Field(
        default=None,
        description="Twiss parameters at end of element",
    )
    a_pole: Sequence[float] = pydantic.Field(
        default=0.0,
        description="knl for multipole elements.",
    )
    a_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Electrostatic multipoles. ksnl for multipole elements.",
    )
    ac_kick: AcKickerStruct = pydantic.Field(
        default=None,
        description="ac_kicker element parameters.",
    )
    alias: str = pydantic.Field(
        default="",
        max_length=40,
        description="Another name.",
    )
    aperture_at: int = pydantic.Field(
        default=0,
        description="Aperture location: entrance_end$, ...",
    )
    aperture_type: int = pydantic.Field(
        default=0,
        description="rectangular$, elliptical$, auto_aperture$, ...",
    )
    b: TwissStruct = pydantic.Field(
        default=None,
        description="Twiss parameters at end of element",
    )
    b_pole: Sequence[float] = pydantic.Field(
        default=0.0,
        description="tilt for multipole elements.",
    )
    b_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Electrostatic multipoles.",
    )
    bmad_logic: bool = pydantic.Field(
        default=False,
        description="For Bmad internal use only.",
    )
    bookkeeping_state: BookkeepingStateStruct = pydantic.Field(
        default=None,
        description="Attribute bookkeeping",
    )
    branch: BranchStruct = pydantic.Field(
        default=None,
        description="Pointer to branch containing element.",
    )
    c_mat: Sequence[float] = pydantic.Field(
        default=0,
        description="2x2 C coupling matrix",
    )
    cartesian_map: Sequence[CartesianMapStruct] = pydantic.Field(
        default=None,
        description="Used to define E/M fields",
    )
    component_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Used by overlays, multipass patch, etc.",
    )
    control: ControllerStruct = pydantic.Field(
        default=None,
        description="group & overlay variables.",
    )
    converter: ConverterStruct = pydantic.Field(
        default=None,
        description="EG: Positron converter in linac.",
    )
    csr_method: int = pydantic.Field(
        default=0,
        description="or one_dim$ ('1_dim'), steady_state_3d$",
    )
    custom: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Custom attributes.",
    )
    cylindrical_map: Sequence[CylindricalMapStruct] = pydantic.Field(
        default=None,
        description="Used to define E/M fields",
    )
    descrip: str = pydantic.Field(
        default_factory=list,
        max_length=200,
        description="Description string.",
    )
    field_calc: int = pydantic.Field(
        default=0,
        description="no_field$, fieldmap$, refer_to_lords$, or custom$",
    )
    field_master: bool = pydantic.Field(
        default=False,
        description="Calculate strength from the field value?",
    )
    floor: FloorPositionStruct = pydantic.Field(
        default=None,
    )
    foil: FoilStruct = pydantic.Field(
        default=None,
    )
    gamma_c: float = pydantic.Field(
        default=1,
        description="gamma associated with C matrix",
    )
    gen_grad_map: Sequence[GenGradMapStruct] = pydantic.Field(
        default=None,
        description="Used to define E/M fields.",
    )
    grid_field: Sequence[GridFieldStruct] = pydantic.Field(
        default=None,
        description=(
            "Used to define E/M fields. The difference between map_ref_orb and "
            "time_ref_orb is that map_ref_orb is the reference orbit for the 1st order "
            "spin/orbit map which, in general, is non-zero while time_ref_orb follows "
            "the reference particle which is generally the zero orbit (non-zero, for "
            "example, in the second slice of a sliced wiggler)."
        ),
    )
    high_energy_space_charge: HighEnergySpaceChargeStruct = pydantic.Field(
        default=None,
    )
    ic1_lord: int = pydantic.Field(
        default=0,
        description="Pointer index to this element's lords.",
    )
    is_on: bool = pydantic.Field(
        default=True,
        description="For turning element on/off.",
    )
    ix1_slave: int = pydantic.Field(
        default=0,
        description="Pointer index to this element's slaves.",
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description="Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description=(
            "Index in branch ele(0:) array. Set to ix_slice_slave$ = -2 for "
            "slice_slave$ elements."
        ),
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
    key: int = pydantic.Field(
        default=0,
        description="Element class (quadrupole, etc.).",
    )
    logic: bool = pydantic.Field(
        default=False,
        description="For general use. Not used by Bmad (except during lattice parsing).",
    )
    lord: EleStruct = pydantic.Field(
        default=None,
        description="Pointer to a slice lord.",
    )
    lord_status: int = pydantic.Field(
        default=0,
        description="Type of lord element this is. overlay_lord$, etc.",
    )
    map_ref_orb_in: CoordStruct = pydantic.Field(
        default=None,
        description="Entrance end transfer map ref orbit",
    )
    map_ref_orb_out: CoordStruct = pydantic.Field(
        default=None,
        description="Exit end transfer map ref orbit",
    )
    mat6: Sequence[float] = pydantic.Field(
        default=0,
        description="1st order transport matrix.",
    )
    mat6_calc_method: int = pydantic.Field(
        default=0,
        description="taylor$, symp_lie_ptc$, etc.",
    )
    mode3: Mode3Struct = pydantic.Field(
        default=None,
        description="6D normal mode structure.",
    )
    mode_flip: bool = pydantic.Field(
        default=False,
        description="Have the normal modes traded places?",
    )
    multipole_cache: MultipoleCacheStruct = pydantic.Field(
        default=None,
    )
    multipoles_on: bool = pydantic.Field(
        default=True,
        description="For turning multipoles on/off",
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
    n_slave: int = pydantic.Field(
        default=0,
        description="Number of slaves (except field overlap slaves) of this element.",
    )
    n_slave_field: int = pydantic.Field(
        default=0,
        description="Number of field slaves of this element.",
    )
    name: str = pydantic.Field(
        default="<Initialized>",
        max_length=40,
        description="name of element.",
    )
    offset_moves_aperture: bool = pydantic.Field(
        default=False,
        description="element offsets affects aperture? ! final :: ele_finalizer",
    )
    old_value: Sequence[float] = pydantic.Field(
        default=0,
        description=(
            "Used to see if %value(:) array has changed. Note: The reference orbit for "
            "spin/orbit matrices is %map_ref_orb_in/out"
        ),
    )
    orientation: int = pydantic.Field(
        default=1,
        description="-1 -> Element is longitudinally reversed. +1 -> Normal.",
    )
    photon: PhotonElementStruct = pydantic.Field(
        default=None,
    )
    ptc_fibre: Fibre = pydantic.Field(
        default=None,
        description="PTC track corresponding to this ele.",
    )
    ptc_integration_type: int = pydantic.Field(
        default=0,
        description="drift_kick$, matrix_kick$, or ripken_kick$",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        description="For general use. Not used by Bmad.",
    )
    rad_map: RadMapEleStruct = pydantic.Field(
        default=None,
        description=(
            "Radiation kick parameters Note: The reference orbits for spin and orbit "
            "Taylor maps are not necessarily the same. For example, Sprint spin Taylor "
            "maps can be with respect to the zero orbit independent of the orbital map."
        ),
    )
    ref_species: int = pydantic.Field(
        default=0,
        description="Reference species",
    )
    ref_time: float = pydantic.Field(
        default=0,
        description="Time ref particle passes exit end.",
    )
    s: float = pydantic.Field(
        default=0,
        description="longitudinal ref position at the exit end.",
    )
    s_start: float = pydantic.Field(
        default=0,
        description="longitudinal ref position at entrance_end",
    )
    scale_multipoles: bool = pydantic.Field(
        default=True,
        description=(
            "Are ab_multipoles within other elements (EG: quads, etc.) scaled by the "
            "strength of the element?"
        ),
    )
    select: bool = pydantic.Field(
        default=False,
        description="For Bmad internal use only.",
    )
    slave_status: int = pydantic.Field(
        default=0,
        description="Type of slave element this is. multipass_slave$, slice_slave$, etc.",
    )
    space_charge_method: int = pydantic.Field(
        default=0,
        description="slice$, slice_longitudinal$, slice_transverse$, fft_3D$, cathode_fft_3d$",
    )
    spin_q: Sequence[float] = pydantic.Field(
        default=0.0,
        description="0th and 1st order Spin transport quaternion.",
    )
    spin_taylor: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        description="Quaternion Spin Taylor map.",
    )
    spin_taylor_ref_orb_in: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=6,
    )
    spin_tracking_method: int = pydantic.Field(
        default=0,
        description="symp_lie_ptc$, etc.",
    )
    sub_key: int = pydantic.Field(
        default=0,
        description="Records bend input type.",
    )
    symplectify: bool = pydantic.Field(
        default=False,
        description="Symplectify mat6 matrices.",
    )
    taylor: Sequence[TaylorStruct] = pydantic.Field(
        default=None,
        max_length=6,
        description="Phase space Taylor map.",
    )
    taylor_map_includes_offsets: bool = pydantic.Field(
        default=True,
        description="Taylor map calculated with element misalignments?",
    )
    time_ref_orb_in: CoordStruct = pydantic.Field(
        default=None,
        description="Reference orbit at entrance end for ref_time calc.",
    )
    time_ref_orb_out: CoordStruct = pydantic.Field(
        default=None,
        description="Reference orbit at exit end for ref_time calc.",
    )
    tracking_method: int = pydantic.Field(
        default=0,
        description="taylor$, linear$, etc.",
    )
    type: str = pydantic.Field(
        default="",
        max_length=40,
        description="type name.",
    )
    value: Sequence[float] = pydantic.Field(
        default=0,
        description="attribute values.",
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="0th order transport vector.",
    )
    wake: WakeStruct = pydantic.Field(
        default=None,
        description="Wakes",
    )
    wall3d: Sequence[Wall3dStruct] = pydantic.Field(
        default=None,
        description="Chamber or capillary wall E/M field structs.",
    )
    x: XyDispStruct = pydantic.Field(
        default=None,
        description="Projected dispersions.",
    )
    y: XyDispStruct = pydantic.Field(
        default=None,
        description="Projected dispersions.",
    )
    z: TwissStruct = pydantic.Field(
        default=None,
        description="Twiss parameters at end of element",
    )


class EllipseBeamInitStruct(pydantic.BaseModel):
    """
    EllipseBeamInitStruct corresponds to bmad `ellipse_beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1114.

    Attributes
    ----------
    n_ellipse : int
        number of ellipses (>= 1)
        Bmad type: integer
        Fortran default: 1
    part_per_ellipse : int
        number of particles per ellipse
        Bmad type: integer
        Fortran default: 0
    sigma_cutoff : float
        sigma cutoff of the representation
        Bmad type: real
        Fortran default: 0
    """

    n_ellipse: int = pydantic.Field(
        default=1,
        description="number of ellipses (>= 1)",
    )
    part_per_ellipse: int = pydantic.Field(
        default=0,
        description="number of particles per ellipse",
    )
    sigma_cutoff: float = pydantic.Field(
        default=0,
        description="sigma cutoff of the representation",
    )


class EmFieldStruct(pydantic.BaseModel):
    """
    EmFieldStruct corresponds to bmad `em_field_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1972.

    Attributes
    ----------
    a : float
        Magnetic vector potential.
        Bmad type: real
        Fortran default: 0
    b : float
        magnetic field.
        Bmad type: real
        Fortran default: 0
    e : float
        electric field.
        Bmad type: real
        Fortran default: 0
    db : float
        magnetic field gradient.
        Bmad type: real
        Fortran default: 0
    de : float
        electric field gradient.
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
    """

    a: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Magnetic vector potential.",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    b: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="magnetic field.",
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    e: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="electric field.",
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
    )
    db: Sequence[float] = pydantic.Field(
        default=0,
        description="magnetic field gradient.",
        validation_alias=pydantic.AliasChoices("db", "dB"),
        serialization_alias="dB",
    )
    de: Sequence[float] = pydantic.Field(
        default=0,
        description="electric field gradient.",
        validation_alias=pydantic.AliasChoices("de", "dE"),
        serialization_alias="dE",
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
        Bmad type: em_taylor_term_struct
    """

    ref: float = pydantic.Field(
        default=0,
    )
    term: Sequence[EmTaylorTermStruct] = pydantic.Field(
        default=None,
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


class ExtraParsingInfoStruct(pydantic.BaseModel):
    """
    ExtraParsingInfoStruct corresponds to bmad `extra_parsing_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2138.

    Attributes
    ----------
    abs_tol_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    abs_tol_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    absolute_time_ref_shift_set : bool
        Bmad type: logical
        Fortran default: .false.
    absolute_time_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    aperture_limit_on_set : bool
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
    beam_chamber_height_set : bool
        Bmad type: logical
        Fortran default: .false.
    cathode_strength_cutoff_set : bool
        Bmad type: logical
        Fortran default: .false.
    conserve_taylor_maps_set : bool
        Bmad type: logical
        Fortran default: .false.
    convert_to_kinetic_momentum_set : bool
        Bmad type: logical
        Fortran default: .false.
    csr3d_mesh_size_set : bool
        Bmad type: logical
        Fortran default: .false.
    csr_and_space_charge_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    cut_factor_set : bool
        Bmad type: logical
        Fortran default: .false.
    d_orb_set : bool
        Bmad type: logical
        Fortran default: .false.
    debug_set : bool
        Used with space_charge_com
        Bmad type: logical
        Fortran default: .false.
    default_ds_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    default_integ_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    diagnostic_output_file_set : bool
        Used with ptc_com
        Bmad type: logical
        Fortran default: .false.
    ds_track_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    dt_track_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    electric_dipole_moment_set : bool
        Bmad type: logical
        Fortran default: .false.
    exact_misalign_set : bool
        Bmad type: logical
        Fortran default: .false.
    exact_model_set : bool
        Bmad type: logical
        Fortran default: .false.
    fatal_ds_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    high_energy_space_charge_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    init_ds_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    lr_wakes_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    lsc_kick_transverse_dependence_set : bool
        Bmad type: logical
        Fortran default: .false.
    lsc_sigma_cutoff_set : bool
        Bmad type: logical
        Fortran default: .false.
    max_aperture_limit_set : bool
        Bmad type: logical
        Fortran default: .false.
    max_fringe_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    max_num_runge_kutta_step_set : bool
        Bmad type: logical
        Fortran default: .false.
    min_ds_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    n_bin_set : bool
        Bmad type: logical
        Fortran default: .false.
    n_shield_images_set : bool
        Bmad type: logical
        Fortran default: .false.
    old_integrator_set : bool
        Bmad type: logical
        Fortran default: .false.
    particle_bin_span_set : bool
        Bmad type: logical
        Fortran default: .false.
    particle_sigma_cutoff_set : bool
        Bmad type: logical
        Fortran default: .false.
    print_info_messages_set : bool
        Bmad type: logical
        Fortran default: .false.
    radiation_damping_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    radiation_fluctuations_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    radiation_zero_average_set : bool
        Bmad type: logical
        Fortran default: .false.
    ran_seed : int
        Bmad type: integer
        Fortran default: 0
    ran_state : RandomStateStruct
        Bmad type: random_state_struct
        Fortran default: random_state_struct()
    rel_tol_adaptive_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    rel_tol_tracking_set : bool
        Bmad type: logical
        Fortran default: .false.
    rf_phase_below_transition_ref_set : bool
        Bmad type: logical
        Fortran default: .false.
    runge_kutta_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    sad_amp_max_set : bool
        Bmad type: logical
        Fortran default: .false.
    sad_eps_scale_set : bool
        Bmad type: logical
        Fortran default: .false.
    sad_n_div_max_set : bool
        Bmad type: logical
        Fortran default: .false.
    sc_abs_tol_tracking_set : bool
        For: space_charge_com%abs_tol_tracking
        Bmad type: logical
        Fortran default: .false.
    sc_debug_set : bool
        Bmad type: logical
        Fortran default: .false.
    sc_min_in_bin_set : bool
        Bmad type: logical
        Fortran default: .false.
    sc_rel_tol_tracking_set : bool
        For: space_charge_com%rel_tol_tracking
        Bmad type: logical
        Fortran default: .false.
    significant_length_set : bool
        Bmad type: logical
        Fortran default: .false.
    space_charge_mesh_size_set : bool
        Bmad type: logical
        Fortran default: .false.
    spin_sokolov_ternov_flipping_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    spin_tracking_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    sr_wakes_on_set : bool
        Bmad type: logical
        Fortran default: .false.
    synch_rad_scale_set : bool
        Bmad type: logical
        Fortran default: .false.
    taylor_order_set : bool
        Bmad type: logical
        Fortran default: .false.
    translate_patch_drift_time_set : bool
        Bmad type: logical
        Fortran default: .false.
    undeterministic_ran_function_called : bool
        Used with bmad_com
        Bmad type: logical
        Fortran default: .false.
    use_orientation_patches_set : bool
        Bmad type: logical
        Fortran default: .false.
    vertical_kick_set : bool
        Bmad type: logical
        Fortran default: .false.
    """

    abs_tol_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    abs_tol_tracking_set: bool = pydantic.Field(
        default=False,
    )
    absolute_time_ref_shift_set: bool = pydantic.Field(
        default=False,
    )
    absolute_time_tracking_set: bool = pydantic.Field(
        default=False,
    )
    aperture_limit_on_set: bool = pydantic.Field(
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
    beam_chamber_height_set: bool = pydantic.Field(
        default=False,
    )
    cathode_strength_cutoff_set: bool = pydantic.Field(
        default=False,
    )
    conserve_taylor_maps_set: bool = pydantic.Field(
        default=False,
    )
    convert_to_kinetic_momentum_set: bool = pydantic.Field(
        default=False,
    )
    csr3d_mesh_size_set: bool = pydantic.Field(
        default=False,
    )
    csr_and_space_charge_on_set: bool = pydantic.Field(
        default=False,
    )
    cut_factor_set: bool = pydantic.Field(
        default=False,
    )
    d_orb_set: bool = pydantic.Field(
        default=False,
    )
    debug_set: bool = pydantic.Field(
        default=False,
        description="Used with space_charge_com",
    )
    default_ds_step_set: bool = pydantic.Field(
        default=False,
    )
    default_integ_order_set: bool = pydantic.Field(
        default=False,
    )
    diagnostic_output_file_set: bool = pydantic.Field(
        default=False,
        description="Used with ptc_com",
    )
    ds_track_step_set: bool = pydantic.Field(
        default=False,
    )
    dt_track_step_set: bool = pydantic.Field(
        default=False,
    )
    electric_dipole_moment_set: bool = pydantic.Field(
        default=False,
    )
    exact_misalign_set: bool = pydantic.Field(
        default=False,
    )
    exact_model_set: bool = pydantic.Field(
        default=False,
    )
    fatal_ds_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    high_energy_space_charge_on_set: bool = pydantic.Field(
        default=False,
    )
    init_ds_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    lr_wakes_on_set: bool = pydantic.Field(
        default=False,
    )
    lsc_kick_transverse_dependence_set: bool = pydantic.Field(
        default=False,
    )
    lsc_sigma_cutoff_set: bool = pydantic.Field(
        default=False,
    )
    max_aperture_limit_set: bool = pydantic.Field(
        default=False,
    )
    max_fringe_order_set: bool = pydantic.Field(
        default=False,
    )
    max_num_runge_kutta_step_set: bool = pydantic.Field(
        default=False,
    )
    min_ds_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    n_bin_set: bool = pydantic.Field(
        default=False,
    )
    n_shield_images_set: bool = pydantic.Field(
        default=False,
    )
    old_integrator_set: bool = pydantic.Field(
        default=False,
    )
    particle_bin_span_set: bool = pydantic.Field(
        default=False,
    )
    particle_sigma_cutoff_set: bool = pydantic.Field(
        default=False,
    )
    print_info_messages_set: bool = pydantic.Field(
        default=False,
    )
    radiation_damping_on_set: bool = pydantic.Field(
        default=False,
    )
    radiation_fluctuations_on_set: bool = pydantic.Field(
        default=False,
    )
    radiation_zero_average_set: bool = pydantic.Field(
        default=False,
    )
    ran_seed: int = pydantic.Field(
        default=0,
    )
    ran_state: RandomStateStruct = pydantic.Field(
        default=None,
    )
    rel_tol_adaptive_tracking_set: bool = pydantic.Field(
        default=False,
    )
    rel_tol_tracking_set: bool = pydantic.Field(
        default=False,
    )
    rf_phase_below_transition_ref_set: bool = pydantic.Field(
        default=False,
    )
    runge_kutta_order_set: bool = pydantic.Field(
        default=False,
    )
    sad_amp_max_set: bool = pydantic.Field(
        default=False,
    )
    sad_eps_scale_set: bool = pydantic.Field(
        default=False,
    )
    sad_n_div_max_set: bool = pydantic.Field(
        default=False,
    )
    sc_abs_tol_tracking_set: bool = pydantic.Field(
        default=False,
        description="For: space_charge_com%abs_tol_tracking",
    )
    sc_debug_set: bool = pydantic.Field(
        default=False,
    )
    sc_min_in_bin_set: bool = pydantic.Field(
        default=False,
    )
    sc_rel_tol_tracking_set: bool = pydantic.Field(
        default=False,
        description="For: space_charge_com%rel_tol_tracking",
    )
    significant_length_set: bool = pydantic.Field(
        default=False,
    )
    space_charge_mesh_size_set: bool = pydantic.Field(
        default=False,
    )
    spin_sokolov_ternov_flipping_on_set: bool = pydantic.Field(
        default=False,
    )
    spin_tracking_on_set: bool = pydantic.Field(
        default=False,
    )
    sr_wakes_on_set: bool = pydantic.Field(
        default=False,
    )
    synch_rad_scale_set: bool = pydantic.Field(
        default=False,
    )
    taylor_order_set: bool = pydantic.Field(
        default=False,
    )
    translate_patch_drift_time_set: bool = pydantic.Field(
        default=False,
    )
    undeterministic_ran_function_called: bool = pydantic.Field(
        default=False,
        description="Used with bmad_com",
    )
    use_orientation_patches_set: bool = pydantic.Field(
        default=False,
    )
    vertical_kick_set: bool = pydantic.Field(
        default=False,
    )


class FloorPositionStruct(pydantic.BaseModel):
    """
    FloorPositionStruct corresponds to bmad `floor_position_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 827.

    Attributes
    ----------
    phi : float
        angular orientation consistent with W matrix
        Bmad type: real
        Fortran default: 0
    psi : float
        angular orientation consistent with W matrix
        Bmad type: real
        Fortran default: 0
    r : float
        (x, y, z) offset from origin
        Bmad type: real
        Fortran default: 0
    theta : float
        angular orientation consistent with W matrix
        Bmad type: real
        Fortran default: 0
    w : float
        W matrix. Columns are unit vectors of the frame axes.
        Bmad type: real
        Fortran default: mat3_unit$
    """

    phi: float = pydantic.Field(
        default=0,
        description="angular orientation consistent with W matrix",
    )
    psi: float = pydantic.Field(
        default=0,
        description="angular orientation consistent with W matrix",
    )
    r: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="(x, y, z) offset from origin",
    )
    theta: float = pydantic.Field(
        default=0,
        description="angular orientation consistent with W matrix",
    )
    w: Sequence[float] = pydantic.Field(
        default=0.0,
        description="W matrix. Columns are unit vectors of the frame axes.",
    )


class FoilStruct(pydantic.BaseModel):
    """
    FoilStruct corresponds to bmad `foil_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1284.

    Attributes
    ----------
    material : MaterialStruct
        Bmad type: material_struct
    """

    material: Sequence[MaterialStruct] = pydantic.Field(
        default=None,
    )


class FringeFieldInfoStruct(pydantic.BaseModel):
    """
    FringeFieldInfoStruct corresponds to bmad `fringe_field_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 35.

    Attributes
    ----------
    ds_edge : float
        Distance from particle to edge in hard_ele frame.
        Bmad type: real
        Fortran default: 0
    hard_ele : EleStruct
        Bmad type: ele_struct
        Fortran default: null()
    hard_location : int
        Particle location wrt hard_ele. Points to element in location(:).
        Bmad type: integer, pointer
        Fortran default: null()
    has_fringe : bool
        Has a fringe to worry about?
        Bmad type: logical
        Fortran default: .false.
    location : int
        Particle location in an element. entrance_end$, inside$, or exit_end$ Elements
        in list are the tracking element or its lords.
        Bmad type: integer, allocatable
    particle_at : int
        first_track_edge$, second_track_edge$, or none$
        Bmad type: integer
        Fortran default: -1
    s_edge_hard : float
        Bmad type: real
        Fortran default: 0
    """

    ds_edge: float = pydantic.Field(
        default=0,
        description="Distance from particle to edge in hard_ele frame.",
    )
    hard_ele: EleStruct = pydantic.Field(
        default=None,
    )
    hard_location: int = pydantic.Field(
        default=0,
        description="Particle location wrt hard_ele. Points to element in location(:).",
    )
    has_fringe: bool = pydantic.Field(
        default=False,
        description="Has a fringe to worry about?",
    )
    location: Sequence[int] = pydantic.Field(
        default=0,
        description=(
            "Particle location in an element. entrance_end$, inside$, or exit_end$ "
            "Elements in list are the tracking element or its lords."
        ),
    )
    particle_at: int = pydantic.Field(
        default=-1,
        description="first_track_edge$, second_track_edge$, or none$",
    )
    s_edge_hard: float = pydantic.Field(
        default=0,
    )


class GenGrad1Struct(pydantic.BaseModel):
    """
    GenGrad1Struct corresponds to bmad `gen_grad1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 750.

    Attributes
    ----------
    deriv : float
        Range: (iz0:iz1, 0:2*n_deriv_max+1)
        Bmad type: real
    m : int
        Azimuthal index
        Bmad type: integer
        Fortran default: 0
    n_deriv_max : int
        Max GG derivative The derivative matrix is extended to include the
        interpolating spline polynomial.
        Bmad type: integer
        Fortran default: -1
    sincos : int
        sin$ or cos$
        Bmad type: integer
        Fortran default: 0
    """

    deriv: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Range: (iz0:iz1, 0:2*n_deriv_max+1)",
    )
    m: int = pydantic.Field(
        default=0,
        description="Azimuthal index",
    )
    n_deriv_max: int = pydantic.Field(
        default=-1,
        description=(
            "Max GG derivative The derivative matrix is extended to include the "
            "interpolating spline polynomial."
        ),
    )
    sincos: int = pydantic.Field(
        default=0,
        description="sin$ or cos$",
    )


class GenGradMapStruct(pydantic.BaseModel):
    """
    GenGradMapStruct corresponds to bmad `gen_grad_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 758.

    Attributes
    ----------
    curved_ref_frame : bool
        Bmad type: logical
        Fortran default: .false.
    dz : float
        Point spacing.
        Bmad type: real
        Fortran default: 0
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    field_type : int
        or electric$
        Bmad type: integer
        Fortran default: magnetic$
    file : str
        Input file name. Used also as ID for instances.
        Bmad type: character
        Fortran default: ''
    gg : GenGrad1Struct
        Bmad type: gen_grad1_struct
    iz0 : int
        gg%deriv(iz0:iz1, :) lower bound.
        Bmad type: integer
        Fortran default: int_garbage$
    iz1 : int
        gg%deriv(iz0:iz1, :) upper bound.
        Bmad type: integer
        Fortran default: int_garbage$
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    r0 : float
        field origin relative to ele_anchor_pt.
        Bmad type: real
        Fortran default: 0
    """

    curved_ref_frame: bool = pydantic.Field(
        default=False,
    )
    dz: float = pydantic.Field(
        default=0,
        description="Point spacing.",
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    field_type: int = pydantic.Field(
        default=0,
        description="or electric$",
    )
    file: str = pydantic.Field(
        default="",
        max_length=400,
        description="Input file name. Used also as ID for instances.",
    )
    gg: Sequence[GenGrad1Struct] = pydantic.Field(
        default=None,
    )
    iz0: int = pydantic.Field(
        default=0,
        description="gg%deriv(iz0:iz1, :) lower bound.",
    )
    iz1: int = pydantic.Field(
        default=0,
        description="gg%deriv(iz0:iz1, :) upper bound.",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="field origin relative to ele_anchor_pt.",
    )


class GridBeamInitStruct(pydantic.BaseModel):
    """
    GridBeamInitStruct corresponds to bmad `grid_beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1126.

    Attributes
    ----------
    n_px : int
        Number of rows.
        Bmad type: integer
        Fortran default: 0
    n_x : int
        Number of columns.
        Bmad type: integer
        Fortran default: 0
    px_max : float
        Upper px limit.
        Bmad type: real
        Fortran default: 0
    px_min : float
        Lower px limit.
        Bmad type: real
        Fortran default: 0
    x_max : float
        Upper x limit.
        Bmad type: real
        Fortran default: 0
    x_min : float
        Lower x limit.
        Bmad type: real
        Fortran default: 0
    """

    n_px: int = pydantic.Field(
        default=0,
        description="Number of rows.",
    )
    n_x: int = pydantic.Field(
        default=0,
        description="Number of columns.",
    )
    px_max: float = pydantic.Field(
        default=0,
        description="Upper px limit.",
    )
    px_min: float = pydantic.Field(
        default=0,
        description="Lower px limit.",
    )
    x_max: float = pydantic.Field(
        default=0,
        description="Upper x limit.",
    )
    x_min: float = pydantic.Field(
        default=0,
        description="Lower x limit.",
    )


class GridFieldPt1Struct(pydantic.BaseModel):
    """
    GridFieldPt1Struct corresponds to bmad `grid_field_pt1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 774.

    Attributes
    ----------
    b : Complex
        Bmad type: complex
        Fortran default: 0
    e : Complex
        Bmad type: complex
        Fortran default: 0
    """

    b: Sequence[Complex] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("b", "B"),
        serialization_alias="B",
    )
    e: Sequence[Complex] = pydantic.Field(
        default=0,
        max_length=3,
        validation_alias=pydantic.AliasChoices("e", "E"),
        serialization_alias="E",
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
        Bmad type: grid_field_pt1_struct
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
    bi_coef : BicubicCmplxCoefStruct
        Save computed coefs for faster tracking
        Bmad type: bicubic_cmplx_coef_struct
    curved_ref_frame : bool
        Bmad type: logical
        Fortran default: .false.
    dr : float
        Grid spacing.
        Bmad type: real
        Fortran default: 0
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    field_scale : float
        Factor to scale the fields by
        Bmad type: real
        Fortran default: 1
    field_type : int
        or magnetic$ or electric$
        Bmad type: integer
        Fortran default: mixed$
    geometry : int
        Type of grid: xyz$, or rotationally_symmetric_rz$
        Bmad type: integer
        Fortran default: 0
    harmonic : int
        Harmonic of fundamental for AC fields.
        Bmad type: integer
        Fortran default: 0
    interpolation_order : int
        Possibilities are 1 or 3.
        Bmad type: integer
        Fortran default: 1
    master_parameter : int
        Master parameter in ele%value(:) array to use for scaling the field.
        Bmad type: integer
        Fortran default: 0
    phi0_fieldmap : float
        Mode oscillates as: twopi * (f * t + phi0_fieldmap)
        Bmad type: real
        Fortran default: 0
    ptr : GridFieldPtStruct
        Bmad type: grid_field_pt_struct
        Fortran default: null()
    r0 : float
        Field origin relative to ele_anchor_pt.
        Bmad type: real
        Fortran default: 0
    tri_coef : TricubicCmplxCoefStruct
        Save computed coefs for faster tracking
        Bmad type: tricubic_cmplx_coef_struct
    """

    bi_coef: Sequence[BicubicCmplxCoefStruct] = pydantic.Field(
        default=None,
        description="Save computed coefs for faster tracking",
    )
    curved_ref_frame: bool = pydantic.Field(
        default=False,
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Grid spacing.",
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    field_scale: float = pydantic.Field(
        default=1,
        description="Factor to scale the fields by",
    )
    field_type: int = pydantic.Field(
        default=0,
        description="or magnetic$ or electric$",
    )
    geometry: int = pydantic.Field(
        default=0,
        description="Type of grid: xyz$, or rotationally_symmetric_rz$",
    )
    harmonic: int = pydantic.Field(
        default=0,
        description="Harmonic of fundamental for AC fields.",
    )
    interpolation_order: int = pydantic.Field(
        default=1,
        description="Possibilities are 1 or 3.",
    )
    master_parameter: int = pydantic.Field(
        default=0,
        description="Master parameter in ele%value(:) array to use for scaling the field.",
    )
    phi0_fieldmap: float = pydantic.Field(
        default=0,
        description="Mode oscillates as: twopi * (f * t + phi0_fieldmap)",
    )
    ptr: GridFieldPtStruct = pydantic.Field(
        default=None,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Field origin relative to ele_anchor_pt.",
    )
    tri_coef: Sequence[TricubicCmplxCoefStruct] = pydantic.Field(
        default=None,
        description="Save computed coefs for faster tracking",
    )


class HighEnergySpaceChargeStruct(pydantic.BaseModel):
    """
    HighEnergySpaceChargeStruct corresponds to bmad `high_energy_space_charge_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 835.

    Attributes
    ----------
    closed_orb : CoordStruct
        beam orbit
        Bmad type: coord_struct
    cos_phi : float
        Bmad type: real
    kick_const : float
        Bmad type: real
    phi : float
        Rotation angle to go from lab frame to rotated frame.
        Bmad type: real
    sig_x : float
        Bmad type: real
    sig_y : float
        Bmad type: real
    sig_z : float
        Bmad type: real
    sin_phi : float
        Bmad type: real
    """

    closed_orb: CoordStruct = pydantic.Field(
        default=None,
        description="beam orbit",
    )
    cos_phi: float = pydantic.Field(
        default=0.0,
    )
    kick_const: float = pydantic.Field(
        default=0.0,
    )
    phi: float = pydantic.Field(
        default=0.0,
        description="Rotation angle to go from lab frame to rotated frame.",
    )
    sig_x: float = pydantic.Field(
        default=0.0,
    )
    sig_y: float = pydantic.Field(
        default=0.0,
    )
    sig_z: float = pydantic.Field(
        default=0.0,
    )
    sin_phi: float = pydantic.Field(
        default=0.0,
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


class KvBeamInitStruct(pydantic.BaseModel):
    """
    KvBeamInitStruct corresponds to bmad `kv_beam_init_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1120.

    Attributes
    ----------
    a : float
        A = I1/e
        Bmad type: real
        Fortran default: 0
    n_i2 : int
        number of I2
        Bmad type: integer
        Fortran default: 0
    part_per_phi : int
        number of particles per angle variable.
        Bmad type: integer
        Fortran default: 0
    """

    a: float = pydantic.Field(
        default=0,
        description="A = I1/e",
        validation_alias=pydantic.AliasChoices("a", "A"),
        serialization_alias="A",
    )
    n_i2: int = pydantic.Field(
        default=0,
        description="number of I2",
        validation_alias=pydantic.AliasChoices("n_i2", "n_I2"),
        serialization_alias="n_I2",
    )
    part_per_phi: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
        description="number of particles per angle variable.",
    )


class LatEleLocStruct(pydantic.BaseModel):
    """
    LatEleLocStruct corresponds to bmad `lat_ele_loc_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 853.

    Attributes
    ----------
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Bmad type: integer
        Fortran default: -1
    """

    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_ele: int = pydantic.Field(
        default=-1,
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
        Bmad type: lat_ele_order1_struct
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
        Bmad type: lat_ele_order_array_struct
    """

    branch: Sequence[LatEleOrderArrayStruct] = pydantic.Field(
        default=None,
    )


class LatParamStruct(pydantic.BaseModel):
    """
    LatParamStruct corresponds to bmad `lat_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1474.

    Attributes
    ----------
    beam_init : BeamInitStruct
        For beam initialization.
        Bmad type: beam_init_struct
        Fortran default: beam_init_struct()
    bookkeeping_state : BookkeepingStateStruct
        Overall status for the branch.
        Bmad type: bookkeeping_state_struct
        Fortran default: bookkeeping_state_struct()
    default_tracking_species : int
        Default particle type to use in tracking.
        Bmad type: integer
        Fortran default: ref_particle$
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
    geometry : int
        open$ or closed$
        Bmad type: integer
        Fortran default: 0
    ixx : int
        Integer for general use
        Bmad type: integer
        Fortran default: 0
    live_branch : bool
        Should tracking be done on the branch?
        Bmad type: logical
        Fortran default: .true.
    n_part : float
        Particles/bunch (for BeamBeam elements).
        Bmad type: real
        Fortran default: 0
    particle : int
        Reference particle: positron$, electron$, etc. Call lattice_bookkeeper if this
        is changed.
        Bmad type: integer
        Fortran default: not_set$
    spin_tune : float
        Closed orbit spin tune.
        Bmad type: real
        Fortran default: 0
    stable : bool
        is closed lat stable?
        Bmad type: logical
        Fortran default: .false.
    t1_no_rf : float
        Full 1-turn matrix with RF off.
        Bmad type: real
        Fortran default: 0
    t1_with_rf : float
        Full 1-turn matrix with RF on.
        Bmad type: real
        Fortran default: 0
    total_length : float
        total_length of branch. Warning: branch may not start at s = 0.
        Bmad type: real
        Fortran default: 0
    unstable_factor : float
        If positive: Growth rate/turn if unstable in closed branches or |orbit-
        aperture|/aperture if particle hits wall. Zero otherwise.
        Bmad type: real
        Fortran default: 0
    """

    beam_init: BeamInitStruct = pydantic.Field(
        default=None,
        description="For beam initialization.",
    )
    bookkeeping_state: BookkeepingStateStruct = pydantic.Field(
        default=None,
        description="Overall status for the branch.",
    )
    default_tracking_species: int = pydantic.Field(
        default=0,
        description="Default particle type to use in tracking.",
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
    geometry: int = pydantic.Field(
        default=0,
        description="open$ or closed$",
    )
    ixx: int = pydantic.Field(
        default=0,
        description="Integer for general use",
    )
    live_branch: bool = pydantic.Field(
        default=True,
        description="Should tracking be done on the branch?",
    )
    n_part: float = pydantic.Field(
        default=0,
        description="Particles/bunch (for BeamBeam elements).",
    )
    particle: int = pydantic.Field(
        default=0,
        description=(
            "Reference particle: positron$, electron$, etc. Call lattice_bookkeeper if "
            "this is changed."
        ),
    )
    spin_tune: float = pydantic.Field(
        default=0,
        description="Closed orbit spin tune.",
    )
    stable: bool = pydantic.Field(
        default=False,
        description="is closed lat stable?",
    )
    t1_no_rf: Sequence[float] = pydantic.Field(
        default=0,
        description="Full 1-turn matrix with RF off.",
        validation_alias=pydantic.AliasChoices("t1_no_rf", "t1_no_RF"),
        serialization_alias="t1_no_RF",
    )
    t1_with_rf: Sequence[float] = pydantic.Field(
        default=0,
        description="Full 1-turn matrix with RF on.",
        validation_alias=pydantic.AliasChoices("t1_with_rf", "t1_with_RF"),
        serialization_alias="t1_with_RF",
    )
    total_length: float = pydantic.Field(
        default=0,
        description="total_length of branch. Warning: branch may not start at s = 0.",
    )
    unstable_factor: float = pydantic.Field(
        default=0,
        description=(
            "If positive: Growth rate/turn if unstable in closed branches or |orbit- "
            "aperture|/aperture if particle hits wall. Zero otherwise."
        ),
    )


class LatPointerStruct(pydantic.BaseModel):
    """
    LatPointerStruct corresponds to bmad `lat_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 909.

    Attributes
    ----------
    lat : LatStruct
        Bmad type: lat_struct
        Fortran default: null()
    """

    lat: LatStruct = pydantic.Field(
        default=None,
    )


class LatStruct(pydantic.BaseModel):
    """
    LatStruct corresponds to bmad `lat_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1592.

    Attributes
    ----------
    a : ModeInfoStruct
        Tunes (fractional part), etc.
        Bmad type: mode_info_struct
        Fortran default: null()
    b : ModeInfoStruct
        Tunes (fractional part), etc.
        Bmad type: mode_info_struct
        Fortran default: null()
    beam_init : BeamInitStruct
        Beam initialization.
        Bmad type: beam_init_struct
    branch : BranchStruct
        Branch(0:) array
        Bmad type: branch_struct
    constant : ExpressionAtomStruct
        Constants defined in the lattice
        Bmad type: expression_atom_struct
    control : ControlStruct
        Control list
        Bmad type: control_struct
    creation_hash : int
        Set by bmad_parser. creation_hash will vary if any of the lattice files are
        modified.
        Bmad type: integer
        Fortran default: 0
    custom : float
        Custom attributes.
        Bmad type: real
    ele : EleStruct
        Array of elements [=> branch(0)].
        Bmad type: ele_struct
        Fortran default: null()
    ele_init : EleStruct
        For use by any program
        Bmad type: ele_struct
    ic : int
        Index to %control(:) from slaves.
        Bmad type: integer, allocatable
    input_file_name : str
        Name of the lattice input file
        Bmad type: character
        Fortran default: ''
    input_taylor_order : int
        As set in the input file
        Bmad type: integer
        Fortran default: 0
    lattice : str
        Lattice
        Bmad type: character
        Fortran default: ''
    lord_state : BookkeepingStateStruct
        lord bookkeeping status.
        Bmad type: bookkeeping_state_struct
    machine : str
        Name of the machine the lattice is for ("LHC", etc).
        Bmad type: character
        Fortran default: ''
    n_control_max : int
        Last index used in control_array
        Bmad type: integer
        Fortran default: 0
    n_ele_max : int
        Index of last valid element in %ele(:) array
        Bmad type: integer, pointer
        Fortran default: null()
    n_ele_track : int
        Number of lat elements to track through.
        Bmad type: integer, pointer
        Fortran default: null()
    n_ic_max : int
        Last index used in ic_array
        Bmad type: integer
        Fortran default: 0
    nametable : NametableStruct
        For quick searching by element name.
        Bmad type: nametable_struct
    param : LatParamStruct
        Parameters
        Bmad type: lat_param_struct
        Fortran default: null()
    particle_start : CoordStruct
        Starting particle_coords.
        Bmad type: coord_struct
    photon_type : int
        Or coherent$. For X-ray simulations.
        Bmad type: integer
        Fortran default: incoherent$
    pre_tracker : PreTrackerStruct
        For OPAL/IMPACT-T
        Bmad type: pre_tracker_struct
    print_str : str
        Saved print statements.
        Bmad type: character
    ramper_slave_bookkeeping : int
        Bmad type: integer
        Fortran default: stale$
    title : str
        General title
        Bmad type: character
        Fortran default: ''
    use_name : str
        Name of lat given by USE statement
        Bmad type: character
        Fortran default: ''
    version : int
        Version number
        Bmad type: integer
        Fortran default: -1
    z : ModeInfoStruct
        Tunes (fractional part), etc.
        Bmad type: mode_info_struct
        Fortran default: null()
    """

    a: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Tunes (fractional part), etc.",
    )
    b: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Tunes (fractional part), etc.",
    )
    beam_init: BeamInitStruct = pydantic.Field(
        default=None,
        description="Beam initialization.",
    )
    branch: Sequence[BranchStruct] = pydantic.Field(
        default=None,
        description="Branch(0:) array",
    )
    constant: Sequence[ExpressionAtomStruct] = pydantic.Field(
        default=None,
        description="Constants defined in the lattice",
    )
    control: Sequence[ControlStruct] = pydantic.Field(
        default=None,
        description="Control list",
    )
    creation_hash: int = pydantic.Field(
        default=0,
        description=(
            "Set by bmad_parser. creation_hash will vary if any of the lattice files "
            "are modified."
        ),
    )
    custom: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Custom attributes.",
    )
    ele: Sequence[EleStruct] = pydantic.Field(
        default=None,
        description="Array of elements [=> branch(0)].",
    )
    ele_init: EleStruct = pydantic.Field(
        default=None,
        description="For use by any program",
    )
    ic: Sequence[int] = pydantic.Field(
        default=0,
        description="Index to %control(:) from slaves.",
    )
    input_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Name of the lattice input file",
    )
    input_taylor_order: int = pydantic.Field(
        default=0,
        description="As set in the input file",
    )
    lattice: str = pydantic.Field(
        default="",
        max_length=40,
        description="Lattice",
    )
    lord_state: BookkeepingStateStruct = pydantic.Field(
        default=None,
        description="lord bookkeeping status.",
    )
    machine: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of the machine the lattice is for ('LHC', etc).",
    )
    n_control_max: int = pydantic.Field(
        default=0,
        description="Last index used in control_array",
    )
    n_ele_max: int = pydantic.Field(
        default=0,
        description="Index of last valid element in %ele(:) array",
    )
    n_ele_track: int = pydantic.Field(
        default=0,
        description="Number of lat elements to track through.",
    )
    n_ic_max: int = pydantic.Field(
        default=0,
        description="Last index used in ic_array",
    )
    nametable: NametableStruct = pydantic.Field(
        default=None,
        description="For quick searching by element name.",
    )
    param: LatParamStruct = pydantic.Field(
        default=None,
        description="Parameters",
    )
    particle_start: CoordStruct = pydantic.Field(
        default=None,
        description="Starting particle_coords.",
    )
    photon_type: int = pydantic.Field(
        default=0,
        description="Or coherent$. For X-ray simulations.",
    )
    pre_tracker: PreTrackerStruct = pydantic.Field(
        default=None,
        description="For OPAL/IMPACT-T",
    )
    print_str: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=100,
        description="Saved print statements.",
    )
    ramper_slave_bookkeeping: int = pydantic.Field(
        default=0,
    )
    title: str = pydantic.Field(
        default="",
        max_length=80,
        description="General title",
    )
    use_name: str = pydantic.Field(
        default="",
        max_length=200,
        description="Name of lat given by USE statement",
    )
    version: int = pydantic.Field(
        default=-1,
        description="Version number",
    )
    z: ModeInfoStruct = pydantic.Field(
        default=None,
        description="Tunes (fractional part), etc.",
    )


class LinacNormalModeStruct(pydantic.BaseModel):
    """
    LinacNormalModeStruct corresponds to bmad `linac_normal_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1931.

    Attributes
    ----------
    a_emittance_end : float
        a mode emittance at end of linac
        Bmad type: real
        Fortran default: 0
    b_emittance_end : float
        b mode emittance at end of linac
        Bmad type: real
        Fortran default: 0
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
    """

    a_emittance_end: float = pydantic.Field(
        default=0,
        description="a mode emittance at end of linac",
    )
    b_emittance_end: float = pydantic.Field(
        default=0,
        description="b mode emittance at end of linac",
    )
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


class LinearEleIsfStruct(pydantic.BaseModel):
    """
    LinearEleIsfStruct corresponds to bmad `linear_ele_isf_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 322.

    Attributes
    ----------
    node : LinearIsf1Struct
        Array per PTC integration node.
        Bmad type: linear_isf1_struct
    """

    node: Sequence[LinearIsf1Struct] = pydantic.Field(
        default=None,
        description="Array per PTC integration node.",
    )


class LinearIsf1Struct(pydantic.BaseModel):
    """
    LinearIsf1Struct corresponds to bmad `linear_isf1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 313.

    Attributes
    ----------
    isf : float
        Linear ISF map at a given point.
        Bmad type: real
        Fortran default: 0
    orb0 : float
        Closed orbit.
        Bmad type: real
        Fortran default: 0
    s : float
        Offset from beginning of element. !! real(rp) :: m_1turn(6,6) = 0   ! Orbital
        1-turn matrix.
        Bmad type: real
        Fortran default: 0
    """

    isf: Sequence[float] = pydantic.Field(
        default=0,
        description="Linear ISF map at a given point.",
    )
    orb0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Closed orbit.",
    )
    s: float = pydantic.Field(
        default=0,
        description=(
            "Offset from beginning of element. !! real(rp) :: m_1turn(6,6) = 0   ! "
            "Orbital 1-turn matrix."
        ),
    )


class MaterialStruct(pydantic.BaseModel):
    """
    MaterialStruct corresponds to bmad `material_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1276.

    Attributes
    ----------
    area_density : float
        Bmad type: real
        Fortran default: real_garbage$
    area_density_used : float
        Bmad type: real
        Fortran default: real_garbage$
    density : float
        Bmad type: real
        Fortran default: real_garbage$
    density_used : float
        Bmad type: real
        Fortran default: real_garbage$
    number : int
        Relative number
        Bmad type: integer
        Fortran default: int_garbage$
    radiation_length : float
        Bmad type: real
        Fortran default: real_garbage$
    radiation_length_used : float
        Bmad type: real
        Fortran default: real_garbage$
    species : int
        Bmad type: integer
        Fortran default: not_set$
    """

    area_density: float = pydantic.Field(
        default=0.0,
    )
    area_density_used: float = pydantic.Field(
        default=0.0,
    )
    density: float = pydantic.Field(
        default=0.0,
    )
    density_used: float = pydantic.Field(
        default=0.0,
    )
    number: int = pydantic.Field(
        default=0,
        description="Relative number",
    )
    radiation_length: float = pydantic.Field(
        default=0.0,
    )
    radiation_length_used: float = pydantic.Field(
        default=0.0,
    )
    species: int = pydantic.Field(
        default=0,
    )


class Mode3Struct(pydantic.BaseModel):
    """
    Mode3Struct corresponds to bmad `mode3_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 915.

    Attributes
    ----------
    a : TwissStruct
        Bmad type: twiss_struct
    b : TwissStruct
        Bmad type: twiss_struct
    c : TwissStruct
        Bmad type: twiss_struct
    v : float
        Bmad type: real
    x : TwissStruct
        Bmad type: twiss_struct
    y : TwissStruct
        Bmad type: twiss_struct
    """

    a: TwissStruct = pydantic.Field(
        default=None,
    )
    b: TwissStruct = pydantic.Field(
        default=None,
    )
    c: TwissStruct = pydantic.Field(
        default=None,
    )
    v: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    x: TwissStruct = pydantic.Field(
        default=None,
    )
    y: TwissStruct = pydantic.Field(
        default=None,
    )


class ModeInfoStruct(pydantic.BaseModel):
    """
    ModeInfoStruct corresponds to bmad `mode_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1510.

    Attributes
    ----------
    chrom : float
        Chromaticity.
        Bmad type: real
        Fortran default: 0
    emit : float
        Emittance (unnormalized).
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
    stable : bool
        Is the mode stable?
        Bmad type: logical
        Fortran default: .false.
    tune : float
        "fractional" tune in radians
        Bmad type: real
        Fortran default: 0
    """

    chrom: float = pydantic.Field(
        default=0,
        description="Chromaticity.",
    )
    emit: float = pydantic.Field(
        default=0,
        description="Emittance (unnormalized).",
    )
    sigma: float = pydantic.Field(
        default=0,
        description="Beam size.",
    )
    sigmap: float = pydantic.Field(
        default=0,
        description="Beam divergence.",
    )
    stable: bool = pydantic.Field(
        default=False,
        description="Is the mode stable?",
    )
    tune: float = pydantic.Field(
        default=0,
        description="'fractional' tune in radians",
    )


class MultipassAllInfoStruct(pydantic.BaseModel):
    """
    MultipassAllInfoStruct corresponds to bmad `multipass_all_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2052.

    Attributes
    ----------
    branch : MultipassBranchInfoStruct
        Bmad type: multipass_branch_info_struct
    lord : MultipassLordInfoStruct
        Array of lords
        Bmad type: multipass_lord_info_struct
    """

    branch: Sequence[MultipassBranchInfoStruct] = pydantic.Field(
        default=None,
    )
    lord: Sequence[MultipassLordInfoStruct] = pydantic.Field(
        default=None,
        description="Array of lords",
    )


class MultipassBranchInfoStruct(pydantic.BaseModel):
    """
    MultipassBranchInfoStruct corresponds to bmad `multipass_branch_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2045.

    Attributes
    ----------
    ele : MultipassEleInfoStruct
        Bmad type: multipass_ele_info_struct
    """

    ele: Sequence[MultipassEleInfoStruct] = pydantic.Field(
        default=None,
    )


class MultipassEleInfoStruct(pydantic.BaseModel):
    """
    MultipassEleInfoStruct corresponds to bmad `multipass_ele_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2038.

    Attributes
    ----------
    ix_lord : int
        Pointers to lord(:) array
        Bmad type: integer, allocatable
    ix_pass : int
        Pass number
        Bmad type: integer
    ix_super : int
        Indexes to slave(ix_pass, super_slave%ix_ele) matrix
        Bmad type: integer, allocatable
    multipass : bool
        True if involved in multipass. False otherwise
        Bmad type: logical
    """

    ix_lord: Sequence[int] = pydantic.Field(
        default=0,
        description="Pointers to lord(:) array",
    )
    ix_pass: int = pydantic.Field(
        default=0,
        description="Pass number",
    )
    ix_super: Sequence[int] = pydantic.Field(
        default=0,
        description="Indexes to slave(ix_pass, super_slave%ix_ele) matrix",
    )
    multipass: bool = pydantic.Field(
        default=False,
        description="True if involved in multipass. False otherwise",
    )


class MultipassLordInfoStruct(pydantic.BaseModel):
    """
    MultipassLordInfoStruct corresponds to bmad `multipass_lord_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2027.

    Attributes
    ----------
    lord : EleStruct
        Lord element
        Bmad type: ele_struct
    n_pass : int
        Number of passes (= number of slaves)
        Bmad type: integer
    n_super_slave : int
        Number of super_slaves per super_lord.
        Bmad type: integer
    slave : ElePointerStruct
        Slaves list in tracking part.
        Bmad type: ele_pointer_struct
    super_lord : ElePointerStruct
        Super_lord list if they exist.
        Bmad type: ele_pointer_struct
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
    slave: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
        description="Slaves list in tracking part.",
    )
    super_lord: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
        description="Super_lord list if they exist.",
    )


class MultipoleCacheStruct(pydantic.BaseModel):
    """
    MultipoleCacheStruct corresponds to bmad `multipole_cache_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 946.

    Attributes
    ----------
    a_kick_elec : float
        Bmad type: real
    a_kick_mag : float
        Bmad type: real
    a_pole_elec : float
        Bmad type: real
    a_pole_mag : float
        Bmad type: real
    b_kick_elec : float
        Bmad type: real
    b_kick_mag : float
        Bmad type: real
    b_pole_elec : float
        Bmad type: real
    b_pole_mag : float
        Bmad type: real
    elec_valid : bool
        Bmad type: logical
        Fortran default: .false.
    ix_kick_elec_max : int
        Bmad type: integer
        Fortran default: -1
    ix_kick_mag_max : int
        Bmad type: integer
        Fortran default: -1
    ix_pole_elec_max : int
        Bmad type: integer
        Fortran default: -1
    ix_pole_mag_max : int
        Bmad type: integer
        Fortran default: -1
    mag_valid : bool
        From elseparator hkick and vkick.
        Bmad type: logical
        Fortran default: .false.
    """

    a_kick_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a_kick_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    a_pole_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_kick_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_kick_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_pole_elec: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    b_pole_mag: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    elec_valid: bool = pydantic.Field(
        default=False,
    )
    ix_kick_elec_max: int = pydantic.Field(
        default=-1,
    )
    ix_kick_mag_max: int = pydantic.Field(
        default=-1,
    )
    ix_pole_elec_max: int = pydantic.Field(
        default=-1,
    )
    ix_pole_mag_max: int = pydantic.Field(
        default=-1,
    )
    mag_valid: bool = pydantic.Field(
        default=False,
        description="From elseparator hkick and vkick.",
    )


class NormalModesStruct(pydantic.BaseModel):
    """
    NormalModesStruct corresponds to bmad `normal_modes_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1941.

    Attributes
    ----------
    a : AnormalModeStruct
        Bmad type: anormal_mode_struct
        Fortran default: anormal_mode_struct()
    b : AnormalModeStruct
        Bmad type: anormal_mode_struct
        Fortran default: anormal_mode_struct()
    dpz_damp : float
        Change in pz without RF
        Bmad type: real
        Fortran default: 0
    e_loss : float
        Energy loss / turn (eV)
        Bmad type: real
        Fortran default: 0
    lin : LinacNormalModeStruct
        Bmad type: linac_normal_mode_struct
        Fortran default: linac_normal_mode_struct()
    momentum_compaction : float
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
    rf_voltage : float
        Total rfcavity voltage (eV)
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
    synch_int : float
        Synchrotron integrals I0, I1, I2, and I3
        Bmad type: real
        Fortran default: 0
    z : AnormalModeStruct
        Bmad type: anormal_mode_struct
        Fortran default: anormal_mode_struct()
    """

    a: AnormalModeStruct = pydantic.Field(
        default=None,
    )
    b: AnormalModeStruct = pydantic.Field(
        default=None,
    )
    dpz_damp: float = pydantic.Field(
        default=0,
        description="Change in pz without RF",
    )
    e_loss: float = pydantic.Field(
        default=0,
        description="Energy loss / turn (eV)",
    )
    lin: LinacNormalModeStruct = pydantic.Field(
        default=None,
    )
    momentum_compaction: float = pydantic.Field(
        default=0,
    )
    pz_aperture: float = pydantic.Field(
        default=0,
        description="pz aperture limit. Used with Touschek calculations.",
    )
    pz_average: float = pydantic.Field(
        default=0,
        description="Average over branch due to damping.",
    )
    rf_voltage: float = pydantic.Field(
        default=0,
        description="Total rfcavity voltage (eV)",
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
    synch_int: Sequence[float] = pydantic.Field(
        default=0,
        description="Synchrotron integrals I0, I1, I2, and I3",
    )
    z: AnormalModeStruct = pydantic.Field(
        default=None,
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


class PhotonElementStruct(pydantic.BaseModel):
    """
    PhotonElementStruct corresponds to bmad `photon_element_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1072.

    Attributes
    ----------
    curvature : SurfaceCurvatureStruct
        Bmad type: surface_curvature_struct
        Fortran default: surface_curvature_struct()
    displacement : SurfaceDisplacementStruct
        Bmad type: surface_displacement_struct
        Fortran default: surface_displacement_struct(.false., 0, 0, null())
    h_misalign : SurfaceHMisalignStruct
        Bmad type: surface_h_misalign_struct
        Fortran default: surface_h_misalign_struct(.false., 0, 0, null())
    init_energy_prob : SplineStruct
        Initial energy probability density
        Bmad type: spline_struct
    integrated_init_energy_prob : float
        Bmad type: real
    material : PhotonMaterialStruct
        Bmad type: photon_material_struct
        Fortran default: photon_material_struct()
    pixel : PixelDetecStruct
        Bmad type: pixel_detec_struct
        Fortran default: pixel_detec_struct([0.0_rp, 0.0_rp], [0.0_rp, 0.0_rp], 0, 0, 0, null())
    reflectivity_table_pi : PhotonReflectTableStruct
        Bmad type: photon_reflect_table_struct
    reflectivity_table_sigma : PhotonReflectTableStruct
        If polarization is ignored use sigma table.
        Bmad type: photon_reflect_table_struct
    reflectivity_table_type : int
        Bmad type: integer
        Fortran default: not_set$
    segmented : SurfaceSegmentedStruct
        Bmad type: surface_segmented_struct
        Fortran default: surface_segmented_struct(.false., 0, 0, null())
    target : PhotonTargetStruct
        Bmad type: photon_target_struct
        Fortran default: photon_target_struct()
    """

    curvature: SurfaceCurvatureStruct = pydantic.Field(
        default=None,
    )
    displacement: SurfaceDisplacementStruct = pydantic.Field(
        default=None,
    )
    h_misalign: SurfaceHMisalignStruct = pydantic.Field(
        default=None,
    )
    init_energy_prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
        description="Initial energy probability density",
    )
    integrated_init_energy_prob: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    material: PhotonMaterialStruct = pydantic.Field(
        default=None,
    )
    pixel: PixelDetecStruct = pydantic.Field(
        default=None,
    )
    reflectivity_table_pi: PhotonReflectTableStruct = pydantic.Field(
        default=None,
    )
    reflectivity_table_sigma: PhotonReflectTableStruct = pydantic.Field(
        default=None,
        description="If polarization is ignored use sigma table.",
    )
    reflectivity_table_type: int = pydantic.Field(
        default=0,
    )
    segmented: SurfaceSegmentedStruct = pydantic.Field(
        default=None,
    )
    target: PhotonTargetStruct = pydantic.Field(
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


class PhotonReflectSurfaceStruct(pydantic.BaseModel):
    """
    PhotonReflectSurfaceStruct corresponds to bmad `photon_reflect_surface_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 218.

    Attributes
    ----------
    description : str
        Descriptive name
        Bmad type: character
        Fortran default: ''
    ix_surface : int
        Bmad type: integer
        Fortran default: -1
    name : str
        Bmad type: character
        Fortran default: ''
    reflectivity_file : str
        Bmad type: character
        Fortran default: ''
    roughness_correlation_len : float
        T in Dugan's notation
        Bmad type: real
        Fortran default: 0
    surface_roughness_rms : float
        sigma in Dugan's notation
        Bmad type: real
        Fortran default: 0
    table : PhotonReflectTableStruct
        Bmad type: photon_reflect_table_struct
    """

    description: str = pydantic.Field(
        default="",
        max_length=80,
        description="Descriptive name",
    )
    ix_surface: int = pydantic.Field(
        default=-1,
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    reflectivity_file: str = pydantic.Field(
        default="",
        max_length=200,
    )
    roughness_correlation_len: float = pydantic.Field(
        default=0,
        description="T in Dugan's notation",
    )
    surface_roughness_rms: float = pydantic.Field(
        default=0,
        description="sigma in Dugan's notation",
    )
    table: Sequence[PhotonReflectTableStruct] = pydantic.Field(
        default=None,
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
    bragg_angle : float
        Bragg angle at energy values.
        Bmad type: real
    energy : float
        Vector of energy values for %p_reflect
        Bmad type: real
    int1 : Interval1CoefStruct
        Bmad type: interval1_coef_struct
    max_energy : float
        maximum energy for this table
        Bmad type: real
        Fortran default: -1
    p_reflect : float
        (angle, ev) probability. Log used for smooth surface reflection
        Bmad type: real
    p_reflect_scratch : float
        Scratch space
        Bmad type: real
    """

    angle: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Vector of angle values for %p_reflect",
    )
    bragg_angle: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Bragg angle at energy values.",
    )
    energy: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Vector of energy values for %p_reflect",
    )
    int1: Sequence[Interval1CoefStruct] = pydantic.Field(
        default=None,
    )
    max_energy: float = pydantic.Field(
        default=-1,
        description="maximum energy for this table",
    )
    p_reflect: Sequence[float] = pydantic.Field(
        default=0.0,
        description="(angle, ev) probability. Log used for smooth surface reflection",
    )
    p_reflect_scratch: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Scratch space",
    )


class PhotonTargetStruct(pydantic.BaseModel):
    """
    PhotonTargetStruct corresponds to bmad `photon_target_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1049.

    Attributes
    ----------
    center : TargetPointStruct
        Bmad type: target_point_struct
        Fortran default: target_point_struct()
    corner : TargetPointStruct
        Bmad type: target_point_struct
        Fortran default: target_point_struct()
    ele_loc : LatEleLocStruct
        Bmad type: lat_ele_loc_struct
        Fortran default: lat_ele_loc_struct()
    n_corner : int
        Bmad type: integer
        Fortran default: 0
    type : int
        or rectangular$
        Bmad type: integer
        Fortran default: off$
    """

    center: TargetPointStruct = pydantic.Field(
        default=None,
    )
    corner: Sequence[TargetPointStruct] = pydantic.Field(
        default=None,
        max_length=8,
    )
    ele_loc: LatEleLocStruct = pydantic.Field(
        default=None,
    )
    n_corner: int = pydantic.Field(
        default=0,
    )
    type: int = pydantic.Field(
        default=0,
        description="or rectangular$",
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
    n_hit_detec : int
        How many photons hit the detector.
        Bmad type: integer
        Fortran default: 0
    n_hit_pixel : int
        How many photons hit the pixel grid of the detector.
        Bmad type: integer
        Fortran default: 0
    n_track_tot : int
        How many photons were launched from source element.
        Bmad type: integer
        Fortran default: 0
    pt : PixelPtStruct
        Grid of pixels
        Bmad type: pixel_pt_struct
    r0 : float
        Bmad type: real
        Fortran default: 0
    """

    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
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
    n_track_tot: int = pydantic.Field(
        default=0,
        max_length=8,
        description="How many photons were launched from source element.",
    )
    pt: Sequence[PixelPtStruct] = pydantic.Field(
        default=None,
        description="Grid of pixels",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )


class PixelPtStruct(pydantic.BaseModel):
    """
    PixelPtStruct corresponds to bmad `pixel_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1016.

    Attributes
    ----------
    e_x : Complex
        Bmad type: complex
        Fortran default: 0
    e_y : Complex
        Bmad type: complex
        Fortran default: 0
    init_orbit : float
        Initial orbit at start of lattice statistics.
        Bmad type: real
        Fortran default: 0
    init_orbit_rms : float
        Initial orbit at start of lattice RMS statistics.
        Bmad type: real
        Fortran default: 0
    intensity : float
        Bmad type: real
        Fortran default: 0
    intensity_x : float
        Bmad type: real
        Fortran default: 0
    intensity_y : float
        Bmad type: real
        Fortran default: 0
    n_photon : int
        Bmad type: integer
        Fortran default: 0
    orbit : float
        x, Vx/c, y, Vy/c, dummy, E - E_ref.
        Bmad type: real
        Fortran default: 0
    orbit_rms : float
        RMS statistics.
        Bmad type: real
        Fortran default: 0
    """

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
    intensity: float = pydantic.Field(
        default=0,
    )
    intensity_x: float = pydantic.Field(
        default=0,
    )
    intensity_y: float = pydantic.Field(
        default=0,
    )
    n_photon: int = pydantic.Field(
        default=0,
        max_length=8,
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


class PmdHeaderStruct(pydantic.BaseModel):
    """
    PmdHeaderStruct corresponds to bmad `pmd_header_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2357.

    Attributes
    ----------
    author : str
        Bmad type: character
    basepath : str
        Bmad type: character
    date : str
        Bmad type: character
    latticefile : str
        Bmad type: character
    latticename : str
        Bmad type: character
    meshespath : str
        Bmad type: character
    openpmd : str
        Bmad type: character
    openpmdextension : str
        Bmad type: character
    particlespath : str
        Bmad type: character
    software : str
        Bmad type: character
    softwareversion : str
        Bmad type: character
    """

    author: str = pydantic.Field(
        default="",
    )
    basepath: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("basepath", "basePath"),
        serialization_alias="basePath",
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
    meshespath: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("meshespath", "meshesPath"),
        serialization_alias="meshesPath",
    )
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
    particlespath: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("particlespath", "particlesPath"),
        serialization_alias="particlesPath",
    )
    software: str = pydantic.Field(
        default="",
    )
    softwareversion: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("softwareversion", "softwareVersion"),
        serialization_alias="softwareVersion",
    )


class PreTrackerStruct(pydantic.BaseModel):
    """
    PreTrackerStruct corresponds to bmad `pre_tracker_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1576.

    Attributes
    ----------
    input_file : str
        Bmad type: character
        Fortran default: ''
    ix_ele_end : int
        Bmad type: integer
        Fortran default: 0
    ix_ele_start : int
        Bmad type: integer
        Fortran default: 0
    who : int
        Can be opal$, or impactt$
        Bmad type: integer
        Fortran default: 0
    """

    input_file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    ix_ele_end: int = pydantic.Field(
        default=0,
    )
    ix_ele_start: int = pydantic.Field(
        default=0,
    )
    who: int = pydantic.Field(
        default=0,
        description="Can be opal$, or impactt$",
    )


class PtcBranch1Struct(pydantic.BaseModel):
    """
    PtcBranch1Struct corresponds to bmad `ptc_branch1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1503.

    Attributes
    ----------
    m_t_layout : Layout
        Tracking layout.
        Bmad type: layout
        Fortran default: null()
    m_u_layout : PtcLayoutPointerStruct
        Bmad type: ptc_layout_pointer_struct
    """

    m_t_layout: Layout = pydantic.Field(
        default=None,
        description="Tracking layout.",
    )
    m_u_layout: Sequence[PtcLayoutPointerStruct] = pydantic.Field(
        default=None,
    )


class PtcCommonStruct(pydantic.BaseModel):
    """
    PtcCommonStruct corresponds to bmad `ptc_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2280.

    Attributes
    ----------
    cut_factor : float
        Cut factor for PTC tracking
        Bmad type: real
        Fortran default: 0.006
    exact_misalign : bool
        Points to PTC ALWAYS_EXACTMIS. Default True. Notice different names.
        Bmad type: logical, pointer
        Fortran default: null()
    exact_model : bool
        Points to PTC EXACT_MODEL. Default True.
        Bmad type: logical, pointer
        Fortran default: null()
    max_fringe_order : int
        Points to PTC HIGHEST_FRINGE. 2 (default) => Quadrupole.
        Bmad type: integer, pointer
        Fortran default: null()
    old_integrator : int
        Points to PTC OLD_INTEGRATOR. -1 = False, 1 = True.
        Bmad type: integer, pointer
        Fortran default: null()
    print_info_messages : bool
        Allow PTC to print informational messages (which can clutter the output)?
        Bmad type: logical
        Fortran default: .false.
    print_step_warning : bool
        Print warning if element uses too many steps. Below is stuff that should not be
        set except by experts
        Bmad type: logical
        Fortran default: .false.
    translate_patch_drift_time : bool
        When a Bmad patch is translated to a PTC fibre, is the drift time included in
        the translation?
        Bmad type: logical
        Fortran default: .true.
    use_orientation_patches : bool
        offset, pitch, and tilt attributes are put in ptc patch?
        Bmad type: logical
        Fortran default: .true.
    vertical_kick : float
        Points to PTC VERTICAL_KICK for 6D emittance calc. 0 => off, 1 => on (default).
        Bmad type: real
        Fortran default: null()
    """

    cut_factor: float = pydantic.Field(
        default=0.006,
        description="Cut factor for PTC tracking",
    )
    exact_misalign: bool = pydantic.Field(
        default=False,
        description="Points to PTC ALWAYS_EXACTMIS. Default True. Notice different names.",
    )
    exact_model: bool = pydantic.Field(
        default=False,
        description="Points to PTC EXACT_MODEL. Default True.",
    )
    max_fringe_order: int = pydantic.Field(
        default=0,
        description="Points to PTC HIGHEST_FRINGE. 2 (default) => Quadrupole.",
    )
    old_integrator: int = pydantic.Field(
        default=0,
        description="Points to PTC OLD_INTEGRATOR. -1 = False, 1 = True.",
    )
    print_info_messages: bool = pydantic.Field(
        default=False,
        description="Allow PTC to print informational messages (which can clutter the output)?",
    )
    print_step_warning: bool = pydantic.Field(
        default=False,
        description=(
            "Print warning if element uses too many steps. Below is stuff that should "
            "not be set except by experts"
        ),
    )
    translate_patch_drift_time: bool = pydantic.Field(
        default=True,
        description=(
            "When a Bmad patch is translated to a PTC fibre, is the drift time included "
            "in the translation?"
        ),
    )
    use_orientation_patches: bool = pydantic.Field(
        default=True,
        description="offset, pitch, and tilt attributes are put in ptc patch?",
    )
    vertical_kick: float = pydantic.Field(
        default=0.0,
        description="Points to PTC VERTICAL_KICK for 6D emittance calc. 0 => off, 1 => on (default).",
    )


class PtcLayoutPointerStruct(pydantic.BaseModel):
    """
    PtcLayoutPointerStruct corresponds to bmad `ptc_layout_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1499.

    Attributes
    ----------
    ptr : Layout
        Bmad type: layout
        Fortran default: null()
    """

    ptr: Layout = pydantic.Field(
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
        Bmad type: ele_struct
        Fortran default: null()
    isf : CQuaternion
        Invariant spin field in (x, px, ...) space.
        Bmad type: c_quaternion
    normal_form : CNormalForm
        Complex normal form
        Bmad type: c_normal_form
    one_turn_map : Probe8
        One turn map
        Bmad type: probe_8
    orb0 : float
        Closed orbit at element.
        Bmad type: real
    path_length : CTaylor
        Path length map. Gives momentum compaction.
        Bmad type: c_taylor
    phase : CTaylor
        Phase/chromaticity maps
        Bmad type: c_taylor
    spin_tune : CTaylor
        Amplitude dependent spin tune
        Bmad type: c_taylor
    state : InternalState
        PTC state
        Bmad type: internal_state
    valid_map : bool
        Bmad type: logical
        Fortran default: .false.
    """

    ele_origin: EleStruct = pydantic.Field(
        default=None,
        description="Element at which the on-turn map was created.",
    )
    isf: CQuaternion = pydantic.Field(
        default=None,
        description="Invariant spin field in (x, px, ...) space.",
    )
    normal_form: CNormalForm = pydantic.Field(
        default=None,
        description="Complex normal form",
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
    path_length: CTaylor = pydantic.Field(
        default=None,
        description="Path length map. Gives momentum compaction.",
    )
    phase: Sequence[CTaylor] = pydantic.Field(
        default=None,
        max_length=3,
        description="Phase/chromaticity maps",
    )
    spin_tune: CTaylor = pydantic.Field(
        default=None,
        description="Amplitude dependent spin tune",
    )
    state: InternalState = pydantic.Field(
        default=None,
        description="PTC state",
    )
    valid_map: bool = pydantic.Field(
        default=False,
    )


class PtcPrivateStruct(pydantic.BaseModel):
    """
    PtcPrivateStruct corresponds to bmad `ptc_private_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2307.

    Attributes
    ----------
    base_state : InternalState
        Base PTC state.
        Bmad type: internal_state
    e_tot_set : float
        Bmad type: real
        Fortran default: 0
    init_ptc_needed : bool
        Bmad type: logical
        Fortran default: .true.
    init_spin_needed : bool
        Bmad type: logical
        Fortran default: .true.
    taylor_order_ptc : int
        What has been set in PTC. 0 -> not yet set. See above.
        Bmad type: integer
        Fortran default: 0
    taylor_order_saved : int
        Default to use at startup.
        Bmad type: integer
        Fortran default: 3
    """

    base_state: InternalState = pydantic.Field(
        default=None,
        description="Base PTC state.",
    )
    e_tot_set: float = pydantic.Field(
        default=0,
    )
    init_ptc_needed: bool = pydantic.Field(
        default=True,
    )
    init_spin_needed: bool = pydantic.Field(
        default=True,
    )
    taylor_order_ptc: int = pydantic.Field(
        default=0,
        description="What has been set in PTC. 0 -> not yet set. See above.",
    )
    taylor_order_saved: int = pydantic.Field(
        default=3,
        description="Default to use at startup.",
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


class RadIntAllEleStruct(pydantic.BaseModel):
    """
    RadIntAllEleStruct corresponds to bmad `rad_int_all_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2351.

    Attributes
    ----------
    branch : RadIntBranchStruct
        Array is indexed from 0
        Bmad type: rad_int_branch_struct
    """

    branch: Sequence[RadIntBranchStruct] = pydantic.Field(
        default=None,
        description="Array is indexed from 0",
    )


class RadIntBranchStruct(pydantic.BaseModel):
    """
    RadIntBranchStruct corresponds to bmad `rad_int_branch_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2347.

    Attributes
    ----------
    ele : RadInt1Struct
        Array is indexed from 0
        Bmad type: rad_int1_struct
    """

    ele: Sequence[RadInt1Struct] = pydantic.Field(
        default=None,
        description="Array is indexed from 0",
    )


class RadMapEleStruct(pydantic.BaseModel):
    """
    RadMapEleStruct corresponds to bmad `rad_map_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 969.

    Attributes
    ----------
    rm0 : RadMapStruct
        Upstream half and downstream half matrices for an element.
        Bmad type: rad_map_struct
    rm1 : RadMapStruct
        Upstream half and downstream half matrices for an element.
        Bmad type: rad_map_struct
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


class RadMapStruct(pydantic.BaseModel):
    """
    RadMapStruct corresponds to bmad `rad_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 961.

    Attributes
    ----------
    damp_dmat : float
        damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.
        Bmad type: real
        Fortran default: 0
    ref_orb : float
        Reference point around which damp_mat is calculated.
        Bmad type: real
        Fortran default: -1
    stoc_mat : float
        Stochastic variance or "kick" (Cholesky decomposed) matrix.
        Bmad type: real
        Fortran default: 0
    xfer_damp_mat : float
        1st order matrix: xfer_no_damp_mat + xfer_damp_correction.
        Bmad type: real
        Fortran default: mat6_unit$
    xfer_damp_vec : float
        Transfer map with damping 0th order vector.
        Bmad type: real
        Fortran default: 0
    """

    damp_dmat: Sequence[float] = pydantic.Field(
        default=0,
        description="damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.",
    )
    ref_orb: Sequence[float] = pydantic.Field(
        default=-1,
        max_length=6,
        description="Reference point around which damp_mat is calculated.",
    )
    stoc_mat: Sequence[float] = pydantic.Field(
        default=0,
        description="Stochastic variance or 'kick' (Cholesky decomposed) matrix.",
    )
    xfer_damp_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description="1st order matrix: xfer_no_damp_mat + xfer_damp_correction.",
    )
    xfer_damp_vec: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Transfer map with damping 0th order vector.",
    )


class RamperLordStruct(pydantic.BaseModel):
    """
    RamperLordStruct corresponds to bmad `ramper_lord_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1337.

    Attributes
    ----------
    attrib_ptr : float
        Pointer to attribute in this element.
        Bmad type: real
        Fortran default: null()
    ix_con : int
        Index in lord%control%ramp(:) array
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Lord index
        Bmad type: integer
        Fortran default: 0
    """

    attrib_ptr: float = pydantic.Field(
        default=0.0,
        description="Pointer to attribute in this element.",
    )
    ix_con: int = pydantic.Field(
        default=0,
        description="Index in lord%control%ramp(:) array",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="Lord index",
    )


class ResonanceHStruct(pydantic.BaseModel):
    """
    ResonanceHStruct corresponds to bmad `resonance_h_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1521.

    Attributes
    ----------
    c_val : Complex
        Resonance value
        Bmad type: complex
        Fortran default: 0
    id : str
        6 digit ID. EG: '003100'
        Bmad type: character
        Fortran default: ''
    """

    c_val: Complex = pydantic.Field(
        default=0,
        description="Resonance value",
    )
    id: str = pydantic.Field(
        default="",
        max_length=6,
        description="6 digit ID. EG: '003100'",
    )


class SpaceChargeCommonStruct(pydantic.BaseModel):
    """
    SpaceChargeCommonStruct corresponds to bmad `space_charge_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2093.

    Attributes
    ----------
    abs_tol_tracking : float
        Absolute tolerance for tracking.
        Bmad type: real
        Fortran default: 1d-10
    beam_chamber_height : float
        Used in shielding calculation.
        Bmad type: real
        Fortran default: 0
    cathode_strength_cutoff : float
        Cutoff for the cathode field calc.
        Bmad type: real
        Fortran default: 0.01
    csr3d_mesh_size : int
        Gird size for CSR.
        Bmad type: integer
        Fortran default: [32, 32, 64]
    debug : bool
        Bmad type: logical
        Fortran default: .false.
    diagnostic_output_file : str
        If non-blank write a diagnostic (EG wake) file
        Bmad type: character
        Fortran default: ''
    ds_track_step : float
        CSR tracking step size
        Bmad type: real
        Fortran default: 0
    dt_track_step : float
        Time Runge kutta initial step.
        Bmad type: real
        Fortran default: 1d-12
    lsc_kick_transverse_dependence : bool
        Bmad type: logical
        Fortran default: .false.
    lsc_sigma_cutoff : float
        Cutoff for the 1-dim longitudinal SC calc. If a bin sigma is < cutoff *
        sigma_ave then ignore.
        Bmad type: real
        Fortran default: 0.1
    n_bin : int
        Number of bins used
        Bmad type: integer
        Fortran default: 0
    n_shield_images : int
        Chamber wall shielding. 0 = no shielding.
        Bmad type: integer
        Fortran default: 0
    particle_bin_span : int
        Longitudinal particle length / dz_bin
        Bmad type: integer
        Fortran default: 2
    particle_sigma_cutoff : float
        3D SC calc cutoff for particles with (x,y,z) position far from the center.
        Negative or zero means ignore.
        Bmad type: real
        Fortran default: -1
    rel_tol_tracking : float
        Relative tolerance for tracking.
        Bmad type: real
        Fortran default: 1d-8
    sc_min_in_bin : int
        Minimum number of particles in a bin for sigmas to be valid.
        Bmad type: integer
        Fortran default: 10
    space_charge_mesh_size : int
        Gird size for fft_3d space charge calc.
        Bmad type: integer
        Fortran default: [32, 32, 64]
    """

    abs_tol_tracking: float = pydantic.Field(
        default=1e-10,
        description="Absolute tolerance for tracking.",
    )
    beam_chamber_height: float = pydantic.Field(
        default=0,
        description="Used in shielding calculation.",
    )
    cathode_strength_cutoff: float = pydantic.Field(
        default=0.01,
        description="Cutoff for the cathode field calc.",
    )
    csr3d_mesh_size: Sequence[int] = pydantic.Field(
        default=[32, 32, 64],
        max_length=3,
        description="Gird size for CSR.",
    )
    debug: bool = pydantic.Field(
        default=False,
    )
    diagnostic_output_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="If non-blank write a diagnostic (EG wake) file",
    )
    ds_track_step: float = pydantic.Field(
        default=0,
        description="CSR tracking step size",
    )
    dt_track_step: float = pydantic.Field(
        default=1e-12,
        description="Time Runge kutta initial step.",
    )
    lsc_kick_transverse_dependence: bool = pydantic.Field(
        default=False,
    )
    lsc_sigma_cutoff: float = pydantic.Field(
        default=0.1,
        description=(
            "Cutoff for the 1-dim longitudinal SC calc. If a bin sigma is < cutoff * "
            "sigma_ave then ignore."
        ),
    )
    n_bin: int = pydantic.Field(
        default=0,
        description="Number of bins used",
    )
    n_shield_images: int = pydantic.Field(
        default=0,
        description="Chamber wall shielding. 0 = no shielding.",
    )
    particle_bin_span: int = pydantic.Field(
        default=2,
        description="Longitudinal particle length / dz_bin",
    )
    particle_sigma_cutoff: float = pydantic.Field(
        default=-1,
        description=(
            "3D SC calc cutoff for particles with (x,y,z) position far from the center. "
            "Negative or zero means ignore."
        ),
    )
    rel_tol_tracking: float = pydantic.Field(
        default=1e-08,
        description="Relative tolerance for tracking.",
    )
    sc_min_in_bin: int = pydantic.Field(
        default=10,
        description="Minimum number of particles in a bin for sigmas to be valid.",
    )
    space_charge_mesh_size: Sequence[int] = pydantic.Field(
        default=[32, 32, 64],
        max_length=3,
        description="Gird size for fft_3d space charge calc.",
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
    m : float
        Transverse axis.
        Bmad type: real
        Fortran default: 0
    n0 : float
        Invariant spin axis on closed orbit.
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
    m: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Transverse axis.",
    )
    n0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Invariant spin axis on closed orbit.",
    )


class SpinEigenStruct(pydantic.BaseModel):
    """
    SpinEigenStruct corresponds to bmad `spin_eigen_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 269.

    Attributes
    ----------
    val : Complex
        Bmad type: complex
        Fortran default: 0
    vec : Complex
        Bmad type: complex
        Fortran default: 0
    """

    val: Complex = pydantic.Field(
        default=0,
    )
    vec: Sequence[Complex] = pydantic.Field(
        default=0,
        max_length=8,
    )


class SpinMatchingStruct(pydantic.BaseModel):
    """
    SpinMatchingStruct corresponds to bmad `spin_matching_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 280.

    Attributes
    ----------
    m_1turn : float
        1-turn matrix
        Bmad type: real
        Fortran default: 0
    m_ele : float
        Transfer matrix through element.
        Bmad type: real
        Fortran default: 0
    alpha : float
        Alpha vector
        Bmad type: real
        Fortran default: 0
    axis : SpinAxisStruct
        Bmad type: spin_axis_struct
        Fortran default: spin_axis_struct()
    beta : float
        Beta vector
        Bmad type: real
        Fortran default: 0
    dn_dpz : float
        Invariant spin derivative
        Bmad type: real
        Fortran default: 0
    eigen : SpinEigenStruct
        Bmad type: spin_eigen_struct
        Fortran default: spin_eigen_struct()
    orb0 : float
        Closed orbit
        Bmad type: real
        Fortran default: 0
    sq_1turn : float
        Bmad type: real
        Fortran default: 0
    sq_ele : float
        Bmad type: real
        Fortran default: 0
    valid : bool
        Bmad type: logical
        Fortran default: .false.
    """

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
    alpha: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Alpha vector",
    )
    axis: SpinAxisStruct = pydantic.Field(
        default=None,
    )
    beta: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Beta vector",
    )
    dn_dpz: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Invariant spin derivative",
    )
    eigen: Sequence[SpinEigenStruct] = pydantic.Field(
        default=None,
        max_length=8,
    )
    orb0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Closed orbit",
    )
    sq_1turn: Sequence[float] = pydantic.Field(
        default=0,
    )
    sq_ele: Sequence[float] = pydantic.Field(
        default=0,
    )
    valid: bool = pydantic.Field(
        default=False,
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
    spin_q : float
        0th and 1st order quaternion spin map
        Bmad type: real
        Fortran default: 0
    vec0 : float
        Orbital 0th order map: r_out = mat6 * r_in + vec0
        Bmad type: real
        Fortran default: 0
    """

    orb_mat: Sequence[float] = pydantic.Field(
        default=0,
        description="Orbital matrix",
    )
    spin_q: Sequence[float] = pydantic.Field(
        default=0,
        description="0th and 1st order quaternion spin map",
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
        description="Orbital 0th order map: r_out = mat6 * r_in + vec0",
    )


class SpinPolarStruct(pydantic.BaseModel):
    """
    SpinPolarStruct corresponds to bmad `spin_polar_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 296.

    Attributes
    ----------
    phi : float
        Spherical coords: Angle in (x,y) plane.
        Bmad type: real
        Fortran default: 0
    polarization : float
        Bmad type: real
        Fortran default: 1
    theta : float
        Spherical coords: Angle from z-axis.
        Bmad type: real
        Fortran default: 0
    xi : float
        Spinor phase angle (See Bmad manual).
        Bmad type: real
        Fortran default: 0
    """

    phi: float = pydantic.Field(
        default=0,
        description="Spherical coords: Angle in (x,y) plane.",
    )
    polarization: float = pydantic.Field(
        default=1,
    )
    theta: float = pydantic.Field(
        default=0,
        description="Spherical coords: Angle from z-axis.",
    )
    xi: float = pydantic.Field(
        default=0,
        description="Spinor phase angle (See Bmad manual).",
    )


class StrongBeamStruct(pydantic.BaseModel):
    """
    StrongBeamStruct corresponds to bmad `strong_beam_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1990.

    Attributes
    ----------
    dx : float
        Particle - beam slice distance.
        Bmad type: real
        Fortran default: 0
    dy : float
        Particle - beam slice distance.
        Bmad type: real
        Fortran default: 0
    ix_slice : int
        0 -> at element center and not at slice.
        Bmad type: integer
        Fortran default: 0
    x_center : float
        Strong beam slice center.
        Bmad type: real
        Fortran default: 0
    x_sigma : float
        Strong beam slice sigma.
        Bmad type: real
        Fortran default: 0
    y_center : float
        Strong beam slice center.
        Bmad type: real
        Fortran default: 0
    y_sigma : float
        Strong beam slice sigma.
        Bmad type: real
        Fortran default: 0
    """

    dx: float = pydantic.Field(
        default=0,
        description="Particle - beam slice distance.",
    )
    dy: float = pydantic.Field(
        default=0,
        description="Particle - beam slice distance.",
    )
    ix_slice: int = pydantic.Field(
        default=0,
        description="0 -> at element center and not at slice.",
    )
    x_center: float = pydantic.Field(
        default=0,
        description="Strong beam slice center.",
    )
    x_sigma: float = pydantic.Field(
        default=0,
        description="Strong beam slice sigma.",
    )
    y_center: float = pydantic.Field(
        default=0,
        description="Strong beam slice center.",
    )
    y_sigma: float = pydantic.Field(
        default=0,
        description="Strong beam slice sigma.",
    )


class SurfaceCurvatureStruct(pydantic.BaseModel):
    """
    SurfaceCurvatureStruct corresponds to bmad `surface_curvature_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1036.

    Attributes
    ----------
    elliptical : float
        Total curvature = elliptical + spherical
        Bmad type: real
        Fortran default: 0
    has_curvature : bool
        Dependent var. Will be set by Bmad
        Bmad type: logical
        Fortran default: .false.
    spherical : float
        Bmad type: real
        Fortran default: 0
    xy : float
        Bmad type: real
        Fortran default: 0
    """

    elliptical: Sequence[float] = pydantic.Field(
        default=0,
        max_length=3,
        description="Total curvature = elliptical + spherical",
    )
    has_curvature: bool = pydantic.Field(
        default=False,
        description="Dependent var. Will be set by Bmad",
    )
    spherical: float = pydantic.Field(
        default=0,
    )
    xy: Sequence[float] = pydantic.Field(
        default=0,
    )


class SurfaceDisplacementPtStruct(pydantic.BaseModel):
    """
    SurfaceDisplacementPtStruct corresponds to bmad `surface_displacement_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1003.

    Attributes
    ----------
    d2z_dxdy : float
        Bmad type: real
        Fortran default: 0
    dz_dx : float
        Bmad type: real
        Fortran default: 0
    dz_dy : float
        Bmad type: real
        Fortran default: 0
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
    """

    d2z_dxdy: float = pydantic.Field(
        default=0,
    )
    dz_dx: float = pydantic.Field(
        default=0,
    )
    dz_dy: float = pydantic.Field(
        default=0,
    )
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
    pt : SurfaceDisplacementPtStruct
        Bmad type: surface_displacement_pt_struct
    r0 : float
        Bmad type: real
        Fortran default: 0
    """

    active: bool = pydantic.Field(
        default=False,
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    pt: Sequence[SurfaceDisplacementPtStruct] = pydantic.Field(
        default=None,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )


class SurfaceHMisalignPtStruct(pydantic.BaseModel):
    """
    SurfaceHMisalignPtStruct corresponds to bmad `surface_h_misalign_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 990.

    Attributes
    ----------
    rot_t : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    rot_t_rms : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    rot_y : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    rot_y_rms : float
        rot_t = x-rotation for Bragg and z-rotation for Laue.
        Bmad type: real
        Fortran default: 0
    x0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    y0 : float
        Position at center
        Bmad type: real
        Fortran default: 0
    """

    rot_t: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )
    rot_t_rms: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )
    rot_y: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )
    rot_y_rms: float = pydantic.Field(
        default=0,
        description="rot_t = x-rotation for Bragg and z-rotation for Laue.",
    )
    x0: float = pydantic.Field(
        default=0,
        description="Position at center",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Position at center",
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
    pt : SurfaceHMisalignPtStruct
        Bmad type: surface_h_misalign_pt_struct
    r0 : float
        Bmad type: real
        Fortran default: 0
    """

    active: bool = pydantic.Field(
        default=False,
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    pt: Sequence[SurfaceHMisalignPtStruct] = pydantic.Field(
        default=None,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )


class SurfaceSegmentedPtStruct(pydantic.BaseModel):
    """
    SurfaceSegmentedPtStruct corresponds to bmad `surface_segmented_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 977.

    Attributes
    ----------
    dz_dx : float
        Slope at center
        Bmad type: real
        Fortran default: 0
    dz_dy : float
        Slope at center
        Bmad type: real
        Fortran default: 0
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
    """

    dz_dx: float = pydantic.Field(
        default=0,
        description="Slope at center",
    )
    dz_dy: float = pydantic.Field(
        default=0,
        description="Slope at center",
    )
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
    pt : SurfaceSegmentedPtStruct
        Bmad type: surface_segmented_pt_struct
    r0 : float
        Bmad type: real
        Fortran default: 0
    """

    active: bool = pydantic.Field(
        default=False,
    )
    dr: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    pt: Sequence[SurfaceSegmentedPtStruct] = pydantic.Field(
        default=None,
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
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
        Bmad type: taylor_term_struct
        Fortran default: null()
    """

    ref: float = pydantic.Field(
        default=0,
    )
    term: Sequence[TaylorTermStruct] = pydantic.Field(
        default=None,
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


class TrackPointStruct(pydantic.BaseModel):
    """
    TrackPointStruct corresponds to bmad `track_point_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 1997.

    Attributes
    ----------
    field : EmFieldStruct
        An array of em fields indexed from 0 (%field(0:)).
        Bmad type: em_field_struct
    mat6 : float
        1st order part of xfer map (transfer matrix).
        Bmad type: real
    orb : CoordStruct
        An array of track points indexed from 0 (%orb(0:)).
        Bmad type: coord_struct
    s_body : float
        Longitudinal coords within the element body.
        Bmad type: real
    strong_beam : StrongBeamStruct
        Strong beam info for beambeam element.
        Bmad type: strong_beam_struct
    vec0 : float
        0th order part of xfer map from the beginning.
        Bmad type: real
    """

    field: EmFieldStruct = pydantic.Field(
        default=None,
        description="An array of em fields indexed from 0 (%field(0:)).",
    )
    mat6: Sequence[float] = pydantic.Field(
        default=0.0,
        description="1st order part of xfer map (transfer matrix).",
    )
    orb: CoordStruct = pydantic.Field(
        default=None,
        description="An array of track points indexed from 0 (%orb(0:)).",
    )
    s_body: float = pydantic.Field(
        default=0.0,
        description="Longitudinal coords within the element body.",
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


class TrackStruct(pydantic.BaseModel):
    """
    TrackStruct corresponds to bmad `track_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 2008.

    Attributes
    ----------
    ds_save : float
        Min distance between points. Not positive => Save at all points.
        Bmad type: real
        Fortran default: 1d-3
    n_bad : int
        Number of "bad" steps where the step length was shortened.
        Bmad type: integer
        Fortran default: 0
    n_ok : int
        Number of "good" steps where the step length was not shortened.
        Bmad type: integer
        Fortran default: 0
    n_pt : int
        Track upper bound for %pt(0:) array. n_bad and n_ok are used by adaptive
        trackers to record the number of times the step length had to be shortened.
        Bmad type: integer
        Fortran default: -1
    pt : TrackPointStruct
        Array of track points indexed from 0.
        Bmad type: track_point_struct
    """

    ds_save: float = pydantic.Field(
        default=0.001,
        description="Min distance between points. Not positive => Save at all points.",
    )
    n_bad: int = pydantic.Field(
        default=0,
        description="Number of 'bad' steps where the step length was shortened.",
    )
    n_ok: int = pydantic.Field(
        default=0,
        description="Number of 'good' steps where the step length was not shortened.",
    )
    n_pt: int = pydantic.Field(
        default=-1,
        description=(
            "Track upper bound for %pt(0:) array. n_bad and n_ok are used by adaptive "
            "trackers to record the number of times the step length had to be "
            "shortened."
        ),
    )
    pt: Sequence[TrackPointStruct] = pydantic.Field(
        default=None,
        description="Array of track points indexed from 0.",
    )


class TwissStruct(pydantic.BaseModel):
    """
    TwissStruct corresponds to bmad `twiss_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 181.

    Attributes
    ----------
    alpha : float
        Bmad type: real
        Fortran default: 0
    beta : float
        Bmad type: real
        Fortran default: 0
    deta_ds : float
        Bmad type: real
        Fortran default: 0
    emit : float
        Bmad type: real
        Fortran default: 0
    eta : float
        Bmad type: real
        Fortran default: 0
    etap : float
        Bmad type: real
        Fortran default: 0
    gamma : float
        Bmad type: real
        Fortran default: 0
    norm_emit : float
        Bmad type: real
        Fortran default: 0
    phi : float
        Bmad type: real
        Fortran default: 0
    sigma : float
        Bmad type: real
        Fortran default: 0
    sigma_p : float
        Bmad type: real
        Fortran default: 0
    """

    alpha: float = pydantic.Field(
        default=0,
    )
    beta: float = pydantic.Field(
        default=0,
    )
    deta_ds: float = pydantic.Field(
        default=0,
    )
    emit: float = pydantic.Field(
        default=0,
    )
    eta: float = pydantic.Field(
        default=0,
    )
    etap: float = pydantic.Field(
        default=0,
    )
    gamma: float = pydantic.Field(
        default=0,
    )
    norm_emit: float = pydantic.Field(
        default=0,
    )
    phi: float = pydantic.Field(
        default=0,
    )
    sigma: float = pydantic.Field(
        default=0,
    )
    sigma_p: float = pydantic.Field(
        default=0,
    )


class WakeLrModeStruct(pydantic.BaseModel):
    """
    WakeLrModeStruct corresponds to bmad `wake_lr_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 636.

    Attributes
    ----------
    q : float
        Used for backwards compatability.
        Bmad type: real
        Fortran default: real_garbage$
    r_over_q : float
        Strength in V/C/m^(2*m_mode).
        Bmad type: real
        Fortran default: 0
    a_cos : float
        skew cos-like component of the wake.
        Bmad type: real
        Fortran default: 0
    a_sin : float
        skew sin-like component of the wake.
        Bmad type: real
        Fortran default: 0
    angle : float
        polarization angle (radians/2pi).
        Bmad type: real
        Fortran default: 0
    b_cos : float
        non-skew cos-like component of the wake.
        Bmad type: real
        Fortran default: 0
    b_sin : float
        non-skew sin-like component of the wake.
        Bmad type: real
        Fortran default: 0
    damp : float
        Damping factor = omega / 2 * Q = pi * freq / Q
        Bmad type: real
        Fortran default: 0
    freq : float
        Actual Frequency in Hz.
        Bmad type: real
        Fortran default: 0
    freq_in : float
        Input frequency in Hz.
        Bmad type: real
        Fortran default: 0
    m : int
        Mode order (1 = dipole, 2 = quad, etc.)
        Bmad type: integer
        Fortran default: 0
    phi : float
        Phase in radians/2pi.
        Bmad type: real
        Fortran default: 0
    polarized : bool
        Polaraized mode?
        Bmad type: logical
        Fortran default: .false.
    """

    q: float = pydantic.Field(
        default=0.0,
        description="Used for backwards compatability.",
        validation_alias=pydantic.AliasChoices("q", "Q"),
        serialization_alias="Q",
    )
    r_over_q: float = pydantic.Field(
        default=0,
        description="Strength in V/C/m^(2*m_mode).",
        validation_alias=pydantic.AliasChoices("r_over_q", "R_over_Q"),
        serialization_alias="R_over_Q",
    )
    a_cos: float = pydantic.Field(
        default=0,
        description="skew cos-like component of the wake.",
    )
    a_sin: float = pydantic.Field(
        default=0,
        description="skew sin-like component of the wake.",
    )
    angle: float = pydantic.Field(
        default=0,
        description="polarization angle (radians/2pi).",
    )
    b_cos: float = pydantic.Field(
        default=0,
        description="non-skew cos-like component of the wake.",
    )
    b_sin: float = pydantic.Field(
        default=0,
        description="non-skew sin-like component of the wake.",
    )
    damp: float = pydantic.Field(
        default=0,
        description="Damping factor = omega / 2 * Q = pi * freq / Q",
    )
    freq: float = pydantic.Field(
        default=0,
        description="Actual Frequency in Hz.",
    )
    freq_in: float = pydantic.Field(
        default=0,
        description="Input frequency in Hz.",
    )
    m: int = pydantic.Field(
        default=0,
        description="Mode order (1 = dipole, 2 = quad, etc.)",
    )
    phi: float = pydantic.Field(
        default=0,
        description="Phase in radians/2pi.",
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
    amp_scale : float
        Wake amplitude scale factor.
        Bmad type: real
        Fortran default: 1
    file : str
        Bmad type: character
        Fortran default: ''
    freq_spread : float
        Random frequency spread of long range modes.
        Bmad type: real
        Fortran default: 0
    mode : WakeLrModeStruct
        Bmad type: wake_lr_mode_struct
    self_wake_on : bool
        Long range self-wake used in tracking?
        Bmad type: logical
        Fortran default: .true.
    t_ref : float
        time reference value for computing the wake amplitude. This is used to prevent
        value overflow with long trains.
        Bmad type: real
        Fortran default: 0
    time_scale : float
        time scale factor.
        Bmad type: real
        Fortran default: 1
    """

    amp_scale: float = pydantic.Field(
        default=1,
        description="Wake amplitude scale factor.",
    )
    file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    freq_spread: float = pydantic.Field(
        default=0,
        description="Random frequency spread of long range modes.",
    )
    mode: Sequence[WakeLrModeStruct] = pydantic.Field(
        default=None,
    )
    self_wake_on: bool = pydantic.Field(
        default=True,
        description="Long range self-wake used in tracking?",
    )
    t_ref: float = pydantic.Field(
        default=0,
        description=(
            "time reference value for computing the wake amplitude. This is used to "
            "prevent value overflow with long trains."
        ),
    )
    time_scale: float = pydantic.Field(
        default=1,
        description="time scale factor.",
    )


class WakeSrModeStruct(pydantic.BaseModel):
    """
    WakeSrModeStruct corresponds to bmad `wake_sr_mode_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 606.

    Attributes
    ----------
    a_cos : float
        skew (y) cos-like component of the wake
        Bmad type: real
        Fortran default: 0
    a_sin : float
        skew (y) sin-like component of the wake
        Bmad type: real
        Fortran default: 0
    amp : float
        Amplitude
        Bmad type: real
        Fortran default: 0
    b_cos : float
        non-skew (x) cos-like component of the wake
        Bmad type: real
        Fortran default: 0
    b_sin : float
        non-skew (x) sin-like component of the wake
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
    polarization : int
        Transverse: none$, x_axis$, y_axis$. Not used for longitudinal.
        Bmad type: integer
        Fortran default: none$
    position_dependence : int
        Transverse: leading$, trailing$, none$ Longitudinal: x_leading$, ...,
        y_trailing$, none$
        Bmad type: integer
        Fortran default: not_set$
    """

    a_cos: float = pydantic.Field(
        default=0,
        description="skew (y) cos-like component of the wake",
    )
    a_sin: float = pydantic.Field(
        default=0,
        description="skew (y) sin-like component of the wake",
    )
    amp: float = pydantic.Field(
        default=0,
        description="Amplitude",
    )
    b_cos: float = pydantic.Field(
        default=0,
        description="non-skew (x) cos-like component of the wake",
    )
    b_sin: float = pydantic.Field(
        default=0,
        description="non-skew (x) sin-like component of the wake",
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
    polarization: int = pydantic.Field(
        default=0,
        description="Transverse: none$, x_axis$, y_axis$. Not used for longitudinal.",
    )
    position_dependence: int = pydantic.Field(
        default=0,
        description=(
            "Transverse: leading$, trailing$, none$ Longitudinal: x_leading$, ..., "
            "y_trailing$, none$"
        ),
    )


class WakeSrStruct(pydantic.BaseModel):
    """
    WakeSrStruct corresponds to bmad `wake_sr_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 620.

    Attributes
    ----------
    amp_scale : float
        Wake amplitude scale factor.
        Bmad type: real
        Fortran default: 1
    file : str
        Bmad type: character
        Fortran default: ''
    long : WakeSrModeStruct
        Bmad type: wake_sr_mode_struct
    scale_with_length : bool
        Scale wake with element length?
        Bmad type: logical
        Fortran default: .true.
    trans : WakeSrModeStruct
        Bmad type: wake_sr_mode_struct
    z_long : WakeSrZLongStruct
        Bmad type: wake_sr_z_long_struct
    z_max : float
        Max allowable z value. 0-> ignore
        Bmad type: real
        Fortran default: 0
    z_ref_long : float
        z reference value for computing the wake amplitude.
        Bmad type: real
        Fortran default: 0
    z_ref_trans : float
        This is used to prevent value overflow with long bunches.
        Bmad type: real
        Fortran default: 0
    z_scale : float
        z-distance scale factor.
        Bmad type: real
        Fortran default: 1
    """

    amp_scale: float = pydantic.Field(
        default=1,
        description="Wake amplitude scale factor.",
    )
    file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    long: Sequence[WakeSrModeStruct] = pydantic.Field(
        default=None,
    )
    scale_with_length: bool = pydantic.Field(
        default=True,
        description="Scale wake with element length?",
    )
    trans: Sequence[WakeSrModeStruct] = pydantic.Field(
        default=None,
    )
    z_long: WakeSrZLongStruct = pydantic.Field(
        default=None,
    )
    z_max: float = pydantic.Field(
        default=0,
        description="Max allowable z value. 0-> ignore",
    )
    z_ref_long: float = pydantic.Field(
        default=0,
        description="z reference value for computing the wake amplitude.",
    )
    z_ref_trans: float = pydantic.Field(
        default=0,
        description="This is used to prevent value overflow with long bunches.",
    )
    z_scale: float = pydantic.Field(
        default=1,
        description="z-distance scale factor.",
    )


class WakeSrZLongStruct(pydantic.BaseModel):
    """
    WakeSrZLongStruct corresponds to bmad `wake_sr_z_long_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 594.

    Attributes
    ----------
    dz : float
        Distance between points. If zero there is no wake.
        Bmad type: real
        Fortran default: 0
    fbunch : Complex
        Scratch space.
        Bmad type: complex
    fw : Complex
        Fourier transform of w.
        Bmad type: complex
    position_dependence : int
        Transverse: leading$, trailing$, none$ Longitudinal: x_leading$, ...,
        y_trailing$, none$
        Bmad type: integer
        Fortran default: none$
    smoothing_sigma : float
        0 => No smoothing.
        Bmad type: real
        Fortran default: 0
    time_based : bool
        Was input time based?
        Bmad type: logical
        Fortran default: .false.
    w : float
        Input single particle Wake. Indexed from 1.
        Bmad type: real
    w_out : Complex
        Scratch space.
        Bmad type: complex
    z0 : float
        Wake extent is [-z0, z0].
        Bmad type: real
        Fortran default: 0
    """

    dz: float = pydantic.Field(
        default=0,
        description="Distance between points. If zero there is no wake.",
    )
    fbunch: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Scratch space.",
    )
    fw: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Fourier transform of w.",
    )
    position_dependence: int = pydantic.Field(
        default=0,
        description=(
            "Transverse: leading$, trailing$, none$ Longitudinal: x_leading$, ..., "
            "y_trailing$, none$"
        ),
    )
    smoothing_sigma: float = pydantic.Field(
        default=0,
        description="0 => No smoothing.",
    )
    time_based: bool = pydantic.Field(
        default=False,
        description="Was input time based?",
    )
    w: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Input single particle Wake. Indexed from 1.",
    )
    w_out: Sequence[Complex] = pydantic.Field(
        default=0.0,
        description="Scratch space.",
    )
    z0: float = pydantic.Field(
        default=0,
        description="Wake extent is [-z0, z0].",
    )


class WakeStruct(pydantic.BaseModel):
    """
    WakeStruct corresponds to bmad `wake_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 665.

    Attributes
    ----------
    lr : WakeLrStruct
        Long-range wake
        Bmad type: wake_lr_struct
        Fortran default: wake_lr_struct('', null(), 0.0_rp, 0.0_rp, 1.0_rp, 1.0_rp, .true.)
    sr : WakeSrStruct
        Short-range wake
        Bmad type: wake_sr_struct
        Fortran default: wake_sr_struct('', wake_sr_z_long_struct(), null(), null(), 0.0_rp, 0.0_rp, 0.0_rp, 1.0_rp, 1.0_rp, .true.)
    """

    lr: WakeLrStruct = pydantic.Field(
        default=None,
        description="Long-range wake",
    )
    sr: WakeSrStruct = pydantic.Field(
        default=None,
        description="Short-range wake",
    )


class Wall3dSectionStruct(pydantic.BaseModel):
    """
    Wall3dSectionStruct corresponds to bmad `wall3d_section_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 417.

    Attributes
    ----------
    dr_ds : float
        derivative of wall radius
        Bmad type: real
        Fortran default: real_garbage$
    dx0_ds : float
        Center of wall derivative
        Bmad type: real
        Fortran default: 0
    dy0_ds : float
        Center of wall derivative
        Bmad type: real
        Fortran default: 0
    ix_branch : int
        Index of branch lattice element is in.
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        index of lattice element containing section
        Bmad type: integer
        Fortran default: 0
    material : str
        Material.
        Bmad type: character
        Fortran default: ''
    n_vertex_input : int
        Number of vertices specified by the user.
        Bmad type: integer
        Fortran default: 0
    name : str
        Identifying name
        Bmad type: character
        Fortran default: ''
    p1_coef : float
        Spline coefs for p0 function
        Bmad type: real
        Fortran default: 0
    p2_coef : float
        Spline coefs for p1 function
        Bmad type: real
        Fortran default: 0
    patch_in_region : bool
        Patch element exists between this section and previous one?
        Bmad type: logical
        Fortran default: .false.
    r0 : float
        Center of section Section-to-section spline interpolation of the center of the
        section
        Bmad type: real
        Fortran default: 0
    s : float
        Longitudinal position
        Bmad type: real
        Fortran default: 0
    surface : PhotonReflectSurfaceStruct
        Surface reflectivity tables.
        Bmad type: photon_reflect_surface_struct
        Fortran default: null()
    thickness : float
        Material thickness.
        Bmad type: real
        Fortran default: -1
    type : int
        normal$, clear$, opaque$, wall_start$, wall_end$
        Bmad type: integer
        Fortran default: normal$
    v : Wall3dVertexStruct
        Array of vertices. Always stored relative.
        Bmad type: wall3d_vertex_struct
    vertices_state : int
        absolute$, or shifted_to_relative$. If set to absolute$ on input, will be
        changed to shifted_to_relative$ by section initalizer.
        Bmad type: integer
        Fortran default: relative$
    x0_coef : float
        Spline coefs for x-center
        Bmad type: real
        Fortran default: 0
    y0_coef : float
        Spline coefs for y-center Section-to_section spline interpolation of the wall.
        Bmad type: real
        Fortran default: 0
    """

    dr_ds: float = pydantic.Field(
        default=0.0,
        description="derivative of wall radius",
    )
    dx0_ds: float = pydantic.Field(
        default=0,
        description="Center of wall derivative",
    )
    dy0_ds: float = pydantic.Field(
        default=0,
        description="Center of wall derivative",
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description="Index of branch lattice element is in.",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="index of lattice element containing section",
    )
    material: str = pydantic.Field(
        default="",
        max_length=20,
        description="Material.",
    )
    n_vertex_input: int = pydantic.Field(
        default=0,
        description="Number of vertices specified by the user.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Identifying name",
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
    patch_in_region: bool = pydantic.Field(
        default=False,
        description="Patch element exists between this section and previous one?",
    )
    r0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description=(
            "Center of section Section-to-section spline interpolation of the center of "
            "the section"
        ),
    )
    s: float = pydantic.Field(
        default=0,
        description="Longitudinal position",
    )
    surface: PhotonReflectSurfaceStruct = pydantic.Field(
        default=None,
        description="Surface reflectivity tables.",
    )
    thickness: float = pydantic.Field(
        default=-1,
        description="Material thickness.",
    )
    type: int = pydantic.Field(
        default=0,
        description="normal$, clear$, opaque$, wall_start$, wall_end$",
    )
    v: Sequence[Wall3dVertexStruct] = pydantic.Field(
        default=None,
        description="Array of vertices. Always stored relative.",
    )
    vertices_state: int = pydantic.Field(
        default=0,
        description=(
            "absolute$, or shifted_to_relative$. If set to absolute$ on input, will be "
            "changed to shifted_to_relative$ by section initalizer."
        ),
    )
    x0_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Spline coefs for x-center",
    )
    y0_coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Spline coefs for y-center Section-to_section spline interpolation of the wall.",
    )


class Wall3dStruct(pydantic.BaseModel):
    """
    Wall3dStruct corresponds to bmad `wall3d_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 449.

    Attributes
    ----------
    clear_material : str
        Bmad type: character
        Fortran default: ''
    ele_anchor_pt : int
        anchor_beginning$, anchor_center$, or anchor_end$
        Bmad type: integer
        Fortran default: anchor_beginning$
    ix_wall3d : int
        Index in branch%wall3d(:) array.
        Bmad type: integer
        Fortran default: 0
    n_link : int
        For memory management of ele%wall3d
        Bmad type: integer
        Fortran default: 1
    name : str
        Bmad type: character
        Fortran default: ''
    opaque_material : str
        Bmad type: character
        Fortran default: ''
    section : Wall3dSectionStruct
        Indexed from 1.
        Bmad type: wall3d_section_struct
    superimpose : bool
        Can overlap another wall
        Bmad type: logical
        Fortran default: .false.
    thickness : float
        For diffraction_plate elements
        Bmad type: real
        Fortran default: -1
    type : int
        or mask_plate$
        Bmad type: integer
        Fortran default: chamber_wall$
    """

    clear_material: str = pydantic.Field(
        default="",
        max_length=20,
    )
    ele_anchor_pt: int = pydantic.Field(
        default=0,
        description="anchor_beginning$, anchor_center$, or anchor_end$",
    )
    ix_wall3d: int = pydantic.Field(
        default=0,
        description="Index in branch%wall3d(:) array.",
    )
    n_link: int = pydantic.Field(
        default=1,
        description="For memory management of ele%wall3d",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    opaque_material: str = pydantic.Field(
        default="",
        max_length=20,
    )
    section: Sequence[Wall3dSectionStruct] = pydantic.Field(
        default=None,
        description="Indexed from 1.",
    )
    superimpose: bool = pydantic.Field(
        default=False,
        description="Can overlap another wall",
    )
    thickness: float = pydantic.Field(
        default=-1,
        description="For diffraction_plate elements",
    )
    type: int = pydantic.Field(
        default=0,
        description="or mask_plate$",
    )


class Wall3dVertexStruct(pydantic.BaseModel):
    """
    Wall3dVertexStruct corresponds to bmad `wall3d_vertex_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 401.

    Attributes
    ----------
    angle : float
        Angle of (x, y) point.
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
    type : int
        No longer used.
        Bmad type: integer
        Fortran default: normal$
    x : float
        Coordinates of the vertex.
        Bmad type: real
        Fortran default: 0
    x0 : float
        Center of ellipse
        Bmad type: real
        Fortran default: 0
    y : float
        Coordinates of the vertex.
        Bmad type: real
        Fortran default: 0
    y0 : float
        Center of ellipse
        Bmad type: real
        Fortran default: 0
    """

    angle: float = pydantic.Field(
        default=0,
        description="Angle of (x, y) point.",
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
    type: int = pydantic.Field(
        default=0,
        description="No longer used.",
    )
    x: float = pydantic.Field(
        default=0,
        description="Coordinates of the vertex.",
    )
    x0: float = pydantic.Field(
        default=0,
        description="Center of ellipse",
    )
    y: float = pydantic.Field(
        default=0,
        description="Coordinates of the vertex.",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Center of ellipse",
    )


class XyDispStruct(pydantic.BaseModel):
    """
    XyDispStruct corresponds to bmad `xy_disp_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/bmad_struct.f90 on line 846.

    Attributes
    ----------
    deta_ds : float
        Bmad type: real
        Fortran default: 0
    eta : float
        Bmad type: real
        Fortran default: 0
    etap : float
        Bmad type: real
        Fortran default: 0
    sigma : float
        Bmad type: real
        Fortran default: 0
    """

    deta_ds: float = pydantic.Field(
        default=0,
    )
    eta: float = pydantic.Field(
        default=0,
    )
    etap: float = pydantic.Field(
        default=0,
    )
    sigma: float = pydantic.Field(
        default=0,
    )


class WigglerModelingCommonStruct(pydantic.BaseModel):
    """
    WigglerModelingCommonStruct corresponds to bmad `wiggler_modeling_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/element_modeling_mod.f90 on line 18.

    Attributes
    ----------
    drift_len_min : float
        Bmad type: real
        Fortran default: .01
    drift_len_wgt : float
        Bmad type: real
        Fortran default: 1d5
    g_step : float
        Step size for calculating derivatives
        Bmad type: real
        Fortran default: 1d-8
    integral_g2_wgt : float
        Bmad type: real
        Fortran default: 1d4
    integral_g3_wgt : float
        Bmad type: real
        Fortran default: 1d4
    integration_ds : float
        meters
        Bmad type: real
        Fortran default: 0.001
    k_step : float
        Step size for calculating derivatives
        Bmad type: real
        Fortran default: 1d-7
    len_d_end : float
        Bmad type: real
    len_d_end2 : float
        Bmad type: real
    len_drifts : float
        Bmad type: real
    len_step : float
        Step size for calculating derivatives
        Bmad type: real
        Fortran default: 1d-6
    mat6_wgt : float
        Bmad type: real
        Fortran default: 1d6
    print_results : bool
        Bmad type: logical
        Fortran default: .false.
    x_wgt : float
        Bmad type: real
        Fortran default: 1d10
    """

    drift_len_min: float = pydantic.Field(
        default=0.01,
    )
    drift_len_wgt: float = pydantic.Field(
        default=100000.0,
    )
    g_step: float = pydantic.Field(
        default=1e-08,
        description="Step size for calculating derivatives",
    )
    integral_g2_wgt: float = pydantic.Field(
        default=10000.0,
    )
    integral_g3_wgt: float = pydantic.Field(
        default=10000.0,
    )
    integration_ds: float = pydantic.Field(
        default=0.001,
        description="meters",
    )
    k_step: float = pydantic.Field(
        default=1e-07,
        description="Step size for calculating derivatives",
    )
    len_d_end: float = pydantic.Field(
        default=0.0,
    )
    len_d_end2: float = pydantic.Field(
        default=0.0,
    )
    len_drifts: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    len_step: float = pydantic.Field(
        default=1e-06,
        description="Step size for calculating derivatives",
    )
    mat6_wgt: float = pydantic.Field(
        default=1000000.0,
    )
    print_results: bool = pydantic.Field(
        default=False,
    )
    x_wgt: float = pydantic.Field(
        default=10000000000.0,
    )


class ExpressionFuncStruct(pydantic.BaseModel):
    """
    ExpressionFuncStruct corresponds to bmad `expression_func_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/expression_mod.f90 on line 41.

    Attributes
    ----------
    n_arg_count : int
        Number of arguments found.
        Bmad type: integer
        Fortran default: 0
    n_arg_target : int
        Number of arguments the function should have. -1 => 0 or 1 arg
        Bmad type: integer
        Fortran default: 0
    name : str
        Name of function
        Bmad type: character
        Fortran default: ''
    """

    n_arg_count: int = pydantic.Field(
        default=0,
        description="Number of arguments found.",
    )
    n_arg_target: int = pydantic.Field(
        default=0,
        description="Number of arguments the function should have. -1 => 0 or 1 arg",
    )
    name: str = pydantic.Field(
        default="",
        max_length=12,
        description="Name of function",
    )


class MadEnergyStruct(pydantic.BaseModel):
    """
    MadEnergyStruct corresponds to bmad `mad_energy_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/mad_mod.f90 on line 14.

    Attributes
    ----------
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
    total : float
        Bmad type: real
    """

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
    total: float = pydantic.Field(
        default=0.0,
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


class Mat2Struct(pydantic.BaseModel):
    """
    Mat2Struct corresponds to bmad `mat2_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/mode3_mod.f90 on line 1267.

    Attributes
    ----------
    m : float
        Bmad type: real
    """

    m: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class PrivateStashStruct(pydantic.BaseModel):
    """
    PrivateStashStruct corresponds to bmad `private_stash_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_6d_mod.f90 on line 16.

    Attributes
    ----------
    eta_x_coef : float
        Dispersion interpolation coefs.
        Bmad type: real
    eta_y_coef : float
        Dispersion interpolation coefs.
        Bmad type: real
    gamma0 : float
        Relativistic gamma factor.
        Bmad type: real
    """

    eta_x_coef: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Dispersion interpolation coefs.",
    )
    eta_y_coef: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Dispersion interpolation coefs.",
    )
    gamma0: float = pydantic.Field(
        default=0.0,
        description="Relativistic gamma factor.",
    )


class QrombIntStruct_(pydantic.BaseModel):
    """
    QrombIntStruct_ corresponds to bmad `qromb_int_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_6d_mod.f90 on line 743.

    Attributes
    ----------
    h : float
        Bmad type: real
        Fortran default: 0
    int_g : float
        Bmad type: real
        Fortran default: 0
    int_g2 : float
        Bmad type: real
        Fortran default: 0
    int_g3 : float
        Bmad type: real
        Fortran default: 0
    """

    h: float = pydantic.Field(
        default=0,
    )
    int_g: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    int_g2: float = pydantic.Field(
        default=0,
    )
    int_g3: float = pydantic.Field(
        default=0,
    )


class RadIntCache1Struct(pydantic.BaseModel):
    """
    RadIntCache1Struct corresponds to bmad `rad_int_cache1_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 28.

    Attributes
    ----------
    cache_type : int
        Bmad type: integer
        Fortran default: no_cache$
    n_pt : int
        Upper bound of pt(0:n_pt)
        Bmad type: integer
        Fortran default: -1
    pt : RadIntTrackPointStruct
        pt(0:n_pt)
        Bmad type: rad_int_track_point_struct
    """

    cache_type: int = pydantic.Field(
        default=0,
    )
    n_pt: int = pydantic.Field(
        default=-1,
        description="Upper bound of pt(0:n_pt)",
    )
    pt: Sequence[RadIntTrackPointStruct] = pydantic.Field(
        default=None,
        description="pt(0:n_pt)",
    )


class RadIntCacheStruct(pydantic.BaseModel):
    """
    RadIntCacheStruct corresponds to bmad `rad_int_cache_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 34.

    Attributes
    ----------
    c_ele : RadIntCache1Struct
        Bmad type: rad_int_cache1_struct
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
    a : TwissStruct
        Bmad type: twiss_struct
    b : TwissStruct
        Bmad type: twiss_struct
    branch : BranchStruct
        Bmad type: branch_struct
    cache_ele : RadIntCache1Struct
        pointer to cache in use
        Bmad type: rad_int_cache1_struct
    dg2_x : float
        Bmad type: real
    dg2_y : float
        Bmad type: real
    ele : EleStruct
        Bmad type: ele_struct
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
    orbit : CoordStruct
        Bmad type: coord_struct
    """

    a: TwissStruct = pydantic.Field(
        default=None,
    )
    b: TwissStruct = pydantic.Field(
        default=None,
    )
    branch: BranchStruct = pydantic.Field(
        default=None,
    )
    cache_ele: RadIntCache1Struct = pydantic.Field(
        default=None,
        description="pointer to cache in use",
    )
    dg2_x: float = pydantic.Field(
        default=0.0,
    )
    dg2_y: float = pydantic.Field(
        default=0.0,
    )
    ele: EleStruct = pydantic.Field(
        default=None,
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
    orbit: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )


class RadIntTrackPointStruct(pydantic.BaseModel):
    """
    RadIntTrackPointStruct corresponds to bmad `rad_int_track_point_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 15.

    Attributes
    ----------
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
    g_x0 : float
        Additional g factors for bends.
        Bmad type: real
        Fortran default: 0
    g_y0 : float
        Additional g factors for bends.
        Bmad type: real
        Fortran default: 0
    mat6 : float
        Bmad type: real
        Fortran default: 0
    ref_orb_in : CoordStruct
        Bmad type: coord_struct
        Fortran default: coord_struct()
    ref_orb_out : CoordStruct
        Bmad type: coord_struct
        Fortran default: coord_struct()
    s_body : float
        Bmad type: real
        Fortran default: 0
    vec0 : float
        Bmad type: real
        Fortran default: 0
    """

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
    g_x0: float = pydantic.Field(
        default=0,
        description="Additional g factors for bends.",
    )
    g_y0: float = pydantic.Field(
        default=0,
        description="Additional g factors for bends.",
    )
    mat6: Sequence[float] = pydantic.Field(
        default=0,
    )
    ref_orb_in: CoordStruct = pydantic.Field(
        default=None,
    )
    ref_orb_out: CoordStruct = pydantic.Field(
        default=None,
    )
    s_body: float = pydantic.Field(
        default=0,
    )
    vec0: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
    )


class RiArrayStruct(pydantic.BaseModel):
    """
    RiArrayStruct corresponds to bmad `ri_array_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/rad_int_common.f90 on line 86.

    Attributes
    ----------
    h : float
        Bmad type: real
    sum : float
        Bmad type: real
    """

    h: float = pydantic.Field(
        default=0.0,
    )
    sum: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class RungeKuttaCommonStruct(pydantic.BaseModel):
    """
    RungeKuttaCommonStruct corresponds to bmad `runge_kutta_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/runge_kutta_mod.f90 on line 5.

    Attributes
    ----------
    calc_field_derivatives : bool
        Experimental: For use with extensions to the spin BMT equation that involve
        field derivatives.
        Bmad type: logical
        Fortran default: .false.
    num_steps_done : int
        Number of integration steps. Not used by Bmad. For external use.
        Bmad type: integer
        Fortran default: -1
    """

    calc_field_derivatives: bool = pydantic.Field(
        default=False,
        description=(
            "Experimental: For use with extensions to the spin BMT equation that "
            "involve field derivatives."
        ),
    )
    num_steps_done: int = pydantic.Field(
        default=-1,
        description="Number of integration steps. Not used by Bmad. For external use.",
    )


class SlicedElesStruct(pydantic.BaseModel):
    """
    SlicedElesStruct corresponds to bmad `sliced_eles_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/srdt_mod.f90 on line 41.

    Attributes
    ----------
    beta_a : float
        Bmad type: real
    beta_b : float
        Bmad type: real
    e2a : Complex
        Bmad type: complex
    e2b : Complex
        Bmad type: complex
    e3a : Complex
        Bmad type: complex
    ea : Complex
        Bmad type: complex
    eb : Complex
        Bmad type: complex
    eta_a : float
        Bmad type: real
    good_k2 : bool
        Bmad type: logical
    ix : int
        Bmad type: integer
    k1l : float
        Bmad type: real
    k2l : float
        Bmad type: real
    L : float
        Bmad type: real
    phi_a : float
        Bmad type: real
    phi_b : float
        Bmad type: real
    s : float
        Bmad type: real
    srdt : SummationRdtStruct
        Bmad type: summation_rdt_struct
    """

    beta_a: float = pydantic.Field(
        default=0.0,
    )
    beta_b: float = pydantic.Field(
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
    ea: Complex = pydantic.Field(
        default=0.0,
    )
    eb: Complex = pydantic.Field(
        default=0.0,
    )
    eta_a: float = pydantic.Field(
        default=0.0,
    )
    good_k2: bool = pydantic.Field(
        default=False,
    )
    ix: int = pydantic.Field(
        default=0,
    )
    k1l: float = pydantic.Field(
        default=0.0,
    )
    k2l: float = pydantic.Field(
        default=0.0,
    )
    L: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("L", "l"),
        serialization_alias="l",
    )
    phi_a: float = pydantic.Field(
        default=0.0,
    )
    phi_b: float = pydantic.Field(
        default=0.0,
    )
    s: float = pydantic.Field(
        default=0.0,
    )
    srdt: SummationRdtStruct = pydantic.Field(
        default=None,
    )


class SummationRdtStruct(pydantic.BaseModel):
    """
    SummationRdtStruct corresponds to bmad `summation_rdt_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/srdt_mod.f90 on line 11.

    Attributes
    ----------
    h00111 : Complex
        Bmad type: complex
    h00201 : Complex
        Bmad type: complex
    h00220 : Complex
        Bmad type: complex
    h00310 : Complex
        Bmad type: complex
    h00400 : Complex
        Bmad type: complex
    h10002 : Complex
        Bmad type: complex
    h10020 : Complex
        Bmad type: complex
    h10110 : Complex
        Bmad type: complex
    h10200 : Complex
        2nd order in K2 moments
        Bmad type: complex
    h11001 : Complex
        Bmad type: complex
    h11110 : Complex
        Bmad type: complex
    h11200 : Complex
        Bmad type: complex
    h20001 : Complex
        Bmad type: complex
    h20020 : Complex
        Bmad type: complex
    h20110 : Complex
        Bmad type: complex
    h20200 : Complex
        Bmad type: complex
    h21000 : Complex
        Bmad type: complex
    h22000 : Complex
        Bmad type: complex
    h30000 : Complex
        Bmad type: complex
    h31000 : Complex
        Bmad type: complex
    h40000 : Complex
        Bmad type: complex
    """

    h00111: Complex = pydantic.Field(
        default=0.0,
    )
    h00201: Complex = pydantic.Field(
        default=0.0,
    )
    h00220: Complex = pydantic.Field(
        default=0.0,
    )
    h00310: Complex = pydantic.Field(
        default=0.0,
    )
    h00400: Complex = pydantic.Field(
        default=0.0,
    )
    h10002: Complex = pydantic.Field(
        default=0.0,
    )
    h10020: Complex = pydantic.Field(
        default=0.0,
    )
    h10110: Complex = pydantic.Field(
        default=0.0,
    )
    h10200: Complex = pydantic.Field(
        default=0.0,
        description="2nd order in K2 moments",
    )
    h11001: Complex = pydantic.Field(
        default=0.0,
    )
    h11110: Complex = pydantic.Field(
        default=0.0,
    )
    h11200: Complex = pydantic.Field(
        default=0.0,
    )
    h20001: Complex = pydantic.Field(
        default=0.0,
    )
    h20020: Complex = pydantic.Field(
        default=0.0,
    )
    h20110: Complex = pydantic.Field(
        default=0.0,
    )
    h20200: Complex = pydantic.Field(
        default=0.0,
    )
    h21000: Complex = pydantic.Field(
        default=0.0,
    )
    h22000: Complex = pydantic.Field(
        default=0.0,
    )
    h30000: Complex = pydantic.Field(
        default=0.0,
    )
    h31000: Complex = pydantic.Field(
        default=0.0,
    )
    h40000: Complex = pydantic.Field(
        default=0.0,
    )


class SectionPtrStruct(pydantic.BaseModel):
    """
    SectionPtrStruct corresponds to bmad `section_ptr_struct`
    which is in Users/klauer/Repos/bmad/bmad/modules/wall3d_mod.f90 on line 1206.

    Attributes
    ----------
    ele : EleStruct
        Bmad type: ele_struct
    s : float
        Bmad type: real
    sec : Wall3dSectionStruct
        Bmad type: wall3d_section_struct
    """

    ele: EleStruct = pydantic.Field(
        default=None,
    )
    s: float = pydantic.Field(
        default=0.0,
    )
    sec: Wall3dSectionStruct = pydantic.Field(
        default=None,
    )


class IbsLifetimeStruct(pydantic.BaseModel):
    """
    IbsLifetimeStruct corresponds to bmad `ibs_lifetime_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/ibs_mod.f90 on line 23.

    Attributes
    ----------
    tlp : float
        Bmad type: real
    tlx : float
        Bmad type: real
    tly : float
        Bmad type: real
    """

    tlp: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("tlp", "Tlp"),
        serialization_alias="Tlp",
    )
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


class IbsMaxratioStruct(pydantic.BaseModel):
    """
    IbsMaxratioStruct corresponds to bmad `ibs_maxratio_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/ibs_mod.f90 on line 30.

    Attributes
    ----------
    r_p : float
        Bmad type: real
    rx : float
        Bmad type: real
    ry : float
        Bmad type: real
    """

    r_p: float = pydantic.Field(
        default=0.0,
    )
    rx: float = pydantic.Field(
        default=0.0,
    )
    ry: float = pydantic.Field(
        default=0.0,
    )


class IbsSimParamStruct(pydantic.BaseModel):
    """
    IbsSimParamStruct corresponds to bmad `ibs_sim_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/multiparticle/ibs_mod.f90 on line 10.

    Attributes
    ----------
    clog_to_use : int
        see multi_coulomb_log subroutine for valid settings.  Set to 1 to disable tail-
        cut.  Set to 1 for linacs.
        Bmad type: integer
        Fortran default: 1
    do_pwd : bool
        If true, then use potential well distortion to calculate bunch lengths.  If
        false, bunch length is proportional to energy spread.
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
    formula : str
        Which IBS formulation to use.  See subroutine ibs1 for a list. real(rp) ::
        fake_3HC = -1   ! If greater than zero, divide growth rates by this factor.
        Bmad type: character
        Fortran default: 'bjmt'
    inductance : float
        Inductive part of impedance for pwd calc.
        Bmad type: real
        Fortran default: 0.0d0
    set_dispersion : bool
        True: add vertical dispersion to transfer matrix.  Valid for kubo method.
        Bmad type: logical
        Fortran default: .false.
    tau_a : float
        horizontal damping rate (needed for coulomb log tail cut)
        Bmad type: real
        Fortran default: 0.0d0
    """

    clog_to_use: int = pydantic.Field(
        default=1,
        description=(
            "see multi_coulomb_log subroutine for valid settings.  Set to 1 to disable "
            "tail-cut.  Set to 1 for linacs."
        ),
    )
    do_pwd: bool = pydantic.Field(
        default=False,
        description=(
            "If true, then use potential well distortion to calculate bunch lengths. "
            "If false, bunch length is proportional to energy spread."
        ),
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
    formula: str = pydantic.Field(
        default="bjmt",
        max_length=4,
        description=(
            "Which IBS formulation to use.  See subroutine ibs1 for a list. real(rp) :: "
            "fake_3HC = -1   ! If greater than zero, divide growth rates by this "
            "factor."
        ),
    )
    inductance: float = pydantic.Field(
        default=0.0,
        description="Inductive part of impedance for pwd calc.",
    )
    set_dispersion: bool = pydantic.Field(
        default=False,
        description="True: add vertical dispersion to transfer matrix.  Valid for kubo method.",
    )
    tau_a: float = pydantic.Field(
        default=0.0,
        description="horizontal damping rate (needed for coulomb log tail cut)",
    )


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
    neg : float
        Bmad type: REAL
    pos : float
        Bmad type: REAL
    s : float
        Bmad type: REAL
    """

    neg: float = pydantic.Field(
        default=0.0,
    )
    pos: float = pydantic.Field(
        default=0.0,
    )
    s: float = pydantic.Field(
        default=0.0,
    )


class MultipassRegionBranchStruct(pydantic.BaseModel):
    """
    MultipassRegionBranchStruct corresponds to bmad `multipass_region_branch_struct`
    which is in Users/klauer/Repos/bmad/bmad/output/write_lattice_file_mod.f90 on line 12.

    Attributes
    ----------
    ele : MultipassRegionEleStruct
        Bmad type: multipass_region_ele_struct
    """

    ele: Sequence[MultipassRegionEleStruct] = pydantic.Field(
        default=None,
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


class MultipassRegionLatStruct(pydantic.BaseModel):
    """
    MultipassRegionLatStruct corresponds to bmad `multipass_region_lat_struct`
    which is in Users/klauer/Repos/bmad/bmad/output/write_lattice_file_mod.f90 on line 16.

    Attributes
    ----------
    branch : MultipassRegionBranchStruct
        Bmad type: multipass_region_branch_struct
    """

    branch: Sequence[MultipassRegionBranchStruct] = pydantic.Field(
        default=None,
    )


class GridPtStruct(pydantic.BaseModel):
    """
    GridPtStruct corresponds to bmad `grid_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_mod.f90 on line 6551.

    Attributes
    ----------
    field : Complex
        Bmad type: complex
        Fortran default: 0
    ix : int
        Bmad type: integer
        Fortran default: [1, 1, 1]
    """

    field: Sequence[Complex] = pydantic.Field(
        default=0,
        max_length=6,
    )
    ix: Sequence[int] = pydantic.Field(
        default=[1, 1, 1],
        max_length=3,
    )


class LrWakeInputStruct(pydantic.BaseModel):
    """
    LrWakeInputStruct corresponds to bmad `lr_wake_input_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_mod.f90 on line 1760.

    Attributes
    ----------
    q : float
        Quality factor.
        Bmad type: real
        Fortran default: 0
    r_over_q : float
        Strength in V/C/m^(2*m_mode).
        Bmad type: real
        Fortran default: 0
    a_cos : float
        Bmad type: real
        Fortran default: 0
    a_sin : float
        Bmad type: real
        Fortran default: 0
    angle : str
        polarization angle (radians/2pi).
        Bmad type: character
        Fortran default: ''
    b_cos : float
        Bmad type: real
        Fortran default: 0
    b_sin : float
        Bmad type: real
        Fortran default: 0
    freq : float
        Actual Frequency in Hz.
        Bmad type: real
        Fortran default: real_garbage$
    m : int
        Mode order (1 = dipole, 2 = quad, etc.)
        Bmad type: integer
        Fortran default: 0
    t_ref : float
        Bmad type: real
        Fortran default: 0
    """

    q: float = pydantic.Field(
        default=0,
        description="Quality factor.",
        validation_alias=pydantic.AliasChoices("q", "Q"),
        serialization_alias="Q",
    )
    r_over_q: float = pydantic.Field(
        default=0,
        description="Strength in V/C/m^(2*m_mode).",
        validation_alias=pydantic.AliasChoices("r_over_q", "R_over_Q"),
        serialization_alias="R_over_Q",
    )
    a_cos: float = pydantic.Field(
        default=0,
    )
    a_sin: float = pydantic.Field(
        default=0,
    )
    angle: str = pydantic.Field(
        default="",
        max_length=16,
        description="polarization angle (radians/2pi).",
    )
    b_cos: float = pydantic.Field(
        default=0,
    )
    b_sin: float = pydantic.Field(
        default=0,
    )
    freq: float = pydantic.Field(
        default=0.0,
        description="Actual Frequency in Hz.",
    )
    m: int = pydantic.Field(
        default=0,
        description="Mode order (1 = dipole, 2 = quad, etc.)",
    )
    t_ref: float = pydantic.Field(
        default=0,
    )


class MultiElePointerStruct(pydantic.BaseModel):
    """
    MultiElePointerStruct corresponds to bmad `multi_ele_pointer_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_mod.f90 on line 4276.

    Attributes
    ----------
    eles : ElePointerStruct
        Bmad type: ele_pointer_struct
    n_loc : int
        Bmad type: integer
    """

    eles: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
    )
    n_loc: int = pydantic.Field(
        default=0,
    )


class MyKnotStruct(pydantic.BaseModel):
    """
    MyKnotStruct corresponds to bmad `my_knot_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_mod.f90 on line 2264.

    Attributes
    ----------
    y : float
        Bmad type: real
    """

    y: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class BaseLineEleStruct(pydantic.BaseModel):
    """
    BaseLineEleStruct corresponds to bmad `base_line_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 29.

    Attributes
    ----------
    ele_order_reflect : bool
        Part of reflection or reversed line?
        Bmad type: logical
        Fortran default: .false.
    ix_ele_in_in_lat : int
        Bmad type: integer
        Fortran default: -1
    ix_multi : int
        Multipass indentifier
        Bmad type: integer
        Fortran default: 0
    name : str
        Name of sequence or element
        Bmad type: character
        Fortran default: ''
    orientation : int
        Element reversed?
        Bmad type: integer
        Fortran default: 1
    tag : str
        Tag name.
        Bmad type: character
        Fortran default: ''
    """

    ele_order_reflect: bool = pydantic.Field(
        default=False,
        description="Part of reflection or reversed line?",
    )
    ix_ele_in_in_lat: int = pydantic.Field(
        default=-1,
    )
    ix_multi: int = pydantic.Field(
        default=0,
        description="Multipass indentifier",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of sequence or element",
    )
    orientation: int = pydantic.Field(
        default=1,
        description="Element reversed?",
    )
    tag: str = pydantic.Field(
        default="",
        max_length=40,
        description="Tag name.",
    )


class BpCommon2Struct(pydantic.BaseModel):
    """
    BpCommon2Struct corresponds to bmad `bp_common2_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 176.

    Attributes
    ----------
    const : BpConstStruct
        Constant name
        Bmad type: bp_const_struct
    """

    const: Sequence[BpConstStruct] = pydantic.Field(
        default=None,
        description="Constant name",
    )


class BpCommonStruct(pydantic.BaseModel):
    """
    BpCommonStruct corresponds to bmad `bp_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 127.

    Attributes
    ----------
    always_parse : bool
        For debugging to force parsing
        Bmad type: logical
        Fortran default: .false.
    bmad_parser_calling : bool
        used for expand_lattice
        Bmad type: logical
        Fortran default: .false.
    calc_reference_orbit : bool
        Bmad type: logical
        Fortran default: .false.
    current_file : StackFileStruct
        Bmad type: stack_file_struct
        Fortran default: null()
    detected_expand_lattice_cmd : bool
        Bmad type: logical
        Fortran default: .false.
    do_superimpose : bool
        Bmad type: logical
        Fortran default: .true.
    error_flag : bool
        Set True on error
        Bmad type: logical
        Fortran default: .false.
    extra : ExtraParsingInfoStruct
        Bmad type: extra_parsing_info_struct
        Fortran default: extra_parsing_info_struct()
    fatal_error_flag : bool
        Set True on fatal (must abort now) error
        Bmad type: logical
        Fortran default: .false.
    file : StackFileStruct
        Bmad type: stack_file_struct
        Fortran default: stack_file_struct()
    i_const_init : int
        Bmad type: integer
        Fortran default: 0
    i_const_tot : int
        Bmad type: integer
        Fortran default: 0
    i_file_level : int
        Bmad type: integer
        Fortran default: 0
    inline_call_active : bool
        Bmad type: logical
        Fortran default: .false.
    input_from_file : bool
        Input is from a lattice file?
        Bmad type: logical
        Fortran default: .true.
    input_line1 : str
        Line before current line. For debug messages.
        Bmad type: character
        Fortran default: ''
    input_line2 : str
        Current line. For debug messages.
        Bmad type: character
        Fortran default: ''
    input_line_meaningful : bool
        Bmad type: logical
        Fortran default: .false.
    ios_next_chunk : int
        Bmad type: integer
        Fortran default: 0
    ios_this_chunk : int
        Bmad type: integer
        Fortran default: 0
    last_char_in_parse_line : str
        Needed for long lines read in pieces. parser_name is used by routines to tell
        if parsing is being done or not.
        Bmad type: character
        Fortran default: ''
    last_word : str
        Last word to be parsed
        Bmad type: character
        Fortran default: ''
    lat_file_names : str
        List of all files used to create lat Note: use %line2_file_name to ID line.
        %line1_file_name may be blank!
        Bmad type: character
    line1_file_name : str
        Name of file from which %input_line1 was read
        Bmad type: character
        Fortran default: ''
    line2_file_name : str
        Name of file from which %input_line2 was read
        Bmad type: character
        Fortran default: ''
    next_chunk : str
        Line waiting to be appended to the parse_line.
        Bmad type: character
        Fortran default: ''
    num_lat_files : int
        Number of files opened
        Bmad type: integer
        Fortran default: 0
    old_lat : LatStruct
        Bmad type: lat_struct
        Fortran default: null()
    parse_line : str
        Current string to be parsed.
        Bmad type: character
        Fortran default: ''
    parser_name : str
        Blank means not in bmad_parser nor bmad_parser2.
        Bmad type: character
        Fortran default: ''
    print_err : bool
        Print error messages? For compatibility with translated MAD files, treat
        undefined vars as having zero value. Note: When using the parser code for local
        evaluations (done by Tao), do not wnat this.
        Bmad type: logical
        Fortran default: .true.
    rest_of_line : str
        Line after semicolon saved until current statement is completely parsed.
        Bmad type: character
        Fortran default: ''
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
    undefined_vars_evaluate_to_zero : bool
        Bmad type: logical
        Fortran default: .true.
    use_local_lat_file : bool
        Bmad type: logical
        Fortran default: .false.
    used_line_set_by_calling_routine : bool
        Bmad type: logical
        Fortran default: .false.
    write_digested : bool
        For bmad_parser
        Bmad type: logical
        Fortran default: .true.
    write_digested2 : bool
        For bmad_parser2
        Bmad type: logical
        Fortran default: .true.
    """

    always_parse: bool = pydantic.Field(
        default=False,
        description="For debugging to force parsing",
    )
    bmad_parser_calling: bool = pydantic.Field(
        default=False,
        description="used for expand_lattice",
    )
    calc_reference_orbit: bool = pydantic.Field(
        default=False,
    )
    current_file: StackFileStruct = pydantic.Field(
        default=None,
    )
    detected_expand_lattice_cmd: bool = pydantic.Field(
        default=False,
    )
    do_superimpose: bool = pydantic.Field(
        default=True,
    )
    error_flag: bool = pydantic.Field(
        default=False,
        description="Set True on error",
    )
    extra: ExtraParsingInfoStruct = pydantic.Field(
        default=None,
    )
    fatal_error_flag: bool = pydantic.Field(
        default=False,
        description="Set True on fatal (must abort now) error",
    )
    file: Sequence[StackFileStruct] = pydantic.Field(
        default=None,
    )
    i_const_init: int = pydantic.Field(
        default=0,
    )
    i_const_tot: int = pydantic.Field(
        default=0,
    )
    i_file_level: int = pydantic.Field(
        default=0,
    )
    inline_call_active: bool = pydantic.Field(
        default=False,
    )
    input_from_file: bool = pydantic.Field(
        default=True,
        description="Input is from a lattice file?",
    )
    input_line1: str = pydantic.Field(
        default="",
        description="Line before current line. For debug messages.",
    )
    input_line2: str = pydantic.Field(
        default="",
        description="Current line. For debug messages.",
    )
    input_line_meaningful: bool = pydantic.Field(
        default=False,
    )
    ios_next_chunk: int = pydantic.Field(
        default=0,
    )
    ios_this_chunk: int = pydantic.Field(
        default=0,
    )
    last_char_in_parse_line: str = pydantic.Field(
        default="",
        max_length=1,
        description=(
            "Needed for long lines read in pieces. parser_name is used by routines to "
            "tell if parsing is being done or not."
        ),
    )
    last_word: str = pydantic.Field(
        default="",
        max_length=100,
        description="Last word to be parsed",
    )
    lat_file_names: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=400,
        description=(
            "List of all files used to create lat Note: use %line2_file_name to ID "
            "line. %line1_file_name may be blank!"
        ),
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
    next_chunk: str = pydantic.Field(
        default="",
        description="Line waiting to be appended to the parse_line.",
    )
    num_lat_files: int = pydantic.Field(
        default=0,
        description="Number of files opened",
    )
    old_lat: LatStruct = pydantic.Field(
        default=None,
    )
    parse_line: str = pydantic.Field(
        default="",
        description="Current string to be parsed.",
    )
    parser_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Blank means not in bmad_parser nor bmad_parser2.",
    )
    print_err: bool = pydantic.Field(
        default=True,
        description=(
            "Print error messages? For compatibility with translated MAD files, treat "
            "undefined vars as having zero value. Note: When using the parser code for "
            "local evaluations (done by Tao), do not wnat this."
        ),
    )
    rest_of_line: str = pydantic.Field(
        default="",
        description="Line after semicolon saved until current statement is completely parsed.",
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
    undefined_vars_evaluate_to_zero: bool = pydantic.Field(
        default=True,
    )
    use_local_lat_file: bool = pydantic.Field(
        default=False,
    )
    used_line_set_by_calling_routine: bool = pydantic.Field(
        default=False,
    )
    write_digested: bool = pydantic.Field(
        default=True,
        description="For bmad_parser",
    )
    write_digested2: bool = pydantic.Field(
        default=True,
        description="For bmad_parser2",
    )


class BpConstStruct(pydantic.BaseModel):
    """
    BpConstStruct corresponds to bmad `bp_const_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 121.

    Attributes
    ----------
    index : int
        Constant sort index
        Bmad type: integer
        Fortran default: 0
    name : str
        Constant name
        Bmad type: character
        Fortran default: ''
    value : float
        Constant value
        Bmad type: real
        Fortran default: 0
    """

    index: int = pydantic.Field(
        default=0,
        description="Constant sort index",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Constant name",
    )
    value: float = pydantic.Field(
        default=0,
        description="Constant value",
    )


class ParserControllerStruct(pydantic.BaseModel):
    """
    ParserControllerStruct corresponds to bmad `parser_controller_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 78.

    Attributes
    ----------
    attrib_name : str
        Bmad type: character
    n_stk : int
        Bmad type: integer
    name : str
        Bmad type: character
    stack : ExpressionAtomStruct
        Arithmetic expression stack
        Bmad type: expression_atom_struct
    y_knot : float
        Bmad type: real
    """

    attrib_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    n_stk: int = pydantic.Field(
        default=0,
    )
    name: str = pydantic.Field(
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


class ParserEleStruct(pydantic.BaseModel):
    """
    ParserEleStruct corresponds to bmad `parser_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 86.

    Attributes
    ----------
    control : ParserControllerStruct
        Bmad type: parser_controller_struct
    create_jumbo_slave : bool
        Bmad type: logical
        Fortran default: .false.
    default_attrib : str
        For group/overlay elements: slave attribute
        Bmad type: character
        Fortran default: ''
    ele_name : str
        For fork element or superimpose statement.
        Bmad type: character
        Fortran default: ''
    ele_pt : int
        Bmad type: integer
    field_overlaps : str
        Bmad type: character
    index : int
        Bmad type: integer
    is_range : bool
        For girders
        Bmad type: logical
        Fortran default: .false.
    ix_count : int
        Bmad type: integer
    ix_line_in_file : int
        Line in file where element was defined.
        Bmad type: integer
    ix_super_ref_multipass : int
        Multipass index for superimpose reference element.
        Bmad type: integer
        Fortran default: 0
    lat_file : str
        File where element was defined.
        Bmad type: character
        Fortran default: ''
    names1 : str
        Currently just used by feedback element.
        Bmad type: character
    names2 : str
        Currently just used by feedback element.
        Bmad type: character
    offset : float
        Bmad type: real
        Fortran default: 0
    ref_name : str
        Bmad type: character
        Fortran default: ''
    ref_pt : int
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
    """

    control: Sequence[ParserControllerStruct] = pydantic.Field(
        default=None,
    )
    create_jumbo_slave: bool = pydantic.Field(
        default=False,
    )
    default_attrib: str = pydantic.Field(
        default="",
        max_length=40,
        description="For group/overlay elements: slave attribute",
    )
    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="For fork element or superimpose statement.",
    )
    ele_pt: int = pydantic.Field(
        default=0,
    )
    field_overlaps: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    index: int = pydantic.Field(
        default=0,
    )
    is_range: bool = pydantic.Field(
        default=False,
        description="For girders",
    )
    ix_count: int = pydantic.Field(
        default=0,
    )
    ix_line_in_file: int = pydantic.Field(
        default=0,
        description="Line in file where element was defined.",
    )
    ix_super_ref_multipass: int = pydantic.Field(
        default=0,
        description="Multipass index for superimpose reference element.",
    )
    lat_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="File where element was defined.",
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
    offset: float = pydantic.Field(
        default=0,
    )
    ref_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ref_pt: int = pydantic.Field(
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


class ParserLatStruct(pydantic.BaseModel):
    """
    ParserLatStruct corresponds to bmad `parser_lat_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 108.

    Attributes
    ----------
    ele : ParserEleStruct
        Bmad type: parser_ele_struct
    """

    ele: Sequence[ParserEleStruct] = pydantic.Field(
        default=None,
    )


class SeqEleStruct(pydantic.BaseModel):
    """
    SeqEleStruct corresponds to bmad `seq_ele_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 14.

    Attributes
    ----------
    actual_arg : str
        Bmad type: character
    ele_order_reflect : bool
        Travel through ele sequence in reverse order
        Bmad type: logical
        Fortran default: .false.
    ele_orientation : int
        element has reverse orientation.
        Bmad type: integer
        Fortran default: 1
    ix_arg : int
        index in arg list (for replacement lines)
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        if an element: pointer to ELE array if a line or list: pointer to SEQ array
        Bmad type: integer
        Fortran default: 0
    name : str
        name of element, subline, or sublist
        Bmad type: character
    rep_count : int
        how many copies of an element
        Bmad type: integer
        Fortran default: 1
    slice_end : str
        For "my_line[start:end]" slice constructs.
        Bmad type: character
        Fortran default: ''
    slice_start : str
        For "my_line[start:end]" slice constructs.
        Bmad type: character
        Fortran default: ''
    tag : str
        tag name.
        Bmad type: character
        Fortran default: ''
    type : int
        LINE$, REPLACEMENT_LINE$, LIST$, ELEMENT$
        Bmad type: integer
        Fortran default: 0
    """

    actual_arg: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    ele_order_reflect: bool = pydantic.Field(
        default=False,
        description="Travel through ele sequence in reverse order",
    )
    ele_orientation: int = pydantic.Field(
        default=1,
        description="element has reverse orientation.",
    )
    ix_arg: int = pydantic.Field(
        default=0,
        description="index in arg list (for replacement lines)",
    )
    ix_ele: int = pydantic.Field(
        default=0,
        description="if an element: pointer to ELE array if a line or list: pointer to SEQ array",
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="name of element, subline, or sublist",
    )
    rep_count: int = pydantic.Field(
        default=1,
        description="how many copies of an element",
    )
    slice_end: str = pydantic.Field(
        default="",
        max_length=40,
        description="For 'my_line[start:end]' slice constructs.",
    )
    slice_start: str = pydantic.Field(
        default="",
        max_length=40,
        description="For 'my_line[start:end]' slice constructs.",
    )
    tag: str = pydantic.Field(
        default="",
        max_length=40,
        description="tag name.",
    )
    type: int = pydantic.Field(
        default=0,
        description="LINE$, REPLACEMENT_LINE$, LIST$, ELEMENT$",
    )


class SeqStruct(pydantic.BaseModel):
    """
    SeqStruct corresponds to bmad `seq_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 38.

    Attributes
    ----------
    active : bool
        Used to prevent infinite loops.
        Bmad type: logical
        Fortran default: .false.
    corresponding_actual_arg : str
        Bmad type: character
    dummy_arg : str
        Bmad type: character
    ele : SeqEleStruct
        Elements in the sequence
        Bmad type: seq_ele_struct
    file_name : str
        File where sequence is defined
        Bmad type: character
        Fortran default: ''
    index : int
        Alphabetical order sorted index
        Bmad type: integer
    ix_file_line : int
        Line number in file where sequence is defined
        Bmad type: integer
    ix_list : int
        Current index for lists
        Bmad type: integer
    list_upcount : int
        Bmad type: integer
        Fortran default: 0
    multipass : bool
        Bmad type: logical
    name : str
        name of sequence
        Bmad type: character
    ptc_layout : bool
        Put in separate PTC layout
        Bmad type: logical
    type : int
        LINE$, REPLACEMENT_LINE$ or LIST$
        Bmad type: integer
    """

    active: bool = pydantic.Field(
        default=False,
        description="Used to prevent infinite loops.",
    )
    corresponding_actual_arg: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    dummy_arg: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    ele: Sequence[SeqEleStruct] = pydantic.Field(
        default=None,
        description="Elements in the sequence",
    )
    file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="File where sequence is defined",
    )
    index: int = pydantic.Field(
        default=0,
        description="Alphabetical order sorted index",
    )
    ix_file_line: int = pydantic.Field(
        default=0,
        description="Line number in file where sequence is defined",
    )
    ix_list: int = pydantic.Field(
        default=0,
        description="Current index for lists",
    )
    list_upcount: int = pydantic.Field(
        default=0,
    )
    multipass: bool = pydantic.Field(
        default=False,
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="name of sequence",
    )
    ptc_layout: bool = pydantic.Field(
        default=False,
        description="Put in separate PTC layout",
    )
    type: int = pydantic.Field(
        default=0,
        description="LINE$, REPLACEMENT_LINE$ or LIST$",
    )


class StackFileStruct(pydantic.BaseModel):
    """
    StackFileStruct corresponds to bmad `stack_file_struct`
    which is in Users/klauer/Repos/bmad/bmad/parsing/bmad_parser_struct.f90 on line 60.

    Attributes
    ----------
    dir : str
        Bmad type: character
        Fortran default: './'
    f_unit : int
        Bmad type: integer
        Fortran default: 0
    full_name : str
        Bmad type: character
        Fortran default: ''
    i_line : int
        Bmad type: integer
        Fortran default: 0
    inline_call_active : bool
        Bmad type: logical
        Fortran default: .false.
    input_line1_saved : str
        Bmad type: character
        Fortran default: ''
    input_line2_saved : str
        Bmad type: character
        Fortran default: ''
    ios_next_chunk_saved : int
        Bmad type: integer
        Fortran default: 0
    ios_this_chunk_saved : int
        Bmad type: integer
        Fortran default: 0
    last_char_in_parse_line_saved : str
        Bmad type: character
        Fortran default: ''
    next_chunk_saved : str
        Bmad type: character
        Fortran default: ''
    parse_line_saved : str
        Bmad type: character
        Fortran default: ''
    rest_of_line_saved : str
        Bmad type: character
        Fortran default: ''
    """

    dir: str = pydantic.Field(
        default="./",
        max_length=400,
    )
    f_unit: int = pydantic.Field(
        default=0,
    )
    full_name: str = pydantic.Field(
        default="",
        max_length=400,
    )
    i_line: int = pydantic.Field(
        default=0,
    )
    inline_call_active: bool = pydantic.Field(
        default=False,
    )
    input_line1_saved: str = pydantic.Field(
        default="",
    )
    input_line2_saved: str = pydantic.Field(
        default="",
    )
    ios_next_chunk_saved: int = pydantic.Field(
        default=0,
    )
    ios_this_chunk_saved: int = pydantic.Field(
        default=0,
    )
    last_char_in_parse_line_saved: str = pydantic.Field(
        default="",
        max_length=1,
    )
    next_chunk_saved: str = pydantic.Field(
        default="",
    )
    parse_line_saved: str = pydantic.Field(
        default="",
    )
    rest_of_line_saved: str = pydantic.Field(
        default="",
    )


class Subobj(pydantic.BaseModel):
    """
    Subobj corresponds to bmad `subobj`
    which is in Users/klauer/Repos/bmad/bmad/parsing/converter_distribution_parser.f90 on line 24.

    Attributes
    ----------
    n_max : int
        Bmad type: integer
    n_min : int
        Bmad type: integer
    name : str
        Bmad type: character
    """

    n_max: int = pydantic.Field(
        default=0,
    )
    n_min: int = pydantic.Field(
        default=0,
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )


class PhotonCoordStruct(pydantic.BaseModel):
    """
    PhotonCoordStruct corresponds to bmad `photon_coord_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/capillary_mod.f90 on line 5.

    Attributes
    ----------
    ix_section : int
        Cross section index
        Bmad type: integer
    orb : CoordStruct
        Phase space: orb%vec = (x, vx/c, y, vy/c, s, vs/c)
        Bmad type: coord_struct
    track_len : float
        Total track length from the start of the element.
        Bmad type: real
    """

    ix_section: int = pydantic.Field(
        default=0,
        description="Cross section index",
    )
    orb: CoordStruct = pydantic.Field(
        default=None,
        description="Phase space: orb%vec = (x, vx/c, y, vy/c, s, vs/c)",
    )
    track_len: float = pydantic.Field(
        default=0.0,
        description="Total track length from the start of the element.",
    )


class PhotonTrackStruct(pydantic.BaseModel):
    """
    PhotonTrackStruct corresponds to bmad `photon_track_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/capillary_mod.f90 on line 11.

    Attributes
    ----------
    now : PhotonCoordStruct
        Bmad type: photon_coord_struct
    old : PhotonCoordStruct
        Bmad type: photon_coord_struct
    """

    now: PhotonCoordStruct = pydantic.Field(
        default=None,
    )
    old: PhotonCoordStruct = pydantic.Field(
        default=None,
    )


class AdaptiveIntegrationIntervalStruct(pydantic.BaseModel):
    """
    AdaptiveIntegrationIntervalStruct corresponds to bmad `adaptive_integration_interval_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_mod.f90 on line 1397.

    Attributes
    ----------
    integral : float
        Integral over interval
        Bmad type: real
    int_err : float
        Integral estimated error
        Bmad type: real
    ix_next : int
        previous interval
        Bmad type: integer
        Fortran default: -1
    ix_previous : int
        Next interval
        Bmad type: integer
        Fortran default: -1
    x : float
        [x(0), x(4)] = Interval range
        Bmad type: real
    y : float
        Function value at points x(0:4)
        Bmad type: real
    """

    integral: float = pydantic.Field(
        default=0.0,
        description="Integral over interval",
        validation_alias=pydantic.AliasChoices("integral", "Integral"),
        serialization_alias="Integral",
    )
    int_err: float = pydantic.Field(
        default=0.0,
        description="Integral estimated error",
    )
    ix_next: int = pydantic.Field(
        default=-1,
        description="previous interval",
    )
    ix_previous: int = pydantic.Field(
        default=-1,
        description="Next interval",
    )
    x: Sequence[float] = pydantic.Field(
        default=0.0,
        description="[x(0), x(4)] = Interval range",
    )
    y: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Function value at points x(0:4)",
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
    del_x : float
        Spacing between spline points
        Bmad type: real
    pt : PhotonInitSplinePtStruct
        Bmad type: photon_init_spline_pt_struct
    spline_type : int
        Bmad type: integer
    x_max : float
        Upper bound of Region of validity of this spline fit. The lower bound is given
        by the upper bound of the previos struct.
        Bmad type: real
    x_min : float
        Lower bound
        Bmad type: real
    """

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
    x_max: float = pydantic.Field(
        default=0.0,
        description=(
            "Upper bound of Region of validity of this spline fit. The lower bound is "
            "given by the upper bound of the previos struct."
        ),
    )
    x_min: float = pydantic.Field(
        default=0.0,
        description="Lower bound",
    )


class PhotonVertAnglePtStruct(pydantic.BaseModel):
    """
    PhotonVertAnglePtStruct corresponds to bmad `photon_vert_angle_pt_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_mod.f90 on line 434.

    Attributes
    ----------
    dgp_d2 : float
        d^2Gamma-phi/(dlog_E dIntegratedProbability)
        Bmad type: real
    dgp_dloge : float
        dGamm-phi/dlog_E
        Bmad type: real
    dgp_dprob : float
        dGamma-phi/dIntegratedProbability
        Bmad type: real
    gp : float
        Gamma-phi
        Bmad type: real
    """

    dgp_d2: float = pydantic.Field(
        default=0.0,
        description="d^2Gamma-phi/(dlog_E dIntegratedProbability)",
    )
    dgp_dloge: float = pydantic.Field(
        default=0.0,
        description="dGamm-phi/dlog_E",
        validation_alias=pydantic.AliasChoices("dgp_dloge", "dgp_dlogE"),
        serialization_alias="dgp_dlogE",
    )
    dgp_dprob: float = pydantic.Field(
        default=0.0,
        description="dGamma-phi/dIntegratedProbability",
    )
    gp: float = pydantic.Field(
        default=0.0,
        description="Gamma-phi",
    )


class PhotonInitSplinesStruct(pydantic.BaseModel):
    """
    PhotonInitSplinesStruct corresponds to bmad `photon_init_splines_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_spline_mod.f90 on line 24.

    Attributes
    ----------
    energy_prob : SplineStruct
        Bmad type: spline_struct
    source_type : str
        'bend', 'wiggler', 'undulator'
        Bmad type: character
    spline_space_dimensions : int
        Dimensions: [energy, y_angle, x_angle, x, y]
        Bmad type: integer
    y_angle : PhotonInitYAngleSplineStruct
        Bmad type: photon_init_y_angle_spline_struct
    """

    energy_prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    source_type: str = pydantic.Field(
        default_factory=list,
        max_length=16,
        description="'bend', 'wiggler', 'undulator'",
    )
    spline_space_dimensions: int = pydantic.Field(
        default=0,
        description="Dimensions: [energy, y_angle, x_angle, x, y]",
    )
    y_angle: Sequence[PhotonInitYAngleSplineStruct] = pydantic.Field(
        default=None,
    )


class PhotonInitXAngleSplineStruct(pydantic.BaseModel):
    """
    PhotonInitXAngleSplineStruct corresponds to bmad `photon_init_x_angle_spline_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_spline_mod.f90 on line 15.

    Attributes
    ----------
    pc : SplineStruct
        Bmad type: spline_struct
    pl : SplineStruct
        Bmad type: spline_struct
    pl45 : SplineStruct
        Bmad type: spline_struct
    prob : SplineStruct
        Bmad type: spline_struct
    """

    pc: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl45: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )


class PhotonInitYAngleSplineStruct(pydantic.BaseModel):
    """
    PhotonInitYAngleSplineStruct corresponds to bmad `photon_init_y_angle_spline_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_init_spline_mod.f90 on line 19.

    Attributes
    ----------
    pc : SplineStruct
        Bmad type: spline_struct
    pl : SplineStruct
        Bmad type: spline_struct
    pl45 : SplineStruct
        Bmad type: spline_struct
    prob : SplineStruct
        Bmad type: spline_struct
    x_angle : PhotonInitXAngleSplineStruct
        Bmad type: photon_init_x_angle_spline_struct
    """

    pc: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    pl45: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    prob: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    x_angle: Sequence[PhotonInitXAngleSplineStruct] = pydantic.Field(
        default=None,
    )


class ChebDiffuseStruct(pydantic.BaseModel):
    """
    ChebDiffuseStruct corresponds to bmad `cheb_diffuse_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_reflection_mod.f90 on line 20.

    Attributes
    ----------
    cch : float
        Bmad type: real
    cch_int : float
        Bmad type: real
    """

    cch: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    cch_int: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class DiffuseCommonStruct(pydantic.BaseModel):
    """
    DiffuseCommonStruct corresponds to bmad `diffuse_common_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_reflection_mod.f90 on line 28.

    Attributes
    ----------
    area_err_tol : float
        Bmad type: real
        Fortran default: 4d-3
    use_spline_fit : bool
        Bmad type: logical
        Fortran default: .true.
    """

    area_err_tol: float = pydantic.Field(
        default=0.004,
    )
    use_spline_fit: bool = pydantic.Field(
        default=True,
    )


class DiffuseParamStruct(pydantic.BaseModel):
    """
    DiffuseParamStruct corresponds to bmad `diffuse_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_reflection_mod.f90 on line 13.

    Attributes
    ----------
    c_norm : float
        Bmad type: real
    chx_norm : float
        Bmad type: real
    lambda_ : float
        Bmad type: real
    n_pt_spline : int
        Bmad type: integer
    prob_spline : SplineStruct
        Bmad type: spline_struct
    x : float
        Bmad type: real
    y : float
        Bmad type: real
    """

    c_norm: float = pydantic.Field(
        default=0.0,
    )
    chx_norm: float = pydantic.Field(
        default=0.0,
    )
    lambda_: float = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("lambda_", "lambda"),
        serialization_alias="lambda",
    )
    n_pt_spline: int = pydantic.Field(
        default=0,
    )
    prob_spline: Sequence[SplineStruct] = pydantic.Field(
        default=None,
    )
    x: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )


class CrystalParamStruct(pydantic.BaseModel):
    """
    CrystalParamStruct corresponds to bmad `crystal_param_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/photon_utils_mod.f90 on line 9.

    Attributes
    ----------
    b_eff : float
        Bmad type: real
    cap_gamma : float
        Bmad type: real
    dtheta_sin_2theta : float
        Bmad type: real
    new_vvec : float
        Bmad type: real
    old_vvec : float
        Bmad type: real
    wavelength : float
        Bmad type: real
    """

    b_eff: float = pydantic.Field(
        default=0.0,
    )
    cap_gamma: float = pydantic.Field(
        default=0.0,
    )
    dtheta_sin_2theta: float = pydantic.Field(
        default=0.0,
    )
    new_vvec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    old_vvec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    wavelength: float = pydantic.Field(
        default=0.0,
    )


class MosaicLayerStruct(pydantic.BaseModel):
    """
    MosaicLayerStruct corresponds to bmad `mosaic_layer_struct`
    which is in Users/klauer/Repos/bmad/bmad/photon/track1_photon_mod.f90 on line 623.

    Attributes
    ----------
    branch_ratio : float
        Bmad type: real
        Fortran default: 0
    follow_diffracted : bool
        Bmad type: logical
        Fortran default: .false.
    theta_in : float
        Bmad type: real
        Fortran default: 0
    theta_out : float
        Bmad type: real
        Fortran default: 0
    """

    branch_ratio: float = pydantic.Field(
        default=0,
    )
    follow_diffracted: bool = pydantic.Field(
        default=False,
    )
    theta_in: float = pydantic.Field(
        default=0,
    )
    theta_out: float = pydantic.Field(
        default=0,
    )


class PtcRadMapStruct(pydantic.BaseModel):
    """
    PtcRadMapStruct corresponds to bmad `ptc_rad_map_struct`
    which is in Users/klauer/Repos/bmad/bmad/ptc/ptc_map_with_radiation_mod.f90 on line 9.

    Attributes
    ----------
    damp_mat : float
        Damping "correction" to orbital matrix. Stoc_mat is referenced to the start of
        the map. That is, it is applied before the transport matrix.
        Bmad type: real
    dref_time : float
        Time ref particle takes.
        Bmad type: real
    ix_branch : int
        Bmad type: integer
    ix_ele_end : int
        End point for making the map
        Bmad type: integer
    ix_ele_start : int
        Start point for making the map
        Bmad type: integer
    lattice_file : str
        Name of the lattice file
        Bmad type: character
    map_order : int
        Bmad type: integer
    nodamp_mat : float
        Nondamped orbital matrix. M_orbit = M_damp * M_nodamp
        Bmad type: real
    p0c_end : float
        ref momentum at end
        Bmad type: real
    p0c_start : float
        ref momentum at start
        Bmad type: real
    radiation_damping_on : bool
        Bmad type: logical
    ref0 : float
        Reference orbit at start.
        Bmad type: real
    ref1 : float
        Reference orbit at end.
        Bmad type: real
    s_end : float
        Ending s-position
        Bmad type: real
    stoc_mat : float
        Stochatic matrix for the orbit.
        Bmad type: real
    sub_map : TreeElement
        Type tree_element in PTC
        Bmad type: tree_element_zhe
    """

    damp_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description=(
            "Damping 'correction' to orbital matrix. Stoc_mat is referenced to the "
            "start of the map. That is, it is applied before the transport matrix."
        ),
    )
    dref_time: float = pydantic.Field(
        default=0.0,
        description="Time ref particle takes.",
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_ele_end: int = pydantic.Field(
        default=0,
        description="End point for making the map",
    )
    ix_ele_start: int = pydantic.Field(
        default=0,
        description="Start point for making the map",
    )
    lattice_file: str = pydantic.Field(
        default_factory=list,
        max_length=200,
        description="Name of the lattice file",
    )
    map_order: int = pydantic.Field(
        default=0,
    )
    nodamp_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Nondamped orbital matrix. M_orbit = M_damp * M_nodamp",
    )
    p0c_end: float = pydantic.Field(
        default=0.0,
        description="ref momentum at end",
    )
    p0c_start: float = pydantic.Field(
        default=0.0,
        description="ref momentum at start",
    )
    radiation_damping_on: bool = pydantic.Field(
        default=False,
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
    s_end: float = pydantic.Field(
        default=0.0,
        description="Ending s-position",
    )
    stoc_mat: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Stochatic matrix for the orbit.",
    )
    sub_map: Sequence[TreeElement] = pydantic.Field(
        default=None,
        max_length=3,
        description="Type tree_element in PTC",
    )


class Quat1Struct(pydantic.BaseModel):
    """
    Quat1Struct corresponds to bmad `quat1_struct`
    which is in Users/klauer/Repos/bmad/bmad/ptc/ptc_spin_matching_calc.f90 on line 38.

    Attributes
    ----------
    q : float
        Bmad type: real
    """

    q: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class CsrBunchSliceStruct(pydantic.BaseModel):
    """
    CsrBunchSliceStruct corresponds to bmad `csr_bunch_slice_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 34.

    Attributes
    ----------
    charge : float
        charge of the particles
        Bmad type: real
        Fortran default: 0
    coef_lsc_minus : float
        LSC Kick coefs.
        Bmad type: real
        Fortran default: 0
    coef_lsc_plus : float
        LSC Kick coefs.
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
    kick_lsc : float
        Bmad type: real
        Fortran default: 0
    n_particle : float
        Number of particles in slice can be a fraction since particles span multiple
        bins.
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
    """

    charge: float = pydantic.Field(
        default=0,
        description="charge of the particles",
    )
    coef_lsc_minus: Sequence[float] = pydantic.Field(
        default=0,
        description="LSC Kick coefs.",
    )
    coef_lsc_plus: Sequence[float] = pydantic.Field(
        default=0,
        description="LSC Kick coefs.",
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
    sig_x: float = pydantic.Field(
        default=0,
        description="particle's RMS width",
    )
    sig_y: float = pydantic.Field(
        default=0,
        description="particle's RMS width",
    )
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


class CsrEleInfoStruct(pydantic.BaseModel):
    """
    CsrEleInfoStruct corresponds to bmad `csr_ele_info_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 22.

    Attributes
    ----------
    l_chord : float
        Chord Length. Negative if bunch moves backwards in element.
        Bmad type: real
    dl_s : float
        L_s(of element) - L_chord
        Bmad type: real
    ele : EleStruct
        lattice element
        Bmad type: ele_struct
    floor0 : FloorPositionStruct
        Floor position of centroid at entrance/exit ends
        Bmad type: floor_position_struct
    floor1 : FloorPositionStruct
        Floor position of centroid at entrance/exit ends
        Bmad type: floor_position_struct
    orbit0 : CoordStruct
        centroid orbit at entrance/exit ends
        Bmad type: coord_struct
    orbit1 : CoordStruct
        centroid orbit at entrance/exit ends
        Bmad type: coord_struct
    ref_floor0 : FloorPositionStruct
        Floor position of element ref coords at entrance/exit ends
        Bmad type: floor_position_struct
    ref_floor1 : FloorPositionStruct
        Floor position of element ref coords at entrance/exit ends
        Bmad type: floor_position_struct
    spline : SplineStruct
        Spline for centroid orbit. spline%x = distance along chord. The spline is zero
        at the ends by construction.
        Bmad type: spline_struct
    theta_chord : float
        Reference angle of chord in z-x plane
        Bmad type: real
    """

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
    ele: EleStruct = pydantic.Field(
        default=None,
        description="lattice element",
    )
    floor0: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of centroid at entrance/exit ends",
    )
    floor1: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of centroid at entrance/exit ends",
    )
    orbit0: CoordStruct = pydantic.Field(
        default=None,
        description="centroid orbit at entrance/exit ends",
    )
    orbit1: CoordStruct = pydantic.Field(
        default=None,
        description="centroid orbit at entrance/exit ends",
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
        description=(
            "Spline for centroid orbit. spline%x = distance along chord. The spline is "
            "zero at the ends by construction."
        ),
    )
    theta_chord: float = pydantic.Field(
        default=0.0,
        description="Reference angle of chord in z-x plane",
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
    L : float
        Distance between source and kick points.
        Bmad type: real
    l_vec : float
        L vector in global coordinates.
        Bmad type: real
    dl : float
        = epsilon_L = Ls - L
        Bmad type: real
    dz_particles : float
        Kicked particle - source particle position at constant time.
        Bmad type: real
    floor_s : FloorPositionStruct
        Floor position of source pt
        Bmad type: floor_position_struct
    image_kick_csr : float
        kick.
        Bmad type: real
    ix_ele_source : int
        Source element index.
        Bmad type: integer
    s_chord_source : float
        Source point coordinate along chord.
        Bmad type: real
    theta_l : float
        Angle of L vector
        Bmad type: real
    theta_lk : float
        Angle between L and velocity of kicked particle
        Bmad type: real
    theta_sl : float
        Angle between velocity of particle at source pt and L
        Bmad type: real
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
    L: float = pydantic.Field(
        default=0.0,
        description="Distance between source and kick points.",
    )
    l_vec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="L vector in global coordinates.",
        validation_alias=pydantic.AliasChoices("l_vec", "L_vec"),
        serialization_alias="L_vec",
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
    floor_s: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor position of source pt",
    )
    image_kick_csr: float = pydantic.Field(
        default=0.0,
        description="kick.",
    )
    ix_ele_source: int = pydantic.Field(
        default=0,
        description="Source element index.",
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
    theta_lk: float = pydantic.Field(
        default=0.0,
        description="Angle between L and velocity of kicked particle",
    )
    theta_sl: float = pydantic.Field(
        default=0.0,
        description="Angle between velocity of particle at source pt and L",
    )


class CsrParticlePositionStruct(pydantic.BaseModel):
    """
    CsrParticlePositionStruct corresponds to bmad `csr_particle_position_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 73.

    Attributes
    ----------
    charge : float
        particle charge
        Bmad type: real
    r : float
        particle position
        Bmad type: real
    """

    charge: float = pydantic.Field(
        default=0.0,
        description="particle charge",
    )
    r: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="particle position",
    )


class CsrStruct(pydantic.BaseModel):
    """
    CsrStruct corresponds to bmad `csr_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/csr_and_space_charge_mod.f90 on line 78.

    Attributes
    ----------
    actual_track_step : float
        ds_track_step scalled by Length_centroid_chord / Length_element ratio
        Bmad type: real
    beta : float
        Relativistic beta factor.
        Bmad type: real
    ds_track_step : float
        True step size
        Bmad type: real
    dz_slice : float
        Bin width
        Bmad type: real
        Fortran default: 0
    eleinfo : CsrEleInfoStruct
        Element-by-element information.
        Bmad type: csr_ele_info_struct
    floor_k : FloorPositionStruct
        Floor coords at kick point
        Bmad type: floor_position_struct
    gamma : float
        Relativistic gamma factor.
        Bmad type: real
    gamma2 : float
        Relativistic gamma factor.
        Bmad type: real
    ix_ele_kick : int
        Same as element being tracked through.
        Bmad type: integer
    kick1 : CsrKick1Struct
        kick1(i) referes to the kick between two slices i bins apart.
        Bmad type: csr_kick1_struct
    kick_ele : EleStruct
        Element where the kick pt is == ele tracked through.
        Bmad type: ele_struct
    kick_factor : float
        Coefficient to scale the kick
        Bmad type: real
    mesh3d : Mesh3dStruct
        Bmad type: mesh3d_struct
    position : CsrParticlePositionStruct
        Bmad type: csr_particle_position_struct
    rel_mass : float
        m_particle / m_electron
        Bmad type: real
    s_chord_kick : float
        Kick point along beam centroid line
        Bmad type: real
    s_kick : float
        Kick point longitudinal location (element ref coords) from entrance end
        Bmad type: real
    slice : CsrBunchSliceStruct
        slice(i) refers to the i^th bunch slice.
        Bmad type: csr_bunch_slice_struct
    species : int
        Particle type
        Bmad type: integer
    x0_bunch : float
        Bunch centroid
        Bmad type: real
    y0_bunch : float
        Bunch centroid
        Bmad type: real
    y_source : float
        Height of source particle.
        Bmad type: real
    """

    actual_track_step: float = pydantic.Field(
        default=0.0,
        description="ds_track_step scalled by Length_centroid_chord / Length_element ratio",
    )
    beta: float = pydantic.Field(
        default=0.0,
        description="Relativistic beta factor.",
    )
    ds_track_step: float = pydantic.Field(
        default=0.0,
        description="True step size",
    )
    dz_slice: float = pydantic.Field(
        default=0,
        description="Bin width",
    )
    eleinfo: Sequence[CsrEleInfoStruct] = pydantic.Field(
        default=None,
        description="Element-by-element information.",
    )
    floor_k: FloorPositionStruct = pydantic.Field(
        default=None,
        description="Floor coords at kick point",
    )
    gamma: float = pydantic.Field(
        default=0.0,
        description="Relativistic gamma factor.",
    )
    gamma2: float = pydantic.Field(
        default=0.0,
        description="Relativistic gamma factor.",
    )
    ix_ele_kick: int = pydantic.Field(
        default=0,
        description="Same as element being tracked through.",
    )
    kick1: Sequence[CsrKick1Struct] = pydantic.Field(
        default=None,
        description="kick1(i) referes to the kick between two slices i bins apart.",
    )
    kick_ele: EleStruct = pydantic.Field(
        default=None,
        description="Element where the kick pt is == ele tracked through.",
    )
    kick_factor: float = pydantic.Field(
        default=0.0,
        description="Coefficient to scale the kick",
    )
    mesh3d: Mesh3dStruct = pydantic.Field(
        default=None,
    )
    position: Sequence[CsrParticlePositionStruct] = pydantic.Field(
        default=None,
    )
    rel_mass: float = pydantic.Field(
        default=0.0,
        description="m_particle / m_electron",
    )
    s_chord_kick: float = pydantic.Field(
        default=0.0,
        description="Kick point along beam centroid line",
    )
    s_kick: float = pydantic.Field(
        default=0.0,
        description="Kick point longitudinal location (element ref coords) from entrance end",
    )
    slice: Sequence[CsrBunchSliceStruct] = pydantic.Field(
        default=None,
        description="slice(i) refers to the i^th bunch slice.",
    )
    species: int = pydantic.Field(
        default=0,
        description="Particle type",
    )
    x0_bunch: float = pydantic.Field(
        default=0.0,
        description="Bunch centroid",
    )
    y0_bunch: float = pydantic.Field(
        default=0.0,
        description="Bunch centroid",
    )
    y_source: float = pydantic.Field(
        default=0.0,
        description="Height of source particle.",
    )


class Mesh3dStruct(pydantic.BaseModel):
    """
    Mesh3dStruct corresponds to bmad `mesh3d_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/open_spacecharge_mod.f90 on line 14.

    Attributes
    ----------
    bfield : float
        magnetic field grid
        Bmad type: real
    charge : float
        Total charge on mesh
        Bmad type: real
    delta : float
        Grid spacing
        Bmad type: real
    efield : float
        electric field grid
        Bmad type: real
    gamma : float
        Relativistic gamma
        Bmad type: real
    max : float
        Maximum in each dimension
        Bmad type: real
    min : float
        Minimim in each dimension
        Bmad type: real
    nhi : int
        Highest grid index in x, y, z (m) of rho and the quantity being computed (phi
        or E)
        Bmad type: integer
        Fortran default: [64, 64, 64]
    nlo : int
        Lowest  grid index in x, y, z (m) of rho and the quantity being computed (phi
        or E)
        Bmad type: integer
        Fortran default: [ 1,  1,  1]
    npad : int
        Array padding for cyclic convolution
        Bmad type: integer
        Fortran default: [ 1,  1,  1]
    phi : float
        electric potential grid
        Bmad type: real
    rho : float
        Charge density grid
        Bmad type: real
    """

    bfield: float = pydantic.Field(
        default=0.0,
        description="magnetic field grid",
    )
    charge: float = pydantic.Field(
        default=0.0,
        description="Total charge on mesh",
    )
    delta: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Grid spacing",
    )
    efield: float = pydantic.Field(
        default=0.0,
        description="electric field grid",
    )
    gamma: float = pydantic.Field(
        default=0.0,
        description="Relativistic gamma",
    )
    max: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Maximum in each dimension",
    )
    min: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Minimim in each dimension",
    )
    nhi: Sequence[int] = pydantic.Field(
        default=[64, 64, 64],
        max_length=3,
        description=(
            "Highest grid index in x, y, z (m) of rho and the quantity being computed "
            "(phi or E)"
        ),
    )
    nlo: Sequence[int] = pydantic.Field(
        default=[1, 1, 1],
        max_length=3,
        description=(
            "Lowest  grid index in x, y, z (m) of rho and the quantity being computed "
            "(phi or E)"
        ),
    )
    npad: Sequence[int] = pydantic.Field(
        default=[1, 1, 1],
        max_length=3,
        description="Array padding for cyclic convolution",
    )
    phi: float = pydantic.Field(
        default=0.0,
        description="electric potential grid",
    )
    rho: float = pydantic.Field(
        default=0.0,
        description="Charge density grid",
    )


class ThisWStruct(pydantic.BaseModel):
    """
    ThisWStruct corresponds to bmad `this_w_struct`
    which is in Users/klauer/Repos/bmad/bmad/space_charge/space_charge_mod.f90 on line 33.

    Attributes
    ----------
    ixp : int
        Bmad type: integer
    w_mat : float
        Bmad type: real
    """

    ixp: int = pydantic.Field(
        default=0,
    )
    w_mat: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class QArrayStruct(pydantic.BaseModel):
    """
    QArrayStruct corresponds to bmad `q_array_struct`
    which is in Users/klauer/Repos/bmad/bmad/spin/track1_spin_integration.f90 on line 145.

    Attributes
    ----------
    h : float
        Bmad type: real
    omega : float
        Bmad type: real
    """

    h: float = pydantic.Field(
        default=0.0,
    )
    omega: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
