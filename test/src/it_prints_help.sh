#!/usr/bin/env bash

nova -h | \
  bb-assert 'it prints the help listing' \
    grep -F 'usage: nova [options] [--] [program...]'
