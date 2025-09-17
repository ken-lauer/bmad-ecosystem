from __future__ import annotations

from string import Template
from typing import TYPE_CHECKING

from .types import FullType

if TYPE_CHECKING:
    from .create_interface import CodegenStructure

fortran_templates = {
    # REAL types
    FullType("real", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ATTRNAME
  end subroutine
""",
        "c_type": "double",
    },
    FullType("real", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      ptr_out = c_loc(struct_obj%ATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
        "c_type": "double*",
    },
    FullType("real", 1, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ATTRNAME(lbound(struct_obj%ATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%ATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%ATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
        "c_type": "double*",
    },
    FullType("complex", 1, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ATTRNAME(lbound(struct_obj%ATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%ATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%ATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
        "c_type": "double _Complex*",
    },
    FullType("integer", 1, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ATTRNAME(lbound(struct_obj%ATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%ATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%ATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
        "c_type": "int*",
    },
    FullType("real", 1, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ATTRNAME)) then
      data_ptr = c_loc(struct_obj%ATTRNAME(lbound(struct_obj%ATTRNAME, 1)))
      lower_bound = int(lbound(struct_obj%ATTRNAME, 1), c_int)
      upper_bound = int(ubound(struct_obj%ATTRNAME, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
        "c_type": "double*",
    },
    FullType("real", 2, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ATTRNAME)) then
      data_ptr = c_loc(struct_obj%ATTRNAME(lbound(struct_obj%ATTRNAME,1), lbound(struct_obj%ATTRNAME,2)))
      
      dim1_lower = int(lbound(struct_obj%ATTRNAME, 1), c_int)
      dim1_upper = int(ubound(struct_obj%ATTRNAME, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      
      dim2_lower = int(lbound(struct_obj%ATTRNAME, 2), c_int)
      dim2_upper = int(ubound(struct_obj%ATTRNAME, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      
      stride1 = 1_c_int
      stride2 = dim1_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
        "c_type": "double*",
    },
    # REAL16 types
    FullType("real16", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_long_double), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ATTRNAME
  end subroutine
""",
        "c_type": "long double",
    },
    FullType("real16", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      ptr_out = c_loc(struct_obj%ATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
        "c_type": "long double*",
    },
    # INTEGER types
    FullType("integer", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ATTRNAME
  end subroutine
""",
        "c_type": "int",
    },
    FullType("integer", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      ptr_out = c_loc(struct_obj%ATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
        "c_type": "int*",
    },
    FullType("integer", 1, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ATTRNAME)) then
      data_ptr = c_loc(struct_obj%ATTRNAME(lbound(struct_obj%ATTRNAME, 1)))
      lower_bound = int(lbound(struct_obj%ATTRNAME, 1), c_int)
      upper_bound = int(ubound(struct_obj%ATTRNAME, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
        "c_type": "int*",
    },
    FullType("integer", 2, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ATTRNAME)) then
      data_ptr = c_loc(struct_obj%ATTRNAME(lbound(struct_obj%ATTRNAME,1), lbound(struct_obj%ATTRNAME,2)))
      
      dim1_lower = int(lbound(struct_obj%ATTRNAME, 1), c_int)
      dim1_upper = int(ubound(struct_obj%ATTRNAME, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      
      dim2_lower = int(lbound(struct_obj%ATTRNAME, 2), c_int)
      dim2_upper = int(ubound(struct_obj%ATTRNAME, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      
      stride1 = 1_c_int
      stride2 = dim1_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
        "c_type": "int*",
    },
    FullType("integer8", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ATTRNAME
  end subroutine
""",
        "c_type": "long long",
    },
    FullType("integer8", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      ptr_out = c_loc(struct_obj%ATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
        "c_type": "long long*",
    },
    # COMPLEX types
    FullType("complex", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ATTRNAME
  end subroutine
""",
        "c_type": "double _Complex",
    },
    FullType("complex", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      ptr_out = c_loc(struct_obj%ATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
        "c_type": "double _Complex*",
    },
    # LOGICAL types
    FullType("logical", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ATTRNAME
  end subroutine
""",
        "c_type": "bool",
    },
    FullType("logical", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      ptr_out = c_loc(struct_obj%ATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
        "c_type": "bool*",
    },
    # CHARACTER types
    FullType("character", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ATTRNAME)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%ATTRNAME), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
        "c_type": "char*",
    },
    FullType("character", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      data_ptr = c_loc(struct_obj%ATTRNAME)
      lower_bound = 1_c_int
      upper_bound = int(len_trim(struct_obj%ATTRNAME), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
        "c_type": "char*",
    },
    # TYPE (derived type - no pointer, just address)
    FullType("type", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ATTRNAME)
  end subroutine
""",
        "c_type": "void*",
    },
    FullType("type", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ATTRNAME)) then
      ptr_out = c_loc(struct_obj%ATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
        "c_type": "void*",
    },
    # SIZE queries
    FullType("size", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_ATTRNAME(struct_obj_ptr, dim, size_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(in), value :: dim
    integer(c_int), intent(out) :: size_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ATTRNAME)) then
      if (dim >= 1 .and. dim <= rank(struct_obj%ATTRNAME)) then
        size_out = int(size(struct_obj%ATTRNAME, dim), c_int)
      else
        size_out = -1_c_int  ! Invalid dimension
      endif
    else
      size_out = 0_c_int  ! Not allocated
    endif
  end subroutine
""",
        "c_type": "int",
    },
}

cpp_templates = {
    # REAL types
    FullType("real", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, double* value_out);
""",
        "accessor": """
    double ATTRNAME() const {
        double value;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &value);
        return value;
    }
""",
        "cpp_type": "double",
    },
    FullType("real", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, double** ptr_out);
""",
        "accessor": """
    double* ATTRNAME() const {
        double* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""",
        "cpp_type": "double*",
    },
    FullType("real", 1, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        double** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound
    );
