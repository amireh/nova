#!/usr/bin/env bash

nova --debug -p test/profiles/default 2>&1 | \
  bb-assert 'it prints diagnostics' \
    grep -F 'nova: evaluating CONSUL_HTTP_ADDR'
