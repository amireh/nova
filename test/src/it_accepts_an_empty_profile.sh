#!/usr/bin/env bash

nova -p ./test/profiles/empty || {
  bb-assert 'it complains on empty profile' false
}
