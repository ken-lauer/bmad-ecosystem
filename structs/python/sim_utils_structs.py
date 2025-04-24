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


class CDummyStruct(pydantic.BaseModel):
    """
    CDummyStruct corresponds to bmad `c_dummy_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/misc/fortran_cpp_utils.f90 on line 6.

    Attributes
    ----------
    dummy : float
        Bmad type: real
    """

    dummy: float = pydantic.Field(
        default=0.0,
    )


class PgInterfaceStruct(pydantic.BaseModel):
    """
    PgInterfaceStruct corresponds to bmad `pg_interface_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/pgplot_interface.f90 on line 37.

    Attributes
    ----------
    page_type : str
        Bmad type: character
    plot_file : str
        Bmad type: character
    i_chan : int
        Bmad type: integer
        Fortran default: -1
    qp_to_pg_text_height_factor : float
        Bmad type: real
    page_scale : float
        scaling for entire page
        Bmad type: real
    """

    page_type: str = pydantic.Field(
        default_factory=list,
        max_length=16,
    )
    plot_file: str = pydantic.Field(
        default_factory=list,
        max_length=100,
    )
    i_chan: int = pydantic.Field(
        default=-1,
    )
    qp_to_pg_text_height_factor: float = pydantic.Field(
        default=0.0,
    )
    page_scale: float = pydantic.Field(
        default=0.0,
        description="scaling for entire page",
    )


class QpAxisStruct(pydantic.BaseModel):
    """
    QpAxisStruct corresponds to bmad `qp_axis_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 57.

    Attributes
    ----------
    label : str
        Bmad type: character
        Fortran default: ' '
    min : float
        Axis min/max in data units.
        Bmad type: real
        Fortran default: 0
    max : float
        Axis min/max in data units.
        Bmad type: real
        Fortran default: 10
    tick_min : float
        Min tick location along axis in data units.
        Bmad type: real
        Fortran default: 0
    tick_max : float
        Max tick location along axis in data units.
        Bmad type: real
        Fortran default: 10
    eval_min : float
        For general use. Not set by quick_plot.
        Bmad type: real
        Fortran default: 0
    eval_max : float
        For general use. Not set by quick_plot.
        Bmad type: real
        Fortran default: 0
    dtick : float
        Distance between ticks. In data units. Ticks will be drawn between %min and
        %max.
        Bmad type: real
        Fortran default: 2
    number_offset : float
        Offset from axis line in inches.
        Bmad type: real
        Fortran default: 0.05
    label_offset : float
        Offset from numbers in inches.
        Bmad type: real
        Fortran default: 0.05
    major_tick_len : float
        In inches.
        Bmad type: real
        Fortran default: 0.10
    minor_tick_len : float
        In inches.
        Bmad type: real
        Fortran default: 0.06
    label_color : str
        Color of the label.
        Bmad type: character
        Fortran default: 'black'
    major_div : int
        Actual numbrer of major divisions
        Bmad type: integer
        Fortran default: 5
    major_div_nominal : int
        Nominal value.
        Bmad type: integer
        Fortran default: 5
    minor_div : int
        0 = auto choose.
        Bmad type: integer
        Fortran default: 0
    minor_div_max : int
        Max number for auto choose.
        Bmad type: integer
        Fortran default: 5
    places : int
        Number of places after the decimal point to print.
        Bmad type: integer
        Fortran default: 0
    type : str
        Or 'LOG', or 'CUSTOM'
        Bmad type: character
        Fortran default: 'LINEAR'
    bounds : str
        Or 'ZERO_AT_END' or 'ZERO_SYMMETRIC'
        Bmad type: character
        Fortran default: 'GENERAL'
    tick_side : int
        +1 = Draw on the side inside the graph, 0 = both (longer tick), -1 = outside.
        Bmad type: integer
        Fortran default: +1
    number_side : int
        +1 = Draw to the side inside the graph, -1 = outside.
        Bmad type: integer
        Fortran default: -1
    draw_label : bool
        Bmad type: logical
        Fortran default: .true.
    draw_numbers : bool
        Bmad type: logical
        Fortran default: .true.
    """

    label: str = pydantic.Field(
        default=" ",
        max_length=80,
    )
    min: float = pydantic.Field(
        default=0,
        description="Axis min/max in data units.",
    )
    max: float = pydantic.Field(
        default=10,
        description="Axis min/max in data units.",
    )
    tick_min: float = pydantic.Field(
        default=0,
        description="Min tick location along axis in data units.",
    )
    tick_max: float = pydantic.Field(
        default=10,
        description="Max tick location along axis in data units.",
    )
    eval_min: float = pydantic.Field(
        default=0,
        description="For general use. Not set by quick_plot.",
    )
    eval_max: float = pydantic.Field(
        default=0,
        description="For general use. Not set by quick_plot.",
    )
    dtick: float = pydantic.Field(
        default=2,
        description=(
            "Distance between ticks. In data units. Ticks will be drawn between %min "
            "and %max."
        ),
    )
    number_offset: float = pydantic.Field(
        default=0.05,
        description="Offset from axis line in inches.",
    )
    label_offset: float = pydantic.Field(
        default=0.05,
        description="Offset from numbers in inches.",
    )
    major_tick_len: float = pydantic.Field(
        default=0.1,
        description="In inches.",
    )
    minor_tick_len: float = pydantic.Field(
        default=0.06,
        description="In inches.",
    )
    label_color: str = pydantic.Field(
        default="black",
        max_length=16,
        description="Color of the label.",
    )
    major_div: int = pydantic.Field(
        default=5,
        description="Actual numbrer of major divisions",
    )
    major_div_nominal: int = pydantic.Field(
        default=5,
        description="Nominal value.",
    )
    minor_div: int = pydantic.Field(
        default=0,
        description="0 = auto choose.",
    )
    minor_div_max: int = pydantic.Field(
        default=5,
        description="Max number for auto choose.",
    )
    places: int = pydantic.Field(
        default=0,
        description="Number of places after the decimal point to print.",
    )
    type: str = pydantic.Field(
        default="LINEAR",
        max_length=16,
        description="Or 'LOG', or 'CUSTOM'",
    )
    bounds: str = pydantic.Field(
        default="GENERAL",
        max_length=16,
        description="Or 'ZERO_AT_END' or 'ZERO_SYMMETRIC'",
    )
    tick_side: int = pydantic.Field(
        default=1,
        description="+1 = Draw on the side inside the graph, 0 = both (longer tick), -1 = outside.",
    )
    number_side: int = pydantic.Field(
        default=-1,
        description="+1 = Draw to the side inside the graph, -1 = outside.",
    )
    draw_label: bool = pydantic.Field(
        default=True,
    )
    draw_numbers: bool = pydantic.Field(
        default=True,
    )


