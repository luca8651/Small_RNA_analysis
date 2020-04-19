# Small_RNA_analysis
Mix of code used to analyse small RNA read data


*get_flanking_genes_from_coordinates.pl*

identify the closest flanking protein coding genes based on a list of genomic coordinates:
get_flanking_genes_from_coordinates.pl annotation.bed  coordinate_list.txt

annotation.bed : genome annotation in BED format. This can be created from an Ensembl GTF file with the following command:
cat  Canis_familiaris.CanFam3.1.75.gtf  | awk '{print $1,$4,$5,$3,$6,$7}' | grep -v "#" | tr " " "\t" > Canis_familiaris.CanFam3.1.75.bed

coordinate_list.txt : list of genomic coordinates of interest (one per line) in the following format: chr:start-end(+/-)
