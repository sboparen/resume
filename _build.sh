#!/bin/bash
set -e
pdflatex -halt-on-error -shell-escape _resume
./_strip_pdf.sh _resume.pdf
htlatex _resume "html,NoFonts,-css" '' '' "-halt-on-error"
sed -i _resume.html -e 's/<!--[^>]*-->//g'
tidy -m -i -w 72 -b _resume.html
L='<link rel="stylesheet" href="https://sboparen.github.io/style/main.css">'
sed -i _resume.html -e "s@</head>@$L</head>@"
awk '/<body>/{flag=1;next}/body>/{flag=0}flag' _resume.html >_partial.html
cp _resume.pdf simon-parent.pdf
