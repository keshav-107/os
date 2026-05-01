#!/bin/bash

pages=(7 0 1 2 0 3 0 4)
frame_size=3

frames=()

for p in "${pages[@]}"; do
  found=0

  # check if page already in frame
  for i in "${!frames[@]}"; do
    if [ "${frames[$i]}" -eq "$p" ]; then
      unset 'frames[$i]'
      frames=("${frames[@]}")   # re-pack array
      frames+=("$p")            # move to most recent
      found=1
      break
    fi
  done

  if [ $found -eq 0 ]; then
    # page fault
    if [ "${#frames[@]}" -eq "$frame_size" ]; then
      unset 'frames[0]'         # remove least recently used
      frames=("${frames[@]}")
    fi
    frames+=("$p")
    echo "Fault: $p"
  else
    echo "Hit: $p"
  fi

  echo "Frames: ${frames[@]}"
done
