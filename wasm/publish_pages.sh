#!/bin/bash
#
# Build the Tao web page and publish it with GitHub Pages: the page is pushed as the only commit
# of the gh-pages branch of a remote. Needs the toolchain and the libraries (see README.md).
#
# Usage: wasm/publish_pages.sh [remote]      Default remote is "origin".
#
# The gh-pages branch of the remote is REPLACED: it holds nothing but the generated page.

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$HERE")"
source "$HERE/env.sh"

remote=${1:-origin}
url=$(git -C "$ROOT" remote get-url "$remote")
commit=$(git -C "$ROOT" rev-parse --short HEAD)

python3 "$HERE/gen_ninja.py"
ninja -C "$HERE/build"
python3 "$HERE/build_web.py"

site=$(mktemp -d)
trap 'rm -rf "$site"' EXIT
cp -R "$HERE/build/web/." "$site/"
# The files are served as they are: no Jekyll processing.
touch "$site/.nojekyll"

git -C "$site" init -q -b gh-pages
git -C "$site" add -A
git -C "$site" commit -q -m "Tao web page built from $commit"
git -C "$site" push --force "$url" gh-pages

echo "Published $commit to the gh-pages branch of $url"
