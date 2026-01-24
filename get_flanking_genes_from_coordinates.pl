#!/usr/bin/perl -w

use strict;
use warnings;
use Data::Dumper qw(Dumper);
use List::Util qw(min max);


my $lines = shift; 
my $coordall = shift;

	if ( (!$lines) || (!$coordall) ){
	print STDERR "$0: A script to identify identify the closest flanking protein coding genes based on a list of genomic coordinates\n";
	print STDERR "$0: <genome_annotation.bed> <genomic coordinates.txt>\n";
    print STDERR "the genome annotation file in BED format can be created from an Ensembl GTF file:\n";
    print STDERR "cat Homo_sapiens.GRCh38.99.chr.gtf  | awk -F \"\\t\" \'BEGIN{OFS=\"\\t\"}{print \$1,\$4,\$5,\$3,\$9,\$7}\' | grep -v \"#\" | tr -d \" \" > annotation.bed \n";
    print STDERR "coordiantes.txt contains a list of genomic coordinates, one in each row, with format chr/start-end(strand)\n";
	exit();
	}

my $chr; 
my $miRNA_start; 
my $miRNA_end; 
my $strand; 
my $count;
my @array;
my $num;
my $found_right=0;
my $found_left=0;
my $geneLeft=0;
my $geneRight=0;
my $geneContainer=0;
my $found_container=0;
###
my @array2;
my @array3;
my $coord;
my $i;
my $test;
my $lineRight;
my $lineLeft;
my $lineContain;

my $test1;
my $test2;


open (FILE2,  "$coordall" ) or die "can't open : $!";

while (  <FILE2>) {

$found_container=0;
$found_right=0; 
$found_left=0;

$coord=$_;
$coord=substr($coord,0,length($coord)-1);

@array2=split(/\//, $coord);    #12	100-160(+)
$chr=$array2[0];

$miRNA_start=$array2[1];   
@array2=split(/\-/, $miRNA_start);      # 100	160(+)
$miRNA_start=$array2[0];


$miRNA_end=$array2[1];           #160(+)
$strand="+";

if (index($miRNA_end,$strand)!=-1 ) {

}
else   {
$strand="-";
}

@array2=split(/\(/, $miRNA_end);    #160	+)
$miRNA_end=$array2[0];



open (FILE,  "$lines" ) or die "can't open : $!";

while (my $line = <FILE>) {  



$line=substr($line,0,length($line)-1);

@array=split(/\t/, $line);



if ( $line =~/protein/ && $array[3] eq "gene" && $array[2]< $miRNA_start && $array[0] eq $chr   ) {

$lineLeft=$line;
@array3=split(/\t/, $line);
$geneLeft=$array3[4];
@array3=split(/\;/, $geneLeft);
$found_left=1;
$i=@array3-1;

while ($i>=0)      {

if ( ( $array3[$i]=~/name/ && $array3[$i]=~/gene/ ) || ($array3[$i]=~/Name=/) ) 
                       { 
$geneLeft=$array3[$i];

$geneLeft=~ s/Name//;
$geneLeft=~ s/gene_id//;
$geneLeft=~ s/gene_name//;

$geneLeft=~ tr/"//;
$geneLeft=~ tr/=//;

                       }
$i=$i-1;
			  }



                           }
elsif ($line =~/protein/ && $array[3] eq "gene" && $array[1]> $miRNA_end  && $array[0] eq $chr  && $found_right == 0    )                {

$lineRight=$line;
@array3=split(/\t/, $line);
$geneRight=$array3[4];
$found_right=1;

@array3=split(/\;/, $geneRight);

$i=@array3-1;

while ($i>=0)      {

if ( ( $array3[$i]=~/name/ && $array3[$i]=~/gene/ ) || ($array3[$i]=~/Name=/) ) 
                       { 
$geneRight=$array3[$i]; 
$geneRight=~ s/Name//;
$geneRight=~ s/gene_name//;
$geneRight=~ s/Name//;
$geneRight=~ s/gene_id//;
$geneRight=~ tr/"//;
$geneRight=~ tr/=//;



                       }
$i=$i-1;
			  }



                            }

elsif ($line =~/protein/ && $array[3] eq "gene" && $array[1]< $miRNA_start &&  $array[2]> $miRNA_end && $array[0] eq $chr && $found_container==0 )                {

$lineContain=$line;
@array3=split(/\t/, $line);
$geneContainer=$array3[4];

$found_container=1;

@array3=split(/\;/, $geneContainer);

$i=@array3-1;

while ($i>=0)      {

if ( ( $array3[$i]=~/name/ && $array3[$i]=~/gene/ ) || ($array3[$i]=~/Name=/)  ) 
                       { 
$geneContainer=$array3[$i]; 


$geneContainer=~ s/Name//;
$geneContainer=~ s/gene_id//;
$geneContainer=~ s/gene_name//;

$geneContainer=~ tr/"//;
$geneContainer=~ tr/=//;



                             }
$i=$i-1;
			  }





		}

}


close($lines);


if ( $strand eq "+" )                  {

if ( $found_left  )  {
print "$coord\t$geneLeft\_Upstream\t$lineLeft\n";
}

if ( $found_container  )  {

print "$coord\t$geneContainer\_host\t$lineContain\n";
}

if ( $found_right ) {
print "$coord\t$geneRight\_Downstream\t$lineRight\n";
}

                                         }

else                                     {


if ( $found_right ) {
print "$coord\t$geneRight\_Upstream\t$lineRight\n";
}

if ( $found_container  )  {

print "$coord\t$geneContainer\_host\t$lineContain\n";
}

if ( $found_left  )  {
print "$coord\t$geneLeft\_Downstream\t$lineLeft\n";
}


                                         }

}

