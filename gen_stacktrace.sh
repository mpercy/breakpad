#!/bin/bash -xe
#########################################
if [ -z "$2" ]; then
  echo "Usage: $0 <executable> <minidump>"
  exit 1
fi
ROOT=$(cd $(dirname $0); pwd)
EXE=$1
NAME=$(basename $EXE)
MINIDUMP=$2
SYMS="$EXE.sym"
$ROOT/src/tools/linux/dump_syms/dump_syms "$EXE" > "$SYMS"
ID=$(head -n1 "$SYMS" | awk '{print $4}')
if [ -z "$ID" ]; then
  echo "ID not found in symbols file"
  exit 1
fi
mkdir -p ./symbols/$NAME/$ID
mv "$SYMS" ./symbols/$NAME/$ID/
$ROOT/src/google_breakpad/processor/minidump_stackwalk "$MINIDUMP" ./symbols
