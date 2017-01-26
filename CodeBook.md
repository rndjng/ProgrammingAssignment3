---
title: "Assignment 3.4 - Tidying Smartphone data"
author: "René de Jong"
output: html_document
---

In this assignment data from a scientific experiment. The experiment is known as Human Activity Recognition Using Smartphones Dataset. The manin author is L. Jorge from the Smartlab (www.smartlab.ws)

This codebook is additional to the documententation of the used data. See `features_info.txt` for original information about the features in the data set.

The `run_analysis.R` script delivers 2 data tables:

* har
* har_summary
  
Both contain 68 variables described below. Below you also find all the functions and what they are used for.

# Variables in output data sets
## Subject ID 
`Domain`: 1-30 (integer)

The subject ID identifies each of the 30 participants of the research project.

## Activity
`Activity`: {WALKING | WALKING_UPSTAIRS | WALKING_DOWNSTAIRS | SITTING | STANDING | LAYING}

Describes the activity of subject during the measeruments of the features from accelerometer and gyroscope. 

## Features
`66 columns of features`: -1 .. 1 

### data table 'har'
These columns contain processed data in Time and Frequency domain. The Acceleration is split into a Body and Gravitational component. Furthermore they are split in a mean and Standard Deviation compontent. And finally the Acceleration features are split into 3 coordinates.

### data table 'har_summary'
The data table `har_summary` contains the same 66 variables with exactly the same names. The values represent mean values per Subject_id per Activity.

# Run_analysis.R
## function activity_labels ()

`Goal` Read activities file into a data frame with 2 columns: activity_code and activity

## function get_features ()

`Goal` Read feature file and return a data table with 2 columns: featureName_raw and featureName. The latter can be used for columns names in a data frame

## function read_har_file_set (type) 
`Goal` Read all relevant files of type 'test' or 'train' into data table for further processing. Contains only the original features with 'mean()' or 'std()' in their name.
`type` {test | train}

