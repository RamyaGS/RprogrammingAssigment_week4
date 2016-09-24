library(plyr)
library(dplyr)

#Step1:Extracting Features,Subject and Activity Data and cleaning them
###################################################################################
# read features and select features with mean and standard deviation
featureNames <- read.table("./UCI HAR Dataset/features.txt")
featureNames <- select(featureNames,V2)
featuresRequired <- grep("mean|std",featureNames$V2)
#clean feature names
featuresRequired.Names <- grep("mean|std",featureNames$V2,value = T)
featuresRequired.Names <- gsub("-","",featuresRequired.Names)
featuresRequired.Names <- gsub("\\()","",featuresRequired.Names)
featuresRequired.Names <- gsub("mean","Mean",featuresRequired.Names)
featuresRequired.Names <- gsub("std","Std",featuresRequired.Names)

#load test  and training subject data 
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
trainingSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#load activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activityLabels <- as.character(activityLabels$V2)

#load test and training activity data 
testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainingActivity <- read.table("./UCI HAR Dataset/train/y_train.txt")

#Step 2:Load test and train data as per selected features
#############################################################################

testData <- read.table("./UCI HAR Dataset/test/X_test.txt")[featuresRequired]
trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")[featuresRequired]

#create test and train dataframes combining subject,activity and test,train data
test <- cbind(testSubject,testActivity,testData)
train <- cbind(trainingSubject,trainingActivity,trainingData)

#Step 3:Merge test and train data
##################################################################################

fullData <- rbind(test,train)
colnames(fullData) <- c("subject","activity",featuresRequired.Names)


#Step 4:Make subject and activity variable as factors
####################################################################################

fullData$subject <- as.factor(fullData$subject)
fullData$activity <- as.factor(fullData$activity)
levels(fullData$activity) <- c(activityLabels)

#Step 5:Create tidy dataset with averages(mean) of variables grouped by Subject and Activity
##############################################################################################
tidyData <- fullData%>%group_by(subject,activity)%>%summarize_each(funs(mean))
write.table(tidyData,"tidy_data.txt",row.names = F)

