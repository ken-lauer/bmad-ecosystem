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

Complex = Annotated[
    complex,
    PlainValidator(
        lambda x: x if isinstance(x, complex) else complex(x.get("real", x.get("imag")))
    ),
    PlainSerializer(lambda x: {"real": x.real, "imag": x.imag}, return_type=dict),
]


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


class TaoRealPointerStruct(pydantic.BaseModel):
    """
    TaoRealPointerStruct corresponds to bmad `tao_real_pointer_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 70.

    Attributes
    ----------
    r : float
        Bmad type: real
        Fortran default: null()
    good_value : bool
        Bmad type: logical
        Fortran default: null()
    good_user : bool
        Bmad type: logical
        Fortran default: null()
    """

    r: float = pydantic.Field(
        default=0.0,
    )
    good_value: bool = pydantic.Field(
        default=False,
    )
    good_user: bool = pydantic.Field(
        default=False,
    )


class TaoLogicalArrayStruct(pydantic.BaseModel):
    """
    TaoLogicalArrayStruct corresponds to bmad `tao_logical_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 76.

    Attributes
    ----------
    L : bool
        Bmad type: logical
        Fortran default: null()
    """

    L: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("L", "l"),
        serialization_alias="l",
    )


class TaoIntegerArrayStruct(pydantic.BaseModel):
    """
    TaoIntegerArrayStruct corresponds to bmad `tao_integer_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 80.

    Attributes
    ----------
    i : int
        Bmad type: integer
        Fortran default: null()
    """

    i: int = pydantic.Field(
        default=0,
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


class TaoExpressionInfoStruct(pydantic.BaseModel):
    """
    TaoExpressionInfoStruct corresponds to bmad `tao_expression_info_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 90.

    Attributes
    ----------
    good : bool
        Expression is valid.
        Bmad type: logical
        Fortran default: .true.
    ele : EleStruct
        Associated ele if it exists
        Bmad type: type
        Fortran default: null()
    s : float
        Longitudinal position of expression.
        Bmad type: real
        Fortran default: real_garbage$
    """

    good: bool = pydantic.Field(
        default=True,
        description="Expression is valid.",
    )
    ele: EleStruct = pydantic.Field(
        default=None,
        description="Associated ele if it exists",
    )
    s: float = pydantic.Field(
        default=0.0,
        description="Longitudinal position of expression.",
    )


class TaoEvalStack1Struct(pydantic.BaseModel):
    """
    TaoEvalStack1Struct corresponds to bmad `tao_eval_stack1_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 96.

    Attributes
    ----------
    type : int
        Bmad type: integer
        Fortran default: 0
    name : str
        Bmad type: character
        Fortran default: ''
    scale : float
        Scale factor for ping data
        Bmad type: real
        Fortran default: 1
    value : float
        Bmad type: real
    info : TaoExpressionInfoStruct
        Bmad type: type
    value_ptr : TaoRealPointerStruct
        Used to point to data, lattice parameters, etc
        Bmad type: type
    """

    type: int = pydantic.Field(
        default=0,
    )
    name: str = pydantic.Field(
        default="",
        max_length=120,
    )
    scale: float = pydantic.Field(
        default=1,
        description="Scale factor for ping data",
    )
    value: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    info: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    value_ptr: Sequence[TaoRealPointerStruct] = pydantic.Field(
        default=None,
        description="Used to point to data, lattice parameters, etc",
    )


class TaoElePointerStruct(pydantic.BaseModel):
    """
    TaoElePointerStruct corresponds to bmad `tao_ele_pointer_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 107.

    Attributes
    ----------
    eles : ElePointerStruct
        Bmad type: type
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
    ele_id : str
        element "key::name" to match to.
        Bmad type: character
        Fortran default: ''
    shape : str
        Shape to draw
        Bmad type: character
        Fortran default: ''
    color : str
        Color of shape
        Bmad type: character
        Fortran default: 'black'
    size : float
        plot vertical height
        Bmad type: real
        Fortran default: 0
    label : str
        Can be: 'name', 's', 'none'
        Bmad type: character
        Fortran default: 'name'
    draw : bool
        Draw the shape?
        Bmad type: logical
        Fortran default: .true.
    multi : bool
        Can be part of a multi-shape.
        Bmad type: logical
        Fortran default: .false.
    line_width : int
        Width of lines used to draw the shape.
        Bmad type: integer
        Fortran default: 1
    offset : float
        Vertical offset.
        Bmad type: real
        Fortran default: 0
    ix_key : int
        Extracted from ele_id. 0 => all classes (quadrupole, etc.)
        Bmad type: integer
        Fortran default: 0
    name_ele : str
        Name of element.
        Bmad type: character
        Fortran default: ''
    uni : TaoElePointerStruct
        Bmad type: type
    """

    ele_id: str = pydantic.Field(
        default="",
        max_length=60,
        description="element 'key::name' to match to.",
    )
    shape: str = pydantic.Field(
        default="",
        max_length=40,
        description="Shape to draw",
    )
    color: str = pydantic.Field(
        default="black",
        max_length=16,
        description="Color of shape",
    )
    size: float = pydantic.Field(
        default=0,
        description="plot vertical height",
    )
    label: str = pydantic.Field(
        default="name",
        max_length=16,
        description="Can be: 'name', 's', 'none'",
    )
    draw: bool = pydantic.Field(
        default=True,
        description="Draw the shape?",
    )
    multi: bool = pydantic.Field(
        default=False,
        description="Can be part of a multi-shape.",
    )
    line_width: int = pydantic.Field(
        default=1,
        description="Width of lines used to draw the shape.",
    )
    offset: float = pydantic.Field(
        default=0,
        description="Vertical offset.",
    )
    ix_key: int = pydantic.Field(
        default=0,
        description="Extracted from ele_id. 0 => all classes (quadrupole, etc.)",
    )
    name_ele: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of element.",
    )
    uni: Sequence[TaoElePointerStruct] = pydantic.Field(
        default=None,
    )


class TaoDrawingStruct(pydantic.BaseModel):
    """
    TaoDrawingStruct corresponds to bmad `tao_drawing_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 128.

    Attributes
    ----------
    ele_shape : TaoEleShapeStruct
        Bmad type: type
    """

    ele_shape: Sequence[TaoEleShapeStruct] = pydantic.Field(
        default=None,
    )


class TaoShapePatternPointStruct(pydantic.BaseModel):
    """
    TaoShapePatternPointStruct corresponds to bmad `tao_shape_pattern_point_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 132.

    Attributes
    ----------
    s : float
        Bmad type: real
        Fortran default: real_garbage$
    y : float
        Bmad type: real
        Fortran default: real_garbage$
    radius : float
        Bmad type: real
        Fortran default: 0
    """

    s: float = pydantic.Field(
        default=0.0,
    )
    y: float = pydantic.Field(
        default=0.0,
    )
    radius: float = pydantic.Field(
        default=0,
    )


