#!/bin/sh

docker run --rm -it -v "$PWD":/mnt:ro -w /mnt bash:5 ./test/init.sh
