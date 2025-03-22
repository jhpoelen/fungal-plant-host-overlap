#!/bin/bash
#
#

datasets="$@"

echo "A | B | A ∩ B"
echo "--- | --- | ---"
for x in $datasets
do
  for y in $datasets
  do
    diff --unchanged-group-format='%<' --old-group-format='' --new-group-format=''   --changed-group-format='' output/$x-uniq.txt output/$y-uniq.txt > output/$x-intersect-$y.txt
    echo -en "[$x $(cat output/$x-uniq.txt | wc -l)](output/$x-uniq.txt) | "
    echo -en "[$y $(cat output/$y-uniq.txt | wc -l)](output/$y-uniq.txt) | "
    echo -en "[$x ∩ $y $(cat output/$x-intersect-$y.txt | wc -l)](output/$x-intersect-$y.txt)\n"
  done
done
