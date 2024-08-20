# mann-whitney

# file:///C:/Users/jolal/Downloads/99_Mann_Whitney_U_Test.pdf  =>
# https://www.sheffield.ac.uk/media/30589/download?attachment


sampSet <- read.table('zhou-set.tsv',header=TRUE)
allSet<- read.table('zhou.tsv',header=TRUE)
result1 <- wilcox.test(allSet$PolyA.tail_size, sampSet$PolyA.tail_size)
print (result1)

hist(allSet$PolyA.tail_size)
hist(sampSet$PolyA.tail_size)

result1 <- wilcox.test(allSet$X5._TSD_size, sampSet$X5._TSD_size)
print (result1)

hist(allSet$X5._TSD_size)
hist(sampSet$X5._TSD_size)

result1 <- wilcox.test(allSet$Predicted_transD_size, sampSet$Predicted_transD_size)
print (result1)

hist(allSet$Predicted_transD_size)
hist(sampSet$Predicted_transD_size)

result1 <- wilcox.test(allSet$Insertion_L1_size, sampSet$Insertion_L1_size)
print (result1)

hist(allSet$Insertion_L1_size)
hist(sampSet$Insertion_L1_size)


result1 <- wilcox.test(allSet$Insertion_L1_size, sampSet$Insertion_L1_size)
print (result1)

hist(allSet$X5._inverted_seq_size)
hist(sampSet$X5._inverted_seq_size)

