###############################################################################################
######################### Getting and Cleaning Data Course Project  ###########################
###############################################################################################

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

                      # Step 0: Downlaod files
# load Libraries
library(dplyr)
library(stringr) 

# download file & unzip data
if(!file.exists("./data")){dir.create("./data")}

fileUrl <-  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
myfile = "getDataset.zip"

if (!file.exists(myfile)){
download.file(fileUrl,destfile=myfile, method="auto")
unzip(zipfile= myfile,exdir="./data")
}

                     # Step 1: Merge the training and the test sets to create one data set

# Reading trainings tables into table structures
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables into table structures
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading features into table structures
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels into table structures
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Assgin meaningfull column names to the data 
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activityLabels) <- c('activityId','activityType')

# combining train and test data
all_trainData <- cbind(y_train, subject_train, x_train)
all_testData <- cbind(y_test, subject_test, x_test)
allData <- rbind(all_trainData, all_testData )

                       # Step  2: Extracts only the measurements on the mean and standard deviation for each measurement
colNames <- colnames(allData)
#search Matchings in colNames
matchColnames <- (grepl("activityId", colNames) |  grepl("subjectId", colNames) | grepl("mean..", colNames) | grepl("std..", colNames))
# subset allData according to selectVec
allData= allData[matchColnames==TRUE];

                       # Step 3: Uses descriptive activity names to name the activities in the data set

finalData <- merge(allData, activityLabels, by='activityId', all.x=TRUE)

                       # Step 4: Appropriately labels the data set with descriptive variable names

# update colNames
colNames <- colnames(finalData)
# clean column names
for (i in 1:length(colNames)) 
{
        colNames[i] = gsub("\\()","",colNames[i])
        colNames[i] = gsub("-std$","StdDev",colNames[i])
        colNames[i] = gsub("-mean","Mean",colNames[i])
        colNames[i] = gsub("^(t)","time",colNames[i])
        colNames[i] = gsub("^(f)","freq",colNames[i])
        colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
        colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
        colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
        colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
        colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
        colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
        colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(finalData) = colNames

                  # Step 5: creates a second, independent tidy data set with the average of each variable for each activity and each subject

secTidydata <- aggregate(. ~subjectId + activityId, finalData, mean)
secTidydata <- secTidydata[order(secTidydata$subjectId, secTidydata$activityId), ]
# write the data into a file 
write.table(secTidydata, "./data/secTidydata.txt", row.name=FALSE)