class QpPlotStruct(pydantic.BaseModel):
    """
    QpPlotStruct corresponds to bmad `qp_plot_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 85.

    Attributes
    ----------
    title : str
        Bmad type: character
        Fortran default: ' '
    x : QpAxisStruct
        Bmad type: type
    y : QpAxisStruct
        Bmad type: type
    x2 : QpAxisStruct
        Bmad type: type
    y2 : QpAxisStruct
        Bmad type: type
    xx : QpAxisStruct
        Pointer to x or x2 active axes currently used for plotting.
        Bmad type: type
    yy : QpAxisStruct
        Pointer to y or y2 active axes currently used for plotting.
        Bmad type: type
    draw_box : bool
        Bmad type: logical
        Fortran default: .true.
    draw_title : bool
        Bmad type: logical
        Fortran default: .true.
    draw_grid : bool
        Bmad type: logical
        Fortran default: .true.
    x2_mirrors_x : bool
        x2 axis same as x?
        Bmad type: logical
        Fortran default: .true.
    y2_mirrors_y : bool
        y2 axis same as y?
        Bmad type: logical
        Fortran default: .true.
    x_is_active_axis : bool
        True => x is the active axis. False => x2 is active.
        Bmad type: logical
    y_is_active_axis : bool
        True => y is the active axis. False => y2 is active.
        Bmad type: logical
    """

    title: str = pydantic.Field(
        default=" ",
        max_length=80,
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
    xx: QpAxisStruct = pydantic.Field(
        default=None,
        description="Pointer to x or x2 active axes currently used for plotting.",
    )
    yy: QpAxisStruct = pydantic.Field(
        default=None,
        description="Pointer to y or y2 active axes currently used for plotting.",
    )
    draw_box: bool = pydantic.Field(
        default=True,
    )
    draw_title: bool = pydantic.Field(
        default=True,
    )
    draw_grid: bool = pydantic.Field(
        default=True,
    )
    x2_mirrors_x: bool = pydantic.Field(
        default=True,
        description="x2 axis same as x?",
    )
    y2_mirrors_y: bool = pydantic.Field(
        default=True,
        description="y2 axis same as y?",
    )
    x_is_active_axis: bool = pydantic.Field(
        default=False,
        description="True => x is the active axis. False => x2 is active.",
    )
    y_is_active_axis: bool = pydantic.Field(
        default=False,
        description="True => y is the active axis. False => y2 is active.",
    )


class QpPointStruct(pydantic.BaseModel):
    """
    QpPointStruct corresponds to bmad `qp_point_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 99.

    Attributes
    ----------
    x : float
        Bmad type: real
        Fortran default: 0
    y : float
        Bmad type: real
        Fortran default: 0
    units : str
        Bmad type: character
        Fortran default: ' '
    """

    x: float = pydantic.Field(
        default=0,
    )
    y: float = pydantic.Field(
        default=0,
    )
    units: str = pydantic.Field(
        default=" ",
        max_length=16,
    )


class QpRectStruct(pydantic.BaseModel):
    """
    QpRectStruct corresponds to bmad `qp_rect_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 104.

    Attributes
    ----------
    x1 : float
        Bmad type: real
        Fortran default: 0
    x2 : float
        Bmad type: real
        Fortran default: 0
    y1 : float
        Bmad type: real
        Fortran default: 0
    y2 : float
        Bmad type: real
        Fortran default: 0
    units : str
        Bmad type: character
        Fortran default: ' '
    """

    x1: float = pydantic.Field(
        default=0,
    )
    x2: float = pydantic.Field(
        default=0,
    )
    y1: float = pydantic.Field(
        default=0,
    )
    y2: float = pydantic.Field(
        default=0,
    )
    units: str = pydantic.Field(
        default=" ",
        max_length=16,
    )


class QpTextStruct(pydantic.BaseModel):
    """
    QpTextStruct corresponds to bmad `qp_text_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 109.

    Attributes
    ----------
    height : float
        in points
        Bmad type: real
        Fortran default: 12
    color : str
        Bmad type: character
        Fortran default: 'black'
    uniform_spacing : bool
        Bmad type: logical
        Fortran default: .false.
    """

    height: float = pydantic.Field(
        default=12,
        description="in points",
    )
    color: str = pydantic.Field(
        default="black",
        max_length=16,
    )
    uniform_spacing: bool = pydantic.Field(
        default=False,
    )


class QpLineStruct(pydantic.BaseModel):
    """
    QpLineStruct corresponds to bmad `qp_line_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 115.

    Attributes
    ----------
    width : int
        Bmad type: integer
        Fortran default: 3
    color : str
        Bmad type: character
        Fortran default: 'black'
    pattern : str
        Bmad type: character
        Fortran default: 'solid'
    """

    width: int = pydantic.Field(
        default=3,
    )
    color: str = pydantic.Field(
        default="black",
        max_length=16,
    )
    pattern: str = pydantic.Field(
        default="solid",
        max_length=16,
    )


class QpSymbolStruct(pydantic.BaseModel):
    """
    QpSymbolStruct corresponds to bmad `qp_symbol_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 121.

    Attributes
    ----------
    type : str
        Bmad type: character
        Fortran default: 'circle_dot'
    height : float
        in points (same as text height)
        Bmad type: real
        Fortran default: 10d0
    color : str
        Bmad type: character
        Fortran default: 'black'
    fill_pattern : str
        Bmad type: character
        Fortran default: 'solid_fill'
    line_width : int
        Bmad type: integer
        Fortran default: 3
    """

    type: str = pydantic.Field(
        default="circle_dot",
        max_length=16,
    )
    height: float = pydantic.Field(
        default=10.0,
        description="in points (same as text height)",
    )
    color: str = pydantic.Field(
        default="black",
        max_length=16,
    )
    fill_pattern: str = pydantic.Field(
        default="solid_fill",
        max_length=16,
    )
    line_width: int = pydantic.Field(
        default=3,
    )


class QpArrowStruct(pydantic.BaseModel):
    """
    QpArrowStruct corresponds to bmad `qp_arrow_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 129.

    Attributes
    ----------
    head_angle : float
        Acute angle of the arrow point in degrees.
        Bmad type: real
        Fortran default: 30
    head_barb : float
        Fraction of triangular arrow head that is cut away from the back.
        Bmad type: real
        Fortran default: 0.4
    head_size : float
        Bmad type: real
        Fortran default: 1.0
    head_type : str
        Or 'outline_arrow_head'
        Bmad type: character
        Fortran default: 'filled_arrow_head'
    color : str
        Bmad type: character
        Fortran default: 'black'
    """

    head_angle: float = pydantic.Field(
        default=30,
        description="Acute angle of the arrow point in degrees.",
    )
    head_barb: float = pydantic.Field(
        default=0.4,
        description="Fraction of triangular arrow head that is cut away from the back.",
    )
    head_size: float = pydantic.Field(
        default=1.0,
    )
    head_type: str = pydantic.Field(
        default="filled_arrow_head",
        max_length=16,
        description="Or 'outline_arrow_head'",
    )
    color: str = pydantic.Field(
        default="black",
        max_length=16,
    )


class QpLegendStruct(pydantic.BaseModel):
    """
    QpLegendStruct corresponds to bmad `qp_legend_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 137.

    Attributes
    ----------
    row_spacing : float
        Spacing between rows.
        Bmad type: real
        Fortran default: 1.0
    line_length : float
        Length of the line in points.
        Bmad type: real
        Fortran default: 72
    text_offset : float
        Horizontal offset in points between the line and the text.
        Bmad type: real
        Fortran default: 10
    draw_line : bool
        Draw lines?
        Bmad type: logical
        Fortran default: .true.
    draw_symbol : bool
        Draw symbols?
        Bmad type: logical
        Fortran default: .true.
    draw_text : bool
        Draw text?
        Bmad type: logical
        Fortran default: .true.
    """

    row_spacing: float = pydantic.Field(
        default=1.0,
        description="Spacing between rows.",
    )
    line_length: float = pydantic.Field(
        default=72,
        description="Length of the line in points.",
    )
    text_offset: float = pydantic.Field(
        default=10,
        description="Horizontal offset in points between the line and the text.",
    )
    draw_line: bool = pydantic.Field(
        default=True,
        description="Draw lines?",
    )
    draw_symbol: bool = pydantic.Field(
        default=True,
        description="Draw symbols?",
    )
    draw_text: bool = pydantic.Field(
        default=True,
        description="Draw text?",
    )


class QpStateStruct(pydantic.BaseModel):
    """
    QpStateStruct corresponds to bmad `qp_state_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/plot/quick_plot_struct.f90 on line 146.

    Attributes
    ----------
    plot : QpPlotStruct
        Bmad type: type
    page : QpRectStruct
        Bmad type: type
        Fortran default: qp_rect_struct (0.0, 0.0, 0.0, 0.0, ' ')
    box : QpRectStruct
        Bmad type: type
        Fortran default: qp_rect_struct (1.0, 2.0, 1.0, 2.0, ' ')
    graph : QpRectStruct
        Bmad type: type
        Fortran default: qp_rect_struct (1.0, 2.0, 1.0, 2.0, ' ')
    margin : QpRectStruct
        Bmad type: type
        Fortran default: qp_rect_struct (0.0, 0.0, 0.0, 0.0, ' ')
    border : QpRectStruct
        Bmad type: type
        Fortran default: qp_rect_struct (0.0, 0.0, 0.0, 0.0, ' ')
    main_title : QpTextStruct
        Bmad type: type
        Fortran default: qp_text_struct(18.0, 'black', .false.)
    graph_title : QpTextStruct
        Bmad type: type
        Fortran default: qp_text_struct(20.0, 'black', .false.)
    legend : QpTextStruct
        Bmad type: type
        Fortran default: qp_text_struct(13.0, 'black', .false.)
    text : QpTextStruct
        Bmad type: type
        Fortran default: qp_text_struct(18.0, 'black', .false.)
    axis_number : QpTextStruct
        Bmad type: type
        Fortran default: qp_text_struct(12.0, 'black', .false.)
    axis_label : QpTextStruct
        Bmad type: type
        Fortran default: qp_text_struct(15.0, 'black', .false.)
    this_text : QpTextStruct
        current settings.
        Bmad type: type
    symbol : QpSymbolStruct
        Bmad type: type
        Fortran default: qp_symbol_struct()
    arrow : QpArrowStruct
        Bmad type: type
        Fortran default: qp_arrow_struct()
    std_line : QpLineStruct
        Bmad type: type
        Fortran default: qp_line_struct()
    plot_line : QpLineStruct
        Bmad type: type
        Fortran default: qp_line_struct()
    axis_line : QpLineStruct
        Bmad type: type
        Fortran default: qp_line_struct()
    legend_line : QpLineStruct
        Bmad type: type
        Fortran default: qp_line_struct()
    grid_line : QpLineStruct
        Bmad type: type
        Fortran default: qp_line_struct(1, 'light_grey', 'solid')
    text_scale : float
        Bmad type: real
        Fortran default: 1
    text_spacing_factor : float
        Bmad type: real
        Fortran default: 0.6
    dflt_axis_slop_factor : float
        Bmad type: real
        Fortran default: 1d-3
    text_background : str
        Bmad type: character
        Fortran default: 'not_set'
    max_axis_zero_digits : int
        Bmad type: integer
        Fortran default: 3
    dflt_units : int
        Bmad type: integer
        Fortran default: dflt_draw$
    max_digits : int
        Bmad type: integer
        Fortran default: 8
    plot_file : str
        Bmad type: character
    page_type : str
        'PS', 'X', etc.
        Bmad type: character
    dflt_draw_units : str
        Bmad type: character
        Fortran default: ['DATA ', 'GRAPH', 'LB   ' ]
    dflt_set_units : str
        Bmad type: character
        Fortran default: ['INCH ', 'PAGE ', 'LB   ' ]
    subgraph_on : bool
        Bmad type: logical
        Fortran default: .false.
    clip : bool
        Bmad type: logical
        Fortran default: .false.
    buffer : bool
        to be used by qp_save_state only
        Bmad type: logical
        Fortran default: .false.
    uniform_symbol_size : bool
        Bmad type: logical
        Fortran default: .true.
    """

    plot: QpPlotStruct = pydantic.Field(
        default=None,
    )
    page: QpRectStruct = pydantic.Field(
        default=None,
    )
    box: QpRectStruct = pydantic.Field(
        default=None,
    )
    graph: QpRectStruct = pydantic.Field(
        default=None,
    )
    margin: QpRectStruct = pydantic.Field(
        default=None,
    )
    border: QpRectStruct = pydantic.Field(
        default=None,
    )
    main_title: QpTextStruct = pydantic.Field(
        default=None,
    )
    graph_title: QpTextStruct = pydantic.Field(
        default=None,
    )
    legend: QpTextStruct = pydantic.Field(
        default=None,
    )
    text: QpTextStruct = pydantic.Field(
        default=None,
    )
    axis_number: QpTextStruct = pydantic.Field(
        default=None,
    )
    axis_label: QpTextStruct = pydantic.Field(
        default=None,
    )
    this_text: QpTextStruct = pydantic.Field(
        default=None,
        description="current settings.",
    )
    symbol: QpSymbolStruct = pydantic.Field(
        default=None,
    )
    arrow: QpArrowStruct = pydantic.Field(
        default=None,
    )
    std_line: QpLineStruct = pydantic.Field(
        default=None,
    )
    plot_line: QpLineStruct = pydantic.Field(
        default=None,
    )
    axis_line: QpLineStruct = pydantic.Field(
        default=None,
    )
    legend_line: QpLineStruct = pydantic.Field(
        default=None,
    )
    grid_line: QpLineStruct = pydantic.Field(
        default=None,
    )
    text_scale: float = pydantic.Field(
        default=1,
    )
    text_spacing_factor: float = pydantic.Field(
        default=0.6,
    )
    dflt_axis_slop_factor: float = pydantic.Field(
        default=0.001,
    )
    text_background: str = pydantic.Field(
        default="not_set",
        max_length=16,
    )
    max_axis_zero_digits: int = pydantic.Field(
        default=3,
    )
    dflt_units: int = pydantic.Field(
        default=0,
    )
    max_digits: int = pydantic.Field(
        default=8,
    )
    plot_file: str = pydantic.Field(
        default_factory=list,
        max_length=200,
    )
    page_type: str = pydantic.Field(
        default_factory=list,
        max_length=16,
        description="'PS', 'X', etc.",
    )
    dflt_draw_units: Sequence[str] = pydantic.Field(
        default=["DATA ", "GRAPH", "LB   "],
        max_length=3,
    )
    dflt_set_units: Sequence[str] = pydantic.Field(
        default=["INCH ", "PAGE ", "LB   "],
        max_length=3,
    )
    subgraph_on: bool = pydantic.Field(
        default=False,
    )
    clip: bool = pydantic.Field(
        default=False,
    )
    buffer: bool = pydantic.Field(
        default=False,
        description="to be used by qp_save_state only",
    )
    uniform_symbol_size: bool = pydantic.Field(
        default=True,
    )


class TempStruct(pydantic.BaseModel):
    """
    TempStruct corresponds to bmad `temp_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/file/object_model_mod.f90 on line 60.

    Attributes
    ----------
    str_ : str
        Bmad type: character
        Fortran default: ''
    """

    str_: str = pydantic.Field(
        default="",
        max_length=40,
        validation_alias=pydantic.AliasChoices("str_", "str"),
        serialization_alias="str",
    )


class ObjectStruct(pydantic.BaseModel):
    """
    ObjectStruct corresponds to bmad `object_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/file/object_model_mod.f90 on line 64.

    Attributes
    ----------
    name : str
        Bmad type: character
    parent : ObjectStruct
        Bmad type: type
        Fortran default: null()
    token : VarLengthStringStruct
        Array of tokens
        Bmad type: type
    child : ObjectStruct
        Array of subobjects
        Bmad type: type
        Fortran default: null()
    n_child : int
        Number of subobjects.
        Bmad type: integer
        Fortran default: 0
    n_token : int
        Number of tokens.
        Bmad type: integer
        Fortran default: 0
    """

    name: str = pydantic.Field(
        default="",
    )
    parent: ObjectStruct = pydantic.Field(
        default=None,
    )
    token: Sequence[VarLengthStringStruct] = pydantic.Field(
        default=None,
        description="Array of tokens",
    )
    child: Sequence[ObjectStruct] = pydantic.Field(
        default=None,
        description="Array of subobjects",
    )
    n_child: int = pydantic.Field(
        default=0,
        description="Number of subobjects.",
    )
    n_token: int = pydantic.Field(
        default=0,
        description="Number of tokens.",
    )


class OutIoOutputDirectStruct(pydantic.BaseModel):
    """
    OutIoOutputDirectStruct corresponds to bmad `out_io_output_direct_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/io/output_mod.f90 on line 28.

    Attributes
    ----------
    print_and_capture : bool
        Bmad type: logical
        Fortran default: .true.
    file_unit : int
        Bmad type: integer
        Fortran default: -1
    """

    print_and_capture: Sequence[bool] = pydantic.Field(
        default=True,
    )
    file_unit: Sequence[int] = pydantic.Field(
        default=-1,
    )


class OutIoModComStruct(pydantic.BaseModel):
    """
    OutIoModComStruct corresponds to bmad `out_io_mod_com_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/io/output_mod.f90 on line 33.

    Attributes
    ----------
    indent_num : int
        Bmad type: integer
        Fortran default: [0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
    print_on : bool
        Bmad type: logical
        Fortran default: .true.
    capture_lines_null_terminated : bool
        Bmad type: logical
        Fortran default: .true.
    n_buffer_lines : int
        Bmad type: integer
        Fortran default: 0
    buffer : str
        Bmad type: character
    capture_state : str
        See out_io_print_and_capture_setup
        Bmad type: character
        Fortran default: 'OFF'
    """

    indent_num: Sequence[int] = pydantic.Field(
        default=[0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    )
    print_on: bool = pydantic.Field(
        default=True,
    )
    capture_lines_null_terminated: bool = pydantic.Field(
        default=True,
    )
    n_buffer_lines: int = pydantic.Field(
        default=0,
    )
    buffer: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=300,
    )
    capture_state: str = pydantic.Field(
        default="OFF",
        max_length=16,
        description="See out_io_print_and_capture_setup",
    )


class WlsStruct(pydantic.BaseModel):
    """
    WlsStruct corresponds to bmad `wls_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/windowLS.f90 on line 39.

    Attributes
    ----------
    r1 : float
        Bmad type: REAL
    q1 : float
        Bmad type: REAL
    n : int
        number of data points to fit to
        Bmad type: INTEGER
    order : int
        order of fit polynomial
        Bmad type: INTEGER
    der : int
        order of derivative to be returned by fixedWindowLS
        Bmad type: INTEGER
    xend : float
        Bmad type: REAL
    y : float
        holds data
        Bmad type: REAL
    """

    r1: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("r1", "R1"),
        serialization_alias="R1",
    )
    q1: Sequence[float] = pydantic.Field(
        default=0.0,
        validation_alias=pydantic.AliasChoices("q1", "Q1"),
        serialization_alias="Q1",
    )
    n: int = pydantic.Field(
        default=0,
        description="number of data points to fit to",
        validation_alias=pydantic.AliasChoices("n", "N"),
        serialization_alias="N",
    )
    order: int = pydantic.Field(
        default=0,
        description="order of fit polynomial",
    )
    der: int = pydantic.Field(
        default=0,
        description="order of derivative to be returned by fixedWindowLS",
    )
    xend: float = pydantic.Field(
        default=0.0,
    )
    y: Sequence[float] = pydantic.Field(
        default=0.0,
        description="holds data",
    )


