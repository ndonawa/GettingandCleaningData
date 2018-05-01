##Download File
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  dest5 <- "./fitbitdata"
  download.file(fileURL,dest5)
  
##unzip file
  unzip(zipfile = dest5, exdir = "C:/Users/T93J09O/Documents")
  
## ReadAllTables
  
  xtest <- read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/test/X_test.txt")
  ytest <- read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/test/subject_test.txt")
  xtrain <- read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/train/subject_train.txt")
  ytrain <- read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/train/subject_train.txt")
  features <- read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/features.txt")
  actlabels = read.table("file:///C:/Users/T93J09O/Documents/UCI HAR Dataset/features.txt")
  
  ##Variable Names
  colnames(x_train) <- features[,2] 
  colnames(y_train) <-"activityId"
  colnames(subject_train) <- "subjectId"
  colnames(x_test) <- features[,2] 
  colnames(y_test) <- "activityId"
  colnames(subject_test) <- "subjectId"
  colnames(actlabels) <- c("activityId", "activitytype")
  
##DataMerge
  training_merge <- cbind(x_train, y_train, subject_train)
  test_merge <- cbind(x_test, y_test, subject_test)
  Train_Test <- rbind(training_merge, test_merge)
 
  
##ReadColumnNames&CreateVectorID
  colNames <- colnames(Train_Test)
  Metrics <- (grepl("activityId", colNames) |
              grepl("subjectId", colNames)  |
              grepl("mean..", colNames)  |
              grepl("std..", colNames)  
              )
  
  subsetforMeanandSTD <- Train_Test[, Metrics == TRUE]
  
  ActivityNames <- merge(subsetforMeanandSTD, actlabels,
                         by="activityId",
                         all.x=TRUE)
  
  #CreateSecondTidyDataSet&WriteinTXT
  Tidydata2 <- aggregate(. ~subjectId + activityId, ActivityNames, mean)
  Tidydata2 <- Tidydata2[order(Tidydata2$subjectId, Tidydata2$activityId),]
  
  write.table(Tidydata2, "Tidydata2.txt", row.names = FALSE)