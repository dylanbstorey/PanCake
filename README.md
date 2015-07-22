# Genome2GenomeDistance

`nucmeer file1 file2 `
`show-coordes out.delta`

#show co-ords output
[S1] start of the alignment region in the reference sequence
 [E1] end of the alignment region in the reference sequence
 [S2] start of the alignment region in the query sequence
 [E2] end of the alignment region in the query sequence
 [LEN 1] length of the alignment region in the reference sequence
 [LEN 2] length of the alignment region in the query sequenc
e
 [% IDY] percent identity of the alignment
 [% SIM] percent similarity of the alignment
 [% STP] percent of stop codons in the alignment
 [LEN R] length of the reference sequence
 [LEN Q] length of the query sequence
 [COV R] percent alignment coverage in the reference sequenc
e
 [COV Q] percent alignment coverage in the query sequence
 [FRM] reading frame for the reference and query sequence alignments respectively
 [TAGS] the reference and query FastA IDs respectively.
 All output coordinates and lengths are relative to the forward strand
 
 (i) MUMi formula
 MUMs are maximal unique exact matches shared by two sequences. Fast algorithms, such as the one implemented in Mummer, allow the calculation in a few seconds of the list of all such matches shared by two genomes, taking into consideration the forward, as well as the reverse, strand of the target genome (23). The calculation in version 3 of Mummer is based on suffix arrays, which are built in linear time and linear space (23). As suggested by others (6), a naïve distance called MUMi can be derived from this MUM list, using the following formula: MUMi = 1 − Lmum/Lav, where Lmum is the sum of the lengths of all nonoverlapping MUMs and Lav is the average length of the two genomes to be compared. Values close to 0 signify very similar sequences, whereas values close to 1 are obtained for distant genomes. An important posttreatment of the MUM list is applied to remove all overlaps between MUMs, so that the distance never becomes negative (see below).

In designing the MUMi formula, we chose to divide Lmum by Lav. Other calculations aiming at estimating global distances between all kinds of bacterial genomes have used the size of the shorter genome of the pair, Lmin (16, 28). The use of Lav instead allows a greater sensitivity to variations due to gene loss and gene acquisition (as is necessary between close relatives). Lav has been reported to perform better for tree estimations based on BLAST high-scoring pairs (1). It should be noted that the two kinds of differences between genomes, i.e., originating from vertical evolution or from horizontal transfer, contribute to the MUMi value.

(ii) Generation of the MUM list.
For each genome pair, the list of MUMs was generated using Mummer3 software (http://mummer.sourceforge.net/manual/), with the following options: −mum, −b, −c, and −l19 (unless otherwise stated). Option −b allows the recovery of MUMs present on both strands of the target sequence and hence takes into account DNA inversions. Parameter l is the minimal length of MUM to be detected, called k in this paper (see Results for its choice). We tested the effect of removing the constraint on uniqueness of the MUMs so as to get MEMs (maximal exact matches) by cancelling the option −mum. This did not significantly change the results: an average difference of 0.00069 was measured on 638 pairs of bacterial genomes tested. We therefore chose to do calculations with MUMs.

(iii) Removal of MUM overlaps.
Mummer detects matches that may not be unique, as the uniqueness criterion is examined independently on forward and reverse strands of the target genome being compared to the query sequence. This explains the presence of spurious matches that need to be removed or trimmed. A script was written in Perl to trim overlapping MUMs and to calculate the MUMi value (see the supplemental material). Taking as the entry the Mummer3 output file and the lengths of both genomes (called hereafter g1 and g2), it first trims the MUMs and then calculates the MUMi.

An exact solution for trimming overlapping segments, originally designed for BLAST outputs, is available (13). However, it is time-consuming, and the problem with MUMs is less complex because hits have the same length on the two genomes being compared. We therefore designed an approximate solution with the following steps. (i) Remove MUMs whose coordinates on g1 (or on g2) are completely included in a larger MUM (this is made possible by the fact that in Mummer3, the uniqueness of each MUM is defined according to one strand only). (ii) Remove MUMs whose coordinates on g1 (or on g2) are completely included in two neighboring MUMs. (iii) Treat the remaining MUMs of g1 (or g2) that exhibit partial overlap. To do this, MUMs are ordered according to their beginning positions on g1 (or on g2), and starting from the last element of the list, each MUM is compared to its neighbor. In cases of overlap, the end of the leftward MUM is trimmed, i.e., its end coordinates on both g1 and g2 are shifted so that no overlap exists on g1 (or on g2). This is the part of the script that creates asymmetry, because a different solution is created when g2 is treated before g1. The level of asymmetry was tested on an E. coli genome pair (MG1655 versus CFT073), and the difference was negligible (0.002% difference between the two MUMi values). We then tested two genome pairs suspected to be difficult cases because of abundant repeat sequences (Table ​(Table1).1). A maximal difference in the MUMi estimate was reached with the Shigella flexneri 2a pair. The absolute difference was small (0.0011), but relative to the MUMi value of this pair, which was also small, it resulted in a 2.7% difference between the two MUMi values. We decided that the average of the two MUMi values obtained depending on which genome was treated first was a reasonable way to force symmetry, and the MUMi was therefore calculated by this average. A web interface for calculating MUMi is under construction, and its address will be posted at http://www.jouy.inra.fr/ublo.