class SuperMrqminStorageStruct(pydantic.BaseModel):
    """
    SuperMrqminStorageStruct corresponds to bmad `super_mrqmin_storage_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/super_recipes_mod.f90 on line 13.

    Attributes
    ----------
    covar : float
        Covariance matrix. See mrqmin in NR for more details.
        Bmad type: real
    alpha : float
        Curvature matrix. See mrqmin in NR for more details.
        Bmad type: real
    atry : float
        Bmad type: real
    beta : float
        Bmad type: real
    da : float
        Bmad type: real
    ochisq : float
        Bmad type: real
    mask : bool
        Bmad type: logical
    dyda : float
        Bmad type: real
    old_dy : float
        Bmad type: real
    dy : float
        Bmad type: real
    wt : float
        Bmad type: real
    ymod : float
        Bmad type: real
    """

    covar: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Covariance matrix. See mrqmin in NR for more details.",
    )
    alpha: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Curvature matrix. See mrqmin in NR for more details.",
    )
    atry: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    beta: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    da: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ochisq: float = pydantic.Field(
        default=0.0,
    )
    mask: Sequence[bool] = pydantic.Field(
        default=False,
    )
    dyda: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    old_dy: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    dy: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    wt: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    ymod: Sequence[float] = pydantic.Field(
        default=0.0,
    )


