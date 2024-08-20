
library(psych)

# PCA plot of complete data set 203 elements and sample set

# http://strata.uga.edu/8370/lecturenotes/principalComponents.html
# lab pc: /home/a1779913/Documents/At_uni/thesis/chap2/r
# home pc: C:\Users\jolal\OneDrive\Documents\adel_uni\thesis\figures\ch2\fig_pca

l1charac <- read.table('zhou.tsv',header=TRUE)

t <- l1charac[,c(2:6)]
scale_t <- as.data.frame(scale(t[,c(1:5)]))

pc <- prcomp(scale_t[,-6])
print(pc)
summary(pc)


FullX <- l1charac$TYPE == "full-len"
InvertX <- l1charac$TYPE == "inverted"
TransX <- l1charac$TYPE == "transduct"
TruncX <- l1charac$TYPE == "trunc"
scores <- pc$x

plot(scores[, 1], scores[, 2], xlab='PCA 1', ylab='PCA 2', type='n', asp=1, las=1, xlim =c(-5,8), ylim=c(-2,3) )
points(scores[FullX, 1], scores[FullX, 2], pch=16, cex=0.7, col='red')
points(scores[InvertX, 1], scores[InvertX, 2], pch=16, cex=0.7, col='blue')
points(scores[TransX, 1], scores[TransX, 2], pch=16, cex=0.7, col='green')
points(scores[TruncX, 1], scores[TruncX, 2], pch=16, cex=0.7, col='orange')

text(5, 1, 'Inverted', col='blue')
text(5, 0, 'Full Length', col='red')
text(5, -1, 'Transduction', col='green')
text(5, -2, 'Truncation', col='orange')

sampleSet <- c(6,20,41,51,57,73,84,89,90,92,97,98,100,103,104,115,129,130,135,136,137,143,152,169,170,177,180,186,193,196,197,198)

#
# PCA plot of sample set.
l1charac <- read.table('zhou-set.tsv',header=TRUE)

t <- l1charac[,c(2:6)]
scale_t <- as.data.frame(scale(t[,c(1:5)]))

pc <- prcomp(scale_t[,-6])
print(pc)
summary(pc)


FullX <- l1charac$TYPE == "full-len"
InvertX <- l1charac$TYPE == "inverted"
TransX <- l1charac$TYPE == "transduct"
TruncX <- l1charac$TYPE == "trunc"
scores <- pc$x

plot(scores[, 1], scores[, 2], xlab='PCA 1', ylab='PCA 2', type='n', asp=1, las=1, xlim =c(-5,8), ylim=c(-2,3) )
points(scores[FullX, 1], scores[FullX, 2], pch=16, cex=0.7, col='red')
points(scores[InvertX, 1], scores[InvertX, 2], pch=16, cex=0.7, col='blue')
points(scores[TransX, 1], scores[TransX, 2], pch=16, cex=0.7, col='green')
points(scores[TruncX, 1], scores[TruncX, 2], pch=16, cex=0.7, col='orange')

text(5, 1, 'Inverted', col='blue')
text(5, 0, 'Full Length', col='red')
text(5, -1, 'Transduction', col='green')
text(5, -2, 'Truncation', col='orange')