#!/bin/sh
# like chmod -Rf a+rX

if test -z "$1" ; then
	DIR="."
else
	DIR="$1"
fi

find "$DIR" -type f -executable -print0 | xargs --null -i chmod 644 {}