class RandomStateStruct(pydantic.BaseModel):
    """
    RandomStateStruct corresponds to bmad `random_state_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/random_mod.f90 on line 28.

    Attributes
    ----------
    ix : int
        Bmad type: integer
        Fortran default: -1
    iy : int
        Bmad type: integer
        Fortran default: -1
    number_stored : bool
        Bmad type: logical
        Fortran default: .false.
    h_saved : float
        Bmad type: real
        Fortran default: 0
    engine : int
        Bmad type: integer
        Fortran default: pseudo_random$
    seed : int
        Bmad type: integer
        Fortran default: 0
    am : float
        Bmad type: real
        Fortran default: 0
    gauss_converter : int
        Bmad type: integer
        Fortran default: exact_gaussian$
    gauss_sigma_cut : float
        Only used if positive.
        Bmad type: real
        Fortran default: -1
    in_sobseq : int
        Bmad type: integer
        Fortran default: 0
    ix_sobseq : int
        Bmad type: integer
        Fortran default: 0
    x_sobseq : float
        Bmad type: real
        Fortran default: 0
    """

    ix: int = pydantic.Field(
        default=-1,
    )
    iy: int = pydantic.Field(
        default=-1,
    )
    number_stored: bool = pydantic.Field(
        default=False,
    )
    h_saved: float = pydantic.Field(
        default=0,
    )
    engine: int = pydantic.Field(
        default=0,
    )
    seed: int = pydantic.Field(
        default=0,
    )
    am: float = pydantic.Field(
        default=0,
    )
    gauss_converter: int = pydantic.Field(
        default=0,
    )
    gauss_sigma_cut: float = pydantic.Field(
        default=-1,
        description="Only used if positive.",
    )
    in_sobseq: int = pydantic.Field(
        default=0,
    )
    ix_sobseq: Sequence[int] = pydantic.Field(
        default=0,
    )
    x_sobseq: Sequence[float] = pydantic.Field(
        default=0,
    )


