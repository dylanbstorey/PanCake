data<-read.table("test_join.mtx" , header=TRUE )
rownames(data)=colnames(data)
data=as.matrix(data)
library(gplots)
png(file="test_join.mtx.png",width=12*720,height=12*720,res=720,point=14)
mtx <- heatmap.2 (data,denscol="green",trace="none",dendrogram="row",symm=TRUE,keysize=0.7,main="Genome Distance Clustering" ,cexRow=0.2,offsetRow=0,labCol = " ")
dev.off()
data=data[rev(mtx$rowInd),mtx$colInd]
write.table(data, file="test_join.mtx" , sep="\t", row.names=FALSE, quote=FALSE)
