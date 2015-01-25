library(dplyr)

uciDir <- "UCI HAR Dataset"
dataDir <- "data"
activityLabels <- "activity_labels.txt"
featureLabels <- "features.txt"

init <- function() {
    ## Verifiy uci data set exists and setup working area

    if (!file.exists(uciDir)) {
        stop("UCI HAR Dataset not present, please see readme for source URL, download and extract to 'UCI HAR Dataset'.")
    }
    if (!file.exists(dataDir)) {
        dir.create(dataDir)
    }   
}

readActivityLabels <- function () {
    ## Simple helper to get activity labels
    ##
    ## Returns:
    ##  a data.frame with activity labels
    path <- file.path(uciDir, activityLabels)
    read.table(path)
}

readFeatureLabels <- function () {
    ## Pull out the set of feature labels we care about
    ##
    ## Returns:
    ##  a data.frame with filtered set of features and their position in X_{set}.txt
    path <- file.path(uciDir, featureLabels)
    labels <- read.table(path)
    labels <- filter(labels, grepl("-std\\(|-mean\\(", V2))
}

readUCIDataSet <- function(set="train") {
    ## Read a UCIDataSet, select out features we care about, and prepend subject
    ## and activity
    ##
    ## Args:
    ##  set: train or test, defaults to train
    ##
    ## Returns:
    ##  a data.frame which has been selected down to features we care about with cols: subject,
    ##  activity, + features
    if (set != "train" && set != "test") {
        stop("Invalid set param for readUCIDataSet")
    }
    dirPath <- file.path(uciDir, set)
    xPath <- file.path(dirPath, sprintf("X_%s.txt", set))
    yPath <- file.path(dirPath, sprintf("y_%s.txt", set))
    subjectPath <- file.path(dirPath, sprintf("subject_%s.txt", set))
    message("Reading UCIDataSet ", set, ", file names: ", paste(xPath, yPath, subjectPath, sep=","))

    # read feature labels
    featureLabels <- readFeatureLabels()
    
    # read and select xdata
    xData <- read.table(xPath)
    xData <- select(xData, featureLabels$V1)
    names(xData) <- featureLabels$V2
    
    # read and expand ydata with activity labels
    activityLabels <- readActivityLabels()
    yData <- read.table(yPath)
    yData <- inner_join(yData, activityLabels, by = c("V1"))
    
    # prepend activity column
    xData <- cbind(activity = yData$V2, xData)
    
    # prepend subject column
    subjectData <- read.table(subjectPath)
    xData <- cbind(subject = subjectData$V1, xData)
}

buildMergedDataSet <- function () {
    ## Read and combine train and test data
    ##
    ## Returns:
    ##  the cleaned, merged set of data
    trainData <- readUCIDataSet("train")
    testData <- readUCIDataSet("test")
    mergedDataSet <- rbind(trainData, testData)
}

buildSummaryDataSet <- function(mergedDataSet) {
    ## Build a summary set of data from the merged data grouped by subject, activity
    ## and with means computed for feature variables
    ##
    ## Returns:
    ##  a data set which has averages for all features for each subject and activity

    # group by subject and activity
    bySubjectActivity <- group_by(mergedDataSet, subject, activity)
    
    # Compute avg of each feature variable for each activity and each subject
    avgsBySubjectActivity <- summarise_each(bySubjectActivity, funs(mean))
    
    # Fix up the col names
    colNames <- names(avgsBySubjectActivity)
    avgNames <- sapply(colNames[3:68], function(x) sprintf("avg-%s", x), USE.NAMES = FALSE)
    names(avgsBySubjectActivity) <- c("subject", "activity", avgNames)
    avgsBySubjectActivity
}

init()
mergedDataSet <- buildMergedDataSet()
summaryDataSet <- buildSummaryDataSet(mergedDataSet)
write.table(summaryDataSet, file.path(dataDir, "avgs_by_subject_activity.txt"), row.names = FALSE)
