#!/usr/bin/env bash

nova -p foo/bar/baz 2>&1 | \
  bb-assert 'it bails when the specified profile is not a thing' \
    grep -F 'nova: profile not found -- foo/bar/baz'
