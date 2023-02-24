set -e

delimited_prefixes=$(sed 's/ *, */|/g' <<< $1)
if egrep "($delimited_prefixes).*\-beta\-" package.json; then
    echo "ERROR: should not consume a beta version of an internal dependency. Make sure to revert/update to use a proper release."
    exit 1
fi
