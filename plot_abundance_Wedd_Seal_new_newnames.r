
#data_abundance is a matrix of concatenated rows likke this:
#mir1 blood
#mir 2 blood
#...
#mir n blood
#mir1 heart
#mir2 heart
#...
#mir n heart
require(lattice)


#samples=c("Heart1","Heart2","Kidney1","Kidney2","Testis1","Testis2","Whole_Brain1","Whole_Brain2"); #rabbit

#samples=c("Cerebellum1","Cerebellum2","Cortex1","Cortex2","Heart1","Heart2","Hypothalamus1","Hypothalamus2","Kidney1","Kidney2","Testis1","Testis2");  #pig 1610

#samples=c("Cerebellum_1099","Cortex_1099","Heart_1099","Hypothalamus_1099","Kidney_1099","Testis_1099","Cerebellum_1610", "Cortex_1610","Heart_1610","Hypothalamus_1610","Kidney_1610","Testis_1610"  );

#samples=c("cortex_154113-micro_1_miRDeep2","cortex_154117-micro-Ce_1_miRDeep2","cortex_164022_1_miRDeep2","cortex_164023_1_miRDeep2","cortex_164024_1_miRDeep2","cortex_164025_1_miRDeep2","miRCat_cortex_154113-micro_1","miRCat_cortex_154117-micro-Ce_1","miRCat_cortex_164022_1","miRCat_cortex_164023_1","miRCat_cortex_164024_1","miRCat_cortex_164025_1","heart_154102-micro_1_miRDeep2","heart_154115-micro_1_miRDeep2","heart_164011_1_miRDeep2","heart_164012_1_miRDeep2","heart_164013_1_miRDeep2","heart_164014_1_miRDeep2","miRCat_heart_154102-micro_1","miRCat_heart_154115-micro_1","miRCat_heart_164011_1","miRCat_heart_164012_1","miRCat_heart_164013_1","miRCat_heart_164014_1","miRCat_muscle_154117-micro-Mu_1","miRCat_muscle_164001_1","miRCat_muscle_164003_1","miRCat_muscle_164004_1","miRCat_muscle_164005_1","miRCat_muscle_164006_1","muscle_154117-micro-Mu_1_miRDeep2","muscle_164001_1_miRDeep2","muscle_164003_1_miRDeep2","muscle_164004_1_miRDeep2","muscle_164005_1_miRDeep2","muscle_164006_1_miRDeep2","miRCat_plasma_164386_1","miRCat_plasma_164387_1","miRCat_plasma_164388_1","miRCat_plasma_164390_1","miRCat_plasma_164391_1","miRCat_plasma_164393_1","plasma_164386_1_miRDeep2","plasma_164387_1_miRDeep2","plasma_164388_1_miRDeep2","plasma_164390_1_miRDeep2","plasma_164391_1_miRDeep2","plasma_164393_1_miRDeep2")
data_abundance <- read.delim("Documents//Wedd_Seal/Tables/abundance_each_base_mirbase_names_final2_corrected31_lwe-miR.txt",header=0, row.names=1,sep="\t")

samples=c("brain_154113-micro_1","brain_154117-micro-Ce_1","brain_164022_1","brain_164023_1","brain_164024_1","brain_164025_1","heart_154102-micro_1","heart_154115-micro_1","heart_164011_1","heart_164012_1","heart_164013_1","heart_164014_1","muscle_154117-micro-Mu_1","muscle_164001_1","muscle_164003_1","muscle_164004_1","muscle_164005_1","muscle_164006_1","plasma_164386_1","plasma_164387_1","plasma_164388_1","plasma_164390_1","plasma_164391_1","plasma_164393_1")

age=c("pup","adult")


#data_abundance=rbind(data_abundance,1:length(data_abundance[1,]));


nsamples=length(samples);

nmir=length(data_abundance[,1])/nsamples;     #n, the numer of loci
x=1:nsamples;

for (h in 2:nsamples) {
x[h]=nmir*(h-1)+1;                       #this indicates the rows corresponding to same locus for diff tissues
}



lastr=length(data_abundance[,1]);

posvet2=1:length(data_abundance[1,]);

