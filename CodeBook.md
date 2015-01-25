## Code Book


### Description

This project provides a summarised set of averages for selected features from the UCI HAR Samsung data. The primary data set along with descriptions are available from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

The steps in producing this projects summary data set are:

1. Each primary data set is read
2. The target features are selected
3. Activity and subject information is normalized and pre-pended to the data set
4. The test and training data sets are merged
5. The merged data is grouped by subject and activity
6. Means are calculated for the selected features by subject and activity

A deliberate effort was made to retain significance between naming from the original data set and this one. The rational was these names are already constructed with semantic significance. A detailed description of the data features in the primary data set is available from the source. In general the principles for naming features in the original data set were:

* time domain values are prefixed with 't'
* frequency domain values are prefixed with 'f'
* original signals are from accelerometer and gyroscope on device, and are notated by 'Acc' or 'Gryo'
* signal components, for example with the accelerometer, are denoted as 'Body' or 'Gravity'
* acceleration and velocity measures are denoted with 'Jerk'
* magnitude calculations are denoted with 'Mag'
* 3 axial signals are denoted with 'X', 'Y', 'Z'
* finally a number of variables were computed from the original signals, and these calculations are denoted as 'std()', 'mean()', etc

For example, in the original data set a variable 'tBodyAcc-mean()-X' would be a mean measurement in time domain, for the body component from the accelerometer, along the X axis.

Only those variables corresponding to 'std()' and 'mean()' caclulations are used in construction of the data set for this project.

Again, as noted above, the original feature names are generally retained, with the notation 'avg-' prepended to signify
the values have been averaged. As such the meaning of each feature can be deduced from the above information, with additional reference to the originating data set.

### Column Descriptions

The first two columns group the observations. The remaining columns are denoted using the naming convention referenced above:

|Column|Desc|
|------|----|
|subject|the coded subject
|activity|the activity, one of LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
|avg-tBodyAcc-mean()-X||
|avg-tBodyAcc-mean()-Y||
|avg-tBodyAcc-mean()-Z||
|avg-tBodyAcc-std()-X||
|avg-tBodyAcc-std()-Y||
|avg-tBodyAcc-std()-Z||
|avg-tGravityAcc-mean()-X||
|avg-tGravityAcc-mean()-Y||
|avg-tGravityAcc-mean()-Z||
|avg-tGravityAcc-std()-X||
|avg-tGravityAcc-std()-Y||
|avg-tGravityAcc-std()-Z||
|avg-tBodyAccJerk-mean()-X||
|avg-tBodyAccJerk-mean()-Y||
|avg-tBodyAccJerk-mean()-Z||
|avg-tBodyAccJerk-std()-X||
|avg-tBodyAccJerk-std()-Y||
|avg-tBodyAccJerk-std()-Z||
|avg-tBodyGyro-mean()-X||
|avg-tBodyGyro-mean()-Y||
|avg-tBodyGyro-mean()-Z||
|avg-tBodyGyro-std()-X||
|avg-tBodyGyro-std()-Y||
|avg-tBodyGyro-std()-Z||
|avg-tBodyGyroJerk-mean()-X||
|avg-tBodyGyroJerk-mean()-Y||
|avg-tBodyGyroJerk-mean()-Z||
|avg-tBodyGyroJerk-std()-X||
|avg-tBodyGyroJerk-std()-Y||
|avg-tBodyGyroJerk-std()-Z||
|avg-tBodyAccMag-mean()||
|avg-tBodyAccMag-std()||
|avg-tGravityAccMag-mean()||
|avg-tGravityAccMag-std()||
|avg-tBodyAccJerkMag-mean()||
|avg-tBodyAccJerkMag-std()||
|avg-tBodyGyroMag-mean()||
|avg-tBodyGyroMag-std()||
|avg-tBodyGyroJerkMag-mean()||
|avg-tBodyGyroJerkMag-std()||
|avg-fBodyAcc-mean()-X||
|avg-fBodyAcc-mean()-Y||
|avg-fBodyAcc-mean()-Z||
|avg-fBodyAcc-std()-X||
|avg-fBodyAcc-std()-Y||
|avg-fBodyAcc-std()-Z||
|avg-fBodyAccJerk-mean()-X||
|avg-fBodyAccJerk-mean()-Y||
|avg-fBodyAccJerk-mean()-Z||
|avg-fBodyAccJerk-std()-X||
|avg-fBodyAccJerk-std()-Y||
|avg-fBodyAccJerk-std()-Z||
|avg-fBodyGyro-mean()-X||
|avg-fBodyGyro-mean()-Y||
|avg-fBodyGyro-mean()-Z||
|avg-fBodyGyro-std()-X||
|avg-fBodyGyro-std()-Y||
|avg-fBodyGyro-std()-Z||
|avg-fBodyAccMag-mean()||
|avg-fBodyAccMag-std()||
|avg-fBodyBodyAccJerkMag-mean()||
|avg-fBodyBodyAccJerkMag-std()||
|avg-fBodyBodyGyroMag-mean()||
|avg-fBodyBodyGyroMag-std()||
|avg-fBodyBodyGyroJerkMag-mean()||
|avg-fBodyBodyGyroJerkMag-std()||