#!/bin/bash
set -e

# Don't run unless we are clean.
# See http://stackoverflow.com/questions/5139290
if (git status --porcelain || echo err) | grep -q .; then exit 1; fi

# Build.
./clean.sh
./build.sh

# Copy files.
cp page.html pages/index.html
cp partial.html pages/_partial.html
cp resume.pdf pages/simon-parent.pdf

# Commit (if there were any changes).
h="$(git describe --always)"
cd pages
if (git status --porcelain || echo err) | grep -q .; then
    git commit -a -m "Build from commit $h."
fi
