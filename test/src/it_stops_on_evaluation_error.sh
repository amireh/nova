#!/usr/bin/env bash

nova -p test/profiles/death 2>&1 |
  bb-assert 'it stops when a variable could not be evaluated' \
    grep -F 'nova: unable to evaluate XXX'
