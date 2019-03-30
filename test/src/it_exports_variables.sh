#!/usr/bin/env bash

nova -p test/profiles/default env |
  bb-assert "it exports variables" \
    grep -c "CONSUL_HTTP_ADDR"
