# MicrobeNetNet 

Host plant overlap between known plant-fungal datasets as seen from the perspective of GloBI's [name alignment](https://big-bee-network.github.io/name-alignment-workshop/) and data review process (e.g., see the [maarjAM](https://depot.globalbioticinteractions/reviews/globalbioticineractions/maarjam), [fred](https://depot.globalbioticinteractions/fred), [mycoportal](https://depot.globalbioticinteractions/mycoportal), and [usda-fungal-host](https://depot.globalbioticinteractions/usda-fungal-host) review pages).  

Overall strategy: re-use published name alignments, establish overlap between datasets, share distinct taxonomic names per datasets as well as pairwise intersections (or overlap). 


Step 1. Get The GloBI World of Flora Online Alignment Review for each dataset using [fetch.sh](bin/fetch.sh)
```
bin/fetch.sh "maarjam mycoportal usda-fungus-host fred"
```

Step 2. Make a list of all unique taxa using [uniq-resolved-plant-names.sh](bin/uniq-resolved-plant-names.sh)
```
mkdir -p output
ls -1 input/\
 | grep -oE "^[a-z-]+"\
 | parallel "cat input/{1}.tsv.gz | gunzip | bin/uniq-resolved-plant-names.sh > output/{1}-uniq.txt" 
```

Step 3. Calculate pairwise overlap table using [pairwise-overlap.sh](bin/pairwise-overlap.sh)

```
bin/pairwise-overlap.sh $(ls -1 input/ | grep -oE "^[a-z-]+" | tr '\n' ' ')
```

# Preliminary Results


## Pairwise Overlap

A | distinct(A) | B | distinct(B) | A ∩ B | distinct (A ∩ B)
--- | --- | --- | --- | --- | ---
[fred](output/fred-uniq.txt) | 6927 | [fred](output/fred-uniq.txt) | 6927 | [fred ∩ fred](output/fred-intersect-fred.txt) | 6927
[fred](output/fred-uniq.txt) | 6927 | [maarjam](output/maarjam-uniq.txt) | 1217 | [fred ∩ maarjam](output/fred-intersect-maarjam.txt) | 656
[fred](output/fred-uniq.txt) | 6927 | [mycoportal](output/mycoportal-uniq.txt) | 33273 | [fred ∩ mycoportal](output/fred-intersect-mycoportal.txt) | 5062
[fred](output/fred-uniq.txt) | 6927 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [fred ∩ usda-fungus-host](output/fred-intersect-usda-fungus-host.txt) | 5881
[maarjam](output/maarjam-uniq.txt) | 1217 | [fred](output/fred-uniq.txt) | 6927 | [maarjam ∩ fred](output/maarjam-intersect-fred.txt) | 656
[maarjam](output/maarjam-uniq.txt) | 1217 | [maarjam](output/maarjam-uniq.txt) | 1217 | [maarjam ∩ maarjam](output/maarjam-intersect-maarjam.txt) | 1217
[maarjam](output/maarjam-uniq.txt) | 1217 | [mycoportal](output/mycoportal-uniq.txt) | 33273 | [maarjam ∩ mycoportal](output/maarjam-intersect-mycoportal.txt) | 915
[maarjam](output/maarjam-uniq.txt) | 1217 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [maarjam ∩ usda-fungus-host](output/maarjam-intersect-usda-fungus-host.txt) | 974
[mycoportal](output/mycoportal-uniq.txt) | 33273 | [fred](output/fred-uniq.txt) | 6927 | [mycoportal ∩ fred](output/mycoportal-intersect-fred.txt) | 5062
[mycoportal](output/mycoportal-uniq.txt) | 33273 | [maarjam](output/maarjam-uniq.txt) | 1217 | [mycoportal ∩ maarjam](output/mycoportal-intersect-maarjam.txt) | 915
[mycoportal](output/mycoportal-uniq.txt) | 33273 | [mycoportal](output/mycoportal-uniq.txt) | 33273 | [mycoportal ∩ mycoportal](output/mycoportal-intersect-mycoportal.txt) | 33273
[mycoportal](output/mycoportal-uniq.txt) | 33273 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [mycoportal ∩ usda-fungus-host](output/mycoportal-intersect-usda-fungus-host.txt) | 27474
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [fred](output/fred-uniq.txt) | 6927 | [usda-fungus-host ∩ fred](output/usda-fungus-host-intersect-fred.txt) | 5881
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [maarjam](output/maarjam-uniq.txt) | 1217 | [usda-fungus-host ∩ maarjam](output/usda-fungus-host-intersect-maarjam.txt) | 974
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [mycoportal](output/mycoportal-uniq.txt) | 33273 | [usda-fungus-host ∩ mycoportal](output/usda-fungus-host-intersect-mycoportal.txt) | 27474
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48418 | [usda-fungus-host ∩ usda-fungus-host](output/usda-fungus-host-intersect-usda-fungus-host.txt) | 48418


## Intersection Matrix

Another perspective: symmetric matrix overlap in names 

dataset/dataset | maarjam | fred | mycoportal | usda-fungus-host
--- | --- | --- | --- | ---
maarjam | - | 1,217 ∩ 6,927 = 656 | 1,217 ∩ 33,273 = 915 | 1,217 ∩ 48,418 = 974
fred | - | - | 6,927 ∩ 33,273 = 5,062 | 6,927 ∩ 48,418 = 5,881
mycoportal | - | - | - | 33,273 ∩ 48,418 = 27474
usda-fungus-host | - | - | - | -

