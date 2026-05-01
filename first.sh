#!/bin/bash

# holes (memory blocks)
holes=(100 500 200 300 600)

# processes
procs=(212 417 112 426)

for ((i=0; i<${#procs[@]}; i++)); do
  allocated=0

  for ((j=0; j<${#holes[@]}; j++)); do
    if [ ${holes[j]} -ge ${procs[i]} ]; then
      echo "Process ${procs[i]} -> Hole $j"

      holes[j]=$((holes[j] - procs[i]))  # reduce hole size
      allocated=1
      break
    fi
  done

  if [ $allocated -eq 0 ]; then
    echo "Process ${procs[i]} -> Not Allocated"
  fi
done
