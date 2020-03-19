#!/usr/bin/env bash

(cd test/profiles/novarc-rel/src && nova --no-rc) 2>&1 | \
  bb-assert 'it ignores .novarc when --no-rc is specified' \
    grep -F 'nova: no profile specified'
