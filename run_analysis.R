# goal          : script for reading data from teh HAR experiment
# pre requisite : all the data files should be in the working directory.
# output        : 2 data tables: har and har_summary

  library(dplyr)
  library(tidyr)
  
  rm(list=ls())
  
  filename = c(
    activity = "activity_labels.txt",
    feature = "features.txt",
    subject = "subject_%TYPE%.txt",
    x = "X_%TYPE%.txt",
    y = "y_%TYPE%.txt"
    )
  
  typeindicator <- "%TYPE%"
  
  # Read activities file into a data frame with 2 columns: activity_code and activity
  activity_labels <- function()  {
    activities <- read.table(filename["activity"],
                                    stringsAsFactors = FALSE,
                                    col.names = c("activity_code", "Activity"))
    return(activities)
    }

  # Read feature file anb return a data table with 2 columns: featureName_raw and featureName
  # The latter can be used for columns names in a data frame
  get_features <- function () {
    raw_data <- read.table(filename["feature"],
                                   stringsAsFactors = FALSE,
                                   col.names = c("feature_code", "featureName_raw"))

    # add a column with a tidied feature name that can be used as columns names in a data frame    
    features <- tbl_df(raw_data) %>% 
      select(featureName_raw) %>%
      mutate(featureName = make.names(featureName_raw, unique = TRUE)) %>%
      mutate(featureName = gsub("\\.", "_", featureName)) %>%     # replace all dots by _
      mutate(featureName = gsub("_{3}", "_", featureName)) %>%    # replace '___' by '_'
      mutate(featureName = gsub("_{2}", "_", featureName)) %>%    # replace '__' by '_'
      mutate(featureName = gsub("^t", "Time_", featureName)) %>%  # t > Time
      mutate(featureName = gsub("^f", "Frequency_", featureName)) %>%  # f > Frequency
      mutate(featureName = gsub("_$", "", featureName)) %>% # remove '_' at the end        
      select(everything())
        
    return(features)    
  }


  ## Read all relevant files of type 'test' or 'train' into data table for further processing
  read_har_file_set <- function(type)  {

    if (!type %in% c("test", "train")) {stop("type can only be 'test' or 'train'")}
    
    features <- get_features()

    # read files into vars
    subject <- read.table(sub(typeindicator, type, filename["subject"]), col.names = c("Subject_id"))
    activities <- read.table(sub(typeindicator, type, filename["y"]), col.names = c("activity_code"))
    fact <- read.table(sub(typeindicator, type, filename["x"]), col.names = features$featureName)

    activities <- left_join(activities, activity_labels(), by="activity_code")

    har <- tbl_df(fact) %>%
      select(grep("mean\\()|std\\()", features$featureName_raw)) %>%
      bind_cols(subject, activities, .) %>%
      select(-activity_code) %>%
      select(everything())
    
    return(har)
  }

  
# har contains a data table with the tidied and merged test and train data of the HAR experiment. 
har <- bind_rows(read_har_file_set("test"), read_har_file_set("train"))

# har_summary contains a data table with a summary of all the mean values of the har data table
# grouped by subject_id and activity

har_summary <- har %>%
  group_by(subject_id, activity) %>%
  summarise_each(funs(mean)) %>%
  select(everything())

write.table(har_summary, "har_summary.txt", row.names = FALSE)