class TaoShapePatternStruct(pydantic.BaseModel):
    """
    TaoShapePatternStruct corresponds to bmad `tao_shape_pattern_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 136.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    line : QpLineStruct
        Line color and pattern set by shape using this pattern.
        Bmad type: type
        Fortran default: qp_line_struct(1, 'Not_Set', 'solid')
    pt : TaoShapePatternPointStruct
        Bmad type: type
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    line: QpLineStruct = pydantic.Field(
        default=None,
        description="Line color and pattern set by shape using this pattern.",
    )
    pt: Sequence[TaoShapePatternPointStruct] = pydantic.Field(
        default=None,
    )


class TaoTitleStruct(pydantic.BaseModel):
    """
    TaoTitleStruct corresponds to bmad `tao_title_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 149.

    Attributes
    ----------
    string : str
        title character string.
        Bmad type: character
        Fortran default: ''
    x : float
        x, y rwt lower left corner
        Bmad type: real
        Fortran default: 0.5
    y : float
        x, y rwt lower left corner
        Bmad type: real
        Fortran default: 0.97
    units : str
        %BOX, POINTS, etc...
        Bmad type: character
        Fortran default: '%PAGE'
    justify : str
        Left, Center, or Right justification.
        Bmad type: character
        Fortran default: 'CC'
    draw_it : bool
        draw the title?
        Bmad type: logical
        Fortran default: .true.
    """

    string: str = pydantic.Field(
        default="",
        max_length=100,
        description="title character string.",
    )
    x: float = pydantic.Field(
        default=0.5,
        description="x, y rwt lower left corner",
    )
    y: float = pydantic.Field(
        default=0.97,
        description="x, y rwt lower left corner",
    )
    units: str = pydantic.Field(
        default="%PAGE",
        max_length=16,
        description="%BOX, POINTS, etc...",
    )
    justify: str = pydantic.Field(
        default="CC",
        max_length=2,
        description="Left, Center, or Right justification.",
    )
    draw_it: bool = pydantic.Field(
        default=True,
        description="draw the title?",
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


class TaoHistogramStruct(pydantic.BaseModel):
    """
    TaoHistogramStruct corresponds to bmad `tao_histogram_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 162.

    Attributes
    ----------
    density_normalized : bool
        Bmad type: logical
        Fortran default: .false.
    weight_by_charge : bool
        Bmad type: logical
        Fortran default: .true.
    minimum : float
        Computed by Tao. Not User settable.
        Bmad type: real
        Fortran default: 0
    maximum : float
        Computed by Tao. Not User settable.
        Bmad type: real
        Fortran default: 0
    width : float
        Bmad type: real
        Fortran default: 0
    center : float
        Bmad type: real
        Fortran default: 0
    number : int
        Bmad type: integer
        Fortran default: 0
    """

    density_normalized: bool = pydantic.Field(
        default=False,
    )
    weight_by_charge: bool = pydantic.Field(
        default=True,
    )
    minimum: float = pydantic.Field(
        default=0,
        description="Computed by Tao. Not User settable.",
    )
    maximum: float = pydantic.Field(
        default=0,
        description="Computed by Tao. Not User settable.",
    )
    width: float = pydantic.Field(
        default=0,
    )
    center: float = pydantic.Field(
        default=0,
    )
    number: int = pydantic.Field(
        default=0,
    )


class TaoCurveOrbitStruct(pydantic.BaseModel):
    """
    TaoCurveOrbitStruct corresponds to bmad `tao_curve_orbit_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 171.

    Attributes
    ----------
    x : float
        Transverse offset
        Bmad type: real
        Fortran default: 0
    y : float
        Transverse offset
        Bmad type: real
        Fortran default: 0
    t : float
        Time
        Bmad type: real
        Fortran default: 0
    """

    x: float = pydantic.Field(
        default=0,
        description="Transverse offset",
    )
    y: float = pydantic.Field(
        default=0,
        description="Transverse offset",
    )
    t: float = pydantic.Field(
        default=0,
        description="Time",
    )


class TaoCurveColorStruct(pydantic.BaseModel):
    """
    TaoCurveColorStruct corresponds to bmad `tao_curve_color_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 179.

    Attributes
    ----------
    data_type : str
        Datum type to use for z-axis.
        Bmad type: character
        Fortran default: ''
    is_on : bool
        On/Off
        Bmad type: logical
        Fortran default: .false.
    min : float
        Min and max values for mapping z-axis to color.
        Bmad type: real
        Fortran default: 0
    max : float
        Min and max values for mapping z-axis to color.
        Bmad type: real
        Fortran default: 0
    autoscale : bool
        Set %min, %max automatically to the limits of %data_type
        Bmad type: logical
        Fortran default: .true.
    """

    data_type: str = pydantic.Field(
        default="",
        max_length=100,
        description="Datum type to use for z-axis.",
    )
    is_on: bool = pydantic.Field(
        default=False,
        description="On/Off",
    )
    min: float = pydantic.Field(
        default=0,
        description="Min and max values for mapping z-axis to color.",
    )
    max: float = pydantic.Field(
        default=0,
        description="Min and max values for mapping z-axis to color.",
    )
    autoscale: bool = pydantic.Field(
        default=True,
        description="Set %min, %max automatically to the limits of %data_type",
    )


class TaoCurveStruct(pydantic.BaseModel):
    """
    TaoCurveStruct corresponds to bmad `tao_curve_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 189.

    Attributes
    ----------
    name : str
        Name identifying the curve.
        Bmad type: character
        Fortran default: ''
    data_source : str
        'lat', 'beam', 'data' (deprecated: 'dat'), 'var', 'multi_turn_orbit'
        Bmad type: character
        Fortran default: ''
    data_index : str
        Used for calculating %ix_symb(:).
        Bmad type: character
        Fortran default: ''
    data_type_x : str
        Used for data slices and phase space plots.
        Bmad type: character
        Fortran default: ''
    data_type : str
        'orbit.x', etc.
        Bmad type: character
    ele_ref_name : str
        Reference element.
        Bmad type: character
        Fortran default: ''
    legend_text : str
        String to draw in a curve legend.
        Bmad type: character
        Fortran default: ''
    message_text : str
        Informational message to draw with graph.
        Bmad type: character
        Fortran default: ''
    component : str
        Who to plot. Eg: 'meas - design'
        Bmad type: character
        Fortran default: ''
    why_invalid : str
        Informative string to print.
        Bmad type: character
        Fortran default: '???'
    g : TaoGraphStruct
        pointer to parent graph
        Bmad type: type
    hist : TaoHistogramStruct
        Bmad type: type
        Fortran default: tao_histogram_struct()
    z_color : TaoCurveColorStruct
        Bmad type: type
        Fortran default: tao_curve_color_struct()
    x_line : float
        Coords for drawing a curve
        Bmad type: real
    y_line : float
        Bmad type: real
    y2_line : float
        Second array needed for beam chamber curve.
        Bmad type: real
    ix_line : int
        Used by wave and aperture curves.
        Bmad type: integer
    x_symb : float
        Coords for drawing the symbols
        Bmad type: real
    y_symb : float
        Bmad type: real
    z_symb : float
        Symbol color
        Bmad type: real
    err_symb : float
        Error bars
        Bmad type: real
    symb_size : float
        Symbol size. Used with symbol_size_scale.
        Bmad type: real
    ix_symb : int
        Corresponding index in d1_data%d(:) array.
        Bmad type: integer
    y_axis_scale_factor : float
        y-axis conversion from internal to plotting units.
        Bmad type: real
        Fortran default: 1
    line : QpLineStruct
        Line attributes
        Bmad type: type
        Fortran default: qp_line_struct()
    symbol : QpSymbolStruct
        Symbol attributes
        Bmad type: type
        Fortran default: qp_symbol_struct()
    orbit : TaoCurveOrbitStruct
        Used for E/B field plotting.
        Bmad type: type
        Fortran default: tao_curve_orbit_struct()
    ix_universe : int
        Universe where data is. -1 => use s%global%default_universe
        Bmad type: integer
        Fortran default: -1
    symbol_every : int
        Symbol every how many points.
        Bmad type: integer
        Fortran default: 1
    ix_branch : int
        Bmad type: integer
        Fortran default: -1
    ix_bunch : int
        Bunch to plot.
        Bmad type: integer
        Fortran default: 0
    n_turn : int
        Used for multi_turn_orbit plotting
        Bmad type: integer
        Fortran default: -1
    use_y2 : bool
        Use y2 axis?
        Bmad type: logical
        Fortran default: .false.
    draw_line : bool
        Draw a line through the data points?
        Bmad type: logical
        Fortran default: .true.
    draw_symbols : bool
        Draw a symbol at the data points?
        Bmad type: logical
        Fortran default: .true.
    draw_symbol_index : bool
        Draw the symbol index number curve%ix_symb?
        Bmad type: logical
        Fortran default: .false.
    draw_error_bars : bool
        Draw error bars based upon data%error_rms if drawing data?
        Bmad type: logical
        Fortran default: .false.
    smooth_line_calc : bool
        Calculate data between element edge points?
        Bmad type: logical
        Fortran default: .true.
    valid : bool
        valid data?
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name identifying the curve.",
    )
    data_source: str = pydantic.Field(
        default="",
        max_length=40,
        description="'lat', 'beam', 'data' (deprecated: 'dat'), 'var', 'multi_turn_orbit'",
    )
    data_index: str = pydantic.Field(
        default="",
        max_length=100,
        description="Used for calculating %ix_symb(:).",
    )
    data_type_x: str = pydantic.Field(
        default="",
        max_length=100,
        description="Used for data slices and phase space plots.",
    )
    data_type: str = pydantic.Field(
        default="",
        description="'orbit.x', etc.",
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Reference element.",
    )
    legend_text: str = pydantic.Field(
        default="",
        max_length=40,
        description="String to draw in a curve legend.",
    )
    message_text: str = pydantic.Field(
        default="",
        max_length=40,
        description="Informational message to draw with graph.",
    )
    component: str = pydantic.Field(
        default="",
        max_length=60,
        description="Who to plot. Eg: 'meas - design'",
    )
    why_invalid: str = pydantic.Field(
        default="???",
        max_length=80,
        description="Informative string to print.",
    )
    g: TaoGraphStruct = pydantic.Field(
        default=None,
        description="pointer to parent graph",
    )
    hist: TaoHistogramStruct = pydantic.Field(
        default=None,
    )
    z_color: TaoCurveColorStruct = pydantic.Field(
        default=None,
    )
    x_line: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Coords for drawing a curve",
    )
    y_line: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y2_line: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Second array needed for beam chamber curve.",
    )
    ix_line: Sequence[int] = pydantic.Field(
        default=0,
        description="Used by wave and aperture curves.",
    )
    x_symb: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Coords for drawing the symbols",
    )
    y_symb: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    z_symb: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Symbol color",
    )
    err_symb: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Error bars",
    )
    symb_size: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Symbol size. Used with symbol_size_scale.",
    )
    ix_symb: Sequence[int] = pydantic.Field(
        default=0,
        description="Corresponding index in d1_data%d(:) array.",
    )
    y_axis_scale_factor: float = pydantic.Field(
        default=1,
        description="y-axis conversion from internal to plotting units.",
    )
    line: QpLineStruct = pydantic.Field(
        default=None,
        description="Line attributes",
    )
    symbol: QpSymbolStruct = pydantic.Field(
        default=None,
        description="Symbol attributes",
    )
    orbit: TaoCurveOrbitStruct = pydantic.Field(
        default=None,
        description="Used for E/B field plotting.",
    )
    ix_universe: int = pydantic.Field(
        default=-1,
        description="Universe where data is. -1 => use s%global%default_universe",
    )
    symbol_every: int = pydantic.Field(
        default=1,
        description="Symbol every how many points.",
    )
    ix_branch: int = pydantic.Field(
        default=-1,
    )
    ix_bunch: int = pydantic.Field(
        default=0,
        description="Bunch to plot.",
    )
    n_turn: int = pydantic.Field(
        default=-1,
        description="Used for multi_turn_orbit plotting",
    )
    use_y2: bool = pydantic.Field(
        default=False,
        description="Use y2 axis?",
    )
    draw_line: bool = pydantic.Field(
        default=True,
        description="Draw a line through the data points?",
    )
    draw_symbols: bool = pydantic.Field(
        default=True,
        description="Draw a symbol at the data points?",
    )
    draw_symbol_index: bool = pydantic.Field(
        default=False,
        description="Draw the symbol index number curve%ix_symb?",
    )
    draw_error_bars: bool = pydantic.Field(
        default=False,
        description="Draw error bars based upon data%error_rms if drawing data?",
    )
    smooth_line_calc: bool = pydantic.Field(
        default=True,
        description="Calculate data between element edge points?",
    )
    valid: bool = pydantic.Field(
        default=False,
        description="valid data?",
    )


class TaoFloorPlanStruct(pydantic.BaseModel):
    """
    TaoFloorPlanStruct corresponds to bmad `tao_floor_plan_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 234.

    Attributes
    ----------
    view : str
        or 'xz'.
        Bmad type: character
        Fortran default: 'zx'
    rotation : float
        Rotation of floor plan plot: 1.0 -> 360^deg
        Bmad type: real
        Fortran default: 0
    correct_distortion : bool
        T -> Shrink one axis so x-scale = y-scale.
        Bmad type: logical
        Fortran default: .true.
    flip_label_side : bool
        Draw element label on other side of element?
        Bmad type: logical
        Fortran default: .false.
    size_is_absolute : bool
        Are shape sizes in meters or window pixels?
        Bmad type: logical
        Fortran default: .false.
    draw_only_first_pass : bool
        Draw only first pass with multipass elements?
        Bmad type: logical
        Fortran default: .false.
    draw_building_wall : bool
        Draw the building wall?
        Bmad type: logical
        Fortran default: .true.
    orbit_scale : float
        Scale factor for drawing orbits. 0 -> Do not draw.
        Bmad type: real
        Fortran default: 0
    orbit_color : str
        Bmad type: character
        Fortran default: 'red'
    orbit_pattern : str
        Bmad type: character
        Fortran default: 'solid'
    orbit_lattice : str
        Or 'design' or 'base'
        Bmad type: character
        Fortran default: 'model'
    orbit_width : int
        Bmad type: integer
        Fortran default: 1
    """

    view: str = pydantic.Field(
        default="zx",
        max_length=2,
        description="or 'xz'.",
    )
    rotation: float = pydantic.Field(
        default=0,
        description="Rotation of floor plan plot: 1.0 -> 360^deg",
    )
    correct_distortion: bool = pydantic.Field(
        default=True,
        description="T -> Shrink one axis so x-scale = y-scale.",
    )
    flip_label_side: bool = pydantic.Field(
        default=False,
        description="Draw element label on other side of element?",
    )
    size_is_absolute: bool = pydantic.Field(
        default=False,
        description="Are shape sizes in meters or window pixels?",
    )
    draw_only_first_pass: bool = pydantic.Field(
        default=False,
        description="Draw only first pass with multipass elements?",
    )
    draw_building_wall: bool = pydantic.Field(
        default=True,
        description="Draw the building wall?",
    )
    orbit_scale: float = pydantic.Field(
        default=0,
        description="Scale factor for drawing orbits. 0 -> Do not draw.",
    )
    orbit_color: str = pydantic.Field(
        default="red",
        max_length=16,
    )
    orbit_pattern: str = pydantic.Field(
        default="solid",
        max_length=16,
    )
    orbit_lattice: str = pydantic.Field(
        default="model",
        max_length=16,
        description="Or 'design' or 'base'",
    )
    orbit_width: int = pydantic.Field(
        default=1,
    )


class TaoGraphStruct(pydantic.BaseModel):
    """
    TaoGraphStruct corresponds to bmad `tao_graph_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 253.

    Attributes
    ----------
    name : str
        Name identifying the graph
        Bmad type: character
        Fortran default: ''
    type : str
        'data', 'lat_layout', 'phase_space', 'histogram', 'dynamic_aperture'
        Bmad type: character
        Fortran default: ''
    title : str
        Bmad type: character
        Fortran default: ''
    title_suffix : str
        Bmad type: character
        Fortran default: ''
    text_legend : str
        Array for holding descriptive info.
        Bmad type: character
        Fortran default: ''
    text_legend_out : str
        Array for holding descriptive info.
        Bmad type: character
        Fortran default: ''
    why_invalid : str
        Informative string to print.
        Bmad type: character
        Fortran default: '???'
    curve : TaoCurveStruct
        Bmad type: type
    p : TaoPlotStruct
        pointer to parent plot
        Bmad type: type
        Fortran default: null()
    floor_plan : TaoFloorPlanStruct
        Bmad type: type
        Fortran default: tao_floor_plan_struct()
    text_legend_origin : QpPointStruct
        Bmad type: type
        Fortran default: qp_point_struct()
    curve_legend_origin : QpPointStruct
        Bmad type: type
        Fortran default: qp_point_struct()
    curve_legend : QpLegendStruct
        Bmad type: type
        Fortran default: qp_legend_struct()
    x : QpAxisStruct
        X-axis parameters.
        Bmad type: type
        Fortran default: qp_axis_struct()
    y : QpAxisStruct
        Y-axis attributes.
        Bmad type: type
        Fortran default: qp_axis_struct()
    x2 : QpAxisStruct
        X2-axis attributes (Not currently used).
        Bmad type: type
        Fortran default: qp_axis_struct()
    y2 : QpAxisStruct
        Y2-axis attributes.
        Bmad type: type
        Fortran default: qp_axis_struct()
    margin : QpRectStruct
        Margin around the graph.
        Bmad type: type
        Fortran default: qp_rect_struct()
    scale_margin : QpRectStruct
        Margin for scaling
        Bmad type: type
        Fortran default: qp_rect_struct()
    x_axis_scale_factor : float
        x-axis conversion from internal to plotting units.
        Bmad type: real
        Fortran default: 1
    symbol_size_scale : float
        Symbol size scale factor for phase_space plots.
        Bmad type: real
        Fortran default: 0
    box : int
        Defines which box the plot is put in.
        Bmad type: integer
        Fortran default: 0
    ix_branch : int
        Branch in lattice. Used when there are no associated curves.
        Bmad type: integer
        Fortran default: -1
    ix_universe : int
        Used for lat_layout plots.
        Bmad type: integer
        Fortran default: -1
    clip : bool
        Clip plot at graph boundary.
        Bmad type: logical
        Fortran default: .false.
    y2_mirrors_y : bool
        Y2-axis same as Y-axis?
        Bmad type: logical
        Fortran default: .true.
    limited : bool
        True if at least one data point past graph bounds.
        Bmad type: logical
        Fortran default: .false.
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
    draw_title : bool
        Bmad type: logical
        Fortran default: .true.
    draw_only_good_user_data_or_vars : bool
        Bmad type: logical
        Fortran default: .true.
    allow_wrap_around : bool
        "Wrap" curves to extend past lattice boundaries?
        Bmad type: logical
        Fortran default: .true.
    is_valid : bool
        EG: Bad x_axis_type.
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name identifying the graph",
    )
    type: str = pydantic.Field(
        default="",
        max_length=40,
        description="'data', 'lat_layout', 'phase_space', 'histogram', 'dynamic_aperture'",
    )
    title: str = pydantic.Field(
        default="",
        max_length=100,
    )
    title_suffix: str = pydantic.Field(
        default="",
        max_length=100,
    )
    text_legend: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="Array for holding descriptive info.",
    )
    text_legend_out: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="Array for holding descriptive info.",
    )
    why_invalid: str = pydantic.Field(
        default="???",
        max_length=80,
        description="Informative string to print.",
    )
    curve: Sequence[TaoCurveStruct] = pydantic.Field(
        default=None,
    )
    p: TaoPlotStruct = pydantic.Field(
        default=None,
        description="pointer to parent plot",
    )
    floor_plan: TaoFloorPlanStruct = pydantic.Field(
        default=None,
    )
    text_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    curve_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    curve_legend: QpLegendStruct = pydantic.Field(
        default=None,
    )
    x: QpAxisStruct = pydantic.Field(
        default=None,
        description="X-axis parameters.",
    )
    y: QpAxisStruct = pydantic.Field(
        default=None,
        description="Y-axis attributes.",
    )
    x2: QpAxisStruct = pydantic.Field(
        default=None,
        description="X2-axis attributes (Not currently used).",
    )
    y2: QpAxisStruct = pydantic.Field(
        default=None,
        description="Y2-axis attributes.",
    )
    margin: QpRectStruct = pydantic.Field(
        default=None,
        description="Margin around the graph.",
    )
    scale_margin: QpRectStruct = pydantic.Field(
        default=None,
        description="Margin for scaling",
    )
    x_axis_scale_factor: float = pydantic.Field(
        default=1,
        description="x-axis conversion from internal to plotting units.",
    )
    symbol_size_scale: float = pydantic.Field(
        default=0,
        description="Symbol size scale factor for phase_space plots.",
    )
    box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=4,
        description="Defines which box the plot is put in.",
    )
    ix_branch: int = pydantic.Field(
        default=-1,
        description="Branch in lattice. Used when there are no associated curves.",
    )
    ix_universe: int = pydantic.Field(
        default=-1,
        description="Used for lat_layout plots.",
    )
    clip: bool = pydantic.Field(
        default=False,
        description="Clip plot at graph boundary.",
    )
    y2_mirrors_y: bool = pydantic.Field(
        default=True,
        description="Y2-axis same as Y-axis?",
    )
    limited: bool = pydantic.Field(
        default=False,
        description="True if at least one data point past graph bounds.",
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
    draw_title: bool = pydantic.Field(
        default=True,
    )
    draw_only_good_user_data_or_vars: bool = pydantic.Field(
        default=True,
    )
    allow_wrap_around: bool = pydantic.Field(
        default=True,
        description="'Wrap' curves to extend past lattice boundaries?",
    )
    is_valid: bool = pydantic.Field(
        default=False,
        description="EG: Bad x_axis_type.",
    )


class TaoPlotStruct(pydantic.BaseModel):
    """
    TaoPlotStruct corresponds to bmad `tao_plot_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 295.

    Attributes
    ----------
    name : str
        Identifying name. Rule: If name is blank, plot is not valid.
        Bmad type: character
        Fortran default: ''
    description : str
        Descriptive string.
        Bmad type: character
        Fortran default: ''
    graph : TaoGraphStruct
        individual graphs of a plot
        Bmad type: type
    r : TaoPlotRegionStruct
        pointer to parent.
        Bmad type: type
        Fortran default: null()
    ix_plot : int
        Index in s%plot_page%template(:) or %region(:) arrays.
        Bmad type: integer
        Fortran default: -1
    n_curve_pts : int
        Overrides s%plot_page%n_curve_pts.
        Bmad type: integer
        Fortran default: -1
    type : str
        or 'wave'
        Bmad type: character
        Fortran default: 'normal'
    x_axis_type : str
        'index', 'ele_index', 's', 'none', 'floor', 'phase_space', etc.
        Bmad type: character
        Fortran default: ''
    autoscale_x : bool
        Horizontal autoscale.
        Bmad type: logical
        Fortran default: .false.
    autoscale_y : bool
        Vertical autoscale.
        Bmad type: logical
        Fortran default: .false.
    autoscale_gang_x : bool
        scale cmd scales graphs together?
        Bmad type: logical
        Fortran default: .true.
    autoscale_gang_y : bool
        scale cmd scales graphs together?
        Bmad type: logical
        Fortran default: .true.
    list_with_show_plot_command : bool
        False used for default plots to shorten the output of "show plot"
        Bmad type: logical
        Fortran default: .true.
    phantom : bool
        Used by tao_plot_init to add info lines to "show plot -templates"
        Bmad type: logical
        Fortran default: .false.
    default_plot : bool
        One of Tao's default plots?
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Identifying name. Rule: If name is blank, plot is not valid.",
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
    r: TaoPlotRegionStruct = pydantic.Field(
        default=None,
        description="pointer to parent.",
    )
    ix_plot: int = pydantic.Field(
        default=-1,
        description="Index in s%plot_page%template(:) or %region(:) arrays.",
    )
    n_curve_pts: int = pydantic.Field(
        default=-1,
        description="Overrides s%plot_page%n_curve_pts.",
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
    autoscale_x: bool = pydantic.Field(
        default=False,
        description="Horizontal autoscale.",
    )
    autoscale_y: bool = pydantic.Field(
        default=False,
        description="Vertical autoscale.",
    )
    autoscale_gang_x: bool = pydantic.Field(
        default=True,
        description="scale cmd scales graphs together?",
    )
    autoscale_gang_y: bool = pydantic.Field(
        default=True,
        description="scale cmd scales graphs together?",
    )
    list_with_show_plot_command: bool = pydantic.Field(
        default=True,
        description="False used for default plots to shorten the output of 'show plot'",
    )
    phantom: bool = pydantic.Field(
        default=False,
        description="Used by tao_plot_init to add info lines to 'show plot -templates'",
    )
    default_plot: bool = pydantic.Field(
        default=False,
        description="One of Tao's default plots?",
    )


class TaoPlotRegionStruct(pydantic.BaseModel):
    """
    TaoPlotRegionStruct corresponds to bmad `tao_plot_region_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 318.

    Attributes
    ----------
    name : str
        Region name. Eg: 'r13', etc.
        Bmad type: character
        Fortran default: ''
    plot : TaoPlotStruct
        Plot associated with this region
        Bmad type: type
    location : float
        [x1, x2, y1, y2] location on page.
        Bmad type: real
        Fortran default: 0
    visible : bool
        To draw or not to draw.
        Bmad type: logical
        Fortran default: .false.
    list_with_show_plot_command : bool
        False used for default plots to shorten the output of "show plot"
        Bmad type: logical
        Fortran default: .true.
    setup_done : bool
        Used for plot bookkeeping.
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Region name. Eg: 'r13', etc.",
    )
    plot: TaoPlotStruct = pydantic.Field(
        default=None,
        description="Plot associated with this region",
    )
    location: Sequence[float] = pydantic.Field(
        default=0,
        max_length=4,
        description="[x1, x2, y1, y2] location on page.",
    )
    visible: bool = pydantic.Field(
        default=False,
        description="To draw or not to draw.",
    )
    list_with_show_plot_command: bool = pydantic.Field(
        default=True,
        description="False used for default plots to shorten the output of 'show plot'",
    )
    setup_done: bool = pydantic.Field(
        default=False,
        description="Used for plot bookkeeping.",
    )


class TaoPlotPageStruct(pydantic.BaseModel):
    """
    TaoPlotPageStruct corresponds to bmad `tao_plot_page_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 333.

    Attributes
    ----------
    title : TaoTitleStruct
        Title  at top of page.
        Bmad type: type
        Fortran default: tao_title_struct()
    subtitle : TaoTitleStruct
        Subtitle below title at top of page.
        Bmad type: type
        Fortran default: tao_title_struct()
    border : QpRectStruct
        Border around plots edge of page.
        Bmad type: type
        Fortran default: qp_rect_struct()
    floor_plan : TaoDrawingStruct
        Bmad type: type
        Fortran default: tao_drawing_struct(null())
    lat_layout : TaoDrawingStruct
        Bmad type: type
        Fortran default: tao_drawing_struct(null())
    pattern : TaoShapePatternStruct
        Bmad type: type
    template : TaoPlotStruct
        Templates for the plots.
        Bmad type: type
    region : TaoPlotRegionStruct
        Bmad type: type
    plot_display_type : str
        'X' or 'TK'
        Bmad type: character
        Fortran default: 'X'
    size : float
        width and height of plot window in pixels.
        Bmad type: real
        Fortran default: 0
    text_height : float
        In points. Scales the height of all text
        Bmad type: real
        Fortran default: 12
    main_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.3
    graph_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.1
    axis_number_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    axis_label_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.0
    legend_text_scale : float
        Relative to text_height. For legends, plot_page, and lat_layout
        Bmad type: real
        Fortran default: 0.9
    key_table_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    floor_plan_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    floor_plan_text_scale : float
        Scale used = floor_plan_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    lat_layout_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    lat_layout_text_scale : float
        Scale used = lat_layout_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    n_curve_pts : int
        Default number of points for plotting a smooth curve.
        Bmad type: integer
        Fortran default: n_curve_pts_init$
    id_window : int
        X window id number.
        Bmad type: integer
        Fortran default: -1
    delete_overlapping_plots : bool
        Delete overlapping plots when a plot is placed?
        Bmad type: logical
        Fortran default: .true.
    draw_graph_title_suffix : bool
        Draw the graph title suffix?
        Bmad type: logical
        Fortran default: .true.
    """

    title: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Title  at top of page.",
    )
    subtitle: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Subtitle below title at top of page.",
    )
    border: QpRectStruct = pydantic.Field(
        default=None,
        description="Border around plots edge of page.",
    )
    floor_plan: TaoDrawingStruct = pydantic.Field(
        default=None,
    )
    lat_layout: TaoDrawingStruct = pydantic.Field(
        default=None,
    )
    pattern: Sequence[TaoShapePatternStruct] = pydantic.Field(
        default=None,
    )
    template: Sequence[TaoPlotStruct] = pydantic.Field(
        default=None,
        description="Templates for the plots.",
    )
    region: Sequence[TaoPlotRegionStruct] = pydantic.Field(
        default=None,
    )
    plot_display_type: str = pydantic.Field(
        default="X",
        max_length=8,
        description="'X' or 'TK'",
    )
    size: Sequence[float] = pydantic.Field(
        default=0,
        max_length=2,
        description="width and height of plot window in pixels.",
    )
    text_height: float = pydantic.Field(
        default=12,
        description="In points. Scales the height of all text",
    )
    main_title_text_scale: float = pydantic.Field(
        default=1.3,
        description="Relative to text_height",
    )
    graph_title_text_scale: float = pydantic.Field(
        default=1.1,
        description="Relative to text_height",
    )
    axis_number_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    axis_label_text_scale: float = pydantic.Field(
        default=1.0,
        description="Relative to text_height",
    )
    legend_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height. For legends, plot_page, and lat_layout",
    )
    key_table_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    floor_plan_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    floor_plan_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = floor_plan_text_scale * legend_text_scale",
    )
    lat_layout_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    lat_layout_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = lat_layout_text_scale * legend_text_scale",
    )
    n_curve_pts: int = pydantic.Field(
        default=0,
        description="Default number of points for plotting a smooth curve.",
    )
    id_window: int = pydantic.Field(
        default=-1,
        description="X window id number.",
    )
    delete_overlapping_plots: bool = pydantic.Field(
        default=True,
        description="Delete overlapping plots when a plot is placed?",
    )
    draw_graph_title_suffix: bool = pydantic.Field(
        default=True,
        description="Draw the graph title suffix?",
    )


class TaoRegionArrayStruct(pydantic.BaseModel):
    """
    TaoRegionArrayStruct corresponds to bmad `tao_region_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 363.

    Attributes
    ----------
    r : TaoPlotRegionStruct
        Bmad type: type
    """

    r: TaoPlotRegionStruct = pydantic.Field(
        default=None,
    )


class TaoPlotArrayStruct(pydantic.BaseModel):
    """
    TaoPlotArrayStruct corresponds to bmad `tao_plot_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 367.

    Attributes
    ----------
    p : TaoPlotStruct
        Bmad type: type
    """

    p: TaoPlotStruct = pydantic.Field(
        default=None,
    )


class TaoGraphArrayStruct(pydantic.BaseModel):
    """
    TaoGraphArrayStruct corresponds to bmad `tao_graph_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 371.

    Attributes
    ----------
    g : TaoGraphStruct
        Bmad type: type
    """

    g: TaoGraphStruct = pydantic.Field(
        default=None,
    )


class TaoCurveArrayStruct(pydantic.BaseModel):
    """
    TaoCurveArrayStruct corresponds to bmad `tao_curve_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 375.

    Attributes
    ----------
    c : TaoCurveStruct
        Bmad type: type
    """

    c: TaoCurveStruct = pydantic.Field(
        default=None,
    )


class TaoSpinMapStruct(pydantic.BaseModel):
    """
    TaoSpinMapStruct corresponds to bmad `tao_spin_map_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 381.

    Attributes
    ----------
    valid : bool
        Bmad type: logical
        Fortran default: .false.
    map1 : SpinOrbitMap1Struct
        Bmad type: type
        Fortran default: spin_orbit_map1_struct()
    axis_input : SpinAxisStruct
        Input axes.
        Bmad type: type
        Fortran default: spin_axis_struct()
    axis0 : SpinAxisStruct
        Initial axes.
        Bmad type: type
        Fortran default: spin_axis_struct()
    axis1 : SpinAxisStruct
        Final axes.
        Bmad type: type
        Fortran default: spin_axis_struct()
    ix_ele : int
        Bmad type: integer
        Fortran default: 0
    ix_ref : int
        Bmad type: integer
        Fortran default: 0
    ix_uni : int
        Bmad type: integer
        Fortran default: 0
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    mat8 : float
        Bmad type: real
        Fortran default: 0
    """

    valid: bool = pydantic.Field(
        default=False,
    )
    map1: SpinOrbitMap1Struct = pydantic.Field(
        default=None,
    )
    axis_input: SpinAxisStruct = pydantic.Field(
        default=None,
        description="Input axes.",
    )
    axis0: SpinAxisStruct = pydantic.Field(
        default=None,
        description="Initial axes.",
    )
    axis1: SpinAxisStruct = pydantic.Field(
        default=None,
        description="Final axes.",
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
    ix_branch: int = pydantic.Field(
        default=0,
    )
    mat8: Sequence[float] = pydantic.Field(
        default=0,
    )


class TaoDataStruct(pydantic.BaseModel):
    """
    TaoDataStruct corresponds to bmad `tao_data_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 421.

    Attributes
    ----------
    ele_name : str
        Name of the lattice element where datum is evaluated.
        Bmad type: character
        Fortran default: ''
    ele_start_name : str
        Name of starting lattice element when there is a range
        Bmad type: character
        Fortran default: ''
    ele_ref_name : str
        Name of reference lattice element
        Bmad type: character
        Fortran default: ''
    data_type : str
        Type of data: 'orbit.x', etc.
        Bmad type: character
    merit_type : str
        Type of constraint: 'target', 'max', 'min', etc.
        Bmad type: character
        Fortran default: ''
    id : str
        Used by Tao extension code. Not used by Tao directly.
        Bmad type: character
        Fortran default: ''
    data_source : str
        'lat', 'beam', 'data' or 'var'. Last two used for expressions.
        Bmad type: character
        Fortran default: ''
    why_invalid : str
        Informational string if there is a problem.
        Bmad type: character
        Fortran default: ''
    ix_uni : int
        Universe index of datum.
        Bmad type: integer
        Fortran default: -1
    ix_bunch : int
        Bunch number to get the data from.
        Bmad type: integer
        Fortran default: 0
    ix_branch : int
        Index of the associated lattice branch.
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Index of the lattice element corresponding to ele_name
        Bmad type: integer
        Fortran default: -1
    ix_ele_start : int
        Index of lattice elment when there is a range
        Bmad type: integer
        Fortran default: -1
    ix_ele_ref : int
        Index of lattice elment when there is a reference.
        Bmad type: integer
        Fortran default: -1
    ix_ele_merit : int
        Index of lattice elment where merit is evaluated.
        Bmad type: integer
        Fortran default: -1
    ix_d1 : int
        Index number in u%d2_data(i)%d1_data(j)%d(:) array.
        Bmad type: integer
        Fortran default: -1
    ix_data : int
        Index of this datum in the u%data(:) array of data_structs.
        Bmad type: integer
        Fortran default: -1
    ix_dmodel : int
        Row number in the dModel_dVar derivative matrix.
        Bmad type: integer
        Fortran default: -1
    eval_point : int
        or anchor_center$, anchor_beginning$. Where to evaluate data relative to the
        element.
        Bmad type: integer
        Fortran default: anchor_end$
    meas_value : float
        Measured datum value.
        Bmad type: real
        Fortran default: 0
    ref_value : float
        Measured datum value from the reference data set.
        Bmad type: real
        Fortran default: 0
    bmad_model_value : float
        Datum value as calculated from the model.
        Bmad type: real
        Fortran default: 0
    design_value : float
        What the datum value is in the design lattice.
        Bmad type: real
        Fortran default: 0
    old_value : float
        The model_value at some previous time.
        Bmad type: real
        Fortran default: 0
    base_value : float
        The value as calculated from the base model.
        Bmad type: real
        Fortran default: 0
    error_rms : float
        Measurement error RMS. Used in plotting.
        Bmad type: real
        Fortran default: 0
    delta_merit : float
        Diff used to calculate the merit function term.
        Bmad type: real
        Fortran default: 0
    weight : float
        Weight for the merit function term.
        Bmad type: real
        Fortran default: 0
    invalid_value : float
        Value used in merit calc if good_model = F (or possibly good_design &
        good_base).
        Bmad type: real
        Fortran default: 0
    merit : float
        Merit function term value: weight * delta_merit^2
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
        Bmad type: type
    err_message_printed : bool
        Used to prevent zillions of error messages being generated
        Bmad type: logical
        Fortran default: .false.
    exists : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_model : bool
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
    good_ref : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_user : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    good_opt : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    good_plot : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    useit_plot : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    useit_opt : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    d1 : TaoD1DataStruct
        Pointer to the parent d1_data_struct
        Bmad type: type
        Fortran default: null()
    stack : TaoEvalStack1Struct
        Bmad type: type
    """

    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of the lattice element where datum is evaluated.",
    )
    ele_start_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of starting lattice element when there is a range",
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of reference lattice element",
    )
    data_type: str = pydantic.Field(
        default="",
        description="Type of data: 'orbit.x', etc.",
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=40,
        description="Type of constraint: 'target', 'max', 'min', etc.",
    )
    id: str = pydantic.Field(
        default="",
        max_length=40,
        description="Used by Tao extension code. Not used by Tao directly.",
    )
    data_source: str = pydantic.Field(
        default="",
        max_length=20,
        description="'lat', 'beam', 'data' or 'var'. Last two used for expressions.",
    )
    why_invalid: str = pydantic.Field(
        default="",
        max_length=100,
        description="Informational string if there is a problem.",
    )
    ix_uni: int = pydantic.Field(
        default=-1,
        description="Universe index of datum.",
    )
    ix_bunch: int = pydantic.Field(
        default=0,
        description="Bunch number to get the data from.",
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description="Index of the associated lattice branch.",
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description="Index of the lattice element corresponding to ele_name",
    )
    ix_ele_start: int = pydantic.Field(
        default=-1,
        description="Index of lattice elment when there is a range",
    )
    ix_ele_ref: int = pydantic.Field(
        default=-1,
        description="Index of lattice elment when there is a reference.",
    )
    ix_ele_merit: int = pydantic.Field(
        default=-1,
        description="Index of lattice elment where merit is evaluated.",
    )
    ix_d1: int = pydantic.Field(
        default=-1,
        description="Index number in u%d2_data(i)%d1_data(j)%d(:) array.",
    )
    ix_data: int = pydantic.Field(
        default=-1,
        description="Index of this datum in the u%data(:) array of data_structs.",
    )
    ix_dmodel: int = pydantic.Field(
        default=-1,
        description="Row number in the dModel_dVar derivative matrix.",
        validation_alias=pydantic.AliasChoices("ix_dmodel", "ix_dModel"),
        serialization_alias="ix_dModel",
    )
    eval_point: int = pydantic.Field(
        default=0,
        description=(
            "or anchor_center$, anchor_beginning$. Where to evaluate data relative to "
            "the element."
        ),
    )
    meas_value: float = pydantic.Field(
        default=0,
        description="Measured datum value.",
    )
    ref_value: float = pydantic.Field(
        default=0,
        description="Measured datum value from the reference data set.",
    )
    bmad_model_value: float = pydantic.Field(
        default=0,
        description="Datum value as calculated from the model.",
        validation_alias=pydantic.AliasChoices("bmad_model_value", "model_value"),
        serialization_alias="model_value",
    )
    design_value: float = pydantic.Field(
        default=0,
        description="What the datum value is in the design lattice.",
    )
    old_value: float = pydantic.Field(
        default=0,
        description="The model_value at some previous time.",
    )
    base_value: float = pydantic.Field(
        default=0,
        description="The value as calculated from the base model.",
    )
    error_rms: float = pydantic.Field(
        default=0,
        description="Measurement error RMS. Used in plotting.",
    )
    delta_merit: float = pydantic.Field(
        default=0,
        description="Diff used to calculate the merit function term.",
    )
    weight: float = pydantic.Field(
        default=0,
        description="Weight for the merit function term.",
    )
    invalid_value: float = pydantic.Field(
        default=0,
        description=(
            "Value used in merit calc if good_model = F (or possibly good_design & "
            "good_base)."
        ),
    )
    merit: float = pydantic.Field(
        default=0,
        description="Merit function term value: weight * delta_merit^2",
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
    err_message_printed: bool = pydantic.Field(
        default=False,
        description="Used to prevent zillions of error messages being generated",
    )
    exists: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_model: bool = pydantic.Field(
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
    good_ref: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_user: bool = pydantic.Field(
        default=True,
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
    useit_plot: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    useit_opt: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    d1: TaoD1DataStruct = pydantic.Field(
        default=None,
        description="Pointer to the parent d1_data_struct",
    )
    stack: Sequence[TaoEvalStack1Struct] = pydantic.Field(
        default=None,
    )


class TaoD1DataStruct(pydantic.BaseModel):
    """
    TaoD1DataStruct corresponds to bmad `tao_d1_data_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 475.

    Attributes
    ----------
    name : str
        Eg: 'x', etc.
        Bmad type: character
        Fortran default: ''
    d2 : TaoD2DataStruct
        ptr to parent d2_data
        Bmad type: type
        Fortran default: null()
    d : TaoDataStruct
        Bmad type: type
        Fortran default: null()
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Eg: 'x', etc.",
    )
    d2: TaoD2DataStruct = pydantic.Field(
        default=None,
        description="ptr to parent d2_data",
    )
    d: Sequence[TaoDataStruct] = pydantic.Field(
        default=None,
    )


