#!/bin/bash

# holes (memory blocks)
holes=(100 500 200 300 600)

# processes
procs=(212 417 112 426)

for ((i=0; i<${#procs[@]}; i++)); do
  idx=-1
  best=999999

  # find smallest suitable hole
  for ((j=0; j<${#holes[@]}; j++)); do
    if [ ${holes[j]} -ge ${procs[i]} ]; then
      if [ ${holes[j]} -lt $best ]; then
        best=${holes[j]}
        idx=$j
      fi
    fi
  done

  if [ $idx -ne -1 ]; then
    echo "Process ${procs[i]} -> Hole $idx"

    holes[$idx]=$((holes[$idx] - procs[i]))
  else
    echo "Process ${procs[i]} -> Not Allocated"
  fi
done
