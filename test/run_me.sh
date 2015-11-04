#!/bin/bash


#Create our manifests
../Split_Manifests --files Genomes/*.fa --chunk_size 200

#Run them from a single node 
for i in *.man; do cd Chunk-$i; ../G2GCalc --threads 32 --manifest $i ;cd .. ; done 


#SBATCH
#cp ../Array_Submit.slrm . 
#sbatch --array=0-2 Array_Submit.slrm

cp Chunk*/*mtx . 

#Combine and plot 
#Get max elements 
ls Genomes/*.fa | wc -l 
#28
../CombineMatrices --max_elements 28 --files *.mtx --out test_join.mtx