class TaoD2DataStruct(pydantic.BaseModel):
    """
    TaoD2DataStruct corresponds to bmad `tao_d2_data_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 487.

    Attributes
    ----------
    name : str
        Name to be used with commands.
        Bmad type: character
        Fortran default: ''
    data_file_name : str
        Data file name .
        Bmad type: character
        Fortran default: ''
    ref_file_name : str
        Reference file name.
        Bmad type: character
        Fortran default: ''
    data_date : str
        Data measurement date.
        Bmad type: character
        Fortran default: ''
    ref_date : str
        Reference data measurement date.
        Bmad type: character
        Fortran default: ''
    descrip : str
        Array for descriptive information.
        Bmad type: character
        Fortran default: ''
    d1 : TaoD1DataStruct
        Points to children
        Bmad type: type
    ix_universe : int
        Index of universe this is in.
        Bmad type: integer
    ix_d2_data : int
        Index in u%d2_data(:) array.
        Bmad type: integer
    ix_ref : int
        Index of the reference data set.
        Bmad type: integer
    data_read_in : bool
        A data set has been read in?
        Bmad type: logical
        Fortran default: .false.
    ref_read_in : bool
        A reference data set has been read in?
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name to be used with commands.",
    )
    data_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Data file name .",
    )
    ref_file_name: str = pydantic.Field(
        default="",
        max_length=400,
        description="Reference file name.",
    )
    data_date: str = pydantic.Field(
        default="",
        max_length=24,
        description="Data measurement date.",
    )
    ref_date: str = pydantic.Field(
        default="",
        max_length=24,
        description="Reference data measurement date.",
    )
    descrip: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="Array for descriptive information.",
    )
    d1: Sequence[TaoD1DataStruct] = pydantic.Field(
        default=None,
        description="Points to children",
    )
    ix_universe: int = pydantic.Field(
        default=0,
        description="Index of universe this is in.",
    )
    ix_d2_data: int = pydantic.Field(
        default=0,
        description="Index in u%d2_data(:) array.",
    )
    ix_ref: int = pydantic.Field(
        default=0,
        description="Index of the reference data set.",
    )
    data_read_in: bool = pydantic.Field(
        default=False,
        description="A data set has been read in?",
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
        Bmad type: type
        Fortran default: null()
    """

    d: TaoDataStruct = pydantic.Field(
        default=None,
    )


class TaoD1DataArrayStruct(pydantic.BaseModel):
    """
    TaoD1DataArrayStruct corresponds to bmad `tao_d1_data_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 509.

    Attributes
    ----------
    d1 : TaoD1DataStruct
        Bmad type: type
        Fortran default: null()
    """

    d1: TaoD1DataStruct = pydantic.Field(
        default=None,
    )


class TaoD2DataArrayStruct(pydantic.BaseModel):
    """
    TaoD2DataArrayStruct corresponds to bmad `tao_d2_data_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 513.

    Attributes
    ----------
    d2 : TaoD2DataStruct
        Bmad type: type
        Fortran default: null()
    """

    d2: TaoD2DataStruct = pydantic.Field(
        default=None,
    )


class TaoVarSlaveStruct(pydantic.BaseModel):
    """
    TaoVarSlaveStruct corresponds to bmad `tao_var_slave_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 521.

    Attributes
    ----------
    ix_uni : int
        universe index.
        Bmad type: integer
        Fortran default: 1
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    ix_ele : int
        Index of element in the u%lattice%ele(:) array.
        Bmad type: integer
        Fortran default: -1
    bmad_model_value : float
        Pointer to the variable in the model lat.
        Bmad type: real
        Fortran default: null()
    base_value : float
        Pointer to the variable in the base lat.
        Bmad type: real
        Fortran default: null()
    """

    ix_uni: int = pydantic.Field(
        default=1,
        description="universe index.",
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_ele: int = pydantic.Field(
        default=-1,
        description="Index of element in the u%lattice%ele(:) array.",
    )
    bmad_model_value: float = pydantic.Field(
        default=0.0,
        description="Pointer to the variable in the model lat.",
        validation_alias=pydantic.AliasChoices("bmad_model_value", "model_value"),
        serialization_alias="model_value",
    )
    base_value: float = pydantic.Field(
        default=0.0,
        description="Pointer to the variable in the base lat.",
    )


class TaoVarStruct(pydantic.BaseModel):
    """
    TaoVarStruct corresponds to bmad `tao_var_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 545.

    Attributes
    ----------
    ele_name : str
        Associated lattice element name.
        Bmad type: character
        Fortran default: ''
    attrib_name : str
        Name of the attribute to vary.
        Bmad type: character
        Fortran default: ''
    id : str
        Used by Tao extension code. Not used by Tao directly.
        Bmad type: character
        Fortran default: ''
    slave : TaoVarSlaveStruct
        Bmad type: type
    ix_v1 : int
        Index of this var in the s%v1_var(i)%v(:) array.
        Bmad type: integer
        Fortran default: 0
    ix_var : int
        Index number of this var in the s%var(:) array.
        Bmad type: integer
        Fortran default: 0
    ix_dvar : int
        Column in the dData_dVar derivative matrix.
        Bmad type: integer
        Fortran default: -1
    ix_attrib : int
        Index in ele%value(:) array if appropriate.
        Bmad type: integer
        Fortran default: 0
    ix_key_table : int
        Has a key binding?
        Bmad type: integer
        Fortran default: 0
    bmad_model_value : float
        Model value.
        Bmad type: real
        Fortran default: null()
    base_value : float
        Base value.
        Bmad type: real
        Fortran default: null()
    design_value : float
        Design value from the design lattice.
        Bmad type: real
        Fortran default: 0
    scratch_value : float
        Scratch space used by Tao.
        Bmad type: real
        Fortran default: 0
    old_value : float
        Scratch space used by Tao.
        Bmad type: real
        Fortran default: 0
    meas_value : float
        The value when the data measurement was taken.
        Bmad type: real
        Fortran default: 0
    ref_value : float
        Value when the reference measurement was taken.
        Bmad type: real
        Fortran default: 0
    correction_value : float
        Value determined by a fit to correct the lattice.
        Bmad type: real
        Fortran default: 0
    high_lim : float
        High limit for the model_value.
        Bmad type: real
        Fortran default: -1d30
    low_lim : float
        Low limit for the model_value.
        Bmad type: real
        Fortran default: 1d30
    step : float
        Sets what is a small step for varying this var.
        Bmad type: real
        Fortran default: 0
    weight : float
        Weight for the merit function term.
        Bmad type: real
        Fortran default: 0
    delta_merit : float
        Diff used to calculate the merit function term.
        Bmad type: real
        Fortran default: 0
    merit : float
        merit_term = weight * delta^2.
        Bmad type: real
        Fortran default: 0
    dmerit_dvar : float
        Merit derivative.
        Bmad type: real
        Fortran default: 0
    key_val0 : float
        Key base value
        Bmad type: real
        Fortran default: 0
    key_delta : float
        Change in value when a key is pressed.
        Bmad type: real
        Fortran default: 0
    s : float
        longitudinal position of ele.
        Bmad type: real
        Fortran default: 0
    extend_val : float
        For extension code. Not used by Tao.
        Bmad type: real
    merit_type : str
        'target' or 'limit'
        Bmad type: character
        Fortran default: ''
    exists : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_var : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_user : bool
        See above
        Bmad type: logical
        Fortran default: .true.
    good_opt : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    good_plot : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    useit_opt : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    useit_plot : bool
        See above
        Bmad type: logical
        Fortran default: .false.
    key_bound : bool
        Variable bound to keyboard key?
        Bmad type: logical
        Fortran default: .false.
    v1 : TaoV1VarStruct
        Pointer to the parent.
        Bmad type: type
        Fortran default: null()
    """

    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Associated lattice element name.",
    )
    attrib_name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Name of the attribute to vary.",
    )
    id: str = pydantic.Field(
        default="",
        max_length=40,
        description="Used by Tao extension code. Not used by Tao directly.",
    )
    slave: Sequence[TaoVarSlaveStruct] = pydantic.Field(
        default=None,
    )
    ix_v1: int = pydantic.Field(
        default=0,
        description="Index of this var in the s%v1_var(i)%v(:) array.",
    )
    ix_var: int = pydantic.Field(
        default=0,
        description="Index number of this var in the s%var(:) array.",
    )
    ix_dvar: int = pydantic.Field(
        default=-1,
        description="Column in the dData_dVar derivative matrix.",
    )
    ix_attrib: int = pydantic.Field(
        default=0,
        description="Index in ele%value(:) array if appropriate.",
    )
    ix_key_table: int = pydantic.Field(
        default=0,
        description="Has a key binding?",
    )
    bmad_model_value: float = pydantic.Field(
        default=0.0,
        description="Model value.",
        validation_alias=pydantic.AliasChoices("bmad_model_value", "model_value"),
        serialization_alias="model_value",
    )
    base_value: float = pydantic.Field(
        default=0.0,
        description="Base value.",
    )
    design_value: float = pydantic.Field(
        default=0,
        description="Design value from the design lattice.",
    )
    scratch_value: float = pydantic.Field(
        default=0,
        description="Scratch space used by Tao.",
    )
    old_value: float = pydantic.Field(
        default=0,
        description="Scratch space used by Tao.",
    )
    meas_value: float = pydantic.Field(
        default=0,
        description="The value when the data measurement was taken.",
    )
    ref_value: float = pydantic.Field(
        default=0,
        description="Value when the reference measurement was taken.",
    )
    correction_value: float = pydantic.Field(
        default=0,
        description="Value determined by a fit to correct the lattice.",
    )
    high_lim: float = pydantic.Field(
        default=-1e30,
        description="High limit for the model_value.",
    )
    low_lim: float = pydantic.Field(
        default=1e30,
        description="Low limit for the model_value.",
    )
    step: float = pydantic.Field(
        default=0,
        description="Sets what is a small step for varying this var.",
    )
    weight: float = pydantic.Field(
        default=0,
        description="Weight for the merit function term.",
    )
    delta_merit: float = pydantic.Field(
        default=0,
        description="Diff used to calculate the merit function term.",
    )
    merit: float = pydantic.Field(
        default=0,
        description="merit_term = weight * delta^2.",
    )
    dmerit_dvar: float = pydantic.Field(
        default=0,
        description="Merit derivative.",
        validation_alias=pydantic.AliasChoices("dmerit_dvar", "dMerit_dVar"),
        serialization_alias="dMerit_dVar",
    )
    key_val0: float = pydantic.Field(
        default=0,
        description="Key base value",
    )
    key_delta: float = pydantic.Field(
        default=0,
        description="Change in value when a key is pressed.",
    )
    s: float = pydantic.Field(
        default=0,
        description="longitudinal position of ele.",
    )
    extend_val: float = pydantic.Field(
        default=0.0,
        description="For extension code. Not used by Tao.",
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=40,
        description="'target' or 'limit'",
    )
    exists: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_var: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_user: bool = pydantic.Field(
        default=True,
        description="See above",
    )
    good_opt: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    good_plot: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    useit_opt: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    useit_plot: bool = pydantic.Field(
        default=False,
        description="See above",
    )
    key_bound: bool = pydantic.Field(
        default=False,
        description="Variable bound to keyboard key?",
    )
    v1: TaoV1VarStruct = pydantic.Field(
        default=None,
        description="Pointer to the parent.",
    )


