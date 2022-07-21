library(ape)

args <- commandArgs(trailingOnly = T)
treefile <- args[1]
outfile <- args[2]

tree <- read.tree(treefile)
coltree <- di2multi(tree, tol = 0.0025)

write.tree(coltree, file=outfile)

