#!/usr/bin/env bash

nova -p test/profiles/default env |
  bb-assert "it exports variables" \
    grep -Eq "^CONSUL_HTTP_ADDR=http://localhost:8500"
