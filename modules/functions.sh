#!/bin/sh

ICON_CROSS=$(printf '\e[0;31m✘  \e[m')

ROOT_DIR=$(git rev-parse --show-toplevel 2> /dev/null)
HOOKS_DIR=$(dirname $SCRIPT_PATH)

__print_fail() {
    echo "   $ICON_CROSS $1" 1>&2
}

__get_commit_files() {
    echo $(git diff-index --name-only --diff-filter=ACM --cached HEAD --)
}

__get_hotfix_version_bumplevel() {
    if [ -z "$VERSION_BUMPLEVEL_HOTFIX" ]; then
        VERSION_BUMPLEVEL_HOTFIX="PATCH"
    fi

    echo $VERSION_BUMPLEVEL_HOTFIX
}

__get_release_version_bumplevel() {
    if [ -z "$VERSION_BUMPLEVEL_RELEASE" ]; then
        VERSION_BUMPLEVEL_RELEASE="MINOR"
    fi

    echo $VERSION_BUMPLEVEL_RELEASE
}
