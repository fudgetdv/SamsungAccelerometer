library(dplyr)
library(stringr)
library(reshape2)

runAnalysis <- function(){
  dir <- "./data/"
  featureFile <- paste(dir,"features.txt", sep="")
  labelFile <- paste(dir,"activity_labels.txt", sep="")
  
  #Training Set
  train_subject_file <- paste(dir,"train/subject_train.txt", sep="")
  train_activity_file <- paste(dir,"train/y_train.txt", sep="")
  train_measurement_file <- paste(dir,"train/x_train.txt", sep="")
  
  #Test Set
  test_subject_file <- paste(dir,"test/subject_test.txt", sep="")
  test_activity_file <- paste(dir,"test/y_test.txt", sep="")
  test_measurement_file <- paste(dir,"test/x_test.txt", sep="")
  
  
  trainDatLabel <- read.table(labelFile)
  trainDatLabel <- rename(trainDatLabel, id=V1)
  trainDatLabel <- rename(trainDatLabel, activity=V2)
  
  trainDatAct <- read.table(train_activity_file)
  trainDatAct <- rename(trainDatAct, activity_id=V1)
  
  testDatAct <- read.table(test_activity_file)
  testDatAct <- rename(testDatAct, activity_id=V1)
  
  trainDatAct <- merge(trainDatAct, trainDatLabel, by.x="activity_id", by.y="id", all=TRUE, sort=FALSE)
  testDatAct <- merge(testDatAct, trainDatLabel, by.x="activity_id", by.y="id", all=TRUE, sort=FALSE)
  
  
  features <- read.table(featureFile)
  features <- as.character(features[,2])

  inFeatures <- grep("std|mean", features)
  count <- length(inFeatures)+3
  
  features <- features[inFeatures]
  
  trainDatSub <- read.table(train_subject_file)
  trainDatSub <- rename(trainDatSub, subject=V1)
  
  testDatSub <- read.table(test_subject_file)
  testDatSub <- rename(testDatSub, subject=V1)
  
  dat <- read.table(train_measurement_file)
  dat <- dat[,inFeatures]
  colnames(dat) <- features
  
  dat1 <- read.table(test_measurement_file)
  dat1 <- dat1[,inFeatures]
  colnames(dat1) <- features
  
  dat <- select(cbind(trainDatSub, trainDatAct,dat),subject, activity, 3:count)
  dat1 <- select(cbind(testDatSub, testDatAct,dat1),subject, activity, 3:count)
  
  dat <- rbind(dat,dat1)
  dat <- melt(dat,id.vars=c("subject","activity"), variable.name="measurement")
  
  dat <- aggregate(value~subject+activity+measurement,dat,mean)
  dat <- arrange(dat, desc(subject))
  
  write.table(dat,file="./tidy/SamsungAccelerometers.txt",row.names=FALSE)
  
  
  
  
  
}

