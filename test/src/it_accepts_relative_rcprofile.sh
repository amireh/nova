#!/usr/bin/env bash

(cd test/profiles/novarc-rel/src && nova) | \
  bb-assert 'it resolves tthe profile relative to .novarc dir' \
    grep -ic consul
