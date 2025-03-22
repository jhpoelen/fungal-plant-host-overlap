# MicrobeNetNet Prototype - Common Plant Taxa Across Databases 

:warning: This is a work in progress :warning:

Host plant overlap between known plant-fungal datasets as seen from the perspective of GloBI's [name alignment](https://big-bee-network.github.io/name-alignment-workshop/) and data review process (e.g., see the [maarjAM](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/maarjam), [fred](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/fred), [mycoportal](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/mycoportal), and [usda-fungus-host](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/usda-fungus-host) review pages).  

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
In step 2., all distinct names in the taxonomic hierarchies of resolved names are treated as individual names. E.g., 

```
Angiosperms | Fagales | Fagaceae | Quercus | Quercus  subgen. Quercus | Quercus  sect. Quercus | Quercus alba
Angiosperms | Fagales | Fagaceae | Quercus | Quercus  subgen. Cerris | Quercus  sect. Ilex | Quercus phillyreoides
```

is translated to:

```
Angiosperms
Fagales
Fagaceae
Quercus
Quercus  subgen. Quercus
Quercus  sect. Quercus
Quercus alba 
Quercus  subgen. Cerris
Quercus  sect. Ilex
Quercus phillyreoides
```

which would result in 10 distinct taxonomic names, with overlap in the higher order taxonomic ranks (e.g., Quercus, Fagaceae). 

Step 3. Calculate pairwise overlap table using [pairwise-overlap.sh](bin/pairwise-overlap.sh)

```
bin/pairwise-overlap.sh $(ls -1 input/ | grep -oE "^[a-z-]+" | tr '\n' ' ')
```

# Preliminary Results

## Plant Hostname Intersection Matrix

Another perspective: symmetric matrix overlap in names with notation: 

```
count(distinct(plant taxon names in dataset A)) 
∩ 
count(distinct(plant taxon names in Dataset B))
= 
count(distinct(plant taxon names in both dataset A and dataset B))
```

dataset/dataset | maarjam | fred | mycoportal | usda-fungus-host
--- | --- | --- | --- | ---
maarjam | - | [1,217](output/maarjam-uniq.txt) ∩ [6,927](output/fred-uniq.txt) = [656](output/maarjam-intersect-fred.txt) | [1,217](output/maarjam-uniq.txt) ∩ [33,273](output/mycoportal-uniq.txt) = [915](output/maarjam-intersect-mycoportal.txt) | [1,217](output/maarjam-uniq.txt) ∩ [48,418](output/usda-fungus-host-uniq.txt) = [974](output/maarjam-intersect-usda-fungus-host.txt)
fred | - | - | [6,927](output/fred-uniq.txt) ∩ [33,273](output/mycoportal-uniq.txt) = [5,062](output/fred-intersect-mycoportal.txt) | [6,927](output/fred-uniq.txt) ∩ [48,418](output/usda-fungus-host-uniq.txt) = [5,881](output/fred-intersect-usda-fungus-host.txt)
mycoportal | - | - | - | [33,273](output/mycoportal-uniq.txt) ∩ [48,418](output/usda-fungus-host-uniq.txt) = [27,474](output/mycoportal-intersect-usda-fungus-host.txt)
usda-fungus-host | - | - | - | -

## Pairwise Overlap Plant Hostname 

A | count(A) | B | count(B) | A ∩ B | count(A ∩ B)
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



