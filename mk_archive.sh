#!/bin/bash -e
####################################

REVISION=HEAD
VERSION=$(git rev-parse $REVISION)
STAGING=staging
NAME=breakpad-$VERSION
PREFIX=$STAGING/$NAME
FILENAME="$NAME.tar.gz"

rm -rf "$STAGING"
git archive --format=tar --prefix=$PREFIX/ $REVISION | tar xf -
git archive --format=tar --prefix=$PREFIX/src/google_breakpad/third_party/lss --remote=https://chromium.googlesource.com/linux-syscall-support | tar xf -

pushd "$STAGING"
tar czvf "$FILENAME" "$NAME/"
mv "$FILE" ..
popd
echo "Archive created at $(pwd)/$FILE"

exit 0
