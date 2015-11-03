#!/bin/bash


#Create our manifests
../Split_Manifests --files Genomes/*.fa --chunk_size 200

#Run them from a single node 
for i in *.man; do ../G2GCalc --threads 32 --manifest $i ; done 


#SBATCH
#cp ../Array_Submit.slrm . 
#sbatch --array=0-2 Array_Submit.slrm


#We should clean up a little once were done running
mkdir co-ords
mv *coords co-ords/
mkdir deltas
mv *delta deltas/

#Combine and plot 
#Get max elements 
ls Genomes/*.fa | wc -l 
#28
../CombineMatrices --max_elements 28 --files *.mtx --out test_join.mtx


