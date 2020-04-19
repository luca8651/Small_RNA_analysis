#!/usr/bin/perl -w

use strict;
use warnings;
use Data::Dumper qw(Dumper);
#use Bio::SeqIO;
use List::Util qw(min max);
#use File::Slurp;
my $lines = shift;
open (FILE,  "$lines" ) or die "can't open : $!";
#

my $print=1;
my $char="/";
my $iscoord=0;
my $offset=0;
my $result1=0;
my $result=0;
my $start=0;
my $end=0;
my $start2=0;
my $end2=0;
my $i=0;
my $comp=0;
my $line2="string";
my $letter="l";
my $sbstr="a";
my $sbstr2="a";
my $coord1="a";
my $coord2="a";
my $ind1=1;
my $ind11=1;
my $ind2=1;
my $ind22=1;
my $ind23=1;
my $ind24=1;
my $ind25=1;
my $indscore=1000;
my $diff=0;
my $newcoord1=1;
my $newcoord2=1;
my $strand='*';
my @coordmat;
my $cont=1;
my $expr_index=0;
my $chr='0';
my $ID='ID';
my @expr_count=(0,0,0);
#my $track_name;
my $count;
my $print2=1;
my $hairp_centre;
my $fivecount;
my $threecount;
my $three;
my $five;
my $cont2=0;
my $sbstr1='b';
my $print3=1;
my $print4=1;

$ind1 = rindex($lines, "/") +1;

