#!/bin/bash
#INDEXING OF OPENGROK
cd /src
for repo in *; do
    echo "Updating ${repo}">>/opengrok/indexing.log
    cd ${repo}
    git fetch --all
    git reset --hard origin/master
    cd ..
done
date +"%R Indexing starting">>/opengrok/indexing.log
/opengrok/bin/OpenGrok index /src >>/opengrok/indexing.log
date +"%R Indexing finishing">>/opengrok/indexing.log