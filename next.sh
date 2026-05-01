#!/bin/bash

# holes (memory blocks)
holes=(100 500 200 300 600)

# processes
procs=(212 417 112 426)

start=0   # keeps track of last allocation position

for ((i=0; i<${#procs[@]}; i++)); do
  allocated=0
  j=$start

  for ((k=0; k<${#holes[@]}; k++)); do
    idx=$(( (j + k) % ${#holes[@]} ))

    if [ ${holes[$idx]} -ge ${procs[$i]} ]; then
      echo "Process ${procs[$i]} -> Hole $idx"

      holes[$idx]=$((holes[$idx] - procs[$i]))
      start=$idx   # update next start position
      allocated=1
      break
    fi
  done

  if [ $allocated -eq 0 ]; then
    echo "Process ${procs[$i]} -> Not Allocated"
  fi
done