class TaoV1VarStruct(pydantic.BaseModel):
    """
    TaoV1VarStruct corresponds to bmad `tao_v1_var_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 589.

    Attributes
    ----------
    name : str
        V1 variable name. Eg: 'quad_k1'.
        Bmad type: character
        Fortran default: ''
    ix_v1_var : int
        Index to s%v1_var(:) array
        Bmad type: integer
        Fortran default: -1
    v : TaoVarStruct
        Bmad type: type
        Fortran default: null()
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="V1 variable name. Eg: 'quad_k1'.",
    )
    ix_v1_var: int = pydantic.Field(
        default=-1,
        description="Index to s%v1_var(:) array",
    )
    v: Sequence[TaoVarStruct] = pydantic.Field(
        default=None,
    )


class TaoVarArrayStruct(pydantic.BaseModel):
    """
    TaoVarArrayStruct corresponds to bmad `tao_var_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 599.

    Attributes
    ----------
    v : TaoVarStruct
        Bmad type: type
        Fortran default: null()
    """

    v: TaoVarStruct = pydantic.Field(
        default=None,
    )


class TaoV1VarArrayStruct(pydantic.BaseModel):
    """
    TaoV1VarArrayStruct corresponds to bmad `tao_v1_var_array_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 603.

    Attributes
    ----------
    v1 : TaoV1VarStruct
        Bmad type: type
        Fortran default: null()
    """

    v1: TaoV1VarStruct = pydantic.Field(
        default=None,
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
    z : float
        Global floor position
        Bmad type: real
        Fortran default: 0
    x : float
        Global floor position
        Bmad type: real
        Fortran default: 0
    radius : float
        Arc radius. +r -> CW rotation, same as bends.
        Bmad type: real
        Fortran default: 0
    z_center : float
        Arc center.
        Bmad type: real
        Fortran default: 0
    x_center : float
        Arc center.
        Bmad type: real
        Fortran default: 0
    """

    z: float = pydantic.Field(
        default=0,
        description="Global floor position",
    )
    x: float = pydantic.Field(
        default=0,
        description="Global floor position",
    )
    radius: float = pydantic.Field(
        default=0,
        description="Arc radius. +r -> CW rotation, same as bends.",
    )
    z_center: float = pydantic.Field(
        default=0,
        description="Arc center.",
    )
    x_center: float = pydantic.Field(
        default=0,
        description="Arc center.",
    )