""",
        "accessor": """
    FortranArray1D<double> ATTRNAME() const {
        double* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<double>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""",
        "cpp_type": "FortranArray1D<double>",
    },
    FullType("complex", 1, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        double _Complex** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound
    );
""",
        "accessor": """
    FortranArray1D<std::complex<double>> ATTRNAME() const {
        double _Complex* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<std::complex<double>>(
            reinterpret_cast<std::complex<double>*>(data_ptr), 
            size_out, lower_bound, upper_bound, true
        );
    }
""",
        "cpp_type": "FortranArray1D<std::complex<double>>",
    },
    FullType("integer", 1, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        int** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound
    );
""",
        "accessor": """
    FortranArray1D<int> ATTRNAME() const {
        int* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<int>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""",
        "cpp_type": "FortranArray1D<int>",
    },
    FullType("real", 1, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        double** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated
    );
""",
        "accessor": """
    FortranArray1D<double> ATTRNAME() const {
        double* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        
        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );
        
        return FortranArray1D<double>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""",
        "cpp_type": "FortranArray1D<double>",
    },
    FullType("real", 2, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        double** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2,
        bool* is_allocated
    );
""",
        "accessor": """
    FortranArray2D<double> ATTRNAME() const {
        double* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        bool is_allocated;
        
        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, 
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2, &is_allocated
        );
        
        return FortranArray2D<double>(data_ptr, 
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, is_allocated);
    }
""",
        "cpp_type": "FortranArray2D<double>",
    },
    # REAL16 types
    FullType("real16", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, long double* value_out);
""",
        "accessor": """
    long double ATTRNAME() const {
        long double value;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &value);
        return value;
    }
""",
        "cpp_type": "long double",
    },
    FullType("real16", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, long double** ptr_out);
""",
        "accessor": """
    long double* ATTRNAME() const {
        long double* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""",
        "cpp_type": "long double*",
    },
    # INTEGER types
    FullType("integer", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, int* value_out);
""",
        "accessor": """
    int ATTRNAME() const {
        int value;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &value);
        return value;
    }
""",
        "cpp_type": "int",
    },
    FullType("integer", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, int** ptr_out);
""",
        "accessor": """
    int* ATTRNAME() const {
        int* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""",
        "cpp_type": "int*",
    },
    FullType("integer", 1, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        int** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated
    );
""",
        "accessor": """
    FortranArray1D<int> ATTRNAME() const {
        int* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        
        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );
        
        return FortranArray1D<int>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""",
        "cpp_type": "FortranArray1D<int>",
    },
    FullType("integer", 2, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        int** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2,
        bool* is_allocated
    );
""",
        "accessor": """
    FortranArray2D<int> ATTRNAME() const {
        int* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        bool is_allocated;
        
        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, 
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2, &is_allocated
        );
        
        return FortranArray2D<int>(data_ptr, 
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, is_allocated);
    }
""",
        "cpp_type": "FortranArray2D<int>",
    },
    FullType("integer8", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, long long* value_out);
""",
        "accessor": """
    long long ATTRNAME() const {
        long long value;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &value);
        return value;
    }
""",
        "cpp_type": "long long",
    },
    FullType("integer8", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, long long** ptr_out);
""",
        "accessor": """
    long long* ATTRNAME() const {
        long long* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""",
        "cpp_type": "long long*",
    },
    # COMPLEX types
    FullType("complex", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, double _Complex* value_out);
""",
        "accessor": """
    std::complex<double> ATTRNAME() const {
        double _Complex c_value;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &c_value);
        return std::complex<double>(creal(c_value), cimag(c_value));
    }
""",
        "cpp_type": "std::complex<double>",
    },
    FullType("complex", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, double _Complex** ptr_out);
