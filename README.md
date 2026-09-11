# MicrobeNetNet Prototype - Common Plant Taxa Across Databases 

:warning: This is a work in progress :warning:

Host plant overlap between known plant-fungal datasets as seen from the perspective of GloBI's [name alignment](https://big-bee-network.github.io/name-alignment-workshop/) and data review process (e.g., see the [maarjAM](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/maarjam), [fred](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/fred), [mycoportal](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/mycoportal), and [usda-fungus-host](https://depot.globalbioticinteractions.org/reviews/globalbioticinteractions/usda-fungus-host) review pages).  

Overall strategy: re-use published name alignments, establish overlap between datasets, share distinct taxonomic names per datasets as well as pairwise intersections (or overlap). 

Outcome of discussions in afternoon session of MicrobeNet^Net Colloquium 2025-03-22 with participants (in alphabetical order by first name) - Aimee Classen, Jorrit Poelen, Luke McCormack, Maarja Öpik, Martin Nunez. (Note: results updated with MN^N related datasets on 2026-09-10, see change history for specifics). 

Step 1. Get The GloBI World of Flora Online Alignment Review for each dataset using [fetch.sh](bin/fetch.sh)
```
bin/fetch.sh "maarjam fred globalfungi globalamfungi maps mycodb mycoportal usda-fungus-host unite policelli2023 pdd icmp limbu2025 fungaltraits austraits funfun souza2025 stewartBisot2026 usda-ars-culture-collection-nrrl"
```

