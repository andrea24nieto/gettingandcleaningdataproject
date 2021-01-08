## Getting and Cleaning Data: Course Project

## 0. Preparing data

        ## Loading packages
        
        library(dplyr)
        
        ## Downloading and unzipping data
        
        zipname <- "project_coursera.zip"
        if (!file.exists(zipname)) {
                zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(zipURL, zipname, method = "curl")
        }
        
        if(!file.exists("UCI HAR Dataset")) {
                unzip(zipname)
        }
        
        ## Assigning data frames 
        
        activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                                 header = FALSE)
        features <- read.table("UCI HAR Dataset/features.txt",
                               header = FALSE)
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                                   header = FALSE)
        x_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                             header = FALSE)
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt",
                             header = FALSE)
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                                    header = FALSE)
        x_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                              header = FALSE)
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                              header = FALSE)

## 1. Merging training and test sets to create one data set
        
        ## Merging tables by rows
        compfeatX <- rbind(x_test, x_train)
        compactsY <- rbind(y_test, y_train)
        compsub <- rbind(subject_test, subject_train)
        
        ## Naming variables
        names(compsub) <- c("subject")
        names(compactsY) <- c("activity")
        names(compfeatX) <- features$V2
        
        ## Merging all data to get complete set
        mergedDF <- cbind(compsub, compactsY, compfeatX)
        
        
## 2. Extracting only measurements on the mean and std dev for each measurement
        
        featnames <- features$V2
        msnames <- grep("mean\\(\\)|std\\(\\)", featnames, value = TRUE)
        tidydata <- mergedDF %>% select(subject, activity, all_of(msnames))
        
        
## 3. Assigning descriptive activity names to activities in data set
        
        tidydata$activity <- activities[tidydata$activity, 2]
        
        
## 4. Labeling the data set with descriptive variable names
        
        names(tidydata) <- gsub("^t", "Time", names(tidydata))
        names(tidydata) <- gsub("^f", "Frequency", names(tidydata))
        names(tidydata) <- gsub("Acc", "Accelerometer", names(tidydata))
        names(tidydata) <- gsub("Gyro", "Gyroscope", names(tidydata))
        names(tidydata) <- gsub("Mag", "Magnitude", names(tidydata))
        names(tidydata) <- gsub("BodyBody", "Body", names(tidydata))
        names(tidydata) <- gsub("-mean", "Mean", names(tidydata))
        names(tidydata) <- gsub("-std", "STD", names(tidydata))
        
        
## 5. Creating second data set with average of each variable for each
##    activity and subject
        
        tidyavg <- tidydata %>% group_by(subject, activity) %>% 
                summarise(across(.fns = mean))
        
        write.table(tidyavg, file = "FinalData.txt", row.names = FALSE)
        
        