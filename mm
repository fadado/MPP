#!/bin/bash

# mm -- Markdown Maker

########################################################################
#
########################################################################

declare -a FIND_ASSETS=(
    -name '*.png' -or
    -name '*.gif' -or
    -name '*.pdf' -or
    -name '*.jpg' -or
    -name '*.jpeg'
)
declare -a FIND_PAGES=(
    -name '*.md'  -or
    -name '*.mkd' -or
    -name '*.markdown'
)

########################################################################
#
########################################################################

function folders
{
    local src=$1 dst=$2 folder

    find "$src" "${FIND_PAGES[@]}" -or "${FIND_ASSETS[@]}"  |
        sed -e "s/^$src//" -e 's/[^/]\+$//' -e '/^\/$/d'    \
            -e "s/^/$dst/"                                  |
        sort -ru                                            |
        while read -r folder; do
            [[ -d "$folder" ]] || mkdir -vp "$folder"
        done
    [[ -d "$dst" ]] || mkdir -vp "$dst"
    return
}

function assets
{
    local src=$1 dst=$2 asset

    find "$src" "${FIND_ASSETS[@]}" |
        while read -r asset; do
            cp -vu "$asset" "$dst${asset#$src}"
        done
    return
}

function pages
{
    local src=$1 dst=$2 page
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
