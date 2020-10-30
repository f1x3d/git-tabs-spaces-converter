# Tabs-Spaces Converter for Git

Script for adding a git filter to locally convert between tabs and spaces, without forcing every repository member to use the same indentation characters.

During checkout, tabs/spaces will be converted into the preferred characters to use locally.

During staging, the characters you use will be converted back to tabs/spaces, producing no extra diffs.

## How it works

See [this answer on StackOverflow](https://stackoverflow.com/a/2316728) and [this section of the Pro Git book](https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes#_keyword_expansion).

## Usage

### Prerequisites

* Windows: none (dependencies are built-in)
* Linux: install `coreutils` (e.g., `sudo apt install coreutils`)
* Mac OS: install `coreutils` (e.g., `brew install coreutils`)

### Installation

1. Open terminal (for Windows, Git Bash or whatever you use).
2. `cd` into the root folder of your repository (i.e., the one with `.git` folder in it).
3. Run `src/install.sh <type> [tab size]`, where
    * `<type>` is either `tabs` or `spaces` &mdash; determines what characters do you want to have locally;
    * `[tab size]` is a number of spaces in a tab (optional; defaults to 4).

    For example, `src/install.sh tabs 8` or `src/install.sh spaces 2`
4. Open the `.git/info/attributes` file and add/remove file extensions you want to use this script with. Use the `*.py` line as an example.
5. Stash your changes, if any, and delete all tracked files in the repository folder.
6. Run `git checkout HEAD -- *`
7. Enjoy your favorite indentation characters!

### Uninstallation

1. Open terminal (for Windows, Git Bash or whatever you use)
2. `cd` into the root folder of your repository (i.e., the one with `.git` folder in it)
3. Run `src/uninstall.sh`
