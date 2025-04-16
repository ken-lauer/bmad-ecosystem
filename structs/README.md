# Bmad structure parser

- Parses bmad Fortran code and generates `.yaml` details about all defined structures it found
- Generates JSON-Fortran code (assuming `bmad` is one directory up) for dumping arbitrary ("raw") Fortran structures as JSON
- Generates Python code representing the structures as Pydantic v2 models