class Field1At2dPtStruct(pydantic.BaseModel):
    """
    Field1At2dPtStruct corresponds to bmad `field1_at_2D_pt_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 28.

    Attributes
    ----------
    f : float
        Field
        Bmad type: real
    df_dx : float
        Normalized field 1st derivatives
        Bmad type: real
    df_dy : float
        Normalized field 1st derivatives
        Bmad type: real
    d2f_dxdy : float
        Normalized field 2nd derivative
        Bmad type: real
    """

    f: float = pydantic.Field(
        default=0.0,
        description="Field",
    )
    df_dx: float = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    df_dy: float = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    d2f_dxdy: float = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivative",
    )


class FieldAt2dBoxStruct(pydantic.BaseModel):
    """
    FieldAt2dBoxStruct corresponds to bmad `field_at_2D_box_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 36.

    Attributes
    ----------
    pt : Field1At2dPtStruct
        Bmad type: type
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    pt: Sequence[Field1At2dPtStruct] = pydantic.Field(
        default=None,
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
        description="index at lower box corner.",
    )


class BicubicCoefStruct(pydantic.BaseModel):
    """
    BicubicCoefStruct corresponds to bmad `bicubic_coef_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 43.

    Attributes
    ----------
    coef : float
        Coefs
        Bmad type: real
        Fortran default: 0
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Coefs",
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
        description="index at lower box corner.",
    )


class CmplxField1At2dPtStruct(pydantic.BaseModel):
    """
    CmplxField1At2dPtStruct corresponds to bmad `cmplx_field1_at_2D_pt_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 55.

    Attributes
    ----------
    f : Complex
        Field
        Bmad type: complex
    df_dx : Complex
        Normalized field 1st derivatives
        Bmad type: complex
    df_dy : Complex
        Normalized field 1st derivatives
        Bmad type: complex
    d2f_dxdy : Complex
        Normalized field 2nd derivative
        Bmad type: complex
    """

    f: Complex = pydantic.Field(
        default=0.0,
        description="Field",
    )
    df_dx: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    df_dy: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    d2f_dxdy: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivative",
    )


class CmplxFieldAt2dBoxStruct(pydantic.BaseModel):
    """
    CmplxFieldAt2dBoxStruct corresponds to bmad `cmplx_field_at_2D_box_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 63.

    Attributes
    ----------
    pt : CmplxField1At2dPtStruct
        Bmad type: type
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    pt: Sequence[CmplxField1At2dPtStruct] = pydantic.Field(
        default=None,
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
        description="index at lower box corner.",
    )


class BicubicCmplxCoefStruct(pydantic.BaseModel):
    """
    BicubicCmplxCoefStruct corresponds to bmad `bicubic_cmplx_coef_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 70.

    Attributes
    ----------
    coef : Complex
        Coefs
        Bmad type: complex
        Fortran default: 0
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    coef: Sequence[Complex] = pydantic.Field(
        default=0,
        description="Coefs",
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=2,
        description="index at lower box corner.",
    )


class Field1At3dPtStruct(pydantic.BaseModel):
    """
    Field1At3dPtStruct corresponds to bmad `field1_at_3D_pt_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 82.

    Attributes
    ----------
    f : float
        Field
        Bmad type: real
    df_dx : float
        Normalized field 1st derivatives
        Bmad type: real
    df_dy : float
        Normalized field 1st derivatives
        Bmad type: real
    df_dz : float
        Normalized field 1st derivatives
        Bmad type: real
    d2f_dxdy : float
        Normalized field 2nd derivatives
        Bmad type: real
    d2f_dxdz : float
        Normalized field 2nd derivatives
        Bmad type: real
    d2f_dydz : float
        Normalized field 2nd derivatives
        Bmad type: real
    d3f_dxdydz : float
        Normalized field 3rd derivative
        Bmad type: real
    """

    f: float = pydantic.Field(
        default=0.0,
        description="Field",
    )
    df_dx: float = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    df_dy: float = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    df_dz: float = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    d2f_dxdy: float = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivatives",
    )
    d2f_dxdz: float = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivatives",
    )
    d2f_dydz: float = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivatives",
    )
    d3f_dxdydz: float = pydantic.Field(
        default=0.0,
        description="Normalized field 3rd derivative",
    )


