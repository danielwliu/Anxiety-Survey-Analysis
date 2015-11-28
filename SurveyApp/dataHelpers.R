# Get the current survey csv file
GetSurveyCSV <- function() {
  read.table("./data/data.csv",header=TRUE,sep=",")
}

Save2SurveyCSV <-  function(age, zipcode, anxiety) {
  if (!is.null(age) && zipcode != "" && !is.null(anxiety))
  {
    age <- as.integer(age)
    zipcode <- as.integer(zipcode)
    anxiety <- as.integer(anxiety)
    if (age > 0 && zipcode > 0 && anxiety >= 0)
     {
      newRow <- data.frame(zipcode=zipcode,age=age,anxiety=anxiety)
      write.table(newRow, file = "./data/data.csv",sep=",", row.names=FALSE,col.names = FALSE, append=TRUE)
    }
  }
}
