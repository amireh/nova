#!/usr/bin/env bash

PATH="$PWD/test/bin:$PATH" exec bb-run "$@" test/targets
