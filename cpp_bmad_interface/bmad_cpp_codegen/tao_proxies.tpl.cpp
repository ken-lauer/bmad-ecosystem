#include "tao_proxies.hpp"

using namespace tao;

TaoUniverseProxy TaoUniverseIndexProxy::operator*() const {
  int n_universes = tao_get_n_universes();
  if (ix_uni_ < 1 || ix_uni_ > n_universes) {
    throw InvalidIndexException("universe", ix_uni_, n_universes);
  }
  return TaoUniverseProxy(tao_c_get_universe_ptr(ix_uni_));
}
