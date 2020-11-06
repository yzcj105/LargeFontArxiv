#!/bin/sh
TEMP=/tmp/pdfZoom
echo $TEMP/$1
rm -rf $TEMP/$1
mkdir -p $TEMP/$1
cd $TEMP/$1
#wget  https://arxiv.org/e-print/$1 -o $TEMP/$1/$1.tgz && tar xf $TEMP/$1/$1.tgz -C $TEMP/$1/
curl -L https://arxiv.org/e-print/$1 -o $TEMP/$1/$1.tgz && tar xf $TEMP/$1/$1.tgz -C $TEMP/$1/
#aria2c --allow-overwrite=true  https://arxiv.org/e-print/$1 -o $TEMP/$1/$1.tgz && tar xf $TEMP/$1/$1.tgz -C $TEMP/$1/
f=$(fd --extension tex)
NAME=${f%.tex}
#sed -i '' '1,10s/twocolumn/onecolumn/g' $TEMP/$1/$NAME.tex
#sed -i '' '1,10s/preprint/onecolumn/g' $TEMP/$1/$NAME.tex
#sed -i '' '1,10s/reprint/onecolumn/g' $TEMP/$1/$NAME.tex
#sed -i '' '1,10s/10pt/12pt/g' $TEMP/$1/$NAME.tex
#sed -i '' '1,10s/11pt/12pt/g' $TEMP/$1/$NAME.tex
sed -i '' '1,10s/twocolumn//g' $TEMP/$1/$NAME.tex
sed -i '' '1,10s/preprint//g' $TEMP/$1/$NAME.tex
sed -i '' '1,10s/reprint//g' $TEMP/$1/$NAME.tex
sed -i '' '1,10s/10pt//g' $TEMP/$1/$NAME.tex
sed -i '' '1,10s/11pt//g' $TEMP/$1/$NAME.tex
sed -i '' '1,10s/documentclass\[/documentclass\[reprint,12pt,/g' $TEMP/$1/$NAME.tex
pdflatex -synctex=1 -interaction=nonstopmode $NAME 2> error.txt 1> output.txt
bibtex $NAME 2>error.txt 1>output.txt
pdflatex -synctex=1 -interaction=nonstopmode $NAME 2> error.txt 1> output.txt
pdflatex -synctex=1 -interaction=nonstopmode $NAME 2> error.txt 1> output.txt
open $NAME.pdf


