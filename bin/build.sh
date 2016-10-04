#!/bin/bash
set -e
pdflatex -halt-on-error -shell-escape resume
bin/strip_pdf.sh resume.pdf
htlatex resume "html,NoFonts,-css" '' '' "-halt-on-error"
tidy -i -w 72 -b resume.html \
    | awk '/<body>/{flag=1;next}/body>/{flag=0}flag' \
    > partial.html
