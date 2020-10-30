#!/bin/bash 

IS_WINDOWS=0
IS_MACOS=0

case "$OSTYPE" in
    darwin*)  IS_MACOS=1   ;;
    win*)     IS_WINDOWS=1 ;;
    msys*)    IS_WINDOWS=1 ;;
    cygwin*)  IS_WINDOWS=1 ;;
esac

# Copy dependencies

if [ $IS_WINDOWS -eq 1 ]; then
    SOURCE_PATH=$(dirname "$BASH_SOURCE")
    TARGET_PATH=$(realpath .git/tabs-spaces-converter/)

    cp -a "$SOURCE_PATH/../lib/." "$TARGET_PATH"
fi

# Set git filters

if [ $IS_WINDOWS -eq 1 ]; then
    TABS_TO_SPACES="\"$TARGET_PATH/expand\" --tabs=4 --initial"
    SPACES_TO_TABS="\"$TARGET_PATH/unexpand\" --tabs=4 --first-only"
elif [ $IS_MACOS -eq 1 ]; then
    TABS_TO_SPACES="gexpand --tabs=4 --initial"
    SPACES_TO_TABS="gunexpand --tabs=4 --first-only"
else
    TABS_TO_SPACES="expand --tabs=4 --initial"
    SPACES_TO_TABS="unexpand --tabs=4 --first-only"
fi

if [ "$1" = "tabs" ]; then
    SMUDGE=$SPACES_TO_TABS
    CLEAN=$TABS_TO_SPACES
elif [ "$1" = "spaces" ]; then
    SMUDGE=$TABS_TO_SPACES
    CLEAN=$SPACES_TO_TABS
else
    echo 'Could not recognize the installation type.'
    echo 'Please specify "tabs" or "spaces".'
    exit 1
fi

git config filter.tabs-spaces-converter.smudge "$SMUDGE"
git config filter.tabs-spaces-converter.clean "$CLEAN"

# Apply git filters

GIT_ATTRIBUTES_PATH='.git/info/attributes'

if ! grep -q 'tabs-spaces-converter' $GIT_ATTRIBUTES_PATH; then
    echo '*.py  filter=tabs-spaces-converter' >> $GIT_ATTRIBUTES_PATH
fi