class FieldAt3dBoxStruct(pydantic.BaseModel):
    """
    FieldAt3dBoxStruct corresponds to bmad `field_at_3D_box_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 91.

    Attributes
    ----------
    pt : Field1At3dPtStruct
        Bmad type: type
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    pt: Sequence[Field1At3dPtStruct] = pydantic.Field(
        default=None,
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        description="index at lower box corner.",
    )


class TricubicCoefStruct(pydantic.BaseModel):
    """
    TricubicCoefStruct corresponds to bmad `tricubic_coef_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 98.

    Attributes
    ----------
    coef : float
        Coefs
        Bmad type: real
        Fortran default: 0
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    coef: Sequence[float] = pydantic.Field(
        default=0,
        description="Coefs",
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        description="index at lower box corner.",
    )


class CmplxField1At3dPtStruct(pydantic.BaseModel):
    """
    CmplxField1At3dPtStruct corresponds to bmad `cmplx_field1_at_3D_pt_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 110.

    Attributes
    ----------
    f : Complex
        Field
        Bmad type: complex
    df_dx : Complex
        Normalized field 1st derivatives
        Bmad type: complex
    df_dy : Complex
        Normalized field 1st derivatives
        Bmad type: complex
    df_dz : Complex
        Normalized field 1st derivatives
        Bmad type: complex
    d2f_dxdy : Complex
        Normalized field 2nd derivatives
        Bmad type: complex
    d2f_dxdz : Complex
        Normalized field 2nd derivatives
        Bmad type: complex
    d2f_dydz : Complex
        Normalized field 2nd derivatives
        Bmad type: complex
    d3f_dxdydz : Complex
        Normalized field 3rd derivative
        Bmad type: complex
    """

    f: Complex = pydantic.Field(
        default=0.0,
        description="Field",
    )
    df_dx: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    df_dy: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    df_dz: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 1st derivatives",
    )
    d2f_dxdy: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivatives",
    )
    d2f_dxdz: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivatives",
    )
    d2f_dydz: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 2nd derivatives",
    )
    d3f_dxdydz: Complex = pydantic.Field(
        default=0.0,
        description="Normalized field 3rd derivative",
    )


class CmplxFieldAt3dBoxStruct(pydantic.BaseModel):
    """
    CmplxFieldAt3dBoxStruct corresponds to bmad `cmplx_field_at_3D_box_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 119.

    Attributes
    ----------
    pt : CmplxField1At3dPtStruct
        Bmad type: type
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    pt: Sequence[CmplxField1At3dPtStruct] = pydantic.Field(
        default=None,
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        description="index at lower box corner.",
    )


class TricubicCmplxCoefStruct(pydantic.BaseModel):
    """
    TricubicCmplxCoefStruct corresponds to bmad `tricubic_cmplx_coef_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/cubic_interpolation_mod.f90 on line 126.

    Attributes
    ----------
    coef : Complex
        Coefs
        Bmad type: complex
        Fortran default: 0
    i_box : int
        index at lower box corner.
        Bmad type: integer
        Fortran default: int_garbage$
    """

    coef: Sequence[Complex] = pydantic.Field(
        default=0,
        description="Coefs",
    )
    i_box: Sequence[int] = pydantic.Field(
        default=0,
        max_length=3,
        description="index at lower box corner.",
    )


class BinStruct(pydantic.BaseModel):
    """
    BinStruct corresponds to bmad `bin_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/bin_mod.f90 on line 9.

    Attributes
    ----------
    count : float
        Counts (or weight) in each bin
        Bmad type: real
    min : float
        Bounds for the bins
        Bmad type: real
    max : float
        Bmad type: real
    delta : float
        Size of a bin
        Bmad type: real
    n : int
        Number of bins
        Bmad type: integer
    """

    count: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Counts (or weight) in each bin",
    )
    min: float = pydantic.Field(
        default=0.0,
        description="Bounds for the bins",
    )
    max: float = pydantic.Field(
        default=0.0,
    )
    delta: float = pydantic.Field(
        default=0.0,
        description="Size of a bin",
    )
    n: int = pydantic.Field(
        default=0,
        description="Number of bins",
    )


class GeneralBinStruct(pydantic.BaseModel):
    """
    GeneralBinStruct corresponds to bmad `general_bin_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/bin_mod.f90 on line 17.

    Attributes
    ----------
    count : float
        Counts (or weight) in each bin
        Bmad type: real
    min : float
        Bounds for the bins
        Bmad type: real
    max : float
        Bmad type: real
    delta : float
        Size of a bin
        Bmad type: real
    dim : int
        Number of dimensions
        Bmad type: integer
        Fortran default: 3
    n : int
        number of bins in each dimension
        Bmad type: integer
        Fortran default: 1
    """

    count: Sequence[float] = pydantic.Field(
        default=0.0,
        description="Counts (or weight) in each bin",
    )
    min: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Bounds for the bins",
    )
    max: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
    )
    delta: Sequence[float] = pydantic.Field(
        default=0.0,
        max_length=3,
        description="Size of a bin",
    )
    dim: int = pydantic.Field(
        default=3,
        description="Number of dimensions",
    )
    n: Sequence[int] = pydantic.Field(
        default=1,
        max_length=3,
        description="number of bins in each dimension",
    )


class SplineStruct(pydantic.BaseModel):
    """
    SplineStruct corresponds to bmad `spline_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/math/spline_mod.f90 on line 18.

    Attributes
    ----------
    x0 : float
        Point at start of spline
        Bmad type: real
        Fortran default: 0
    y0 : float
        Point at start of spline
        Bmad type: real
        Fortran default: 0
    x1 : float
        Point at end of spline
        Bmad type: real
        Fortran default: 0
    coef : float
        coefficients for cubic spline
        Bmad type: real
        Fortran default: 0
    """

    x0: float = pydantic.Field(
        default=0,
        description="Point at start of spline",
    )
    y0: float = pydantic.Field(
        default=0,
        description="Point at start of spline",
    )
    x1: float = pydantic.Field(
        default=0,
        description="Point at end of spline",
    )
    coef: Sequence[float] = pydantic.Field(
        default=0,
        description="coefficients for cubic spline",
    )


class OptiDeParamStruct(pydantic.BaseModel):
    """
    OptiDeParamStruct corresponds to bmad `opti_de_param_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/optimizers/opti_de_mod.f90 on line 5.

    Attributes
    ----------
    cr : float
        Crossover probability
        Bmad type: real
        Fortran default: 0.8
    f : float
        Mixing number
        Bmad type: real
        Fortran default: 0.8
    l_best : float
        Percentage of best vector.
        Bmad type: real
        Fortran default: 0.0
    use_2nd_diff : bool
        use F * (x_4 - x_5) term
        Bmad type: logical
        Fortran default: .false.
    binomial_cross : bool
        Bmad type: logical
        Fortran default: .false.
    randomize_f : bool
        Bmad type: logical
        Fortran default: .false.
    minimize_merit : bool
        Alternative is to maximize.
        Bmad type: logical
        Fortran default: .true.
    """

    cr: float = pydantic.Field(
        default=0.8,
        description="Crossover probability",
        validation_alias=pydantic.AliasChoices("cr", "CR"),
        serialization_alias="CR",
    )
    f: float = pydantic.Field(
        default=0.8,
        description="Mixing number",
        validation_alias=pydantic.AliasChoices("f", "F"),
        serialization_alias="F",
    )
    l_best: float = pydantic.Field(
        default=0.0,
        description="Percentage of best vector.",
    )
    use_2nd_diff: bool = pydantic.Field(
        default=False,
        description="use F * (x_4 - x_5) term",
    )
    binomial_cross: bool = pydantic.Field(
        default=False,
    )
    randomize_f: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("randomize_f", "randomize_F"),
        serialization_alias="randomize_F",
    )
    minimize_merit: bool = pydantic.Field(
        default=True,
        description="Alternative is to maximize.",
    )


class GeodesicLmParamStruct(pydantic.BaseModel):
    """
    GeodesicLmParamStruct corresponds to bmad `geodesic_lm_param_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/geodesic_lm/geodesic_lm.f90 on line 5.

    Attributes
    ----------
    mode : int
        LM damping matrix. 0->id, 1->dynamic jacob-based
        Bmad type: integer
        Fortran default: 0
    maxiter : int
        max # of routine iterations
        Bmad type: integer
        Fortran default: 500
    maxfev : int
        max # of func evals (0-> no limit)
        Bmad type: integer
        Fortran default: 0
    maxjev : int
        max number of jac evals (0->no limit)
        Bmad type: integer
        Fortran default: 0
    maxaev : int
        max number of dir second derivs (0->no limit)
        Bmad type: integer
        Fortran default: 0
    print_level : int
        how many details to be printed (0-5)
        Bmad type: integer
        Fortran default: 3
    print_unit : int
        unit number details written to
        Bmad type: integer
        Fortran default: 6
    imethod : int
        method choice for updating LM parameter
        Bmad type: integer
        Fortran default: 10
    iaccel : int
        use geodesic acceleration or not
        Bmad type: integer
        Fortran default: 1
    ibold : int
        'boldness' in accepting uphill (0-4) with 0->downhill
        Bmad type: integer
        Fortran default: 0
    ibroyden : int
        number of iterations using approximate jacobian
        Bmad type: integer
        Fortran default: 0
    h1 : float
        controls step sizes for finite diff derivatives
        Bmad type: real
        Fortran default: 1.D-6
    h2 : float
        controls step sizes for finite diff derivatives
        Bmad type: real
        Fortran default: 1.D-1
    maxlam : float
        maximum limit on damping term lambda (if <0 no limit)
        Bmad type: real
        Fortran default: 1E7
    minlam : float
        minimum limit on damping term lambda (if <0 no limit)
        Bmad type: real
        Fortran default: -1.0
    artol : float
        cos of angle between residual and tangent plane
        Bmad type: real
        Fortran default: 1.E-3
    cgoal : float
        Cost lower limit (ends when falls below)
        Bmad type: real
        Fortran default: 1.E-23
    gtol : float
        gradient lower limit
        Bmad type: real
        Fortran default: 1.5E-8
    xtol : float
        step size lower limit (ll)
        Bmad type: real
        Fortran default: 1.E-10
    xrtol : float
        relative parameter change ll
        Bmad type: real
        Fortran default: 1.5E-8
    ftol : float
        consecutive cost difference ll
        Bmad type: real
        Fortran default: 1.5E-8
    frtol : float
        relative consecutive cost diff ll
        Bmad type: real
        Fortran default: 1.5E-8
    initialfactor : float
        initial LM param or step size
        Bmad type: real
        Fortran default: 1.
    factoraccept : float
        (if imethod=0 or 10) adjusts initialfactor
        Bmad type: real
        Fortran default: 5.
    factorreject : float
        adjusts initialfactor for rejected step
        Bmad type: real
        Fortran default: 2.
    avmax : float
        limits geo accel w.r.t. velocity
        Bmad type: real
        Fortran default: 0.8
    analytic_jac : bool
        Bmad type: logical
        Fortran default: .true.
    analytic_avv : bool
        Bmad type: logical
        Fortran default: .false.
    center_diff : bool
        Bmad type: logical
        Fortran default: .true.
    geo_hit_limit : bool
        flag for when limits are hit
        Bmad type: logical
        Fortran default: .false.
    """

    mode: int = pydantic.Field(
        default=0,
        description="LM damping matrix. 0->id, 1->dynamic jacob-based",
    )
    maxiter: int = pydantic.Field(
        default=500,
        description="max # of routine iterations",
    )
    maxfev: int = pydantic.Field(
        default=0,
        description="max # of func evals (0-> no limit)",
    )
    maxjev: int = pydantic.Field(
        default=0,
        description="max number of jac evals (0->no limit)",
    )
    maxaev: int = pydantic.Field(
        default=0,
        description="max number of dir second derivs (0->no limit)",
    )
    print_level: int = pydantic.Field(
        default=3,
        description="how many details to be printed (0-5)",
    )
    print_unit: int = pydantic.Field(
        default=6,
        description="unit number details written to",
    )
    imethod: int = pydantic.Field(
        default=10,
        description="method choice for updating LM parameter",
    )
    iaccel: int = pydantic.Field(
        default=1,
        description="use geodesic acceleration or not",
    )
    ibold: int = pydantic.Field(
        default=0,
        description="'boldness' in accepting uphill (0-4) with 0->downhill",
    )
    ibroyden: int = pydantic.Field(
        default=0,
        description="number of iterations using approximate jacobian",
    )
    h1: float = pydantic.Field(
        default=1e-06,
        description="controls step sizes for finite diff derivatives",
    )
    h2: float = pydantic.Field(
        default=0.1,
        description="controls step sizes for finite diff derivatives",
    )
    maxlam: float = pydantic.Field(
        default=10000000.0,
        description="maximum limit on damping term lambda (if <0 no limit)",
    )
    minlam: float = pydantic.Field(
        default=-1.0,
        description="minimum limit on damping term lambda (if <0 no limit)",
    )
    artol: float = pydantic.Field(
        default=0.001,
        description="cos of angle between residual and tangent plane",
    )
    cgoal: float = pydantic.Field(
        default=1e-23,
        description="Cost lower limit (ends when falls below)",
        validation_alias=pydantic.AliasChoices("cgoal", "Cgoal"),
        serialization_alias="Cgoal",
    )
    gtol: float = pydantic.Field(
        default=1.5e-08,
        description="gradient lower limit",
    )
    xtol: float = pydantic.Field(
        default=1e-10,
        description="step size lower limit (ll)",
    )
    xrtol: float = pydantic.Field(
        default=1.5e-08,
        description="relative parameter change ll",
    )
    ftol: float = pydantic.Field(
        default=1.5e-08,
        description="consecutive cost difference ll",
    )
    frtol: float = pydantic.Field(
        default=1.5e-08,
        description="relative consecutive cost diff ll",
    )
    initialfactor: float = pydantic.Field(
        default=1.0,
        description="initial LM param or step size",
    )
    factoraccept: float = pydantic.Field(
        default=5.0,
        description="(if imethod=0 or 10) adjusts initialfactor",
    )
    factorreject: float = pydantic.Field(
        default=2.0,
        description="adjusts initialfactor for rejected step",
    )
    avmax: float = pydantic.Field(
        default=0.8,
        description="limits geo accel w.r.t. velocity",
    )
    analytic_jac: bool = pydantic.Field(
        default=True,
    )
    analytic_avv: bool = pydantic.Field(
        default=False,
    )
    center_diff: bool = pydantic.Field(
        default=True,
    )
    geo_hit_limit: bool = pydantic.Field(
        default=False,
        description="flag for when limits are hit",
    )


class AtomStruct(pydantic.BaseModel):
    """
    AtomStruct corresponds to bmad `atom_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/particle_species_mod.f90 on line 124.

    Attributes
    ----------
    z : int
        Number of protons
        Bmad type: integer
    name : str
        Element name
        Bmad type: character
    i_offset : int
        isotope number offset
        Bmad type: integer
    mass : float
        isotope masses in units of the unified atomic mass unit.
        Bmad type: real
        Fortran default: no_iso
    """

    z: int = pydantic.Field(
        default=0,
        description="Number of protons",
    )
    name: str = pydantic.Field(
        default_factory=list,
        max_length=2,
        description="Element name",
    )
    i_offset: int = pydantic.Field(
        default=0,
        description="isotope number offset",
    )
    mass: Sequence[float] = pydantic.Field(
        default=0.0,
        description="isotope masses in units of the unified atomic mass unit.",
    )


class VarLengthStringStruct(pydantic.BaseModel):
    """
    VarLengthStringStruct corresponds to bmad `var_length_string_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/sim_utils_struct.f90 on line 14.

    Attributes
    ----------
    str_ : str
        Bmad type: character
    """

    str_: str = pydantic.Field(
        default="",
        validation_alias=pydantic.AliasChoices("str_", "str"),
        serialization_alias="str",
    )


class StrIndexStruct(pydantic.BaseModel):
    """
    StrIndexStruct corresponds to bmad `str_index_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/sim_utils_struct.f90 on line 18.

    Attributes
    ----------
    name : VarLengthStringStruct
        Array of names.
        Bmad type: type
    index : int
        Sorted index for names(:) array.
        Bmad type: integer
    n_min : int
        Bmad type: integer
        Fortran default: 1
    n_max : int
        Use only names(n_min:n_max) part of array.
        Bmad type: integer
        Fortran default: 0
    """

    name: Sequence[VarLengthStringStruct] = pydantic.Field(
        default=None,
        description="Array of names.",
    )
    index: Sequence[int] = pydantic.Field(
        default=0,
        description="Sorted index for names(:) array.",
    )
    n_min: int = pydantic.Field(
        default=1,
    )
    n_max: int = pydantic.Field(
        default=0,
        description="Use only names(n_min:n_max) part of array.",
    )


class NametableStruct(pydantic.BaseModel):
    """
    NametableStruct corresponds to bmad `nametable_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/sim_utils_struct.f90 on line 34.

    Attributes
    ----------
    name : str
        Array of names.
        Bmad type: character
    index : int
        Sorted index for names(:) array.
        Bmad type: integer
    n_min : int
        Set to 0 for use in a lattice.
        Bmad type: integer
        Fortran default: 1
    n_max : int
        Use only names(n_min:n_max) part of array.
        Bmad type: integer
        Fortran default: 0
    """

    name: Sequence[str] = pydantic.Field(
        default_factory=list,
        max_length=40,
        description="Array of names.",
    )
    index: Sequence[int] = pydantic.Field(
        default=0,
        description="Sorted index for names(:) array.",
    )
    n_min: int = pydantic.Field(
        default=1,
        description="Set to 0 for use in a lattice.",
    )
    n_max: int = pydantic.Field(
        default=0,
        description="Use only names(n_min:n_max) part of array.",
    )


class AllPointerStruct(pydantic.BaseModel):
    """
    AllPointerStruct corresponds to bmad `all_pointer_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/sim_utils_struct.f90 on line 45.

    Attributes
    ----------
    r : float
        Bmad type: real
        Fortran default: null()
    i : int
        Bmad type: integer
        Fortran default: null()
    L : bool
        Bmad type: logical
        Fortran default: null()
    r1 : float
        Bmad type: real
        Fortran default: null()
    i1 : int
        Bmad type: integer
        Fortran default: null()
    """

    r: float = pydantic.Field(
        default=0.0,
    )
    i: int = pydantic.Field(
        default=0,
    )
    L: bool = pydantic.Field(
        default=False,
        validation_alias=pydantic.AliasChoices("L", "l"),
        serialization_alias="l",
    )
    r1: Sequence[float] = pydantic.Field(
        default=0.0,
    )
    i1: Sequence[int] = pydantic.Field(
        default=0,
    )


class MolecularComponentStruct(pydantic.BaseModel):
    """
    MolecularComponentStruct corresponds to bmad `molecular_component_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/sim_utils_struct.f90 on line 77.

    Attributes
    ----------
    atom : str
        Bmad type: character
        Fortran default: ''
    number : int
        Bmad type: integer
        Fortran default: 0
    """

    atom: str = pydantic.Field(
        default="",
        max_length=2,
    )
    number: int = pydantic.Field(
        default=0,
    )


class GlobalCommonStruct(pydantic.BaseModel):
    """
    GlobalCommonStruct corresponds to bmad `global_common_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/precision_def.f90 on line 8.

    Attributes
    ----------
    mp_threading_is_safe : bool
        Can threading be used with MP? EG ramping is not thread safe.
        Bmad type: logical
        Fortran default: .true.
    exit_on_error : bool
        Exit program on error?
        Bmad type: logical
        Fortran default: .true.
    debug : int
        Used for debugging purpeses
        Bmad type: integer
        Fortran default: 0
    """

    mp_threading_is_safe: bool = pydantic.Field(
        default=True,
        description="Can threading be used with MP? EG ramping is not thread safe.",
    )
    exit_on_error: bool = pydantic.Field(
        default=True,
        description="Exit program on error?",
    )
    debug: int = pydantic.Field(
        default=0,
        description="Used for debugging purpeses",
    )


class NamedNumberStruct(pydantic.BaseModel):
    """
    NamedNumberStruct corresponds to bmad `named_number_struct`
    which is in Users/klauer/Repos/bmad/sim_utils/interfaces/precision_def.f90 on line 16.

    Attributes
    ----------
    name : str
        Bmad type: character
        Fortran default: ''
    value : float
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
