Peer-graded Assignment: Getting and Cleaning Data Course Project

The run_analysis.R script reads data from a scientific experiment Human
Activity Recognition Using Smartphones Dataset.
It creates 2 data tables. See CodeBook.md for more information about the
dataset as well as the R-code.

This file explains how to use the run_analysis.R script.

1.  download the data from the URL below.
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

1.  Unzip the file and make sure the next files are in the same directory
    as run_analysis.R file.
    - activity_labels.txt
    - features.txt
    - subject_test.txt
    - subject_train.txt
    - X_test.txt
    - X_train.txt
    - y_test.txt
    - y_train.txt

1.  Run the full script

1.  Inspect the 'har' and 'har_summary' objects


# Run_analysis.R script explained
## function activity_labels ()

`Goal` Read activities file 
`Return value` data frame with 2 columns: activity_code and activity

## function get_features ()

`Goal` Read feature file
`Return value` a data table with 2 columns: featureName_raw and featureName. The latter can be used for columns names in a data frame

## function read_har_file_set (type) 
`Goal` Read all relevant files of research type 'test' or 'train' 
`Return value` a data table with 68 column. 
`type` {test | train}

The value returned are all the mean()- and std()-columns from the original source. 
The test and train set are merged in the har data table
har_summery is identical to har except that the values in the columns represent the mean values of har grouped by Subject_id and Activity.
