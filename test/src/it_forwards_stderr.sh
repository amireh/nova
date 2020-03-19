#!/usr/bin/env bash

nova -p test/profiles/with-stderr 2>&1 1>/dev/null | \
  bb-assert 'it forwards stderr' \
    grep 'generating VAR'