pdf("/Users/lucapensodolfin/Dropbox/Weddell_Seal/R1 BMC manuscript/Wedd_Seal_abundance_newnames_lwe-miR_revi.pdf");
#pdf("pig_novel_1099_1610_blast_new.pdf");
#nmir
for ( i in 1:nmir )   {                     #i in 1:nmir      

#max_pos=1;
#for ( i2 in 1:length(x) ){
#posvet=which(data_abundance[x[i2],] >0);

#if (length(posvet) >0) {
#max_pos=max(c(max_pos,max(posvet) ) );
#}
#}

#if (max_pos<60) {max_pos=60;}


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

#max_pos=pos2-pos1+3;   ###?
max_pos=pos2-pos1+2; 
#name4=paste(name2[1],name2[2],name2[3],name2[4],name2[5],sep="_");

#name4=paste(name2[1],name2[2],name2[3],name22,sep="_");
name4=name22;    #paste(name2[1],name2[2],name22,sep="_");
#name4=gsub("Wedd_Seal_","",name4)

name2=paste(name2[1],name2[2],sep="_");

#pdf(paste(paste(row.names(data_abundance)[x[1]]) ,".pdf",sep=""));



#matplot(data_abundance[x,],length(data_abundance[1,]), type = c("b"),col=rainbow(9,start=.8,end=.7) ,  pch = c(19,20,21),  xlab=c("bp position") , ylab=c("counts"), xlim= c( min(data_abundance[i,] ) ,  max(data_abundance[i,] )*1.5 )  ,  ylim= c( min(data_abundance[i,] ) , max(data_abundance[i,] )*1.5 ) ) ;
#matplot(data_abundance[x,], matrix(rep(1:length(data_abundance[1,]),each=nsamples), ncol=length(data_abundance[1,])), type = c("l"),col=rainbow(9,start=.8,end=.7) ,  xlab=c("bp position") , ylab=c("counts") ) ;
#matplot( matrix(rep(1:length(data_abundance[1,]),each=nsamples), ncol=length(data_abundance[1,])) , data_abundance[x,],  type = c("l"), col=rainbow(9,start=.8,end=.7) ,  xlab=c("bp position") , ylab=c("counts") ) ;
par(new=F);
#xyplot( 1:length(data_abundance[1,]) ~ data_abundance[x,] , type = c('l'),  auto.key=T)

legendline=c("solid","solid", "dashed","dashed", "dashed","solid", "dashed","solid", "solid","dashed", "solid","dashed","solid","dashed","dashed","solid","dashed","solid",  "solid","solid","solid","dashed","dashed", "dashed" );
#cont=1;
legendline2=c("dashed","solid")
colorvet=c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4)

for (i2 in as.numeric(1:nsamples)) {
if (i2==1) {
#matplot( as.numeric(data_abundance[lastr,1:max_pos]), as.numeric(data_abundance[x[i2],1:max_pos]),  type = c("l"), col=i2 , xlab=c("bp position") , ylab=c("counts")  ) ;
#matplot( 1, data_abundance[x[i2],1:131],  type = c("l"), col=i2 , xlab=c("bp position") , ylab=c("counts")  ) ;
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
#legendline[i2]="solid";
#matplot( 1:131, data_abundance[x[i2],1:131],  type = c("l"), col=i2 , xlab="", ylab="", axes=F  ) ;
}

#if ( floor(i2/6)!=i2/6   )  {cont=cont+1;}         #6 is number of tissues
#else {cont=1;}



par(new=1);
}

#if ( max(data_abundance[i,])>= 1 ) {
#legend( 40, max(data_abundance[x,1:max_pos])/2,  samples, col=1:i2, pch=c(19));
legend( c("topleft"),  samples, col=c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4), lty=legendline, ncol=min(c(3,length(samples))),cex=0.6,bty = "n");   # bty = "n" removes box
legend( c("topright"),  age,col=1, lty=legendline2,cex=1.2,bty = "n");
#par(xpd=NA);
#legend( max(data_abundance[x,1:max_pos])/2, -1, samples, col=1:i2, pch=c(19), ncol=nsamples,cex=0.7);


#                                 }
#else                             {
#legend(max(data_abundance[i,])*1.2, max( 1, max(data_abundance[i,]*0.8) ) , colnames(data), col=rainbow(9,start=.8,end=.7) ,  pch = c(19,20,21,22,23,24,22,23,24) );
#legend(max(data_abundance[i,]), max(data_abundance[i,])+0.1   , colnames(data), col=rainbow(9,start=.8,end=.7) , pch = c(19,20,21,22,23,24,22,23,24)  );
#                                }
#abline(0,1);
title(main=paste(name4) );
#dev.print(device=postscript,file=paste(name2,".ps",sep=""), paper = "a4",horizontal=FALSE);



x=x+1;  #next locus
}

dev.off();
par(new=F);
