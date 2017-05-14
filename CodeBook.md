# Codebook.md #

## Source ##
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## run_analysis.R ##
The script in this file will merge training/test data sets, extracts mean/standard deviation for each measurement, names activities and variables in the dataset. 
It also creates an independent tidy data set with average of each varaible for each activity and subject.

Reads x,y,subject train and test datasets and combines them.  
Reads activity dataset and sets the values in the y dataset to be readable activity names instead of numbers.
Reads features dataset and uses only the measurements on the mean and standard deviation variables.
Relabels columns using features values for the x dataset, activity for the y column, and as volunteers for the subject column.
Merges x, y, and subject datasets which is then exported as tidyData.txt.

Uses a for loop and dplyr library. For each volunteer, we find the average value for each activity then add to the initalized array. 
The result is exported as tidyDataAvg.txt

##Variables##

activity - contents from "activity_labels.txt"
subtest - contents from "test/subject_test.txt" 
subtrain - contents from "train/subject_train.txt"
xtest - contents from"test/X_test.txt"
xtrain - contents from"train/X_train.txt"
ytest - contents from"test/y_test.txt"
ytrain - contents from"train/y_train.txt"
features - contents from"features.txt"

dty - combined ytrain and ytest data (activity)
dtx - combined xtrain and xtest data (data for each variable related to volunteer/activity)
dtsub - combined subtest and subtrain (volunteer)

datareorg <- combined dtsub, dtx, dty datasets
dataavg <- average value for each volunteer for each activity

##Output##

tidyData.txt (10299 x 81)
Col 1 = Volunteer numbers, Col 2 = Activity, Col 3-81 = measurements 

tidyDatAvg.txt (180 x )
Col 1 = Volunteer numbers, Col 2 = Activity, Col 3-81 = measurements 
