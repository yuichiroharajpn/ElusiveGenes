# Searching for gene absence in a phylogenetic tree (Hara and Kuraku, submitted)

## Dependency

The suite requires ete3 (==3.1.2) implemented in Python3 (>= 3.6, <3.7.0), ape (>= 5.5) in R (>= 3.2.0), and Perl5.
  

## Inputs

### Gene tree file
The suite inputs unrooted tree files in the newick format. All tree files have .nwk extension and are stored in a specified directory.  
Caution: Do not attach .clps.nwk extension for these tree files because this extension will be attached to the intermediate tree files that are removed at the initial step of the script.
#### The Prefix of OTU names
Each OTU should have a six-character abbreviation of species names.  
The six-character prefix is attached to the species name with an underscore.
The abbreviations used in the paper were described in data/XXX.txt  

| Abbreviation | Species name |
----|---- 
| `Homsap` | Homo Sapiens |
| `Pantro` | Pan troglodytes |
| `Mondom` | Monodelphis domestica |
| etc. |



### Human-centric topological age 
This represents rough phylogenetic distances between human and other vertebrates in a hierarchical manner as shown in the table below. The ages for the individual species are included in data/hierarchy_vrt.txt.
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
The Ensembl orthologous pairs between human and other vertebrates can be optionally used to decrease false identification of gene absence due to reconstruction of gene trees inconsistent with species phylogeny.  
The file contains representative protein IDs of human and other vertebrate ortholog pairs in tabular separated text. The first column should contain human protein IDs. When Ensembl and the other annotations are integrated, Non-Ensembl (e.g., RefSeq) protein IDs are acceptable.  
Find the file in data/YYY.txt.


### Preset data
- Species list (six-characters)
- Taxonomy list
- Species phylogenetic tree  
The tree contains the multifurcation relationship of species in a representative taxonomic group for identifying gene loss in the newick format.
For example, the species belonging to Carnivora should be described as:
```
(Panpar,Pantig,Felcat,Ursmar,Ailmel,Musput,Enhlut,Canfam,Neosch,Odoros)Carnivora
```

## Execution

Download this git repository to a directory
```
cd /PATH/TO/github
git clone https://github.com/yuichiroharajpn/ElusiveGenes.git
```

Run a wrapper for inferring speciation and duplication events at each tree node for each human gene.
```
/PATH/TO/github/ElusiveGenes/scripts/processtree.sh dir_name
```
where `dir_name` is a directory that contains gene tree files.  
This wrapper produces two types of intermediate tree files and an output file for each tree file.
- XXXX.clps.nwk; a tree file with collapsing internal branches with near zero lengths
- XXXX.clps.reroot.nwk; a rooted tree file of the XXXX.clps.nwk
- XXXX.clps.reroot.ortho.txt; an output file of speciation and duplication inference for the individual human genes  
  

Summarize the presence or absence of species in ortholog groups that contains human genes
```
/PATH/TO/github/ElusiveGenes/scripts/summarize_absence.pl -d dir_name -e /PATH/TO/github/ElusiveGenes/data/Ensembl_human_orthopair.92.pep.txt -M > summary_gene_retention.txt
```
The output file contains number of genes in each taxon and species and human gene (representative protein) IDs for a mammalian subtree in a gene tree in a line.
