#!/usr/bin/perl -w use Text::CSV_XS;
use strict; use warnings; use Data::Dumper qw(Dumper);
#use Bio::SeqIO;
use List::Util qw(min max);
#use File::Slurp;
my $lines = shift;
my $seq;
my $ind;
my $ind1;
my $ID;
my $L;
my $ind2;
my $count;

open (FILE,  "$lines" ) or die "can't open : $!";

my $cont=0;

my $first=1;

while (my $line = <FILE>) {  


$ind=index($line,">");


if ( eof  ) {

#print "$ID\t$cont\n";

}

elsif ( $ind == -1 )  {   #sequence
$L=length($line)-1;
#$cont=$cont+$L;


$first=2;
}
#elsif ($first==1) {  $ID=substr($line,1,length($line) -2);     }       #first line

#elsif ($first>1 )  {     #ID 
else     {
#print "$ID\t$cont\n";  #print information about previous 2 lines
$ID=substr($line,1,length($line) -2);
$ind1=index($line,"(")+1;
$ind2=index($line,")")-1;
$count=substr($line,$ind1,$ind2-$ind1+1);
$seq=substr($line,1,$ind1-2);
#print "count is $count\n";

$cont=0;
 while ($cont<$count) { 

print ">$seq\n$seq\n";
$cont++;
          }






}


}
close ($lines);
