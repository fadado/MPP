#!/bin/bash

# mm -- Markdown Maker

shopt -s expand_aliases

alias info='echo 1>&2'

########################################################################
#
########################################################################

declare -a FIND_ASSETS=(
    -type f
    '!' -name '_*'
    -name '*.png'   -o
    -name '*.gif'   -o
    -name '*.pdf'   -o
    -name '*.jpg'   -o
    -name '*.jpeg'
)
declare -a FIND_PAGES=(
    -type f
    '!' -name '_*'
    -name '*.md'    -o
    -name '*.mkd'   -o
    -name '*.mdown' -o
    -name '*.markdown'
)

########################################################################
#
########################################################################

function folders
{
    local src=$1 dst=$2 folder

    find "$src" "${FIND_PAGES[@]}" -or "${FIND_ASSETS[@]}"  |
        sed -e "s/^$src//;s/[^/]\+$//;/^\/$/d;s/^/$dst/"    |
        sort -ru                                            |
        while read -r folder; do
            test -d "$folder" || mkdir -p "$folder"
        done
    test -d "$dst" || mkdir -p "$dst"
}

function assets
{
    local src=$1 dst=$2 asset target

    find "$src" "${FIND_ASSETS[@]}" |
        while read -r asset; do
            target="$dst${asset#$src}"
            test "$target" -nt "$asset" || {
                info "$asset => $target"
                cp "$asset" "$target"
            }
        done
}

function pages
{
    local src=$1 dst=$2 page target

    find "$src" "${FIND_PAGES[@]}" |
        while read -r page; do
            target="$dst${page#$src}"
            test "$target" -nt "$page" || {
                info "$page => $target"
                mpp -I"$src" < "$page" > "$target"
            }
        done
}

function publish
{
    folders "$@"; assets "$@"; pages "$@"
}

########################################################################
#
########################################################################

if (( $# == 0 )); then
    for d in _*; do
        publish "$d" "${d#_}"
    done
else
    for d in "$@"; do
        [[ -d "_$d" ]] || {
            info "Directory _$d expected to exist"
            exit 1
        }
        publish "_$d" "$d"
    done
fi

exit

# vim:ts=4:sw=4:ai:et:fileencoding=utf-8:syntax=sh
