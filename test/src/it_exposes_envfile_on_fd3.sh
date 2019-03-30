#!/usr/bin/env bash

read -r lines < <(
  nova -p test/profiles/default \
    sh -c 'cat /dev/fd/3 ; cat /dev/fd/3' | grep -c 'CONSUL_HTTP_ADDR'
)

bb-assert 'reading does not exhaust /dev/fd/3' \
  test "$lines" -eq 2
