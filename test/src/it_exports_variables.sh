#!/usr/bin/env bash

nova -p test/profiles/default --export |
  bb-assert "it exports variables" \
    grep -Eq "^export CONSUL_HTTP_ADDR=http://localhost:8500$"
