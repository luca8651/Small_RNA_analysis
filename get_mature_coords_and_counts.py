#!/usr/bin/env python3.5
import csv
import os
import re
import sys
dir_fd = os.open('/usr/users/ga002/pensodl/', os.O_RDONLY)
filename = sys.argv[1]
names=[]
ages=[]
cont=0
plus='+'
fivep=0
threep=0
cont2=0
#with open('data.csv','r') as f:
with open(filename, "r") as f:
	for line in f:
		match = re.search('/', line)
		if match:
			cont2=cont2+1

			if cont2>1:
				
				if count5>=count3:

					print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart1)+'\t'+str(newend1)+'\t5p\tmiRNA\t'+str(count5)+'\t'+str(startseed)+'\t'+str(endseed))
					print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart2)+'\t'+str(newend2)+'\t3p\tstar\t'+str(count3)+'\t'+str(startseed2)+'\t'+str(endseed2))	
				else:
					print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart1)+'\t'+str(newend1)+'\t3p\tmiRNA\t'+str(count3)+'\t'+str(startseed)+'\t'+str(endseed))
					print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart2)+'\t'+str(newend2)+'\t5p\tstar\t'+str(count5)+'\t'+str(startseed2)+'\t'+str(endseed2))
				
			

			count3=0
			count5=0
			fivep=0			#used to print only the coords of the most abundant fivep read
			threep=0
			cont=1
			newstart1=0
			newend1=0
			newstart2=0
			newend2=0
			startseed=0
			endseed=0
			startseed2=0
			endseed2=0
			name=line[0:len(line)-1]
			string1=line.split("_",1)
			match=re.search('\)', string1[0])
			#print("hey",match)
			if match!=1:
				string2=string1[0]+string1[1]
			else:
				string2=string1[0]
			#print(string2)
			#print(string1)
			#string2=string1[0]
			string3=string2.split("-",1)
			string31=string3[1]
			string32=string31.split("(",1)
			end=string32[0]
			strand=string32[1]
			string34=string3[0]
			string34=string34.split("/",1)
			chrom=string34[0]
			strand=strand[0]
			string4=string3[0]
			string5=string4.split("/",1)
			start=string5[1]
			#print(line[0:-1]+'\t'+string1[0]+'\t'+string3[0]+'\t'+start+'\t'+end+'\t'+strand+'\t'+chrom)
			#print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t')
		elif cont==1:
			cont=2
			length=len(line)
			center=(len(line)-1)/2
		elif cont==2:
			first=0
			start1=1
			end1=1
			for i in range(0,len(line)-1):
				match=re.search('[ATGC]', line[i])
				if match and first==0:
					#print(str(i)+'hey'+line[i])
					start1=i
					first=1
				elif match and first:
					end1=i
				
			#print(str(center)+'\t'+str(start1)+'\t'+str(end1))
			cont=3							#this means that most abundant read has benn found 
			
			string6=line.split("\t",1)
			if start1<center and fivep==0:
				fivep=1
				if strand == plus:
					newstart1=int(start)+start1
					newend1=int(start)+end1
					startseed=int(newstart1)+1
					endseed=int(newstart1)+7
				else:
					newend1=int(end)-start1
					newstart1=int(end)-end1
					endseed=int(newend1)-1
					startseed=int(newend1)-7
				#print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart1)+'\t'+str(newend1)+'\t5p\tmiRNA')
			elif start1>center and threep==0:
				threep=1
				if strand == plus:
					newstart1=int(start)+start1
					newend1=int(start)+end1
					startseed=int(newstart1)+1
					endseed=int(newstart1)+7
				else:
					newend1=int(end)-start1
					newstart1=int(end)-end1
					endseed=int(newend1)-1
					startseed=int(newend1)-7
				#print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart1)+'\t'+str(newend1)+'\t3p\tmiRNA')

			match=re.search('\t', line)
			if match:
				string6=line.split("\t",1)
				if start1<center:
					count5=count5+int(string6[1])
				elif start1>center:
					count3=count3+int(string6[1])  



		elif cont==3:
			first=0
			start2=1
			end2=1
			for i in range(0,len(line)-1):
				match=re.search('[ATGC]', line[i])
				if match and first==0:
					#print(str(i)+'hey'+line[i])
					start2=i
					first=1
				elif match and first:
					end2=i
				
			#print(str(center)+'\t'+str(start2)+'\t'+str(end2))
			
			if start2<center and fivep==0:
				fivep=1
				if strand == plus:
					#print('hey')
					newstart2=int(start)+start2
					newend2=int(start)+end2
					startseed2=int(newstart2)+1
					endseed2=int(newstart2)+7
				else:
					newend2=int(end)-start2
					newstart2=int(end)-end2
					endseed2=int(newend2)-1
					startseed2=int(newend2)-7
				#print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart2)+'\t'+str(newend2)+'\t5p\tstar')
			elif start2>center and threep==0:
				threep=1
				if strand == plus:
					#print('yeey')
					newstart2=int(start)+start2
					newend2=int(start)+end2
					startseed2=int(newstart2)+1
					endseed2=int(newstart2)+7
				else:
					newend2=int(end)-start2
					newstart2=int(end)-end2
					endseed2=int(newend2)-1
					startseed2=int(newend2)-7
				
				#print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart2)+'\t'+str(newend2)+'\t3p\tstar')

			#if fivep and threep:
			#	cont=4

			match=re.search('\t', line)
			if match:
				string6=line.split("\t",1)
				if start2<center:
					count5=count5+int(string6[1])
				elif start2>center:
					count3=count3+int(string6[1])

					
				
			
		#elif cont==4:
			
if count5>count3:

	print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart1)+'\t'+str(newend1)+'\t5p\tmiRNA\t'+str(count5)+'\t'+str(startseed)+'\t'+str(endseed))
	print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart2)+'\t'+str(newend2)+'\t3p\tstar\t'+str(count3)+'\t'+str(startseed2)+'\t'+str(endseed2))	
else:
	print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart1)+'\t'+str(newend1)+'\t3p\tmiRNA\t'+str(count3)+'\t'+str(startseed)+'\t'+str(endseed))
	print(chrom+'\t'+start+'\t'+end+'\t'+strand+'\t'+name+'\t'+str(newstart2)+'\t'+str(newend2)+'\t5p\tstar\t'+str(count5)+'\t'+str(startseed2)+'\t'+str(endseed2))		
									
		
	
#    next(f) # skip headings
#    reader=csv.reader(f,delimiter='\t')
#    for name,age in reader:
#       names.append(name)
#        ages.append(age) 

#print(names)
# ('Mark', 'Matt', 'John', 'Jason', 'Matt', 'Frank', 'Frank', 'Frank', 'Frank')
#print(ages)
# ('32', '29', '67', '45', '12', '11', '34', '65', '78')
#print(names.index("Luca"))
#for w in names:
#	match = re.search('uc', w)
#	if match:
#		for n in range(0,len(names)-1):
#			print(names[n] , w , int(ages[n])-int(ages[names.index("Luca")]))
#			
#		print(w +' is a match')
#	if len(w) > 4:
#		print(w +' is a longer name')
#	else:
#		print(w +' is a short name')


		
