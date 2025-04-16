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

{%- for filename, imports in to_import.items() %}
from .{{ filename }} import {{ imports | sort | join(", ") }}
{%- endfor %}

Complex = Annotated[
    complex,
    PlainValidator(lambda x: x if isinstance(x, complex)
                   else complex(x.get('real', x.get('imag')))),
    PlainSerializer(lambda x: {'real': x.real, 'imag': x.imag}, return_type=dict)
]


{%- for filename, file_structs in all_structs.items() %}
{%- for struct_name, struct in file_structs.items() %}

{%- if struct.info.members | length %}
{% macro field_value(param) -%}
    {{ " =" }} pydantic.Field(
    {%- if param.default_factory -%}
        default_factory={{ param.default_factory }},
    {%- else -%}
        default={{ param.default | repr }},
    {%- endif -%}
    {%- if param.size | int != 0 -%}
        {%- if param.dimension | int != 0 -%}
            max_length={{ param.dimension }},
        {%- else -%}
            max_length={{ param.size }},
        {%- endif -%}
    {%- elif param.dimension | int != 0 -%}
        max_length={{ param.dimension }},
    {%- endif -%}
    {%- if param.comment | length > 80 -%}
        {%- set lines = param.comment | replace('"', "'") | wordwrap(width=74) | splitlines %}
        description=({%- for line in lines %}
        {%- if loop.last %}
            {{ line | maybe_raw_string }}"{{ line }}"
        {%- else %}
            {{ line | maybe_raw_string }}"{{ line }} "
        {%- endif %}
        {%- endfor %}
        ),
    {%- elif param.comment -%}
        description={{ param.comment | maybe_raw_string }}"{{ param.comment | replace('"', "'") }}",
    {%- endif -%}
    {%- if param.name != param.python_name %}
        validation_alias=pydantic.AliasChoices("{{ param.python_name }}", "{{ param.name }}"),
        serialization_alias="{{ param.name }}",
    {%- endif -%}
    )
{%- endmacro%}

{%- macro get_docstring(py_struct) %}
    {{ struct.info.class_name }} corresponds to bmad `{{ struct_name }}`
    which is in {{ filename | trim("./") }} on line {{ struct.line }}. {{
        struct.info.comment | wordwrap | indent(4) 
    }}

    Attributes
    ----------
    {%- for param in struct.info.members.values() %}
    {{ param.python_name }} : {{ param.python_type }}{% if not param.default is none %}{% endif %}
        {%- if param.comment %}
        {{ param.comment | wordwrap | indent(8) }}
        {%- endif  %}
        Bmad type: {{ param.type }}
        {%- if param.fortran_default %}
        Fortran default: {{ param.fortran_default }}
        {%- endif %}
    {%- endfor %}
{%- endmacro %}
{%- set docstring = get_docstring(py_struct) %}
class {{ struct.info.class_name }}(pydantic.BaseModel):
    {{ docstring | maybe_raw_string }}
    """
    {{- docstring }}
    """

    {%- for param in struct.info.members.values() %}
    {%- if param.dimension %}
    {{ param.python_name }}: Sequence[{{ param.python_type }}]{{ field_value(param) }}
    {%- else %}
    {{ param.python_name }}: {{ param.python_type }}{{ field_value(param) }}
    {%- endif %}
    {%- endfor %}
{%- endif %}
{%- endfor %}
{%- endfor %}
