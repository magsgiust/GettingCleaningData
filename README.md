GettingCleaningData
===================

Course Project-Analyzing accelerometers from the Samsung Galaxy S smartphone

Wearable computing is attracting all sorts of companies, and the most progressive in the industry such as Fitbit, Nike, and Jawbone Up are using data science to iterate and continuously improve.  The data being analyzed here represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained, as well as the most updated code book and data set: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

You will find a script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
	loads test data using read.delim; loads training data using read.delim
	merges test data using cbind; merges training data using cbind
	merges test data with training data using rbind
2. Appropriately labels the data set with descriptive variable names. 
	load the list of features (features.txt) using read.delim
	add column names of "subject","activity_id", and feature names from features.txt
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
	create data frame with subject, activity, and columns matching "mean | std" using grep()
4. Uses descriptive activity names to name the activities in the data set
	load the list of activity labels (activity_labels.txt)
	join with the data frame on activity IDs using arrange() and join() from library(plyr)
	rearrange the columns so that subject is in column 1, and select the activity name and all variables, omitting the activity id.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	using library(data.table), convert data frame to data table 
	calculate the mean of each variable for each activity and each subject using lapply and save to a new data table
	relabel columns of new data set to describe what their values represent
