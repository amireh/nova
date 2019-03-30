#!/usr/bin/env bash

export PATH="$PWD/bin:$PATH"

nova -p test/profiles/default || exit $?
nova -p test/profiles/default env | grep -i consul || exit $?
nova -p test/profiles/custom-interpreter | grep 'XXX=hi' || exit $?
echo hi | nova -p test/profiles/with-read | grep 'PASSWORD=hi' || exit $?

echo "nova-test: ok" 1>&2