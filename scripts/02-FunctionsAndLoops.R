###############################################################################
## CONDITIONAL EXPR, LOOPS, APPLY AND FUNCTIONS
###############################################################################
## 3.1 Practice conditional expressions and logical operators 
## 3.2 For() loops
## 3.3 Funciton writing
## 3.4 Use your function inside an apply statement
## 3.5 Bar-Plotting function
###############################################################################
source("scripts/01-DataImport.R")

## 3.1 Practice conditional expressions and logical operators 
###############################################################################
x <- 1:7
y <- -3:3
x
y
# try the following: 
(x == y)
(x > abs(y))
(x > 3) & (x < 5)
(x > 3) | (x < 5)
xor((x > 3), (x < 5))
(-1 %in% y)
(3 %in% y) & (3 %in% x) 
(3 %in% y) & !(3 %in% x) 

## 3.2 Check consistency of tidy.economic.situation proportions with for loop
###############################################################################
for (i in 1: nrow(tidy.economic.situation)) {
  if(sum(tidy.economic.situation[i,2:4]) == 100){
    print("OK")} else {
      print(paste("Something is wrong in row ", i))
    }
}

## 3.3 Write a function to check consistency of tidy.economic.situation proportions
###############################################################################
FunRowCheck <- function(x) {
  message <- if(sum(x) == 100){
    "OK"} else {
      "Not OK"}
  return(message)
}
# try it out:
FunRowCheck(tidy.economic.situation[1,2:4])

## 3.4 Use your functions inside an apply statement
###############################################################################
apply(tidy.economic.situation[,2:4], 1, FunRowCheck)
# append the new test variable to the dataset
tidy.economic.situation$test <- apply(tidy.economic.situation[,2:4], 1, FunRowCheck)

## 3.5 Bar-Plotting function
###############################################################################
FunBarPlot <- function(question = "HH") {
  df <- tidy.economic.situation[tidy.economic.situation$perception == question,]
  where <- ifelse(question =="HH", "household", ifelse(question == "UK", "United Kingdom", "world"))
  main.title <- paste("Perception of economic situation in", where)
  barplot(t(as.matrix(df[,c(2,4,3)])),
          main = main.title,
          names.arg = df[,1],
          legend.text = c("Bad", "Neutral", "Good")
          )
}

FunBarPlot()
FunBarPlot("UK")
FunBarPlot("W")
