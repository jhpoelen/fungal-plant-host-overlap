#!/bin/bash
#
#

datasets="$@"

echo "A | distinct(A) | B | distinct(B) | A ∩ B | distinct (A ∩ B)"
echo "--- | --- | --- | --- | --- | ---"
for x in $datasets
do
  for y in $datasets
  do
    diff --unchanged-group-format='%<' --old-group-format='' --new-group-format=''   --changed-group-format='' output/$x-uniq.txt output/$y-uniq.txt > output/$x-intersect-$y.txt
    echo -en "[$x](output/$x-uniq.txt) | "
    echo -en "$(cat output/$x-uniq.txt | wc -l) | "
    echo -en "[$y](output/$y-uniq.txt) | "
    echo -en "$(cat output/$y-uniq.txt | wc -l) | "
    echo -en "[$x ∩ $y](output/$x-intersect-$y.txt) | "
    echo -en "$(cat output/$x-intersect-$y.txt | wc -l)\n"
  done
done
