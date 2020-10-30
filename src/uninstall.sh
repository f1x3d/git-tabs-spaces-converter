#!/bin/bash 

IS_WINDOWS=0

case "$OSTYPE" in
    win*)     IS_WINDOWS=1 ;;
    msys*)    IS_WINDOWS=1 ;;
    cygwin*)  IS_WINDOWS=1 ;;
esac

# Remove dependencies

if [ $IS_WINDOWS -eq 1 ]; then
    rm -rf .git/tabs-spaces-converter/
fi

# Remove git filters config

git config --unset filter.tabs-spaces-converter.smudge
git config --unset filter.tabs-spaces-converter.clean

# Remove git attributes filters

sed -i '/tabs-spaces-converter/d' .git/info/attributes
