#!/usr/bin/env bash

echo hi | \
  nova -p test/profiles/with-stdin | \
    bb-assert 'it forwards stdin' grep 'PASSWORD=hi'