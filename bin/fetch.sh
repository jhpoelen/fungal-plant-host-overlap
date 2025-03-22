#!/bin/bash
#
#

set -x

TAXONOMY=wfo

mkdir -p input

for x in $@
do 
  curl "https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/$x/indexed-names-resolved-${TAXONOMY}.tsv.gz" > "input/$x.tsv.gz"
done