class TaoBuildingWallSectionStruct(pydantic.BaseModel):
    """
    TaoBuildingWallSectionStruct corresponds to bmad `tao_building_wall_section_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 623.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    constraint : str
        "left_side" or "right_side" constraint.
        Bmad type: character
        Fortran default: ''
    point : TaoBuildingWallPointStruct
        Bmad type: type
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    constraint: str = pydantic.Field(
        default="",
        max_length=16,
        description="'left_side' or 'right_side' constraint.",
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
        Bmad type: type
        Fortran default: tao_building_wall_orientation_struct()
    section : TaoBuildingWallSectionStruct
        Bmad type: type
    """

    orientation: TaoBuildingWallOrientationStruct = pydantic.Field(
        default=None,
    )
    section: Sequence[TaoBuildingWallSectionStruct] = pydantic.Field(
        default=None,
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
    lm_opt_deriv_reinit : float
        Reinit derivative matrix cutoff
        Bmad type: real
        Fortran default: -1
    de_lm_step_ratio : float
        Scaling for step sizes between DE and LM optimizers.
        Bmad type: real
        Fortran default: 1
    de_var_to_population_factor : float
        DE population = max(n_var*factor, 20)
        Bmad type: real
        Fortran default: 5.0_rp
    lmdif_eps : float
        Tollerance for lmdif optimizer.
        Bmad type: real
        Fortran default: 1e-12
    lmdif_negligible_merit : float
        Bmad type: real
        Fortran default: 1d-30
    svd_cutoff : float
        SVD singular value cutoff.
        Bmad type: real
        Fortran default: 1e-5
    unstable_penalty : float
        Used in unstable_ring datum merit calculation.
        Bmad type: real
        Fortran default: 1e-3
    merit_stop_value : float
        Merit value below which an optimizer will stop.
        Bmad type: real
        Fortran default: 0
    dmerit_stop_value : float
        Fractional Merit change below which an optimizer will stop.
        Bmad type: real
        Fortran default: 0
    random_sigma_cutoff : float
        Cut-off in sigmas.
        Bmad type: real
        Fortran default: -1
    delta_e_chrom : float
        Delta E used from chrom calc.
        Bmad type: real
        Fortran default: 0
    max_plot_time : float
        If plotting time (seconds) exceeds this than a message is generated.
        Bmad type: real
        Fortran default: 5
    default_universe : int
        Default universe to work with.
        Bmad type: integer
        Fortran default: 1
    default_branch : int
        Default lattice branch to work with.
        Bmad type: integer
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
    phase_units : int
        Phase units on output.
        Bmad type: integer
        Fortran default: radians$
    bunch_to_plot : int
        Which bunch to plot
        Bmad type: integer
        Fortran default: 1
    random_seed : int
        Use system clock by default
        Bmad type: integer
        Fortran default: -1
    n_top10_merit : int
        Number of top merit constraints to print.
        Bmad type: integer
        Fortran default: 10
    srdt_gen_n_slices : int
        Number times to slice elements for summation RDT calculation
        Bmad type: integer
        Fortran default: 10
    datum_err_messages_max : int
        Maximum number of error messages per call to lattice_calc.
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
    quiet : str
        Print I/O when running a command file?
        Bmad type: character
        Fortran default: 'off'
    random_engine : str
        Non-beam random number engine
        Bmad type: character
        Fortran default: ''
    random_gauss_converter : str
        Non-beam
        Bmad type: character
        Fortran default: ''
    track_type : str
        or 'beam'
        Bmad type: character
        Fortran default: 'single'
    prompt_string : str
        Bmad type: character
        Fortran default: 'Tao'
    prompt_color : str
        See read_a_line routine for possible settings.
        Bmad type: character
        Fortran default: 'DEFAULT'
    optimizer : str
        optimizer to use.
        Bmad type: character
        Fortran default: 'lm'
    print_command : str
        Bmad type: character
        Fortran default: 'lpr'
    var_out_file : str
        Bmad type: character
        Fortran default: 'var#.out'
    history_file : str
        Bmad type: character
        Fortran default: '~/.history_tao'
    beam_timer_on : bool
        For timing the beam tracking calculation.
        Bmad type: logical
        Fortran default: .false.
    box_plots : bool
        For debugging plot layout issues.
        Bmad type: logical
        Fortran default: .false.
    cmd_file_abort_on_error : bool
        Abort open command files if there is an error?
        Bmad type: logical
        Fortran default: .true.
    concatenate_maps : bool
        False => tracking using DA.
        Bmad type: logical
        Fortran default: .false.
    debug_on : bool
        For debugging.
        Bmad type: logical
        Fortran default: .false.
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
    draw_curve_off_scale_warn : bool
        Display warning on graphs?
        Bmad type: logical
        Fortran default: .true.
    external_plotting : bool
        Used with matplotlib and gui.
        Bmad type: logical
        Fortran default: .false.
    init_lat_sigma_from_beam : bool
        Initial lattice derived sigma matrix derived from beam dist?
        Bmad type: logical
        Fortran default: .false.
    label_lattice_elements : bool
        For lat_layout plots
        Bmad type: logical
        Fortran default: .true.
    label_keys : bool
        For lat_layout plots
        Bmad type: logical
        Fortran default: .true.
    lattice_calc_on : bool
        Turn on/off beam and single particle calculations.
        Bmad type: logical
        Fortran default: .true.
    only_limit_opt_vars : bool
        Only apply limits to variables used in optimization.
        Bmad type: logical
        Fortran default: .false.
    opt_with_ref : bool
        Use reference data in optimization?
        Bmad type: logical
        Fortran default: .false.
    opt_with_base : bool
        Use base data in optimization?
        Bmad type: logical
        Fortran default: .false.
    opt_match_auto_recalc : bool
        Set recalc = True for match elements before each cycle?
        Bmad type: logical
        Fortran default: .false.
    opti_write_var_file : bool
        "run" command writes var_out_file
        Bmad type: logical
        Fortran default: .true.
    optimizer_allow_user_abort : bool
        See Tao manual for more details.
        Bmad type: logical
        Fortran default: .true.
    optimizer_var_limit_warn : bool
        Warn when vars reach a limit with optimization.
        Bmad type: logical
        Fortran default: .true.
    plot_on : bool
        Do plotting?
        Bmad type: logical
        Fortran default: .true.
    rad_int_user_calc_on : bool
        User set radiation integrals calculation on/off.
        Bmad type: logical
        Fortran default: .true.
    rf_on : bool
        RFcavities on or off? Does not affect lcavities.
        Bmad type: logical
        Fortran default: .true.
    single_step : bool
        For debugging and demonstrations: Single step through a command file?
        Bmad type: logical
        Fortran default: .false.
    stop_on_error : bool
        For debugging: False prevents tao from exiting on an error.
        Bmad type: logical
        Fortran default: .true.
    svd_retreat_on_merit_increase : bool
        Bmad type: logical
        Fortran default: .true.
    var_limits_on : bool
        Respect the variable limits?
        Bmad type: logical
        Fortran default: .true.
    wait_for_cr_in_single_mode : bool
        For use with a python GUI.
        Bmad type: logical
        Fortran default: .false.
    blank_line_between_commands : bool
        Add a blank line between command output?
        Bmad type: logical
        Fortran default: .true.
    symbol_import : bool
        Import symbols from lattice file(s)?
        Bmad type: logical
        Fortran default: .false.
    """

    beam_dead_cutoff: float = pydantic.Field(
        default=0.99,
        description="Percentage of dead particles at which beam tracking is stopped.",
    )
    lm_opt_deriv_reinit: float = pydantic.Field(
        default=-1,
        description="Reinit derivative matrix cutoff",
    )
    de_lm_step_ratio: float = pydantic.Field(
        default=1,
        description="Scaling for step sizes between DE and LM optimizers.",
    )
    de_var_to_population_factor: float = pydantic.Field(
        default=5.0,
        description="DE population = max(n_var*factor, 20)",
    )
    lmdif_eps: float = pydantic.Field(
        default=1e-12,
        description="Tollerance for lmdif optimizer.",
    )
    lmdif_negligible_merit: float = pydantic.Field(
        default=1e-30,
    )
    svd_cutoff: float = pydantic.Field(
        default=1e-05,
        description="SVD singular value cutoff.",
    )
    unstable_penalty: float = pydantic.Field(
        default=0.001,
        description="Used in unstable_ring datum merit calculation.",
    )
    merit_stop_value: float = pydantic.Field(
        default=0,
        description="Merit value below which an optimizer will stop.",
    )
    dmerit_stop_value: float = pydantic.Field(
        default=0,
        description="Fractional Merit change below which an optimizer will stop.",
    )
    random_sigma_cutoff: float = pydantic.Field(
        default=-1,
        description="Cut-off in sigmas.",
    )
    delta_e_chrom: float = pydantic.Field(
        default=0,
        description="Delta E used from chrom calc.",
    )
    max_plot_time: float = pydantic.Field(
        default=5,
        description="If plotting time (seconds) exceeds this than a message is generated.",
    )
    default_universe: int = pydantic.Field(
        default=1,
        description="Default universe to work with.",
    )
    default_branch: int = pydantic.Field(
        default=0,
        description="Default lattice branch to work with.",
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
    phase_units: int = pydantic.Field(
        default=0,
        description="Phase units on output.",
    )
    bunch_to_plot: int = pydantic.Field(
        default=1,
        description="Which bunch to plot",
    )
    random_seed: int = pydantic.Field(
        default=-1,
        description="Use system clock by default",
    )
    n_top10_merit: int = pydantic.Field(
        default=10,
        description="Number of top merit constraints to print.",
    )
    srdt_gen_n_slices: int = pydantic.Field(
        default=10,
        description="Number times to slice elements for summation RDT calculation",
    )
    datum_err_messages_max: int = pydantic.Field(
        default=10,
        description="Maximum number of error messages per call to lattice_calc.",
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
    quiet: str = pydantic.Field(
        default="off",
        max_length=12,
        description="Print I/O when running a command file?",
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
    track_type: str = pydantic.Field(
        default="single",
        max_length=16,
        description="or 'beam'",
    )
    prompt_string: str = pydantic.Field(
        default="Tao",
        max_length=40,
    )
    prompt_color: str = pydantic.Field(
        default="DEFAULT",
        max_length=16,
        description="See read_a_line routine for possible settings.",
    )
    optimizer: str = pydantic.Field(
        default="lm",
        max_length=16,
        description="optimizer to use.",
    )
    print_command: str = pydantic.Field(
        default="lpr",
        max_length=40,
    )
    var_out_file: str = pydantic.Field(
        default="var#.out",
        max_length=80,
    )
    history_file: str = pydantic.Field(
        default="~/.history_tao",
        max_length=100,
    )
    beam_timer_on: bool = pydantic.Field(
        default=False,
        description="For timing the beam tracking calculation.",
    )
    box_plots: bool = pydantic.Field(
        default=False,
        description="For debugging plot layout issues.",
    )
    cmd_file_abort_on_error: bool = pydantic.Field(
        default=True,
        description="Abort open command files if there is an error?",
    )
    concatenate_maps: bool = pydantic.Field(
        default=False,
        description="False => tracking using DA.",
    )
    debug_on: bool = pydantic.Field(
        default=False,
        description="For debugging.",
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
    draw_curve_off_scale_warn: bool = pydantic.Field(
        default=True,
        description="Display warning on graphs?",
    )
    external_plotting: bool = pydantic.Field(
        default=False,
        description="Used with matplotlib and gui.",
    )
    init_lat_sigma_from_beam: bool = pydantic.Field(
        default=False,
        description="Initial lattice derived sigma matrix derived from beam dist?",
    )
    label_lattice_elements: bool = pydantic.Field(
        default=True,
        description="For lat_layout plots",
    )
    label_keys: bool = pydantic.Field(
        default=True,
        description="For lat_layout plots",
    )
    lattice_calc_on: bool = pydantic.Field(
        default=True,
        description="Turn on/off beam and single particle calculations.",
    )
    only_limit_opt_vars: bool = pydantic.Field(
        default=False,
        description="Only apply limits to variables used in optimization.",
    )
    opt_with_ref: bool = pydantic.Field(
        default=False,
        description="Use reference data in optimization?",
    )
    opt_with_base: bool = pydantic.Field(
        default=False,
        description="Use base data in optimization?",
    )
    opt_match_auto_recalc: bool = pydantic.Field(
        default=False,
        description="Set recalc = True for match elements before each cycle?",
    )
    opti_write_var_file: bool = pydantic.Field(
        default=True,
        description="'run' command writes var_out_file",
    )
    optimizer_allow_user_abort: bool = pydantic.Field(
        default=True,
        description="See Tao manual for more details.",
    )
    optimizer_var_limit_warn: bool = pydantic.Field(
        default=True,
        description="Warn when vars reach a limit with optimization.",
    )
    plot_on: bool = pydantic.Field(
        default=True,
        description="Do plotting?",
    )
    rad_int_user_calc_on: bool = pydantic.Field(
        default=True,
        description="User set radiation integrals calculation on/off.",
    )
    rf_on: bool = pydantic.Field(
        default=True,
        description="RFcavities on or off? Does not affect lcavities.",
    )
    single_step: bool = pydantic.Field(
        default=False,
        description="For debugging and demonstrations: Single step through a command file?",
    )
    stop_on_error: bool = pydantic.Field(
        default=True,
        description="For debugging: False prevents tao from exiting on an error.",
    )
    svd_retreat_on_merit_increase: bool = pydantic.Field(
        default=True,
    )
    var_limits_on: bool = pydantic.Field(
        default=True,
        description="Respect the variable limits?",
    )
    wait_for_cr_in_single_mode: bool = pydantic.Field(
        default=False,
        description="For use with a python GUI.",
        validation_alias=pydantic.AliasChoices(
            "wait_for_cr_in_single_mode", "wait_for_CR_in_single_mode"
        ),
        serialization_alias="wait_for_CR_in_single_mode",
    )
    blank_line_between_commands: bool = pydantic.Field(
        default=True,
        description="Add a blank line between command output?",
    )
    symbol_import: bool = pydantic.Field(
        default=False,
        description="Import symbols from lattice file(s)?",
    )


class TaoAliasStruct(pydantic.BaseModel):
    """
    TaoAliasStruct corresponds to bmad `tao_alias_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 710.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    expanded_str : str
        Bmad type: character
        Fortran default: ''
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    expanded_str: str = pydantic.Field(
        default="",
        max_length=200,
    )


class TaoCommandFileStruct(pydantic.BaseModel):
    """
    TaoCommandFileStruct corresponds to bmad `tao_command_file_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 715.

    Attributes
    ----------
    full_name : str
        Bmad type: character
        Fortran default: ''
    dir : str
        Bmad type: character
        Fortran default: './'
    ix_unit : int
        Bmad type: integer
    cmd_arg : str
        Command file arguments.
        Bmad type: character
        Fortran default: ''
    quiet : str
        Bmad type: character
        Fortran default: 'off'
    paused : bool
        Is the command file paused?
        Bmad type: logical
        Fortran default: .false.
    n_line : int
        Current line number
        Bmad type: integer
        Fortran default: 0
    reset_at_end : bool
        Reset lattice_calc_on and plot_on at end of file?
        Bmad type: logical
        Fortran default: .true.
    lattice_calc_save : bool
        Bmad type: logical
        Fortran default: .true.
    plot_save : bool
        Bmad type: logical
        Fortran default: .true.
    """

    full_name: str = pydantic.Field(
        default="",
        max_length=400,
    )
    dir: str = pydantic.Field(
        default="./",
        max_length=400,
    )
    ix_unit: int = pydantic.Field(
        default=0,
    )
    cmd_arg: Sequence[str] = pydantic.Field(
        default="",
        max_length=9,
        description="Command file arguments.",
    )
    quiet: str = pydantic.Field(
        default="off",
        max_length=12,
    )
    paused: bool = pydantic.Field(
        default=False,
        description="Is the command file paused?",
    )
    n_line: int = pydantic.Field(
        default=0,
        description="Current line number",
    )
    reset_at_end: bool = pydantic.Field(
        default=True,
        description="Reset lattice_calc_on and plot_on at end of file?",
    )
    lattice_calc_save: bool = pydantic.Field(
        default=True,
    )
    plot_save: bool = pydantic.Field(
        default=True,
    )


class DoLoopStruct(pydantic.BaseModel):
    """
    DoLoopStruct corresponds to bmad `do_loop_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 728.

    Attributes
    ----------
    name : str
        do loop index name
        Bmad type: character
        Fortran default: ''
    index : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    start : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    end : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    step : int
        for do loops
        Bmad type: integer
        Fortran default: 0
    n_line_start : int
        lines in each nested loop
        Bmad type: integer
        Fortran default: 0
    n_line_end : int
        lines in each nested loop
        Bmad type: integer
        Fortran default: 0
    value : int
        Bmad type: integer
        Fortran default: int_garbage$
    """

    name: str = pydantic.Field(
        default="",
        max_length=20,
        description="do loop index name",
    )
    index: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    start: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    end: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    step: int = pydantic.Field(
        default=0,
        description="for do loops",
    )
    n_line_start: int = pydantic.Field(
        default=0,
        description="lines in each nested loop",
    )
    n_line_end: int = pydantic.Field(
        default=0,
        description="lines in each nested loop",
    )
    value: int = pydantic.Field(
        default=0,
    )


class TaoCommonStruct(pydantic.BaseModel):
    """
    TaoCommonStruct corresponds to bmad `tao_common_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 740.

    Attributes
    ----------
    alias : TaoAliasStruct
        Bmad type: type
        Fortran default: tao_alias_struct()
    key : TaoAliasStruct
        Bmad type: type
        Fortran default: tao_alias_struct()
    cmd_file : TaoCommandFileStruct
        Bmad type: type
    symbolic_num : NamedNumberStruct
        Named numbers
        Bmad type: type
    plot_place_buffer : TaoPlotRegionStruct
        Used when %external_plotting is on.
        Bmad type: type
    do_loop : DoLoopStruct
        Bmad type: type
    covar : float
        Bmad type: real
    alpha : float
        Bmad type: real
    dummy_target : float
        Dummy varaible
        Bmad type: real
        Fortran default: 0
    ix_ref_taylor : int
        Taylor map end points
        Bmad type: integer
        Fortran default: -1
    ix_ele_taylor : int
        Taylor map end points
        Bmad type: integer
        Fortran default: -1
    n_alias : int
        Bmad type: integer
        Fortran default: 0
    cmd_file_level : int
        For nested command files. 0 -> no command file.
        Bmad type: integer
        Fortran default: 0
    ix_key_bank : int
        For single mode.
        Bmad type: integer
        Fortran default: 0
    ix_history : int
        present index to command history array
        Bmad type: integer
        Fortran default: 0
    n_history : int
        present history index
        Bmad type: integer
        Fortran default: 0
    lev_loop : int
        in do loop nest level
        Bmad type: integer
        Fortran default: 0
    n_err_messages_printed : int
        Used by tao_set_invalid to limit number of messages.
        Bmad type: integer
        Fortran default: 0
    n_universes : int
        Bmad type: integer
        Fortran default: n_uni_init$
    ix_beam_track_active_element : int
        Element being tracked through `tao_beam_track`.
        Bmad type: integer
        Fortran default: -1
    cmd_file_paused : bool
        Bmad type: logical
        Fortran default: .false.
    use_cmd_here : bool
        Used for commands recalled from the cmd history stack
        Bmad type: logical
        Fortran default: .false.
    cmd_from_cmd_file : bool
        was command from a command file?
        Bmad type: logical
        Fortran default: .false.
    use_saved_beam_in_tracking : bool
        Bmad type: logical
        Fortran default: .false.
    single_mode : bool
        Bmad type: logical
        Fortran default: .false.
    combine_consecutive_elements_of_like_name : bool
        Bmad type: logical
        Fortran default: .false.
    have_tracked_beam : bool
        Used to catch error when beam plotting without having tracked a beam.
        Bmad type: logical
        Fortran default: .false.
    init_plot_needed : bool
        reinitialize plotting?
        Bmad type: logical
        Fortran default: .true.
    init_beam : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    init_var : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    init_read_lat_info : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    optimizer_running : bool
        Bmad type: logical
        Fortran default: .false.
    have_datums_using_expressions : bool
        Bmad type: logical
        Fortran default: .false.
    print_to_terminal : bool
        Print command prompt to the terminal? For use with GUIs.
        Bmad type: logical
        Fortran default: .true.
    lattice_calc_done : bool
        Used by GUI for deciding when to refresh.
        Bmad type: logical
        Fortran default: .false.
    add_measurement_noise : bool
        Turn off to take data derivatives.
        Bmad type: logical
        Fortran default: .true.
    is_err_message_printed : bool
        Used by tao_set_invalid
        Bmad type: logical
        Fortran default: .false.
    command_arg_has_been_executed : bool
        Has the -command command line argument been executed?
        Bmad type: logical
        Fortran default: .false.
    all_merit_weights_positive : bool
        Bmad type: logical
        Fortran default: .true.
    multi_turn_orbit_is_plotted : bool
        Is a multi_turn_orbit being plotted?
        Bmad type: logical
        Fortran default: .false.
    force_chrom_calc : bool
        Used by a routine to force calculation
        Bmad type: logical
        Fortran default: .false.
    force_rad_int_calc : bool
        Used by a routine to force calculation
        Bmad type: logical
        Fortran default: .false.
    rad_int_ri_calc_on : bool
        "Classical" radiation integrals calculation on/off.
        Bmad type: logical
        Fortran default: .true.
    rad_int_6d_calc_on : bool
        6D Radiation integrals calculation on/off.
        Bmad type: logical
        Fortran default: .true.
    valid_plot_who : str
        model, base, ref etc...
        Bmad type: character
        Fortran default: ''
    single_mode_buffer : str
        Bmad type: character
        Fortran default: ''
    cmd : str
        Used for the cmd history
        Bmad type: character
        Fortran default: ''
    saved_cmd_line : str
        Saved part of command line when there are mulitple commands on a line
        Bmad type: character
        Fortran default: ''
    """

    alias: Sequence[TaoAliasStruct] = pydantic.Field(
        default=None,
        max_length=200,
    )
    key: Sequence[TaoAliasStruct] = pydantic.Field(
        default=None,
        max_length=100,
    )
    cmd_file: Sequence[TaoCommandFileStruct] = pydantic.Field(
        default=None,
    )
    symbolic_num: Sequence[NamedNumberStruct] = pydantic.Field(
        default=None,
        description="Named numbers",
    )
    plot_place_buffer: Sequence[TaoPlotRegionStruct] = pydantic.Field(
        default=None,
        description="Used when %external_plotting is on.",
    )
    do_loop: Sequence[DoLoopStruct] = pydantic.Field(
        default=None,
    )
    covar: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    alpha: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    dummy_target: float = pydantic.Field(
        default=0,
        description="Dummy varaible",
    )
    ix_ref_taylor: int = pydantic.Field(
        default=-1,
        description="Taylor map end points",
    )
    ix_ele_taylor: int = pydantic.Field(
        default=-1,
        description="Taylor map end points",
    )
    n_alias: int = pydantic.Field(
        default=0,
    )
    cmd_file_level: int = pydantic.Field(
        default=0,
        description="For nested command files. 0 -> no command file.",
    )
    ix_key_bank: int = pydantic.Field(
        default=0,
        description="For single mode.",
    )
    ix_history: int = pydantic.Field(
        default=0,
        description="present index to command history array",
    )
    n_history: int = pydantic.Field(
        default=0,
        description="present history index",
    )
    lev_loop: int = pydantic.Field(
        default=0,
        description="in do loop nest level",
    )
    n_err_messages_printed: int = pydantic.Field(
        default=0,
        description="Used by tao_set_invalid to limit number of messages.",
    )
    n_universes: int = pydantic.Field(
        default=0,
    )
    ix_beam_track_active_element: int = pydantic.Field(
        default=-1,
        description="Element being tracked through `tao_beam_track`.",
    )
    cmd_file_paused: bool = pydantic.Field(
        default=False,
    )
    use_cmd_here: bool = pydantic.Field(
        default=False,
        description="Used for commands recalled from the cmd history stack",
    )
    cmd_from_cmd_file: bool = pydantic.Field(
        default=False,
        description="was command from a command file?",
    )
    use_saved_beam_in_tracking: bool = pydantic.Field(
        default=False,
    )
    single_mode: bool = pydantic.Field(
        default=False,
    )
    combine_consecutive_elements_of_like_name: bool = pydantic.Field(
        default=False,
    )
    have_tracked_beam: bool = pydantic.Field(
        default=False,
        description="Used to catch error when beam plotting without having tracked a beam.",
    )
    init_plot_needed: bool = pydantic.Field(
        default=True,
        description="reinitialize plotting?",
    )
    init_beam: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    init_var: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    init_read_lat_info: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    optimizer_running: bool = pydantic.Field(
        default=False,
    )
    have_datums_using_expressions: bool = pydantic.Field(
        default=False,
    )
    print_to_terminal: bool = pydantic.Field(
        default=True,
        description="Print command prompt to the terminal? For use with GUIs.",
    )
    lattice_calc_done: bool = pydantic.Field(
        default=False,
        description="Used by GUI for deciding when to refresh.",
    )
    add_measurement_noise: bool = pydantic.Field(
        default=True,
        description="Turn off to take data derivatives.",
    )
    is_err_message_printed: Sequence[bool] = pydantic.Field(
        default=False,
        max_length=2,
        description="Used by tao_set_invalid",
    )
    command_arg_has_been_executed: bool = pydantic.Field(
        default=False,
        description="Has the -command command line argument been executed?",
    )
    all_merit_weights_positive: bool = pydantic.Field(
        default=True,
    )
    multi_turn_orbit_is_plotted: bool = pydantic.Field(
        default=False,
        description="Is a multi_turn_orbit being plotted?",
    )
    force_chrom_calc: bool = pydantic.Field(
        default=False,
        description="Used by a routine to force calculation",
    )
    force_rad_int_calc: bool = pydantic.Field(
        default=False,
        description="Used by a routine to force calculation",
    )
    rad_int_ri_calc_on: bool = pydantic.Field(
        default=True,
        description="'Classical' radiation integrals calculation on/off.",
    )
    rad_int_6d_calc_on: bool = pydantic.Field(
        default=True,
        description="6D Radiation integrals calculation on/off.",
    )
    valid_plot_who: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
        description="model, base, ref etc...",
    )
    single_mode_buffer: str = pydantic.Field(
        default="",
        max_length=200,
    )
    cmd: str = pydantic.Field(
        default="",
        max_length=200,
        description="Used for the cmd history",
    )
    saved_cmd_line: str = pydantic.Field(
        default="",
        max_length=200,
        description="Saved part of command line when there are mulitple commands on a line",
    )


class TaoInitStruct(pydantic.BaseModel):
    """
    TaoInitStruct corresponds to bmad `tao_init_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 791.

    Attributes
    ----------
    parse_cmd_args : bool
        Used by custom programs to control Tao init
        Bmad type: logical
        Fortran default: .true.
    debug_switch : bool
        Is the "-debug" switch present?
        Bmad type: logical
        Fortran default: .false.
    external_plotting_switch : bool
        Is "-external_plotting" switch present?
        Bmad type: logical
        Fortran default: .false.
    init_name : str
        label for initialization
        Bmad type: character
        Fortran default: 'Tao'
    hook_init_file : str
        Bmad type: character
        Fortran default: ''
    hook_lat_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_beam_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    hook_data_file : str
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
    hook_building_wall_file : str
        To be set by tao_hook_parse_command_args
        Bmad type: character
        Fortran default: ''
    init_file_arg_path : str
        Path part of init_tao_file
        Bmad type: character
        Fortran default: ''
    lattice_file_arg : str
        -lattice_file        command line argument.
        Bmad type: character
        Fortran default: ''
    hook_init_file_arg : str
        -hook_init_file      command line argument
        Bmad type: character
        Fortran default: ''
    init_file_arg : str
        -init_file           command line argument.
        Bmad type: character
        Fortran default: ''
    beam_file_arg : str
        -beam_file           command line argument.
        Bmad type: character
        Fortran default: ''
    beam_init_position_file_arg : str
        -beam_init_position_file command line argument.
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
    plot_file_arg : str
        -plot_file           command line argument.
        Bmad type: character
        Fortran default: ''
    startup_file_arg : str
        -startup_file        command line argument.
        Bmad type: character
        Fortran default: ''
    var_file_arg : str
        -var_file            command line argument.
        Bmad type: character
        Fortran default: ''
    building_wall_file_arg : str
        -building_wall_file  command line argument.
        Bmad type: character
        Fortran default: ''
    geometry_arg : str
        -geometry            command line argument.
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
    log_startup_arg : str
        -log_startup         command line argument
        Bmad type: character
        Fortran default: ''
    no_stopping_arg : str
        -no_stopping         command line argument
        Bmad type: character
        Fortran default: ''
    noplot_arg : str
        -noplot              command line argument
        Bmad type: character
        Fortran default: ''
    no_rad_int_arg : str
        -no_rad_int          command line argument
        Bmad type: character
        Fortran default: ''
    reverse_arg : str
        -reverse             command line argument
        Bmad type: character
        Fortran default: ''
    debug_arg : str
        -debug               command line argument
        Bmad type: character
        Fortran default: ''
    disable_smooth_line_calc_arg : str
        -disable_smooth_line_calc
        Bmad type: character
        Fortran default: ''
    rf_on_arg : str
        -rf_on               command line argument
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
    noinit_arg : str
        -noinit              command line argument
        Bmad type: character
        Fortran default: ''
    nostartup_arg : str
        -nostartup           command line argument
        Bmad type: character
        Fortran default: ''
    symbol_import_arg : str
        -symbol_import       command line argument
        Bmad type: character
        Fortran default: ''
    unique_name_suffix : str
        Bmad type: character
        Fortran default: ''
    """

    parse_cmd_args: bool = pydantic.Field(
        default=True,
        description="Used by custom programs to control Tao init",
    )
    debug_switch: bool = pydantic.Field(
        default=False,
        description="Is the '-debug' switch present?",
    )
    external_plotting_switch: bool = pydantic.Field(
        default=False,
        description="Is '-external_plotting' switch present?",
    )
    init_name: str = pydantic.Field(
        default="Tao",
        max_length=16,
        description="label for initialization",
    )
    hook_init_file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    hook_lat_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_beam_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    hook_data_file: str = pydantic.Field(
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
    hook_building_wall_file: str = pydantic.Field(
        default="",
        max_length=400,
        description="To be set by tao_hook_parse_command_args",
    )
    init_file_arg_path: str = pydantic.Field(
        default="",
        max_length=400,
        description="Path part of init_tao_file",
    )
    lattice_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-lattice_file        command line argument.",
    )
    hook_init_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-hook_init_file      command line argument",
    )
    init_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-init_file           command line argument.",
    )
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
    plot_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-plot_file           command line argument.",
    )
    startup_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-startup_file        command line argument.",
    )
    var_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-var_file            command line argument.",
    )
    building_wall_file_arg: str = pydantic.Field(
        default="",
        max_length=400,
        description="-building_wall_file  command line argument.",
    )
    geometry_arg: str = pydantic.Field(
        default="",
        max_length=16,
        description="-geometry            command line argument.",
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
    log_startup_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-log_startup         command line argument",
    )
    no_stopping_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-no_stopping         command line argument",
    )
    noplot_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-noplot              command line argument",
    )
    no_rad_int_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-no_rad_int          command line argument",
    )
    reverse_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-reverse             command line argument",
    )
    debug_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-debug               command line argument",
    )
    disable_smooth_line_calc_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-disable_smooth_line_calc",
    )
    rf_on_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-rf_on               command line argument",
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
    noinit_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-noinit              command line argument",
    )
    nostartup_arg: str = pydantic.Field(
        default="",
        max_length=12,
        description="-nostartup           command line argument",
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


class TaoBeamShakeStruct(pydantic.BaseModel):
    """
    TaoBeamShakeStruct corresponds to bmad `tao_beam_shake_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 838.

    Attributes
    ----------
    cbar : float
        Bmad type: real
    k_11a : float
        Bmad type: real
    k_12a : float
        Bmad type: real
    k_12b : float
        Bmad type: real
    k_22b : float
        Bmad type: real
    amp_a : float
        Bmad type: real
    amp_b : float
        Bmad type: real
    amp_na : float
        Bmad type: real
    amp_nb : float
        Bmad type: real
    one : float
        Bmad type: real
        Fortran default: 1.0
    coupling_calc_done : bool
        Bmad type: logical
        Fortran default: .false.
    amp_calc_done : bool
        Bmad type: logical
        Fortran default: .false.
    """

    cbar: Sequence[float] = pydantic.Field(
        default=0.0,
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
    amp_a: float = pydantic.Field(
        default=0.0,
    )
    amp_b: float = pydantic.Field(
        default=0.0,
    )
    amp_na: float = pydantic.Field(
        default=0.0,
    )
    amp_nb: float = pydantic.Field(
        default=0.0,
    )
    one: float = pydantic.Field(
        default=1.0,
    )
    coupling_calc_done: bool = pydantic.Field(
        default=False,
    )
    amp_calc_done: bool = pydantic.Field(
        default=False,
    )


class TaoScratchSpaceStruct(pydantic.BaseModel):
    """
    TaoScratchSpaceStruct corresponds to bmad `tao_scratch_space_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 847.

    Attributes
    ----------
    cc : TaoBeamShakeStruct
        Bmad type: type
    eles : ElePointerStruct
        Bmad type: type
    d1_array : TaoD1DataArrayStruct
        Bmad type: type
    v1_array : TaoV1VarArrayStruct
        Bmad type: type
    stack : TaoEvalStack1Struct
        Bmad type: type
    var_array : TaoVarArrayStruct
        Bmad type: type
    attribs : AllPointerStruct
        Bmad type: type
    comp : TaoDataVarComponentStruct
        Bmad type: type
    info : TaoExpressionInfoStruct
        Bmad type: type
    info_x : TaoExpressionInfoStruct
        Bmad type: type
    info_y : TaoExpressionInfoStruct
        Bmad type: type
    info_ix : TaoExpressionInfoStruct
        Bmad type: type
    picked : bool
        Bmad type: logical
    axis1 : float
        Bmad type: real
    axis2 : float
        Bmad type: real
    axis3 : float
        Bmad type: real
    x : float
        Bmad type: real
    y : float
        Bmad type: real
    err : float
        Bmad type: real
    y_value : float
        Bmad type: real
    srdt_cache : Complex
        Bmad type: complex
    """

    cc: Sequence[TaoBeamShakeStruct] = pydantic.Field(
        default=None,
    )
    eles: Sequence[ElePointerStruct] = pydantic.Field(
        default=None,
    )
    d1_array: Sequence[TaoD1DataArrayStruct] = pydantic.Field(
        default=None,
    )
    v1_array: Sequence[TaoV1VarArrayStruct] = pydantic.Field(
        default=None,
    )
    stack: Sequence[TaoEvalStack1Struct] = pydantic.Field(
        default=None,
    )
    var_array: Sequence[TaoVarArrayStruct] = pydantic.Field(
        default=None,
    )
    attribs: Sequence[AllPointerStruct] = pydantic.Field(
        default=None,
    )
    comp: Sequence[TaoDataVarComponentStruct] = pydantic.Field(
        default=None,
    )
    info: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    info_x: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    info_y: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    info_ix: Sequence[TaoExpressionInfoStruct] = pydantic.Field(
        default=None,
    )
    picked: Sequence[bool] = pydantic.Field(
        default=False,
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
    x: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    err: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    y_value: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    srdt_cache: Sequence[Complex] = pydantic.Field(
        default=0.0,
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


class TaoSpinDnDpzStruct(pydantic.BaseModel):
    """
    TaoSpinDnDpzStruct corresponds to bmad `tao_spin_dn_dpz_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 878.

    Attributes
    ----------
    vec : float
        n0 derivative wrt pz.
        Bmad type: real
    partial : float
        partial(i:) is spin n0 derivative wrt pz for i^th oscillation mode (1 =>
        a-mode, etc.)
        Bmad type: real
    partial2 : float
        partial(i:) is spin n0 derivative wrt pz with i^th oscillation mode missing (1
        => a-mode, etc.)
        Bmad type: real
    """

    vec: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="n0 derivative wrt pz.",
    )
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


class TaoSpinEleStruct(pydantic.BaseModel):
    """
    TaoSpinEleStruct corresponds to bmad `tao_spin_ele_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 884.

    Attributes
    ----------
    dn_dpz : TaoSpinDnDpzStruct
        Bmad type: type
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


class TaoSpinPolarizationStruct(pydantic.BaseModel):
    """
    TaoSpinPolarizationStruct corresponds to bmad `tao_spin_polarization_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 892.

    Attributes
    ----------
    tune : float
        Bmad type: real
        Fortran default: real_garbage$
    pol_limit_st : float
        Polarization calculated using Sokolov-Ternov formula.
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
    pol_rate_bks : float
        BKS Polarization rate (1/sec).
        Bmad type: real
        Fortran default: real_garbage$
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
    integral_bn : float
        Integral of g^3 * b_hat * n_0
        Bmad type: real
        Fortran default: real_garbage$
    integral_bdn : float
        Integral of g^3 * b_hat * dn/ddelta
        Bmad type: real
        Fortran default: real_garbage$
    integral_1ns : float
        Integral of g^3 (1 - 2(n * s_hat)/9)
        Bmad type: real
        Fortran default: real_garbage$
    integral_dn2 : float
        Integral of g^3 * 11 (dn/ddelta)^2 / 9
        Bmad type: real
        Fortran default: real_garbage$
    valid : bool
        Bmad type: logical
        Fortran default: .false.
    q_1turn : SpinOrbitMap1Struct
        Save results from spin_concat_linear_maps in tao_spin_polarization.
        Bmad type: type
    q_ele : SpinOrbitMap1Struct
        Save results from spin_concat_linear_maps in tao_spin_polarization.
        Bmad type: type
    """

    tune: float = pydantic.Field(
        default=0.0,
    )
    pol_limit_st: float = pydantic.Field(
        default=0.0,
        description="Polarization calculated using Sokolov-Ternov formula.",
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
    pol_rate_bks: float = pydantic.Field(
        default=0.0,
        description="BKS Polarization rate (1/sec).",
    )
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
    integral_bn: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 * b_hat * n_0",
    )
    integral_bdn: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 * b_hat * dn/ddelta",
    )
    integral_1ns: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 (1 - 2(n * s_hat)/9)",
    )
    integral_dn2: float = pydantic.Field(
        default=0.0,
        description="Integral of g^3 * 11 (dn/ddelta)^2 / 9",
    )
    valid: bool = pydantic.Field(
        default=False,
    )
    q_1turn: SpinOrbitMap1Struct = pydantic.Field(
        default=None,
        description="Save results from spin_concat_linear_maps in tao_spin_polarization.",
    )
    q_ele: Sequence[SpinOrbitMap1Struct] = pydantic.Field(
        default=None,
        description="Save results from spin_concat_linear_maps in tao_spin_polarization.",
    )


class TaoPlotCacheStruct(pydantic.BaseModel):
    """
    TaoPlotCacheStruct corresponds to bmad `tao_plot_cache_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 913.

    Attributes
    ----------
    ele : EleStruct
        Bmad type: type
    orbit : CoordStruct
        Bmad type: type
    err : bool
        Bmad type: logical
    """

    ele: EleStruct = pydantic.Field(
        default=None,
    )
    orbit: CoordStruct = pydantic.Field(
        default=None,
    )
    err: bool = pydantic.Field(
        default=False,
    )


class TaoLatticeBranchStruct(pydantic.BaseModel):
    """
    TaoLatticeBranchStruct corresponds to bmad `tao_lattice_branch_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 923.

    Attributes
    ----------
    tao_lat : TaoLatticeStruct
        Parent tao_lat
        Bmad type: type
        Fortran default: null()
    lat_sigma : TaoLatSigmaStruct
        Sigma matrix derived from lattice (not beam).
        Bmad type: type
    spin_ele : TaoSpinEleStruct
        Spin stuff
        Bmad type: type
    bunch_params : BunchParamsStruct
        Per element
        Bmad type: type
    bunch_params_comb : BunchTrackStruct
        A comb for each bunch in beam.
        Bmad type: type
    orbit : CoordStruct
        Bmad type: type
    plot_cache : TaoPlotCacheStruct
        Plotting data cache
        Bmad type: type
    a : TaoLatModeStruct
        Bmad type: type
    b : TaoLatModeStruct
        Bmad type: type
    spin : TaoSpinPolarizationStruct
        Bmad type: type
    srdt : SummationRdtStruct
        Bmad type: type
    orb0 : CoordStruct
        For saving beginning orbit
        Bmad type: type
    modes_ri : NormalModesStruct
        Synchrotron integrals stuff
        Bmad type: type
    modes_6d : NormalModesStruct
        6D radiation matrices.
        Bmad type: type
    ptc_normal_form : PtcNormalFormStruct
        Bmad type: type
    bmad_normal_form : BmadNormalFormStruct
        Bmad type: type
    high_e_orb : CoordStruct
        Bmad type: type
    low_e_orb : CoordStruct
        Bmad type: type
    cache_x_min : float
        Bmad type: real
        Fortran default: 0
    cache_x_max : float
        Bmad type: real
        Fortran default: 0
    comb_ds_save : float
        Master parameter for %bunch_params_comb(:)%ds_save
        Bmad type: real
        Fortran default: -1
    track_state : int
        Bmad type: integer
    cache_n_pts : int
        Bmad type: integer
        Fortran default: 0
    ix_rad_int_cache : int
        Radiation integrals cache index.
        Bmad type: integer
    n_hterms : int
        Number of distinct res driving terms to evaluate.
        Bmad type: integer
        Fortran default: 0
    has_open_match_element : bool
        Bmad type: logical
        Fortran default: .false.
    plot_cache_valid : bool
        Valid plotting data cache?
        Bmad type: logical
        Fortran default: .false.
    spin_map_valid : bool
        Bmad type: logical
        Fortran default: .false.
    twiss_valid : bool
        Invalid EG with unstable 1-turn matrix with a closed branch.
        Bmad type: logical
        Fortran default: .true.
    mode_flip_here : bool
        Twiss parameter mode flip seen?
        Bmad type: logical
        Fortran default: .false.
    """

    tao_lat: TaoLatticeStruct = pydantic.Field(
        default=None,
        description="Parent tao_lat",
    )
    lat_sigma: Sequence[TaoLatSigmaStruct] = pydantic.Field(
        default=None,
        description="Sigma matrix derived from lattice (not beam).",
    )
    spin_ele: Sequence[TaoSpinEleStruct] = pydantic.Field(
        default=None,
        description="Spin stuff",
    )
    bunch_params: Sequence[BunchParamsStruct] = pydantic.Field(
        default=None,
        description="Per element",
    )
    bunch_params_comb: Sequence[BunchTrackStruct] = pydantic.Field(
        default=None,
        description="A comb for each bunch in beam.",
    )
    orbit: Sequence[CoordStruct] = pydantic.Field(
        default=None,
    )
    plot_cache: Sequence[TaoPlotCacheStruct] = pydantic.Field(
        default=None,
        description="Plotting data cache",
    )
    a: TaoLatModeStruct = pydantic.Field(
        default=None,
    )
    b: TaoLatModeStruct = pydantic.Field(
        default=None,
    )
    spin: TaoSpinPolarizationStruct = pydantic.Field(
        default=None,
    )
    srdt: SummationRdtStruct = pydantic.Field(
        default=None,
    )
    orb0: CoordStruct = pydantic.Field(
        default=None,
        description="For saving beginning orbit",
    )
    modes_ri: NormalModesStruct = pydantic.Field(
        default=None,
        description="Synchrotron integrals stuff",
    )
    modes_6d: NormalModesStruct = pydantic.Field(
        default=None,
        description="6D radiation matrices.",
    )
    ptc_normal_form: PtcNormalFormStruct = pydantic.Field(
        default=None,
    )
    bmad_normal_form: BmadNormalFormStruct = pydantic.Field(
        default=None,
    )
    high_e_orb: Sequence[CoordStruct] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("high_e_orb", "high_E_orb"),
        serialization_alias="high_E_orb",
    )
    low_e_orb: Sequence[CoordStruct] = pydantic.Field(
        default=None,
        validation_alias=pydantic.AliasChoices("low_e_orb", "low_E_orb"),
        serialization_alias="low_E_orb",
    )
    cache_x_min: float = pydantic.Field(
        default=0,
    )
    cache_x_max: float = pydantic.Field(
        default=0,
    )
    comb_ds_save: float = pydantic.Field(
        default=-1,
        description="Master parameter for %bunch_params_comb(:)%ds_save",
    )
    track_state: int = pydantic.Field(
        default=0,
    )
    cache_n_pts: int = pydantic.Field(
        default=0,
    )
    ix_rad_int_cache: int = pydantic.Field(
        default=0,
        description="Radiation integrals cache index.",
    )
    n_hterms: int = pydantic.Field(
        default=0,
        description="Number of distinct res driving terms to evaluate.",
    )
    has_open_match_element: bool = pydantic.Field(
        default=False,
    )
    plot_cache_valid: bool = pydantic.Field(
        default=False,
        description="Valid plotting data cache?",
    )
    spin_map_valid: bool = pydantic.Field(
        default=False,
    )
    twiss_valid: bool = pydantic.Field(
        default=True,
        description="Invalid EG with unstable 1-turn matrix with a closed branch.",
    )
    mode_flip_here: bool = pydantic.Field(
        default=False,
        description="Twiss parameter mode flip seen?",
    )


class TaoLatticeStruct(pydantic.BaseModel):
    """
    TaoLatticeStruct corresponds to bmad `tao_lattice_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 957.

    Attributes
    ----------
    name : str
        "model", "base", or "design".
        Bmad type: character
    lat : LatStruct
        lattice structures
        Bmad type: type
    high_e_lat : LatStruct
        For chrom calc.
        Bmad type: type
    low_e_lat : LatStruct
        For chrom calc.
        Bmad type: type
    chrom_calc_ok : bool
        Bmad type: logical
        Fortran default: .false.
    u : TaoUniverseStruct
        Parent universe
        Bmad type: type
        Fortran default: null()
    rad_int_by_ele_ri : RadIntAllEleStruct
        Bmad type: type
    rad_int_by_ele_6d : RadIntAllEleStruct
        Bmad type: type
    tao_branch : TaoLatticeBranchStruct
        Bmad type: type
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=8,
        description="'model', 'base', or 'design'.",
    )
    lat: LatStruct = pydantic.Field(
        default=None,
        description="lattice structures",
    )
    high_e_lat: LatStruct = pydantic.Field(
        default=None,
        description="For chrom calc.",
        validation_alias=pydantic.AliasChoices("high_e_lat", "high_E_lat"),
        serialization_alias="high_E_lat",
    )
    low_e_lat: LatStruct = pydantic.Field(
        default=None,
        description="For chrom calc.",
        validation_alias=pydantic.AliasChoices("low_e_lat", "low_E_lat"),
        serialization_alias="low_E_lat",
    )
    chrom_calc_ok: bool = pydantic.Field(
        default=False,
    )
    u: TaoUniverseStruct = pydantic.Field(
        default=None,
        description="Parent universe",
    )
    rad_int_by_ele_ri: RadIntAllEleStruct = pydantic.Field(
        default=None,
    )
    rad_int_by_ele_6d: RadIntAllEleStruct = pydantic.Field(
        default=None,
    )
    tao_branch: Sequence[TaoLatticeBranchStruct] = pydantic.Field(
        default=None,
    )


class TaoModelElementStruct(pydantic.BaseModel):
    """
    TaoModelElementStruct corresponds to bmad `tao_model_element_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 975.

    Attributes
    ----------
    beam : BeamStruct
        Beam distribution at element.
        Bmad type: type
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


class TaoBeamBranchStruct(pydantic.BaseModel):
    """
    TaoBeamBranchStruct corresponds to bmad `tao_beam_branch_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 985.

    Attributes
    ----------
    beam_at_start : BeamStruct
        Initial beam
        Bmad type: type
    beam_init : BeamInitStruct
        User set beam distrubution at track start.
        Bmad type: type
    beam_init_used : BeamInitStruct
        beam distribution with emit values set.
        Bmad type: type
    init_starting_distribution : bool
        Init beam
        Bmad type: logical
        Fortran default: .true.
    track_start : str
        Tracking start element.
        Bmad type: character
        Fortran default: ''
    track_end : str
        Bmad type: character
        Fortran default: ''
    ix_branch : int
        Branch tracked.
        Bmad type: integer
        Fortran default: 0
    ix_track_start : int
        Element track start index.
        Bmad type: integer
        Fortran default: not_set$
    ix_track_end : int
        Element track end index
        Bmad type: integer
        Fortran default: not_set$
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
    track_start: str = pydantic.Field(
        default="",
        max_length=40,
        description="Tracking start element.",
    )
    track_end: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ix_branch: int = pydantic.Field(
        default=0,
        description="Branch tracked.",
    )
    ix_track_start: int = pydantic.Field(
        default=0,
        description="Element track start index.",
    )
    ix_track_end: int = pydantic.Field(
        default=0,
        description="Element track end index",
    )


class TaoModelBranchStruct(pydantic.BaseModel):
    """
    TaoModelBranchStruct corresponds to bmad `tao_model_branch_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1000.

    Attributes
    ----------
    ele : TaoModelElementStruct
        Per element information
        Bmad type: type
    beam : TaoBeamBranchStruct
        Bmad type: type
    """

    ele: Sequence[TaoModelElementStruct] = pydantic.Field(
        default=None,
        description="Per element information",
    )
    beam: TaoBeamBranchStruct = pydantic.Field(
        default=None,
    )


class TaoBeamUniStruct(pydantic.BaseModel):
    """
    TaoBeamUniStruct corresponds to bmad `tao_beam_uni_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1007.

    Attributes
    ----------
    saved_at : str
        Bmad type: character
        Fortran default: ''
    dump_file : str
        Bmad type: character
        Fortran default: ''
    dump_at : str
        Bmad type: character
        Fortran default: ''
    track_beam_in_universe : bool
        Beam tracking enabled in this universe?
        Bmad type: logical
        Fortran default: .false.
    always_reinit : bool
        Bmad type: logical
        Fortran default: .false.
    """

    saved_at: str = pydantic.Field(
        default="",
        max_length=200,
    )
    dump_file: str = pydantic.Field(
        default="",
        max_length=400,
    )
    dump_at: str = pydantic.Field(
        default="",
        max_length=200,
    )
    track_beam_in_universe: bool = pydantic.Field(
        default=False,
        description="Beam tracking enabled in this universe?",
    )
    always_reinit: bool = pydantic.Field(
        default=False,
    )


class TaoUniverseCalcStruct(pydantic.BaseModel):
    """
    TaoUniverseCalcStruct corresponds to bmad `tao_universe_calc_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1018.

    Attributes
    ----------
    srdt_for_data : int
        0 = false, 1 = 1st order, 2 = 1st & 2nd order
        Bmad type: integer
        Fortran default: 0
    rad_int_for_data : bool
        Do the radiation integrals need to be computed for
        Bmad type: logical
        Fortran default: .false.
    rad_int_for_plotting : bool
        data or plotting?
        Bmad type: logical
        Fortran default: .false.
    chrom_for_data : bool
        Does the chromaticity need to be computed for
        Bmad type: logical
        Fortran default: .false.
    chrom_for_plotting : bool
        data or plotting?
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
    dynamic_aperture : bool
        Do the dynamic_aperture calc?
        Bmad type: logical
        Fortran default: .false.
    one_turn_map : bool
        Compute the one turn map?
        Bmad type: logical
        Fortran default: .false.
    lattice : bool
        Used to indicate which lattices need tracking done.
        Bmad type: logical
        Fortran default: .true.
    twiss : bool
        calc linear transfer matrix?
        Bmad type: logical
        Fortran default: .true.
    track : bool
        tracking needs to be done?
        Bmad type: logical
        Fortran default: .true.
    spin_matrices : bool
        Calculate G and D spin matrices?
        Bmad type: logical
        Fortran default: .false.
    """

    srdt_for_data: int = pydantic.Field(
        default=0,
        description="0 = false, 1 = 1st order, 2 = 1st & 2nd order",
    )
    rad_int_for_data: bool = pydantic.Field(
        default=False,
        description="Do the radiation integrals need to be computed for",
    )
    rad_int_for_plotting: bool = pydantic.Field(
        default=False,
        description="data or plotting?",
    )
    chrom_for_data: bool = pydantic.Field(
        default=False,
        description="Does the chromaticity need to be computed for",
    )
    chrom_for_plotting: bool = pydantic.Field(
        default=False,
        description="data or plotting?",
    )
    lat_sigma_for_data: bool = pydantic.Field(
        default=False,
        description="Do the beam sigmas need to be computed for",
    )
    lat_sigma_for_plotting: bool = pydantic.Field(
        default=False,
        description="data or plotting?",
    )
    dynamic_aperture: bool = pydantic.Field(
        default=False,
        description="Do the dynamic_aperture calc?",
    )
    one_turn_map: bool = pydantic.Field(
        default=False,
        description="Compute the one turn map?",
    )
    lattice: bool = pydantic.Field(
        default=True,
        description="Used to indicate which lattices need tracking done.",
    )
    twiss: bool = pydantic.Field(
        default=True,
        description="calc linear transfer matrix?",
    )
    track: bool = pydantic.Field(
        default=True,
        description="tracking needs to be done?",
    )
    spin_matrices: bool = pydantic.Field(
        default=False,
        description="Calculate G and D spin matrices?",
    )


class TaoMpiStruct(pydantic.BaseModel):
    """
    TaoMpiStruct corresponds to bmad `tao_mpi_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1037.

    Attributes
    ----------
    on : bool
        Is MPI on?
        Bmad type: logical
        Fortran default: .false.
    master : bool
        Is this the master task? If yes, rank == 0
        Bmad type: logical
        Fortran default: .true.
    rank : int
        Rank of task (rank is 0, 1, 2, ... n_tasks-1 )
        Bmad type: integer
        Fortran default: 0
    max_rank : int
        Maximum rank, should be n_tasks-1
        Bmad type: integer
        Fortran default: 0
    host_name : str
        Name of the host machine
        Bmad type: character
        Fortran default: ''
    """

    on: bool = pydantic.Field(
        default=False,
        description="Is MPI on?",
    )
    master: bool = pydantic.Field(
        default=True,
        description="Is this the master task? If yes, rank == 0",
    )
    rank: int = pydantic.Field(
        default=0,
        description="Rank of task (rank is 0, 1, 2, ... n_tasks-1 )",
    )
    max_rank: int = pydantic.Field(
        default=0,
        description="Maximum rank, should be n_tasks-1",
    )
    host_name: str = pydantic.Field(
        default="",
        max_length=200,
        description="Name of the host machine",
    )


class TaoDynamicApertureStruct(pydantic.BaseModel):
    """
    TaoDynamicApertureStruct corresponds to bmad `tao_dynamic_aperture_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1048.

    Attributes
    ----------
    param : ApertureParamStruct
        Bmad type: type
    scan : ApertureScanStruct
        One scan for each pz.
        Bmad type: type
    pz : float
        Bmad type: real
    ellipse_scale : float
        Bmad type: real
        Fortran default: 1
    a_emit : float
        Bmad type: real
        Fortran default: -1
    b_emit : float
        Bmad type: real
        Fortran default: -1
    """

    param: ApertureParamStruct = pydantic.Field(
        default=None,
    )
    scan: Sequence[ApertureScanStruct] = pydantic.Field(
        default=None,
        description="One scan for each pz.",
    )
    pz: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ellipse_scale: float = pydantic.Field(
        default=1,
    )
    a_emit: float = pydantic.Field(
        default=-1,
    )
    b_emit: float = pydantic.Field(
        default=-1,
    )


class TaoWaveKickPtStruct(pydantic.BaseModel):
    """
    TaoWaveKickPtStruct corresponds to bmad `tao_wave_kick_pt_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1059.

    Attributes
    ----------
    phi_s : float
        Bmad type: real
    phi_r : float
        Bmad type: real
    phi : float
        Bmad type: real
    amp : float
        Bmad type: real
    s : float
        s-position of kick
        Bmad type: real
    ix_dat_before_kick : int
        Index of datum in data array just before the kick.
        Bmad type: integer
    ele : EleStruct
        lattice element at position of kick.
        Bmad type: type
    """

    phi_s: float = pydantic.Field(
        default=0.0,
    )
    phi_r: float = pydantic.Field(
        default=0.0,
    )
    phi: float = pydantic.Field(
        default=0.0,
    )
    amp: float = pydantic.Field(
        default=0.0,
    )
    s: float = pydantic.Field(
        default=0.0,
        description="s-position of kick",
    )
    ix_dat_before_kick: int = pydantic.Field(
        default=0,
        description="Index of datum in data array just before the kick.",
    )
    ele: EleStruct = pydantic.Field(
        default=None,
        description="lattice element at position of kick.",
    )


class TaoWaveStruct(pydantic.BaseModel):
    """
    TaoWaveStruct corresponds to bmad `tao_wave_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1066.

    Attributes
    ----------
    data_type : str
        Bmad type: character
        Fortran default: ''
    rms_rel_a : float
        Bmad type: real
        Fortran default: 0
    rms_rel_b : float
        Bmad type: real
        Fortran default: 0
    rms_rel_as : float
        Bmad type: real
        Fortran default: 0
    rms_rel_bs : float
        Bmad type: real
        Fortran default: 0
    rms_rel_ar : float
        Bmad type: real
        Fortran default: 0
    rms_rel_br : float
        Bmad type: real
        Fortran default: 0
    rms_rel_k : float
        Bmad type: real
        Fortran default: 0
    rms_rel_ks : float
        Bmad type: real
        Fortran default: 0
    rms_rel_kr : float
        Bmad type: real
        Fortran default: 0
    rms_phi : float
        Bmad type: real
        Fortran default: 0
    rms_phi_s : float
        Bmad type: real
        Fortran default: 0
    rms_phi_r : float
        Bmad type: real
        Fortran default: 0
    amp_ba_s : float
        Bmad type: real
        Fortran default: 0
    amp_ba_r : float
        Bmad type: real
        Fortran default: 0
    chi_a : float
        Bmad type: real
        Fortran default: 0
    chi_c : float
        Bmad type: real
        Fortran default: 0
    chi_ba : float
        Bmad type: real
        Fortran default: 0
    amp_a : float
        Bmad type: real
        Fortran default: 0
    amp_b : float
        Bmad type: real
        Fortran default: 0
    amp_ba : float
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
    n_func : int
        Number of functions used in the fit.
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
    n_a : int
        Bmad type: integer
        Fortran default: 0
    n_b : int
        Bmad type: integer
        Fortran default: 0
    i_curve_wrap_pt : int
        Index of last point before wrap in curve array.
        Bmad type: integer
        Fortran default: 0
    ix_data : int
        Translates from plot point to datum index
        Bmad type: integer
    n_kick : int
        Bmad type: integer
        Fortran default: 0
    kick : TaoWaveKickPtStruct
        Bmad type: type
    base_graph : TaoGraphStruct
        Graph before curves extended to 1.5 periods.
        Bmad type: type
    region : TaoPlotRegionStruct
        Where the wave plot is
        Bmad type: type
        Fortran default: null()
    d1_dat : TaoD1DataStruct
        D1 data for analysis
        Bmad type: type
        Fortran default: null()
    """

    data_type: str = pydantic.Field(
        default="",
        max_length=40,
    )
    rms_rel_a: float = pydantic.Field(
        default=0,
    )
    rms_rel_b: float = pydantic.Field(
        default=0,
    )
    rms_rel_as: float = pydantic.Field(
        default=0,
    )
    rms_rel_bs: float = pydantic.Field(
        default=0,
    )
    rms_rel_ar: float = pydantic.Field(
        default=0,
    )
    rms_rel_br: float = pydantic.Field(
        default=0,
    )
    rms_rel_k: float = pydantic.Field(
        default=0,
    )
    rms_rel_ks: float = pydantic.Field(
        default=0,
    )
    rms_rel_kr: float = pydantic.Field(
        default=0,
    )
    rms_phi: float = pydantic.Field(
        default=0,
    )
    rms_phi_s: float = pydantic.Field(
        default=0,
    )
    rms_phi_r: float = pydantic.Field(
        default=0,
    )
    amp_ba_s: float = pydantic.Field(
        default=0,
    )
    amp_ba_r: float = pydantic.Field(
        default=0,
    )
    chi_a: float = pydantic.Field(
        default=0,
    )
    chi_c: float = pydantic.Field(
        default=0,
    )
    chi_ba: float = pydantic.Field(
        default=0,
    )
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
    n_func: int = pydantic.Field(
        default=0,
        description="Number of functions used in the fit.",
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
    n_a: int = pydantic.Field(
        default=0,
    )
    n_b: int = pydantic.Field(
        default=0,
    )
    i_curve_wrap_pt: int = pydantic.Field(
        default=0,
        description="Index of last point before wrap in curve array.",
    )
    ix_data: Sequence[int] = pydantic.Field(
        default=0,
        description="Translates from plot point to datum index",
    )
    n_kick: int = pydantic.Field(
        default=0,
    )
    kick: Sequence[TaoWaveKickPtStruct] = pydantic.Field(
        default=None,
    )
    base_graph: TaoGraphStruct = pydantic.Field(
        default=None,
        description="Graph before curves extended to 1.5 periods.",
    )
    region: TaoPlotRegionStruct = pydantic.Field(
        default=None,
        description="Where the wave plot is",
    )
    d1_dat: TaoD1DataStruct = pydantic.Field(
        default=None,
        description="D1 data for analysis",
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


class TaoUniversePointerStruct(pydantic.BaseModel):
    """
    TaoUniversePointerStruct corresponds to bmad `tao_universe_pointer_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1099.

    Attributes
    ----------
    u : TaoUniverseStruct
        Bmad type: type
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
    model : TaoLatticeStruct
        Bmad type: type
    design : TaoLatticeStruct
        Bmad type: type
    base : TaoLatticeStruct
        Bmad type: type
    beam : TaoBeamUniStruct
        Bmad type: type
    dynamic_aperture : TaoDynamicApertureStruct
        Bmad type: type
    bmad_model_branch : TaoModelBranchStruct
        model specific information
        Bmad type: type
    d2_data : TaoD2DataStruct
        The data types
        Bmad type: type
    data : TaoDataStruct
        Array of all data.
        Bmad type: type
    ping_scale : TaoPingScaleStruct
        Bmad type: type
    scratch_lat : LatStruct
        Scratch area.
        Bmad type: type
    calc : TaoUniverseCalcStruct
        What needs to be calculated?
        Bmad type: type
    ele_order : LatEleOrderStruct
        Order of elements with same name.
        Bmad type: type
    spin_map : TaoSpinMapStruct
        Bmad type: type
    dmodel_dvar : float
        Derivative matrix.
        Bmad type: real
    ix_uni : int
        Universe index.
        Bmad type: integer
        Fortran default: -1
    n_d2_data_used : int
        Number of used %d2_data(:) components.
        Bmad type: integer
        Fortran default: -1
    n_data_used : int
        Number of used %data(:) components.
        Bmad type: integer
        Fortran default: -1
    is_on : bool
        universe turned on
        Bmad type: logical
        Fortran default: .true.
    design_same_as_previous : bool
        Design lat same as the previous uni?
        Bmad type: logical
        Fortran default: .false.
    picked_uni : bool
        Scratch logical.
        Bmad type: logical
        Fortran default: .false.
    """

    model: TaoLatticeStruct = pydantic.Field(
        default=None,
    )
    design: TaoLatticeStruct = pydantic.Field(
        default=None,
    )
    base: TaoLatticeStruct = pydantic.Field(
        default=None,
    )
    beam: TaoBeamUniStruct = pydantic.Field(
        default=None,
    )
    dynamic_aperture: TaoDynamicApertureStruct = pydantic.Field(
        default=None,
    )
    bmad_model_branch: Sequence[TaoModelBranchStruct] = pydantic.Field(
        default=None,
        description="model specific information",
        validation_alias=pydantic.AliasChoices("bmad_model_branch", "model_branch"),
        serialization_alias="model_branch",
    )
    d2_data: Sequence[TaoD2DataStruct] = pydantic.Field(
        default=None,
        description="The data types",
    )
    data: Sequence[TaoDataStruct] = pydantic.Field(
        default=None,
        description="Array of all data.",
    )
    ping_scale: TaoPingScaleStruct = pydantic.Field(
        default=None,
    )
    scratch_lat: LatStruct = pydantic.Field(
        default=None,
        description="Scratch area.",
    )
    calc: TaoUniverseCalcStruct = pydantic.Field(
        default=None,
        description="What needs to be calculated?",
    )
    ele_order: LatEleOrderStruct = pydantic.Field(
        default=None,
        description="Order of elements with same name.",
    )
    spin_map: TaoSpinMapStruct = pydantic.Field(
        default=None,
    )
    dmodel_dvar: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Derivative matrix.",
        validation_alias=pydantic.AliasChoices("dmodel_dvar", "dModel_dVar"),
        serialization_alias="dModel_dVar",
    )
    ix_uni: int = pydantic.Field(
        default=-1,
        description="Universe index.",
    )
    n_d2_data_used: int = pydantic.Field(
        default=-1,
        description="Number of used %d2_data(:) components.",
    )
    n_data_used: int = pydantic.Field(
        default=-1,
        description="Number of used %data(:) components.",
    )
    is_on: bool = pydantic.Field(
        default=True,
        description="universe turned on",
    )
    design_same_as_previous: bool = pydantic.Field(
        default=False,
        description="Design lat same as the previous uni?",
    )
    picked_uni: bool = pydantic.Field(
        default=False,
        description="Scratch logical.",
    )


class TaoSuperUniverseStruct(pydantic.BaseModel):
    """
    TaoSuperUniverseStruct corresponds to bmad `tao_super_universe_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_struct.f90 on line 1131.

    Attributes
    ----------
    global_ : TaoGlobalStruct
        User accessible global variables.
        Bmad type: type
        Fortran default: tao_global_struct()
    init : TaoInitStruct
        Initialization parameters
        Bmad type: type
        Fortran default: tao_init_struct()
    com : TaoCommonStruct
        Non-initialization common parameters
        Bmad type: type
    plot_page : TaoPlotPageStruct
        Defines the plot window.
        Bmad type: type
    v1_var : TaoV1VarStruct
        The variable types
        Bmad type: type
    var : TaoVarStruct
        array of all variables.
        Bmad type: type
    u : TaoUniverseStruct
        array of universes.
        Bmad type: type
    mpi : TaoMpiStruct
        Bmad type: type
        Fortran default: tao_mpi_struct()
    key : int
        Bmad type: integer
    building_wall : TaoBuildingWallStruct
        Bmad type: type
    wave : TaoWaveStruct
        Bmad type: type
    n_var_used : int
        Bmad type: integer
        Fortran default: 0
    n_v1_var_used : int
        Bmad type: integer
        Fortran default: 0
    history : TaoCmdHistoryStruct
        command history
        Bmad type: type
        Fortran default: tao_cmd_history_struct()
    initialized : bool
        Does tao_init() need to be called?
        Bmad type: logical
        Fortran default: .false.
    """

    global_: TaoGlobalStruct = pydantic.Field(
        default=None,
        description="User accessible global variables.",
        validation_alias=pydantic.AliasChoices("global_", "global"),
        serialization_alias="global",
    )
    init: TaoInitStruct = pydantic.Field(
        default=None,
        description="Initialization parameters",
    )
    com: TaoCommonStruct = pydantic.Field(
        default=None,
        description="Non-initialization common parameters",
    )
    plot_page: TaoPlotPageStruct = pydantic.Field(
        default=None,
        description="Defines the plot window.",
    )
    v1_var: Sequence[TaoV1VarStruct] = pydantic.Field(
        default=None,
        description="The variable types",
    )
    var: Sequence[TaoVarStruct] = pydantic.Field(
        default=None,
        description="array of all variables.",
    )
    u: Sequence[TaoUniverseStruct] = pydantic.Field(
        default=None,
        description="array of universes.",
    )
    mpi: TaoMpiStruct = pydantic.Field(
        default=None,
    )
    key: Sequence[int] = pydantic.Field(
        default=0,
    )
    building_wall: TaoBuildingWallStruct = pydantic.Field(
        default=None,
    )
    wave: TaoWaveStruct = pydantic.Field(
        default=None,
    )
    n_var_used: int = pydantic.Field(
        default=0,
    )
    n_v1_var_used: int = pydantic.Field(
        default=0,
    )
    history: Sequence[TaoCmdHistoryStruct] = pydantic.Field(
        default=None,
        max_length=1000,
        description="command history",
    )
    initialized: bool = pydantic.Field(
        default=False,
        description="Does tao_init() need to be called?",
    )


class TaoCInterfaceCommonStruct(pydantic.BaseModel):
    """
    TaoCInterfaceCommonStruct corresponds to bmad `tao_c_interface_common_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_c_interface_mod.f90 on line 16.

    Attributes
    ----------
    c_real : float
        Bmad type: real
    c_integer : int
        Bmad type: integer
    c_line : str
        Bmad type: character
    n_real : int
        Bmad type: integer
        Fortran default: 0
    n_int : int
        Bmad type: integer
        Fortran default: 0
    """

    c_real: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    c_integer: Sequence[int] = pydantic.Field(
        default=0,
    )
    c_line: Sequence[str] = pydantic.Field(
        default="",
    )
    n_real: int = pydantic.Field(
        default=0,
    )
    n_int: int = pydantic.Field(
        default=0,
    )


class TaoTop10Struct(pydantic.BaseModel):
    """
    TaoTop10Struct corresponds to bmad `tao_top10_struct`
    which is in Users/klauer/Repos/bmad/tao/code/tao_top10_mod.f90 on line 9.

    Attributes
    ----------
    name : str
        name of contributor
        Bmad type: character
        Fortran default: ''
    value : float
        contribution to the merit function
        Bmad type: real
        Fortran default: 0
    index : int
        index of contributor.
        Bmad type: integer
        Fortran default: 0
    valid : bool
        valid entry?
        Bmad type: logical
        Fortran default: .false.
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="name of contributor",
    )
    value: float = pydantic.Field(
        default=0,
        description="contribution to the merit function",
    )
    index: int = pydantic.Field(
        default=0,
        description="index of contributor.",
    )
    valid: bool = pydantic.Field(
        default=False,
        description="valid entry?",
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


class TaoDatumInput(pydantic.BaseModel):
    """
    TaoDatumInput corresponds to bmad `tao_datum_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 25.

    Attributes
    ----------
    data_type : str
        long due to expressions.
        Bmad type: character
        Fortran default: ''
    ele_ref_name : str
        Bmad type: character
        Fortran default: ''
    ele_start_name : str
        Bmad type: character
        Fortran default: ''
    ele_name : str
        Bmad type: character
        Fortran default: ''
    merit_type : str
        Bmad type: character
        Fortran default: ''
    meas : float
        used to tag when %meas_value is set in file
        Bmad type: real
        Fortran default: real_garbage$
    weight : float
        Bmad type: real
        Fortran default: real_garbage$
    good_user : bool
        Bmad type: logical
        Fortran default: .true.
    good_opt : bool
        Bmad type: logical
        Fortran default: .true.
    data_source : str
        Bmad type: character
        Fortran default: ''
    eval_point : str
        Bmad type: character
        Fortran default: 'end'
    s_offset : float
        Bmad type: real
        Fortran default: 0
    ix_bunch : int
        Bmad type: integer
        Fortran default: 0
    spin_axis : SpinAxisStruct
        Bmad type: type
        Fortran default: spin_axis_struct()
    invalid_value : float
        Bmad type: real
        Fortran default: 0
    error_rms : float
        Bmad type: real
        Fortran default: 0
    """

    data_type: str = pydantic.Field(
        default="",
        max_length=600,
        description="long due to expressions.",
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ele_start_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=20,
    )
    meas: float = pydantic.Field(
        default=0.0,
        description="used to tag when %meas_value is set in file",
    )
    weight: float = pydantic.Field(
        default=0.0,
    )
    good_user: bool = pydantic.Field(
        default=True,
    )
    good_opt: bool = pydantic.Field(
        default=True,
    )
    data_source: str = pydantic.Field(
        default="",
        max_length=20,
    )
    eval_point: str = pydantic.Field(
        default="end",
        max_length=20,
    )
    s_offset: float = pydantic.Field(
        default=0,
    )
    ix_bunch: int = pydantic.Field(
        default=0,
    )
    spin_axis: SpinAxisStruct = pydantic.Field(
        default=None,
    )
    invalid_value: float = pydantic.Field(
        default=0,
    )
    error_rms: float = pydantic.Field(
        default=0,
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
    ele_name : str
        Bmad type: character
        Fortran default: ''
    attribute : str
        attribute to vary
        Bmad type: character
        Fortran default: ''
    universe : str
        Bmad type: character
        Fortran default: ''
    weight : float
        Bmad type: real
        Fortran default: real_garbage$
    step : float
        Bmad type: real
        Fortran default: 0
    low_lim : float
        Bmad type: real
        Fortran default: -1e30
    high_lim : float
        Bmad type: real
        Fortran default: 1e30
    merit_type : str
        Bmad type: character
        Fortran default: ''
    good_user : bool
        Bmad type: logical
        Fortran default: .true.
    key_bound : bool
        Bmad type: logical
        Fortran default: .false.
    key_delta : float
        Bmad type: real
        Fortran default: 0
    meas : float
        Bmad type: real
        Fortran default: real_garbage$
    """

    ele_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    attribute: str = pydantic.Field(
        default="",
        max_length=40,
        description="attribute to vary",
    )
    universe: str = pydantic.Field(
        default="",
        max_length=16,
    )
    weight: float = pydantic.Field(
        default=0.0,
    )
    step: float = pydantic.Field(
        default=0,
    )
    low_lim: float = pydantic.Field(
        default=-1e30,
    )
    high_lim: float = pydantic.Field(
        default=1e30,
    )
    merit_type: str = pydantic.Field(
        default="",
        max_length=40,
    )
    good_user: bool = pydantic.Field(
        default=True,
        max_length=4,
    )
    key_bound: bool = pydantic.Field(
        default=False,
        max_length=4,
    )
    key_delta: float = pydantic.Field(
        default=0,
    )
    meas: float = pydantic.Field(
        default=0.0,
    )


class TaoRegionInput(pydantic.BaseModel):
    """
    TaoRegionInput corresponds to bmad `tao_region_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 69.

    Attributes
    ----------
    name : str
        Eg: 'top', 'bottom'.
        Bmad type: character
        Fortran default: ''
    location : float
        location on page.
        Bmad type: real
        Fortran default: 0
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
        description="Eg: 'top', 'bottom'.",
    )
    location: Sequence[float] = pydantic.Field(
        default=0,
        max_length=4,
        description="location on page.",
    )


class TaoPlaceInput(pydantic.BaseModel):
    """
    TaoPlaceInput corresponds to bmad `tao_place_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 74.

    Attributes
    ----------
    region : str
        Bmad type: character
        Fortran default: ''
    plot : str
        Bmad type: character
        Fortran default: ''
    """

    region: str = pydantic.Field(
        default="",
        max_length=40,
    )
    plot: str = pydantic.Field(
        default="",
        max_length=40,
    )


class TaoCurveInput(pydantic.BaseModel):
    """
    TaoCurveInput corresponds to bmad `tao_curve_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 79.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    data_source : str
        Bmad type: character
        Fortran default: ''
    data_type_x : str
        Bmad type: character
        Fortran default: ''
    data_type_z : str
        Deprecated. Use c%z_color%...
        Bmad type: character
        Fortran default: ''
    data_type : str
        Bmad type: character
        Fortran default: ''
    data_index : str
        Bmad type: character
        Fortran default: ''
    legend_text : str
        Bmad type: character
        Fortran default: ''
    units : str
        Unused.
        Bmad type: character
        Fortran default: ''
    component : str
        Bmad type: character
        Fortran default: ''
    y_axis_scale_factor : float
        Bmad type: real
        Fortran default: 1
    z_color0 : float
        Deprecated. Use c%z_color%...
        Bmad type: real
        Fortran default: invalid$
    z_color1 : float
        Deprecated. Use c%z_color%...
        Bmad type: real
        Fortran default: invalid$
    symbol_every : int
        Bmad type: integer
        Fortran default: 1
    ix_universe : int
        Bmad type: integer
        Fortran default: -1
    n_turn : int
        Bmad type: integer
        Fortran default: -1
    draw_line : bool
        Bmad type: logical
        Fortran default: .true.
    draw_symbols : bool
        Bmad type: logical
        Fortran default: .true.
    draw_symbol_index : bool
        Bmad type: logical
        Fortran default: .false.
    draw_error_bars : bool
        Bmad type: logical
        Fortran default: .false.
    use_y2 : bool
        Bmad type: logical
        Fortran default: .false.
    use_z_color : bool
        Deprecated. Use c%z_color%...
        Bmad type: logical
        Fortran default: .false.
    autoscale_z_color : bool
        Deprecated. Use c%z_color%...
        Bmad type: logical
        Fortran default: .true.
    smooth_line_calc : bool
        Bmad type: logical
        Fortran default: .true.
    ele_ref_name : str
        Bmad type: character
        Fortran default: ''
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    ix_bunch : int
        Bmad type: integer
        Fortran default: 0
    line : QpLineStruct
        Bmad type: type
        Fortran default: qp_line_struct()
    symbol : QpSymbolStruct
        Bmad type: type
        Fortran default: qp_symbol_struct()
    hist : TaoHistogramStruct
        Bmad type: type
        Fortran default: tao_histogram_struct()
    orbit : TaoCurveOrbitStruct
        Bmad type: type
        Fortran default: tao_curve_orbit_struct()
    z_color : TaoCurveColorStruct
        Bmad type: type
        Fortran default: tao_curve_color_struct()
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    data_source: str = pydantic.Field(
        default="",
        max_length=40,
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
    data_type: str = pydantic.Field(
        default="",
        max_length=200,
    )
    data_index: str = pydantic.Field(
        default="",
        max_length=100,
    )
    legend_text: str = pydantic.Field(
        default="",
        max_length=40,
    )
    units: str = pydantic.Field(
        default="",
        max_length=40,
        description="Unused.",
    )
    component: str = pydantic.Field(
        default="",
        max_length=60,
    )
    y_axis_scale_factor: float = pydantic.Field(
        default=1,
    )
    z_color0: float = pydantic.Field(
        default=0.0,
        description="Deprecated. Use c%z_color%...",
    )
    z_color1: float = pydantic.Field(
        default=0.0,
        description="Deprecated. Use c%z_color%...",
    )
    symbol_every: int = pydantic.Field(
        default=1,
    )
    ix_universe: int = pydantic.Field(
        default=-1,
    )
    n_turn: int = pydantic.Field(
        default=-1,
    )
    draw_line: bool = pydantic.Field(
        default=True,
    )
    draw_symbols: bool = pydantic.Field(
        default=True,
    )
    draw_symbol_index: bool = pydantic.Field(
        default=False,
    )
    draw_error_bars: bool = pydantic.Field(
        default=False,
    )
    use_y2: bool = pydantic.Field(
        default=False,
    )
    use_z_color: bool = pydantic.Field(
        default=False,
        description="Deprecated. Use c%z_color%...",
    )
    autoscale_z_color: bool = pydantic.Field(
        default=True,
        description="Deprecated. Use c%z_color%...",
    )
    smooth_line_calc: bool = pydantic.Field(
        default=True,
    )
    ele_ref_name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    ix_bunch: int = pydantic.Field(
        default=0,
    )
    line: QpLineStruct = pydantic.Field(
        default=None,
    )
    symbol: QpSymbolStruct = pydantic.Field(
        default=None,
    )
    hist: TaoHistogramStruct = pydantic.Field(
        default=None,
    )
    orbit: TaoCurveOrbitStruct = pydantic.Field(
        default=None,
    )
    z_color: TaoCurveColorStruct = pydantic.Field(
        default=None,
    )


class TaoGraphInput(pydantic.BaseModel):
    """
    TaoGraphInput corresponds to bmad `tao_graph_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 112.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    type : str
        Bmad type: character
        Fortran default: 'data'
    title : str
        Bmad type: character
        Fortran default: ''
    component : str
        Bmad type: character
        Fortran default: ''
    text_legend : str
        Bmad type: character
        Fortran default: ''
    floor_plan_view : str
        deprecated. Use g%floor_plan%...
        Bmad type: character
        Fortran default: ''
    floor_plan_orbit_color : str
        deprecated. Use g%floor_plan%...
        Bmad type: character
        Fortran default: ''
    box : int
        Bmad type: integer
        Fortran default: [1, 1, 1, 1]
    ix_universe : int
        Bmad type: integer
        Fortran default: -1
    ix_branch : int
        Bmad type: integer
        Fortran default: 0
    n_curve : int
        Bmad type: integer
        Fortran default: -1
    x_axis_scale_factor : float
        Bmad type: real
        Fortran default: 1
    symbol_size_scale : float
        Bmad type: real
        Fortran default: 0
    floor_plan_rotation : float
        deprecated. Use g%floor_plan%...
        Bmad type: real
        Fortran default: real_garbage$
    floor_plan_orbit_scale : float
        deprecated. Use g%floor_plan%...
        Bmad type: real
        Fortran default: -1
    floor_plan_flip_label_side : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .false.
    floor_plan_size_is_absolute : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .false.
    floor_plan_draw_only_first_pass : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .false.
    correct_xy_distortion : bool
        deprecated. Use g%floor_plan%...
        Bmad type: logical
        Fortran default: .true.
    clip : bool
        Bmad type: logical
        Fortran default: .true.
    draw_title : bool
        Bmad type: logical
        Fortran default: .true.
    draw_axes : bool
        Bmad type: logical
        Fortran default: .true.
    draw_grid : bool
        Bmad type: logical
        Fortran default: .true.
    draw_curve_legend : bool
        Bmad type: logical
        Fortran default: .true.
    draw_only_good_user_data_or_vars : bool
        Bmad type: logical
        Fortran default: .true.
    allow_wrap_around : bool
        Bmad type: logical
        Fortran default: .true.
    floor_plan : TaoFloorPlanStruct
        Bmad type: type
        Fortran default: tao_floor_plan_struct()
    text_legend_origin : QpPointStruct
        Bmad type: type
        Fortran default: qp_point_struct(5.0_rp, 0.0_rp, 'POINTS/GRAPH/RT')
    curve_legend_origin : QpPointStruct
        Bmad type: type
        Fortran default: qp_point_struct(5.0_rp, -2.0_rp, 'POINTS/GRAPH/LT')
    margin : QpRectStruct
        Bmad type: type
        Fortran default: qp_rect_struct(0.0_rp, 0.0_rp, 0.0_rp, 0.0_rp, '%GRAPH')
    scale_margin : QpRectStruct
        Bmad type: type
        Fortran default: qp_rect_struct(0.0_rp, 0.0_rp, 0.0_rp, 0.0_rp, '%GRAPH')
    x : QpAxisStruct
        Bmad type: type
        Fortran default: qp_axis_struct()
    y : QpAxisStruct
        Bmad type: type
        Fortran default: qp_axis_struct()
    x2 : QpAxisStruct
        Bmad type: type
        Fortran default: qp_axis_struct()
    y2 : QpAxisStruct
        Bmad type: type
        Fortran default: qp_axis_struct()
    curve_legend : QpLegendStruct
        Bmad type: type
        Fortran default: qp_legend_struct(1.0_rp, 30.0_rp, 6.0_rp, .true., .true., .true.)
    """

    name: str = pydantic.Field(
        default="",
        max_length=40,
    )
    type: str = pydantic.Field(
        default="data",
        max_length=40,
    )
    title: str = pydantic.Field(
        default="",
        max_length=80,
    )
    component: str = pydantic.Field(
        default="",
        max_length=60,
    )
    text_legend: Sequence[str] = pydantic.Field(
        default="",
        max_length=10,
    )
    floor_plan_view: str = pydantic.Field(
        default="",
        max_length=2,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_orbit_color: str = pydantic.Field(
        default="",
        max_length=16,
        description="deprecated. Use g%floor_plan%...",
    )
    box: Sequence[int] = pydantic.Field(
        default=[1, 1, 1, 1],
        max_length=4,
    )
    ix_universe: int = pydantic.Field(
        default=-1,
    )
    ix_branch: int = pydantic.Field(
        default=0,
    )
    n_curve: int = pydantic.Field(
        default=-1,
    )
    x_axis_scale_factor: float = pydantic.Field(
        default=1,
    )
    symbol_size_scale: float = pydantic.Field(
        default=0,
    )
    floor_plan_rotation: float = pydantic.Field(
        default=0.0,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_orbit_scale: float = pydantic.Field(
        default=-1,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_flip_label_side: bool = pydantic.Field(
        default=False,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_size_is_absolute: bool = pydantic.Field(
        default=False,
        description="deprecated. Use g%floor_plan%...",
    )
    floor_plan_draw_only_first_pass: bool = pydantic.Field(
        default=False,
        description="deprecated. Use g%floor_plan%...",
    )
    correct_xy_distortion: bool = pydantic.Field(
        default=True,
        description="deprecated. Use g%floor_plan%...",
    )
    clip: bool = pydantic.Field(
        default=True,
    )
    draw_title: bool = pydantic.Field(
        default=True,
    )
    draw_axes: bool = pydantic.Field(
        default=True,
    )
    draw_grid: bool = pydantic.Field(
        default=True,
    )
    draw_curve_legend: bool = pydantic.Field(
        default=True,
    )
    draw_only_good_user_data_or_vars: bool = pydantic.Field(
        default=True,
    )
    allow_wrap_around: bool = pydantic.Field(
        default=True,
    )
    floor_plan: TaoFloorPlanStruct = pydantic.Field(
        default=None,
    )
    text_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    curve_legend_origin: QpPointStruct = pydantic.Field(
        default=None,
    )
    margin: QpRectStruct = pydantic.Field(
        default=None,
    )
    scale_margin: QpRectStruct = pydantic.Field(
        default=None,
    )
    x: QpAxisStruct = pydantic.Field(
        default=None,
    )
    y: QpAxisStruct = pydantic.Field(
        default=None,
    )
    x2: QpAxisStruct = pydantic.Field(
        default=None,
    )
    y2: QpAxisStruct = pydantic.Field(
        default=None,
    )
    curve_legend: QpLegendStruct = pydantic.Field(
        default=None,
    )


class TaoPlotInput(pydantic.BaseModel):
    """
    TaoPlotInput corresponds to bmad `tao_plot_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 151.

    Attributes
    ----------
    name : str
        Bmad type: character
    description : str
        Bmad type: character
    x_axis_type : str
        Bmad type: character
    n_graph : int
        Bmad type: integer
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
    n_curve_pts : int
        Bmad type: integer
    x : QpAxisStruct
        Bmad type: type
    """

    name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    description: str = pydantic.Field(
        default_factory=list,
        max_length=60,
    )
    x_axis_type: str = pydantic.Field(
        default_factory=list,
        max_length=16,
    )
    n_graph: int = pydantic.Field(
        default=0,
    )
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
    n_curve_pts: int = pydantic.Field(
        default=0,
    )
    x: QpAxisStruct = pydantic.Field(
        default=None,
    )


class TaoDesignLatInput(pydantic.BaseModel):
    """
    TaoDesignLatInput corresponds to bmad `tao_design_lat_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 167.

    Attributes
    ----------
    file : str
        Bmad type: character
        Fortran default: ''
    file2 : str
        Bmad type: character
        Fortran default: ''
    language : str
        Bmad type: character
        Fortran default: ''
    use_line : str
        Bmad type: character
        Fortran default: ''
    one_turn_map_calc : bool
        Bmad type: logical
        Fortran default: .false.
    dynamic_aperture_calc : bool
        Bmad type: logical
        Fortran default: .false.
    reverse_lattice : bool
        Bmad type: logical
        Fortran default: .false.
    start_branch_at : str
        Bmad type: character
        Fortran default: ''
    slice_lattice : str
        Bmad type: character
        Fortran default: ''
    use_element_range : str
        Bmad type: character
        Fortran default: ''
    """

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
    use_line: str = pydantic.Field(
        default="",
        max_length=40,
    )
    one_turn_map_calc: bool = pydantic.Field(
        default=False,
    )
    dynamic_aperture_calc: bool = pydantic.Field(
        default=False,
    )
    reverse_lattice: bool = pydantic.Field(
        default=False,
    )
    start_branch_at: str = pydantic.Field(
        default="",
        max_length=40,
    )
    slice_lattice: str = pydantic.Field(
        default="",
        max_length=80,
    )
    use_element_range: Sequence[str] = pydantic.Field(
        default="",
        max_length=2,
    )


class TaoKeyInput(pydantic.BaseModel):
    """
    TaoKeyInput corresponds to bmad `tao_key_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 180.

    Attributes
    ----------
    ele_name : str
        Bmad type: character
    attrib_name : str
        Bmad type: character
    delta : float
        Bmad type: real
    universe : str
        Bmad type: character
    small_step : float
        Bmad type: real
    low_lim : float
        Bmad type: real
    high_lim : float
        Bmad type: real
    weight : float
        Bmad type: real
    good_opt : bool
        Bmad type: logical
    merit_type : str
        Bmad type: character
    """

    ele_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    attrib_name: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )
    delta: float = pydantic.Field(
        default=0.0,
    )
    universe: str = pydantic.Field(
        default_factory=list,
        max_length=16,
    )
    small_step: float = pydantic.Field(
        default=0.0,
    )
    low_lim: float = pydantic.Field(
        default=0.0,
    )
    high_lim: float = pydantic.Field(
        default=0.0,
    )
    weight: float = pydantic.Field(
        default=0.0,
    )
    good_opt: bool = pydantic.Field(
        default=False,
    )
    merit_type: str = pydantic.Field(
        default_factory=list,
        max_length=40,
    )


class TaoPlotPageInput(pydantic.BaseModel):
    """
    TaoPlotPageInput corresponds to bmad `tao_plot_page_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 193.

    Attributes
    ----------
    title : TaoTitleStruct
        Title  at top of page.
        Bmad type: type
        Fortran default: tao_title_struct()
    subtitle : TaoTitleStruct
        Subtitle at top of page.
        Bmad type: type
        Fortran default: tao_title_struct()
    border : QpRectStruct
        Border around plots edge of page.
        Bmad type: type
        Fortran default: qp_rect_struct()
    plot_display_type : str
        Bmad type: character
        Fortran default: ''
    size : float
        width and height of window in pixels.
        Bmad type: real
        Fortran default: 0.0
    text_height : float
        In points. Scales the height of all text
        Bmad type: real
        Fortran default: 12
    main_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.3
    graph_title_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.1
    axis_number_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    axis_label_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 1.0
    legend_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    key_table_text_scale : float
        Relative to text_height
        Bmad type: real
        Fortran default: 0.9
    floor_plan_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    floor_plan_text_scale : float
        Scale used = floor_plan_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    lat_layout_shape_scale : float
        Bmad type: real
        Fortran default: 1.0
    lat_layout_text_scale : float
        Scale used = lat_layout_text_scale * legend_text_scale
        Bmad type: real
        Fortran default: 1.0
    curve_legend_line_len : float
        OLD STYLE. Points.
        Bmad type: real
        Fortran default: real_garbage$
    curve_legend_text_offset : float
        OLD STYLE. Points.
        Bmad type: real
        Fortran default: real_garbage$
    n_curve_pts : int
        Number of points for plotting a smooth curve
        Bmad type: integer
        Fortran default: n_curve_pts_init$
    delete_overlapping_plots : bool
        Delete overlapping plots when a plot is placed?
        Bmad type: logical
        Fortran default: .true.
    draw_graph_title_suffix : bool
        Bmad type: logical
        Fortran default: .true.
    """

    title: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Title  at top of page.",
    )
    subtitle: TaoTitleStruct = pydantic.Field(
        default=None,
        description="Subtitle at top of page.",
    )
    border: QpRectStruct = pydantic.Field(
        default=None,
        description="Border around plots edge of page.",
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
    text_height: float = pydantic.Field(
        default=12,
        description="In points. Scales the height of all text",
    )
    main_title_text_scale: float = pydantic.Field(
        default=1.3,
        description="Relative to text_height",
    )
    graph_title_text_scale: float = pydantic.Field(
        default=1.1,
        description="Relative to text_height",
    )
    axis_number_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    axis_label_text_scale: float = pydantic.Field(
        default=1.0,
        description="Relative to text_height",
    )
    legend_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    key_table_text_scale: float = pydantic.Field(
        default=0.9,
        description="Relative to text_height",
    )
    floor_plan_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    floor_plan_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = floor_plan_text_scale * legend_text_scale",
    )
    lat_layout_shape_scale: float = pydantic.Field(
        default=1.0,
    )
    lat_layout_text_scale: float = pydantic.Field(
        default=1.0,
        description="Scale used = lat_layout_text_scale * legend_text_scale",
    )
    curve_legend_line_len: float = pydantic.Field(
        default=0.0,
        description="OLD STYLE. Points.",
    )
    curve_legend_text_offset: float = pydantic.Field(
        default=0.0,
        description="OLD STYLE. Points.",
    )
    n_curve_pts: int = pydantic.Field(
        default=0,
        description="Number of points for plotting a smooth curve",
    )
    delete_overlapping_plots: bool = pydantic.Field(
        default=True,
        description="Delete overlapping plots when a plot is placed?",
    )
    draw_graph_title_suffix: bool = pydantic.Field(
        default=True,
    )


class TaoEleShapeInput(pydantic.BaseModel):
    """
    TaoEleShapeInput corresponds to bmad `tao_ele_shape_input`
    which is in Users/klauer/Repos/bmad/tao/code/tao_input_struct.f90 on line 217.

    Attributes
    ----------
    ele_id : str
        element "key::name" to match to.
        Bmad type: character
        Fortran default: ''
    shape : str
        Shape to draw
        Bmad type: character
        Fortran default: ''
    color : str
        Color of shape
        Bmad type: character
        Fortran default: 'black'
    size : float
        plot vertical height
        Bmad type: real
        Fortran default: 0
    label : str
        Can be: 'name', 's', 'none'
        Bmad type: character
        Fortran default: 'name'
    draw : bool
        Draw the shape?
        Bmad type: logical
        Fortran default: .true.
    multi : bool
        Can be part of a multi-shape.
        Bmad type: logical
        Fortran default: .false.
    line_width : int
        Width of lines used to draw the shape.
        Bmad type: integer
        Fortran default: 1
    offset : float
        Vertical offset.
        Bmad type: real
        Fortran default: 0
    """

    ele_id: str = pydantic.Field(
        default="",
        max_length=60,
        description="element 'key::name' to match to.",
    )
    shape: str = pydantic.Field(
        default="",
        max_length=40,
        description="Shape to draw",
    )
    color: str = pydantic.Field(
        default="black",
        max_length=16,
        description="Color of shape",
    )
    size: float = pydantic.Field(
        default=0,
        description="plot vertical height",
    )
    label: str = pydantic.Field(
        default="name",
        max_length=16,
        description="Can be: 'name', 's', 'none'",
    )
    draw: bool = pydantic.Field(
        default=True,
        description="Draw the shape?",
    )
    multi: bool = pydantic.Field(
        default=False,
        description="Can be part of a multi-shape.",
    )
    line_width: int = pydantic.Field(
        default=1,
        description="Width of lines used to draw the shape.",
    )
    offset: float = pydantic.Field(
        default=0,
        description="Vertical offset.",
    )