""",
        "accessor": """
    std::complex<double>* ATTRNAME() const {
        double _Complex* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return reinterpret_cast<std::complex<double>*>(ptr);
    }
""",
        "cpp_type": "std::complex<double>*",
    },
    # LOGICAL types
    FullType("logical", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, bool* value_out);
""",
        "accessor": """
    bool ATTRNAME() const {
        bool value;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &value);
        return value;
    }
""",
        "cpp_type": "bool",
    },
    FullType("logical", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, bool** ptr_out);
""",
        "accessor": """
    bool* ATTRNAME() const {
        bool* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""",
        "cpp_type": "bool*",
    },
    # CHARACTER types
    FullType("character", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound
    );
""",
        "accessor": """
    std::string ATTRNAME() const {
        auto char_array = get_ATTRNAME_chars();
        return std::string(char_array.data(), char_array.size());
    }

    FortranArray1D<char> get_ATTRNAME_chars() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;

        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
        );

        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""",
        "cpp_type": "std::string",
    },
    FullType("character", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        bool* is_allocated
    );
""",
        "accessor": """
    std::string ATTRNAME() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;

        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );

        if (!is_allocated || size_out == 0) {
            return std::string();
        }

        return std::string(data_ptr, size_out);
    }

    FortranArray1D<char> get_ATTRNAME_chars() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;

        STRUCTNAME_get_ATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );

        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""",
        "cpp_type": "std::string",
    },
    # TYPE (derived type pointer)
    FullType("type", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, void** ptr_out);
""",
        "accessor": """
    const void* ATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""",
        "cpp_type": "const void*",
    },
    FullType("type", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, void** ptr_out);
""",
        "accessor": """
    const void* ATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""",
        "cpp_type": "const void*",
    },
    # SIZE queries
    FullType("size", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_ATTRNAME(const void* struct_obj, int dim, int* size_out);
""",
        "accessor": """
    int ATTRNAME(int dim = 1) const {
        int size_out;
        STRUCTNAME_get_ATTRNAME(fortran_ptr_, dim, &size_out);
        return size_out;
    }
""",
        "cpp_type": "int",
    },
}


def generate_accessor_code(struct_name: str, attr_name: str, full_type: FullType):
    """
    Generate Fortran and C++ accessor code for a given struct/attribute/type combination.
    """

    try:
        fortran_template = fortran_templates[full_type]
        cpp_template = cpp_templates[full_type]
    except KeyError as ex:
        raise ValueError(f"Unsupported type: {full_type}") from ex

    return {
        "fortran": fortran_template["getter"]
        .replace("STRUCTNAME", struct_name)
        .replace("ATTRNAME", attr_name),
        "cpp_declaration": cpp_template["declaration"]
        .replace("STRUCTNAME", struct_name)
        .replace("ATTRNAME", attr_name),
        "cpp_accessor": cpp_template["accessor"]
        .replace("STRUCTNAME", struct_name)
        .replace("ATTRNAME", attr_name),
        "c_type": fortran_template["c_type"],
        "cpp_type": cpp_template["cpp_type"],
    }


def create_fortran_proxy_code(fout, structs: list[CodegenStructure]):
    print(
        """\
module bmad_struct_proxy_mod
  use bmad_struct
  use, intrinsic :: iso_c_binding
contains
""",
        file=fout,
    )
    for struct in structs:
        print(f"! {struct.f_name}", file=fout)
        for arg in struct.arg:
            if not arg.is_component:
                continue
            try:
                acc = generate_accessor_code(struct.f_name, arg.f_name, arg.full_type)
            except ValueError as ex:
                print(f"! skipped {struct.f_name}%{arg.f_name}: {ex}", file=fout)
                continue

            print(acc["fortran"], file=fout)
    print("end module", file=fout)


def create_cpp_proxy_code(fout, template_src: str, structs: list[CodegenStructure]):
    tpl = Template(template_src.replace("// ${", "${"))

    forward_declarations = []
    subs = {}

    for struct in structs:
        print(f"// {struct.f_name}", file=fout)

        class_body = []
        for arg in struct.arg:
            if not arg.is_component:
                continue
            try:
                acc = generate_accessor_code(struct.f_name, arg.f_name, arg.full_type)
            except ValueError as ex:
                print(f"// skipped {struct.f_name}%{arg.f_name}: {ex}", file=fout)
                continue

            class_body.append(acc["cpp_accessor"])

            forward_declarations.append(acc["cpp_declaration"])

        subs[f"{struct.f_name}_class_body"] = "\n".join(class_body)
    subs["forward_declarations"] = "\n".join(forward_declarations)
    print(tpl.substitute(subs), file=fout)
