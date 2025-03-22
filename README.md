# MicrobeNetNet 

Host plant overlap between known plant-fungal datasets. 

Step 1. Get The GloBI World of Flora Online Alignment Review for each dataset 
```
bin/fetch.sh "maarjam mycoportal usda-fungus-host fred"
```

Step 2. Make a list of all unique taxa
```
mkdir -p output
ls -1 input/\
 | grep -oE "^[a-z-]+"\
 | parallel "cat input/{1}.tsv.gz | gunzip | bin/uniq-resolved-plant-names.sh > output/{1}-uniq.txt" 
```

Step 3. Calculate pairwise overlap table

```
bin/pairwise-overlap.sh $(ls -1 input/ | grep -oE "^[a-z-]+" | tr '\n' ' ')
```

Result:

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


Another perspective: symmetric matrics 

 | maarjam | fred | mycoportal | usda-fungus-host
--- | --- | --- | --- | ---
maarjam | - | 1,217 ∩ 6,927 = 656 | 1217 ∩ 33,273 = 915 | 1,217 ∩ 48,418 = 974
fred | - | - | 6,927 ∩ 33,273 = 5,062 | 6,927 ∩ 48,418 = 5,881
mycoportal | - | - | - | 33,273 ∩ 48,418 = 27474
usda-fungus-host | - | - | - | -

