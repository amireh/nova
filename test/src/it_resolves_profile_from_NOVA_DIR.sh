#!/usr/bin/env bash

export NOVA_DIR="$PWD/test/profiles"

nova -p default | \
  bb-assert "it resolves profile from NOVA_DIR when it's not found from PWD" \
    grep -ic consul
