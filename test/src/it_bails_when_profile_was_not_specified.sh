#!/usr/bin/env bash

nova 2>&1 | \
  bb-assert 'it bails when profile was not specified' \
    grep -F 'nova: no profile specified'
