
[![DOI](https://zenodo.org/badge/19239/dylanstorey/PanCake.svg)](https://zenodo.org/badge/latestdoi/19239/dylanstorey/PanCake)

# PanCake

Implementation of methods described in Meier-Kolthoff et al 2013.
[Article Here](http://www.biomedcentral.com/1471-2105/14/60)

While the authors of that publication rightly believe that the BLAST algorithm gives more sensitivity for these questions , it comes at an extreme cost making application to large datasets computationally intractible. 

These programs provide a minimal implementation of their described methods so that the nucmer program could instead be employed using greedy trimming along with the equation __d<sub>4</sub>__ to calculate a distance between two genome assemblies.

##Citing this work:

If you use this program or any of its outputs in your research please cite the following:

```
Meier-Kolthoff, Jan and Auch, Alexander and Klenk, Hans-Peter and Goker, Markus
Genome sequence-based species delimitation with confidence intervals and improved distance functions
BMC Bioinformatics
2013

Dylan Storey and Bart Weimer. (2015). PanCake:Narya
```
##Installation
The only non core Perl packages required come from [Inline](https://metacpan.org/pod/Inline::CPP).

To install:
```bash
sudo cpan install Inline
sudo cpan install Inline::CPP
```

##Synopsis of usage
__note__: The first time you run these programs a folder (_Inline or .inline) will appear. Don't delete this as it holds libraries for portions of the program.


__Create our manifests__:
```bash
./MakeChunks --files Genomes/*.fa --chunk_size 200
```

__Run them from a single node__:
```bash
parallel '../CalculateDistances --manifest {}' ::: *.man
```
__Run them from slurm__:
```bash
sbatch --array=0-max Array_Submit.slrm
```

__Combine and Plot__:
```bash
ls Genomes/*.fa | wc -l 
$ 28
../CombineChunks --max_elements 28 --files *.mtx --out join.mtx
```

##Outputs of the run
__mtx files__:
These contain the calculated distances in a tab delimited format

__join.mtx__:
This contains all of the ```mtx``` files as a true matrix with header. 

__test_join.mtx.png__:
This is the heatmap generated from join.mtx
 
A big run will look a little something like this:

![Big Heatmap](Extras/heatmap.png)


#Scripts

## CalculateDistances

The core program. Currently runs mummer and retrieves MUMs , filters overlapping MUMs and keeping the longest alignment between any two overlapping MUMs, then calculates distance as the average calculated distance between 
reciprical MUMmer runs. Where a single distance metric is:

	2 * (Total Identical Nucleotides) / (Length of MUMs from Reference) + (Length of MUMs from Query) 


__Usage__:

```bash
  ./CalculateDistances --manifest <options>
```

__Options__:

--manifest : The manifest file to operate on
  
## MakeChunks

Given a large number of files splits the work into many manifests so that analysis can be spread across many processes.

__Usage__ : 

```bash
./Split__Manifests --files *.fa --chunk 10000
```
__Options__: 

--files : files you wish to be broken up in to sub manifests

--chunk : how big of a chunk you want each manifest to take up. 

## CombineChunks
```
./CombineChunks --max_elements <int> --files <files> --out join.mtx
```

__Options__:
--max_elements : The number of samples you have

--files : files to join

--out : name of the file for your final matrix

Combines mtx files in the pair format to a singular matrix , performs clustering, and outputs a heatmap. 

##Array_Submit.slrm
SLURM job file for array jobs. You'll want to know the number of the last manifest in a split to use this.

__Usage__:
```bash
sbatch --array=1-last__manifest Array__Submit.slrm
```

__Options__:
	Anything you can edit in sbatch you can edit here. 


  


