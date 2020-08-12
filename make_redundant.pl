#!/usr/bin/perl -w
use strict; use warnings; use Data::Dumper qw(Dumper);
use List::Util qw(min max);
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



if ( eof==0 && $ind == -1 )  {   #sequence
$L=length($line)-1;
$first=2;
}

elsif (eof==0)     {
$ID=substr($line,1,length($line) -2);
$ind1=index($line,"(")+1;
$ind2=index($line,")")-1;
$count=substr($line,$ind1,$ind2-$ind1+1);
$seq=substr($line,1,$ind1-2);

$cont=0;
 while ($cont<$count) { 

print ">$seq\n$seq\n";
$cont++;
          }



}


}
close ($lines);
