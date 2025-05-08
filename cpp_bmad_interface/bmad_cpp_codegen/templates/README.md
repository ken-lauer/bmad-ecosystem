## Templates

The templates in this directory are of a custom format (\*).

They are used to generate C++ and Fortran code to bidirectionally convert Bmad
Fortran structures and C++ classes.

## (\*) But whhhy

Custom formats are generally terrible. I think this one is at least partially justified.
Here was how this started out:

- The information in these templates was extracted from some original C++
  interface code generation Python script available in Bmad.
- The original intent was to keep the changes minimal but allow for downstream
  support of modern tooling like pybind11. (The goals admittedly shifted over
  time...). This meant that without starting from scratch, I had to use the existing
  data somehow.
- The conversion information was buried in a few thousand lines of code without
  a single function, so attempting to fix even one parameter type ended up taking
  a significant amount of time - or adversely affecting other parameter types
  unintentionally.

Here are the reasons why I think this templating mechanism is ~not so terrible~
better than its predecessor:

- With the template information in files of their respective languages (i.e.,
  C++ code goes in `c_side.cpp` and Fortran code goes in `f_side.f90`), editors
  and standard tooling are able to provide at least syntax highlighting.
- `clang-format` has no major issue with `c_side.cpp` (though some workarounds are in
  place for that purpose)
- Custom code for specific structure members can be included alongside the rest
  of the code (see `ele_struct%` customizations at the end of `c_side.cpp` for
  example).
- If something better comes along, the information could always be extracted and
  rewritten as the future maintainer (perhaps even me) sees fit.

There are still a lot of remnants of the original code, but it's at least
in a more maintainable state (I hope).

## Specifics

## The format

Per-language comment characters are used as control codes.
`////` is used in `c_side.cpp` and `!!!!` is used in `f_side.f90`.

Here, we will use just the C++ comment characters for example.

### `section:`

A section is defined as:

```
//// section:SECTION_NAME
(code)
```

Sections are split until the next section marker is found.
_Each section is entirely independent of other sections._

### `type:`

```
//// type:TYPE_NAME
```

A type specified is global for the section.

### `TYPE_NAME`

Type names are comprised of:

```
{DIM}D_{PTR}_{typename}
```

- Where `DIM` is 0 (scalar), 1 (array), 2 (matrix), or 3 (tensor).
- `PTR` is from the Fortran perspective: `NOT` (not a pointer), `PTR` (a
  pointer), or `ALLOC` (allocatable)
- `typename` is one of
  - `character`
  - `complex`
  - `integer8`
  - `integer`
  - `logical`
  - `real`
  - `size`
  - `type`

## `begin:` and `end:`

Code blocks are defined in begin-to-end sections.

```
//// begin:NAME
CODE
//// end:NAME
```

The above would mean, in rough pseudo-code:

```python
# given `section`
for applicable_type in types_listed_in_section:
    c_side_translation[applicable_type].NAME = CODE
```

## `case:`

For scenarios where a large amount of code is shared with a few exceptions,
`case:` exists. It applies to _only_ the subsequent line in the template.

```
//// case:TYPE:ATTR
CODE
```

For example:

```
//// section:foo
//// case:TYPE1:ATTR1
TYPE1_CODE
//// case:TYPE2:ATTR1
TYPE2_CODE
//// begin:NAME
CODE
//// end:NAME

```

By convention, `//// end special cases` may be seen in the code, but this is
not parsed.

The above would mean, in rough pseudo-code:

```python
# given `section`
for applicable_type in types_listed_in_section:
    c_side_translation[applicable_type].NAME = CODE
c_side_translation[TYPE1].ATTR1 = TYPE1_CODE
c_side_translation[TYPE1].ATTR2 = TYPE2_CODE
```

## Per-structure customizations

An exception for `begin` and `end` code blocks allowing for per-structure member customizations is available.
See `ele_struct%` customizations at the end of `c_side.cpp` for a complete example.

```
  //// section:ele_struct

  //// begin:ele_struct%.c_constructor_arg_list
  const int key_ = 0;
  //// end:ele_struct%.c_constructor_arg_list

  //// begin:ele_struct%value.to_c2_set
  // (custom - off-by-one ele attribs)
  C.NAME[0] = 0;
  for (unsigned int i = 1; i < Bmad::NUM_ELE_ATTRIB + 1; i++) {
    C.NAME[i] = z_NAME[i - 1];
  }
  //// end:ele_struct%value.to_c2_set
```

The above roughly translates to this pseudo-code:

```python
struct = structures["ele_struct"]
struct.c_constructor_arg_list = "const int key_ = 0" # ; stripped
struct.arguments["value"].to_c2_set = "C.NAME[0] = 0;\nfor (unsigned int i..." # clipped
```

## Template replacements

- `NAME` is replaced with the C++- or Fortran-side parameter name
- `TEST_VALUE` is replaced with `test_value`
- `DIM1` is replaced with dimension 1 of the array (where applicable)
- `DIM2` is replaced with dimension 2 of the array (where applicable)
- `DIM3` is replaced with dimension 3 of the array (where applicable)
- `STR_LEN` is replaced with the fixed string length (where applicable)

### `clang-format` workarounds

Some tweaks are made post-processing of the template in order to allow
`clang-format` to appropriately interpret the file.

To see the specifics, best place to look is in the `.../create_interface.py`
script in `load_transforms.

A few things of note:

- Comma (`,`) is stripped from the right of `to_c2_arg` and `to_f2_call`.
- `TEST_VALUE` trailing semicolons are stripped.
- `CTYPE` is replaced with the C type (used when calling Fortran).

### Fortran deduplication helpers

- `associated_or_allocated` is a meta function that gets replaced with
  `associated` or `allocated` depending on the parameter type. It helps for
  deduplicating `ALLOC` and `PTR` types.
