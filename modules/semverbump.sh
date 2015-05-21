#!/bin/sh

__print_usage() {
    echo "Usage: $(basename $0) [major|minor|patch|<semver>]"
    echo "    major|minor|patch: Version will be bumped accordingly."
    echo "    <semver>:          Exact version to use (it won't be bumped)."
    exit 1
}

__print_version() {
    echo $VERSION_BUMPED
    exit 0
}

# parse arguments

if [ $# -gt 2 ]; then
    __print_usage
fi

VERSION_ARG=$(echo "$1" | tr '[:lower:]' '[:upper:]')

if [ -z "$VERSION_ARG" ] || [ "$VERSION_ARG" == "PATCH" ]; then
    VERSION_UPDATE_MODE="PATCH"
elif [ "$VERSION_ARG" == "MINOR" ]; then
    VERSION_UPDATE_MODE=$VERSION_ARG
elif [ "$VERSION_ARG" == "MAJOR" ]; then
    VERSION_UPDATE_MODE=$VERSION_ARG
elif [ $(echo "$VERSION_ARG" | grep -E '^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$') ]; then
    # semantic version passed as argument
    VERSION_BUMPED=$VERSION_ARG
    __print_version
else
    __print_usage
fi

# read git tags

VERSION_PREFIX=$(git config --get gitflow.prefix.versiontag)
VERSION_TAG=$(git tag -l "$VERSION_PREFIX*" | sort -n -t. -k1,1 -k2,2 -k3,3 -k4,4 | tail -1)

if [ ! -z "$VERSION_TAG" ]; then
    if [ ! -z "$VERSION_PREFIX" ]; then
        VERSION_CURRENT=${VERSION_TAG#$VERSION_PREFIX}
    else
        VERSION_CURRENT=$VERSION_TAG
    fi
fi

# default semver 0.1.0
if [ -z "$VERSION_CURRENT" ]; then
    VERSION_CURRENT="0.0.0"
fi

# bump version

VERSION_MAJOR=$(echo "$VERSION_CURRENT" | cut -d'.' -f1)
VERSION_MINOR=$(echo "$VERSION_CURRENT" | cut -d'.' -f2)
VERSION_PATCH=$(echo "$VERSION_CURRENT" | cut -d'.' -f3)

if [ "$VERSION_UPDATE_MODE" == "PATCH" ]; then
    VERSION_PATCH=$((VERSION_PATCH + 1))
elif [ "$VERSION_UPDATE_MODE" == "MINOR" ]; then
    VERSION_MINOR=$((VERSION_MINOR + 1))
    VERSION_PATCH=0
else
    VERSION_MAJOR=$((VERSION_MAJOR + 1))
    VERSION_MINOR=0
    VERSION_PATCH=0
fi

VERSION_BUMPED="$VERSION_MAJOR.$VERSION_MINOR.$VERSION_PATCH"

__print_version
