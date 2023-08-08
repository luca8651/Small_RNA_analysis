#!/usr/bin/perl -w
use strict;
my $input = shift;
my $size =shift;
my $name = shift;
	if ( (!$name) || (!$input) || (!$size) ){
	print STDERR "$0: A script to output sRNA base coverage from a sRNA/miRNA alignment file (align_reads_to_hairpins.pl)\n";
	print STDERR "$0: <input alignment file> <number of genome matching reads in sample (enter X for no normalisation)> <sample name>\n";
	exit();
	}
open (IN, "$input");
my %out;
my %length;
my %distribution;
my $acc;
my $start = 1;
my $last_acc="";
my $max = 0;
my $position2=0;
my $cont=0;


while (<IN>){

$position2=0;
$cont=$cont+1;

# if (eof()) {
# foreach my $position (sort { $a <=> $b } keys %distribution){
 #                       my $abundance = $distribution{$position};
  #                              unless (($size eq 'x') || ($size eq 'X')){
   #                             $abundance = ($abundance/$size)*10000000;
    #                            }
     #                   print "$abundance\t";
     #                   $position2=$position; #$abundance = &log_base(2, ($abundance+1));
                        #print "$abundance\n";
     #                   }

#	    }

	if    (($_=~m/(\S+\/\d+\-\d+\S+\s*\S*)/) || ($_=~m/(\S+\_\d+\-\d+\S+\s*\S*)/)){  #(($_=~m/(dre\S+\s*\S*)/) || ($_=~m/(\S+\/\d+\-\d+\S+\s*\S*)/) || ($_=~m/(\S+\_\d+\-\d+\S+\s*\S*)/)){
	$acc = $1;
	chomp $acc;
		if($acc =~m/(\S+)\/(\S+)\s+(\S+)/){
		my $name = $1;
		my $startend = $2;
		my $id = $3;
		$acc = "$name"."_"."$startend"."_"."$id";
		}
		elsif ($acc =~m/(\S+)\/(\S+)/){
		my $name = $1;
		my $startend = $2;
		$acc = "$name"."_"."$startend";
		}
		unless ($cont == 1 )  { print "$last_acc\_$name\t"; }
			foreach my $position (sort { $a <=> $b } keys %distribution){
			my $abundance = $distribution{$position};
				unless (($size eq 'x') || ($size eq 'X')){
				$abundance = ($abundance/$size)*10000000;				
				}
			print "$abundance\t";
			$position2=$position; #$abundance = &log_base(2, ($abundance+1));
			#print "$abundance\n";
			}
	
	unless ($cont ==1 )		{
       while ($position2<199) {
       print "0\t";
       $position2=$position2+1;
       }  

	print "0\n";
					}

		undef %distribution;
	$last_acc = $acc;
	$start = 0;
	#print "hey! $last_acc";

	}
	elsif ($_=~m/\(/){
	next;
	}
	elsif ($_=~m/^([A-Za-z]+)$/){
	my $tmp = $1;
	chomp $tmp;
	my @hairpin = split(//, $tmp);
	my $i = 1;
		foreach my $element (@hairpin){
		$distribution{$i}=0;
		$i++;
		}
	$max = $i;
	}
	elsif ($_ =~m/^(\.*\w+\.*)\s+(\S+)/){
	my $line = $1;
	my $abundance = $2;
	my @seq=split(//,$line);
	my $i = 1;
		foreach my $base (@seq){
	 	chomp($base);
	 		unless (($base eq '.') || ($i >= $max)){
	 		$distribution{$i}+=$abundance;
	 		}
	 	$i++;
	 	}
	}

}

sub log_base {    
my ($base, $value) = @_;
return log($value)/log($base);
}


print "$last_acc\_$name\t";

 foreach my $position (sort { $a <=> $b } keys %distribution){
                        my $abundance = $distribution{$position};
                                unless (($size eq 'x') || ($size eq 'X')){
                                $abundance = ($abundance/$size)*10000000;
                                }
                        print "$abundance\t";
                        $position2=$position; #$abundance = &log_base(2, ($abundance+1));
                        #print "$abundance\n";
                        }


 unless ($cont ==1 )             {
       while ($position2<199) {
       print "0\t";
       $position2=$position2+1;
       }

               			 }
        print "0\n";
