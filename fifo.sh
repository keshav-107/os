#!/bin/bash

pages=(7 0 1 2 0 3 0 4)
frame_size=3

frames=()

for p in "${pages[@]}"; do
  found=0

  # check hit
  for f in "${frames[@]}"; do
    if [ "$f" -eq "$p" ]; then
      found=1
      break
    fi
  done

  if [ $found -eq 0 ]; then
    if [ "${#frames[@]}" -eq "$frame_size" ]; then
      frames=("${frames[@]:1}")   # remove oldest (front)
    fi
    frames+=("$p")
    echo "Fault: $p"
  else
    echo "Hit: $p"
  fi

  echo "Frames: ${frames[@]}"
done
