#!/usr/bin/env bash

nova -p ./test/profiles/default | \
  bb-assert "it resolves profile from NOVA_DIR when it's not found from PWD" \
    grep -ic consul
