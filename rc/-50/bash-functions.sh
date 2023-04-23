#!/bin/bash
#
# Function definitions
#
# 2008-09-12 Johnny Wezel <j@wezel.name>

# Print usage instructions and exit
function _usage() {
    echo "usage: ${FUNCNAME[1]} $*"
    return 1
}

# Add one or more directories to a specified path variable
#
# Options:
#   -q  don't print warnings if directory does not exist
#
# Arguments:
#   directory ...
#   variable-name
function addpath() {
    local quiet=0 verbose=0 option OPTIND OPTERR dir arg newpath varname path sep args
    while getopts 'qv' option
    do
      case $option in
        q) let quiet+=1 ;;
        v) let verbose+=1 ;;
        ?) _usage "[ -q ] [ -v ] directory ... path-variable" ;;
      esac
    done
    shift $((OPTIND-1))
    args=("$@")
    if [ $# -lt 2 ]; then
        _usage "[ -q ] [ -v ] directory ... path-variable"
        return 1
    fi
    [ -z "${!args[-1]}" ] && return 1
    varname="${args[-1]}"
    unset args[-1]
    eval path=('"'${!varname//:/'" "'}'"')
    newpath=${!varname}
    [ -n "$newpath" ] && sep=:
    for arg in "${args[@]}"; do
        argdir=$(realpath --canonicalize-missing "$arg" 2> /dev/null) ||
        argdir=$(readlink --canonicalize-missing "$arg") ||
        argdir=$arg
        for dir in "${path[@]}"; do
            pathdir=$(realpath --canonicalize-missing "$dir" 2> /dev/null) ||
            pathdir=$(readlink --canonicalize-missing "$dir") ||
            pathdir=$dir
            [ "$argdir" = "$pathdir" ] && {
            [ "$verbose" -gt 0 ] && echo "warning: $arg already in $varname ($dir=$pathdir): ${!varname}"
                continue 2
            }
        done
        [ -e "$arg" ] || {
            [ "$quiet" -eq 0 ] && echo "warning: $arg does not exist"
            continue 2
        }
        [ "$verbose" -gt 0 ] && echo "$arg added to $varname"
        newpath="$newpath""$sep""$arg"
        sep=":"
    done
    [ -n "$newpath" ] && export $varname="$newpath"
}

# Insert one or more directories before a specified path
#
# Options:
#   -q  don't print warnings if directory does not exist
#
# Arguments:
#   directory ...
#   variable-name
function inspath() {
    local quiet=0 verbose=0 option OPTIND OPTERR dir arg newpath varname path sep args
    while getopts 'qv' option
    do
      case $option in
        q) let quiet+=1 ;;
        v) let verbose+=1 ;;
        ?) _usage "[ -q ] [ -v ] directory ... path-variable" ;;
      esac
    done
    shift $((OPTIND-1))
    args=("$@")
    if [ $# -lt 2 ]; then
        _usage "[ -q ] [ -v ] directory ... path-variable"
        return 1
    fi
    [ -z "${!args[-1]}" ] && return 1
    varname="${args[-1]}"
    unset args[-1]
    eval path=('"'${!varname//:/'" "'}'"')
    newpath=${!varname}
    [ -n "$newpath" ] && sep=:
    for arg in "${args[@]}"; do
        argdir=$(realpath --canonicalize-missing "$arg" 2> /dev/null) ||
        argdir=$(readlink --canonicalize-missing "$arg") ||
        argdir=$arg
        for dir in "${path[@]}"; do
            pathdir=$(realpath --canonicalize-missing "$dir" 2> /dev/null) ||
            pathdir=$(readlink --canonicalize-missing "$dir") ||
            pathdir=$dir
            [ "$argdir" = "$pathdir" ] && {
                [ "$verbose" -gt 0 ] && echo "warning: $arg already in $varname"
                continue 2
            }
        done
        [ -e "$arg" ] || {
            [ "$quiet" -eq 0 ] && echo "warning: $arg does not exist"
            continue 2
        }
        [ "$verbose" -gt 0 ] && echo "$arg inserted into $varname"
        newpath="$arg""$sep""$newpath"
        sep=":"
    done
    [ -n "$newpath" ] && export $varname="$newpath"
}

# Remove one or more directories from a specified path
#
# Options:
#   -q  don't print warnings if directory does not exist
#
# Arguments:
#   directory ...
#   path variable-name
function rmpath() {
    local quiet=0 verbose=0 option OPTIND OPTERR dir arg newpath varname path sep args
    while getopts 'qv' option
    do
      case $option in
        q) let quiet+=1 ;;
        v) let verbose+=1 ;;
        ?) _usage "[ -q ] [ -v ] directory ... path-variable" ;;
      esac
    done
    shift $((OPTIND-1))
    args=("$@")
    [ -z "${!args[-1]}" ] && return 1
    varname="${args[-1]}"
    unset args[-1]
    eval path=('"'${!varname//:/'" "'}'"')
    for dir in "${path[@]}"; do
        pathdir=$(realpath --canonicalize-missing "$dir" 2> /dev/null) ||
        pathdir=$(readlink --canonicalize-missing "$dir") ||
        pathdir=$dir
        for arg in "${args[@]}"; do
            argdir=$(realpath --canonicalize-missing "$arg" 2> /dev/null) ||
            argdir=$(readlink --canonicalize-missing "$arg") ||
            argdir=$arg
            [ "$argdir" = "$pathdir" ] && {
                [ "$verbose" -gt 0 ] && echo "$arg removed from $varname"
                continue 2
            }
        done
        newpath="$newpath""$sep""$dir"
        sep=":"
    done
    [ -n "$newpath" ] && export $varname="$newpath"
}

# Add various standard subdirectories to their respective paths
#
# Arguments:
#   prefix-dir      the prefix (ie. parent) directory
#   variable-name   shell variable to update
#
# Notes:
#   - ../sbin is only added when UID=0
#   - Due to new brain-damaged MANPATH logic, a : is always appended to MANPATH
function addprefix() {
    local quiet=0 verbose=0 option dir OPTIND OPTERR
    while getopts 'qv' option
    do
      case $option in
        q) let quiet+=1 ;;
        v) let verbose+=1 ;;
        ?) _usage "[ -q ] [ -v ] directory ... path-variable" ;;
      esac
    done
    shift $((OPTIND-1))
    while [ "$#" -gt 0 ]; do
        if [ -d "$1" ]; then
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/bin" PATH
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/games" PATH
            [ "$UID" -eq 0 ] && addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/sbin" PATH
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/lib" LD_LIBRARY_PATH
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/lib/python" PYTHONPATH
            export MANPATH=$(echo ${MANPATH} | sed 's/:\+$//')
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/share/man" MANPATH ||
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/man" MANPATH
            export MANPATH=$MANPATH:
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/info" INFOPATH
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/include" CPATH
            addpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/share" XDG_DATA_DIRS
        else
            [ "$quiet" -eq 0 ] && echo "prefix does not exist or is not a directory: $1"
        fi
        shift
    done
}

