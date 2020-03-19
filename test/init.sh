#!/usr/bin/env bash

PATH="$PWD/bin:$PWD/test/bin:$PATH" exec bb-run "$@" test/src
