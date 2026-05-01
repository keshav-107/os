#!/bin/bash

BUFFER="buffer.txt"
LOCK="lock.file"

> "$BUFFER"   # empty buffer

producer() {
  for i in {1..5}; do
    (
      flock -x 200
      echo "item $i" >> "$BUFFER"
      echo "Produced item $i"
    ) 200>"$LOCK"
    sleep 1
  done
}

consumer() {
  for i in {1..5}; do
    (
      flock -x 200
      item=$(head -n 1 "$BUFFER")
      sed -i '1d' "$BUFFER"
      echo "Consumed $item"
    ) 200>"$LOCK"
    sleep 2
  done
}

producer &
consumer &

wait
