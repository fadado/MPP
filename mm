#!/bin/bash

# mm -- Markdown Maker

########################################################################
#
########################################################################

declare -a FIND_ASSETS=(
    -name '*.png' -o
    -name '*.gif' -o
    -name '*.pdf' -o
    -name '*.jpg' -o
    -name '*.jpeg'
)
declare -a FIND_PAGES=(
    -name '*.md'  -o
    -name '*.mkd' -o
    -name '*.markdown'
)

########################################################################
#
########################################################################

function folders
{
    local src=$1 dst=$2 folder

    cd "$src"
    find . "${FIND_PAGES[@]}" -or "${FIND_ASSETS[@]}"   |
        sed -e 's/^\.//' -e 's/[^/]\+$//' -e '/^\/$/d'  |
        sort -u                                         |
        while read -r folder; do
            folder="../$dst$folder"
            [[ -d "$folder" ]] || mkdir -p "$folder"
        done
    cd $OLDPWD
    [[ -d "$dst" ]] || mkdir -p "$dst"
    return
}

function assets
{
    local src=$1 dst=$2 folder
    return
}

function pages
{
    local src=$1 dst=$2 folder
    return
}

function publish
{
    folders "$@" && assets "$@" && pages "$@"
}

########################################################################
#
########################################################################

if (( $# == 0 )); then
    for d in _*; do
        publish "$d" "${d#_}"
    done
else
    for d in $*; do
        [[ -d "_$d" ]] || {
            echo 1>&2 "Directory _$d expected to exist"
            exit 1
        }
        publish "_$d" "$d"
    done
fi

exit

# vim:ts=4:sw=4:ai:et:fileencoding=utf-8:syntax=sh