# Insert various standard subdirectories in front of their respective paths
#
# Options:
#   -q  don't print warnings if directory does not exist
#
# Arguments:
#   prefix-dir      the prefix (ie. parent) directory
#   variable-name   shell variable to update
#
# Notes:
#   - ../sbin is only added when UID=0
#   - Due to new brain-damaged MANPATH logic, a : is always appended to MANPATH
function insprefix() {
    local quiet=0 verbose=0 option dir OPTIND OPTERR
    while getopts 'qv' option
    do
      case $option in
        q) let quiet+=1 ;;
        v) let verbose+=1 ;;
        ?) _usage "[ -q ] [ -v ] directory ... path-variable"; return 1;;
      esac
    done
    shift $((OPTIND-1))
    while [ "$#" -gt 0 ]; do
        if [ -d "$1" ]; then
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/bin" PATH
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/games" PATH
            [ "$UID" -eq 0 ] && inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/sbin" PATH
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/lib" LD_LIBRARY_PATH
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/lib/python" PYTHONPATH
            export MANPATH=$(echo ${MANPATH} | sed 's/:\+$//')
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/share/man" MANPATH ||
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/man" MANPATH
            export MANPATH=$MANPATH:
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/info" INFOPATH
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/include" CPATH
            inspath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$1/share" XDG_DATA_DIRS
        else
            [ "$quiet" -eq 0 ] && echo "prefix does not exist or is not a directory: $1"
        fi
        shift
    done
}

# Remove directory from standard paths
#
# Options:
#   -q  don't print warnings if directory does not exist
#
# Arguments:
#   prefix-dir      the parent (ie. parent) directory
#   variable-name   shell variable to update
function rmprefix() {
    local quiet=0 verbose=0 option dir OPTIND OPTERR
    while getopts 'qv' option
    do
      case $option in
        q) let quiet+=1 ;;
        v) let verbose+=1 ;;
        ?) _usage "[ -q ] [ -v ] directory ... path-variable"; return 1 ;;
      esac
    done
    shift $((OPTIND-1))
    while [ "$#" -gt 0 ]; do
        dir=$(realpath "$1" 2> /dev/null) ||
        dir=$(readlink --canonicalize-existing "$1" 2> /dev/null)
        if [ -d "$dir" ]; then
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/bin" PATH
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/sbin" PATH
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/games" PATH
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/lib" LD_LIBRARY_PATH
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/lib/python" PYTHONPATH
            export MANPATH=$(echo ${MANPATH} | sed 's/:\+$//')
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/share/man" MANPATH ||
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/man" MANPATH
            export MANPATH=$MANPATH:
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/info" INFOPATH
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/include" CPATH
            rmpath $(yes -- -v | head -n $verbose) $(yes -- -q | head -n $quiet) "$dir/share" XDG_DATA_DIRS
        else
            [ "$quiet" -eq 0 ] && echo "prefix does not exist or is not a directory: $1"
        fi
        shift
    done
}