Step 2. Make a list of all unique taxa using [uniq-resolved-plant-names.sh](bin/uniq-resolved-plant-names.sh)
```
mkdir -p output
ls -1 input/\
 | grep -oE "^[a-z0-9-]+"\
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
bin/pairwise-overlap.sh $(ls -1 input/ | grep -oE "^[a-zA-Z0-9-]+" | tr '\n' ' ')
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

## Pairwise Overlap Plant Hostname 

A | count(A) | B | count(B) | A ∩ B | count(A ∩ B)
--- | --- | --- | --- | --- | ---
[austraits](output/austraits-uniq.txt) | 9030 | [austraits](output/austraits-uniq.txt) | 9030 | [austraits ∩ austraits](output/austraits-intersect-austraits.txt) | 9030
[austraits](output/austraits-uniq.txt) | 9030 | [fred](output/fred-uniq.txt) | 6953 | [austraits ∩ fred](output/austraits-intersect-fred.txt) | 821
[austraits](output/austraits-uniq.txt) | 9030 | [funfun](output/funfun-uniq.txt) | 33 | [austraits ∩ funfun](output/austraits-intersect-funfun.txt) | 33
[austraits](output/austraits-uniq.txt) | 9030 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [austraits ∩ fungaltraits](output/austraits-intersect-fungaltraits.txt) | 594
[austraits](output/austraits-uniq.txt) | 9030 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [austraits ∩ globalamfungi](output/austraits-intersect-globalamfungi.txt) | 330
[austraits](output/austraits-uniq.txt) | 9030 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [austraits ∩ globalfungi](output/austraits-intersect-globalfungi.txt) | 472
[austraits](output/austraits-uniq.txt) | 9030 | [icmp](output/icmp-uniq.txt) | 123 | [austraits ∩ icmp](output/austraits-intersect-icmp.txt) | 68
[austraits](output/austraits-uniq.txt) | 9030 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [austraits ∩ limbu2025](output/austraits-intersect-limbu2025.txt) | 561
[austraits](output/austraits-uniq.txt) | 9030 | [maarjam](output/maarjam-uniq.txt) | 1294 | [austraits ∩ maarjam](output/austraits-intersect-maarjam.txt) | 345
[austraits](output/austraits-uniq.txt) | 9030 | [maps](output/maps-uniq.txt) | 2167 | [austraits ∩ maps](output/austraits-intersect-maps.txt) | 410
[austraits](output/austraits-uniq.txt) | 9030 | [mycodb](output/mycodb-uniq.txt) | 604 | [austraits ∩ mycodb](output/austraits-intersect-mycodb.txt) | 155
[austraits](output/austraits-uniq.txt) | 9030 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [austraits ∩ mycoportal](output/austraits-intersect-mycoportal.txt) | 2041
[austraits](output/austraits-uniq.txt) | 9030 | [pdd](output/pdd-uniq.txt) | 349 | [austraits ∩ pdd](output/austraits-intersect-pdd.txt) | 197
[austraits](output/austraits-uniq.txt) | 9030 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [austraits ∩ policelli2023](output/austraits-intersect-policelli2023.txt) | 1
[austraits](output/austraits-uniq.txt) | 9030 | [souza2025](output/souza2025-uniq.txt) | 364 | [austraits ∩ souza2025](output/austraits-intersect-souza2025.txt) | 144
[austraits](output/austraits-uniq.txt) | 9030 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [austraits ∩ stewartBisot2026](output/austraits-intersect-stewartBisot2026.txt) | 140
[austraits](output/austraits-uniq.txt) | 9030 | [unite](output/unite-uniq.txt) | 3006 | [austraits ∩ unite](output/austraits-intersect-unite.txt) | 585
[austraits](output/austraits-uniq.txt) | 9030 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [austraits ∩ usda-ars-culture-collection-nrrl](output/austraits-intersect-usda-ars-culture-collection-nrrl.txt) | 225
[austraits](output/austraits-uniq.txt) | 9030 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [austraits ∩ usda-fungus-host](output/austraits-intersect-usda-fungus-host.txt) | 3205
[fred](output/fred-uniq.txt) | 6953 | [austraits](output/austraits-uniq.txt) | 9030 | [fred ∩ austraits](output/fred-intersect-austraits.txt) | 821
[fred](output/fred-uniq.txt) | 6953 | [fred](output/fred-uniq.txt) | 6953 | [fred ∩ fred](output/fred-intersect-fred.txt) | 6953
[fred](output/fred-uniq.txt) | 6953 | [funfun](output/funfun-uniq.txt) | 33 | [fred ∩ funfun](output/fred-intersect-funfun.txt) | 31
[fred](output/fred-uniq.txt) | 6953 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [fred ∩ fungaltraits](output/fred-intersect-fungaltraits.txt) | 1422
[fred](output/fred-uniq.txt) | 6953 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [fred ∩ globalamfungi](output/fred-intersect-globalamfungi.txt) | 737
[fred](output/fred-uniq.txt) | 6953 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [fred ∩ globalfungi](output/fred-intersect-globalfungi.txt) | 1070
[fred](output/fred-uniq.txt) | 6953 | [icmp](output/icmp-uniq.txt) | 123 | [fred ∩ icmp](output/fred-intersect-icmp.txt) | 90
[fred](output/fred-uniq.txt) | 6953 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [fred ∩ limbu2025](output/fred-intersect-limbu2025.txt) | 1378
[fred](output/fred-uniq.txt) | 6953 | [maarjam](output/maarjam-uniq.txt) | 1294 | [fred ∩ maarjam](output/fred-intersect-maarjam.txt) | 685
[fred](output/fred-uniq.txt) | 6953 | [maps](output/maps-uniq.txt) | 2167 | [fred ∩ maps](output/fred-intersect-maps.txt) | 1101
[fred](output/fred-uniq.txt) | 6953 | [mycodb](output/mycodb-uniq.txt) | 604 | [fred ∩ mycodb](output/fred-intersect-mycodb.txt) | 438
[fred](output/fred-uniq.txt) | 6953 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [fred ∩ mycoportal](output/fred-intersect-mycoportal.txt) | 5120
[fred](output/fred-uniq.txt) | 6953 | [pdd](output/pdd-uniq.txt) | 349 | [fred ∩ pdd](output/fred-intersect-pdd.txt) | 253
[fred](output/fred-uniq.txt) | 6953 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [fred ∩ policelli2023](output/fred-intersect-policelli2023.txt) | 20
[fred](output/fred-uniq.txt) | 6953 | [souza2025](output/souza2025-uniq.txt) | 364 | [fred ∩ souza2025](output/fred-intersect-souza2025.txt) | 265
[fred](output/fred-uniq.txt) | 6953 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [fred ∩ stewartBisot2026](output/fred-intersect-stewartBisot2026.txt) | 349
[fred](output/fred-uniq.txt) | 6953 | [unite](output/unite-uniq.txt) | 3006 | [fred ∩ unite](output/fred-intersect-unite.txt) | 1402
[fred](output/fred-uniq.txt) | 6953 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [fred ∩ usda-ars-culture-collection-nrrl](output/fred-intersect-usda-ars-culture-collection-nrrl.txt) | 429
[fred](output/fred-uniq.txt) | 6953 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [fred ∩ usda-fungus-host](output/fred-intersect-usda-fungus-host.txt) | 5906
[funfun](output/funfun-uniq.txt) | 33 | [austraits](output/austraits-uniq.txt) | 9030 | [funfun ∩ austraits](output/funfun-intersect-austraits.txt) | 33
[funfun](output/funfun-uniq.txt) | 33 | [fred](output/fred-uniq.txt) | 6953 | [funfun ∩ fred](output/funfun-intersect-fred.txt) | 31
[funfun](output/funfun-uniq.txt) | 33 | [funfun](output/funfun-uniq.txt) | 33 | [funfun ∩ funfun](output/funfun-intersect-funfun.txt) | 33
[funfun](output/funfun-uniq.txt) | 33 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [funfun ∩ fungaltraits](output/funfun-intersect-fungaltraits.txt) | 30
[funfun](output/funfun-uniq.txt) | 33 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [funfun ∩ globalamfungi](output/funfun-intersect-globalamfungi.txt) | 29
[funfun](output/funfun-uniq.txt) | 33 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [funfun ∩ globalfungi](output/funfun-intersect-globalfungi.txt) | 29
[funfun](output/funfun-uniq.txt) | 33 | [icmp](output/icmp-uniq.txt) | 123 | [funfun ∩ icmp](output/funfun-intersect-icmp.txt) | 14
[funfun](output/funfun-uniq.txt) | 33 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [funfun ∩ limbu2025](output/funfun-intersect-limbu2025.txt) | 32
[funfun](output/funfun-uniq.txt) | 33 | [maarjam](output/maarjam-uniq.txt) | 1294 | [funfun ∩ maarjam](output/funfun-intersect-maarjam.txt) | 30
[funfun](output/funfun-uniq.txt) | 33 | [maps](output/maps-uniq.txt) | 2167 | [funfun ∩ maps](output/funfun-intersect-maps.txt) | 31
[funfun](output/funfun-uniq.txt) | 33 | [mycodb](output/mycodb-uniq.txt) | 604 | [funfun ∩ mycodb](output/funfun-intersect-mycodb.txt) | 23
[funfun](output/funfun-uniq.txt) | 33 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [funfun ∩ mycoportal](output/funfun-intersect-mycoportal.txt) | 33
[funfun](output/funfun-uniq.txt) | 33 | [pdd](output/pdd-uniq.txt) | 349 | [funfun ∩ pdd](output/funfun-intersect-pdd.txt) | 25
[funfun](output/funfun-uniq.txt) | 33 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [funfun ∩ policelli2023](output/funfun-intersect-policelli2023.txt) | 0
[funfun](output/funfun-uniq.txt) | 33 | [souza2025](output/souza2025-uniq.txt) | 364 | [funfun ∩ souza2025](output/funfun-intersect-souza2025.txt) | 27
[funfun](output/funfun-uniq.txt) | 33 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [funfun ∩ stewartBisot2026](output/funfun-intersect-stewartBisot2026.txt) | 22
[funfun](output/funfun-uniq.txt) | 33 | [unite](output/unite-uniq.txt) | 3006 | [funfun ∩ unite](output/funfun-intersect-unite.txt) | 31
[funfun](output/funfun-uniq.txt) | 33 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [funfun ∩ usda-ars-culture-collection-nrrl](output/funfun-intersect-usda-ars-culture-collection-nrrl.txt) | 28
[funfun](output/funfun-uniq.txt) | 33 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [funfun ∩ usda-fungus-host](output/funfun-intersect-usda-fungus-host.txt) | 33
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [austraits](output/austraits-uniq.txt) | 9030 | [fungaltraits ∩ austraits](output/fungaltraits-intersect-austraits.txt) | 594
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [fred](output/fred-uniq.txt) | 6953 | [fungaltraits ∩ fred](output/fungaltraits-intersect-fred.txt) | 1422
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [funfun](output/funfun-uniq.txt) | 33 | [fungaltraits ∩ funfun](output/fungaltraits-intersect-funfun.txt) | 30
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [fungaltraits ∩ fungaltraits](output/fungaltraits-intersect-fungaltraits.txt) | 2612
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [fungaltraits ∩ globalamfungi](output/fungaltraits-intersect-globalamfungi.txt) | 485
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [fungaltraits ∩ globalfungi](output/fungaltraits-intersect-globalfungi.txt) | 778
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [icmp](output/icmp-uniq.txt) | 123 | [fungaltraits ∩ icmp](output/fungaltraits-intersect-icmp.txt) | 91
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [fungaltraits ∩ limbu2025](output/fungaltraits-intersect-limbu2025.txt) | 877
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [maarjam](output/maarjam-uniq.txt) | 1294 | [fungaltraits ∩ maarjam](output/fungaltraits-intersect-maarjam.txt) | 514
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [maps](output/maps-uniq.txt) | 2167 | [fungaltraits ∩ maps](output/fungaltraits-intersect-maps.txt) | 862
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [mycodb](output/mycodb-uniq.txt) | 604 | [fungaltraits ∩ mycodb](output/fungaltraits-intersect-mycodb.txt) | 358
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [fungaltraits ∩ mycoportal](output/fungaltraits-intersect-mycoportal.txt) | 2306
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [pdd](output/pdd-uniq.txt) | 349 | [fungaltraits ∩ pdd](output/fungaltraits-intersect-pdd.txt) | 208
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [fungaltraits ∩ policelli2023](output/fungaltraits-intersect-policelli2023.txt) | 18
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [souza2025](output/souza2025-uniq.txt) | 364 | [fungaltraits ∩ souza2025](output/fungaltraits-intersect-souza2025.txt) | 232
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [fungaltraits ∩ stewartBisot2026](output/fungaltraits-intersect-stewartBisot2026.txt) | 266
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [unite](output/unite-uniq.txt) | 3006 | [fungaltraits ∩ unite](output/fungaltraits-intersect-unite.txt) | 1206
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [fungaltraits ∩ usda-ars-culture-collection-nrrl](output/fungaltraits-intersect-usda-ars-culture-collection-nrrl.txt) | 441
[fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [fungaltraits ∩ usda-fungus-host](output/fungaltraits-intersect-usda-fungus-host.txt) | 2509
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [austraits](output/austraits-uniq.txt) | 9030 | [globalamfungi ∩ austraits](output/globalamfungi-intersect-austraits.txt) | 330
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [fred](output/fred-uniq.txt) | 6953 | [globalamfungi ∩ fred](output/globalamfungi-intersect-fred.txt) | 737
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [funfun](output/funfun-uniq.txt) | 33 | [globalamfungi ∩ funfun](output/globalamfungi-intersect-funfun.txt) | 29
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [globalamfungi ∩ fungaltraits](output/globalamfungi-intersect-fungaltraits.txt) | 485
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [globalamfungi ∩ globalamfungi](output/globalamfungi-intersect-globalamfungi.txt) | 1121
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [globalamfungi ∩ globalfungi](output/globalamfungi-intersect-globalfungi.txt) | 407
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [icmp](output/icmp-uniq.txt) | 123 | [globalamfungi ∩ icmp](output/globalamfungi-intersect-icmp.txt) | 57
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [globalamfungi ∩ limbu2025](output/globalamfungi-intersect-limbu2025.txt) | 1121
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [maarjam](output/maarjam-uniq.txt) | 1294 | [globalamfungi ∩ maarjam](output/globalamfungi-intersect-maarjam.txt) | 604
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [maps](output/maps-uniq.txt) | 2167 | [globalamfungi ∩ maps](output/globalamfungi-intersect-maps.txt) | 667
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [mycodb](output/mycodb-uniq.txt) | 604 | [globalamfungi ∩ mycodb](output/globalamfungi-intersect-mycodb.txt) | 193
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [globalamfungi ∩ mycoportal](output/globalamfungi-intersect-mycoportal.txt) | 956
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [pdd](output/pdd-uniq.txt) | 349 | [globalamfungi ∩ pdd](output/globalamfungi-intersect-pdd.txt) | 120
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [globalamfungi ∩ policelli2023](output/globalamfungi-intersect-policelli2023.txt) | 5
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [souza2025](output/souza2025-uniq.txt) | 364 | [globalamfungi ∩ souza2025](output/globalamfungi-intersect-souza2025.txt) | 158
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [globalamfungi ∩ stewartBisot2026](output/globalamfungi-intersect-stewartBisot2026.txt) | 230
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [unite](output/unite-uniq.txt) | 3006 | [globalamfungi ∩ unite](output/globalamfungi-intersect-unite.txt) | 464
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [globalamfungi ∩ usda-ars-culture-collection-nrrl](output/globalamfungi-intersect-usda-ars-culture-collection-nrrl.txt) | 228
[globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [globalamfungi ∩ usda-fungus-host](output/globalamfungi-intersect-usda-fungus-host.txt) | 1037
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [austraits](output/austraits-uniq.txt) | 9030 | [globalfungi ∩ austraits](output/globalfungi-intersect-austraits.txt) | 472
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [fred](output/fred-uniq.txt) | 6953 | [globalfungi ∩ fred](output/globalfungi-intersect-fred.txt) | 1070
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [funfun](output/funfun-uniq.txt) | 33 | [globalfungi ∩ funfun](output/globalfungi-intersect-funfun.txt) | 29
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [globalfungi ∩ fungaltraits](output/globalfungi-intersect-fungaltraits.txt) | 778
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [globalfungi ∩ globalamfungi](output/globalfungi-intersect-globalamfungi.txt) | 407
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [globalfungi ∩ globalfungi](output/globalfungi-intersect-globalfungi.txt) | 1978
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [icmp](output/icmp-uniq.txt) | 123 | [globalfungi ∩ icmp](output/globalfungi-intersect-icmp.txt) | 68
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [globalfungi ∩ limbu2025](output/globalfungi-intersect-limbu2025.txt) | 663
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [maarjam](output/maarjam-uniq.txt) | 1294 | [globalfungi ∩ maarjam](output/globalfungi-intersect-maarjam.txt) | 412
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [maps](output/maps-uniq.txt) | 2167 | [globalfungi ∩ maps](output/globalfungi-intersect-maps.txt) | 692
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [mycodb](output/mycodb-uniq.txt) | 604 | [globalfungi ∩ mycodb](output/globalfungi-intersect-mycodb.txt) | 254
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [globalfungi ∩ mycoportal](output/globalfungi-intersect-mycoportal.txt) | 1605
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [pdd](output/pdd-uniq.txt) | 349 | [globalfungi ∩ pdd](output/globalfungi-intersect-pdd.txt) | 166
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [globalfungi ∩ policelli2023](output/globalfungi-intersect-policelli2023.txt) | 18
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [souza2025](output/souza2025-uniq.txt) | 364 | [globalfungi ∩ souza2025](output/globalfungi-intersect-souza2025.txt) | 150
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [globalfungi ∩ stewartBisot2026](output/globalfungi-intersect-stewartBisot2026.txt) | 209
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [unite](output/unite-uniq.txt) | 3006 | [globalfungi ∩ unite](output/globalfungi-intersect-unite.txt) | 830
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [globalfungi ∩ usda-ars-culture-collection-nrrl](output/globalfungi-intersect-usda-ars-culture-collection-nrrl.txt) | 289
[globalfungi](output/globalfungi-uniq.txt) | 1978 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [globalfungi ∩ usda-fungus-host](output/globalfungi-intersect-usda-fungus-host.txt) | 1703
[icmp](output/icmp-uniq.txt) | 123 | [austraits](output/austraits-uniq.txt) | 9030 | [icmp ∩ austraits](output/icmp-intersect-austraits.txt) | 68
[icmp](output/icmp-uniq.txt) | 123 | [fred](output/fred-uniq.txt) | 6953 | [icmp ∩ fred](output/icmp-intersect-fred.txt) | 90
[icmp](output/icmp-uniq.txt) | 123 | [funfun](output/funfun-uniq.txt) | 33 | [icmp ∩ funfun](output/icmp-intersect-funfun.txt) | 14
[icmp](output/icmp-uniq.txt) | 123 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [icmp ∩ fungaltraits](output/icmp-intersect-fungaltraits.txt) | 91
[icmp](output/icmp-uniq.txt) | 123 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [icmp ∩ globalamfungi](output/icmp-intersect-globalamfungi.txt) | 57
[icmp](output/icmp-uniq.txt) | 123 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [icmp ∩ globalfungi](output/icmp-intersect-globalfungi.txt) | 68
[icmp](output/icmp-uniq.txt) | 123 | [icmp](output/icmp-uniq.txt) | 123 | [icmp ∩ icmp](output/icmp-intersect-icmp.txt) | 123
[icmp](output/icmp-uniq.txt) | 123 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [icmp ∩ limbu2025](output/icmp-intersect-limbu2025.txt) | 72
[icmp](output/icmp-uniq.txt) | 123 | [maarjam](output/maarjam-uniq.txt) | 1294 | [icmp ∩ maarjam](output/icmp-intersect-maarjam.txt) | 58
[icmp](output/icmp-uniq.txt) | 123 | [maps](output/maps-uniq.txt) | 2167 | [icmp ∩ maps](output/icmp-intersect-maps.txt) | 67
[icmp](output/icmp-uniq.txt) | 123 | [mycodb](output/mycodb-uniq.txt) | 604 | [icmp ∩ mycodb](output/icmp-intersect-mycodb.txt) | 44
[icmp](output/icmp-uniq.txt) | 123 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [icmp ∩ mycoportal](output/icmp-intersect-mycoportal.txt) | 117
[icmp](output/icmp-uniq.txt) | 123 | [pdd](output/pdd-uniq.txt) | 349 | [icmp ∩ pdd](output/icmp-intersect-pdd.txt) | 56
[icmp](output/icmp-uniq.txt) | 123 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [icmp ∩ policelli2023](output/icmp-intersect-policelli2023.txt) | 1
[icmp](output/icmp-uniq.txt) | 123 | [souza2025](output/souza2025-uniq.txt) | 364 | [icmp ∩ souza2025](output/icmp-intersect-souza2025.txt) | 39
[icmp](output/icmp-uniq.txt) | 123 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [icmp ∩ stewartBisot2026](output/icmp-intersect-stewartBisot2026.txt) | 36
[icmp](output/icmp-uniq.txt) | 123 | [unite](output/unite-uniq.txt) | 3006 | [icmp ∩ unite](output/icmp-intersect-unite.txt) | 79
[icmp](output/icmp-uniq.txt) | 123 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [icmp ∩ usda-ars-culture-collection-nrrl](output/icmp-intersect-usda-ars-culture-collection-nrrl.txt) | 63
[icmp](output/icmp-uniq.txt) | 123 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [icmp ∩ usda-fungus-host](output/icmp-intersect-usda-fungus-host.txt) | 119
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [austraits](output/austraits-uniq.txt) | 9030 | [limbu2025 ∩ austraits](output/limbu2025-intersect-austraits.txt) | 561
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [fred](output/fred-uniq.txt) | 6953 | [limbu2025 ∩ fred](output/limbu2025-intersect-fred.txt) | 1378
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [funfun](output/funfun-uniq.txt) | 33 | [limbu2025 ∩ funfun](output/limbu2025-intersect-funfun.txt) | 32
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [limbu2025 ∩ fungaltraits](output/limbu2025-intersect-fungaltraits.txt) | 877
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [limbu2025 ∩ globalamfungi](output/limbu2025-intersect-globalamfungi.txt) | 1121
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [limbu2025 ∩ globalfungi](output/limbu2025-intersect-globalfungi.txt) | 663
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [icmp](output/icmp-uniq.txt) | 123 | [limbu2025 ∩ icmp](output/limbu2025-intersect-icmp.txt) | 72
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [limbu2025 ∩ limbu2025](output/limbu2025-intersect-limbu2025.txt) | 2523
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [maarjam](output/maarjam-uniq.txt) | 1294 | [limbu2025 ∩ maarjam](output/limbu2025-intersect-maarjam.txt) | 829
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [maps](output/maps-uniq.txt) | 2167 | [limbu2025 ∩ maps](output/limbu2025-intersect-maps.txt) | 954
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [mycodb](output/mycodb-uniq.txt) | 604 | [limbu2025 ∩ mycodb](output/limbu2025-intersect-mycodb.txt) | 344
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [limbu2025 ∩ mycoportal](output/limbu2025-intersect-mycoportal.txt) | 2083
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [pdd](output/pdd-uniq.txt) | 349 | [limbu2025 ∩ pdd](output/limbu2025-intersect-pdd.txt) | 167
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [limbu2025 ∩ policelli2023](output/limbu2025-intersect-policelli2023.txt) | 9
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [souza2025](output/souza2025-uniq.txt) | 364 | [limbu2025 ∩ souza2025](output/limbu2025-intersect-souza2025.txt) | 309
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [limbu2025 ∩ stewartBisot2026](output/limbu2025-intersect-stewartBisot2026.txt) | 322
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [unite](output/unite-uniq.txt) | 3006 | [limbu2025 ∩ unite](output/limbu2025-intersect-unite.txt) | 836
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [limbu2025 ∩ usda-ars-culture-collection-nrrl](output/limbu2025-intersect-usda-ars-culture-collection-nrrl.txt) | 358
[limbu2025](output/limbu2025-uniq.txt) | 2523 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [limbu2025 ∩ usda-fungus-host](output/limbu2025-intersect-usda-fungus-host.txt) | 2267
[maarjam](output/maarjam-uniq.txt) | 1294 | [austraits](output/austraits-uniq.txt) | 9030 | [maarjam ∩ austraits](output/maarjam-intersect-austraits.txt) | 345
[maarjam](output/maarjam-uniq.txt) | 1294 | [fred](output/fred-uniq.txt) | 6953 | [maarjam ∩ fred](output/maarjam-intersect-fred.txt) | 685
[maarjam](output/maarjam-uniq.txt) | 1294 | [funfun](output/funfun-uniq.txt) | 33 | [maarjam ∩ funfun](output/maarjam-intersect-funfun.txt) | 30
[maarjam](output/maarjam-uniq.txt) | 1294 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [maarjam ∩ fungaltraits](output/maarjam-intersect-fungaltraits.txt) | 514
[maarjam](output/maarjam-uniq.txt) | 1294 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [maarjam ∩ globalamfungi](output/maarjam-intersect-globalamfungi.txt) | 604
[maarjam](output/maarjam-uniq.txt) | 1294 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [maarjam ∩ globalfungi](output/maarjam-intersect-globalfungi.txt) | 412
[maarjam](output/maarjam-uniq.txt) | 1294 | [icmp](output/icmp-uniq.txt) | 123 | [maarjam ∩ icmp](output/maarjam-intersect-icmp.txt) | 58
[maarjam](output/maarjam-uniq.txt) | 1294 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [maarjam ∩ limbu2025](output/maarjam-intersect-limbu2025.txt) | 829
[maarjam](output/maarjam-uniq.txt) | 1294 | [maarjam](output/maarjam-uniq.txt) | 1294 | [maarjam ∩ maarjam](output/maarjam-intersect-maarjam.txt) | 1294
[maarjam](output/maarjam-uniq.txt) | 1294 | [maps](output/maps-uniq.txt) | 2167 | [maarjam ∩ maps](output/maarjam-intersect-maps.txt) | 1167
[maarjam](output/maarjam-uniq.txt) | 1294 | [mycodb](output/mycodb-uniq.txt) | 604 | [maarjam ∩ mycodb](output/maarjam-intersect-mycodb.txt) | 200
[maarjam](output/maarjam-uniq.txt) | 1294 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [maarjam ∩ mycoportal](output/maarjam-intersect-mycoportal.txt) | 981
[maarjam](output/maarjam-uniq.txt) | 1294 | [pdd](output/pdd-uniq.txt) | 349 | [maarjam ∩ pdd](output/maarjam-intersect-pdd.txt) | 103
[maarjam](output/maarjam-uniq.txt) | 1294 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [maarjam ∩ policelli2023](output/maarjam-intersect-policelli2023.txt) | 1
[maarjam](output/maarjam-uniq.txt) | 1294 | [souza2025](output/souza2025-uniq.txt) | 364 | [maarjam ∩ souza2025](output/maarjam-intersect-souza2025.txt) | 147
[maarjam](output/maarjam-uniq.txt) | 1294 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [maarjam ∩ stewartBisot2026](output/maarjam-intersect-stewartBisot2026.txt) | 204
[maarjam](output/maarjam-uniq.txt) | 1294 | [unite](output/unite-uniq.txt) | 3006 | [maarjam ∩ unite](output/maarjam-intersect-unite.txt) | 481
[maarjam](output/maarjam-uniq.txt) | 1294 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [maarjam ∩ usda-ars-culture-collection-nrrl](output/maarjam-intersect-usda-ars-culture-collection-nrrl.txt) | 195
[maarjam](output/maarjam-uniq.txt) | 1294 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [maarjam ∩ usda-fungus-host](output/maarjam-intersect-usda-fungus-host.txt) | 1033
[maps](output/maps-uniq.txt) | 2167 | [austraits](output/austraits-uniq.txt) | 9030 | [maps ∩ austraits](output/maps-intersect-austraits.txt) | 410
[maps](output/maps-uniq.txt) | 2167 | [fred](output/fred-uniq.txt) | 6953 | [maps ∩ fred](output/maps-intersect-fred.txt) | 1101
[maps](output/maps-uniq.txt) | 2167 | [funfun](output/funfun-uniq.txt) | 33 | [maps ∩ funfun](output/maps-intersect-funfun.txt) | 31
[maps](output/maps-uniq.txt) | 2167 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [maps ∩ fungaltraits](output/maps-intersect-fungaltraits.txt) | 862
[maps](output/maps-uniq.txt) | 2167 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [maps ∩ globalamfungi](output/maps-intersect-globalamfungi.txt) | 667
[maps](output/maps-uniq.txt) | 2167 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [maps ∩ globalfungi](output/maps-intersect-globalfungi.txt) | 692
[maps](output/maps-uniq.txt) | 2167 | [icmp](output/icmp-uniq.txt) | 123 | [maps ∩ icmp](output/maps-intersect-icmp.txt) | 67
[maps](output/maps-uniq.txt) | 2167 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [maps ∩ limbu2025](output/maps-intersect-limbu2025.txt) | 954
[maps](output/maps-uniq.txt) | 2167 | [maarjam](output/maarjam-uniq.txt) | 1294 | [maps ∩ maarjam](output/maps-intersect-maarjam.txt) | 1167
[maps](output/maps-uniq.txt) | 2167 | [maps](output/maps-uniq.txt) | 2167 | [maps ∩ maps](output/maps-intersect-maps.txt) | 2167
[maps](output/maps-uniq.txt) | 2167 | [mycodb](output/mycodb-uniq.txt) | 604 | [maps ∩ mycodb](output/maps-intersect-mycodb.txt) | 299
[maps](output/maps-uniq.txt) | 2167 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [maps ∩ mycoportal](output/maps-intersect-mycoportal.txt) | 1596
[maps](output/maps-uniq.txt) | 2167 | [pdd](output/pdd-uniq.txt) | 349 | [maps ∩ pdd](output/maps-intersect-pdd.txt) | 138
[maps](output/maps-uniq.txt) | 2167 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [maps ∩ policelli2023](output/maps-intersect-policelli2023.txt) | 20
[maps](output/maps-uniq.txt) | 2167 | [souza2025](output/souza2025-uniq.txt) | 364 | [maps ∩ souza2025](output/maps-intersect-souza2025.txt) | 184
[maps](output/maps-uniq.txt) | 2167 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [maps ∩ stewartBisot2026](output/maps-intersect-stewartBisot2026.txt) | 230
[maps](output/maps-uniq.txt) | 2167 | [unite](output/unite-uniq.txt) | 3006 | [maps ∩ unite](output/maps-intersect-unite.txt) | 908
[maps](output/maps-uniq.txt) | 2167 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [maps ∩ usda-ars-culture-collection-nrrl](output/maps-intersect-usda-ars-culture-collection-nrrl.txt) | 283
[maps](output/maps-uniq.txt) | 2167 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [maps ∩ usda-fungus-host](output/maps-intersect-usda-fungus-host.txt) | 1726
[mycodb](output/mycodb-uniq.txt) | 604 | [austraits](output/austraits-uniq.txt) | 9030 | [mycodb ∩ austraits](output/mycodb-intersect-austraits.txt) | 155
[mycodb](output/mycodb-uniq.txt) | 604 | [fred](output/fred-uniq.txt) | 6953 | [mycodb ∩ fred](output/mycodb-intersect-fred.txt) | 438
[mycodb](output/mycodb-uniq.txt) | 604 | [funfun](output/funfun-uniq.txt) | 33 | [mycodb ∩ funfun](output/mycodb-intersect-funfun.txt) | 23
[mycodb](output/mycodb-uniq.txt) | 604 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [mycodb ∩ fungaltraits](output/mycodb-intersect-fungaltraits.txt) | 358
[mycodb](output/mycodb-uniq.txt) | 604 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [mycodb ∩ globalamfungi](output/mycodb-intersect-globalamfungi.txt) | 193
[mycodb](output/mycodb-uniq.txt) | 604 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [mycodb ∩ globalfungi](output/mycodb-intersect-globalfungi.txt) | 254
[mycodb](output/mycodb-uniq.txt) | 604 | [icmp](output/icmp-uniq.txt) | 123 | [mycodb ∩ icmp](output/mycodb-intersect-icmp.txt) | 44
[mycodb](output/mycodb-uniq.txt) | 604 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [mycodb ∩ limbu2025](output/mycodb-intersect-limbu2025.txt) | 344
[mycodb](output/mycodb-uniq.txt) | 604 | [maarjam](output/maarjam-uniq.txt) | 1294 | [mycodb ∩ maarjam](output/mycodb-intersect-maarjam.txt) | 200
[mycodb](output/mycodb-uniq.txt) | 604 | [maps](output/maps-uniq.txt) | 2167 | [mycodb ∩ maps](output/mycodb-intersect-maps.txt) | 299
[mycodb](output/mycodb-uniq.txt) | 604 | [mycodb](output/mycodb-uniq.txt) | 604 | [mycodb ∩ mycodb](output/mycodb-intersect-mycodb.txt) | 604
[mycodb](output/mycodb-uniq.txt) | 604 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [mycodb ∩ mycoportal](output/mycodb-intersect-mycoportal.txt) | 543
[mycodb](output/mycodb-uniq.txt) | 604 | [pdd](output/pdd-uniq.txt) | 349 | [mycodb ∩ pdd](output/mycodb-intersect-pdd.txt) | 78
[mycodb](output/mycodb-uniq.txt) | 604 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [mycodb ∩ policelli2023](output/mycodb-intersect-policelli2023.txt) | 17
[mycodb](output/mycodb-uniq.txt) | 604 | [souza2025](output/souza2025-uniq.txt) | 364 | [mycodb ∩ souza2025](output/mycodb-intersect-souza2025.txt) | 132
[mycodb](output/mycodb-uniq.txt) | 604 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [mycodb ∩ stewartBisot2026](output/mycodb-intersect-stewartBisot2026.txt) | 172
[mycodb](output/mycodb-uniq.txt) | 604 | [unite](output/unite-uniq.txt) | 3006 | [mycodb ∩ unite](output/mycodb-intersect-unite.txt) | 364
[mycodb](output/mycodb-uniq.txt) | 604 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [mycodb ∩ usda-ars-culture-collection-nrrl](output/mycodb-intersect-usda-ars-culture-collection-nrrl.txt) | 209
[mycodb](output/mycodb-uniq.txt) | 604 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [mycodb ∩ usda-fungus-host](output/mycodb-intersect-usda-fungus-host.txt) | 571
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [austraits](output/austraits-uniq.txt) | 9030 | [mycoportal ∩ austraits](output/mycoportal-intersect-austraits.txt) | 2041
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [fred](output/fred-uniq.txt) | 6953 | [mycoportal ∩ fred](output/mycoportal-intersect-fred.txt) | 5120
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [funfun](output/funfun-uniq.txt) | 33 | [mycoportal ∩ funfun](output/mycoportal-intersect-funfun.txt) | 33
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [mycoportal ∩ fungaltraits](output/mycoportal-intersect-fungaltraits.txt) | 2306
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [mycoportal ∩ globalamfungi](output/mycoportal-intersect-globalamfungi.txt) | 956
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [mycoportal ∩ globalfungi](output/mycoportal-intersect-globalfungi.txt) | 1605
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [icmp](output/icmp-uniq.txt) | 123 | [mycoportal ∩ icmp](output/mycoportal-intersect-icmp.txt) | 117
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [mycoportal ∩ limbu2025](output/mycoportal-intersect-limbu2025.txt) | 2083
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [maarjam](output/maarjam-uniq.txt) | 1294 | [mycoportal ∩ maarjam](output/mycoportal-intersect-maarjam.txt) | 981
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [maps](output/maps-uniq.txt) | 2167 | [mycoportal ∩ maps](output/mycoportal-intersect-maps.txt) | 1596
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [mycodb](output/mycodb-uniq.txt) | 604 | [mycoportal ∩ mycodb](output/mycoportal-intersect-mycodb.txt) | 543
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [mycoportal ∩ mycoportal](output/mycoportal-intersect-mycoportal.txt) | 33920
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [pdd](output/pdd-uniq.txt) | 349 | [mycoportal ∩ pdd](output/mycoportal-intersect-pdd.txt) | 332
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [mycoportal ∩ policelli2023](output/mycoportal-intersect-policelli2023.txt) | 20
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [souza2025](output/souza2025-uniq.txt) | 364 | [mycoportal ∩ souza2025](output/mycoportal-intersect-souza2025.txt) | 349
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [mycoportal ∩ stewartBisot2026](output/mycoportal-intersect-stewartBisot2026.txt) | 407
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [unite](output/unite-uniq.txt) | 3006 | [mycoportal ∩ unite](output/mycoportal-intersect-unite.txt) | 2433
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [mycoportal ∩ usda-ars-culture-collection-nrrl](output/mycoportal-intersect-usda-ars-culture-collection-nrrl.txt) | 623
[mycoportal](output/mycoportal-uniq.txt) | 33920 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [mycoportal ∩ usda-fungus-host](output/mycoportal-intersect-usda-fungus-host.txt) | 27789
[pdd](output/pdd-uniq.txt) | 349 | [austraits](output/austraits-uniq.txt) | 9030 | [pdd ∩ austraits](output/pdd-intersect-austraits.txt) | 197
[pdd](output/pdd-uniq.txt) | 349 | [fred](output/fred-uniq.txt) | 6953 | [pdd ∩ fred](output/pdd-intersect-fred.txt) | 253
[pdd](output/pdd-uniq.txt) | 349 | [funfun](output/funfun-uniq.txt) | 33 | [pdd ∩ funfun](output/pdd-intersect-funfun.txt) | 25
[pdd](output/pdd-uniq.txt) | 349 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [pdd ∩ fungaltraits](output/pdd-intersect-fungaltraits.txt) | 208
[pdd](output/pdd-uniq.txt) | 349 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [pdd ∩ globalamfungi](output/pdd-intersect-globalamfungi.txt) | 120
[pdd](output/pdd-uniq.txt) | 349 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [pdd ∩ globalfungi](output/pdd-intersect-globalfungi.txt) | 166
[pdd](output/pdd-uniq.txt) | 349 | [icmp](output/icmp-uniq.txt) | 123 | [pdd ∩ icmp](output/pdd-intersect-icmp.txt) | 56
[pdd](output/pdd-uniq.txt) | 349 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [pdd ∩ limbu2025](output/pdd-intersect-limbu2025.txt) | 167
[pdd](output/pdd-uniq.txt) | 349 | [maarjam](output/maarjam-uniq.txt) | 1294 | [pdd ∩ maarjam](output/pdd-intersect-maarjam.txt) | 103
[pdd](output/pdd-uniq.txt) | 349 | [maps](output/maps-uniq.txt) | 2167 | [pdd ∩ maps](output/pdd-intersect-maps.txt) | 138
[pdd](output/pdd-uniq.txt) | 349 | [mycodb](output/mycodb-uniq.txt) | 604 | [pdd ∩ mycodb](output/pdd-intersect-mycodb.txt) | 78
[pdd](output/pdd-uniq.txt) | 349 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [pdd ∩ mycoportal](output/pdd-intersect-mycoportal.txt) | 332
[pdd](output/pdd-uniq.txt) | 349 | [pdd](output/pdd-uniq.txt) | 349 | [pdd ∩ pdd](output/pdd-intersect-pdd.txt) | 349
[pdd](output/pdd-uniq.txt) | 349 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [pdd ∩ policelli2023](output/pdd-intersect-policelli2023.txt) | 5
[pdd](output/pdd-uniq.txt) | 349 | [souza2025](output/souza2025-uniq.txt) | 364 | [pdd ∩ souza2025](output/pdd-intersect-souza2025.txt) | 84
[pdd](output/pdd-uniq.txt) | 349 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [pdd ∩ stewartBisot2026](output/pdd-intersect-stewartBisot2026.txt) | 67
[pdd](output/pdd-uniq.txt) | 349 | [unite](output/unite-uniq.txt) | 3006 | [pdd ∩ unite](output/pdd-intersect-unite.txt) | 199
[pdd](output/pdd-uniq.txt) | 349 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [pdd ∩ usda-ars-culture-collection-nrrl](output/pdd-intersect-usda-ars-culture-collection-nrrl.txt) | 129
[pdd](output/pdd-uniq.txt) | 349 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [pdd ∩ usda-fungus-host](output/pdd-intersect-usda-fungus-host.txt) | 340
[policelli2023](output/policelli2023-uniq.txt) | 20 | [austraits](output/austraits-uniq.txt) | 9030 | [policelli2023 ∩ austraits](output/policelli2023-intersect-austraits.txt) | 1
[policelli2023](output/policelli2023-uniq.txt) | 20 | [fred](output/fred-uniq.txt) | 6953 | [policelli2023 ∩ fred](output/policelli2023-intersect-fred.txt) | 20
[policelli2023](output/policelli2023-uniq.txt) | 20 | [funfun](output/funfun-uniq.txt) | 33 | [policelli2023 ∩ funfun](output/policelli2023-intersect-funfun.txt) | 0
[policelli2023](output/policelli2023-uniq.txt) | 20 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [policelli2023 ∩ fungaltraits](output/policelli2023-intersect-fungaltraits.txt) | 18
[policelli2023](output/policelli2023-uniq.txt) | 20 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [policelli2023 ∩ globalamfungi](output/policelli2023-intersect-globalamfungi.txt) | 5
[policelli2023](output/policelli2023-uniq.txt) | 20 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [policelli2023 ∩ globalfungi](output/policelli2023-intersect-globalfungi.txt) | 18
[policelli2023](output/policelli2023-uniq.txt) | 20 | [icmp](output/icmp-uniq.txt) | 123 | [policelli2023 ∩ icmp](output/policelli2023-intersect-icmp.txt) | 1
[policelli2023](output/policelli2023-uniq.txt) | 20 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [policelli2023 ∩ limbu2025](output/policelli2023-intersect-limbu2025.txt) | 9
[policelli2023](output/policelli2023-uniq.txt) | 20 | [maarjam](output/maarjam-uniq.txt) | 1294 | [policelli2023 ∩ maarjam](output/policelli2023-intersect-maarjam.txt) | 1
[policelli2023](output/policelli2023-uniq.txt) | 20 | [maps](output/maps-uniq.txt) | 2167 | [policelli2023 ∩ maps](output/policelli2023-intersect-maps.txt) | 20
[policelli2023](output/policelli2023-uniq.txt) | 20 | [mycodb](output/mycodb-uniq.txt) | 604 | [policelli2023 ∩ mycodb](output/policelli2023-intersect-mycodb.txt) | 17
[policelli2023](output/policelli2023-uniq.txt) | 20 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [policelli2023 ∩ mycoportal](output/policelli2023-intersect-mycoportal.txt) | 20
[policelli2023](output/policelli2023-uniq.txt) | 20 | [pdd](output/pdd-uniq.txt) | 349 | [policelli2023 ∩ pdd](output/policelli2023-intersect-pdd.txt) | 5
[policelli2023](output/policelli2023-uniq.txt) | 20 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [policelli2023 ∩ policelli2023](output/policelli2023-intersect-policelli2023.txt) | 20
[policelli2023](output/policelli2023-uniq.txt) | 20 | [souza2025](output/souza2025-uniq.txt) | 364 | [policelli2023 ∩ souza2025](output/policelli2023-intersect-souza2025.txt) | 1
[policelli2023](output/policelli2023-uniq.txt) | 20 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [policelli2023 ∩ stewartBisot2026](output/policelli2023-intersect-stewartBisot2026.txt) | 5
[policelli2023](output/policelli2023-uniq.txt) | 20 | [unite](output/unite-uniq.txt) | 3006 | [policelli2023 ∩ unite](output/policelli2023-intersect-unite.txt) | 20
[policelli2023](output/policelli2023-uniq.txt) | 20 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [policelli2023 ∩ usda-ars-culture-collection-nrrl](output/policelli2023-intersect-usda-ars-culture-collection-nrrl.txt) | 13
[policelli2023](output/policelli2023-uniq.txt) | 20 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [policelli2023 ∩ usda-fungus-host](output/policelli2023-intersect-usda-fungus-host.txt) | 20
[souza2025](output/souza2025-uniq.txt) | 364 | [austraits](output/austraits-uniq.txt) | 9030 | [souza2025 ∩ austraits](output/souza2025-intersect-austraits.txt) | 144
[souza2025](output/souza2025-uniq.txt) | 364 | [fred](output/fred-uniq.txt) | 6953 | [souza2025 ∩ fred](output/souza2025-intersect-fred.txt) | 265
[souza2025](output/souza2025-uniq.txt) | 364 | [funfun](output/funfun-uniq.txt) | 33 | [souza2025 ∩ funfun](output/souza2025-intersect-funfun.txt) | 27
[souza2025](output/souza2025-uniq.txt) | 364 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [souza2025 ∩ fungaltraits](output/souza2025-intersect-fungaltraits.txt) | 232
[souza2025](output/souza2025-uniq.txt) | 364 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [souza2025 ∩ globalamfungi](output/souza2025-intersect-globalamfungi.txt) | 158
[souza2025](output/souza2025-uniq.txt) | 364 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [souza2025 ∩ globalfungi](output/souza2025-intersect-globalfungi.txt) | 150
[souza2025](output/souza2025-uniq.txt) | 364 | [icmp](output/icmp-uniq.txt) | 123 | [souza2025 ∩ icmp](output/souza2025-intersect-icmp.txt) | 39
[souza2025](output/souza2025-uniq.txt) | 364 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [souza2025 ∩ limbu2025](output/souza2025-intersect-limbu2025.txt) | 309
[souza2025](output/souza2025-uniq.txt) | 364 | [maarjam](output/maarjam-uniq.txt) | 1294 | [souza2025 ∩ maarjam](output/souza2025-intersect-maarjam.txt) | 147
[souza2025](output/souza2025-uniq.txt) | 364 | [maps](output/maps-uniq.txt) | 2167 | [souza2025 ∩ maps](output/souza2025-intersect-maps.txt) | 184
[souza2025](output/souza2025-uniq.txt) | 364 | [mycodb](output/mycodb-uniq.txt) | 604 | [souza2025 ∩ mycodb](output/souza2025-intersect-mycodb.txt) | 132
[souza2025](output/souza2025-uniq.txt) | 364 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [souza2025 ∩ mycoportal](output/souza2025-intersect-mycoportal.txt) | 349
[souza2025](output/souza2025-uniq.txt) | 364 | [pdd](output/pdd-uniq.txt) | 349 | [souza2025 ∩ pdd](output/souza2025-intersect-pdd.txt) | 84
[souza2025](output/souza2025-uniq.txt) | 364 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [souza2025 ∩ policelli2023](output/souza2025-intersect-policelli2023.txt) | 1
[souza2025](output/souza2025-uniq.txt) | 364 | [souza2025](output/souza2025-uniq.txt) | 364 | [souza2025 ∩ souza2025](output/souza2025-intersect-souza2025.txt) | 364
[souza2025](output/souza2025-uniq.txt) | 364 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [souza2025 ∩ stewartBisot2026](output/souza2025-intersect-stewartBisot2026.txt) | 126
[souza2025](output/souza2025-uniq.txt) | 364 | [unite](output/unite-uniq.txt) | 3006 | [souza2025 ∩ unite](output/souza2025-intersect-unite.txt) | 218
[souza2025](output/souza2025-uniq.txt) | 364 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [souza2025 ∩ usda-ars-culture-collection-nrrl](output/souza2025-intersect-usda-ars-culture-collection-nrrl.txt) | 153
[souza2025](output/souza2025-uniq.txt) | 364 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [souza2025 ∩ usda-fungus-host](output/souza2025-intersect-usda-fungus-host.txt) | 350
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [austraits](output/austraits-uniq.txt) | 9030 | [stewartBisot2026 ∩ austraits](output/stewartBisot2026-intersect-austraits.txt) | 140
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [fred](output/fred-uniq.txt) | 6953 | [stewartBisot2026 ∩ fred](output/stewartBisot2026-intersect-fred.txt) | 349
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [funfun](output/funfun-uniq.txt) | 33 | [stewartBisot2026 ∩ funfun](output/stewartBisot2026-intersect-funfun.txt) | 22
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [stewartBisot2026 ∩ fungaltraits](output/stewartBisot2026-intersect-fungaltraits.txt) | 266
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [stewartBisot2026 ∩ globalamfungi](output/stewartBisot2026-intersect-globalamfungi.txt) | 230
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [stewartBisot2026 ∩ globalfungi](output/stewartBisot2026-intersect-globalfungi.txt) | 209
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [icmp](output/icmp-uniq.txt) | 123 | [stewartBisot2026 ∩ icmp](output/stewartBisot2026-intersect-icmp.txt) | 36
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [stewartBisot2026 ∩ limbu2025](output/stewartBisot2026-intersect-limbu2025.txt) | 322
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [maarjam](output/maarjam-uniq.txt) | 1294 | [stewartBisot2026 ∩ maarjam](output/stewartBisot2026-intersect-maarjam.txt) | 204
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [maps](output/maps-uniq.txt) | 2167 | [stewartBisot2026 ∩ maps](output/stewartBisot2026-intersect-maps.txt) | 230
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [mycodb](output/mycodb-uniq.txt) | 604 | [stewartBisot2026 ∩ mycodb](output/stewartBisot2026-intersect-mycodb.txt) | 172
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [stewartBisot2026 ∩ mycoportal](output/stewartBisot2026-intersect-mycoportal.txt) | 407
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [pdd](output/pdd-uniq.txt) | 349 | [stewartBisot2026 ∩ pdd](output/stewartBisot2026-intersect-pdd.txt) | 67
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [stewartBisot2026 ∩ policelli2023](output/stewartBisot2026-intersect-policelli2023.txt) | 5
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [souza2025](output/souza2025-uniq.txt) | 364 | [stewartBisot2026 ∩ souza2025](output/stewartBisot2026-intersect-souza2025.txt) | 126
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [stewartBisot2026 ∩ stewartBisot2026](output/stewartBisot2026-intersect-stewartBisot2026.txt) | 455
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [unite](output/unite-uniq.txt) | 3006 | [stewartBisot2026 ∩ unite](output/stewartBisot2026-intersect-unite.txt) | 257
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [stewartBisot2026 ∩ usda-ars-culture-collection-nrrl](output/stewartBisot2026-intersect-usda-ars-culture-collection-nrrl.txt) | 147
[stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [stewartBisot2026 ∩ usda-fungus-host](output/stewartBisot2026-intersect-usda-fungus-host.txt) | 429
[unite](output/unite-uniq.txt) | 3006 | [austraits](output/austraits-uniq.txt) | 9030 | [unite ∩ austraits](output/unite-intersect-austraits.txt) | 585
[unite](output/unite-uniq.txt) | 3006 | [fred](output/fred-uniq.txt) | 6953 | [unite ∩ fred](output/unite-intersect-fred.txt) | 1402
[unite](output/unite-uniq.txt) | 3006 | [funfun](output/funfun-uniq.txt) | 33 | [unite ∩ funfun](output/unite-intersect-funfun.txt) | 31
[unite](output/unite-uniq.txt) | 3006 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [unite ∩ fungaltraits](output/unite-intersect-fungaltraits.txt) | 1206
[unite](output/unite-uniq.txt) | 3006 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [unite ∩ globalamfungi](output/unite-intersect-globalamfungi.txt) | 464
[unite](output/unite-uniq.txt) | 3006 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [unite ∩ globalfungi](output/unite-intersect-globalfungi.txt) | 830
[unite](output/unite-uniq.txt) | 3006 | [icmp](output/icmp-uniq.txt) | 123 | [unite ∩ icmp](output/unite-intersect-icmp.txt) | 79
[unite](output/unite-uniq.txt) | 3006 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [unite ∩ limbu2025](output/unite-intersect-limbu2025.txt) | 836
[unite](output/unite-uniq.txt) | 3006 | [maarjam](output/maarjam-uniq.txt) | 1294 | [unite ∩ maarjam](output/unite-intersect-maarjam.txt) | 481
[unite](output/unite-uniq.txt) | 3006 | [maps](output/maps-uniq.txt) | 2167 | [unite ∩ maps](output/unite-intersect-maps.txt) | 908
[unite](output/unite-uniq.txt) | 3006 | [mycodb](output/mycodb-uniq.txt) | 604 | [unite ∩ mycodb](output/unite-intersect-mycodb.txt) | 364
[unite](output/unite-uniq.txt) | 3006 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [unite ∩ mycoportal](output/unite-intersect-mycoportal.txt) | 2433
[unite](output/unite-uniq.txt) | 3006 | [pdd](output/pdd-uniq.txt) | 349 | [unite ∩ pdd](output/unite-intersect-pdd.txt) | 199
[unite](output/unite-uniq.txt) | 3006 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [unite ∩ policelli2023](output/unite-intersect-policelli2023.txt) | 20
[unite](output/unite-uniq.txt) | 3006 | [souza2025](output/souza2025-uniq.txt) | 364 | [unite ∩ souza2025](output/unite-intersect-souza2025.txt) | 218
[unite](output/unite-uniq.txt) | 3006 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [unite ∩ stewartBisot2026](output/unite-intersect-stewartBisot2026.txt) | 257
[unite](output/unite-uniq.txt) | 3006 | [unite](output/unite-uniq.txt) | 3006 | [unite ∩ unite](output/unite-intersect-unite.txt) | 3006
[unite](output/unite-uniq.txt) | 3006 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [unite ∩ usda-ars-culture-collection-nrrl](output/unite-intersect-usda-ars-culture-collection-nrrl.txt) | 459
[unite](output/unite-uniq.txt) | 3006 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [unite ∩ usda-fungus-host](output/unite-intersect-usda-fungus-host.txt) | 2670
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [austraits](output/austraits-uniq.txt) | 9030 | [usda-ars-culture-collection-nrrl ∩ austraits](output/usda-ars-culture-collection-nrrl-intersect-austraits.txt) | 225
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [fred](output/fred-uniq.txt) | 6953 | [usda-ars-culture-collection-nrrl ∩ fred](output/usda-ars-culture-collection-nrrl-intersect-fred.txt) | 429
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [funfun](output/funfun-uniq.txt) | 33 | [usda-ars-culture-collection-nrrl ∩ funfun](output/usda-ars-culture-collection-nrrl-intersect-funfun.txt) | 28
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [usda-ars-culture-collection-nrrl ∩ fungaltraits](output/usda-ars-culture-collection-nrrl-intersect-fungaltraits.txt) | 441
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [usda-ars-culture-collection-nrrl ∩ globalamfungi](output/usda-ars-culture-collection-nrrl-intersect-globalamfungi.txt) | 228
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [usda-ars-culture-collection-nrrl ∩ globalfungi](output/usda-ars-culture-collection-nrrl-intersect-globalfungi.txt) | 289
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [icmp](output/icmp-uniq.txt) | 123 | [usda-ars-culture-collection-nrrl ∩ icmp](output/usda-ars-culture-collection-nrrl-intersect-icmp.txt) | 63
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [usda-ars-culture-collection-nrrl ∩ limbu2025](output/usda-ars-culture-collection-nrrl-intersect-limbu2025.txt) | 358
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [maarjam](output/maarjam-uniq.txt) | 1294 | [usda-ars-culture-collection-nrrl ∩ maarjam](output/usda-ars-culture-collection-nrrl-intersect-maarjam.txt) | 195
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [maps](output/maps-uniq.txt) | 2167 | [usda-ars-culture-collection-nrrl ∩ maps](output/usda-ars-culture-collection-nrrl-intersect-maps.txt) | 283
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [mycodb](output/mycodb-uniq.txt) | 604 | [usda-ars-culture-collection-nrrl ∩ mycodb](output/usda-ars-culture-collection-nrrl-intersect-mycodb.txt) | 209
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [usda-ars-culture-collection-nrrl ∩ mycoportal](output/usda-ars-culture-collection-nrrl-intersect-mycoportal.txt) | 623
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [pdd](output/pdd-uniq.txt) | 349 | [usda-ars-culture-collection-nrrl ∩ pdd](output/usda-ars-culture-collection-nrrl-intersect-pdd.txt) | 129
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [usda-ars-culture-collection-nrrl ∩ policelli2023](output/usda-ars-culture-collection-nrrl-intersect-policelli2023.txt) | 13
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [souza2025](output/souza2025-uniq.txt) | 364 | [usda-ars-culture-collection-nrrl ∩ souza2025](output/usda-ars-culture-collection-nrrl-intersect-souza2025.txt) | 153
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [usda-ars-culture-collection-nrrl ∩ stewartBisot2026](output/usda-ars-culture-collection-nrrl-intersect-stewartBisot2026.txt) | 147
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [unite](output/unite-uniq.txt) | 3006 | [usda-ars-culture-collection-nrrl ∩ unite](output/usda-ars-culture-collection-nrrl-intersect-unite.txt) | 459
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [usda-ars-culture-collection-nrrl ∩ usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-intersect-usda-ars-culture-collection-nrrl.txt) | 656
[usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [usda-ars-culture-collection-nrrl ∩ usda-fungus-host](output/usda-ars-culture-collection-nrrl-intersect-usda-fungus-host.txt) | 642
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [austraits](output/austraits-uniq.txt) | 9030 | [usda-fungus-host ∩ austraits](output/usda-fungus-host-intersect-austraits.txt) | 3205
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [fred](output/fred-uniq.txt) | 6953 | [usda-fungus-host ∩ fred](output/usda-fungus-host-intersect-fred.txt) | 5906
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [funfun](output/funfun-uniq.txt) | 33 | [usda-fungus-host ∩ funfun](output/usda-fungus-host-intersect-funfun.txt) | 33
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [fungaltraits](output/fungaltraits-uniq.txt) | 2612 | [usda-fungus-host ∩ fungaltraits](output/usda-fungus-host-intersect-fungaltraits.txt) | 2509
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [globalamfungi](output/globalamfungi-uniq.txt) | 1121 | [usda-fungus-host ∩ globalamfungi](output/usda-fungus-host-intersect-globalamfungi.txt) | 1037
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [globalfungi](output/globalfungi-uniq.txt) | 1978 | [usda-fungus-host ∩ globalfungi](output/usda-fungus-host-intersect-globalfungi.txt) | 1703
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [icmp](output/icmp-uniq.txt) | 123 | [usda-fungus-host ∩ icmp](output/usda-fungus-host-intersect-icmp.txt) | 119
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [limbu2025](output/limbu2025-uniq.txt) | 2523 | [usda-fungus-host ∩ limbu2025](output/usda-fungus-host-intersect-limbu2025.txt) | 2267
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [maarjam](output/maarjam-uniq.txt) | 1294 | [usda-fungus-host ∩ maarjam](output/usda-fungus-host-intersect-maarjam.txt) | 1033
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [maps](output/maps-uniq.txt) | 2167 | [usda-fungus-host ∩ maps](output/usda-fungus-host-intersect-maps.txt) | 1726
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [mycodb](output/mycodb-uniq.txt) | 604 | [usda-fungus-host ∩ mycodb](output/usda-fungus-host-intersect-mycodb.txt) | 571
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [mycoportal](output/mycoportal-uniq.txt) | 33920 | [usda-fungus-host ∩ mycoportal](output/usda-fungus-host-intersect-mycoportal.txt) | 27789
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [pdd](output/pdd-uniq.txt) | 349 | [usda-fungus-host ∩ pdd](output/usda-fungus-host-intersect-pdd.txt) | 340
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [policelli2023](output/policelli2023-uniq.txt) | 20 | [usda-fungus-host ∩ policelli2023](output/usda-fungus-host-intersect-policelli2023.txt) | 20
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [souza2025](output/souza2025-uniq.txt) | 364 | [usda-fungus-host ∩ souza2025](output/usda-fungus-host-intersect-souza2025.txt) | 350
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [stewartBisot2026](output/stewartBisot2026-uniq.txt) | 455 | [usda-fungus-host ∩ stewartBisot2026](output/usda-fungus-host-intersect-stewartBisot2026.txt) | 429
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [unite](output/unite-uniq.txt) | 3006 | [usda-fungus-host ∩ unite](output/usda-fungus-host-intersect-unite.txt) | 2670
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [usda-ars-culture-collection-nrrl](output/usda-ars-culture-collection-nrrl-uniq.txt) | 656 | [usda-fungus-host ∩ usda-ars-culture-collection-nrrl](output/usda-fungus-host-intersect-usda-ars-culture-collection-nrrl.txt) | 642
[usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [usda-fungus-host](output/usda-fungus-host-uniq.txt) | 48689 | [usda-fungus-host ∩ usda-fungus-host](output/usda-fungus-host-intersect-usda-fungus-host.txt) | 48689
