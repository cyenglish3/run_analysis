#//////////////////////////////////////////////
#This code was developed by:
#Crystal English
#Getting and Cleaning Data - Assignment 2
#Course Project
#/////////////////////////////////////////////

# Preliminaries:
#
# The purpose of this project is to demonstrate an
# ability to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used
# for later analysis. You will be graded by your peers
# on a series of yes/no questions related to the project.
# You will be required to submit: 1) a tidy data set as
# described below, 2) a link to a Github repository with
# your script for performing the analysis, and 3) a code
# book that describes the variables, the data, and any
# transformations or work that you performed to clean
# up the data called CodeBook.md. You should also include
# a README.md in the repo with your scripts. This repo
# explains how all of the scripts work and how they are connected. 

# ---------------------------------------------------------------
# ---------------------------------------------------------------

# This R script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard
#    deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the
#    data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of
#    each variable for each activity and each subject.

# ---------------------------------------------------------------
# ---------------------------------------------------------------

# Check for, install, and load packages if needed
if(!require("data.table")) {
        install.packages("data.table")
        require("data.table")
}

if(!require("reshape2")) {
        install.packages("reshape2")
        require("reshape2")
}

if(!require("plyr")) {
        install.packages("plyr")
        require("plyr")
}


# Set the working directory
fileDir <- file.path("P:","CE_Documents", "Education", "Coursera", "RDataFiles", "UCI_HAR_Dataset")  
setwd(fileDir)


## Once the file unzips, the data directory will actually be under a second
## directory. I copied and pasted the data directory into the top-level
## working directory. So, this process is commented out.  Uncomment if needed.

# If file is not already in the working directory, download and unzip
# if (!file.exists(dataFiles)) {
#         fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#         download.file(fileUrl, dataFiles, method="auto") # use mode="curl" for Mac
# }
# 
# if (!file.exists(fileDir)) {
#         unzip(dataFiles)
# }


## And it's right about now, I wish I was better at making
## functions...
# ===========================================================

# Fetch and read files into R

# Training data
Xtrain <- read.table("train/X_train.txt")
Ytrain <- read.table("train/y_train.txt")
subTrain <- read.table("train/subject_train.txt")

# Test data
Xtest <- read.table("test/X_test.txt")
Ytest <- read.table("test/y_test.txt")
subTest <- read.table("test/subject_test.txt")

# Features and labels
features <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt")


# 1. Merge the training and test data sets to create a single data set
sFiles <- rbind(subTrain, subTest)
colnames(sFiles) <- "subject"

dataLabel <- rbind(Ytrain, Ytest)
# 3. Uses descriptive activity names to name the activities in the
#    data set
dataLabel <- merge(dataLabel, activityLabels, by=1)[,2]

# 4. Appropriately label the data set with descriptive variable names.
xFiles <- rbind(Xtrain, Xtest)
colnames(xFiles) <- features[,2]

# Combine all three into one data set
filesAll <- cbind(sFiles, dataLabel, xFiles)

# 2. Extract only the measurements on the mean and standard
#    deviation for each measurement.
dataExtract <- grep("-mean|-std", colnames(filesAll))
dMeanStd <- filesAll[,c(1,2,dataExtract)]


# 5. Creates a second, independent tidy data set with the average of
#    each variable for each activity and each subject.

# Calc means by groups - subjects/activity
meltData = melt(dMeanStd, id.var = c("subject", "dataLabel"))
dataMeans = dcast(meltData, subject + dataLabel ~ variable, mean)

# Write to new tidy data file
write.table(dataMeans, file="tidy_data.txt", sep=" ")
