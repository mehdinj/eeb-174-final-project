#install.packages(devtools)

#library(devtools)

library(phytools)
library(psych)
library(ape)

library(phytools)
library(geiger)

#all species of non-occurance
nooccuranceallspecies<-read.csv("/Users/Mehdi/Documents/Classes/C177/Final project/non_occurance_reps.csv", header = TRUE)

#for reading the tree
complete.tree<-read.tree(file="/Users/Mehdi/Documents/Classes/C177/Final project/nature21074-s2/Data/Hackett_Stage2_1K_MCCtree_TargetHeights.tre")


#pr.species<-list(nooccurance$Species)
#print(pr.species)
#type(pr.species)
#type(nooccuranceallspecies)

#taxa_to_keep <- c("Eudyptes_moseleyi","Otus_siaoensis","Opisthocomus_hoazin",
#"Syrrhaptes_tibetanus","Todiramphus_ruficollaris","Zimmerius_acer",
#"Cuculus_lepidus","Leptosomus_discolor","Cariama_cristata",
#"Colius_striatus","Sula_granti","Melanerpes_pulcher","Rollandia_rolland",
#"Amazilia_decora","Rhynchotus_maculicollis","Apteryx_mantelli",
#"Scolopax_rosenbergii","Trogon_mesurus","Tauraco_persa",
#"Mesitornis_variegatus","Rhea_americana","Casuarius_casuarius",
#"Tetrax_tetrax","Tockus_jacksoni","Pseudobulweria_becki",
#"Rhynochetos_jubatus","Phoenicopterus_roseus","Gavia_pacifica",
#"Phaethon_aethereus","Rigidipenna_inexpectata")

#i<-1
#for (i in nooccuranceall$Species){
#  [[i]]<-i
#  }
taxa_to_drop=("")
i<-1
for (j in nooccuranceallspecies$Species){
  taxa_to_drop[[i]]<-j
  i=i+1
  }
taxa_to_drop
length(taxa_to_drop)
length(nooccuranceallspecies$Species)
length(complete.tree$tip.label)
#for removing the unwanted tips
simple.tree<-drop.tip(complete.tree,taxa_to_drop)

#for plotting the tree
plotTree(simple.tree,type="fan",fsize=0.7,lwd=1)

simple.tree$tip.label

tips <- simple.tree$tip.label
#write a csv file to add character data to tips

getwd()
setwd("/Users/Mehdi/Documents/Classes/C177/Final project/")

#write.csv(tips)

#openning occurance species csv file
occurancespecies<-read.csv("/Users/Mehdi/Documents/Classes/C177/Final project/bird_occurance_reps.csv", header = TRUE)

#y<-as.factor(c("A","A","A","B","B","A","A","B","A","B",
#     "A","A","A","B","B","A","A","B","A","B",
#     "A","A","A","B","B","A","A","B","A","B",
#     "A","A","A","B","B","A","A","B"))
#x<-setNames(y,simple.tree$tip.label)

#setting x as species along with their occurance status
x<-setNames(occurancespecies$Occurance,occurancespecies$Species)


x
typeof(x)

#simple.tree$tip.label

# single-rate model 
fitER<-ace(x,simple.tree,model="ER",type="discrete")
fitER

#  model with the backward & forward rates between states are permitted to have different values
fitARD<-ace(x,simple.tree,model="ARD",type="discrete")
fitARD

#plotting ER model on the tree
cols<-setNames(c("red","blue"),levels(x))
plotTree(simple.tree,type="fan",fsize=0.6,ftype="i",lwd=1)
nodelabels(node=1:simple.tree$Nnode+Ntip(simple.tree),
           pie=fitER$lik.anc,piecol=cols,cex=0.4)
tiplabels(pie=to.matrix(x[simple.tree$tip.label],levels(x)),
          piecol=cols,cex=0.3)
add.simmap.legend(colors=cols,prompt=FALSE,x=0.9*par()$usr[1],
                  y=0.8*par()$usr[3],fsize=0.8)

#plotting ARD model on the tree
cols<-setNames(c("red","blue"),levels(x))
plotTree(simple.tree,type="fan",fsize=0.6,ftype="i",lwd=1)
nodelabels(node=1:simple.tree$Nnode+Ntip(simple.tree),
           pie=fitARD$lik.anc,piecol=cols,cex=0.4)
tiplabels(pie=to.matrix(x[simple.tree$tip.label],levels(x)),
          piecol=cols,cex=0.3)
add.simmap.legend(colors=cols,prompt=FALSE,x=0.9*par()$usr[1],
                  y=0.8*par()$usr[3],fsize=0.8)


## simulate single stochastic character map using empirical Bayes method
mtree<-make.simmap(simple.tree,x,model="ER")

#plotting one tree
plot(mtree,cols,type="fan",fsize=0.7,ftype="i")
add.simmap.legend(colors=cols,prompt=FALSE,x=0.9*par()$usr[1],
                  y=0.8*par()$usr[3],fsize=0.8)

#plotting 100 stochastic character maps from our dataset:
mtrees<-make.simmap(tree = simple.tree,x,model="ER",nsim=100)

par(mfrow=c(10,10))
null<-sapply(mtrees,plotSimmap,colors=cols,lwd=1,ftype="off")
pd<-summary(mtrees)
pd


plot(pd,fsize=0.6,ftype="i",colors=cols,ylim=c(-2,Ntip(simple.tree)))
add.simmap.legend(colors=cols[2:1],prompt=FALSE,x=0,y=-4,vertical=FALSE)


##plotting a random map, and overlay the posterior probabilities
plot(mtrees[[1]],cols,fsize=0.6,ftype="i",ylim=c(-2,Ntip(simple.tree)))
nodelabels(pie=pd$ace,piecol=cols,cex=0.5)
add.simmap.legend(colors=cols[2:1],prompt=FALSE,x=0,y=-4,vertical=FALSE)

#use a method in phytools called densityMap to visualize 
#the posterior probability of being in each state 
#across all the edges and nodes of the tree as follows:

obj<-densityMap(mtrees,states=levels(x)[2:1],plot=FALSE)
plot(obj,fsize=c(0.6,1))


#compare the posterior probabilities 
#from stochastic mapping with our marginal ancestral states
pdf("temp.pdf")
plot(fitER$lik.anc,pd$ace,xlab="marginal ancestral states",
     ylab="posterior probabilities from stochastic mapping")
lines(c(0,1),c(0,1),lty="dashed",col="red",lwd=2)
dev.off()
