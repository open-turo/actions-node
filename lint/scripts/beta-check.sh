set -e

if egrep "$1.*\-beta\-" package.json; then
    echo "ERROR: should not consume a beta version of an internal dependency. Make sure to revert/update to use a proper release."
    exit 1
fi
