#!/bin/sh

docker run --rm -it -v "$PWD":/mnt:ro -w /mnt bash:4 ./test/init.sh
