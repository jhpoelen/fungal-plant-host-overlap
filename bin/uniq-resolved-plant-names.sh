#!/bin/bash
#
# Take a GloBI Review name alignment tsv file, and list all the distinct taxonomic names.
#
# example: 
#   curl -L "https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/mycoportal/resolved-indexed-names-resolved-wfo.tsv.gz\
#   | gunzip\
#   | bash uniq_resolved_plant_names.sh
#
# with example output:
# 
# Aa
# Abelia grandiflora
# Abelmoschus
# Abelmoschus esculentus
# Abelmoschus manihot
# Abelmoschus moschatus
# Abies
# Abies alba
# Abies amabilis
# Abies balsamea


mlr --tsvlite cut -f resolvedPath\
 | tail -n+2\
 | tr '|' '\n'\
 | grep -v Fungi\
 | grep -v NONE\
 | grep -v HAS_UNCHECKED_NAME\
 | sed -E 's/^[ ]+//g'\
 | sed -E 's/[ ]+$//g'\
 | sed '/^$/d'\
 | sort\
 | uniq
