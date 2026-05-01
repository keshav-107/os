#!/bin/bash

pages=(7 0 1 2 0 3 0 4)
frame_size=3

frames=()

for p in "${pages[@]}"; do
  found=0

  # check hit
  for i in "${!frames[@]}"; do
    if [ "${frames[$i]}" -eq "$p" ]; then
      unset 'frames[$i]'
      frames=("${frames[@]}")
      frames+=("$p")   # move to most recent
      found=1
      break
    fi
  done

  if [ $found -eq 0 ]; then
    if [ "${#frames[@]}" -eq "$frame_size" ]; then
      unset 'frames[$((${#frames[@]}-1))]'  # remove most recently used
      frames=("${frames[@]}")
    fi
    frames+=("$p")
    echo "Fault: $p"
  else
    echo "Hit: $p"
  fi

  echo "Frames: ${frames[@]}"
done
