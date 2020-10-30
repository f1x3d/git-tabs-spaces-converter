#!/bin/bash 

# Remove dependencies

rm -rf .git/tabs-spaces-converter/

# Remove git filters config

git config --unset filter.tabs-spaces-converter.smudge
git config --unset filter.tabs-spaces-converter.clean

# Remove git attributes filters

sed -i '/tabs-spaces-converter/d' .git/info/attributes
