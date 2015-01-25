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
    xPath <- file.path(dirPath, sprintf("X_%s_100.txt", set))
    yPath <- file.path(dirPath, sprintf("y_%s_100.txt", set))
    subjectPath <- file.path(dirPath, sprintf("subject_%s_100.txt", set))
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

init()

# Merge training and test data sets
trainData <- readUCIDataSet("train")
testData <- readUCIDataSet("test")
tidyDataSet <- rbind(trainData, testData)

# Create 2nd data set with average of each variable for each activity and each subject
