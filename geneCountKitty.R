#Build table of genes counts by gene name

#my data =
allData<-(read.csv("mergedGeneNames.csv",header=TRUE,sep=","))

  
#gene counts
allGeneCount<-table(allData$Gene)
dataFrame<-data.frame(allGeneCount)
write.csv(allGeneCount,"allGeneCount")


#order data and find highest values

geneRepOrder<-order(dataFrame[,2], decreasing=TRUE)
finalOrderGenes<-geneRepOrder[1:231]

for(i in finalOrderGenes){
  myGeneFamilies<-merge(allData$Family[i] , allData$Gene[i])
  #print(finalOrderGenes[i])
  print(myGeneFamilies)
}



myList<-dataFrame[finalOrderGenes,]

write.csv(myList, "testfile.csv")


