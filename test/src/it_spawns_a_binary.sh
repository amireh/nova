#!/usr/bin/env bash

nova -p test/profiles/custom-interpreter | grep 'XXX=hi'
