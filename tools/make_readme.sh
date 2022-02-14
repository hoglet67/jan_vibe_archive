#!/bin/bash

cd screenshots
for folder in `ls -d BAS*`
do
    cd $folder
    rm -f README.md
    for png in `ls *.png | sort`
    do
        name=${png%.png}
        echo "[*${name}*](../../programs/${folder}/${name})" >> README.md
        echo >> README.md
        echo "![](${png})" >> README.md
        echo >> README.md
    done
    cd ..
done
