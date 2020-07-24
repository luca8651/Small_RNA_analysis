
#data_abundance is a matrix of concatenated rows like this:
#mir1 blood
#mir 2 blood
#...
#mir n blood
#mir1 heart
#mir2 heart
#...
#mir n heart
require(lattice)

#Load expression table: columns are base positions across the miRNA hairpin; rows are miRNA loci)
data_abundance <- read.delim("Documents//Wedd_Seal/Tables/abundance_each_base_mirbase_names_final2_corrected31_lwe-miR.txt",header=0, row.names=1,sep="\t")


samples=c("brain_154113-micro_1","brain_154117-micro-Ce_1","brain_164022_1","brain_164023_1","brain_164024_1","brain_164025_1","heart_154102-micro_1","heart_154115-micro_1","heart_164011_1","heart_164012_1","heart_164013_1","heart_164014_1","muscle_154117-micro-Mu_1","muscle_164001_1","muscle_164003_1","muscle_164004_1","muscle_164005_1","muscle_164006_1","plasma_164386_1","plasma_164387_1","plasma_164388_1","plasma_164390_1","plasma_164391_1","plasma_164393_1")


#We have samples for both pups and adult individuals
age=c("pup","adult")


nsamples=length(samples);

nmir=length(data_abundance[,1])/nsamples;     #n, the numer of loci
x=1:nsamples;

for (h in 2:nsamples) {
x[h]=nmir*(h-1)+1;                       #this indicates the rows corresponding to same locus for diff tissues
}



lastr=length(data_abundance[,1]);

posvet2=1:length(data_abundance[1,]);

pdf("/Users/lucapensodolfin/Dropbox/Weddell_Seal/R1 BMC manuscript/Wedd_Seal_abundance_newnames_lwe-miR.pdf");

for ( i in 1:nmir )   {                     #i in 1:nmir      


name=rownames(data_abundance)[x[1]];

name22=unlist(strsplit(name,"\\)_"));
name22=name22[2];

name22=unlist(strsplit(name22[1],"_brain"))
name22=unlist(strsplit(name22[1],"_heart"))
name22=unlist(strsplit(name22[1],"_muscle"))
name22=unlist(strsplit(name22[1],"_plasma"))
name22=name22[1]
#name2=gsub("/",name,replacement = ":");
name2=unlist(strsplit(name,"_"));

name3=unlist(strsplit(name2[3],"\\("));

name3=unlist(strsplit(name3[1],"-"))

pos1=as.numeric(name3[1]);
pos2=as.numeric(name3[2]);


max_pos=pos2-pos1+2; 

name4=name22;    #paste(name2[1],name2[2],name22,sep="_");
#name4=gsub("Wedd_Seal_","",name4)

name2=paste(name2[1],name2[2],sep="_");

par(new=F);
#xyplot( 1:length(data_abundance[1,]) ~ data_abundance[x,] , type = c('l'),  auto.key=T)

legendline=c("solid","solid", "dashed","dashed", "dashed","solid", "dashed","solid", "solid","dashed", "solid","dashed","solid","dashed","dashed","solid","dashed","solid",  "solid","solid","solid","dashed","dashed", "dashed" );
#cont=1;
legendline2=c("dashed","solid")
colorvet=c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4)

for (i2 in as.numeric(1:nsamples)) {
if (i2==1) {
matplot( as.numeric(1:max_pos), as.numeric(data_abundance[x[i2],1:max_pos]), lty=legendline[i2], type = c("l"), col=colorvet[i2] , xlim=c(0,as.numeric(max_pos)), ylim=c(0,as.numeric(1.3*max(data_abundance[x,]) ) ) , xlab=c("bp position") , ylab=c("reads per million genome matching") , axes=1 ) ;
#legendline[i2]="solid";
}
else if (i2>8 && i2<=16) {
matplot( as.numeric(1:max_pos), as.numeric(data_abundance[x[i2],1:max_pos]), lty=legendline[i2], type = c("l"), col=colorvet[i2] , lwd=2, xlab="", ylab="", axes=F, xlim=c(0,as.numeric(max_pos)), ylim=c(0,as.numeric(1.3*max(data_abundance[x,]) ) )  ) ;
#legendline[i2]="longdash";
}
else if (i2>16 && i2<=24) {
matplot( as.numeric(1:max_pos), as.numeric(data_abundance[x[i2],1:max_pos]), lty=legendline[i2], type = c("l"), col=colorvet[i2] , lwd=2, xlab="", ylab="", axes=F, xlim=c(0,as.numeric(max_pos)), ylim=c(0,as.numeric(1.3*max(data_abundance[x,]) ) )  ) ;
#legendline[i2]="dotdash";
}
else {   # i2>1 && i2<=8
matplot( as.numeric(1:max_pos), as.numeric(data_abundance[x[i2],1:max_pos]), lty=legendline[i2], type = c("l"), col=colorvet[i2] , xlab="", ylab="", axes=F, xlim=c(0,as.numeric(max_pos)), ylim=c(0,as.numeric(1.3*max(data_abundance[x,]) ) )  ) ;

}





par(new=1);
}

legend( c("topleft"),  samples, col=c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4), lty=legendline, ncol=min(c(3,length(samples))),cex=0.6,bty = "n");   # bty = "n" removes box
legend( c("topright"),  age,col=1, lty=legendline2,cex=1.2,bty = "n");

title(main=paste(name4) );

x=x+1;  #next locus
}

dev.off();
par(new=F);
