#!/bin/bash

count=1
for file in *; do
  if [ -f "$file" ]; then
    mv "$file" "$(printf "%02d" $count)-$file"
    count=$((count + 1))
  fi
done

