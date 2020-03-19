#!/usr/bin/env bash

PATH="$PWD/bin:$PWD/test/bin:$PATH" bb-run "$@" ./test/{src,targets}
