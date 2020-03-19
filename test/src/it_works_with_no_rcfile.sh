#!/usr/bin/env bash

nova && {
  echo "should have failed!"
  exit 1
}

exit 0
