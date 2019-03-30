#!/usr/bin/env bash

echo hi | \
  nova -p test/profiles/with-read | \
    bb-assert 'it forwards stdin' grep 'PASSWORD=hi'