while ( my $line=<FILE>)  {
  
    
    if  ( index($line,"/")==-1 && $line=~ /\./  && $line=~ /\)/  &&  $line=~ /\(/ )     #line of secondary structure
  
   {  print "$line2\t5'\t$fivecount\t3'\t$threecount\n"; 
    
     }

    elsif ($line=~ /\//)   
    {
    

    $sbstr='a';
    $sbstr1='b';
    $cont2=$cont2+1;

    $line2=substr($line,0,length($line)-1);
     
    $print=1;
    $print2=1;
    $fivecount=0;
    $threecount=0;
    $three=0;
    $five=0;

          
        
     $ind1 = index($line, "/") +1;
     $ind2=index($line, "-");
     $coord1=substr($line,$ind1,$ind2 - $ind1 );
     $chr=substr($line,0,$ind1-1);
     #$ID=substr($line,0,length($line)-1);

     $ind24=index($line," ");
     $ind25=index($line," ",$ind24+1);
     $ID=substr($line,$ind24+1,$ind25-3-1-$ind24); 
     

         
     $ind11 = index($line, "-") +1;
     $ind22 = index($line, "(");
     $ind23 = index($line, ")");
     $coord2=substr($line, $ind11, $ind22 - $ind11 );
     $strand=substr($line,$ind22+1,$ind23-1-$ind22);
     $coord2=substr($line, $ind11, $ind22 - $ind11 );
  
     $diff = $coord2 - $coord1;
     
     $iscoord=1;
     }
     elsif ($iscoord == 1 )
           {
            #print $line;  
            $iscoord=$iscoord+1;
     }
     elsif ($iscoord == 2 && ( $line=~ /A/ || $line=~ /T/ || $line=~ /G/ || $line=~ /C/)  )
           {
            #print $line;            #this is the line of the most abudant read
            @expr_count= (0);        #count the number of times each base appears
           
           $i=rindex($line,"	")+1;

           $count=substr($line,$i,length($line)-$i);   #+1?

           $i=index($count,"\n");
           
           $count=substr($count,0,$i);
           #print "$count\t";          

           
           $print2=0;               #indicates the presence of at least one read

            $i=0;
           
            $offset=0;
            $result1 = index($line, ".");            
            
            $iscoord=3;

        if ($result1==0 ) {  #first symbol is a dot
        
       $i=0;
          
       $letter=substr($line,$i,1);
       
       while ( $letter eq "." && $i<=length($line) )   {

               $i=$i+1;
               $letter=substr($line,$i,1);
                               
                }
        
        $start=$i+1;                 
        
        $comp= substr($line,$i,1) ne "." && substr($line,$i,1) ne "	";
                
        while ($comp && $i<=length($line) )   {
               
               $comp= substr($line,$i,1) ne "." && substr($line,$i,1) ne "	";
              
               $i=$i+1; 
                }

        $end=$i-1;
     
                  
        }   #



        

        else             {
        $start= 0;   
        $end= $result1;   #index starts at zero, so $result1 +1-1 = $result1
        }    
        
        

           
            $sbstr=substr($line,$start,$end-$start);
            #print "string is $sbstr\n";

            $sbstr2=substr($line,$expr_index,$expr_index+3);
          
            if ($start==0) {
            $newcoord1=$coord1;
            $newcoord2=$coord1+$end-1;
            $sbstr=substr($line,$start,$end-$start);
            #$sbstr=substr($line,$start+1,7);
            }
            else           {
            $newcoord1=$coord1+$start-1;             #in this case $start is the exact position of the first letter
            $newcoord2=$coord1+$end-1;
            $sbstr=substr($line,$start-1,$end-$start+1);   #indexing starts from zero
            #$sbstr=substr($line,$start,7);
            }
            
            $hairp_centre=(length($line)-1)/2;
            
            #print "test:$start-$end-$hairp_centre\n";
            
            #print "substr is $sbstr\n";

            if ($start> $hairp_centre )  {
            #$sbstr=substr($line,$start+1,7);
            
            $threecount=$threecount+$count; 
            $three=1;
            }
            elsif (  $end<$hairp_centre        )        {        #replacing "else"
            
            $sbstr1=substr($line,$start+1,7);  
            $fivecount=$fivecount+$count;   
            $five=1;                       
                                        }

            $cont=$cont+1;  
            #$iscoord=0;   
                    
     }

     
    elsif    (  $iscoord == 3   && ( $line=~ /A/ || $line=~ /T/ || $line=~ /G/ || $line=~ /C/)  )  { #( index($line, $A) != -1 || index($line, $T) != -1  || index($line, $G) != -1 || index($line, $C) != -1  ) )   {
        
    

       #this is a read following the most abundant
       #print "coord3 print is $print\n";

      if ( $print ==1 )                                 {
            $i=0;
           $offset=0;
            $result1 = index($line, ".");
            $iscoord= 3;


       if ( $result1==0) { 

       $i=0;

       $letter=substr($line,$i,1);

       while ( $letter eq "." && $i<=length($line) )   {

               $i=$i+1;
               $letter=substr($line,$i,1);

                }

        $start2=$i+1;      

       $comp= substr($line,$i,1) ne "." && substr($line,$i,1) ne "     ";

        while ($comp && $i<=length($line) )   {

               $comp= substr($line,$i,1) ne "." && substr($line,$i,1) ne "      ";

               $i=$i+1;
                }

        $end2=$i-1;

       #  print "line is $line, start2 is $start2, end2 is $end2\n";



                      }
        else          {

        $start2=0;
        $end2=$result1;
                      }


   

        $i=rindex($line,"	")+1;   
      
     $count=substr($line,$i,length($line)-$i);
     $i=index($count,"\n");
     #print "i is $i\n";
     $count=substr($count,0,$i);
    
     #print "count is $count\n";
     #print "substr is $sbstr\n";   # centre is $hairp_centre, start2 is $start2, end2 is $end2\n";


     if (  $start2>$hairp_centre  )   {  #  3' seq      
     
         
     $threecount=$threecount+$count;
     $three=1;# $print = 0;                                      
     }
     elsif  ($end2<$hairp_centre)  {

    
     $fivecount=$fivecount+$count;
     $five=1; # $print =0;                                   
     }
     else   {
     #print "overlap\t";
            }


     #$print = 0;  # removing this allows to look at miRNAstar after the second most abund read   
                                 
                                       }    #if print=1
        
            $i=0;
          
  
            





        } 


     elsif (  $iscoord == 3 )
     {
     
      #print "line is $line";
      
     if ($print==1){

     if ($print2==0) { 
     
     
     }
     else  {
    
           }

     }

     $iscoord=0;
      
          
     }
     elsif ( $iscoord ==2 )      {         
     
     if ($print == 1)  {

     if ($print2==0)  {
     
  

                      }
     else             {
  
    }
     if ( length($chr)<3 ) {
      #print "chr$chr\t$newcoord1\t$newcoord2\t$ID\t$indscore\t$strand\n";
                          }
      else             {
      $chr=substr($chr,0,length($chr)-2); 
     # print "chrUn_$chr\t$newcoord1\t$newcoord2\t$ID\t$indscore\t$strand\n";
                       }

    
     $print = 0;
           } 
     }

   }
close($lines);