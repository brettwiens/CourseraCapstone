## ===========================================================
## Loading Data and Initializing Variables
## ===========================================================

# prediction1 <- "The"
# prediction2 <- "To"
# prediction3 <- "And"
# prediction4 <- "A"
# prediction5 <- "I"

# Five_Words <- readRDS("f2n5.rds")
# Four_Words <- readRDS("f2n4.rds")
# Three_Words <- readRDS("f2n3.rds")
# Two_Words <- readRDS("f2n2.rds")
# Single_Words <- readRDS("f1.rds")

## ===========================================================
## Processing the Data Functions
## ===========================================================

## Clean Text function takes the input string and turns it into lowercase without punctuation, and trims out whitespace
cleanText <- function(inputText){
     
     inputText <- trimws(tolower(gsub("[[:punct:]]+", " ",gsub("'", "", inputText))), which = "both")
     return(inputText)
}

## Pull Words function takes the input string, breaks it into individual words, and pulls the last four words into a data frame
pullWords <- function(inputText){
     
     testVector <- strsplit(inputText, " ")      ## Splits the vector into words (spaces indicate new words)
     numberofWords <- length(testVector[[1]])    ## Calculates the number of words in the vector
     
     lastWord <- data.frame(0)                   ## Creates an empty data frame to store the last (up-to) four words
     
     ## Determines whether there are enough words to gather 4,3,2, or 1 word, and gathers that word
     if(numberofWords > 0){lastWord[1,1] <- as.character(testVector[[1]][length(testVector[[1]])-0])} 
     if(numberofWords > 1){lastWord[2,1] <- as.character(testVector[[1]][length(testVector[[1]])-1])}
     if(numberofWords > 2){lastWord[3,1] <- as.character(testVector[[1]][length(testVector[[1]])-2])}
     if(numberofWords > 3){lastWord[4,1] <- as.character(testVector[[1]][length(testVector[[1]])-3])}
     
     names(lastWord) <- "Word"                   ## Adds "word" to the column name (easier reference)
     
     return(lastWord)                            ## Return the lastWord data frame (result of function)
}

## ===========================================================
## Processing the Data Functions
## ===========================================================

predictWords <- function(testString, PredictionSize, TextPrediction, prediction1, prediction2, prediction3, prediction4, prediction5){

## Initialize predictors (clean 'em up),
oneWord <- ""
twoWord <- ""
threeWord <- ""
fourWord <- ""

## Initialize prediction data frames
Predict_Five_Words <- data.frame()
Predict_Four_Words <- data.frame()
Predict_Three_Words <- data.frame()
Predict_Two_Words <- data.frame()

testString <- cleanText(testString)    ## Clean the text from the test string, lowercase, remove punctuation, etc.
lastWord <- pullWords(testString)      ## Clip the test string to only the last (up to) four words and construct a data frame.

numberofWords <- nrow(lastWord)

if(numberofWords > 3){
     fourWord <- paste(lastWord[4,], lastWord[3,], lastWord[2,], lastWord[1,], sep = " ")   ## Groups the last four words into a predictor string
     Predict_Five_Words <- Five_Words[Five_Words$predictor == fourWord,]                    ## Creates predictor/predicted relationship of the four word predictor and fifth word predicted
}
if(numberofWords > 2 & nrow(Predict_Five_Words) < PredictionSize){
     threeWord <- paste(lastWord[3,], lastWord[2,], lastWord[1,], sep = " ")
     Predict_Four_Words <- Four_Words[Four_Words$predictor == threeWord,]
}
if(numberofWords > 1 & nrow(Predict_Five_Words) + nrow(Predict_Four_Words) < PredictionSize){
     twoWord <- paste(lastWord[2,], lastWord[1,], sep = " ")
     Predict_Three_Words <- Three_Words[Three_Words$predictor == twoWord,]
}
if(numberofWords > 0 & nrow(Predict_Five_Words) + nrow(Predict_Four_Words) + nrow(Predict_Three_Words) < PredictionSize){
     oneWord <- lastWord[1,]
     Predict_Two_Words <- Two_Words[Two_Words$predictor == oneWord,]
}


colnames(TextPrediction) <- c("predictor", "predicted", "n")

if(nrow(Predict_Five_Words) > 0 & PredictionSize > 0) {
     TextPrediction <- Predict_Five_Words[1:min(PredictionSize,nrow(Predict_Five_Words)),]
     PredictionSize <- PredictionSize - nrow(TextPrediction)
}
if(nrow(Predict_Four_Words) > 0 & PredictionSize > 0) {
     TextPrediction <- rbind(as.matrix(TextPrediction),
                             as.matrix(Predict_Four_Words[1:min(PredictionSize,nrow(Predict_Four_Words)),]))
     PredictionSize <- PredictionSize - nrow(TextPrediction)
}
if(nrow(Predict_Three_Words) > 0 & PredictionSize > 0) {
     TextPrediction <- rbind(as.matrix(TextPrediction),
                             as.matrix(Predict_Three_Words[1:min(PredictionSize,nrow(Predict_Three_Words)),]))
     PredictionSize <- PredictionSize - nrow(TextPrediction)
}
if(nrow(Predict_Two_Words) > 0 & PredictionSize > 0 ) {
     TextPrediction <- rbind(as.matrix(TextPrediction),
                             as.matrix(Predict_Two_Words[1:min(PredictionSize,nrow(Predict_Two_Words)),]))
     PredictionSize <- PredictionSize - nrow(TextPrediction)
}
if(PredictionSize > 0){
     TextPrediction <- rbind(TextPrediction,
                             Single_Words[1:min(PredictionSize,nrow(Single_Words)),])
}



return(TextPrediction)

}