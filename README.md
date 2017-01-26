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

1.  make sure the dplyr package is installed on your system

1.  Run the full script. The script will do the following things

  i)  install the dplyr package

  i)  set the filename containing all the filenames. %TYPE% is used as a placeholder for the test and train sets

  i)  3 functions as described in CodeBook.MD will be created:

    * function activity_labels -  Read activities file

    * function get_features () - Read feature file

    * function read_har_file_set (type) - Read all relevant files of research type 'test' or 'train' 

  i) read the test and train set using the read_har_file_set fuction and merge these sets. Assign the result to har.

  i) calculate the mean values in the columns har grouped by Subject_id and Activity and assign the result to har_summery.

5.  Inspect the 'har' and 'har_summary' objects
