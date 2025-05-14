module cpp_bmad_interface_helper_structs

type ele_reference_struct
  integer :: ix_ele = -1                          ! Index in branch ele(0:) array.
  integer :: ix_branch = 0                        ! Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).
end type ele_reference_struct

type branch_reference_struct
  integer :: ix_branch = 0                        ! Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).
end type branch_reference_struct

end module
