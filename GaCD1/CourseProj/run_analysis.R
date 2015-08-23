#To be sure that we use unchanged data, we should rename "UCI HAR Dataset"
#directory, if it exists in your wd.
if("UCI HAR Dataset" %in% dir()){
            file.rename("UCI HAR Dataset", "UCI HAR Dataset old")
}

#Here we just download and unzip data and remove the zip file
#cause we don't need it anymore. Maybe on other operating systems 
#(mine is Windows), one should specify method argument in download.file.
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "Get&cleanCourseProj.zip")
unzip("Get&cleanCourseProj.zip")
file.remove("Get&cleanCourseProj.zip")

#Here we read our data (test and train) and combine one data set.
test.data <- c("UCI HAR Dataset/test/subject_test.txt", 
                "UCI HAR Dataset/test/y_test.txt",
                "UCI HAR Dataset/test/X_test.txt")
train.data <- c("UCI HAR Dataset/train/subject_train.txt", 
                 "UCI HAR Dataset/train/y_train.txt",
                 "UCI HAR Dataset/train/X_train.txt")

all.test <- do.call(cbind,lapply(test.data, read.table,quote="\""))
all.train <- do.call(cbind,lapply(train.data, read.table,quote="\""))
all.data <- rbind(all.test, all.train)

#Here we add column names to our data.
names(all.data) <- make.names(c("id", "Activity", 
                                as.character(read.table
                                             ("UCI HAR Dataset/features.txt")[,2])), 
                              unique=T)
names(all.data) <- c("id", "Activity", 
                     as.character(read.table
                                  ("UCI HAR Dataset/features.txt")[,2]))

#Here we select only needed columns (mean and std).
needed.columns <- unlist(lapply(c("id", "Activity", "-mean()", "-std()"), 
                                 grep, names(all.data), fixed=T))
all.data <- all.data[, sort(needed.columns)]

#Here we change activity names.
actname = c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", 
            "4"="SITTING", "5"="STANDING", "6"="LAYING")
all.data$Activity <- actname[all.data$Activity]

#Here we create a second, independent tidy data set with the average of 
#each variable for each activity and each subject. with dplyr library.
library(dplyr)
final.data <- all.data %>% group_by(id, Activity) %>% summarise_each(funs(mean))

#Finally here we write this data set as file "G&CdCourseProject.txt".
write.table(final.data, "G&CdCourseProject.txt", row.names = FALSE)