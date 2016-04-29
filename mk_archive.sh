#!/bin/bash -e
####################################

VERSION=snapshot
STAGING=staging
git archive --format=tar --prefix=breakpad-$VERSION/ HEAD | (mkdir -p "$STAGING" && cd "$STAGING" && tar xf -)
cd "$STAGING"
git clone https://chromium.googlesource.com/linux-syscall-support breakpad-$VERSION/src/google_breakpad/third_party/lss
tar czvf breakpad-$VERSION.tar.gz breakpad-$VERSION/
