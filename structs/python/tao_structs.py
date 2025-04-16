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
    AllPointerStruct,
    NamedNumberStruct,
    QpAxisStruct,
    QpLegendStruct,
    QpLineStruct,
    QpPointStruct,
    QpRectStruct,
    QpSymbolStruct,
)
from .bmad_structs import (
    ApertureParamStruct,
    ApertureScanStruct,
    BeamInitStruct,
    BeamStruct,
    BmadNormalFormStruct,
    BunchParamsStruct,
    BunchTrackStruct,
    CoordStruct,
    ElePointerStruct,
    EleStruct,
    LatEleOrderStruct,
    LatStruct,
    NormalModesStruct,
    PtcNormalFormStruct,
    RadIntAllEleStruct,
    SpinAxisStruct,
    SpinOrbitMap1Struct,
    SummationRdtStruct,
)

Complex = Annotated[
    complex,
    PlainValidator(
        lambda x: x if isinstance(x, complex) else complex(x.get("real", x.get("imag")))
    ),
    PlainSerializer(lambda x: {"real": x.real, "imag": x.imag}, return_type=dict),
]


class TaoCInterfaceCommonStruct(pydantic.BaseModel):
    """
    TaoCInterfaceCommonStruct corresponds to bmad `tao_c_interface_common_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_c_interface_mod.f90 on line 16.

    Attributes
    ----------
    c_integer : int
        Bmad type: integer
    c_line : str
        Bmad type: character
    c_real : float
        Bmad type: real
    n_int : int
        Bmad type: integer
        Fortran default: 0
    n_real : int
        Bmad type: integer
        Fortran default: 0
    """

    c_integer: Sequence[int] = pydantic.Field(
        default=0,
    )
    c_line: Sequence[str] = pydantic.Field(
        default="",
    )
    c_real: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    n_int: int = pydantic.Field(
        default=0,
    )
    n_real: int = pydantic.Field(
        default=0,
    )


class ExpressionFuncStruct(pydantic.BaseModel):
    """
    ExpressionFuncStruct corresponds to bmad `expression_func_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_evaluate_expression.f90 on line 54.

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


class OldTaoEleShapeStruct(pydantic.BaseModel):
    """
    OldTaoEleShapeStruct corresponds to bmad `old_tao_ele_shape_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_init_plotting.f90 on line 23.

    Attributes
    ----------
    color : str
        plot color
        Bmad type: character
    draw_name : bool
        Bmad type: Logical
        Fortran default: .true.
    ele_name : str
        element name
        Bmad type: character
    key : int
        Element key index to match to
        Bmad type: integer
    key_name : str
        Element key name
        Bmad type: character
    shape : str
        plot shape
        Bmad type: character
    size : float
        plot vertical height
        Bmad type: real
    """

    color: str = pydantic.Field(
        default_factory=list,
        max_length=16,
        description="plot color",
    )
    draw_name: bool = pydantic.Field(
        default=True,
    )
    ele_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="element name",
    )
    key: int = pydantic.Field(
        default=0,
        description="Element key index to match to",
    )
    key_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="Element key name",
    )
    shape: str = pydantic.Field(
        default_factory=list,
        max_length=16,
        description="plot shape",
    )
    size: float = pydantic.Field(
        default=0.0,
        description="plot vertical height",
    )


class TaoCurveInput(pydantic.BaseModel):
    """
    TaoCurveInput corresponds to bmad `tao_curve_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 79.

    Attributes
    ----------
    autoscale_z_color : bool
        Deprecated. Use c%z_color%...
        Bmad type: logical
        Fortran default: .true.
    component : str
        Bmad type: character
        Fortran default: ''
    data_index : str
        Bmad type: character
        Fortran default: ''
    data_source : str
        Bmad type: character
        Fortran default: ''
    data_type : str
        Bmad type: character
        Fortran default: ''
    data_type_x : str
        Bmad type: character
        Fortran default: ''
    data_type_z : str
        Deprecated. Use c%z_color%...
        Bmad type: character
        Fortran default: ''
    draw_error_bars : bool
        Bmad type: logical
        Fortran default: .false.
    draw_line : bool
        Bmad type: logical
        Fortran default: .true.
    draw_symbol_index : bool
        Bmad type: logical
        Fortran default: .false.
    draw_symbols : bool
        Bmad type: logical
        Fortran default: .true.
    ele_ref_name : str
        Bmad type: character
        Fortran default: ''
    hist : TaoHistogramStruct
        Bmad type: tao_histogram_struct
        Fortran default: tao_histogram_struct()
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    ix_bunch : int
        Bmad type: integer
        Fortran default: 0
    ix_universe : int
        Bmad type: integer
        Fortran default: -1
    legend_text : str
        Bmad type: character
        Fortran default: ''
    line : QpLineStruct
        Bmad type: qp_line_struct
        Fortran default: qp_line_struct()
    n_turn : int
        Bmad type: integer
        Fortran default: -1
    name : str
        Bmad type: character
        Fortran default: ''
    orbit : TaoCurveOrbitStruct
        Bmad type: tao_curve_orbit_struct
        Fortran default: tao_curve_orbit_struct()
    smooth_line_calc : bool
        Bmad type: logical
        Fortran default: .true.
    symbol : QpSymbolStruct
        Bmad type: qp_symbol_struct
        Fortran default: qp_symbol_struct()
    symbol_every : int
        Bmad type: integer
        Fortran default: 1
    units : str
        Unused.
        Bmad type: character
        Fortran default: ''
    use_y2 : bool
        Bmad type: logical
        Fortran default: .false.
    use_z_color : bool
        Deprecated. Use c%z_color%...
        Bmad type: logical
        Fortran default: .false.
    y_axis_scale_factor : float
        Bmad type: real
        Fortran default: 1
    z_color : TaoCurveColorStruct
        Bmad type: tao_curve_color_struct
        Fortran default: tao_curve_color_struct()
    z_color0 : float
        Deprecated. Use c%z_color%...
        Bmad type: real
        Fortran default: invalid$
    z_color1 : float
        Deprecated. Use c%z_color%...
        Bmad type: real
        Fortran default: invalid$
    """

    autoscale_z_color: bool = pydantic.Field(
        default=True,
        description="Deprecated. Use c%z_color%...",
    )
    component: str = pydantic.Field(
        default="",
        max_length=60,
    )
    data_index: str = pydantic.Field(
        default="",
        max_length=100,
    )
    data_source: str = pydantic.Field(
        default="",
        max_length=40,
    )
    data_type: str = pydantic.Field(
        default="",
        max_length=200,
    )
    data_type_x: str = pydantic.Field(
        default="",
        max_length=100,
    )
    data_type_z: str = pydantic.Field(
        default="",
        max_length=100,
        description="Deprecated. Use c%z_color%...",
    )
    draw_error_bars: bool = pydantic.Field(
        default=False,
    )
    draw_line: bool = pydantic.Field(
        default=True,
    )
    draw_symbol_index: bool = pydantic.Field(
        default=False,
    )
    draw_symbols: bool = pydantic.Field(
        default=True,
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    hist: TaoHistogramStruct = pydantic.Field(
        default=None,
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_bunch: int = pydantic.Field(
        default=0,
    )
    ix_universe: int = pydantic.Field(
        default=-1,
    )
    legend_text: str = pydantic.Field(
        default="",
        max_length=40,
    )
    line: QpLineStruct = pydantic.Field(
        default=None,
    )
    n_turn: int = pydantic.Field(
        default=-1,
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    orbit: TaoCurveOrbitStruct = pydantic.Field(
        default=None,
    )
    smooth_line_calc: bool = pydantic.Field(
        default=True,
    )
    symbol: QpSymbolStruct = pydantic.Field(
        default=None,
    )
    symbol_every: int = pydantic.Field(
        default=1,
    )
    units: str = pydantic.Field(
        default="",
        max_length=40,
        description="Unused.",
    )
    use_y2: bool = pydantic.Field(
        default=False,
    )
    use_z_color: bool = pydantic.Field(
        default=False,
        description="Deprecated. Use c%z_color%...",
    )
    y_axis_scale_factor: float = pydantic.Field(
        default=1,
    )
    z_color: TaoCurveColorStruct = pydantic.Field(
        default=None,
    )
    z_color0: float = pydantic.Field(
        default=0.0,
        description="Deprecated. Use c%z_color%...",
    )
    z_color1: float = pydantic.Field(
        default=0.0,
        description="Deprecated. Use c%z_color%...",
    )


class TaoD1DataInput(pydantic.BaseModel):
    """
    TaoD1DataInput corresponds to bmad `tao_d1_data_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 21.

    Attributes
    ----------
    name : str
        type of data
        Bmad type: character
        Fortran default: ''
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="type of data",
    )


class TaoD2DataInput(pydantic.BaseModel):
    """
    TaoD2DataInput corresponds to bmad `tao_d2_data_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 17.

    Attributes
    ----------
    name : str
        name of data
        Bmad type: character
        Fortran default: ''
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="name of data",
    )


class TaoDatumInput(pydantic.BaseModel):
    """
    TaoDatumInput corresponds to bmad `tao_datum_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 25.

    Attributes
    ----------
    data_source : str
        Bmad type: character
        Fortran default: ''
    data_type : str
        long due to expressions.
        Bmad type: character
        Fortran default: ''
    ele_name : str
        Bmad type: character
        Fortran default: ''
    ele_ref_name : str
        Bmad type: character
        Fortran default: ''
    ele_start_name : str
        Bmad type: character
        Fortran default: ''
    error_rms : float
        Bmad type: real
        Fortran default: 0
    eval_point : str
        Bmad type: character
        Fortran default: 'end'
    good_opt : bool
        Bmad type: logical
        Fortran default: .true.
    good_user : bool
        Bmad type: logical
        Fortran default: .true.
    invalid_value : float
        Bmad type: real
        Fortran default: 0
    ix_bunch : int
        Bmad type: integer
        Fortran default: 0
    meas : float
        used to tag when %meas_value is set in file
        Bmad type: real
        Fortran default: real_garbage$
    merit_type : str
        Bmad type: character
        Fortran default: ''
    s_offset : float
        Bmad type: real
        Fortran default: 0
    spin_axis : SpinAxisStruct
        Bmad type: spin_axis_struct
        Fortran default: spin_axis_struct()
    weight : float
        Bmad type: real
        Fortran default: real_garbage$
    """

    data_source: str = pydantic.Field(
        default="",
        max_length=20,
    )
    data_type: str = pydantic.Field(
        default="",
        max_length=600,
        description="long due to expressions.",
    )
    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ele_start_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    error_rms: float = pydantic.Field(
        default=0,
    )
    eval_point: str = pydantic.Field(
        default="end",
        max_length=20,
    )
    good_opt: bool = pydantic.Field(
        default=True,
    )
    good_user: bool = pydantic.Field(
        default=True,
    )
    invalid_value: float = pydantic.Field(
        default=0,
    )
    ix_bunch: int = pydantic.Field(
        default=0,
    )
    meas: float = pydantic.Field(
        default=0.0,
        description="used to tag when %meas_value is set in file",
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=20,
    )
    s_offset: float = pydantic.Field(
        default=0,
    )
    spin_axis: SpinAxisStruct = pydantic.Field(
        default=None,
    )
    weight: float = pydantic.Field(
        default=0.0,
    )


class TaoDesignLatInput(pydantic.BaseModel):
    """
    TaoDesignLatInput corresponds to bmad `tao_design_lat_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 167.

    Attributes
    ----------
    dynamic_aperture_calc : bool
        Bmad type: logical
        Fortran default: .false.
    file : str
        Bmad type: character
        Fortran default: ''
    file2 : str
        Bmad type: character
        Fortran default: ''
    language : str
        Bmad type: character
        Fortran default: ''
    one_turn_map_calc : bool
        Bmad type: logical
        Fortran default: .false.
    reverse_lattice : bool
        Bmad type: logical
        Fortran default: .false.
    slice_lattice : str
        Bmad type: character
        Fortran default: ''
    start_branch_at : str
        Bmad type: character
        Fortran default: ''
    use_element_range : str
        Bmad type: character
        Fortran default: ''
    use_line : str
        Bmad type: character
        Fortran default: ''
    """

    dynamic_aperture_calc: bool = pydantic.Field(
        default=False,
    )
    file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    file2: str = pydantic.Field(
        default="",
        max_length=400,
    )
    language: str = pydantic.Field(
        default="",
        max_length=16,
    )
    one_turn_map_calc: bool = pydantic.Field(
        default=False,
    )
    reverse_lattice: bool = pydantic.Field(
        default=False,
    )
    slice_lattice: str = pydantic.Field(
        default="",
        max_length=80,
    )
    start_branch_at: str = pydantic.Field(
        default="",
        max_length=40,
    )
    use_element_range: Sequence[str] = pydantic.Field(
        default="",
        max_length=2,
    )
    use_line: str = pydantic.Field(
        default="",
        max_length=40,
    )


class TaoEleShapeInput(pydantic.BaseModel):
    """
    TaoEleShapeInput corresponds to bmad `tao_ele_shape_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 217.

    Attributes
    ----------
    color : str
        Color of shape
        Bmad type: character
        Fortran default: 'black'
    draw : bool
        Draw the shape?
        Bmad type: logical
        Fortran default: .true.
    ele_id : str
        element "key::name" to match to.
        Bmad type: character
        Fortran default: ''
    label : str
        Can be: 'name', 's', 'none'
        Bmad type: character
        Fortran default: 'name'
    line_width : int
        Width of lines used to draw the shape.
        Bmad type: integer
        Fortran default: 1
    multi : bool
        Can be part of a multi-shape.
        Bmad type: logical
        Fortran default: .false.
    offset : float
        Vertical offset.
        Bmad type: real
        Fortran default: 0
    shape : str
        Shape to draw
        Bmad type: character
        Fortran default: ''
    size : float
        plot vertical height
        Bmad type: real
        Fortran default: 0
    """

    color: str = pydantic.Field(
        default="black",
        max_length=16,
        description="Color of shape",
    )
    draw: bool = pydantic.Field(
        default=True,
        description="Draw the shape?",
    )
    ele_id: str = pydantic.Field(
        default="",
        max_length=60,
        description="element 'key::name' to match to.",
    )
    label: str = pydantic.Field(
        default="name",
        max_length=16,
        description="Can be: 'name', 's', 'none'",
    )
    line_width: int = pydantic.Field(
        default=1,
        description="Width of lines used to draw the shape.",
    )
    multi: bool = pydantic.Field(
        default=False,
        description="Can be part of a multi-shape.",
    )
    offset: float = pydantic.Field(
        default=0,
        description="Vertical offset.",
    )
    shape: str = pydantic.Field(
        default="",
        max_length=40,
        description="Shape to draw",
    )
    size: float = pydantic.Field(
        default=0,
        description="plot vertical height",
    )


