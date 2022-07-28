#!/bin/bash

DIR=$1

SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ ! -d $DIR ]; then
	echo "usage: $0 [Dir_Name]" >&2
	echo "Directory [Dir_Name] not found. Prepare a directory containing gene tree files in newick format with extension .nwk" >&2
fi

# Remove intermediate and output files
rm ${DIR}/*.clps.nwk
rm ${DIR}/*.clps.rooted.nwk

# Collapsing internal branches with near-zero lengths
for i in ${DIR}/*.nwk; do
	Rscript ${SCRIPT_DIR}/collapse_node.R $i ${i/.nwk/.clps.nwk}
done

# Rerooting and inferring speciation/duplication branching points
for i in ${DIR}/*.clps.nwk; do
	python3 ${SCRIPT_DIR}/getortho_ete.reroot.py $i > ${i/clps.nwk/clps.reroot.ortho.txt}
done

