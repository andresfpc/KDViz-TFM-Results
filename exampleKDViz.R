setwd("D:/UNIR/TFM/ExampleKDViz")
library("KDViz")

myKeywords <- c("knowledge domain visualization", "document clustering", "co-words", "co-citation")
myBibDataOnline <- ArticleSearch(keywords = myKeywords, webSite = "ScienceDirect", saveCSV = TRUE, exportName = "KDKeywords")

myBibData <- myBibDataOnline

myCorpus <- BibToCorpus(bibData = myBibData, bibUnits = "Keywords", controlList = c("stripWhitespace"), stopWords = TRUE, wordsToRemove = c("analysis", "data", "text", "review", "topic", "theory", "protein"), replaceWords = "KDReplaceWords.txt")

termFreqTable <- TermFrequency(myCorpus)
head(termFreqTable, 100)
TermFreqByWord(termFreqTable = termFreqTable, word = "docume")

myDTM <- DTMFromCorpus(corpus = myCorpus, rowNames = row.names(myBibData))

mpaWords <- matrix.corpus.mpa(myCorpus, fmin = 8, cmin = 1)
mpaWords$Words

myKDSummary <- KDSummary(matrix.mpa = mpaWords, groupSize = 10)
myKDSummary$clustTable
myKDSummary$wordClasses

myWordGroupDTM <- GroupDTM(dtm = myDTM, kdSummary = myKDSummary)

KDViz(groupDTM = myWordGroupDTM, group = 1, export = TRUE)
KDViz(groupDTM = myWordGroupDTM, group = 12, export = TRUE)

LoadArticle(myBibData, "A321")
LoadArticle(myBibData, "A125")