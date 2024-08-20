
# complete data set 203 elements and sample set elments in different color

l1charac <- read.table('zhou.tsv',header=TRUE)

l1charac$sample <- as.factor("false")

samplel1charac <- read.table('zhou-set.tsv',header=TRUE)

samplel1charac$sample <- as.factor("true")

AllData <- rbind(l1charac,samplel1charac)

t <- AllData[,c(2:6)]
t$TYPE <- as.factor(AllData$TYPE)

scale_t <- as.data.frame(scale(t[,c(1:5)]))
scale_t$TYPE <- t$TYPE

pc <- prcomp(scale_t[,-6])
print(pc)
summary(pc)

biplot(pc)
loadings <- pc$rotation
scores <- pc$x
#rownames(loadings) <- colnames(t)
dev.new(height=7, width=7)


SAMPLE <- AllData$sample == "true"
NonSAMPLE <- AllData$sample == "false"

plot(scores[, 1], scores[, 2], xlab='PCA 1', ylab='PCA 2', type='n', asp=1, las=1)
points(scores[NonSAMPLE, 1], scores[NonSAMPLE, 2], pch=16, cex=0.7, col='red')
points(scores[SAMPLE, 1], scores[SAMPLE, 2], pch=16, cex=0.7, col='blue')
text(-5, -6, 'Sample Set', col='blue')
text(5, -6, 'Remainder', col='red')
