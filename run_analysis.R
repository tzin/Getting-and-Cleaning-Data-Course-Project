## The run_analysis.R  will merge training/test data sets, extracts mean/standard deviation
## for each measurement, names activities and variables in the dataset, and creates 
## an independent tidy data set with average of each varaible for each activity and subject.


   ## read all the x, y, subject train and test datasets into tables
   subtest <- read.table("test/subject_test.txt") 
   subtrain <- read.table("train/subject_train.txt")

   xtest <- read.table("test/X_test.txt")
   xtrain <- read.table("train/X_train.txt")
  
   ytest <-read.table("test/y_test.txt")
   ytrain <- read.table("train/y_train.txt")
   
   #combine test and train data sets for x, y, and subject datasets
   dty <- rbind(ytrain, ytest)
   dtx <- rbind(xtrain,xtest)
   dtsub <- rbind(subtest,subtrain)
  
   #read and reformat the activity names  
   activity <-read.table("activity_labels.txt")
   activity$V2 = tolower(as.character(activity$V2))
   activity$V2 = gsub("_"," ",activity$V2)
   
   ## change y names to activity names
   ylabels <- join(dty, activity, by ="V1")
   ylabels$V1 <- NULL

   ##read the features text for labelling the x dataset (dtx)
   features <-read.table("features.txt")
   features$V2 = gsub("-","",features$V2)
   features$V2 = gsub("\\(\\)","",as.character(features$V2))
   
   ## label each column
   names(ylabels) <- "activity"
   names(dtsub) <-"volunteer"
   colnames(dtx) <- features$V2
   
   ## Keep only the mean and STD columns for dtx
   stdmeanlogic  <- grepl("(std|mean)", features$V2)
   dtx <- dtx[,stdmeanlogic]
   
   ## Combine all the data to one tidy dataset
   datareorg <- cbind(dtsub, ylabels, dtx)
   write.table(datareorg, "tidyData.txt")
   
   ##From the data set in step 4, creates a second, independent tidy 
   ##data set with the average of each variable for each activity and 
   ##each subject.
   
   volunteers <- unique(datareorg$volunteer)
   activities <- unique(datareorg$activity)
   dataavg <- vector(length=0)
   
   ## for each volunteer, find the average value for each activity 
   ## then add to the initalized array
   for (v in 1:length(volunteers)) {
       volsubset <- datareorg[datareorg$volunteer == v,] 
       dataavg <- rbind(dataavg, volsubset %>% group_by(activity) %>% summarise_each(funs(mean)))
   }
   dataavg = dataavg[,c(2,1,3:81)]
   write.table(dataavg, "tidyDataAvg.txt")

