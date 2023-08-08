# Small_RNA_analysis
Mix of code used to analyse small RNA read data


## get_flanking_genes_from_coordinates.pl

identify the closest flanking protein coding genes based on a list of genomic coordinates:
get_flanking_genes_from_coordinates.pl annotation.bed  coordinate_list.txt

*annotation.bed* : genome annotation in BED format. This can be created from an Ensembl GTF file with the following command:

```
cat Homo_sapiens.GRCh38.99.chr.gtf  | awk -F "\t" 'BEGIN{OFS="\t"}{print $1,$4,$5,$3,$9,$7}' | grep -v "#" | tr -d " " > annotation.bed
```

*coordinate_list.txt* : list of genomic coordinates of interest (one per line) in the following format: chr/start-end(+/-)

output is a table indicating, for each coordinate of interest: 1) the closest flanking protein coding gene upstream 2) closest flanking protein coding gene downstream. If the coordinate completely lies inside a gene, this gene is reported. The output also indicates whether the gene lies on the same or opposite strand compared to the genomic coordinate of interest.


## micro_RNA_hairpin_read_counts.pl

Input is an alignment file representing the alignments of small RNA reads against one or multiple hairpins (see example below). A header of the form "chromosome/start-end(strand)_description" is expected, followed by the hairpin sequence on the next line. Each of the following lines represents an aligned small RNA read and the corresponding count (separated by a tab). The alignment entry then ends with a line representing the predicted secondary structure (from the ViennaRNA package), followed by the minimum free energy (separated by a tab).

```
X/50661951-50662015(+)_Dog_novel_microRNA
GTCTTGGCGCGACTTCCTCGACTCACTCTCTTTCCCCCGTGAGTCGTGGAACCTCGCCCGAGGGT
.......................................TGAGTCGTGGAACCTCGCCCGA....	83

.........................................AGTCGTGGAACCTCGCCCGAG...	9

.........................................AGTCGTGGAACCTCGCCCGA....	6

.........................................AGTCGTGGAACCTCGCCCGAGG..	5

...TTGGCGCGACTTCCTCGACTC.........................................	4

....TGGCGCGACTTCCTCGACT..........................................	3

....TGGCGCGACTTCCTCGACTCACT......................................	3

.......................................TGAGTCGTGGAACCTCGCCC......	3

.......................................TGAGTCGTGGAACCTCGCCCGAG...	3

....TGGCGCGACTTCCTCGACTCA........................................	2

.......................................TGAGTCGTGGAACCTCGCCCG.....	2

...TTGGCGCGACTTCCTCGACT..........................................	1

....TGGCGCGACTTCCTCGACTC.........................................	1

....TGGCGCGACTTCCTCGACTCAC.......................................	1

...TTGGCGCGACTTCCTCGACTCACT......................................	1

.......CGCGACTTCCTCGACTCACT......................................	1

..............................TTTCCCCCGTGAGTCGTGGAACC............	1

........................................GAGTCGTGGAACCTCGCCCGA....	1

..................................CCCCGTGAGTCGTGGAACCTCGCCCGAGG..	1

...................................CCCGTGAGTCGTGGAACCTCGCCCGAGG..	1

.....................................CGTGAGTCGTGGAACCTCGCCCGAGG..	1

......................................GTGAGTCGTGGAACCTCGCCCGAGGGT	1

.((((((.((((.((((.((((((((............)))))))).))))..)))))))))).. (-31.20)
```

The output is a TAB delimited table with the following columns:
```
microRNA_locus_ID,strand1,strand1_count,strand2,strand2_count
```

For the example provided we get:

```
X/50661951-50662015(+)_Dog_novel_microRNA	5'	17	3'	116
```


## get_mature_coords_and_counts.py

This script takes as input an alignment in the same format required for *micro_RNA_hairpin_read_counts.pl*
Using the coordinate information included in the first row of each alignment (*chromosome/start-end(strand)_description*), as well as the alignment itself, it can
calculate the genomic position where the miRNA-5p and miRNA-3p have been mapped, as well as calculate their abundance.



Output format is the following:
```
X	50661951	50662015	+	X/50661951-50662015(+)_Dog_novel_microRNA	50661990	50662011	3p	miRNA	116	50661991	50661997

X	50661951	50662015	+	X/50661951-50662015(+)_Dog_novel_microRNA	50661954	50661974	5p	star	18	50661955	50661961
```

## plot_abundance_Wedd_Seal.r
This R script can be used to generate abundance plots for a set of microRNA loci (hairpin sequences) across different samples. The script takes as input one or multiple alignments of small RNA reads to an hairpin sequence, provided in the same format accepted by script *micro_RNA_hairpin_read_counts.pl*.

One plot for each locus is generated, where each line represents the read coverage across the locus for a specific sample. The uploaded version is written specifically for the microRNA annotation (and expression data) presented in Penso-Dolfin et al. 2020 (https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-020-6675-0, see also Supplemetary data)


## make_redundant.pl
usage: make_redundant.pl small_rna_data.fa

This script takes as input a non redundant (that is, each sequence appears only once) list of small RNA reads in FASTA format, and converts it into redundant format (each sequence appears as many times as its count in the sample).
Each sequence entry in the input file must have the following format:

```
>[sequence](count)

[sequence]
```

For example:

```
>TTGGCGCGACTTCCTCGACTC(5)

TTGGCGCGACTTCCTCGACTC
```

The output is the redundant list of sequences.  Using the same example, entry

```
>TTGGCGCGACTTCCTCGACTC(5)

TTGGCGCGACTTCCTCGACTC
```

will be converted into

```
>TTGGCGCGACTTCCTCGACTC

TTGGCGCGACTTCCTCGACTC

>TTGGCGCGACTTCCTCGACTC

TTGGCGCGACTTCCTCGACTC

>TTGGCGCGACTTCCTCGACTC

TTGGCGCGACTTCCTCGACTC

>TTGGCGCGACTTCCTCGACTC

TTGGCGCGACTTCCTCGACTC

>TTGGCGCGACTTCCTCGACTC

TTGGCGCGACTTCCTCGACTC
```


