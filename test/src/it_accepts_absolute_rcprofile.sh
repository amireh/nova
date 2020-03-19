#!/usr/bin/env bash

export NOVA_DIR="$PWD"

(cd test/profiles/novarc-abs/src && nova) | \
  bb-assert 'it uses an absolute profile path' \
    grep -ic consul
