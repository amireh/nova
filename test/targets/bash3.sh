#!/bin/sh

docker run --rm -it -v "$PWD":/mnt:ro -w /mnt bash:3 ./test/init.sh
