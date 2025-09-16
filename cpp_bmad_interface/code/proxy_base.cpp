#include "tao_proxies.hpp"

const std::string tao::ElementProxy::name() const {
  char buf[200];
  ele_get_name(fortran_ptr_, buf);
  return std::string(buf);
}