class TaoGraphInput(pydantic.BaseModel):
    """
    TaoGraphInput corresponds to bmad `tao_graph_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 112.

    Attributes
    ----------
    allow_wrap_around : bool
        Bmad type: logical
        Fortran default: .true.
    box : int
        Bmad type: integer
        Fortran default: [1, 1, 1, 1]
    clip : bool
        Bmad type: logical
        Fortran default: .true.
    component : str
        Bmad type: character
        Fortran default: ''
    correct_xy_distortion : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .true.
    curve_legend : QpLegendStruct
        Bmad type: qp_legend_struct
        Fortran default: qp_legend_struct(1.0_rp, 30.0_rp, 6.0_rp, .true., .true., .true.)
    curve_legend_origin : QpPointStruct
        Bmad type: qp_point_struct
        Fortran default: qp_point_struct(5.0_rp, -2.0_rp, 'POINTS/GRAPH/LT')
    draw_axes : bool
        Bmad type: logical
        Fortran default: .true.
    draw_curve_legend : bool
        Bmad type: logical
        Fortran default: .true.
    draw_grid : bool
        Bmad type: logical
        Fortran default: .true.
    draw_only_good_user_data_or_vars : bool
        Bmad type: logical
        Fortran default: .true.
    draw_title : bool
        Bmad type: logical
        Fortran default: .true.
    floor_plan : TaoFloorPlanStruct
        Bmad type: tao_floor_plan_struct
        Fortran default: tao_floor_plan_struct()
    floor_plan_draw_only_first_pass : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .false.
    floor_plan_flip_label_side : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .false.
    floor_plan_orbit_color : str
        deprecated. Use g%floor_plan%...
        Bmad type: character
        Fortran default: ''
    floor_plan_orbit_scale : float
        deprecated. Use g%floor_plan%...
        Bmad type: real
        Fortran default: -1
    floor_plan_rotation : float
        deprecated. Use g%floor_plan%...
        Bmad type: real
        Fortran default: real_garbage$
    floor_plan_size_is_absolute : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .false.
    floor_plan_view : str
        deprecated. Use g%floor_plan%...
        Bmad type: character
        Fortran default: ''
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    ix_universe : int
        Bmad type: integer
        Fortran default: -1
    margin : QpRectStruct
        Bmad type: qp_rect_struct
        Fortran default: qp_rect_struct(0.0_rp, 0.0_rp, 0.0_rp, 0.0_rp, '%GRAPH')
    n_curve : int
        Bmad type: integer
        Fortran default: -1
    name : str
        Bmad type: character
        Fortran default: ''
    scale_margin : QpRectStruct
        Bmad type: qp_rect_struct
        Fortran default: qp_rect_struct(0.0_rp, 0.0_rp, 0.0_rp, 0.0_rp, '%GRAPH')
    symbol_size_scale : float
        Bmad type: real
        Fortran default: 0
    text_legend : str
        Bmad type: character
        Fortran default: ''
    text_legend_origin : QpPointStruct
        Bmad type: qp_point_struct
        Fortran default: qp_point_struct(5.0_rp, 0.0_rp, 'POINTS/GRAPH/RT')
    title : str
        Bmad type: character
        Fortran default: ''
    type : str
        Bmad type: character
        Fortran default: 'data'
    x : QpAxisStruct
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    x2 : QpAxisStruct
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    x_axis_scale_factor : float
        Bmad type: real
        Fortran default: 1
    y : QpAxisStruct
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    y2 : QpAxisStruct
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    """

    allow_wrap_around: bool = pydantic.Field(
        default=True,
    )
    box: Sequence[int] = pydantic.Field(
        default=[1, 1, 1, 1],
        max_length=4,
    )
    clip: bool = pydantic.Field(
        default=True,
    )
    component: str = pydantic.Field(
        default="",
        max_length=60,
    )
    correct_xy_distortion: bool = pydantic.Field(
        default=True,
        description="deprecated. Use g%floor_plan%...",
    )
    curve_legend: QpLegendStruct = pydantic.Field(
        default=None,
    )
    curve_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    draw_axes: bool = pydantic.Field(
        default=True,
    )
    draw_curve_legend: bool = pydantic.Field(
        default=True,
    )
    draw_grid: bool = pydantic.Field(
        default=True,
    )
    draw_only_good_user_data_or_vars: bool = pydantic.Field(
        default=True,
    )
    draw_title: bool = pydantic.Field(
        default=True,
    )
    floor_plan: TaoFloorPlanStruct = pydantic.Field(
        default=None,
    )
    floor_plan_draw_only_first_pass: bool = pydantic.Field(
        default=False,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_flip_label_side: bool = pydantic.Field(
        default=False,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_orbit_color: str = pydantic.Field(
        default="",
        max_length=16,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_orbit_scale: float = pydantic.Field(
        default=-1,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_rotation: float = pydantic.Field(
        default=0.0,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_size_is_absolute: bool = pydantic.Field(
        default=False,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_view: str = pydantic.Field(
        default="",
        max_length=2,
        description="deprecated. Use g%floor_plan%...",
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_universe: int = pydantic.Field(
        default=-1,
    )
    margin: QpRectStruct = pydantic.Field(
        default=None,
    )
    n_curve: int = pydantic.Field(
        default=-1,
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    scale_margin: QpRectStruct = pydantic.Field(
        default=None,
    )
    symbol_size_scale: float = pydantic.Field(
        default=0,
    )
    text_legend: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
    )
    text_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    title: str = pydantic.Field(
        default="",
        max_length=80,
    )
    type: str = pydantic.Field(
        default="data",
        max_length=40,
    )
    x: QpAxisStruct = pydantic.Field(
        default=None,
    )
    x2: QpAxisStruct = pydantic.Field(
        default=None,
    )
    x_axis_scale_factor: float = pydantic.Field(
        default=1,
    )
    y: QpAxisStruct = pydantic.Field(
        default=None,
    )
    y2: QpAxisStruct = pydantic.Field(
        default=None,
    )


class TaoKeyInput(pydantic.BaseModel):
    """
    TaoKeyInput corresponds to bmad `tao_key_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 180.

    Attributes
    ----------
    attrib_name : str
        Bmad type: character
    delta : float
        Bmad type: real
    ele_name : str
        Bmad type: character
    good_opt : bool
        Bmad type: logical
    high_lim : float
        Bmad type: real
    low_lim : float
        Bmad type: real
    merit_type : str
        Bmad type: character
    small_step : float
        Bmad type: real
    universe : str
        Bmad type: character
    weight : float
        Bmad type: real
    """

    attrib_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    delta: float = pydantic.Field(
        default=0.0,
    )
    ele_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    good_opt: bool = pydantic.Field(
        default=False,
    )
    high_lim: float = pydantic.Field(
        default=0.0,
    )
    low_lim: float = pydantic.Field(
        default=0.0,
    )
    merit_type: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    small_step: float = pydantic.Field(
        default=0.0,
    )
    universe: str = pydantic.Field(
        default_factory=list,
        max_length=16,
    )
    weight: float = pydantic.Field(
        default=0.0,
    )


class TaoPlaceInput(pydantic.BaseModel):
    """
    TaoPlaceInput corresponds to bmad `tao_place_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 74.

    Attributes
    ----------
    plot : str
        Bmad type: character
        Fortran default: ''
    region : str
        Bmad type: character
        Fortran default: ''
    """

    plot: str = pydantic.Field(
        default="",
        max_length=40,
    )
    region: str = pydantic.Field(
        default="",
        max_length=40,
    )


class TaoPlotInput(pydantic.BaseModel):
    """
    TaoPlotInput corresponds to bmad `tao_plot_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 151.

    Attributes
    ----------
    autoscale_gang_x : bool
        scale cmd scales graphs independently?
        Bmad type: logical
    autoscale_gang_y : bool
        scale cmd scales graphs independently?
        Bmad type: logical
    autoscale_x : bool
        Bmad type: logical
    autoscale_y : bool
        Bmad type: logical
    description : str
        Bmad type: character
    n_curve_pts : int
        Bmad type: integer
    n_graph : int
        Bmad type: integer
    name : str
        Bmad type: character
    x : QpAxisStruct
        Bmad type: qp_axis_struct
    x_axis_type : str
        Bmad type: character
    """

    autoscale_gang_x: bool = pydantic.Field(
        default=False,
        description="scale cmd scales graphs independently?",
    )
    autoscale_gang_y: bool = pydantic.Field(
        default=False,
        description="scale cmd scales graphs independently?",
    )
    autoscale_x: bool = pydantic.Field(
        default=False,
    )
    autoscale_y: bool = pydantic.Field(
        default=False,
    )
    description: str = pydantic.Field(
        default_factory=list,
        max_length=60,
    )
    n_curve_pts: int = pydantic.Field(
        default=0,
    )
    n_graph: int = pydantic.Field(
        default=0,
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    x: QpAxisStruct = pydantic.Field(
        default=None,
    )
    x_axis_type: str = pydantic.Field(
        default_factory=list,
        max_length=16,
    )


class TaoPlotPageInput(pydantic.BaseModel):
    """
    TaoPlotPageInput corresponds to bmad `tao_plot_page_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 193.

    Attributes
    ----------
    axis_label_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.0
    axis_number_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    border : QpRectStruct
        Border around plots edge of page.
        Bmad type: qp_rect_struct
        Fortran default: qp_rect_struct()
    curve_legend_line_len : float
        OLD STYLE. Points.
        Bmad type: real
        Fortran default: real_garbage$
    curve_legend_text_offset : float
        OLD STYLE. Points.
        Bmad type: real
        Fortran default: real_garbage$
    delete_overlapping_plots : bool
        Delete overlapping plots when a plot is placed?
        Bmad type: logical
        Fortran default: .true.
    draw_graph_title_suffix : bool
        Bmad type: logical
        Fortran default: .true.
    floor_plan_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    floor_plan_text_scale : float
        Scale used = floor_plan_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    graph_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.1
    key_table_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    lat_layout_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    lat_layout_text_scale : float
        Scale used = lat_layout_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    legend_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    main_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.3
    n_curve_pts : int
        Number of points for plotting a smooth curve
        Bmad type: integer
        Fortran default: n_curve_pts_init$
    plot_display_type : str
        Bmad type: character
        Fortran default: ''
    size : float
        width and height of window in pixels.
        Bmad type: real
        Fortran default: 0.0
    subtitle : TaoTitleStruct
        Subtitle at top of page.
        Bmad type: tao_title_struct
        Fortran default: tao_title_struct()
    text_height : float
        In points. Scales the height of all text
        Bmad type: real
        Fortran default: 12
    title : TaoTitleStruct
        Title  at top of page.
        Bmad type: tao_title_struct
        Fortran default: tao_title_struct()
    """

    axis_label_text_scale: float = pydantic.Field(
        default=1.0,
        description="Relative to text_height",
    )
    axis_number_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    border: QpRectStruct = pydantic.Field(
        default=None,
        description="Border around plots edge of page.",
    )
    curve_legend_line_len: float = pydantic.Field(
        default=0.0,
        description="OLD STYLE. Points.",
    )
    curve_legend_text_offset: float = pydantic.Field(
        default=0.0,
        description="OLD STYLE. Points.",
    )
    delete_overlapping_plots: bool = pydantic.Field(
        default=True,
        description="Delete overlapping plots when a plot is placed?",
    )
    draw_graph_title_suffix: bool = pydantic.Field(
        default=True,
    )
    floor_plan_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    floor_plan_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = floor_plan_text_scale * legend_text_scale",
    )
    graph_title_text_scale: float = pydantic.Field(
        default=1.1,
        description="Relative to text_height",
    )
    key_table_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    lat_layout_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    lat_layout_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = lat_layout_text_scale * legend_text_scale",
    )
    legend_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    main_title_text_scale: float = pydantic.Field(
        default=1.3,
        description="Relative to text_height",
    )
    n_curve_pts: int = pydantic.Field(
        default=0,
        description="Number of points for plotting a smooth curve",
    )
    plot_display_type: str = pydantic.Field(
        default="",
        max_length=8,
    )
    size: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=2,
        description="width and height of window in pixels.",
    )
    subtitle: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Subtitle at top of page.",
    )
    text_height: float = pydantic.Field(
        default=12,
        description="In points. Scales the height of all text",
    )
    title: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Title  at top of page.",
    )


class TaoRegionInput(pydantic.BaseModel):
    """
    TaoRegionInput corresponds to bmad `tao_region_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 69.

    Attributes
    ----------
    location : float
        location on page.
        Bmad type: real
        Fortran default: 0
    name : str
        Eg: 'top', 'bottom'.
        Bmad type: character
        Fortran default: ''
    """

    location: Sequence[float] = pydantic.Field(
        default=0,
        max_length=4,
        description="location on page.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Eg: 'top', 'bottom'.",
    )


class TaoV1VarInput(pydantic.BaseModel):
    """
    TaoV1VarInput corresponds to bmad `tao_v1_var_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 47.

    Attributes
    ----------
    name : str
        name of variable
        Bmad type: character
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="name of variable",
    )


class TaoVarInput(pydantic.BaseModel):
    """
    TaoVarInput corresponds to bmad `tao_var_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 51.

    Attributes
    ----------
    attribute : str
        attribute to vary
        Bmad type: character
        Fortran default: ''
    ele_name : str
        Bmad type: character
        Fortran default: ''
    good_user : bool
        Bmad type: logical
        Fortran default: .true.
    high_lim : float
        Bmad type: real
        Fortran default: 1e30
    key_bound : bool
        Bmad type: logical
        Fortran default: .false.
    key_delta : float
        Bmad type: real
        Fortran default: 0
    low_lim : float
        Bmad type: real
        Fortran default: -1e30
    meas : float
        Bmad type: real
        Fortran default: real_garbage$
    merit_type : str
        Bmad type: character
        Fortran default: ''
    step : float
        Bmad type: real
        Fortran default: 0
    universe : str
        Bmad type: character
        Fortran default: ''
    weight : float
        Bmad type: real
        Fortran default: real_garbage$
    """

    attribute: str = pydantic.Field(
        default="",
        max_length=40,
        description="attribute to vary",
    )
    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    good_user: bool = pydantic.Field(
        default=True,
        max_length=4,
    )
    high_lim: float = pydantic.Field(
        default=1e30,
    )
    key_bound: bool = pydantic.Field(
        default=False,
        max_length=4,
    )
    key_delta: float = pydantic.Field(
        default=0,
    )
    low_lim: float = pydantic.Field(
        default=-1e30,
    )
    meas: float = pydantic.Field(
        default=0.0,
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=40,
    )
    step: float = pydantic.Field(
        default=0,
    )
    universe: str = pydantic.Field(
        default="",
        max_length=16,
    )
    weight: float = pydantic.Field(
        default=0.0,
    )


class OldShowLatColumnStruct(pydantic.BaseModel):
    """
    OldShowLatColumnStruct corresponds to bmad `old_show_lat_column_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_show_this.f90 on line 110.

    Attributes
    ----------
    format : str
        Bmad type: character
        Fortran default: ''
    label : str
        Bmad type: character
        Fortran default: ''
    name : str
        Bmad type: character
        Fortran default: ''
    remove_line_if_zero : bool
        Bmad type: logical
        Fortran default: .false.
    scale_factor : float
        Bmad type: real
        Fortran default: 1
    width : int
        Bmad type: integer
        Fortran default: 0
    """

    format: str = pydantic.Field(
        default="",
        max_length=40,
    )
    label: str = pydantic.Field(
        default="",
        max_length=40,
    )
    name: str = pydantic.Field(
        default="",
        max_length=80,
    )
    remove_line_if_zero: bool = pydantic.Field(
        default=False,
    )
    scale_factor: float = pydantic.Field(
        default=1,
    )
    width: int = pydantic.Field(
        default=0,
    )


class ShowLatColumnInfoStruct(pydantic.BaseModel):
    """
    ShowLatColumnInfoStruct corresponds to bmad `show_lat_column_info_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_show_this.f90 on line 128.

    Attributes
    ----------
    attrib_name : str
        Is Upper case
        Bmad type: character
        Fortran default: ''
    attrib_type : int
        Bmad type: integer
        Fortran default: -1
    indent : int
        Spacing from start of line to beginning of column.
        Bmad type: integer
        Fortran default: 0
    int_s : float
        Bmad type: real
        Fortran default: 0
    int_sum : float
        Bmad type: real
        Fortran default: 0
    int_sum2 : float
        Bmad type: real
        Fortran default: 0
    n_sum : int
        Bmad type: integer
        Fortran default: 0
    sum : float
        Bmad type: real
        Fortran default: 0
    sum2 : float
        Bmad type: real
        Fortran default: 0
    val_last : float
        Bmad type: real
        Fortran default: real_garbage$
    """

    attrib_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Is Upper case",
    )
    attrib_type: int = pydantic.Field(
        default=-1,
    )
    indent: int = pydantic.Field(
        default=0,
        description="Spacing from start of line to beginning of column.",
    )
    int_s: float = pydantic.Field(
        default=0,
    )
    int_sum: float = pydantic.Field(
        default=0,
    )
    int_sum2: float = pydantic.Field(
        default=0,
    )
    n_sum: int = pydantic.Field(
        default=0,
    )
    sum: float = pydantic.Field(
        default=0,
    )
    sum2: float = pydantic.Field(
        default=0,
    )
    val_last: float = pydantic.Field(
        default=0.0,
    )


class ShowLatColumnStruct(pydantic.BaseModel):
    """
    ShowLatColumnStruct corresponds to bmad `show_lat_column_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_show_this.f90 on line 119.

    Attributes
    ----------
    format : str
        Bmad type: character
        Fortran default: ''
    label : str
        Bmad type: character
        Fortran default: ''
    name : str
        Bmad type: character
        Fortran default: ''
    remove_line_if_zero : bool
        Bmad type: logical
        Fortran default: .false.
    scale_factor : float
        Bmad type: real
        Fortran default: 1
    width : int
        Bmad type: integer
        Fortran default: 0
    """

    format: str = pydantic.Field(
        default="",
        max_length=40,
    )
    label: str = pydantic.Field(
        default="",
        max_length=40,
    )
    name: str = pydantic.Field(
        default="",
        max_length=80,
    )
    remove_line_if_zero: bool = pydantic.Field(
        default=False,
    )
    scale_factor: float = pydantic.Field(
        default=1,
    )
    width: int = pydantic.Field(
        default=0,
    )


class DoLoopStruct(pydantic.BaseModel):
    """
    DoLoopStruct corresponds to bmad `do_loop_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 728.

    Attributes
    ----------
    end : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    index : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    n_line_end : int
        lines in each nested loop
        Bmad type: integer
        Fortran default: 0
    n_line_start : int
        lines in each nested loop
        Bmad type: integer
        Fortran default: 0
    name : str
        do loop index name
        Bmad type: character
        Fortran default: ''
    start : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    step : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    value : int
        Bmad type: integer
        Fortran default: int_garbage$
    """

    end: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    index: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    n_line_end: int = pydantic.Field(
        default=0,
        description="lines in each nested loop",
    )
    n_line_start: int = pydantic.Field(
        default=0,
        description="lines in each nested loop",
    )
    name: str = pydantic.Field(
        default="",
        max_length=20,
        description="do loop index name",
    )
    start: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    step: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    value: int = pydantic.Field(
        default=0,
    )


class TaoAliasStruct(pydantic.BaseModel):
    """
    TaoAliasStruct corresponds to bmad `tao_alias_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 710.

    Attributes
    ----------
    expanded_str : str
        Bmad type: character
        Fortran default: ''
    name : str
        Bmad type: character
        Fortran default: ''
    """

    expanded_str: str = pydantic.Field(
        default="",
        max_length=200,
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
    )


class TaoBeamBranchStruct(pydantic.BaseModel):
    """
    TaoBeamBranchStruct corresponds to bmad `tao_beam_branch_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 985.

    Attributes
    ----------
    beam_at_start : BeamStruct
        Initial beam
        Bmad type: beam_struct
    beam_init : BeamInitStruct
        User set beam distrubution at track start.
        Bmad type: beam_init_struct
    beam_init_used : BeamInitStruct
        beam distribution with emit values set.
        Bmad type: beam_init_struct
    init_starting_distribution : bool
        Init beam
        Bmad type: logical
        Fortran default: .true.
    ix_branch : int
        Branch tracked. If track_start or track_end is a lord, ix_track_start/end index
        will be a index of slave.
        Bmad type: integer
        Fortran default: 0
    ix_track_end : int
        Element track end index
        Bmad type: integer
        Fortran default: not_set$
    ix_track_start : int
        Element track start index.
        Bmad type: integer
        Fortran default: not_set$
    track_end : str
        Bmad type: character
        Fortran default: ''
    track_start : str
        Tracking start element.
        Bmad type: character
        Fortran default: ''
    """

    beam_at_start: BeamStruct = pydantic.Field(
        default=None,
        description="Initial beam",
    )
    beam_init: BeamInitStruct = pydantic.Field(
        default=None,
        description="User set beam distrubution at track start.",
    )
    beam_init_used: BeamInitStruct = pydantic.Field(
        default=None,
        description="beam distribution with emit values set.",
    )
    init_starting_distribution: bool = pydantic.Field(
        default=True,
        description="Init beam",
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description=(
            "Branch tracked. If track_start or track_end is a lord, ix_track_start/end "
            "index will be a index of slave."
        ),
    )
    ix_track_end: int = pydantic.Field(
        default=0,
        description="Element track end index",
    )
    ix_track_start: int = pydantic.Field(
        default=0,
        description="Element track start index.",
    )
    track_end: str = pydantic.Field(
        default="",
        max_length=40,
    )
    track_start: str = pydantic.Field(
        default="",
        max_length=40,
        description="Tracking start element.",
    )


class TaoBeamShakeStruct(pydantic.BaseModel):
    """
    TaoBeamShakeStruct corresponds to bmad `tao_beam_shake_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 838.

    Attributes
    ----------
    amp_a : float
        Bmad type: real
    amp_b : float
        Bmad type: real
    amp_calc_done : bool
        Bmad type: logical
        Fortran default: .false.
    amp_na : float
        Bmad type: real
    amp_nb : float
        Bmad type: real
    cbar : float
        Bmad type: real
    coupling_calc_done : bool
        Bmad type: logical
        Fortran default: .false.
    k_11a : float
        Bmad type: real
    k_12a : float
        Bmad type: real
    k_12b : float
        Bmad type: real
    k_22b : float
        Bmad type: real
    one : float
        Bmad type: real
        Fortran default: 1.0
    """

    amp_a: float = pydantic.Field(
        default=0.0,
    )
    amp_b: float = pydantic.Field(
        default=0.0,
    )
    amp_calc_done: bool = pydantic.Field(
        default=False,
    )
    amp_na: float = pydantic.Field(
        default=0.0,
    )
    amp_nb: float = pydantic.Field(
        default=0.0,
    )
    cbar: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    coupling_calc_done: bool = pydantic.Field(
        default=False,
    )
    k_11a: float = pydantic.Field(
        default=0.0,
    )
    k_12a: float = pydantic.Field(
        default=0.0,
    )
    k_12b: float = pydantic.Field(
        default=0.0,
    )
    k_22b: float = pydantic.Field(
        default=0.0,
    )
    one: float = pydantic.Field(
        default=1.0,
    )


class TaoBeamUniStruct(pydantic.BaseModel):
    """
    TaoBeamUniStruct corresponds to bmad `tao_beam_uni_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1007.

    Attributes
    ----------
    always_reinit : bool
        Bmad type: logical
        Fortran default: .false.
    dump_at : str
        Bmad type: character
        Fortran default: ''
    dump_file : str
        Bmad type: character
        Fortran default: ''
    saved_at : str
        Bmad type: character
        Fortran default: ''
    track_beam_in_universe : bool
        Beam tracking enabled in this universe?
        Bmad type: logical
        Fortran default: .false.
    """

    always_reinit: bool = pydantic.Field(
        default=False,
    )
    dump_at: str = pydantic.Field(
        default="",
        max_length=200,
    )
    dump_file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    saved_at: str = pydantic.Field(
        default="",
        max_length=200,
    )
    track_beam_in_universe: bool = pydantic.Field(
        default=False,
        description="Beam tracking enabled in this universe?",
    )


class TaoBuildingWallOrientationStruct(pydantic.BaseModel):
    """
    TaoBuildingWallOrientationStruct corresponds to bmad `tao_building_wall_orientation_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 611.

    Attributes
    ----------
    theta : float
        Bmad type: real
        Fortran default: 0
    x_offset : float
        Bmad type: real
        Fortran default: 0
    z_offset : float
        Bmad type: real
        Fortran default: 0
    """

    theta: float = pydantic.Field(
        default=0,
    )
    x_offset: float = pydantic.Field(
        default=0,
    )
    z_offset: float = pydantic.Field(
        default=0,
    )


class TaoBuildingWallPointStruct(pydantic.BaseModel):
    """
    TaoBuildingWallPointStruct corresponds to bmad `tao_building_wall_point_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 617.

    Attributes
    ----------
    radius : float
        Arc radius. +r -> CW rotation, same as bends.
        Bmad type: real
        Fortran default: 0
    x : float
        Global floor position
        Bmad type: real
        Fortran default: 0
    x_center : float
        Arc center.
        Bmad type: real
        Fortran default: 0
    z : float
        Global floor position
        Bmad type: real
        Fortran default: 0
    z_center : float
        Arc center.
        Bmad type: real
        Fortran default: 0
    """

    radius: float = pydantic.Field(
        default=0,
        description="Arc radius. +r -> CW rotation, same as bends.",
    )
    x: float = pydantic.Field(
        default=0,
        description="Global floor position",
    )
    x_center: float = pydantic.Field(
        default=0,
        description="Arc center.",
    )
    z: float = pydantic.Field(
        default=0,
        description="Global floor position",
    )
    z_center: float = pydantic.Field(
        default=0,
        description="Arc center.",
    )


class TaoBuildingWallSectionStruct(pydantic.BaseModel):
    """
    TaoBuildingWallSectionStruct corresponds to bmad `tao_building_wall_section_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 623.

    Attributes
    ----------
    constraint : str
        "left_side" or "right_side" constraint.
        Bmad type: character
        Fortran default: ''
    name : str
        Bmad type: character
        Fortran default: ''
    point : TaoBuildingWallPointStruct
        Bmad type: tao_building_wall_point_struct
    """

    constraint: str = pydantic.Field(
        default="",
        max_length=16,
        description="'left_side' or 'right_side' constraint.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    point: Sequence[TaoBuildingWallPointStruct] = pydantic.Field(
        default=None,
    )


class TaoBuildingWallStruct(pydantic.BaseModel):
    """
    TaoBuildingWallStruct corresponds to bmad `tao_building_wall_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 629.

    Attributes
    ----------
    orientation : TaoBuildingWallOrientationStruct
        Bmad type: tao_building_wall_orientation_struct
        Fortran default: tao_building_wall_orientation_struct()
    section : TaoBuildingWallSectionStruct
        Bmad type: tao_building_wall_section_struct
    """

    orientation: TaoBuildingWallOrientationStruct = pydantic.Field(
        default=None,
    )
    section: Sequence[TaoBuildingWallSectionStruct] = pydantic.Field(
        default=None,
    )


class TaoCmdHistoryStruct(pydantic.BaseModel):
    """
    TaoCmdHistoryStruct corresponds to bmad `tao_cmd_history_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 61.

    Attributes
    ----------
    cmd : str
        The command
        Bmad type: character
    ix : int
        Command index (1st command has ix = 1, etc.)
        Bmad type: integer
        Fortran default: 0
    """

    cmd: str = pydantic.Field(
        default="",
        description="The command",
    )
    ix: int = pydantic.Field(
        default=0,
        description="Command index (1st command has ix = 1, etc.)",
    )


class TaoCommandFileStruct(pydantic.BaseModel):
    """
    TaoCommandFileStruct corresponds to bmad `tao_command_file_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 715.

    Attributes
    ----------
    cmd_arg : str
        Command file arguments.
        Bmad type: character
        Fortran default: ''
    dir : str
        Bmad type: character
        Fortran default: './'
    full_name : str
        Bmad type: character
        Fortran default: ''
    ix_unit : int
        Bmad type: integer
    lattice_calc_save : bool
        Bmad type: logical
        Fortran default: .true.
    n_line : int
        Current line number
        Bmad type: integer
        Fortran default: 0
    paused : bool
        Is the command file paused?
        Bmad type: logical
        Fortran default: .false.
    plot_save : bool
        Bmad type: logical
        Fortran default: .true.
    quiet : str
        Bmad type: character
        Fortran default: 'off'
    reset_at_end : bool
        Reset lattice_calc_on and plot_on at end of file?
        Bmad type: logical
        Fortran default: .true.
    """

    cmd_arg: Sequence[str] = pydantic.Field(
        default="",
        max_length=9,
        description="Command file arguments.",
    )
    dir: str = pydantic.Field(
        default="./",
        max_length=400,
    )
    full_name: str = pydantic.Field(
        default="",
        max_length=400,
    )
    ix_unit: int = pydantic.Field(
        default=0,
    )
    lattice_calc_save: bool = pydantic.Field(
        default=True,
    )
    n_line: int = pydantic.Field(
        default=0,
        description="Current line number",
    )
    paused: bool = pydantic.Field(
        default=False,
        description="Is the command file paused?",
    )
    plot_save: bool = pydantic.Field(
        default=True,
    )
    quiet: str = pydantic.Field(
        default="off",
        max_length=12,
    )
    reset_at_end: bool = pydantic.Field(
        default=True,
        description="Reset lattice_calc_on and plot_on at end of file?",
    )


class TaoCommonStruct(pydantic.BaseModel):
    """
    TaoCommonStruct corresponds to bmad `tao_common_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 740.

    Attributes
    ----------
    add_measurement_noise : bool
        Turn off to take data derivatives.
        Bmad type: logical
        Fortran default: .true.
    alias : TaoAliasStruct
        Bmad type: tao_alias_struct
        Fortran default: tao_alias_struct()
    all_merit_weights_positive : bool
        Bmad type: logical
        Fortran default: .true.
    alpha : float
        Bmad type: real
    cmd : str
        Used for the cmd history
        Bmad type: character
        Fortran default: ''
    cmd_file : TaoCommandFileStruct
        Bmad type: tao_command_file_struct
    cmd_file_level : int
        For nested command files. 0 -> no command file.
        Bmad type: integer
        Fortran default: 0
    cmd_file_paused : bool
        Bmad type: logical
        Fortran default: .false.
    cmd_from_cmd_file : bool
        was command from a command file?
        Bmad type: logical
        Fortran default: .false.
    combine_consecutive_elements_of_like_name : bool
        Bmad type: logical
        Fortran default: .false.
    command_arg_has_been_executed : bool
        Has the -command command line argument been executed?
        Bmad type: logical
        Fortran default: .false.
    covar : float
        Bmad type: real
    do_loop : DoLoopStruct
        Bmad type: do_loop_struct
    dummy_target : float
        Dummy varaible
        Bmad type: real
        Fortran default: 0
    force_chrom_calc : bool
        Used by a routine to force calculation
        Bmad type: logical
        Fortran default: .false.
    force_rad_int_calc : bool
        Used by a routine to force calculation
        Bmad type: logical
        Fortran default: .false.
    have_datums_using_expressions : bool
        Bmad type: logical
        Fortran default: .false.
    have_tracked_beam : bool
        Used to catch error when beam plotting without having tracked a beam.
        Bmad type: logical
        Fortran default: .false.
    init_beam : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    init_plot_needed : bool
        reinitialize plotting?
        Bmad type: logical
        Fortran default: .true.
    init_read_lat_info : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    init_var : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    is_err_message_printed : bool
        Used by tao_set_invalid
        Bmad type: logical
        Fortran default: .false.
    ix_beam_track_active_element : int
        Element being tracked through `tao_beam_track`.
        Bmad type: integer
        Fortran default: -1
    ix_ele_taylor : int
        Taylor map end points
        Bmad type: integer
        Fortran default: -1
    ix_history : int
        present index to command history array
        Bmad type: integer
        Fortran default: 0
    ix_key_bank : int
        For single mode.
        Bmad type: integer
        Fortran default: 0
    ix_ref_taylor : int
        Taylor map end points
        Bmad type: integer
        Fortran default: -1
    key : TaoAliasStruct
        Bmad type: tao_alias_struct
        Fortran default: tao_alias_struct()
    lattice_calc_done : bool
        Used by GUI for deciding when to refresh.
        Bmad type: logical
        Fortran default: .false.
    lev_loop : int
        in do loop nest level
        Bmad type: integer
        Fortran default: 0
    multi_turn_orbit_is_plotted : bool
        Is a multi_turn_orbit being plotted?
        Bmad type: logical
        Fortran default: .false.
    n_alias : int
        Bmad type: integer
        Fortran default: 0
    n_err_messages_printed : int
        Used by tao_set_invalid to limit number of messages.
        Bmad type: integer
        Fortran default: 0
    n_history : int
        present history index
        Bmad type: integer
        Fortran default: 0
    n_universes : int
        Bmad type: integer
        Fortran default: n_uni_init$
    optimizer_running : bool
        Bmad type: logical
        Fortran default: .false.
    plot_place_buffer : TaoPlotRegionStruct
        Used when %external_plotting is on.
        Bmad type: tao_plot_region_struct
    print_to_terminal : bool
        Print command prompt to the terminal? For use with GUIs.
        Bmad type: logical
        Fortran default: .true.
    rad_int_6d_calc_on : bool
        6D Radiation integrals calculation on/off.
        Bmad type: logical
        Fortran default: .true.
    rad_int_ri_calc_on : bool
        "Classical" radiation integrals calculation on/off.
        Bmad type: logical
        Fortran default: .true.
    saved_cmd_line : str
        Saved part of command line when there are mulitple commands on a line
        Bmad type: character
        Fortran default: ''
    single_mode : bool
        Bmad type: logical
        Fortran default: .false.
    single_mode_buffer : str
        Bmad type: character
        Fortran default: ''
    symbolic_num : NamedNumberStruct
        Named numbers
        Bmad type: named_number_struct
    use_cmd_here : bool
        Used for commands recalled from the cmd history stack
        Bmad type: logical
        Fortran default: .false.
    use_saved_beam_in_tracking : bool
        Bmad type: logical
        Fortran default: .false.
    valid_plot_who : str
        model, base, ref etc...
        Bmad type: character
        Fortran default: ''
    """

    add_measurement_noise: bool = pydantic.Field(
        default=True,
        description="Turn off to take data derivatives.",
    )
    alias: Sequence[TaoAliasStruct] = pydantic.Field(
        default=None,
        max_length=200,
    )
    all_merit_weights_positive: bool = pydantic.Field(
        default=True,
    )
    alpha: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    cmd: str = pydantic.Field(
        default="",
        max_length=200,
        description="Used for the cmd history",
    )
    cmd_file: Sequence[TaoCommandFileStruct] = pydantic.Field(
        default=None,
    )
    cmd_file_level: int = pydantic.Field(
        default=0,
        description="For nested command files. 0 -> no command file.",
    )
    cmd_file_paused: bool = pydantic.Field(
        default=False,
    )
    cmd_from_cmd_file: bool = pydantic.Field(
        default=False,
        description="was command from a command file?",
    )
    combine_consecutive_elements_of_like_name: bool = pydantic.Field(
        default=False,
    )
    command_arg_has_been_executed: bool = pydantic.Field(
        default=False,
        description="Has the -command command line argument been executed?",
    )
    covar: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    do_loop: Sequence[DoLoopStruct] = pydantic.Field(
        default=None,
    )
    dummy_target: float = pydantic.Field(
        default=0,
        description="Dummy varaible",
    )
    force_chrom_calc: bool = pydantic.Field(
        default=False,
        description="Used by a routine to force calculation",
    )
    force_rad_int_calc: bool = pydantic.Field(
        default=False,
        description="Used by a routine to force calculation",
    )
    have_datums_using_expressions: bool = pydantic.Field(
        default=False,
    )
    have_tracked_beam: bool = pydantic.Field(
        default=False,
        description="Used to catch error when beam plotting without having tracked a beam.",
    )
    init_beam: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    init_plot_needed: bool = pydantic.Field(
        default=True,
        description="reinitialize plotting?",
    )
    init_read_lat_info: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    init_var: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    is_err_message_printed: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=2,
        description="Used by tao_set_invalid",
    )
    ix_beam_track_active_element: int = pydantic.Field(
        default=-1,
        description="Element being tracked through `tao_beam_track`.",
    )
    ix_ele_taylor: int = pydantic.Field(
        default=-1,
        description="Taylor map end points",
    )
    ix_history: int = pydantic.Field(
        default=0,
        description="present index to command history array",
    )
    ix_key_bank: int = pydantic.Field(
        default=0,
        description="For single mode.",
    )
    ix_ref_taylor: int = pydantic.Field(
        default=-1,
        description="Taylor map end points",
    )
    key: Sequence[TaoAliasStruct] = pydantic.Field(
        default=None,
        max_length=100,
    )
    lattice_calc_done: bool = pydantic.Field(
        default=False,
        description="Used by GUI for deciding when to refresh.",
    )
    lev_loop: int = pydantic.Field(
        default=0,
        description="in do loop nest level",
    )
    multi_turn_orbit_is_plotted: bool = pydantic.Field(
        default=False,
        description="Is a multi_turn_orbit being plotted?",
    )
    n_alias: int = pydantic.Field(
        default=0,
    )
    n_err_messages_printed: int = pydantic.Field(
        default=0,
        description="Used by tao_set_invalid to limit number of messages.",
    )
    n_history: int = pydantic.Field(
        default=0,
        description="present history index",
    )
    n_universes: int = pydantic.Field(
        default=0,
    )
    optimizer_running: bool = pydantic.Field(
        default=False,
    )
    plot_place_buffer: Sequence[TaoPlotRegionStruct] = pydantic.Field(
        default=None,
        description="Used when %external_plotting is on.",
    )
    print_to_terminal: bool = pydantic.Field(
        default=True,
        description="Print command prompt to the terminal? For use with GUIs.",
    )
    rad_int_6d_calc_on: bool = pydantic.Field(
        default=True,
        description="6D Radiation integrals calculation on/off.",
    )
    rad_int_ri_calc_on: bool = pydantic.Field(
        default=True,
        description="'Classical' radiation integrals calculation on/off.",
    )
    saved_cmd_line: str = pydantic.Field(
        default="",
        max_length=200,
        description="Saved part of command line when there are mulitple commands on a line",
    )
    single_mode: bool = pydantic.Field(
        default=False,
    )
    single_mode_buffer: str = pydantic.Field(
        default="",
        max_length=200,
    )
    symbolic_num: Sequence[NamedNumberStruct] = pydantic.Field(
        default=None,
        description="Named numbers",
    )
    use_cmd_here: bool = pydantic.Field(
        default=False,
        description="Used for commands recalled from the cmd history stack",
    )
    use_saved_beam_in_tracking: bool = pydantic.Field(
        default=False,
    )
    valid_plot_who: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="model, base, ref etc...",
    )


class TaoCurveArrayStruct(pydantic.BaseModel):
    """
    TaoCurveArrayStruct corresponds to bmad `tao_curve_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 375.

    Attributes
    ----------
    c : TaoCurveStruct
        Bmad type: tao_curve_struct
    """

    c: TaoCurveStruct = pydantic.Field(
        default=None,
    )


class TaoCurveColorStruct(pydantic.BaseModel):
    """
    TaoCurveColorStruct corresponds to bmad `tao_curve_color_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 179.

    Attributes
    ----------
    autoscale : bool
        Set %min, %max automatically to the limits of %data_type
        Bmad type: logical
        Fortran default: .true.
    data_type : str
        Datum type to use for z-axis.
        Bmad type: character
        Fortran default: ''
    is_on : bool
        On/Off
        Bmad type: logical
        Fortran default: .false.
    max : float
        Min and max values for mapping z-axis to color.
        Bmad type: real
        Fortran default: 0
    min : float
        Min and max values for mapping z-axis to color.
        Bmad type: real
        Fortran default: 0
    """

    autoscale: bool = pydantic.Field(
        default=True,
        description="Set %min, %max automatically to the limits of %data_type",
    )
    data_type: str = pydantic.Field(
        default="",
        max_length=100,
        description="Datum type to use for z-axis.",
    )
    is_on: bool = pydantic.Field(
        default=False,
        description="On/Off",
    )
    max: float = pydantic.Field(
        default=0,
        description="Min and max values for mapping z-axis to color.",
    )
    min: float = pydantic.Field(
        default=0,
        description="Min and max values for mapping z-axis to color.",
    )


class TaoCurveOrbitStruct(pydantic.BaseModel):
    """
    TaoCurveOrbitStruct corresponds to bmad `tao_curve_orbit_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 171.

    Attributes
    ----------
    t : float
        Time
        Bmad type: real
        Fortran default: 0
    x : float
        Transverse offset
        Bmad type: real
        Fortran default: 0
    y : float
        Transverse offset
        Bmad type: real
        Fortran default: 0
    """

    t: float = pydantic.Field(
        default=0,
        description="Time",
    )
    x: float = pydantic.Field(
        default=0,
        description="Transverse offset",
    )
    y: float = pydantic.Field(
        default=0,
        description="Transverse offset",
    )


class TaoCurveStruct(pydantic.BaseModel):
    """
    TaoCurveStruct corresponds to bmad `tao_curve_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 189.

    Attributes
    ----------
    component : str
        Who to plot. Eg: 'meas - design'
        Bmad type: character
        Fortran default: ''
    data_index : str
        Used for calculating %ix_symb(:).
        Bmad type: character
        Fortran default: ''
    data_source : str
        'lat', 'beam', 'data' (deprecated: 'dat'), 'var', 'multi_turn_orbit'
        Bmad type: character
        Fortran default: ''
    data_type : str
        'orbit.x', etc.
        Bmad type: character
    data_type_x : str
        Used for data slices and phase space plots.
        Bmad type: character
        Fortran default: ''
    draw_error_bars : bool
        Draw error bars based upon data%error_rms if drawing data? !! logical ::
        draw_rms = .false.          ! Show mean and RMS values with legend?
        Bmad type: logical
        Fortran default: .false.
    draw_line : bool
        Draw a line through the data points?
        Bmad type: logical
        Fortran default: .true.
    draw_symbol_index : bool
        Draw the symbol index number curve%ix_symb?
        Bmad type: logical
        Fortran default: .false.
    draw_symbols : bool
        Draw a symbol at the data points?
        Bmad type: logical
        Fortran default: .true.
    ele_ref_name : str
        Reference element.
        Bmad type: character
        Fortran default: ''
    err_symb : float
        Error bars
        Bmad type: real
    g : TaoGraphStruct
        pointer to parent graph
        Bmad type: tao_graph_struct
    hist : TaoHistogramStruct
        Bmad type: tao_histogram_struct
        Fortran default: tao_histogram_struct()
    ix_branch : int
        Bmad type: integer
        Fortran default: -1
    ix_bunch : int
        Bunch to plot.
        Bmad type: integer
        Fortran default: 0
    ix_line : int
        Used by wave and aperture curves.
        Bmad type: integer, allocatable
    ix_symb : int
        Corresponding index in d1_data%d(:) array.
        Bmad type: integer, allocatable
    ix_universe : int
        Universe where data is. -1 => use s%global%default_universe
        Bmad type: integer
        Fortran default: -1
    legend_text : str
        String to draw in a curve legend.
        Bmad type: character
        Fortran default: ''
    line : QpLineStruct
        Line attributes
        Bmad type: qp_line_struct
        Fortran default: qp_line_struct()
    message_text : str
        Informational message to draw with graph.
        Bmad type: character
        Fortran default: ''
    n_turn : int
        Used for multi_turn_orbit plotting
        Bmad type: integer
        Fortran default: -1
    name : str
        Name identifying the curve.
        Bmad type: character
        Fortran default: ''
    orbit : TaoCurveOrbitStruct
        Used for E/B field plotting.
        Bmad type: tao_curve_orbit_struct
        Fortran default: tao_curve_orbit_struct()
    smooth_line_calc : bool
        Calculate data between element edge points?
        Bmad type: logical
        Fortran default: .true.
    symb_size : float
        Symbol size. Used with symbol_size_scale.
        Bmad type: real
    symbol : QpSymbolStruct
        Symbol attributes
        Bmad type: qp_symbol_struct
        Fortran default: qp_symbol_struct()
    symbol_every : int
        Symbol every how many points.
        Bmad type: integer
        Fortran default: 1
    use_y2 : bool
        Use y2 axis?
        Bmad type: logical
        Fortran default: .false.
    valid : bool
        valid data?
        Bmad type: logical
        Fortran default: .false.
    why_invalid : str
        Informative string to print.
        Bmad type: character
        Fortran default: '???'
    x_line : float
        Coords for drawing a curve
        Bmad type: real
    x_symb : float
        Coords for drawing the symbols
        Bmad type: real
    y2_line : float
        Second array needed for beam chamber curve.
        Bmad type: real
    y_axis_scale_factor : float
        y-axis conversion from internal to plotting units.
        Bmad type: real
        Fortran default: 1
    y_line : float
        Bmad type: real
    y_symb : float
        Bmad type: real
    z_color : TaoCurveColorStruct
        Bmad type: tao_curve_color_struct
        Fortran default: tao_curve_color_struct()
    z_symb : float
        Symbol color
        Bmad type: real
    """

    component: str = pydantic.Field(
        default="",
        max_length=60,
        description="Who to plot. Eg: 'meas - design'",
    )
    data_index: str = pydantic.Field(
        default="",
        max_length=100,
        description="Used for calculating %ix_symb(:).",
    )
    data_source: str = pydantic.Field(
        default="",
        max_length=40,
        description="'lat', 'beam', 'data' (deprecated: 'dat'), 'var', 'multi_turn_orbit'",
    )
    data_type: str = pydantic.Field(
        default="",
        description="'orbit.x', etc.",
    )
    data_type_x: str = pydantic.Field(
        default="",
        max_length=100,
        description="Used for data slices and phase space plots.",
    )
    draw_error_bars: bool = pydantic.Field(
        default=False,
        description=(
            "Draw error bars based upon data%error_rms if drawing data? !! logical :: "
            "draw_rms = .false.          ! Show mean and RMS values with legend?"
        ),
    )
    draw_line: bool = pydantic.Field(
        default=True,
        description="Draw a line through the data points?",
    )
    draw_symbol_index: bool = pydantic.Field(
        default=False,
        description="Draw the symbol index number curve%ix_symb?",
    )
    draw_symbols: bool = pydantic.Field(
        default=True,
        description="Draw a symbol at the data points?",
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Reference element.",
    )
    err_symb: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Error bars",
    )
    g: TaoGraphStruct = pydantic.Field(
        default=None,
        description="pointer to parent graph",
    )
    hist: TaoHistogramStruct = pydantic.Field(
        default=None,
    )
    ix_branch: int = pydantic.Field(
        default=-1,
    )
    ix_bunch: int = pydantic.Field(
        default=0,
        description="Bunch to plot.",
    )
    ix_line: Sequence[int] = pydantic.Field(
        default=0,
        description="Used by wave and aperture curves.",
    )
    ix_symb: Sequence[int] = pydantic.Field(
        default=0,
        description="Corresponding index in d1_data%d(:) array.",
    )
    ix_universe: int = pydantic.Field(
        default=-1,
        description="Universe where data is. -1 => use s%global%default_universe",
    )
    legend_text: str = pydantic.Field(
        default="",
        max_length=40,
        description="String to draw in a curve legend.",
    )
    line: QpLineStruct = pydantic.Field(
        default=None,
        description="Line attributes",
    )
    message_text: str = pydantic.Field(
        default="",
        max_length=40,
        description="Informational message to draw with graph.",
    )
    n_turn: int = pydantic.Field(
        default=-1,
        description="Used for multi_turn_orbit plotting",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name identifying the curve.",
    )
    orbit: TaoCurveOrbitStruct = pydantic.Field(
        default=None,
        description="Used for E/B field plotting.",
    )
    smooth_line_calc: bool = pydantic.Field(
        default=True,
        description="Calculate data between element edge points?",
    )
    symb_size: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Symbol size. Used with symbol_size_scale.",
    )
    symbol: QpSymbolStruct = pydantic.Field(
        default=None,
        description="Symbol attributes",
    )
    symbol_every: int = pydantic.Field(
        default=1,
        description="Symbol every how many points.",
    )
    use_y2: bool = pydantic.Field(
        default=False,
        description="Use y2 axis?",
    )
    valid: bool = pydantic.Field(
        default=False,
        description="valid data?",
    )
    why_invalid: str = pydantic.Field(
        default="???",
        max_length=80,
        description="Informative string to print.",
    )
    x_line: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Coords for drawing a curve",
    )
    x_symb: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Coords for drawing the symbols",
    )
    y2_line: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Second array needed for beam chamber curve.",
    )
    y_axis_scale_factor: float = pydantic.Field(
        default=1,
        description="y-axis conversion from internal to plotting units.",
    )
    y_line: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y_symb: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    z_color: TaoCurveColorStruct = pydantic.Field(
        default=None,
    )
    z_symb: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Symbol color",
    )


class TaoD1DataArrayStruct(pydantic.BaseModel):
    """
    TaoD1DataArrayStruct corresponds to bmad `tao_d1_data_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 509.

    Attributes
    ----------
    d1 : TaoD1DataStruct
        Bmad type: tao_d1_data_struct
        Fortran default: null()
    """

    d1: TaoD1DataStruct = pydantic.Field(
        default=None,
    )


class TaoD1DataStruct(pydantic.BaseModel):
    """
    TaoD1DataStruct corresponds to bmad `tao_d1_data_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 475.

    Attributes
    ----------
    d : TaoDataStruct
        Pointer to the appropriate section in u%data
        Bmad type: tao_data_struct
        Fortran default: null()
    d2 : TaoD2DataStruct
        ptr to parent d2_data
        Bmad type: tao_d2_data_struct
        Fortran default: null()
    name : str
        Eg: 'x', etc.
        Bmad type: character
        Fortran default: ''
    """

    d: Sequence[TaoDataStruct] = pydantic.Field(
        default=None,
        description="Pointer to the appropriate section in u%data",
    )
    d2: TaoD2DataStruct = pydantic.Field(
        default=None,
        description="ptr to parent d2_data",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Eg: 'x', etc.",
    )


class TaoD2DataArrayStruct(pydantic.BaseModel):
    """
    TaoD2DataArrayStruct corresponds to bmad `tao_d2_data_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 513.

    Attributes
    ----------
    d2 : TaoD2DataStruct
        Bmad type: tao_d2_data_struct
        Fortran default: null()
    """

    d2: TaoD2DataStruct = pydantic.Field(
        default=None,
    )


class TaoD2DataStruct(pydantic.BaseModel):
    """
    TaoD2DataStruct corresponds to bmad `tao_d2_data_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 487.

    Attributes
    ----------
    d1 : TaoD1DataStruct
        Points to children
        Bmad type: tao_d1_data_struct
    data_date : str
        Data measurement date.
        Bmad type: character
        Fortran default: ''
    data_file_name : str
        Data file name .
        Bmad type: character
        Fortran default: ''
    data_read_in : bool
        A data set has been read in?
        Bmad type: logical
        Fortran default: .false.
    descrip : str
        Array for descriptive information.
        Bmad type: character
        Fortran default: ''
    ix_d2_data : int
        Index in u%d2_data(:) array.
        Bmad type: integer
    ix_ref : int
        Index of the reference data set.
        Bmad type: integer
    ix_universe : int
        Index of universe this is in.
        Bmad type: integer
    name : str
        Name to be used with commands.
        Bmad type: character
        Fortran default: ''
    ref_date : str
        Reference data measurement date.
        Bmad type: character
        Fortran default: ''
    ref_file_name : str
        Reference file name.
        Bmad type: character
        Fortran default: ''
    ref_read_in : bool
        A reference data set has been read in?
        Bmad type: logical
        Fortran default: .false.
    """

    d1: Sequence[TaoD1DataStruct] = pydantic.Field(
        default=None,
        description="Points to children",
    )
    data_date: str = pydantic.Field(
        default="",
        max_length=24,
        description="Data measurement date.",
    )
    data_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Data file name .",
    )
    data_read_in: bool = pydantic.Field(
        default=False,
        description="A data set has been read in?",
    )
    descrip: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="Array for descriptive information.",
    )
    ix_d2_data: int = pydantic.Field(
        default=0,
        description="Index in u%d2_data(:) array.",
    )
    ix_ref: int = pydantic.Field(
        default=0,
        description="Index of the reference data set.",
    )
    ix_universe: int = pydantic.Field(
        default=0,
        description="Index of universe this is in.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name to be used with commands.",
    )
    ref_date: str = pydantic.Field(
        default="",
        max_length=24,
        description="Reference data measurement date.",
    )
    ref_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Reference file name.",
    )
    ref_read_in: bool = pydantic.Field(
        default=False,
        description="A reference data set has been read in?",
    )


class TaoDataArrayStruct(pydantic.BaseModel):
    """
    TaoDataArrayStruct corresponds to bmad `tao_data_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 505.

    Attributes
    ----------
    d : TaoDataStruct
        Bmad type: tao_data_struct
        Fortran default: null()
    """

    d: TaoDataStruct = pydantic.Field(
        default=None,
    )


class TaoDataStruct(pydantic.BaseModel):
    """
    TaoDataStruct corresponds to bmad `tao_data_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 421.

    Attributes
    ----------
    base_value : float
        The value as calculated from the base model.
        Bmad type: real
        Fortran default: 0
    d1 : TaoD1DataStruct
        Pointer to the parent d1_data_struct
        Bmad type: tao_d1_data_struct
        Fortran default: null()
    data_source : str
        'lat', 'beam', 'data' or 'var'. Last two used for expressions.
        Bmad type: character
        Fortran default: ''
    data_type : str
        Type of data: 'orbit.x', etc.
        Bmad type: character
    delta_merit : float
        Diff used to calculate the merit function term.
        Bmad type: real
        Fortran default: 0
    design_value : float
        What the datum value is in the design lattice.
        Bmad type: real
        Fortran default: 0
    ele_name : str
        Name of the lattice element where datum is evaluated.
        Bmad type: character
        Fortran default: ''
    ele_ref_name : str
        Name of reference lattice element
        Bmad type: character
        Fortran default: ''
    ele_start_name : str
        Name of starting lattice element when there is a range
        Bmad type: character
        Fortran default: ''
    err_message_printed : bool
        Used to prevent zillions of error messages being generated
        Bmad type: logical
        Fortran default: .false.
    error_rms : float
        Measurement error RMS. Used in plotting.
        Bmad type: real
        Fortran default: 0
    eval_point : int
        or anchor_center$, anchor_beginning$. Where to evaluate data relative to the
        element.
        Bmad type: integer
        Fortran default: anchor_end$
    exists : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_base : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_design : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_meas : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_model : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_opt : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    good_plot : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    good_ref : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_user : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    id : str
        Used by Tao extension code. Not used by Tao directly.
        Bmad type: character
        Fortran default: ''
    invalid_value : float
        Value used in merit calc if good_model = F (or possibly good_design &
        good_base).
        Bmad type: real
        Fortran default: 0
    ix_branch : int
        Index of the associated lattice branch.
        Bmad type: integer
        Fortran default: 0
    ix_bunch : int
        Bunch number to get the data from.
        Bmad type: integer
        Fortran default: 0
    ix_d1 : int
        Index number in u%d2_data(i)%d1_data(j)%d(:) array.
        Bmad type: integer
        Fortran default: -1
    ix_dmodel : int
        Row number in the dModel_dVar derivative matrix.
        Bmad type: integer
        Fortran default: -1
    ix_data : int
        Index of this datum in the u%data(:) array of data_structs.
        Bmad type: integer
        Fortran default: -1
    ix_ele : int
        Index of the lattice element corresponding to ele_name
        Bmad type: integer
        Fortran default: -1
    ix_ele_merit : int
        Index of lattice elment where merit is evaluated.
        Bmad type: integer
        Fortran default: -1
    ix_ele_ref : int
        Index of lattice elment when there is a reference.
        Bmad type: integer
        Fortran default: -1
    ix_ele_start : int
        Index of lattice elment when there is a range
        Bmad type: integer
        Fortran default: -1
    ix_uni : int
        Universe index of datum.
        Bmad type: integer
        Fortran default: -1
    meas_value : float
        Measured datum value.
        Bmad type: real
        Fortran default: 0
    merit : float
        Merit function term value: weight * delta_merit^2
        Bmad type: real
        Fortran default: 0
    merit_type : str
        Type of constraint: 'target', 'max', 'min', etc.
        Bmad type: character
        Fortran default: ''
    bmad_model_value : float
        Datum value as calculated from the model.
        Bmad type: real
        Fortran default: 0
    old_value : float
        The model_value at some previous time.
        Bmad type: real
        Fortran default: 0
    ref_value : float
        Measured datum value from the reference data set.
        Bmad type: real
        Fortran default: 0
    s : float
        longitudinal position of ele.
        Bmad type: real
        Fortran default: real_garbage$
    s_offset : float
        Offset of the evaluation point.
        Bmad type: real
        Fortran default: 0
    spin_map : TaoSpinMapStruct
        Bmad type: tao_spin_map_struct
    stack : TaoEvalStack1Struct
        Bmad type: tao_eval_stack1_struct
    useit_opt : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    useit_plot : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    weight : float
        Weight for the merit function term.
        Bmad type: real
        Fortran default: 0
    why_invalid : str
        Informational string if there is a problem.
        Bmad type: character
        Fortran default: ''
    """

    base_value: float = pydantic.Field(
        default=0,
        description="The value as calculated from the base model.",
    )
    d1: TaoD1DataStruct = pydantic.Field(
        default=None,
        description="Pointer to the parent d1_data_struct",
    )
    data_source: str = pydantic.Field(
        default="",
        max_length=20,
        description="'lat', 'beam', 'data' or 'var'. Last two used for expressions.",
    )
    data_type: str = pydantic.Field(
        default="",
        description="Type of data: 'orbit.x', etc.",
    )
    delta_merit: float = pydantic.Field(
        default=0,
        description="Diff used to calculate the merit function term.",
    )
    design_value: float = pydantic.Field(
        default=0,
        description="What the datum value is in the design lattice.",
    )
    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of the lattice element where datum is evaluated.",
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of reference lattice element",
    )
    ele_start_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of starting lattice element when there is a range",
    )
    err_message_printed: bool = pydantic.Field(
        default=False,
        description="Used to prevent zillions of error messages being generated",
    )
    error_rms: float = pydantic.Field(
        default=0,
        description="Measurement error RMS. Used in plotting.",
    )
    eval_point: int = pydantic.Field(
        default=0,
        description=(
            "or anchor_center$, anchor_beginning$. Where to evaluate data relative to "
            "the element."
        ),
    )
    exists: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_base: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_design: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_meas: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_model: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_opt: bool = pydantic.Field(
        default=True,
        description="See above",
    )
    good_plot: bool = pydantic.Field(
        default=True,
        description="See above",
    )
    good_ref: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_user: bool = pydantic.Field(
        default=True,
        description="See above",
    )
    id: str = pydantic.Field(
        default="",
        max_length=40,
        description="Used by Tao extension code. Not used by Tao directly.",
    )
    invalid_value: float = pydantic.Field(
        default=0,
        description=(
            "Value used in merit calc if good_model = F (or possibly good_design & "
            "good_base)."
        ),
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description="Index of the associated lattice branch.",
    )
    ix_bunch: int = pydantic.Field(
        default=0,
        description="Bunch number to get the data from.",
    )
    ix_d1: int = pydantic.Field(
        default=-1,
        description="Index number in u%d2_data(i)%d1_data(j)%d(:) array.",
    )
    ix_dmodel: int = pydantic.Field(
        default=-1,
        description="Row number in the dModel_dVar derivative matrix.",
        validation_alias=pydantic.AliasChoices("ix_dmodel", "ix_dModel"),
        serialization_alias="ix_dModel",
    )
    ix_data: int = pydantic.Field(
        default=-1,
        description="Index of this datum in the u%data(:) array of data_structs.",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description="Index of the lattice element corresponding to ele_name",
    )
    ix_ele_merit: int = pydantic.Field(
        default=-1,
        description="Index of lattice elment where merit is evaluated.",
    )
    ix_ele_ref: int = pydantic.Field(
        default=-1,
        description="Index of lattice elment when there is a reference.",
    )
    ix_ele_start: int = pydantic.Field(
        default=-1,
        description="Index of lattice elment when there is a range",
    )
    ix_uni: int = pydantic.Field(
        default=-1,
        description="Universe index of datum.",
    )
    meas_value: float = pydantic.Field(
        default=0,
        description="Measured datum value.",
    )
    merit: float = pydantic.Field(
        default=0,
        description="Merit function term value: weight * delta_merit^2",
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=40,
        description="Type of constraint: 'target', 'max', 'min', etc.",
    )
    bmad_model_value: float = pydantic.Field(
        default=0,
        description="Datum value as calculated from the model.",
        validation_alias=pydantic.AliasChoices("bmad_model_value", "model_value"),
        serialization_alias="model_value",
    )
    old_value: float = pydantic.Field(
        default=0,
        description="The model_value at some previous time.",
    )
    ref_value: float = pydantic.Field(
        default=0,
        description="Measured datum value from the reference data set.",
    )
    s: float = pydantic.Field(
        default=0.0,
        description="longitudinal position of ele.",
    )
    s_offset: float = pydantic.Field(
        default=0,
        description="Offset of the evaluation point.",
    )
    spin_map: TaoSpinMapStruct = pydantic.Field(
        default=None,
    )
    stack: Sequence[TaoEvalStack1Struct] = pydantic.Field(
        default=None,
    )
    useit_opt: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    useit_plot: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    weight: float = pydantic.Field(
        default=0,
        description="Weight for the merit function term.",
    )
    why_invalid: str = pydantic.Field(
        default="",
        max_length=100,
        description="Informational string if there is a problem.",
    )


class TaoDataVarComponentStruct(pydantic.BaseModel):
    """
    TaoDataVarComponentStruct corresponds to bmad `tao_data_var_component_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 157.

    Attributes
    ----------
    name : str
        Eg: 'meas', 'ref', 'model', etc.
        Bmad type: character
        Fortran default: ''
    sign : float
        +1 or -1
        Bmad type: real
        Fortran default: 1
    """

    name: str = pydantic.Field(
        default="",
        max_length=16,
        description="Eg: 'meas', 'ref', 'model', etc.",
    )
    sign: float = pydantic.Field(
        default=1,
        description="+1 or -1",
    )


class TaoDrawingStruct(pydantic.BaseModel):
    """
    TaoDrawingStruct corresponds to bmad `tao_drawing_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 128.

    Attributes
    ----------
    ele_shape : TaoEleShapeStruct
        Bmad type: tao_ele_shape_struct
    """

    ele_shape: Sequence[TaoEleShapeStruct] = pydantic.Field(
        default=None,
    )


class TaoDynamicApertureStruct(pydantic.BaseModel):
    """
    TaoDynamicApertureStruct corresponds to bmad `tao_dynamic_aperture_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1048.

    Attributes
    ----------
    a_emit : float
        Bmad type: real
        Fortran default: -1
    b_emit : float
        Bmad type: real
        Fortran default: -1
    ellipse_scale : float
        Bmad type: real
        Fortran default: 1
    param : ApertureParamStruct
        Bmad type: aperture_param_struct
    pz : float
        Bmad type: real
    scan : ApertureScanStruct
        One scan for each pz.
        Bmad type: aperture_scan_struct
    """

    a_emit: float = pydantic.Field(
        default=-1,
    )
    b_emit: float = pydantic.Field(
        default=-1,
    )
    ellipse_scale: float = pydantic.Field(
        default=1,
    )
    param: ApertureParamStruct = pydantic.Field(
        default=None,
    )
    pz: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    scan: Sequence[ApertureScanStruct] = pydantic.Field(
        default=None,
        description="One scan for each pz.",
    )


class TaoElePointerStruct(pydantic.BaseModel):
    """
    TaoElePointerStruct corresponds to bmad `tao_ele_pointer_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 107.

    Attributes
    ----------
    eles : ElePointerStruct
        Bmad type: ele_pointer_struct
    n_loc : int
        Bmad type: integer
        Fortran default: 0
    """

    eles: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
    )
    n_loc: int = pydantic.Field(
        default=0,
    )


class TaoEleShapeStruct(pydantic.BaseModel):
    """
    TaoEleShapeStruct corresponds to bmad `tao_ele_shape_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 113.

    Attributes
    ----------
    color : str
        Color of shape
        Bmad type: character
        Fortran default: 'black'
    draw : bool
        Draw the shape?
        Bmad type: logical
        Fortran default: .true.
    ele_id : str
        element "key::name" to match to.
        Bmad type: character
        Fortran default: ''
    ix_key : int
        Extracted from ele_id. 0 => all classes (quadrupole, etc.)
        Bmad type: integer
        Fortran default: 0
    label : str
        Can be: 'name', 's', 'none'
        Bmad type: character
        Fortran default: 'name'
    line_width : int
        Width of lines used to draw the shape.
        Bmad type: integer
        Fortran default: 1
    multi : bool
        Can be part of a multi-shape.
        Bmad type: logical
        Fortran default: .false.
    name_ele : str
        Name of element.
        Bmad type: character
        Fortran default: ''
    offset : float
        Vertical offset.
        Bmad type: real
        Fortran default: 0
    shape : str
        Shape to draw
        Bmad type: character
        Fortran default: ''
    size : float
        plot vertical height
        Bmad type: real
        Fortran default: 0
    uni : TaoElePointerStruct
        Bmad type: tao_ele_pointer_struct
    """

    color: str = pydantic.Field(
        default="black",
        max_length=16,
        description="Color of shape",
    )
    draw: bool = pydantic.Field(
        default=True,
        description="Draw the shape?",
    )
    ele_id: str = pydantic.Field(
        default="",
        max_length=60,
        description="element 'key::name' to match to.",
    )
    ix_key: int = pydantic.Field(
        default=0,
        description="Extracted from ele_id. 0 => all classes (quadrupole, etc.)",
    )
    label: str = pydantic.Field(
        default="name",
        max_length=16,
        description="Can be: 'name', 's', 'none'",
    )
    line_width: int = pydantic.Field(
        default=1,
        description="Width of lines used to draw the shape.",
    )
    multi: bool = pydantic.Field(
        default=False,
        description="Can be part of a multi-shape.",
    )
    name_ele: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of element.",
    )
    offset: float = pydantic.Field(
        default=0,
        description="Vertical offset.",
    )
    shape: str = pydantic.Field(
        default="",
        max_length=40,
        description="Shape to draw",
    )
    size: float = pydantic.Field(
        default=0,
        description="plot vertical height",
    )
    uni: Sequence[TaoElePointerStruct] = pydantic.Field(
        default=None,
    )


class TaoEvalStack1Struct(pydantic.BaseModel):
    """
    TaoEvalStack1Struct corresponds to bmad `tao_eval_stack1_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 96.

    Attributes
    ----------
    info : TaoExpressionInfoStruct
        Bmad type: tao_expression_info_struct
    name : str
        Bmad type: character
        Fortran default: ''
    scale : float
        Scale factor for ping data
        Bmad type: real
        Fortran default: 1
    type : int
        Bmad type: integer
        Fortran default: 0
    value : float
        Bmad type: real
    value_ptr : TaoRealPointerStruct
        Used to point to data, lattice parameters, etc
        Bmad type: tao_real_pointer_struct
    """

    info: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    name: str = pydantic.Field(
        default="",
        max_length=120,
    )
    scale: float = pydantic.Field(
        default=1,
        description="Scale factor for ping data",
    )
    type: int = pydantic.Field(
        default=0,
    )
    value: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    value_ptr: Sequence[TaoRealPointerStruct] = pydantic.Field(
        default=None,
        description="Used to point to data, lattice parameters, etc",
    )


class TaoExpressionInfoStruct(pydantic.BaseModel):
    """
    TaoExpressionInfoStruct corresponds to bmad `tao_expression_info_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 90.

    Attributes
    ----------
    ele : EleStruct
        Associated ele if it exists
        Bmad type: ele_struct
        Fortran default: null()
    good : bool
        Expression is valid.
        Bmad type: logical
        Fortran default: .true.
    s : float
        Longitudinal position of expression.
        Bmad type: real
        Fortran default: real_garbage$
    """

    ele: EleStruct = pydantic.Field(
        default=None,
        description="Associated ele if it exists",
    )
    good: bool = pydantic.Field(
        default=True,
        description="Expression is valid.",
    )
    s: float = pydantic.Field(
        default=0.0,
        description="Longitudinal position of expression.",
    )


class TaoFloorPlanStruct(pydantic.BaseModel):
    """
    TaoFloorPlanStruct corresponds to bmad `tao_floor_plan_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 234.

    Attributes
    ----------
    correct_distortion : bool
        T -> Shrink one axis so x-scale = y-scale.
        Bmad type: logical
        Fortran default: .true.
    draw_building_wall : bool
        Draw the building wall?
        Bmad type: logical
        Fortran default: .true.
    draw_only_first_pass : bool
        Draw only first pass with multipass elements?
        Bmad type: logical
        Fortran default: .false.
    flip_label_side : bool
        Draw element label on other side of element?
        Bmad type: logical
        Fortran default: .false.
    orbit_color : str
        Bmad type: character
        Fortran default: 'red'
    orbit_lattice : str
        Or 'design' or 'base'
        Bmad type: character
        Fortran default: 'model'
    orbit_pattern : str
        Bmad type: character
        Fortran default: 'solid'
    orbit_scale : float
        Scale factor for drawing orbits. 0 -> Do not draw.
        Bmad type: real
        Fortran default: 0
    orbit_width : int
        Bmad type: integer
        Fortran default: 1
    rotation : float
        Rotation of floor plan plot: 1.0 -> 360^deg
        Bmad type: real
        Fortran default: 0
    size_is_absolute : bool
        Are shape sizes in meters or window pixels?
        Bmad type: logical
        Fortran default: .false.
    view : str
        or 'xz'.
        Bmad type: character
        Fortran default: 'zx'
    """

    correct_distortion: bool = pydantic.Field(
        default=True,
        description="T -> Shrink one axis so x-scale = y-scale.",
    )
    draw_building_wall: bool = pydantic.Field(
        default=True,
        description="Draw the building wall?",
    )
    draw_only_first_pass: bool = pydantic.Field(
        default=False,
        description="Draw only first pass with multipass elements?",
    )
    flip_label_side: bool = pydantic.Field(
        default=False,
        description="Draw element label on other side of element?",
    )
    orbit_color: str = pydantic.Field(
        default="red",
        max_length=16,
    )
    orbit_lattice: str = pydantic.Field(
        default="model",
        max_length=16,
        description="Or 'design' or 'base'",
    )
    orbit_pattern: str = pydantic.Field(
        default="solid",
        max_length=16,
    )
    orbit_scale: float = pydantic.Field(
        default=0,
        description="Scale factor for drawing orbits. 0 -> Do not draw.",
    )
    orbit_width: int = pydantic.Field(
        default=1,
    )
    rotation: float = pydantic.Field(
        default=0,
        description="Rotation of floor plan plot: 1.0 -> 360^deg",
    )
    size_is_absolute: bool = pydantic.Field(
        default=False,
        description="Are shape sizes in meters or window pixels?",
    )
    view: str = pydantic.Field(
        default="zx",
        max_length=2,
        description="or 'xz'.",
    )


class TaoGlobalStruct(pydantic.BaseModel):
    """
    TaoGlobalStruct corresponds to bmad `tao_global_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 638.

    Attributes
    ----------
    beam_dead_cutoff : float
        Percentage of dead particles at which beam tracking is stopped.
        Bmad type: real
        Fortran default: 0.99
    beam_timer_on : bool
        For timing the beam tracking calculation.
        Bmad type: logical
        Fortran default: .false.
    blank_line_between_commands : bool
        Add a blank line between command output?
        Bmad type: logical
        Fortran default: .true.
    box_plots : bool
        For debugging plot layout issues.
        Bmad type: logical
        Fortran default: .false.
    bunch_to_plot : int
        Which bunch to plot
        Bmad type: integer
        Fortran default: 1
    cmd_file_abort_on_error : bool
        Abort open command files if there is an error?
        Bmad type: logical
        Fortran default: .true.
    concatenate_maps : bool
        False => tracking using DA.
        Bmad type: logical
        Fortran default: .false.
    datum_err_messages_max : int
        Maximum number of error messages per call to lattice_calc.
        Bmad type: integer
        Fortran default: 10
    de_lm_step_ratio : float
        Scaling for step sizes between DE and LM optimizers.
        Bmad type: real
        Fortran default: 1
    de_var_to_population_factor : float
        DE population = max(n_var*factor, 20)
        Bmad type: real
        Fortran default: 5.0_rp
    debug_on : bool
        For debugging.
        Bmad type: logical
        Fortran default: .false.
    default_branch : int
        Default lattice branch to work with.
        Bmad type: integer
        Fortran default: 0
    default_universe : int
        Default universe to work with.
        Bmad type: integer
        Fortran default: 1
    delta_e_chrom : float
        Delta E used from chrom calc.
        Bmad type: real
        Fortran default: 0
    derivative_recalc : bool
        Recalc before each optimizer run?
        Bmad type: logical
        Fortran default: .true.
    derivative_uses_design : bool
        Derivative calc uses design lattice instead of model?
        Bmad type: logical
        Fortran default: .false.
    disable_smooth_line_calc : bool
        Global disable of the smooth line calculation.
        Bmad type: logical
        Fortran default: .false.
    dmerit_stop_value : float
        Fractional Merit change below which an optimizer will stop.
        Bmad type: real
        Fortran default: 0
    draw_curve_off_scale_warn : bool
        Display warning on graphs?
        Bmad type: logical
        Fortran default: .true.
    external_plotting : bool
        Used with matplotlib and gui.
        Bmad type: logical
        Fortran default: .false.
    history_file : str
        Bmad type: character
        Fortran default: '~/.history_tao'
    init_lat_sigma_from_beam : bool
        Initial lattice derived sigma matrix derived from beam dist?
        Bmad type: logical
        Fortran default: .false.
    label_keys : bool
        For lat_layout plots
        Bmad type: logical
        Fortran default: .true.
    label_lattice_elements : bool
        For lat_layout plots
        Bmad type: logical
        Fortran default: .true.
    lattice_calc_on : bool
        Turn on/off beam and single particle calculations.
        Bmad type: logical
        Fortran default: .true.
    lm_opt_deriv_reinit : float
        Reinit derivative matrix cutoff
        Bmad type: real
        Fortran default: -1
    lmdif_eps : float
        Tollerance for lmdif optimizer.
        Bmad type: real
        Fortran default: 1e-12
    lmdif_negligible_merit : float
        Bmad type: real
        Fortran default: 1d-30
    max_plot_time : float
        If plotting time (seconds) exceeds this than a message is generated.
        Bmad type: real
        Fortran default: 5
    merit_stop_value : float
        Merit value below which an optimizer will stop.
        Bmad type: real
        Fortran default: 0
    n_opti_cycles : int
        Number of optimization cycles
        Bmad type: integer
        Fortran default: 20
    n_opti_loops : int
        Number of optimization loops
        Bmad type: integer
        Fortran default: 1
    n_threads : int
        Number of OpenMP threads for parallel calculations.
        Bmad type: integer
        Fortran default: 1
    n_top10_merit : int
        Number of top merit constraints to print.
        Bmad type: integer
        Fortran default: 10
    only_limit_opt_vars : bool
        Only apply limits to variables used in optimization.
        Bmad type: logical
        Fortran default: .false.
    opt_match_auto_recalc : bool
        Set recalc = True for match elements before each cycle?
        Bmad type: logical
        Fortran default: .false.
    opt_with_base : bool
        Use base data in optimization?
        Bmad type: logical
        Fortran default: .false.
    opt_with_ref : bool
        Use reference data in optimization?
        Bmad type: logical
        Fortran default: .false.
    opti_write_var_file : bool
        "run" command writes var_out_file
        Bmad type: logical
        Fortran default: .true.
    optimizer : str
        optimizer to use.
        Bmad type: character
        Fortran default: 'lm'
    optimizer_allow_user_abort : bool
        See Tao manual for more details.
        Bmad type: logical
        Fortran default: .true.
    optimizer_var_limit_warn : bool
        Warn when vars reach a limit with optimization.
        Bmad type: logical
        Fortran default: .true.
    phase_units : int
        Phase units on output.
        Bmad type: integer
        Fortran default: radians$
    plot_on : bool
        Do plotting?
        Bmad type: logical
        Fortran default: .true.
    print_command : str
        Bmad type: character
        Fortran default: 'lpr'
    prompt_color : str
        See read_a_line routine for possible settings.
        Bmad type: character
        Fortran default: 'DEFAULT'
    prompt_string : str
        Bmad type: character
        Fortran default: 'Tao'
    quiet : str
        Print I/O when running a command file?
        Bmad type: character
        Fortran default: 'off'
    rad_int_user_calc_on : bool
        User set radiation integrals calculation on/off.
        Bmad type: logical
        Fortran default: .true.
    random_engine : str
        Non-beam random number engine
        Bmad type: character
        Fortran default: ''
    random_gauss_converter : str
        Non-beam
        Bmad type: character
        Fortran default: ''
    random_seed : int
        Use system clock by default
        Bmad type: integer
        Fortran default: -1
    random_sigma_cutoff : float
        Cut-off in sigmas.
        Bmad type: real
        Fortran default: -1
    rf_on : bool
        RFcavities on or off? Does not affect lcavities.
        Bmad type: logical
        Fortran default: .true.
    single_step : bool
        For debugging and demonstrations: Single step through a command file?
        Bmad type: logical
        Fortran default: .false.
    srdt_gen_n_slices : int
        Number times to slice elements for summation RDT calculation
        Bmad type: integer
        Fortran default: 10
    srdt_sxt_n_slices : int
        Number times to slice sextupoles for summation RDT calculation
        Bmad type: integer
        Fortran default: 20
    srdt_use_cache : bool
        Create cache for SRDT calculations.  Can use lots of memory if srdt_*_n_slices
        large.
        Bmad type: logical
        Fortran default: .true.
    stop_on_error : bool
        For debugging: False prevents tao from exiting on an error.
        Bmad type: logical
        Fortran default: .true.
    svd_cutoff : float
        SVD singular value cutoff.
        Bmad type: real
        Fortran default: 1e-5
    svd_retreat_on_merit_increase : bool
        Bmad type: logical
        Fortran default: .true.
    symbol_import : bool
        Import symbols from lattice file(s)?
        Bmad type: logical
        Fortran default: .false.
    track_type : str
        or 'beam'
        Bmad type: character
        Fortran default: 'single'
    unstable_penalty : float
        Used in unstable_ring datum merit calculation.
        Bmad type: real
        Fortran default: 1e-3
    var_limits_on : bool
        Respect the variable limits?
        Bmad type: logical
        Fortran default: .true.
    var_out_file : str
        Bmad type: character
        Fortran default: 'var#.out'
    wait_for_cr_in_single_mode : bool
        For use with a python GUI.
        Bmad type: logical
        Fortran default: .false.
    """

    beam_dead_cutoff: float = pydantic.Field(
        default=0.99,
        description="Percentage of dead particles at which beam tracking is stopped.",
    )
    beam_timer_on: bool = pydantic.Field(
        default=False,
        description="For timing the beam tracking calculation.",
    )
    blank_line_between_commands: bool = pydantic.Field(
        default=True,
        description="Add a blank line between command output?",
    )
    box_plots: bool = pydantic.Field(
        default=False,
        description="For debugging plot layout issues.",
    )
    bunch_to_plot: int = pydantic.Field(
        default=1,
        description="Which bunch to plot",
    )
    cmd_file_abort_on_error: bool = pydantic.Field(
        default=True,
        description="Abort open command files if there is an error?",
    )
    concatenate_maps: bool = pydantic.Field(
        default=False,
        description="False => tracking using DA.",
    )
    datum_err_messages_max: int = pydantic.Field(
        default=10,
        description="Maximum number of error messages per call to lattice_calc.",
    )
    de_lm_step_ratio: float = pydantic.Field(
        default=1,
        description="Scaling for step sizes between DE and LM optimizers.",
    )
    de_var_to_population_factor: float = pydantic.Field(
        default=5.0,
        description="DE population = max(n_var*factor, 20)",
    )
    debug_on: bool = pydantic.Field(
        default=False,
        description="For debugging.",
    )
    default_branch: int = pydantic.Field(
        default=0,
        description="Default lattice branch to work with.",
    )
    default_universe: int = pydantic.Field(
        default=1,
        description="Default universe to work with.",
    )
    delta_e_chrom: float = pydantic.Field(
        default=0,
        description="Delta E used from chrom calc.",
    )
    derivative_recalc: bool = pydantic.Field(
        default=True,
        description="Recalc before each optimizer run?",
    )
    derivative_uses_design: bool = pydantic.Field(
        default=False,
        description="Derivative calc uses design lattice instead of model?",
    )
    disable_smooth_line_calc: bool = pydantic.Field(
        default=False,
        description="Global disable of the smooth line calculation.",
    )
    dmerit_stop_value: float = pydantic.Field(
        default=0,
        description="Fractional Merit change below which an optimizer will stop.",
    )
    draw_curve_off_scale_warn: bool = pydantic.Field(
        default=True,
        description="Display warning on graphs?",
    )
    external_plotting: bool = pydantic.Field(
        default=False,
        description="Used with matplotlib and gui.",
    )
    history_file: str = pydantic.Field(
        default="~/.history_tao",
        max_length=100,
    )
    init_lat_sigma_from_beam: bool = pydantic.Field(
        default=False,
        description="Initial lattice derived sigma matrix derived from beam dist?",
    )
    label_keys: bool = pydantic.Field(
        default=True,
        description="For lat_layout plots",
    )
    label_lattice_elements: bool = pydantic.Field(
        default=True,
        description="For lat_layout plots",
    )
    lattice_calc_on: bool = pydantic.Field(
        default=True,
        description="Turn on/off beam and single particle calculations.",
    )
    lm_opt_deriv_reinit: float = pydantic.Field(
        default=-1,
        description="Reinit derivative matrix cutoff",
    )
    lmdif_eps: float = pydantic.Field(
        default=1e-12,
        description="Tollerance for lmdif optimizer.",
    )
    lmdif_negligible_merit: float = pydantic.Field(
        default=1e-30,
    )
    max_plot_time: float = pydantic.Field(
        default=5,
        description="If plotting time (seconds) exceeds this than a message is generated.",
    )
    merit_stop_value: float = pydantic.Field(
        default=0,
        description="Merit value below which an optimizer will stop.",
    )
    n_opti_cycles: int = pydantic.Field(
        default=20,
        description="Number of optimization cycles",
    )
    n_opti_loops: int = pydantic.Field(
        default=1,
        description="Number of optimization loops",
    )
    n_threads: int = pydantic.Field(
        default=1,
        description="Number of OpenMP threads for parallel calculations.",
    )
    n_top10_merit: int = pydantic.Field(
        default=10,
        description="Number of top merit constraints to print.",
    )
    only_limit_opt_vars: bool = pydantic.Field(
        default=False,
        description="Only apply limits to variables used in optimization.",
    )
    opt_match_auto_recalc: bool = pydantic.Field(
        default=False,
        description="Set recalc = True for match elements before each cycle?",
    )
    opt_with_base: bool = pydantic.Field(
        default=False,
        description="Use base data in optimization?",
    )
    opt_with_ref: bool = pydantic.Field(
        default=False,
        description="Use reference data in optimization?",
    )
    opti_write_var_file: bool = pydantic.Field(
        default=True,
        description="'run' command writes var_out_file",
    )
    optimizer: str = pydantic.Field(
        default="lm",
        max_length=16,
        description="optimizer to use.",
    )
    optimizer_allow_user_abort: bool = pydantic.Field(
        default=True,
        description="See Tao manual for more details.",
    )
    optimizer_var_limit_warn: bool = pydantic.Field(
        default=True,
        description="Warn when vars reach a limit with optimization.",
    )
    phase_units: int = pydantic.Field(
        default=0,
        description="Phase units on output.",
    )
    plot_on: bool = pydantic.Field(
        default=True,
        description="Do plotting?",
    )
    print_command: str = pydantic.Field(
        default="lpr",
        max_length=40,
    )
    prompt_color: str = pydantic.Field(
        default="DEFAULT",
        max_length=16,
        description="See read_a_line routine for possible settings.",
    )
    prompt_string: str = pydantic.Field(
        default="Tao",
        max_length=40,
    )
    quiet: str = pydantic.Field(
        default="off",
        max_length=12,
        description="Print I/O when running a command file?",
    )
    rad_int_user_calc_on: bool = pydantic.Field(
        default=True,
        description="User set radiation integrals calculation on/off.",
    )
    random_engine: str = pydantic.Field(
        default="",
        max_length=16,
        description="Non-beam random number engine",
    )
    random_gauss_converter: str = pydantic.Field(
        default="",
        max_length=16,
        description="Non-beam",
    )
    random_seed: int = pydantic.Field(
        default=-1,
        description="Use system clock by default",
    )
    random_sigma_cutoff: float = pydantic.Field(
        default=-1,
        description="Cut-off in sigmas.",
    )
    rf_on: bool = pydantic.Field(
        default=True,
        description="RFcavities on or off? Does not affect lcavities.",
    )
    single_step: bool = pydantic.Field(
        default=False,
        description="For debugging and demonstrations: Single step through a command file?",
    )
    srdt_gen_n_slices: int = pydantic.Field(
        default=10,
        description="Number times to slice elements for summation RDT calculation",
    )
    srdt_sxt_n_slices: int = pydantic.Field(
        default=20,
        description="Number times to slice sextupoles for summation RDT calculation",
    )
    srdt_use_cache: bool = pydantic.Field(
        default=True,
        description=(
            "Create cache for SRDT calculations.  Can use lots of memory if "
            "srdt_*_n_slices large."
        ),
    )
    stop_on_error: bool = pydantic.Field(
        default=True,
        description="For debugging: False prevents tao from exiting on an error.",
    )
    svd_cutoff: float = pydantic.Field(
        default=1e-05,
        description="SVD singular value cutoff.",
    )
    svd_retreat_on_merit_increase: bool = pydantic.Field(
        default=True,
    )
    symbol_import: bool = pydantic.Field(
        default=False,
        description="Import symbols from lattice file(s)?",
    )
    track_type: str = pydantic.Field(
        default="single",
        max_length=16,
        description="or 'beam'",
    )
    unstable_penalty: float = pydantic.Field(
        default=0.001,
        description="Used in unstable_ring datum merit calculation.",
    )
    var_limits_on: bool = pydantic.Field(
        default=True,
        description="Respect the variable limits?",
    )
    var_out_file: str = pydantic.Field(
        default="var#.out",
        max_length=80,
    )
    wait_for_cr_in_single_mode: bool = pydantic.Field(
        default=False,
        description="For use with a python GUI.",
        validation_alias=pydantic.AliasChoices(
            "wait_for_cr_in_single_mode", "wait_for_CR_in_single_mode"
        ),
        serialization_alias="wait_for_CR_in_single_mode",
    )


class TaoGraphArrayStruct(pydantic.BaseModel):
    """
    TaoGraphArrayStruct corresponds to bmad `tao_graph_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 371.

    Attributes
    ----------
    g : TaoGraphStruct
        Bmad type: tao_graph_struct
    """

    g: TaoGraphStruct = pydantic.Field(
        default=None,
    )


class TaoGraphStruct(pydantic.BaseModel):
    """
    TaoGraphStruct corresponds to bmad `tao_graph_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 253.

    Attributes
    ----------
    allow_wrap_around : bool
        "Wrap" curves to extend past lattice boundaries?
        Bmad type: logical
        Fortran default: .true.
    box : int
        Defines which box the plot is put in.
        Bmad type: integer
        Fortran default: 0
    clip : bool
        Clip plot at graph boundary.
        Bmad type: logical
        Fortran default: .false.
    curve : TaoCurveStruct
        Bmad type: tao_curve_struct
    curve_legend : QpLegendStruct
        Bmad type: qp_legend_struct
        Fortran default: qp_legend_struct()
    curve_legend_origin : QpPointStruct
        Bmad type: qp_point_struct
        Fortran default: qp_point_struct()
    draw_axes : bool
        Draw axes, labels, etc?
        Bmad type: logical
        Fortran default: .true.
    draw_curve_legend : bool
        Legend for displaying curve info.
        Bmad type: logical
        Fortran default: .true.
    draw_grid : bool
        Draw a grid?
        Bmad type: logical
        Fortran default: .true.
    draw_only_good_user_data_or_vars : bool
        Bmad type: logical
        Fortran default: .true.
    draw_title : bool
        Bmad type: logical
        Fortran default: .true.
    floor_plan : TaoFloorPlanStruct
        Bmad type: tao_floor_plan_struct
        Fortran default: tao_floor_plan_struct()
    is_valid : bool
        EG: Bad x_axis_type.
        Bmad type: logical
        Fortran default: .false.
    ix_branch : int
        Branch in lattice. Used when there are no associated curves.
        Bmad type: integer
        Fortran default: -1
    ix_universe : int
        Used for lat_layout plots.
        Bmad type: integer
        Fortran default: -1
    limited : bool
        True if at least one data point past graph bounds.
        Bmad type: logical
        Fortran default: .false.
    margin : QpRectStruct
        Margin around the graph.
        Bmad type: qp_rect_struct
        Fortran default: qp_rect_struct()
    name : str
        Name identifying the graph
        Bmad type: character
        Fortran default: ''
    p : TaoPlotStruct
        pointer to parent plot
        Bmad type: tao_plot_struct
        Fortran default: null()
    scale_margin : QpRectStruct
        Margin for scaling
        Bmad type: qp_rect_struct
        Fortran default: qp_rect_struct()
    symbol_size_scale : float
        Symbol size scale factor for phase_space plots.
        Bmad type: real
        Fortran default: 0
    text_legend : str
        Array for holding descriptive info.
        Bmad type: character
        Fortran default: ''
    text_legend_origin : QpPointStruct
        Bmad type: qp_point_struct
        Fortran default: qp_point_struct()
    text_legend_out : str
        Array for holding descriptive info.
        Bmad type: character
        Fortran default: ''
    title : str
        Bmad type: character
        Fortran default: ''
    title_suffix : str
        Bmad type: character
        Fortran default: ''
    type : str
        'data', 'lat_layout', 'phase_space', 'histogram', 'dynamic_aperture'
        Bmad type: character
        Fortran default: ''
    why_invalid : str
        Informative string to print.
        Bmad type: character
        Fortran default: '???'
    x : QpAxisStruct
        X-axis parameters.
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    x2 : QpAxisStruct
        X2-axis attributes (Not currently used).
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    x_axis_scale_factor : float
        x-axis conversion from internal to plotting units.
        Bmad type: real
        Fortran default: 1
    y : QpAxisStruct
        Y-axis attributes.
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    y2 : QpAxisStruct
        Y2-axis attributes.
        Bmad type: qp_axis_struct
        Fortran default: qp_axis_struct()
    y2_mirrors_y : bool
        Y2-axis same as Y-axis?
        Bmad type: logical
        Fortran default: .true.
    """

    allow_wrap_around: bool = pydantic.Field(
        default=True,
        description="'Wrap' curves to extend past lattice boundaries?",
    )
    box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=4,
        description="Defines which box the plot is put in.",
    )
    clip: bool = pydantic.Field(
        default=False,
        description="Clip plot at graph boundary.",
    )
    curve: Sequence[TaoCurveStruct] = pydantic.Field(
        default=None,
    )
    curve_legend: QpLegendStruct = pydantic.Field(
        default=None,
    )
    curve_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    draw_axes: bool = pydantic.Field(
        default=True,
        description="Draw axes, labels, etc?",
    )
    draw_curve_legend: bool = pydantic.Field(
        default=True,
        description="Legend for displaying curve info.",
    )
    draw_grid: bool = pydantic.Field(
        default=True,
        description="Draw a grid?",
    )
    draw_only_good_user_data_or_vars: bool = pydantic.Field(
        default=True,
    )
    draw_title: bool = pydantic.Field(
        default=True,
    )
    floor_plan: TaoFloorPlanStruct = pydantic.Field(
        default=None,
    )
    is_valid: bool = pydantic.Field(
        default=False,
        description="EG: Bad x_axis_type.",
    )
    ix_branch: int = pydantic.Field(
        default=-1,
        description="Branch in lattice. Used when there are no associated curves.",
    )
    ix_universe: int = pydantic.Field(
        default=-1,
        description="Used for lat_layout plots.",
    )
    limited: bool = pydantic.Field(
        default=False,
        description="True if at least one data point past graph bounds.",
    )
    margin: QpRectStruct = pydantic.Field(
        default=None,
        description="Margin around the graph.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name identifying the graph",
    )
    p: TaoPlotStruct = pydantic.Field(
        default=None,
        description="pointer to parent plot",
    )
    scale_margin: QpRectStruct = pydantic.Field(
        default=None,
        description="Margin for scaling",
    )
    symbol_size_scale: float = pydantic.Field(
        default=0,
        description="Symbol size scale factor for phase_space plots.",
    )
    text_legend: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="Array for holding descriptive info.",
    )
    text_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    text_legend_out: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="Array for holding descriptive info.",
    )
    title: str = pydantic.Field(
        default="",
        max_length=100,
    )
    title_suffix: str = pydantic.Field(
        default="",
        max_length=100,
    )
    type: str = pydantic.Field(
        default="",
        max_length=40,
        description="'data', 'lat_layout', 'phase_space', 'histogram', 'dynamic_aperture'",
    )
    why_invalid: str = pydantic.Field(
        default="???",
        max_length=80,
        description="Informative string to print.",
    )
    x: QpAxisStruct = pydantic.Field(
        default=None,
        description="X-axis parameters.",
    )
    x2: QpAxisStruct = pydantic.Field(
        default=None,
        description="X2-axis attributes (Not currently used).",
    )
    x_axis_scale_factor: float = pydantic.Field(
        default=1,
        description="x-axis conversion from internal to plotting units.",
    )
    y: QpAxisStruct = pydantic.Field(
        default=None,
        description="Y-axis attributes.",
    )
    y2: QpAxisStruct = pydantic.Field(
        default=None,
        description="Y2-axis attributes.",
    )
    y2_mirrors_y: bool = pydantic.Field(
        default=True,
        description="Y2-axis same as Y-axis?",
    )


class TaoHistogramStruct(pydantic.BaseModel):
    """
    TaoHistogramStruct corresponds to bmad `tao_histogram_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 162.

    Attributes
    ----------
    center : float
        Bmad type: real
        Fortran default: 0
    density_normalized : bool
        Bmad type: logical
        Fortran default: .false.
    maximum : float
        Computed by Tao. Not User settable.
        Bmad type: real
        Fortran default: 0
    minimum : float
        Computed by Tao. Not User settable.
        Bmad type: real
        Fortran default: 0
    number : int
        Bmad type: integer
        Fortran default: 0
    weight_by_charge : bool
        Bmad type: logical
        Fortran default: .true.
    width : float
        Bmad type: real
        Fortran default: 0
    """

    center: float = pydantic.Field(
        default=0,
    )
    density_normalized: bool = pydantic.Field(
        default=False,
    )
    maximum: float = pydantic.Field(
        default=0,
        description="Computed by Tao. Not User settable.",
    )
    minimum: float = pydantic.Field(
        default=0,
        description="Computed by Tao. Not User settable.",
    )
    number: int = pydantic.Field(
        default=0,
    )
    weight_by_charge: bool = pydantic.Field(
        default=True,
    )
    width: float = pydantic.Field(
        default=0,
    )


class TaoInitStruct(pydantic.BaseModel):
    """
    TaoInitStruct corresponds to bmad `tao_init_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 791.

    Attributes
    ----------
    beam_file_arg : str
        -beam_file           command line argument.
        Bmad type: character
        Fortran default: ''
    beam_init_position_file_arg : str
        -beam_init_position_file command line argument.
        Bmad type: character
        Fortran default: ''
    building_wall_file_arg : str
        -building_wall_file  command line argument.
        Bmad type: character
        Fortran default: ''
    command_arg : str
        -command             command line argument.
        Bmad type: character
        Fortran default: ''
    data_file_arg : str
        -data_file           command line argument.
        Bmad type: character
        Fortran default: ''
    debug_arg : str
        -debug               command line argument
        Bmad type: character
        Fortran default: ''
    debug_switch : bool
        Is the "-debug" switch present?
        Bmad type: logical
        Fortran default: .false.
    disable_smooth_line_calc_arg : str
        -disable_smooth_line_calc
        Bmad type: character
        Fortran default: ''
    external_plotting_switch : bool
        Is "-external_plotting" switch present?
        Bmad type: logical
        Fortran default: .false.
    geometry_arg : str
        -geometry            command line argument.
        Bmad type: character
        Fortran default: ''
    hook_beam_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_building_wall_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_data_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_init_file : str
        Bmad type: character
        Fortran default: ''
    hook_init_file_arg : str
        -hook_init_file      command line argument
        Bmad type: character
        Fortran default: ''
    hook_lat_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_plot_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_startup_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_var_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    init_file_arg : str
        -init_file           command line argument.
        Bmad type: character
        Fortran default: ''
    init_file_arg_path : str
        Path part of init_tao_file
        Bmad type: character
        Fortran default: ''
    init_name : str
        label for initialization
        Bmad type: character
        Fortran default: 'Tao'
    lattice_file_arg : str
        -lattice_file        command line argument.
        Bmad type: character
        Fortran default: ''
    log_startup_arg : str
        -log_startup         command line argument
        Bmad type: character
        Fortran default: ''
    no_rad_int_arg : str
        -no_rad_int          command line argument
        Bmad type: character
        Fortran default: ''
    no_stopping_arg : str
        -no_stopping         command line argument
        Bmad type: character
        Fortran default: ''
    noinit_arg : str
        -noinit              command line argument
        Bmad type: character
        Fortran default: ''
    noplot_arg : str
        -noplot              command line argument
        Bmad type: character
        Fortran default: ''
    nostartup_arg : str
        -nostartup           command line argument
        Bmad type: character
        Fortran default: ''
    parse_cmd_args : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    plot_file_arg : str
        -plot_file           command line argument.
        Bmad type: character
        Fortran default: ''
    prompt_color_arg : str
        -prompt_color        command line argument
        Bmad type: character
        Fortran default: ''
    quiet_arg : str
        -quiet               command line argument
        Bmad type: character
        Fortran default: ''
    reverse_arg : str
        -reverse             command line argument
        Bmad type: character
        Fortran default: ''
    rf_on_arg : str
        -rf_on               command line argument
        Bmad type: character
        Fortran default: ''
    slice_lattice_arg : str
        -slice_lattice       command line argument.
        Bmad type: character
        Fortran default: ''
    start_branch_at_arg : str
        -start_branch_at     command line argument.
        Bmad type: character
        Fortran default: ''
    startup_file_arg : str
        -startup_file        command line argument.
        Bmad type: character
        Fortran default: ''
    symbol_import_arg : str
        -symbol_import       command line argument
        Bmad type: character
        Fortran default: ''
    unique_name_suffix : str
        Bmad type: character
        Fortran default: ''
    var_file_arg : str
        -var_file            command line argument.
        Bmad type: character
        Fortran default: ''
    """

    beam_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-beam_file           command line argument.",
    )
    beam_init_position_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-beam_init_position_file command line argument.",
    )
    building_wall_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-building_wall_file  command line argument.",
    )
    command_arg: str = pydantic.Field(
        default="",
        max_length=500,
        description="-command             command line argument.",
    )
    data_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-data_file           command line argument.",
    )
    debug_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-debug               command line argument",
    )
    debug_switch: bool = pydantic.Field(
        default=False,
        description="Is the '-debug' switch present?",
    )
    disable_smooth_line_calc_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-disable_smooth_line_calc",
    )
    external_plotting_switch: bool = pydantic.Field(
        default=False,
        description="Is '-external_plotting' switch present?",
    )
    geometry_arg: str = pydantic.Field(
        default="",
        max_length=16,
        description="-geometry            command line argument.",
    )
    hook_beam_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_building_wall_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_data_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_init_file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    hook_init_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-hook_init_file      command line argument",
    )
    hook_lat_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_plot_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_startup_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_var_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    init_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-init_file           command line argument.",
    )
    init_file_arg_path: str = pydantic.Field(
        default="",
        max_length=400,
        description="Path part of init_tao_file",
    )
    init_name: str = pydantic.Field(
        default="Tao",
        max_length=16,
        description="label for initialization",
    )
    lattice_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-lattice_file        command line argument.",
    )
    log_startup_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-log_startup         command line argument",
    )
    no_rad_int_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-no_rad_int          command line argument",
    )
    no_stopping_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-no_stopping         command line argument",
    )
    noinit_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-noinit              command line argument",
    )
    noplot_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-noplot              command line argument",
    )
    nostartup_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-nostartup           command line argument",
    )
    parse_cmd_args: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    plot_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-plot_file           command line argument.",
    )
    prompt_color_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-prompt_color        command line argument",
    )
    quiet_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-quiet               command line argument",
    )
    reverse_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-reverse             command line argument",
    )
    rf_on_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-rf_on               command line argument",
    )
    slice_lattice_arg: str = pydantic.Field(
        default="",
        max_length=80,
        description="-slice_lattice       command line argument.",
    )
    start_branch_at_arg: str = pydantic.Field(
        default="",
        max_length=40,
        description="-start_branch_at     command line argument.",
    )
    startup_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-startup_file        command line argument.",
    )
    symbol_import_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-symbol_import       command line argument",
    )
    unique_name_suffix: str = pydantic.Field(
        default="",
        max_length=100,
    )
    var_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-var_file            command line argument.",
    )


class TaoIntegerArrayStruct(pydantic.BaseModel):
    """
    TaoIntegerArrayStruct corresponds to bmad `tao_integer_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 80.

    Attributes
    ----------
    i : int
        Bmad type: integer, pointer
        Fortran default: null()
    """

    i: int = pydantic.Field(
        default=0,
    )


class TaoLatModeStruct(pydantic.BaseModel):
    """
    TaoLatModeStruct corresponds to bmad `tao_lat_mode_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 869.

    Attributes
    ----------
    chrom : float
        Bmad type: real
    growth_rate : float
        Bmad type: real
    """

    chrom: float = pydantic.Field(
        default=0.0,
    )
    growth_rate: float = pydantic.Field(
        default=0.0,
    )


class TaoLatSigmaStruct(pydantic.BaseModel):
    """
    TaoLatSigmaStruct corresponds to bmad `tao_lat_sigma_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 874.

    Attributes
    ----------
    mat : float
        Bmad type: real
        Fortran default: 0
    """

    mat: Sequence[float] = pydantic.Field(
        default=0,
    )


class TaoLatticeBranchStruct(pydantic.BaseModel):
    """
    TaoLatticeBranchStruct corresponds to bmad `tao_lattice_branch_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 923.

    Attributes
    ----------
    a : TaoLatModeStruct
        Bmad type: tao_lat_mode_struct
    b : TaoLatModeStruct
        Bmad type: tao_lat_mode_struct
    bmad_normal_form : BmadNormalFormStruct
        Bmad type: bmad_normal_form_struct
    bunch_params : BunchParamsStruct
        Per element
        Bmad type: bunch_params_struct
    bunch_params_comb : BunchTrackStruct
        A comb for each bunch in beam.
        Bmad type: bunch_track_struct
    cache_n_pts : int
        Bmad type: integer
        Fortran default: 0
    cache_x_max : float
        Bmad type: real
        Fortran default: 0
    cache_x_min : float
        Bmad type: real
        Fortran default: 0
    comb_ds_save : float
        Master parameter for %bunch_params_comb(:)%ds_save
        Bmad type: real
        Fortran default: -1
    has_open_match_element : bool
        Bmad type: logical
        Fortran default: .false.
    high_e_orb : CoordStruct
        Bmad type: coord_struct
    ix_rad_int_cache : int
        Radiation integrals cache index.
        Bmad type: integer
    lat_sigma : TaoLatSigmaStruct
        Sigma matrix derived from lattice (not beam).
        Bmad type: tao_lat_sigma_struct
    low_e_orb : CoordStruct
        Bmad type: coord_struct
    mode_flip_here : bool
        Twiss parameter mode flip seen?
        Bmad type: logical
        Fortran default: .false.
    modes_6d : NormalModesStruct
        6D radiation matrices.
        Bmad type: normal_modes_struct
    modes_ri : NormalModesStruct
        Synchrotron integrals stuff
        Bmad type: normal_modes_struct
    n_hterms : int
        Number of distinct res driving terms to evaluate.
        Bmad type: integer
        Fortran default: 0
    orb0 : CoordStruct
        For saving beginning orbit
        Bmad type: coord_struct
    orbit : CoordStruct
        Bmad type: coord_struct
    plot_cache : TaoPlotCacheStruct
        Plotting data cache
        Bmad type: tao_plot_cache_struct
    plot_cache_valid : bool
        Valid plotting data cache?
        Bmad type: logical
        Fortran default: .false.
    ptc_normal_form : PtcNormalFormStruct
        Bmad type: ptc_normal_form_struct
    spin : TaoSpinPolarizationStruct
        Bmad type: tao_spin_polarization_struct
    spin_ele : TaoSpinEleStruct
        Spin stuff
        Bmad type: tao_spin_ele_struct
    spin_map_valid : bool
        Bmad type: logical
        Fortran default: .false.
    srdt : SummationRdtStruct
        Bmad type: summation_rdt_struct
    tao_lat : TaoLatticeStruct
        Parent tao_lat
        Bmad type: tao_lattice_struct
        Fortran default: null()
    track_state : int
        Bmad type: integer
    twiss_valid : bool
        Invalid EG with unstable 1-turn matrix with a closed branch. With open branch:
        twiss_valid = T even if some Twiss (and orbit) is invalid.
        Bmad type: logical
        Fortran default: .true.
    """

    a: TaoLatModeStruct = pydantic.Field(
        default=None,
    )
    b: TaoLatModeStruct = pydantic.Field(
        default=None,
    )
    bmad_normal_form: BmadNormalFormStruct = pydantic.Field(
        default=None,
    )
    bunch_params: Sequence[BunchParamsStruct] = pydantic.Field(
        default=None,
        description="Per element",
    )
    bunch_params_comb: Sequence[BunchTrackStruct] = pydantic.Field(
        default=None,
        description="A comb for each bunch in beam.",
    )
    cache_n_pts: int = pydantic.Field(
        default=0,
    )
    cache_x_max: float = pydantic.Field(
        default=0,
    )
    cache_x_min: float = pydantic.Field(
        default=0,
    )
    comb_ds_save: float = pydantic.Field(
        default=-1,
        description="Master parameter for %bunch_params_comb(:)%ds_save",
    )
    has_open_match_element: bool = pydantic.Field(
        default=False,
    )
    high_e_orb: Sequence[CoordStruct] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("high_e_orb", "high_E_orb"),
        serialization_alias="high_E_orb",
    )
    ix_rad_int_cache: int = pydantic.Field(
        default=0,
        description="Radiation integrals cache index.",
    )
    lat_sigma: Sequence[TaoLatSigmaStruct] = pydantic.Field(
        default=None,
        description="Sigma matrix derived from lattice (not beam).",
    )
    low_e_orb: Sequence[CoordStruct] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("low_e_orb", "low_E_orb"),
        serialization_alias="low_E_orb",
    )
    mode_flip_here: bool = pydantic.Field(
        default=False,
        description="Twiss parameter mode flip seen?",
    )
    modes_6d: NormalModesStruct = pydantic.Field(
        default=None,
        description="6D radiation matrices.",
    )
    modes_ri: NormalModesStruct = pydantic.Field(
        default=None,
        description="Synchrotron integrals stuff",
    )
    n_hterms: int = pydantic.Field(
        default=0,
        description="Number of distinct res driving terms to evaluate.",
    )
    orb0: CoordStruct = pydantic.Field(
        default=None,
        description="For saving beginning orbit",
    )
    orbit: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )
    plot_cache: Sequence[TaoPlotCacheStruct] = pydantic.Field(
        default=None,
        description="Plotting data cache",
    )
    plot_cache_valid: bool = pydantic.Field(
        default=False,
        description="Valid plotting data cache?",
    )
    ptc_normal_form: PtcNormalFormStruct = pydantic.Field(
        default=None,
    )
    spin: TaoSpinPolarizationStruct = pydantic.Field(
        default=None,
    )
    spin_ele: Sequence[TaoSpinEleStruct] = pydantic.Field(
        default=None,
        description="Spin stuff",
    )
    spin_map_valid: bool = pydantic.Field(
        default=False,
    )
    srdt: SummationRdtStruct = pydantic.Field(
        default=None,
    )
    tao_lat: TaoLatticeStruct = pydantic.Field(
        default=None,
        description="Parent tao_lat",
    )
    track_state: int = pydantic.Field(
        default=0,
    )
    twiss_valid: bool = pydantic.Field(
        default=True,
        description=(
            "Invalid EG with unstable 1-turn matrix with a closed branch. With open "
            "branch: twiss_valid = T even if some Twiss (and orbit) is invalid."
        ),
    )


class TaoLatticeStruct(pydantic.BaseModel):
    """
    TaoLatticeStruct corresponds to bmad `tao_lattice_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 957.

    Attributes
    ----------
    chrom_calc_ok : bool
        Bmad type: logical
        Fortran default: .false.
    high_e_lat : LatStruct
        For chrom calc.
        Bmad type: lat_struct
    lat : LatStruct
        lattice structures
        Bmad type: lat_struct
    low_e_lat : LatStruct
        For chrom calc.
        Bmad type: lat_struct
    name : str
        "model", "base", or "design".
        Bmad type: character
    rad_int_by_ele_6d : RadIntAllEleStruct
        Bmad type: rad_int_all_ele_struct
    rad_int_by_ele_ri : RadIntAllEleStruct
        Bmad type: rad_int_all_ele_struct
    tao_branch : TaoLatticeBranchStruct
        Bmad type: tao_lattice_branch_struct
    u : TaoUniverseStruct
        Parent universe
        Bmad type: tao_universe_struct
        Fortran default: null()
    """

    chrom_calc_ok: bool = pydantic.Field(
        default=False,
    )
    high_e_lat: LatStruct = pydantic.Field(
        default=None,
        description="For chrom calc.",
        validation_alias=pydantic.AliasChoices("high_e_lat", "high_E_lat"),
        serialization_alias="high_E_lat",
    )
    lat: LatStruct = pydantic.Field(
        default=None,
        description="lattice structures",
    )
    low_e_lat: LatStruct = pydantic.Field(
        default=None,
        description="For chrom calc.",
        validation_alias=pydantic.AliasChoices("low_e_lat", "low_E_lat"),
        serialization_alias="low_E_lat",
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=8,
        description="'model', 'base', or 'design'.",
    )
    rad_int_by_ele_6d: RadIntAllEleStruct = pydantic.Field(
        default=None,
    )
    rad_int_by_ele_ri: RadIntAllEleStruct = pydantic.Field(
        default=None,
    )
    tao_branch: Sequence[TaoLatticeBranchStruct] = pydantic.Field(
        default=None,
    )
    u: TaoUniverseStruct = pydantic.Field(
        default=None,
        description="Parent universe",
    )


class TaoLogicalArrayStruct(pydantic.BaseModel):
    """
    TaoLogicalArrayStruct corresponds to bmad `tao_logical_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 76.

    Attributes
    ----------
    L : bool
        Bmad type: logical, pointer
        Fortran default: null()
    """

    L: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("L", "l"),
        serialization_alias="l",
    )


class TaoModelBranchStruct(pydantic.BaseModel):
    """
    TaoModelBranchStruct corresponds to bmad `tao_model_branch_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1000.

    Attributes
    ----------
    beam : TaoBeamBranchStruct
        Bmad type: tao_beam_branch_struct
    ele : TaoModelElementStruct
        Per element information
        Bmad type: tao_model_element_struct
    """

    beam: TaoBeamBranchStruct = pydantic.Field(
        default=None,
    )
    ele: Sequence[TaoModelElementStruct] = pydantic.Field(
        default=None,
        description="Per element information",
    )


class TaoModelElementStruct(pydantic.BaseModel):
    """
    TaoModelElementStruct corresponds to bmad `tao_model_element_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 975.

    Attributes
    ----------
    beam : BeamStruct
        Beam distribution at element.
        Bmad type: beam_struct
    save_beam_internally : bool
        Save beam here? Beam also saved at fork elements and at track ends.
        Bmad type: logical
    save_beam_to_file : bool
        Save beam to a file? Beam also saved at fork elements and at track ends.
        Bmad type: logical
    """

    beam: BeamStruct = pydantic.Field(
        default=None,
        description="Beam distribution at element.",
    )
    save_beam_internally: bool = pydantic.Field(
        default=False,
        description="Save beam here? Beam also saved at fork elements and at track ends.",
    )
    save_beam_to_file: bool = pydantic.Field(
        default=False,
        description="Save beam to a file? Beam also saved at fork elements and at track ends.",
    )


class TaoMpiStruct(pydantic.BaseModel):
    """
    TaoMpiStruct corresponds to bmad `tao_mpi_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1037.

    Attributes
    ----------
    host_name : str
        Name of the host machine
        Bmad type: character
        Fortran default: ''
    master : bool
        Is this the master task? If yes, rank == 0
        Bmad type: logical
        Fortran default: .true.
    max_rank : int
        Maximum rank, should be n_tasks-1
        Bmad type: integer
        Fortran default: 0
    on : bool
        Is MPI on?
        Bmad type: logical
        Fortran default: .false.
    rank : int
        Rank of task (rank is 0, 1, 2, ... n_tasks-1 )
        Bmad type: integer
        Fortran default: 0
    """

    host_name: str = pydantic.Field(
        default="",
        max_length=200,
        description="Name of the host machine",
    )
    master: bool = pydantic.Field(
        default=True,
        description="Is this the master task? If yes, rank == 0",
    )
    max_rank: int = pydantic.Field(
        default=0,
        description="Maximum rank, should be n_tasks-1",
    )
    on: bool = pydantic.Field(
        default=False,
        description="Is MPI on?",
    )
    rank: int = pydantic.Field(
        default=0,
        description="Rank of task (rank is 0, 1, 2, ... n_tasks-1 )",
    )


class TaoPingScaleStruct(pydantic.BaseModel):
    """
    TaoPingScaleStruct corresponds to bmad `tao_ping_scale_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1090.

    Attributes
    ----------
    a_mode_meas : float
        Bmad type: real
        Fortran default: 1
    a_mode_ref : float
        Bmad type: real
        Fortran default: 1
    b_mode_meas : float
        Bmad type: real
        Fortran default: 1
    b_mode_ref : float
        Bmad type: real
        Fortran default: 1
    """

    a_mode_meas: float = pydantic.Field(
        default=1,
    )
    a_mode_ref: float = pydantic.Field(
        default=1,
    )
    b_mode_meas: float = pydantic.Field(
        default=1,
    )
    b_mode_ref: float = pydantic.Field(
        default=1,
    )


class TaoPlotArrayStruct(pydantic.BaseModel):
    """
    TaoPlotArrayStruct corresponds to bmad `tao_plot_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 367.

    Attributes
    ----------
    p : TaoPlotStruct
        Bmad type: tao_plot_struct
    """

    p: TaoPlotStruct = pydantic.Field(
        default=None,
    )


class TaoPlotCacheStruct(pydantic.BaseModel):
    """
    TaoPlotCacheStruct corresponds to bmad `tao_plot_cache_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 913.

    Attributes
    ----------
    ele : EleStruct
        Bmad type: ele_struct
    err : bool
        Bmad type: logical
    orbit : CoordStruct
        Bmad type: coord_struct
    """

    ele: EleStruct = pydantic.Field(
        default=None,
    )
    err: bool = pydantic.Field(
        default=False,
    )
    orbit: CoordStruct = pydantic.Field(
        default=None,
    )


class TaoPlotPageStruct(pydantic.BaseModel):
    """
    TaoPlotPageStruct corresponds to bmad `tao_plot_page_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 333.

    Attributes
    ----------
    axis_label_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.0
    axis_number_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    border : QpRectStruct
        Border around plots edge of page.
        Bmad type: qp_rect_struct
        Fortran default: qp_rect_struct()
    delete_overlapping_plots : bool
        Delete overlapping plots when a plot is placed?
        Bmad type: logical
        Fortran default: .true.
    draw_graph_title_suffix : bool
        Draw the graph title suffix?
        Bmad type: logical
        Fortran default: .true.
    floor_plan : TaoDrawingStruct
        Bmad type: tao_drawing_struct
        Fortran default: tao_drawing_struct(null())
    floor_plan_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    floor_plan_text_scale : float
        Scale used = floor_plan_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    graph_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.1
    id_window : int
        X window id number.
        Bmad type: integer
        Fortran default: -1
    key_table_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    lat_layout : TaoDrawingStruct
        Bmad type: tao_drawing_struct
        Fortran default: tao_drawing_struct(null())
    lat_layout_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    lat_layout_text_scale : float
        Scale used = lat_layout_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    legend_text_scale : float
        Relative to text_height. For legends, plot_page, and lat_layout
        Bmad type: real
        Fortran default: 0.9
    main_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.3
    n_curve_pts : int
        Default number of points for plotting a smooth curve.
        Bmad type: integer
        Fortran default: n_curve_pts_init$
    pattern : TaoShapePatternStruct
        Bmad type: tao_shape_pattern_struct
    plot_display_type : str
        'X' or 'TK'
        Bmad type: character
        Fortran default: 'X'
    region : TaoPlotRegionStruct
        Bmad type: tao_plot_region_struct
    size : float
        width and height of plot window in pixels.
        Bmad type: real
        Fortran default: 0
    subtitle : TaoTitleStruct
        Subtitle below title at top of page.
        Bmad type: tao_title_struct
        Fortran default: tao_title_struct()
    template : TaoPlotStruct
        Templates for the plots.
        Bmad type: tao_plot_struct
    text_height : float
        In points. Scales the height of all text
        Bmad type: real
        Fortran default: 12
    title : TaoTitleStruct
        Title  at top of page.
        Bmad type: tao_title_struct
        Fortran default: tao_title_struct()
    """

    axis_label_text_scale: float = pydantic.Field(
        default=1.0,
        description="Relative to text_height",
    )
    axis_number_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    border: QpRectStruct = pydantic.Field(
        default=None,
        description="Border around plots edge of page.",
    )
    delete_overlapping_plots: bool = pydantic.Field(
        default=True,
        description="Delete overlapping plots when a plot is placed?",
    )
    draw_graph_title_suffix: bool = pydantic.Field(
        default=True,
        description="Draw the graph title suffix?",
    )
    floor_plan: TaoDrawingStruct = pydantic.Field(
        default=None,
    )
    floor_plan_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    floor_plan_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = floor_plan_text_scale * legend_text_scale",
    )
    graph_title_text_scale: float = pydantic.Field(
        default=1.1,
        description="Relative to text_height",
    )
    id_window: int = pydantic.Field(
        default=-1,
        description="X window id number.",
    )
    key_table_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    lat_layout: TaoDrawingStruct = pydantic.Field(
        default=None,
    )
    lat_layout_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    lat_layout_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = lat_layout_text_scale * legend_text_scale",
    )
    legend_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height. For legends, plot_page, and lat_layout",
    )
    main_title_text_scale: float = pydantic.Field(
        default=1.3,
        description="Relative to text_height",
    )
    n_curve_pts: int = pydantic.Field(
        default=0,
        description="Default number of points for plotting a smooth curve.",
    )
    pattern: Sequence[TaoShapePatternStruct] = pydantic.Field(
        default=None,
    )
    plot_display_type: str = pydantic.Field(
        default="X",
        max_length=8,
        description="'X' or 'TK'",
    )
    region: Sequence[TaoPlotRegionStruct] = pydantic.Field(
        default=None,
    )
    size: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description="width and height of plot window in pixels.",
    )
    subtitle: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Subtitle below title at top of page.",
    )
    template: Sequence[TaoPlotStruct] = pydantic.Field(
        default=None,
        description="Templates for the plots.",
    )
    text_height: float = pydantic.Field(
        default=12,
        description="In points. Scales the height of all text",
    )
    title: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Title  at top of page.",
    )


class TaoPlotRegionStruct(pydantic.BaseModel):
    """
    TaoPlotRegionStruct corresponds to bmad `tao_plot_region_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 318.

    Attributes
    ----------
    list_with_show_plot_command : bool
        False used for default plots to shorten the output of "show plot"
        Bmad type: logical
        Fortran default: .true.
    location : float
        [x1, x2, y1, y2] location on page.
        Bmad type: real
        Fortran default: 0
    name : str
        Region name. Eg: 'r13', etc.
        Bmad type: character
        Fortran default: ''
    plot : TaoPlotStruct
        Plot associated with this region
        Bmad type: tao_plot_struct
    setup_done : bool
        Used for plot bookkeeping.
        Bmad type: logical
        Fortran default: .false.
    visible : bool
        To draw or not to draw.
        Bmad type: logical
        Fortran default: .false.
    """

    list_with_show_plot_command: bool = pydantic.Field(
        default=True,
        description="False used for default plots to shorten the output of 'show plot'",
    )
    location: Sequence[float] = pydantic.Field(
        default=0,
        max_length=4,
        description="[x1, x2, y1, y2] location on page.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Region name. Eg: 'r13', etc.",
    )
    plot: TaoPlotStruct = pydantic.Field(
        default=None,
        description="Plot associated with this region",
    )
    setup_done: bool = pydantic.Field(
        default=False,
        description="Used for plot bookkeeping.",
    )
    visible: bool = pydantic.Field(
        default=False,
        description="To draw or not to draw.",
    )


class TaoPlotStruct(pydantic.BaseModel):
    """
    TaoPlotStruct corresponds to bmad `tao_plot_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 295.

    Attributes
    ----------
    autoscale_gang_x : bool
        scale cmd scales graphs together?
        Bmad type: logical
        Fortran default: .true.
    autoscale_gang_y : bool
        scale cmd scales graphs together?
        Bmad type: logical
        Fortran default: .true.
    autoscale_x : bool
        Horizontal autoscale.
        Bmad type: logical
        Fortran default: .false.
    autoscale_y : bool
        Vertical autoscale.
        Bmad type: logical
        Fortran default: .false.
    default_plot : bool
        One of Tao's default plots?
        Bmad type: logical
        Fortran default: .false.
    description : str
        Descriptive string.
        Bmad type: character
        Fortran default: ''
    graph : TaoGraphStruct
        individual graphs of a plot
        Bmad type: tao_graph_struct
    ix_plot : int
        Index in s%plot_page%template(:) or %region(:) arrays.
        Bmad type: integer
        Fortran default: -1
    list_with_show_plot_command : bool
        False used for default plots to shorten the output of "show plot"
        Bmad type: logical
        Fortran default: .true.
    n_curve_pts : int
        Overrides s%plot_page%n_curve_pts.
        Bmad type: integer
        Fortran default: -1
    name : str
        Identifying name. Rule: If name is blank, plot is not valid.
        Bmad type: character
        Fortran default: ''
    phantom : bool
        Used by tao_plot_init to add info lines to "show plot -templates"
        Bmad type: logical
        Fortran default: .false.
    r : TaoPlotRegionStruct
        pointer to parent.
        Bmad type: tao_plot_region_struct
        Fortran default: null()
    type : str
        or 'wave'
        Bmad type: character
        Fortran default: 'normal'
    x_axis_type : str
        'index', 'ele_index', 's', 'none', 'floor', 'phase_space', etc.
        Bmad type: character
        Fortran default: ''
    """

    autoscale_gang_x: bool = pydantic.Field(
        default=True,
        description="scale cmd scales graphs together?",
    )
    autoscale_gang_y: bool = pydantic.Field(
        default=True,
        description="scale cmd scales graphs together?",
    )
    autoscale_x: bool = pydantic.Field(
        default=False,
        description="Horizontal autoscale.",
    )
    autoscale_y: bool = pydantic.Field(
        default=False,
        description="Vertical autoscale.",
    )
    default_plot: bool = pydantic.Field(
        default=False,
        description="One of Tao's default plots?",
    )
    description: str = pydantic.Field(
        default="",
        max_length=100,
        description="Descriptive string.",
    )
    graph: Sequence[TaoGraphStruct] = pydantic.Field(
        default=None,
        description="individual graphs of a plot",
    )
    ix_plot: int = pydantic.Field(
        default=-1,
        description="Index in s%plot_page%template(:) or %region(:) arrays.",
    )
    list_with_show_plot_command: bool = pydantic.Field(
        default=True,
        description="False used for default plots to shorten the output of 'show plot'",
    )
    n_curve_pts: int = pydantic.Field(
        default=-1,
        description="Overrides s%plot_page%n_curve_pts.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Identifying name. Rule: If name is blank, plot is not valid.",
    )
    phantom: bool = pydantic.Field(
        default=False,
        description="Used by tao_plot_init to add info lines to 'show plot -templates'",
    )
    r: TaoPlotRegionStruct = pydantic.Field(
        default=None,
        description="pointer to parent.",
    )
    type: str = pydantic.Field(
        default="normal",
        max_length=8,
        description="or 'wave'",
    )
    x_axis_type: str = pydantic.Field(
        default="",
        max_length=16,
        description="'index', 'ele_index', 's', 'none', 'floor', 'phase_space', etc.",
    )


class TaoRealPointerStruct(pydantic.BaseModel):
    """
    TaoRealPointerStruct corresponds to bmad `tao_real_pointer_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 70.

    Attributes
    ----------
    good_user : bool
        Bmad type: logical, pointer
        Fortran default: null()
    good_value : bool
        Bmad type: logical, pointer
        Fortran default: null()
    r : float
        Bmad type: real
        Fortran default: null()
    """

    good_user: bool = pydantic.Field(
        default=False,
    )
    good_value: bool = pydantic.Field(
        default=False,
    )
    r: float = pydantic.Field(
        default=0.0,
    )


class TaoRegionArrayStruct(pydantic.BaseModel):
    """
    TaoRegionArrayStruct corresponds to bmad `tao_region_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 363.

    Attributes
    ----------
    r : TaoPlotRegionStruct
        Bmad type: tao_plot_region_struct
    """

    r: TaoPlotRegionStruct = pydantic.Field(
        default=None,
    )


class TaoScratchSpaceStruct(pydantic.BaseModel):
    """
    TaoScratchSpaceStruct corresponds to bmad `tao_scratch_space_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 847.

    Attributes
    ----------
    attribs : AllPointerStruct
        Bmad type: all_pointer_struct
    axis1 : float
        Bmad type: real
    axis2 : float
        Bmad type: real
    axis3 : float
        Bmad type: real
    cc : TaoBeamShakeStruct
        Bmad type: tao_beam_shake_struct
    comp : TaoDataVarComponentStruct
        Bmad type: tao_data_var_component_struct
    d1_array : TaoD1DataArrayStruct
        Bmad type: tao_d1_data_array_struct
    eles : ElePointerStruct
        Bmad type: ele_pointer_struct
    err : float
        Bmad type: real
    info : TaoExpressionInfoStruct
        Bmad type: tao_expression_info_struct
    info_ix : TaoExpressionInfoStruct
        Bmad type: tao_expression_info_struct
    info_x : TaoExpressionInfoStruct
        Bmad type: tao_expression_info_struct
    info_y : TaoExpressionInfoStruct
        Bmad type: tao_expression_info_struct
    picked : bool
        Bmad type: logical, allocatable
    srdt_cache : Complex
        Bmad type: complex
    stack : TaoEvalStack1Struct
        Bmad type: tao_eval_stack1_struct
    v1_array : TaoV1VarArrayStruct
        Bmad type: tao_v1_var_array_struct
    var_array : TaoVarArrayStruct
        Bmad type: tao_var_array_struct
    x : float
        Bmad type: real
    y : float
        Bmad type: real
    y_value : float
        Bmad type: real
    """

    attribs: Sequence[AllPointerStruct] = pydantic.Field(
        default=None,
    )
    axis1: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    axis2: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    axis3: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    cc: Sequence[TaoBeamShakeStruct] = pydantic.Field(
        default=None,
    )
    comp: Sequence[TaoDataVarComponentStruct] = pydantic.Field(
        default=None,
    )
    d1_array: Sequence[TaoD1DataArrayStruct] = pydantic.Field(
        default=None,
    )
    eles: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
    )
    err: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    info: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    info_ix: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    info_x: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    info_y: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    picked: Sequence[bool] = pydantic.Field(
        default=False,
    )
    srdt_cache: Sequence[Complex] = pydantic.Field(
        default=0.0,
    )
    stack: Sequence[TaoEvalStack1Struct] = pydantic.Field(
        default=None,
    )
    v1_array: Sequence[TaoV1VarArrayStruct] = pydantic.Field(
        default=None,
    )
    var_array: Sequence[TaoVarArrayStruct] = pydantic.Field(
        default=None,
    )
    x: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y_value: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class TaoShapePatternPointStruct(pydantic.BaseModel):
    """
    TaoShapePatternPointStruct corresponds to bmad `tao_shape_pattern_point_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 132.

    Attributes
    ----------
    radius : float
        Bmad type: real
        Fortran default: 0
    s : float
        Bmad type: real
        Fortran default: real_garbage$
    y : float
        Bmad type: real
        Fortran default: real_garbage$
    """

    radius: float = pydantic.Field(
        default=0,
    )
    s: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )


class TaoShapePatternStruct(pydantic.BaseModel):
    """
    TaoShapePatternStruct corresponds to bmad `tao_shape_pattern_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 136.

    Attributes
    ----------
    line : QpLineStruct
        Line color and pattern set by shape using this pattern.
        Bmad type: qp_line_struct
        Fortran default: qp_line_struct(1, 'Not_Set', 'solid')
    name : str
        Bmad type: character
        Fortran default: ''
    pt : TaoShapePatternPointStruct
        Bmad type: tao_shape_pattern_point_struct
    """

    line: QpLineStruct = pydantic.Field(
        default=None,
        description="Line color and pattern set by shape using this pattern.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    pt: Sequence[TaoShapePatternPointStruct] = pydantic.Field(
        default=None,
    )


class TaoSpinDnDpzStruct(pydantic.BaseModel):
    """
    TaoSpinDnDpzStruct corresponds to bmad `tao_spin_dn_dpz_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 878.

    Attributes
    ----------
    partial : float
        partial(i:) is spin n0 derivative wrt pz for i^th oscillation mode (1 =>
        a-mode, etc.)
        Bmad type: real
    partial2 : float
        partial(i:) is spin n0 derivative wrt pz with i^th oscillation mode missing (1
        => a-mode, etc.)
        Bmad type: real
    vec : float
        n0 derivative wrt pz.
        Bmad type: real
    """

    partial: Sequence[float] = pydantic.Field(
        default=0.0,
        description=(
            "partial(i:) is spin n0 derivative wrt pz for i^th oscillation mode (1 => "
            "a-mode, etc.)"
        ),
    )
    partial2: Sequence[float] = pydantic.Field(
        default=0.0,
        description=(
            "partial(i:) is spin n0 derivative wrt pz with i^th oscillation mode "
            "missing (1 => a-mode, etc.)"
        ),
    )
    vec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="n0 derivative wrt pz.",
    )


class TaoSpinEleStruct(pydantic.BaseModel):
    """
    TaoSpinEleStruct corresponds to bmad `tao_spin_ele_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 884.

    Attributes
    ----------
    dn_dpz : TaoSpinDnDpzStruct
        Bmad type: tao_spin_dn_dpz_struct
    orb_eigen_val : float
        Bmad type: real
        Fortran default: 0
    orb_eigen_vec : float
        (j,:) is j^th vector
        Bmad type: real
        Fortran default: 0
    spin_eigen_vec : float
        (j,:) is j^th vector
        Bmad type: real
        Fortran default: 0
    valid : bool
        Bmad type: logical
        Fortran default: .false.
    """

    dn_dpz: TaoSpinDnDpzStruct = pydantic.Field(
        default=None,
    )
    orb_eigen_val: Sequence[float] = pydantic.Field(
        default=0,
        max_length=6,
    )
    orb_eigen_vec: Sequence[float] = pydantic.Field(
        default=0,
        description="(j,:) is j^th vector",
    )
    spin_eigen_vec: Sequence[float] = pydantic.Field(
        default=0,
        description="(j,:) is j^th vector",
    )
    valid: bool = pydantic.Field(
        default=False,
    )


class TaoSpinMapStruct(pydantic.BaseModel):
    """
    TaoSpinMapStruct corresponds to bmad `tao_spin_map_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 381.

    Attributes
    ----------
    axis0 : SpinAxisStruct
        Initial axes.
        Bmad type: spin_axis_struct
        Fortran default: spin_axis_struct()
    axis1 : SpinAxisStruct
        Final axes.
        Bmad type: spin_axis_struct
        Fortran default: spin_axis_struct()
    axis_input : SpinAxisStruct
        Input axes.
        Bmad type: spin_axis_struct
        Fortran default: spin_axis_struct()
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Bmad type: integer
        Fortran default: 0
    ix_ref : int
        Bmad type: integer
        Fortran default: 0
    ix_uni : int
        Bmad type: integer
        Fortran default: 0
    map1 : SpinOrbitMap1Struct
        Bmad type: spin_orbit_map1_struct
        Fortran default: spin_orbit_map1_struct()
    mat8 : float
        Bmad type: real
        Fortran default: 0
    valid : bool
        Bmad type: logical
        Fortran default: .false.
    """

    axis0: SpinAxisStruct = pydantic.Field(
        default=None,
        description="Initial axes.",
    )
    axis1: SpinAxisStruct = pydantic.Field(
        default=None,
        description="Final axes.",
    )
    axis_input: SpinAxisStruct = pydantic.Field(
        default=None,
        description="Input axes.",
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_ele: int = pydantic.Field(
        default=0,
    )
    ix_ref: int = pydantic.Field(
        default=0,
    )
    ix_uni: int = pydantic.Field(
        default=0,
    )
    map1: SpinOrbitMap1Struct = pydantic.Field(
        default=None,
    )
    mat8: Sequence[float] = pydantic.Field(
        default=0,
    )
    valid: bool = pydantic.Field(
        default=False,
    )


class TaoSpinPolarizationStruct(pydantic.BaseModel):
    """
    TaoSpinPolarizationStruct corresponds to bmad `tao_spin_polarization_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 892.

    Attributes
    ----------
    depol_rate : float
        Depolarization rate (1/sec).
        Bmad type: real
        Fortran default: real_garbage$
    depol_rate_partial : float
        Depolarization rate (1/sec) using only single mode to calc dn_dpz.
        Bmad type: real
        Fortran default: real_garbage$
    depol_rate_partial2 : float
        Depolarization rate (1/sec) using only two modes to calc dn_dpz.
        Bmad type: real
        Fortran default: real_garbage$
    integral_1ns : float
        Integral of g^3 (1 - 2(n * s_hat)/9)
        Bmad type: real
        Fortran default: real_garbage$
    integral_bdn : float
        Integral of g^3 * b_hat * dn/ddelta
        Bmad type: real
        Fortran default: real_garbage$
    integral_bn : float
        Integral of g^3 * b_hat * n_0
        Bmad type: real
        Fortran default: real_garbage$
    integral_dn2 : float
        Integral of g^3 * 11 (dn/ddelta)^2 / 9
        Bmad type: real
        Fortran default: real_garbage$
    pol_limit_dk : float
        Equalibrium Polarization calculated via the Derbenev-Kondratenko-Mane formula.
        Bmad type: real
        Fortran default: real_garbage$
    pol_limit_dk_partial : float
        Limit using only single mode to calc dn_dpz
        Bmad type: real
        Fortran default: real_garbage$
    pol_limit_dk_partial2 : float
        Limit using only single mode to calc dn_dpz
        Bmad type: real
        Fortran default: real_garbage$
    pol_limit_st : float
        Polarization calculated using Sokolov-Ternov formula.
        Bmad type: real
        Fortran default: real_garbage$
    pol_rate_bks : float
        BKS Polarization rate (1/sec).
        Bmad type: real
        Fortran default: real_garbage$
    q_1turn : SpinOrbitMap1Struct
        Save results from spin_concat_linear_maps in tao_spin_polarization.
        Bmad type: spin_orbit_map1_struct
    q_ele : SpinOrbitMap1Struct
        Save results from spin_concat_linear_maps in tao_spin_polarization.
        Bmad type: spin_orbit_map1_struct
    tune : float
        Bmad type: real
        Fortran default: real_garbage$
    valid : bool
        Bmad type: logical
        Fortran default: .false.
    """

    depol_rate: float = pydantic.Field(
        default=0.0,
        description="Depolarization rate (1/sec).",
    )
    depol_rate_partial: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Depolarization rate (1/sec) using only single mode to calc dn_dpz.",
    )
    depol_rate_partial2: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Depolarization rate (1/sec) using only two modes to calc dn_dpz.",
    )
    integral_1ns: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 (1 - 2(n * s_hat)/9)",
    )
    integral_bdn: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 * b_hat * dn/ddelta",
    )
    integral_bn: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 * b_hat * n_0",
    )
    integral_dn2: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 * 11 (dn/ddelta)^2 / 9",
    )
    pol_limit_dk: float = pydantic.Field(
        default=0.0,
        description="Equalibrium Polarization calculated via the Derbenev-Kondratenko-Mane formula.",
    )
    pol_limit_dk_partial: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Limit using only single mode to calc dn_dpz",
    )
    pol_limit_dk_partial2: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Limit using only single mode to calc dn_dpz",
    )
    pol_limit_st: float = pydantic.Field(
        default=0.0,
        description="Polarization calculated using Sokolov-Ternov formula.",
    )
    pol_rate_bks: float = pydantic.Field(
        default=0.0,
        description="BKS Polarization rate (1/sec).",
    )
    q_1turn: SpinOrbitMap1Struct = pydantic.Field(
        default=None,
        description="Save results from spin_concat_linear_maps in tao_spin_polarization.",
    )
    q_ele: Sequence[SpinOrbitMap1Struct] = pydantic.Field(
        default=None,
        description="Save results from spin_concat_linear_maps in tao_spin_polarization.",
    )
    tune: float = pydantic.Field(
        default=0.0,
    )
    valid: bool = pydantic.Field(
        default=False,
    )


class TaoStringArrayStruct(pydantic.BaseModel):
    """
    TaoStringArrayStruct corresponds to bmad `tao_string_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 84.

    Attributes
    ----------
    s : str
        Bmad type: character
        Fortran default: null()
    """

    s: str = pydantic.Field(
        default="",
    )


class TaoSuperUniverseStruct(pydantic.BaseModel):
    """
    TaoSuperUniverseStruct corresponds to bmad `tao_super_universe_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1131.

    Attributes
    ----------
    building_wall : TaoBuildingWallStruct
        Bmad type: tao_building_wall_struct
    com : TaoCommonStruct
        Non-initialization common parameters
        Bmad type: tao_common_struct
    global_ : TaoGlobalStruct
        User accessible global variables.
        Bmad type: tao_global_struct
        Fortran default: tao_global_struct()
    history : TaoCmdHistoryStruct
        command history
        Bmad type: tao_cmd_history_struct
        Fortran default: tao_cmd_history_struct()
    init : TaoInitStruct
        Initialization parameters
        Bmad type: tao_init_struct
        Fortran default: tao_init_struct()
    initialized : bool
        Does tao_init() need to be called?
        Bmad type: logical
        Fortran default: .false.
    key : int
        Bmad type: integer, allocatable
    mpi : TaoMpiStruct
        Bmad type: tao_mpi_struct
        Fortran default: tao_mpi_struct()
    n_v1_var_used : int
        Bmad type: integer
        Fortran default: 0
    n_var_used : int
        Bmad type: integer
        Fortran default: 0
    plot_page : TaoPlotPageStruct
        Defines the plot window.
        Bmad type: tao_plot_page_struct
    u : TaoUniverseStruct
        array of universes.
        Bmad type: tao_universe_struct
    v1_var : TaoV1VarStruct
        The variable types
        Bmad type: tao_v1_var_struct
    var : TaoVarStruct
        array of all variables.
        Bmad type: tao_var_struct
    wave : TaoWaveStruct
        Bmad type: tao_wave_struct
    """

    building_wall: TaoBuildingWallStruct = pydantic.Field(
        default=None,
    )
    com: TaoCommonStruct = pydantic.Field(
        default=None,
        description="Non-initialization common parameters",
    )
    global_: TaoGlobalStruct = pydantic.Field(
        default=None,
        description="User accessible global variables.",
        validation_alias=pydantic.AliasChoices("global_", "global"),
        serialization_alias="global",
    )
    history: Sequence[TaoCmdHistoryStruct] = pydantic.Field(
        default=None,
        max_length=1000,
        description="command history",
    )
    init: TaoInitStruct = pydantic.Field(
        default=None,
        description="Initialization parameters",
    )
    initialized: bool = pydantic.Field(
        default=False,
        description="Does tao_init() need to be called?",
    )
    key: Sequence[int] = pydantic.Field(
        default=0,
    )
    mpi: TaoMpiStruct = pydantic.Field(
        default=None,
    )
    n_v1_var_used: int = pydantic.Field(
        default=0,
    )
    n_var_used: int = pydantic.Field(
        default=0,
    )
    plot_page: TaoPlotPageStruct = pydantic.Field(
        default=None,
        description="Defines the plot window.",
    )
    u: Sequence[TaoUniverseStruct] = pydantic.Field(
        default=None,
        description="array of universes.",
    )
    v1_var: Sequence[TaoV1VarStruct] = pydantic.Field(
        default=None,
        description="The variable types",
    )
    var: Sequence[TaoVarStruct] = pydantic.Field(
        default=None,
        description="array of all variables.",
    )
    wave: TaoWaveStruct = pydantic.Field(
        default=None,
    )


class TaoTitleStruct(pydantic.BaseModel):
    """
    TaoTitleStruct corresponds to bmad `tao_title_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 149.

    Attributes
    ----------
    draw_it : bool
        draw the title?
        Bmad type: logical
        Fortran default: .true.
    justify : str
        Left, Center, or Right justification.
        Bmad type: character
        Fortran default: 'CC'
    string : str
        title character string.
        Bmad type: character
        Fortran default: ''
    units : str
        %BOX, POINTS, etc...
        Bmad type: character
        Fortran default: '%PAGE'
    x : float
        x, y rwt lower left corner
        Bmad type: real
        Fortran default: 0.5
    y : float
        x, y rwt lower left corner
        Bmad type: real
        Fortran default: 0.97
    """

    draw_it: bool = pydantic.Field(
        default=True,
        description="draw the title?",
    )
    justify: str = pydantic.Field(
        default="CC",
        max_length=2,
        description="Left, Center, or Right justification.",
    )
    string: str = pydantic.Field(
        default="",
        max_length=100,
        description="title character string.",
    )
    units: str = pydantic.Field(
        default="%PAGE",
        max_length=16,
        description="%BOX, POINTS, etc...",
    )
    x: float = pydantic.Field(
        default=0.5,
        description="x, y rwt lower left corner",
    )
    y: float = pydantic.Field(
        default=0.97,
        description="x, y rwt lower left corner",
    )


class TaoUniverseCalcStruct(pydantic.BaseModel):
    """
    TaoUniverseCalcStruct corresponds to bmad `tao_universe_calc_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1018.

    Attributes
    ----------
    chrom_for_data : bool
        Does the chromaticity need to be computed for
        Bmad type: logical
        Fortran default: .false.
    chrom_for_plotting : bool
        data or plotting?
        Bmad type: logical
        Fortran default: .false.
    dynamic_aperture : bool
        Do the dynamic_aperture calc?
        Bmad type: logical
        Fortran default: .false.
    lat_sigma_for_data : bool
        Do the beam sigmas need to be computed for
        Bmad type: logical
        Fortran default: .false.
    lat_sigma_for_plotting : bool
        data or plotting?
        Bmad type: logical
        Fortran default: .false.
    lattice : bool
        Used to indicate which lattices need tracking done.
        Bmad type: logical
        Fortran default: .true.
    one_turn_map : bool
        Compute the one turn map?
        Bmad type: logical
        Fortran default: .false.
    rad_int_for_data : bool
        Do the radiation integrals need to be computed for
        Bmad type: logical
        Fortran default: .false.
    rad_int_for_plotting : bool
        data or plotting?
        Bmad type: logical
        Fortran default: .false.
    spin_matrices : bool
        Calculate G and D spin matrices?
        Bmad type: logical
        Fortran default: .false.
    srdt_for_data : int
        0 = false, 1 = 1st order, 2 = 1st & 2nd order
        Bmad type: integer
        Fortran default: 0
    track : bool
        tracking needs to be done?
        Bmad type: logical
        Fortran default: .true.
    twiss : bool
        calc linear transfer matrix?
        Bmad type: logical
        Fortran default: .true.
    """

    chrom_for_data: bool = pydantic.Field(
        default=False,
        description="Does the chromaticity need to be computed for",
    )
    chrom_for_plotting: bool = pydantic.Field(
        default=False,
        description="data or plotting?",
    )
    dynamic_aperture: bool = pydantic.Field(
        default=False,
        description="Do the dynamic_aperture calc?",
    )
    lat_sigma_for_data: bool = pydantic.Field(
        default=False,
        description="Do the beam sigmas need to be computed for",
    )
    lat_sigma_for_plotting: bool = pydantic.Field(
        default=False,
        description="data or plotting?",
    )
    lattice: bool = pydantic.Field(
        default=True,
        description="Used to indicate which lattices need tracking done.",
    )
    one_turn_map: bool = pydantic.Field(
        default=False,
        description="Compute the one turn map?",
    )
    rad_int_for_data: bool = pydantic.Field(
        default=False,
        description="Do the radiation integrals need to be computed for",
    )
    rad_int_for_plotting: bool = pydantic.Field(
        default=False,
        description="data or plotting?",
    )
    spin_matrices: bool = pydantic.Field(
        default=False,
        description="Calculate G and D spin matrices?",
    )
    srdt_for_data: int = pydantic.Field(
        default=0,
        description="0 = false, 1 = 1st order, 2 = 1st & 2nd order",
    )
    track: bool = pydantic.Field(
        default=True,
        description="tracking needs to be done?",
    )
    twiss: bool = pydantic.Field(
        default=True,
        description="calc linear transfer matrix?",
    )


class TaoUniversePointerStruct(pydantic.BaseModel):
    """
    TaoUniversePointerStruct corresponds to bmad `tao_universe_pointer_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1099.

    Attributes
    ----------
    u : TaoUniverseStruct
        Bmad type: tao_universe_struct
    """

    u: TaoUniverseStruct = pydantic.Field(
        default=None,
    )


class TaoUniverseStruct(pydantic.BaseModel):
    """
    TaoUniverseStruct corresponds to bmad `tao_universe_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1106.

    Attributes
    ----------
    base : TaoLatticeStruct
        Bmad type: tao_lattice_struct
    beam : TaoBeamUniStruct
        Bmad type: tao_beam_uni_struct
    calc : TaoUniverseCalcStruct
        What needs to be calculated?
        Bmad type: tao_universe_calc_struct
    d2_data : TaoD2DataStruct
        The data types
        Bmad type: tao_d2_data_struct
    dmodel_dvar : float
        Derivative matrix.
        Bmad type: real
    data : TaoDataStruct
        Array of all data.
        Bmad type: tao_data_struct
    design : TaoLatticeStruct
        Bmad type: tao_lattice_struct
    design_same_as_previous : bool
        Design lat same as the previous uni?
        Bmad type: logical
        Fortran default: .false.
    dynamic_aperture : TaoDynamicApertureStruct
        Bmad type: tao_dynamic_aperture_struct
    ele_order : LatEleOrderStruct
        Order of elements with same name.
        Bmad type: lat_ele_order_struct
    is_on : bool
        universe turned on
        Bmad type: logical
        Fortran default: .true.
    ix_uni : int
        Universe index.
        Bmad type: integer
        Fortran default: -1
    model : TaoLatticeStruct
        Bmad type: tao_lattice_struct
    bmad_model_branch : TaoModelBranchStruct
        model specific information
        Bmad type: tao_model_branch_struct
    n_d2_data_used : int
        Number of used %d2_data(:) components.
        Bmad type: integer
        Fortran default: -1
    n_data_used : int
        Number of used %data(:) components.
        Bmad type: integer
        Fortran default: -1
    picked_uni : bool
        Scratch logical.
        Bmad type: logical
        Fortran default: .false.
    ping_scale : TaoPingScaleStruct
        Bmad type: tao_ping_scale_struct
    scratch_lat : LatStruct
        Scratch area.
        Bmad type: lat_struct
    spin_map : TaoSpinMapStruct
        Bmad type: tao_spin_map_struct
    """

    base: TaoLatticeStruct = pydantic.Field(
        default=None,
    )
    beam: TaoBeamUniStruct = pydantic.Field(
        default=None,
    )
    calc: TaoUniverseCalcStruct = pydantic.Field(
        default=None,
        description="What needs to be calculated?",
    )
    d2_data: Sequence[TaoD2DataStruct] = pydantic.Field(
        default=None,
        description="The data types",
    )
    dmodel_dvar: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Derivative matrix.",
        validation_alias=pydantic.AliasChoices("dmodel_dvar", "dModel_dVar"),
        serialization_alias="dModel_dVar",
    )
    data: Sequence[TaoDataStruct] = pydantic.Field(
        default=None,
        description="Array of all data.",
    )
    design: TaoLatticeStruct = pydantic.Field(
        default=None,
    )
    design_same_as_previous: bool = pydantic.Field(
        default=False,
        description="Design lat same as the previous uni?",
    )
    dynamic_aperture: TaoDynamicApertureStruct = pydantic.Field(
        default=None,
    )
    ele_order: LatEleOrderStruct = pydantic.Field(
        default=None,
        description="Order of elements with same name.",
    )
    is_on: bool = pydantic.Field(
        default=True,
        description="universe turned on",
    )
    ix_uni: int = pydantic.Field(
        default=-1,
        description="Universe index.",
    )
    model: TaoLatticeStruct = pydantic.Field(
        default=None,
    )
    bmad_model_branch: Sequence[TaoModelBranchStruct] = pydantic.Field(
        default=None,
        description="model specific information",
        validation_alias=pydantic.AliasChoices("bmad_model_branch", "model_branch"),
        serialization_alias="model_branch",
    )
    n_d2_data_used: int = pydantic.Field(
        default=-1,
        description="Number of used %d2_data(:) components.",
    )
    n_data_used: int = pydantic.Field(
        default=-1,
        description="Number of used %data(:) components.",
    )
    picked_uni: bool = pydantic.Field(
        default=False,
        description="Scratch logical.",
    )
    ping_scale: TaoPingScaleStruct = pydantic.Field(
        default=None,
    )
    scratch_lat: LatStruct = pydantic.Field(
        default=None,
        description="Scratch area.",
    )
    spin_map: TaoSpinMapStruct = pydantic.Field(
        default=None,
    )


class TaoV1VarArrayStruct(pydantic.BaseModel):
    """
    TaoV1VarArrayStruct corresponds to bmad `tao_v1_var_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 603.

    Attributes
    ----------
    v1 : TaoV1VarStruct
        Bmad type: tao_v1_var_struct
        Fortran default: null()
    """

    v1: TaoV1VarStruct = pydantic.Field(
        default=None,
    )


class TaoV1VarStruct(pydantic.BaseModel):
    """
    TaoV1VarStruct corresponds to bmad `tao_v1_var_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 589.

    Attributes
    ----------
    ix_v1_var : int
        Index to s%v1_var(:) array
        Bmad type: integer
        Fortran default: -1
    name : str
        V1 variable name. Eg: 'quad_k1'.
        Bmad type: character
        Fortran default: ''
    v : TaoVarStruct
        Pointer to the appropriate section in s%var.
        Bmad type: tao_var_struct
        Fortran default: null()
    """

    ix_v1_var: int = pydantic.Field(
        default=-1,
        description="Index to s%v1_var(:) array",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="V1 variable name. Eg: 'quad_k1'.",
    )
    v: Sequence[TaoVarStruct] = pydantic.Field(
        default=None,
        description="Pointer to the appropriate section in s%var.",
    )


class TaoVarArrayStruct(pydantic.BaseModel):
    """
    TaoVarArrayStruct corresponds to bmad `tao_var_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 599.

    Attributes
    ----------
    v : TaoVarStruct
        Bmad type: tao_var_struct
        Fortran default: null()
    """

    v: TaoVarStruct = pydantic.Field(
        default=None,
    )


class TaoVarSlaveStruct(pydantic.BaseModel):
    """
    TaoVarSlaveStruct corresponds to bmad `tao_var_slave_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 521.

    Attributes
    ----------
    base_value : float
        Pointer to the variable in the base lat.
        Bmad type: real
        Fortran default: null()
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Index of element in the u%lattice%ele(:) array.
        Bmad type: integer
        Fortran default: -1
    ix_uni : int
        universe index.
        Bmad type: integer
        Fortran default: 1
    bmad_model_value : float
        Pointer to the variable in the model lat.
        Bmad type: real
        Fortran default: null()
    """

    base_value: float = pydantic.Field(
        default=0.0,
        description="Pointer to the variable in the base lat.",
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description="Index of element in the u%lattice%ele(:) array.",
    )
    ix_uni: int = pydantic.Field(
        default=1,
        description="universe index.",
    )
    bmad_model_value: float = pydantic.Field(
        default=0.0,
        description="Pointer to the variable in the model lat.",
        validation_alias=pydantic.AliasChoices("bmad_model_value", "model_value"),
        serialization_alias="model_value",
    )


class TaoVarStruct(pydantic.BaseModel):
    """
    TaoVarStruct corresponds to bmad `tao_var_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 545.

    Attributes
    ----------
    attrib_name : str
        Name of the attribute to vary.
        Bmad type: character
        Fortran default: ''
    base_value : float
        Base value.
        Bmad type: real
        Fortran default: null()
    correction_value : float
        Value determined by a fit to correct the lattice.
        Bmad type: real
        Fortran default: 0
    dmerit_dvar : float
        Merit derivative.
        Bmad type: real
        Fortran default: 0
    delta_merit : float
        Diff used to calculate the merit function term.
        Bmad type: real
        Fortran default: 0
    design_value : float
        Design value from the design lattice.
        Bmad type: real
        Fortran default: 0
    ele_name : str
        Associated lattice element name.
        Bmad type: character
        Fortran default: ''
    exists : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    extend_val : float
        For extension code. Not used by Tao.
        Bmad type: real
    good_opt : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_plot : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_user : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    good_var : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    high_lim : float
        High limit for the model_value.
        Bmad type: real
        Fortran default: -1d30
    id : str
        Used by Tao extension code. Not used by Tao directly.
        Bmad type: character
        Fortran default: ''
    ix_attrib : int
        Index in ele%value(:) array if appropriate.
        Bmad type: integer
        Fortran default: 0
    ix_dvar : int
        Column in the dData_dVar derivative matrix.
        Bmad type: integer
        Fortran default: -1
    ix_key_table : int
        Has a key binding?
        Bmad type: integer
        Fortran default: 0
    ix_v1 : int
        Index of this var in the s%v1_var(i)%v(:) array.
        Bmad type: integer
        Fortran default: 0
    ix_var : int
        Index number of this var in the s%var(:) array.
        Bmad type: integer
        Fortran default: 0
    key_bound : bool
        Variable bound to keyboard key?
        Bmad type: logical
        Fortran default: .false.
    key_delta : float
        Change in value when a key is pressed.
        Bmad type: real
        Fortran default: 0
    key_val0 : float
        Key base value
        Bmad type: real
        Fortran default: 0
    low_lim : float
        Low limit for the model_value.
        Bmad type: real
        Fortran default: 1d30
    meas_value : float
        The value when the data measurement was taken.
        Bmad type: real
        Fortran default: 0
    merit : float
        merit_term = weight * delta^2.
        Bmad type: real
        Fortran default: 0
    merit_type : str
        'target' or 'limit'
        Bmad type: character
        Fortran default: ''
    bmad_model_value : float
        Model value.
        Bmad type: real
        Fortran default: null()
    old_value : float
        Scratch space used by Tao.
        Bmad type: real
        Fortran default: 0
    ref_value : float
        Value when the reference measurement was taken.
        Bmad type: real
        Fortran default: 0
    s : float
        longitudinal position of ele.
        Bmad type: real
        Fortran default: 0
    scratch_value : float
        Scratch space used by Tao.
        Bmad type: real
        Fortran default: 0
    slave : TaoVarSlaveStruct
        Bmad type: tao_var_slave_struct
    step : float
        Sets what is a small step for varying this var.
        Bmad type: real
        Fortran default: 0
    useit_opt : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    useit_plot : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    v1 : TaoV1VarStruct
        Pointer to the parent.
        Bmad type: tao_v1_var_struct
        Fortran default: null()
    weight : float
        Weight for the merit function term.
        Bmad type: real
        Fortran default: 0
    """

    attrib_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of the attribute to vary.",
    )
    base_value: float = pydantic.Field(
        default=0.0,
        description="Base value.",
    )
    correction_value: float = pydantic.Field(
        default=0,
        description="Value determined by a fit to correct the lattice.",
    )
    dmerit_dvar: float = pydantic.Field(
        default=0,
        description="Merit derivative.",
        validation_alias=pydantic.AliasChoices("dmerit_dvar", "dMerit_dVar"),
        serialization_alias="dMerit_dVar",
    )
    delta_merit: float = pydantic.Field(
        default=0,
        description="Diff used to calculate the merit function term.",
    )
    design_value: float = pydantic.Field(
        default=0,
        description="Design value from the design lattice.",
    )
    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Associated lattice element name.",
    )
    exists: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    extend_val: float = pydantic.Field(
        default=0.0,
        description="For extension code. Not used by Tao.",
    )
    good_opt: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_plot: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_user: bool = pydantic.Field(
        default=True,
        description="See above",
    )
    good_var: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    high_lim: float = pydantic.Field(
        default=-1e30,
        description="High limit for the model_value.",
    )
    id: str = pydantic.Field(
        default="",
        max_length=40,
        description="Used by Tao extension code. Not used by Tao directly.",
    )
    ix_attrib: int = pydantic.Field(
        default=0,
        description="Index in ele%value(:) array if appropriate.",
    )
    ix_dvar: int = pydantic.Field(
        default=-1,
        description="Column in the dData_dVar derivative matrix.",
    )
    ix_key_table: int = pydantic.Field(
        default=0,
        description="Has a key binding?",
    )
    ix_v1: int = pydantic.Field(
        default=0,
        description="Index of this var in the s%v1_var(i)%v(:) array.",
    )
    ix_var: int = pydantic.Field(
        default=0,
        description="Index number of this var in the s%var(:) array.",
    )
    key_bound: bool = pydantic.Field(
        default=False,
        description="Variable bound to keyboard key?",
    )
    key_delta: float = pydantic.Field(
        default=0,
        description="Change in value when a key is pressed.",
    )
    key_val0: float = pydantic.Field(
        default=0,
        description="Key base value",
    )
    low_lim: float = pydantic.Field(
        default=1e30,
        description="Low limit for the model_value.",
    )
    meas_value: float = pydantic.Field(
        default=0,
        description="The value when the data measurement was taken.",
    )
    merit: float = pydantic.Field(
        default=0,
        description="merit_term = weight * delta^2.",
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=40,
        description="'target' or 'limit'",
    )
    bmad_model_value: float = pydantic.Field(
        default=0.0,
        description="Model value.",
        validation_alias=pydantic.AliasChoices("bmad_model_value", "model_value"),
        serialization_alias="model_value",
    )
    old_value: float = pydantic.Field(
        default=0,
        description="Scratch space used by Tao.",
    )
    ref_value: float = pydantic.Field(
        default=0,
        description="Value when the reference measurement was taken.",
    )
    s: float = pydantic.Field(
        default=0,
        description="longitudinal position of ele.",
    )
    scratch_value: float = pydantic.Field(
        default=0,
        description="Scratch space used by Tao.",
    )
    slave: Sequence[TaoVarSlaveStruct] = pydantic.Field(
        default=None,
    )
    step: float = pydantic.Field(
        default=0,
        description="Sets what is a small step for varying this var.",
    )
    useit_opt: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    useit_plot: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    v1: TaoV1VarStruct = pydantic.Field(
        default=None,
        description="Pointer to the parent.",
    )
    weight: float = pydantic.Field(
        default=0,
        description="Weight for the merit function term.",
    )


class TaoWaveKickPtStruct(pydantic.BaseModel):
    """
    TaoWaveKickPtStruct corresponds to bmad `tao_wave_kick_pt_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1059.

    Attributes
    ----------
    amp : float
        Bmad type: real
    ele : EleStruct
        lattice element at position of kick.
        Bmad type: ele_struct
    ix_dat_before_kick : int
        Index of datum in data array just before the kick.
        Bmad type: integer
    phi : float
        Bmad type: real
    phi_r : float
        Bmad type: real
    phi_s : float
        Bmad type: real
    s : float
        s-position of kick
        Bmad type: real
    """

    amp: float = pydantic.Field(
        default=0.0,
    )
    ele: EleStruct = pydantic.Field(
        default=None,
        description="lattice element at position of kick.",
    )
    ix_dat_before_kick: int = pydantic.Field(
        default=0,
        description="Index of datum in data array just before the kick.",
    )
    phi: float = pydantic.Field(
        default=0.0,
    )
    phi_r: float = pydantic.Field(
        default=0.0,
    )
    phi_s: float = pydantic.Field(
        default=0.0,
    )
    s: float = pydantic.Field(
        default=0.0,
        description="s-position of kick",
    )


class TaoWaveStruct(pydantic.BaseModel):
    """
    TaoWaveStruct corresponds to bmad `tao_wave_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1066.

    Attributes
    ----------
    amp_a : float
        Bmad type: real
        Fortran default: 0
    amp_b : float
        Bmad type: real
        Fortran default: 0
    amp_ba : float
        Bmad type: real
        Fortran default: 0
    amp_ba_r : float
        Bmad type: real
        Fortran default: 0
    amp_ba_s : float
        Bmad type: real
        Fortran default: 0
    base_graph : TaoGraphStruct
        Graph before curves extended to 1.5 periods.
        Bmad type: tao_graph_struct
    chi_a : float
        Bmad type: real
        Fortran default: 0
    chi_ba : float
        Bmad type: real
        Fortran default: 0
    chi_c : float
        Bmad type: real
        Fortran default: 0
    coef_a : float
        Bmad type: real
        Fortran default: 0
    coef_b : float
        Bmad type: real
        Fortran default: 0
    coef_ba : float
        Bmad type: real
        Fortran default: 0
    d1_dat : TaoD1DataStruct
        D1 data for analysis
        Bmad type: tao_d1_data_struct
        Fortran default: null()
    data_type : str
        Bmad type: character
        Fortran default: ''
    i_a1 : int
        Bmad type: integer
        Fortran default: 0
    i_a2 : int
        Bmad type: integer
        Fortran default: 0
    i_b1 : int
        Bmad type: integer
        Fortran default: 0
    i_b2 : int
        Bmad type: integer
        Fortran default: 0
    i_curve_wrap_pt : int
        Index of last point before wrap in curve array.
        Bmad type: integer
        Fortran default: 0
    ix_a1 : int
        Bmad type: integer
        Fortran default: -1
    ix_a2 : int
        Bmad type: integer
        Fortran default: -1
    ix_b1 : int
        Bmad type: integer
        Fortran default: -1
    ix_b2 : int
        Bmad type: integer
        Fortran default: -1
    ix_data : int
        Translates from plot point to datum index
        Bmad type: integer, allocatable
    kick : TaoWaveKickPtStruct
        Bmad type: tao_wave_kick_pt_struct
    n_a : int
        Bmad type: integer
        Fortran default: 0
    n_b : int
        Bmad type: integer
        Fortran default: 0
    n_func : int
        Number of functions used in the fit.
        Bmad type: integer
        Fortran default: 0
    n_kick : int
        Bmad type: integer
        Fortran default: 0
    region : TaoPlotRegionStruct
        Where the wave plot is
        Bmad type: tao_plot_region_struct
        Fortran default: null()
    rms_phi : float
        Bmad type: real
        Fortran default: 0
    rms_phi_r : float
        Bmad type: real
        Fortran default: 0
    rms_phi_s : float
        Bmad type: real
        Fortran default: 0
    rms_rel_a : float
        Bmad type: real
        Fortran default: 0
    rms_rel_ar : float
        Bmad type: real
        Fortran default: 0
    rms_rel_as : float
        Bmad type: real
        Fortran default: 0
    rms_rel_b : float
        Bmad type: real
        Fortran default: 0
    rms_rel_br : float
        Bmad type: real
        Fortran default: 0
    rms_rel_bs : float
        Bmad type: real
        Fortran default: 0
    rms_rel_k : float
        Bmad type: real
        Fortran default: 0
    rms_rel_kr : float
        Bmad type: real
        Fortran default: 0
    rms_rel_ks : float
        Bmad type: real
        Fortran default: 0
    """

    amp_a: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    amp_b: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    amp_ba: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
    )
    amp_ba_r: float = pydantic.Field(
        default=0,
    )
    amp_ba_s: float = pydantic.Field(
        default=0,
    )
    base_graph: TaoGraphStruct = pydantic.Field(
        default=None,
        description="Graph before curves extended to 1.5 periods.",
    )
    chi_a: float = pydantic.Field(
        default=0,
    )
    chi_ba: float = pydantic.Field(
        default=0,
    )
    chi_c: float = pydantic.Field(
        default=0,
    )
    coef_a: Sequence[float] = pydantic.Field(
        default=0,
        max_length=4,
    )
    coef_b: Sequence[float] = pydantic.Field(
        default=0,
        max_length=4,
    )
    coef_ba: Sequence[float] = pydantic.Field(
        default=0,
        max_length=4,
    )
    d1_dat: TaoD1DataStruct = pydantic.Field(
        default=None,
        description="D1 data for analysis",
    )
    data_type: str = pydantic.Field(
        default="",
        max_length=40,
    )
    i_a1: int = pydantic.Field(
        default=0,
    )
    i_a2: int = pydantic.Field(
        default=0,
    )
    i_b1: int = pydantic.Field(
        default=0,
    )
    i_b2: int = pydantic.Field(
        default=0,
    )
    i_curve_wrap_pt: int = pydantic.Field(
        default=0,
        description="Index of last point before wrap in curve array.",
    )
    ix_a1: int = pydantic.Field(
        default=-1,
    )
    ix_a2: int = pydantic.Field(
        default=-1,
    )
    ix_b1: int = pydantic.Field(
        default=-1,
    )
    ix_b2: int = pydantic.Field(
        default=-1,
    )
    ix_data: Sequence[int] = pydantic.Field(
        default=0,
        description="Translates from plot point to datum index",
    )
    kick: Sequence[TaoWaveKickPtStruct] = pydantic.Field(
        default=None,
    )
    n_a: int = pydantic.Field(
        default=0,
    )
    n_b: int = pydantic.Field(
        default=0,
    )
    n_func: int = pydantic.Field(
        default=0,
        description="Number of functions used in the fit.",
    )
    n_kick: int = pydantic.Field(
        default=0,
    )
    region: TaoPlotRegionStruct = pydantic.Field(
        default=None,
        description="Where the wave plot is",
    )
    rms_phi: float = pydantic.Field(
        default=0,
    )
    rms_phi_r: float = pydantic.Field(
        default=0,
    )
    rms_phi_s: float = pydantic.Field(
        default=0,
    )
    rms_rel_a: float = pydantic.Field(
        default=0,
    )
    rms_rel_ar: float = pydantic.Field(
        default=0,
    )
    rms_rel_as: float = pydantic.Field(
        default=0,
    )
    rms_rel_b: float = pydantic.Field(
        default=0,
    )
    rms_rel_br: float = pydantic.Field(
        default=0,
    )
    rms_rel_bs: float = pydantic.Field(
        default=0,
    )
    rms_rel_k: float = pydantic.Field(
        default=0,
    )
    rms_rel_kr: float = pydantic.Field(
        default=0,
    )
    rms_rel_ks: float = pydantic.Field(
        default=0,
    )


class ConstraintStruct(pydantic.BaseModel):
    """
    ConstraintStruct corresponds to bmad `constraint_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_top10_mod.f90 on line 318.

    Attributes
    ----------
    actual_value : float
        Bmad type: real
    d2_d1_name : str
        Bmad type: character
    expression : bool
        Bmad type: logical
        Fortran default: .false.
    loc_ele : str
        Bmad type: character
    loc_ref : str
        Bmad type: character
    loc_start : str
        Bmad type: character
    max_loc : str
        Bmad type: character
    merit : float
        Bmad type: real
    name : str
        Bmad type: character
    target_value : float
        Bmad type: real
    """

    actual_value: float = pydantic.Field(
        default=0.0,
    )
    d2_d1_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    expression: bool = pydantic.Field(
        default=False,
    )
    loc_ele: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    loc_ref: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    loc_start: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    max_loc: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    merit: float = pydantic.Field(
        default=0.0,
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=80,
    )
    target_value: float = pydantic.Field(
        default=0.0,
    )


class TaoTop10Struct(pydantic.BaseModel):
    """
    TaoTop10Struct corresponds to bmad `tao_top10_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_top10_mod.f90 on line 9.

    Attributes
    ----------
    index : int
        index of contributor.
        Bmad type: integer
        Fortran default: 0
    name : str
        name of contributor
        Bmad type: character
        Fortran default: ''
    valid : bool
        valid entry?
        Bmad type: logical
        Fortran default: .false.
    value : float
        contribution to the merit function
        Bmad type: real
        Fortran default: 0
    """

    index: int = pydantic.Field(
        default=0,
        description="index of contributor.",
    )
    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="name of contributor",
    )
    valid: bool = pydantic.Field(
        default=False,
        description="valid entry?",
    )
    value: float = pydantic.Field(
        default=0,
        description="contribution to the merit function",
    )
