#!/usr/bin/env bash

CONSUL_HTTP_ADDR='blah' nova -p test/profiles/default env |
  bb-assert 'it inherits variables' \
    grep -Eq '^CONSUL_HTTP_ADDR=blah'
