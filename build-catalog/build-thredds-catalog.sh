#!/usr/bin/env bash

cd ${HOME}/build-catalog

DAYS=$(ls /store/hpfx.collab.science.gc.ca/)

cat pre-text.txt > catalog.xml

for DAY in ${DAYS} ; do
   cat main-text.txt | sed -e "s/##DATE##/${DAY}/g" >> catalog.xml
done

cat post-text.txt >> catalog.xml
