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

A | B | A ∩ B
--- | --- | ---
[fred-wfo 6927](output/fred-wfo-uniq.txt) | [fred-wfo 6927](output/fred-wfo-uniq.txt) | [fred-wfo ∩ fred-wfo 6927](output/fred-wfo-intersect-fred-wfo.txt)
[fred-wfo 6927](output/fred-wfo-uniq.txt) | [maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [fred-wfo ∩ maarjam-wfo 656](output/fred-wfo-intersect-maarjam-wfo.txt)
[fred-wfo 6927](output/fred-wfo-uniq.txt) | [mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [fred-wfo ∩ mycoportal-wfo 5062](output/fred-wfo-intersect-mycoportal-wfo.txt)
[fred-wfo 6927](output/fred-wfo-uniq.txt) | [usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [fred-wfo ∩ usda-fungus-host-wfo 5881](output/fred-wfo-intersect-usda-fungus-host-wfo.txt)
[maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [fred-wfo 6927](output/fred-wfo-uniq.txt) | [maarjam-wfo ∩ fred-wfo 656](output/maarjam-wfo-intersect-fred-wfo.txt)
[maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [maarjam-wfo ∩ maarjam-wfo 1217](output/maarjam-wfo-intersect-maarjam-wfo.txt)
[maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [maarjam-wfo ∩ mycoportal-wfo 915](output/maarjam-wfo-intersect-mycoportal-wfo.txt)
[maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [maarjam-wfo ∩ usda-fungus-host-wfo 974](output/maarjam-wfo-intersect-usda-fungus-host-wfo.txt)
[mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [fred-wfo 6927](output/fred-wfo-uniq.txt) | [mycoportal-wfo ∩ fred-wfo 5062](output/mycoportal-wfo-intersect-fred-wfo.txt)
[mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [mycoportal-wfo ∩ maarjam-wfo 915](output/mycoportal-wfo-intersect-maarjam-wfo.txt)
[mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [mycoportal-wfo ∩ mycoportal-wfo 33273](output/mycoportal-wfo-intersect-mycoportal-wfo.txt)
[mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [mycoportal-wfo ∩ usda-fungus-host-wfo 27474](output/mycoportal-wfo-intersect-usda-fungus-host-wfo.txt)
[usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [fred-wfo 6927](output/fred-wfo-uniq.txt) | [usda-fungus-host-wfo ∩ fred-wfo 5881](output/usda-fungus-host-wfo-intersect-fred-wfo.txt)
[usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [maarjam-wfo 1217](output/maarjam-wfo-uniq.txt) | [usda-fungus-host-wfo ∩ maarjam-wfo 974](output/usda-fungus-host-wfo-intersect-maarjam-wfo.txt)
[usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [mycoportal-wfo 33273](output/mycoportal-wfo-uniq.txt) | [usda-fungus-host-wfo ∩ mycoportal-wfo 27474](output/usda-fungus-host-wfo-intersect-mycoportal-wfo.txt)
[usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-uniq.txt) | [usda-fungus-host-wfo ∩ usda-fungus-host-wfo 48418](output/usda-fungus-host-wfo-intersect-usda-fungus-host-wfo.txt)
