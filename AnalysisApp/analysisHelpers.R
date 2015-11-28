# Get the current survey csv file
GetCleanedSurveyData <- function() {
  surveyData <- read.csv("./data/data.csv",header=TRUE,sep=",")
  surveyData$answer <- ifelse(surveyData$anxiety == 1, "YES","NO")
  surveyData$quantity <- 1
  surveyData$answer <- factor(surveyData$answer)
  totalYes <- sum(surveyData[surveyData$answer=="YES",]$quantity)
  totalNo <- sum(surveyData[surveyData$answer=="NO",]$quantity)
  
  surveyData$anxiety <- as.factor(surveyData$anxiety)
  surveyData$zipcode <- sprintf("%05d", surveyData$zipcode)
  surveyData
}

GetAgeData <- function(fromAge, toAge) {
 # surveyData <- GetCleanedSurveyData()
  surveyData <- GetMergedData(fromAge, toAge)
  ageData <- aggregate(quantity ~ age + answer, surveyData, sum)
  ageData
}

GetMergedData <- function(fromAge, toAge) {
  surveyData <- GetCleanedSurveyData()
  data(zipcode)
  mergedData = merge(surveyData, zipcode, by.x='zipcode', by.y='zip')
  mergedData = mergedData[mergedData$zipcode != "09102",]
  mergedData <- mergedData[mergedData$longitude < 144,]
  mergedData$region = substr(mergedData$zipcode, 1, 1)
  if (is.integer(fromAge) && is.integer(toAge))
  {
    subset(mergedData, mergedData$age >= fromAge & mergedData$age <= toAge)
  }
  else
  {
    mergedData
  }
 
}
