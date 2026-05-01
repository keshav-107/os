#!/bin/bash

N=5

philosopher() {
  i=$1
  left=$i
  right=$(( (i + 1) % N ))

  while true; do
    echo "P$i thinking"
    sleep 1

    if [ "$i" -eq $((N-1)) ]; then
      # last philosopher picks right first
      (
        flock -x 200
        flock -x 201
        echo "P$i eating"
        sleep 1
      ) 200>"fork$right" 201>"fork$left"
    else
      (
        flock -x 200
        flock -x 201
        echo "P$i eating"
        sleep 1
      ) 200>"fork$left" 201>"fork$right"
    fi
  done
}

for i in {0..4}; do
  philosopher $i &
done

wait
