codeBook.md
================================
The Data
The script assumes all necessary data is located in the working directory in a sub-directory named "UCI_HAR_Dataset". The following files are used in the script. The descriptions are derrived from the source README file:

features.txt - List of all features.
train/X_train.txt - Training set.
train/y_train.txt - Training labels.
test/X_test.txt - Test set.
test/y_test.txt - Test labels.
train/subject_train.txt - Each row identifies the subject who performed the activity for each window sample.
test/subject_test.txt- Each row identifies the subject who performed the activity for each window sample.
Information about Variables
Variables used in within the script

Training Set Data (raw data)
Xtrain - data.frame containing the training set from X_train.txt.
Ytrain - data.frame containing the training labels from y_train.txt.
subTrain - data.frame containing the identification of each subject by row for the respective activities from subject_train.txt. The range is from 1 to 30. 

Test Set Data (raw data)
Xtest - data.frame containing the training set from X_train.txt.
Ytest - data.frame containing the training labels from y_train.txt.
subTest - data.frame containing the identification of each subject by row for the respective activities from subject_test.txt. The range is from 1 to 30. 

features - data.frame contains the list of all features from features.txt.
activityLabels - data.frame containing the label names of each respective activity.

 
sFiles - data.frame containing all combined subject data
xFiles - data.frame containing all combined x files data
yFiles - data.frame containing combined y files data
filesAll - a data.frame containing the subject, activity and all measurements for both train and test.
tidy_data - a data.frame containing only the measurements on the mean and standard deviation for each measurement

meltData - a data.frame created after it was fused (or melted) on the "Subject" and "Activity" variables.
dataMeans - a data.frame containing the average of each variable for each activity and each subject variables used in within the data sets - the result of which was output to "tiny_data.txt".

The newly created tiny_data set includes the mean and std for the following variables:
tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, tBodyGyro-XYZ, tBodyGyroJerk-XYZ, tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.)

A complete list of all column variables found in the original data set can be found in features.txt in the UCI directory.

The subject column identifies the subject who performed the activity for each window sample. The activity column identifies the activity being performed.



Variable Selection Method
=============================
To extract only the measurements on the mean and standard deviation for each variable the grep function is used to select only columns that are mean or standard deviation calculations. 


Steps to Transform Data
=============================
The script:

Loads data from UCI_HAR_Dataset directory
Uses rbind to add subject and activity data to test and training data.
Merges the complete training and the test sets (which include subject and activity) to create one data set using rbind.
Extracts only the measurements on the mean and standard deviation for each measurement using grep.(See variable selection method above.)
Replaces activity numbers in Activity column with descriptive names.
Using melt and dcast creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Writes the results to a space separated text file called "tidy_data.txt".
