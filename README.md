# Searching for gene absence in a phylogenetic tree (Hara and Kuraku, submitted)

## Dependency

The suite requires ete3 (>= 3.1.1) implemented in Python3 (>= 3.6), ape (>= 5.5) in R (>= 3.2.0), and Perl5.
  

## Inputs

### Gene tree file
The suite inputs unrooted tree files in the newick format. All tree files have .nwk extension and stored in a specified directory.  
Caution: Do not attach .clps.nwk extension for these tree files because this extension will be attached to the intermediate tree files that are removed at the initial step of the script.
#### Prefix of OTU names
Each OTU should have the six-character abbreviation of species names.  
The six-character prefix were attached to species name with underscore.
The abbreviations used in the paper were described in data/XXX.txt  

| Abbreviation | Species name |
----|---- 
| `Homsap` | Homo Sapiens |
| `Pantro` | Pan troglodytes |
| `Mondom` | Monodelphis domestica |
| etc. |



### Human-centric topological age 
This represents rough phylogenetic distances between human and other vertebrates in a hieratchial maanner as shown in the table below. The ages for the individual species are included in data/hierarchy_vrt.txt.
This value is used for rerooting the tree with ete3 assuming taxonomic positions of the species.

| Topological age | Taxon |
|:---:|:---|
| 1 | Homo Sapiens |
| 2 | Non-human apes |
| 3 | Non-ape primates |
| 4 | Non-primate eutherians |
| 5 | Marsupials and monotremes |
| 6 | Sauropsids |
| 7 | Amphibians and coelacanth |
| 8 | chondrichthyans |


### Ensembl human gene orthology
The Ensembl orthologous pairs between human and other vertebrates can be optinally used to decrease false identification of gene absence due to reconstruction of gene trees inconsistent with species phylogeny.  
The file contains representative protein IDs of human and other vertebrate ortholog pairs in tabular separated text. The first column should contain human protein IDs. When Ensembl and the other annotations are integrated, Non-Ensembl (e.g., RefSeq) protein IDs are acceptable.  
Find the file in data/YYY.txt.


### Preset data
- Species list (six-characters)
- Taxonomy list
- Species phylogenetic tree  
The tree contains the mutifurcational relationship of the species in a representative taxonomic group for identifying gene loss in the newick format.
For example, the species belonging to Carnivora should be described as:
```
(Panpar,Pantig,Felcat,Ursmar,Ailmel,Musput,Enhlut,Canfam,Neosch,Odoros)Carnivora
```

## Execution

Run a wrapper for inferring speciation and duplication event at each tree node for each human gene.
```
/PATH/TO/ElusiveGenes/scripts/processtree.sh dir_name
```
where `dir_name` is a directory tha contains gene tree files.  
This wrapper produces two types of intermediate tree files and an output file for each tree file.
- XXXX.clps.nwk; 
- XXXX.clps.reroot.nwk;
- XXXX.clps.reroot.ortho.txt;


