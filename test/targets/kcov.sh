#!/bin/sh

docker run --rm -it \
  -v "$PWD":/mnt:ro \
  -v "$PWD"/build:/build \
  -w /mnt \
  -u "$(id -u)":"$(id -g)" \
  kcov/kcov \
    kcov --clean --include-path="bin/nova" /build/coverage ./test/init.sh
