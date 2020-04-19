# Small_RNA_analysis
Mix of code used to analyse small RNA read data


*get_flanking_genes_from_coordinates.pl*

identify the closest flanking protein coding genes based on a list of genomic coordinates:
get_flanking_genes_from_coordinates.pl annotation.bed  coordinate_list.txt

annotation.bed : genome annotation in BED format. This can be created from an Ensembl GTF file with the following command:
cat  Canis_familiaris.CanFam3.1.75.gtf  | awk '{print $1,$4,$5,$3,$6,$7}' | grep -v "#" | tr " " "\t" > Canis_familiaris.CanFam3.1.75.bed

coordinate_list.txt : list of genomic coordinates of interest (one per line) in the following format: chr:start-end(+/-)

output is a table indicating, for each coordinate of interest: 1) the closest flanking protein coding gene upstream 2) closest flanking protein coding gene downstream. If the coordinate completely lies inside a gene, this gene is reported. The output also indicates whether the gene lies on the same or opposite strand compared to the genomic coordinate of interest.


*micro_RNA_hairpin_read_counts.pl*

Input is an alignment file representing the alignments of small RNA reads against one or multiple hairpins (see example below). A header of the form "chromosome/start-end(strand)_description" is expected, followed by the hairpin sequence on the next line. Each of the following lines represents an aligned small RNA read and the corresponding count (separated by a tab). The alignment entry then ends with a line representing the predicted secondary structure (from the ViennaRNA package), followed by the minimum free energy (separated by a tab).

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

output:

microRNA haipirn header	5'	5'count	3'	3'count

For the example provided we get:

X/50661951-50662015(+)_Dog_novel_microRNA	5'	17	3'	116
