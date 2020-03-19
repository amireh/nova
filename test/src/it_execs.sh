#!/usr/bin/env bash

nova -p test/profiles/default -- sh -c 'echo "MY_VAR=$CONSUL_HTTP_ADDR"' | \
  bb-assert 'it execs an arbitrary command' \
    grep -F 'MY_VAR=http://localhost:8500'
