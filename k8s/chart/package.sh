#!/usr/bin/env bash

i=0
directories=()

add(){
  directories[$i]=$1
  let i++
}

for item in $(ls .); do
  if test -d ${item}; then
    add ${item}
  fi
done

for d in ${directories[@]}; do
  helm package ${d}
done
