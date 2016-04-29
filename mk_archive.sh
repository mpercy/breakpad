#!/bin/bash -e
####################################

VERSION=snapshot
STAGING=staging
rm -rf "$STAGING"
git archive --format=tar --prefix=breakpad-$VERSION/ HEAD | (mkdir -p "$STAGING" && cd "$STAGING" && tar xf -)
pushd "$STAGING"
git clone https://chromium.googlesource.com/linux-syscall-support breakpad-$VERSION/src/google_breakpad/third_party/lss
FILE="breakpad-$VERSION.tar.gz"
tar czvf "$FILE" breakpad-$VERSION/
mv "$FILE" ..
popd
echo "Archive created at $(pwd)/$FILE"

exit 0
