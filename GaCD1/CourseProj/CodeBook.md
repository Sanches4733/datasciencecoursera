#CODE BOOK FOR DATA SET
###for Human Activity Recognition Using Smartphones

##RAW DATA

Raw data and all the information about the studies can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

Original data consists of 10299 observations in 561 variables.

##SCRIPT

Script named "run_analysis.R" does the following:

* downloads raw data file, unzips and removes it

* reads data (test and train) from raw data and combines them into one data set.

* adds columns

* selects only needed measurments: mean and std

* creates a second, independent tidy data set with the average of each variable for each activity and each subject

* writes it in a txt file.

## TIDY DATA

Tidy data has one row for each activity (one of six) performed by each subject (one of 30) - 180 rows totally. It has 68 columns, they are descripted further.
Tidy data can be found in a file named "G&CdCourseProject.txt"", which is a result of running "run_analysis.R".

##COLUMNS DESCRIPTIONS

Letters t and f in the beginning of variable names stand for time and frequency domain signals.
Parts "Body" or "Gravity" mean that measurment was related to body movements or gravity.
Parts "Acc" or "Gyro" mean that it was accelerometer or gyroscopic measurment.
If there ia a part "Jerk", it means that it is a measurment of a sudden movement.
If there is a part "Mag", it means that it is a magnitude of measurment.
Parts "mean" or "std" stand for mean and standart deviation of measurments.
Letters X, Y and Z at the end of variable names stand for the axes.
For example:
* tGravityAcc.std - standard deviation of accelerometer measurement related to gravity (time domain signal).
* tBodyAccMag.mean - mean of magnitude of accelerometer measurment of body movements (time domain signal).
* fBodyBodyGyroJerkMag.mean - mean of magnitude of gyroscopic measurement of sudden body movements (frequency domain signal).