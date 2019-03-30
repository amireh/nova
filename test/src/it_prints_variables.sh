#!/usr/bin/env bash

nova -p test/profiles/default | bb-assert 'it prints variables' grep -ic consul
