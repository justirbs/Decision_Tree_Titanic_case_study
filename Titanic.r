library(rpart)
library(rpart.plot)

# Import data base
ptitanic=read.table("ptitanic.csv", header=T,sep=';',row.names=1) 
data(ptitanic)
str(ptitanic)

# Construct Decision Tree
Tree=rpart(survived~.,ptitanic)
prp(Tree,extra=1)

# Complex decision tree : overfiting
Tree=rpart(survived~.,ptitanic,control=rpart.control(minsplit=5,cp=0))
prp(Tree,extra=1)

# Adjustment error graph
plotcp(Tree)

# Pruning
PrunedTree=prune(Tree,cp=0.0047)
prp(PrunedTree,extra=1)

# Probabilities prediction on the first 5 lines
predict(PrunedTree,ptitanic[1:5,])

# Class prediction for the first 5 lines
predict(PrunedTree,ptitanic[1:5,] ,type="class")

# Confusion matrix
prevision=predict(PrunedTree,ptitanic,type="class")
MatConf=table(ptitanic$survived,prevision)
print(MatConf)

# Rates
tb=sum(diag(MatConf))/sum(MatConf)
print(paste("Global rate of good classed observation : ",tb))
tb.classes=diag(MatConf)/apply(MatConf,1,sum)
print(paste("Rate of good classed observation per class : ",tb.classes))

table(ptitanic$survived)