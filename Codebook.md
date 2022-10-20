---
title: "Codebook"
author: "Giulio Ruggeri"
date: '2022-10-17'
output: pdf_document
---

The run_analysis.R script cleans the data set according to 5 official steps

1) Download the dataset
The data is downloaded from the link below
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data layout is analyzed and then the needed files are loaded at the beginning of the script.
The function «read.delim()» is used to transcript text data into dataframes.


 #Assign each data to variables
 - my_features <- features.txt  (561 rows, 1 column)
 - Activity_labels <- activity_labels.txt (6 rows, 1 column)
 #load data Train
 - my_data_train_xset <- X_train.txt (7352 rows, 561 columns)
 - my_data_train_activities <- y_train.txt (7352 rows, 1 column)
 - my_data_train_subjects <- subject_train.txt (7352 rows, 1 column)
 #load data Test
 - my_data_test_xset <- X_test.txt (2947 rows, 561 columns)
 - my_data_test_activities <- y_test.txt (2947 rows, 1 column)
 - my_data_test_subjects <- subject_test.txt (2947 rows, 1 column)
 

 #Merges test and training set
 - Merged_X_dataset (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
 - Merged_activities (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
 - Merged_subjects (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function


2) Extracts only the measurements on the mean and standard deviation for each measurement
 - Index_vector (79 elements) I get the indexes of the vector in which "mean" OR "std" appear
 - Data_set_meanstd (10299 rows, 79 columns)is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

3) Uses descriptive activity names to name the activities in the data set
 - Dataset_with_Activity_names (10299 rows, 81 columns), through cbind(), a dataframe that includes all the data + the activities and the subject at the first two columns is created

4) Appropriately labels the data set with descriptive variable names
all the columns first cells are renamed in a way to have understandable names.

5) From the data set in step 4, creates a second, independent tidy data set with the average of each activity and each subject
 - AverageSet1 (180 rows, 83 columns). Using the aggregate function, I can get the average for each activity and subjec. two more columns (group1 and group 2) are created at the beginning of the data frame. now I have to delete the first 2 columns of the AverageSet, created by aggregate function
 - AverageSet (180 rows, 81 columns) = AverageSet1[-c(1,2)]
 - AverageSet_ordered (180 rows, 83 columns) ordering the rows according to Subject first and then Activities
 #write the data set in AverageSet_ordered.txt
