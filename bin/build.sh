#!/bin/bash
set -e
pdflatex -halt-on-error -shell-escape resume
bin/strip_pdf.sh resume.pdf
htlatex resume "html,NoFonts,-css" '' '' "-halt-on-error"
sed -i resume.html -e 's/<!--[^>]*-->//g'
tidy -m -i -w 72 -b resume.html
L='<link rel="stylesheet" href="https://sboparen.github.io/style/main.css">'
sed -i resume.html -e "s@</head>@$L</head>@"
awk '/<body>/{flag=1;next}/body>/{flag=0}flag' resume.html >partial.html
