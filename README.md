## Getting and Cleaning Data Course Project

### Description

This project processes data set for human activity recognition using smartphone sensor data. The primary data set along with descriptions are available from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The goal of the project is to process the original data set with following goals:

1. Merge the test and training data
2. Extract measurements for mean and std deviation
3. Produce a data set consistent with [Tidy Data Principles](http://www.jstatsoft.org/v59/i10/paper)
    
### Assumptions

The original data set is assumed to be present in a sub directory of the project, "UCI HAR Dataset". The data set can be obtained [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and should be extracted in place.

Note that there are some measurements in the original data derived from a mean measurement, specifically see for example "angle(tBodyAccMean,gravity)". These values are not part of the output data set, as they are not considered a mean per se.

Also note did not include meanFrequency variables for certain obeservations in frequency domain. For example "fBodyBodyGyroMag-meanFreq()" as again these were not viewed as equivalent to "fBodyBodyGyroMag-mean()", which
is included in the tidy data set.

