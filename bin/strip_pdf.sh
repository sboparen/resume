#!/bin/bash
set -e
test -e "$1"

pdftk "$1" dump_data output "$1".tmp
sed -e 's/\(InfoValue:\)\sD:.*/\1\ /g' -i "$1".tmp
cp "$1" "$1".old
pdftk "$1".old update_info "$1".tmp output "$1"
rm "$1".tmp "$1".old

cp "$1" "$1".orig
sed -i -e '/^\/ID /d' "$1"
