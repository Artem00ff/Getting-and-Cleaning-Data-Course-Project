run_analysis <- function() {
  #UCI HAR Dataset лежит в папке с проектом
  #function does the following.
  
  #Merges the training and the test sets to create one data set.
  #Extracts only the measurements on the mean and standard deviation for each measurement.
  #Uses descriptive activity names to name the activities in the data set
  #Appropriately labels the data set with descriptive variable names.
  #From the data set in step 4, creates a second, 
  #independent tidy data set with the average of each variable for each activity and each subject.
  #Function return first Data, And make txt file with second tidy data. 
  library(plyr)
  
  #read features
  features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("col_ID", "feature"), sep = "")
  #read test data, labels, subject
  DataTest <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
  DataTest_Y <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "labels")
  DataSubject_Test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  #add labels, subject to test data
  DataTest$labels <- factor(DataTest_Y$labels, levels = c("1","2","3","4","5","6"), labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")) 
  DataTest$subject <- DataSubject_Test$subject
  
  #read train data, labels, subject
  DataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
  DataTrain_Y <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "labels")
  DataSubject_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  #add labels, subject to train data
  DataTrain$labels <- factor(DataTrain_Y$labels, levels = c("1","2","3","4","5","6"), labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
  DataTrain$subject <- DataSubject_Train$subject
  
  #Merges the training and the test sets to create one data set.
  Data <- rbind.data.frame(DataTest,DataTrain)
  
  #find features with mean() OR std() of values
  y <- grep("*.mean*.|*.std*.", features$feature)
  #add labels and subject to features with mean() OR std() of values
  y <- c(y, 562, 563)
  
  #delete unnecessary points from names
  names(Data) <- gsub("\\.","",names(Data))
  #selection mean, std, labels and subject cols 
  
  
  #ddply(Data[,y], .(labels,subject), summarize, mean=mean(names(Data[,y])))
  
  #Data5 <- ddply(Data[,y], .(labels,subject), summarize, mean=mean(noquote(names(Data[,y])),na.rm = TRUE)) 
  
  #Data5 <- ddply(Data[,y], .(labels,subject), summarize, mean=mean(tBodyAcc.mean...X, rm = TRUE),mean=mean(fBodyBodyGyroJerkMag.mean.., rm = TRUE))
  #The following 3 lines is a Script to generate query. You can use it to make a huge request, and copy it.
  #string <- "ddply(Data[,y], .(labels,subject), summarize"
  #for (j in 1:79){string <- paste(string ,",", names(Data[,y])[j] , "=mean(" , names(Data[,y])[j] , ")" )} 
  #as.symbol(string)
  
  #query to create from the data set in step 4,
  #a second, independent tidy data set with 
  #the average of each variable for each activity and each subject.
  Data5 <- ddply(Data[,y], .(labels,subject), summarize , tBodyAccmeanX =mean( tBodyAccmeanX ) , tBodyAccmeanY =mean( tBodyAccmeanY ) , tBodyAccmeanZ =mean( tBodyAccmeanZ ) , tBodyAccstdX =mean( tBodyAccstdX ) , tBodyAccstdY =mean( tBodyAccstdY ) , tBodyAccstdZ =mean( tBodyAccstdZ ) , tGravityAccmeanX =mean( tGravityAccmeanX ) , tGravityAccmeanY =mean( tGravityAccmeanY ) , tGravityAccmeanZ =mean( tGravityAccmeanZ ) , tGravityAccstdX =mean( tGravityAccstdX ) , tGravityAccstdY =mean( tGravityAccstdY ) , tGravityAccstdZ =mean( tGravityAccstdZ ) , tBodyAccJerkmeanX =mean( tBodyAccJerkmeanX ) , tBodyAccJerkmeanY =mean( tBodyAccJerkmeanY ) , tBodyAccJerkmeanZ =mean( tBodyAccJerkmeanZ ) , tBodyAccJerkstdX =mean( tBodyAccJerkstdX ) , tBodyAccJerkstdY =mean( tBodyAccJerkstdY ) , tBodyAccJerkstdZ =mean( tBodyAccJerkstdZ ) , tBodyGyromeanX =mean( tBodyGyromeanX ) , tBodyGyromeanY =mean( tBodyGyromeanY ) , tBodyGyromeanZ =mean( tBodyGyromeanZ ) , tBodyGyrostdX =mean( tBodyGyrostdX ) , tBodyGyrostdY =mean( tBodyGyrostdY ) , tBodyGyrostdZ =mean( tBodyGyrostdZ ) , tBodyGyroJerkmeanX =mean( tBodyGyroJerkmeanX ) , tBodyGyroJerkmeanY =mean( tBodyGyroJerkmeanY ) , tBodyGyroJerkmeanZ =mean( tBodyGyroJerkmeanZ ) , tBodyGyroJerkstdX =mean( tBodyGyroJerkstdX ) , tBodyGyroJerkstdY =mean( tBodyGyroJerkstdY ) , tBodyGyroJerkstdZ =mean( tBodyGyroJerkstdZ ) , tBodyAccMagmean =mean( tBodyAccMagmean ) , tBodyAccMagstd =mean( tBodyAccMagstd ) , tGravityAccMagmean =mean( tGravityAccMagmean ) , tGravityAccMagstd =mean( tGravityAccMagstd ) , tBodyAccJerkMagmean =mean( tBodyAccJerkMagmean ) , tBodyAccJerkMagstd =mean( tBodyAccJerkMagstd ) , tBodyGyroMagmean =mean( tBodyGyroMagmean ) , tBodyGyroMagstd =mean( tBodyGyroMagstd ) , tBodyGyroJerkMagmean =mean( tBodyGyroJerkMagmean ) , tBodyGyroJerkMagstd =mean( tBodyGyroJerkMagstd ) , fBodyAccmeanX =mean( fBodyAccmeanX ) , fBodyAccmeanY =mean( fBodyAccmeanY ) , fBodyAccmeanZ =mean( fBodyAccmeanZ ) , fBodyAccstdX =mean( fBodyAccstdX ) , fBodyAccstdY =mean( fBodyAccstdY ) , fBodyAccstdZ =mean( fBodyAccstdZ ) , fBodyAccmeanFreqX =mean( fBodyAccmeanFreqX ) , fBodyAccmeanFreqY =mean( fBodyAccmeanFreqY ) , fBodyAccmeanFreqZ =mean( fBodyAccmeanFreqZ ) , fBodyAccJerkmeanX =mean( fBodyAccJerkmeanX ) , fBodyAccJerkmeanY =mean( fBodyAccJerkmeanY ) , fBodyAccJerkmeanZ =mean( fBodyAccJerkmeanZ ) , fBodyAccJerkstdX =mean( fBodyAccJerkstdX ) , fBodyAccJerkstdY =mean( fBodyAccJerkstdY ) , fBodyAccJerkstdZ =mean( fBodyAccJerkstdZ ) , fBodyAccJerkmeanFreqX =mean( fBodyAccJerkmeanFreqX ) , fBodyAccJerkmeanFreqY =mean( fBodyAccJerkmeanFreqY ) , fBodyAccJerkmeanFreqZ =mean( fBodyAccJerkmeanFreqZ ) , fBodyGyromeanX =mean( fBodyGyromeanX ) , fBodyGyromeanY =mean( fBodyGyromeanY ) , fBodyGyromeanZ =mean( fBodyGyromeanZ ) , fBodyGyrostdX =mean( fBodyGyrostdX ) , fBodyGyrostdY =mean( fBodyGyrostdY ) , fBodyGyrostdZ =mean( fBodyGyrostdZ ) , fBodyGyromeanFreqX =mean( fBodyGyromeanFreqX ) , fBodyGyromeanFreqY =mean( fBodyGyromeanFreqY ) , fBodyGyromeanFreqZ =mean( fBodyGyromeanFreqZ ) , fBodyAccMagmean =mean( fBodyAccMagmean ) , fBodyAccMagstd =mean( fBodyAccMagstd ) , fBodyAccMagmeanFreq =mean( fBodyAccMagmeanFreq ) , fBodyBodyAccJerkMagmean =mean( fBodyBodyAccJerkMagmean ) , fBodyBodyAccJerkMagstd =mean( fBodyBodyAccJerkMagstd ) , fBodyBodyAccJerkMagmeanFreq =mean( fBodyBodyAccJerkMagmeanFreq ) , fBodyBodyGyroMagmean =mean( fBodyBodyGyroMagmean ) , fBodyBodyGyroMagstd =mean( fBodyBodyGyroMagstd ) , fBodyBodyGyroMagmeanFreq =mean( fBodyBodyGyroMagmeanFreq ) , fBodyBodyGyroJerkMagmean =mean( fBodyBodyGyroJerkMagmean ) , fBodyBodyGyroJerkMagstd =mean( fBodyBodyGyroJerkMagstd ) , fBodyBodyGyroJerkMagmeanFreq =mean( fBodyBodyGyroJerkMagmeanFreq ))     
  #write tidy data set with the average of each variable for each activity 
  #and each subject to Datastep_5_Data.txt 
  write.table(Data5, "./Getting-and-Cleaning-Data-Course-Project/step_5_Data.txt", row.name=FALSE)
  #return first Data
  Data <- Data[,y]
  Data
  }