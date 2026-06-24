#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "ERROR: expected one file path" >&2
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "ERROR: file does not exist: $1" >&2
  exit 1
fi

shasum -a 256 "$1" | awk '{print $1}'

