#!/bin/bash

LOCK="rw.lock"

reader() {
  (
    flock -s 200   # shared lock
    echo "Reader $$ reading"
    sleep 1
  ) 200>"$LOCK"
}

writer() {
  (
    flock -x 200   # exclusive lock
    echo "Writer $$ writing"
    sleep 2
  ) 200>"$LOCK"
}

# run some processes
writer &
reader &
reader &
writer &
reader &

wait
