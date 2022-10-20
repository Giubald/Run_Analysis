##peer-reviewed assignment
setwd("~/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4")
#data is downloaded and saved into local folder
#load features.txt (features variables names)
my_features <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", header=FALSE)
Activity_labels <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", header=FALSE)
##Step 1: Merges the training and the test sets (X_train.txt & X_test.txt) to create one data set.
#load data Train
my_data_train_xset <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
my_data_train_activities <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header = FALSE)
my_data_train_subjects <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
#load data test
my_data_test_xset <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
my_data_test_activities <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header = FALSE)
my_data_test_subjects <- read.delim("C:/Users/gruggeri/OneDrive - Autoneum/Documents/Learning/2022 - Data Science Course - Cursera/Module 3/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
#merge X_train set & X_test set
Merged_X_dataset <-rbind(my_data_train_xset, my_data_test_xset) #the new dataset is merged vertically
Merged_activities <-rbind(my_data_train_activities, my_data_test_activities)
Merged_subjects <-rbind(my_data_train_subjects, my_data_test_subjects)
#name of columns
colnames(Merged_X_dataset)= my_features[,1]
colnames(Merged_activities)="Activities_id"
colnames(Merged_subjects)="Subject_id"
#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
#to do that, "my_feature.txt" is used to get the columns of the dataset in which mean and standard deviations are. First, rows indexes in "my_feature" containing "mean" and "std" are found and these indexes corresponds to the ones of the columns wee need su extract in the full dataset.
Index_vector <- grep("mean|std", my_features$V1) #with this espression, I get the indexes of the vector in which "mean" OR "std" appear
Data_set_meanstd <- Merged_X_dataset[, Index_vector]

#Step 3: Uses descriptive activity names to name the activities in the data set
#first replace the "Merged_activities" array from the number into the name of the category, thanks to the legend "Activity_labels"

Dataset_with_Activity_names <-cbind(Merged_activities,Merged_subjects, Data_set_meanstd) #add the column of the activities as first column of the data set

#Step 4: Appropriately labels the data set with descriptive variable names. 
names(Dataset_with_Activity_names)<-gsub("Acc", "Acceleration", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("Gyro", "Gyroscope", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("BodyBody", "Body", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("Mag", "Magnitude", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("^t", "Time", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("^f", "Frequency", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("tBody", "TimeBody", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("-mean()", "Mean", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("-std()", "Standard Deviation", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("-freq()", "Frequency", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("angle", "Angle", names(Dataset_with_Activity_names), ignore.case = TRUE)
names(Dataset_with_Activity_names)<-gsub("gravity", "Gravity", names(Dataset_with_Activity_names), ignore.case = TRUE)


#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
AverageSet1 <- aggregate(Dataset_with_Activity_names, list(Dataset_with_Activity_names$Activities_id, Dataset_with_Activity_names$Subject_id), mean, simplify = TRUE)#with this function, two more columns (group1 and group 2) are created
#now I have to delete the first 2 columns of the AverageSet, created by aggregate function
AverageSet = AverageSet1[-c(1,2)]
AverageSet_ordered <- AverageSet[order(AverageSet$Subject_id, AverageSet$Activities_id),] #ordering the rows according to Subject first and then Activities
#write the data set in .txt
write.table(AverageSet_ordered, "AverageSet_ordered.txt", row.name=FALSE) #saving the document as specified by the assignment

# #create an automatic Codebook
# library(codebook)
# codebook_data <- codebook::bfi
# rio::export(codebook_data, "run_analysis.rds") # to R data structure file
# print(x = codebook_data, target = "study_codebook_1.docx")