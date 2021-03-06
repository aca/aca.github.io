#!/usr/bin/env bash

rm -rf .neuron
cp -rp ~/src/zettels/static .
cp -rp ~/src/zettels/head.html .
cp -rp ~/src/zettels/aca.github.io .
cp -rp ~/src/zettels/neuron.dhall .
mv aca.github.io/aca.github.io.md index.md
git add *
git commit -m "."
git push origin master
