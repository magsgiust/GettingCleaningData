run_analysis.R

#	1. Merges the training and the test sets to create one data set.	
	#	load test data
		setwd("~/test")
			test_x <- read.delim("X_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
			test_y <- read.delim("Y_test.txt", header=FALSE, sep="")
			test_s <- read.delim("subject_test.txt", header=FALSE, sep="")
	
	#	load training data
		setwd("~/train")
			train_x <- read.delim("X_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
			train_y <- read.delim("Y_train.txt", header=FALSE, sep="")
			train_s <- read.delim("subject_train.txt", header=FALSE, sep="")

	#	merge data
			testdf <- cbind(test_s,test_y,test_x)
			traindf <- cbind(train_s,train_y,train_x)
		df <- rbind(testdf,traindf)

#	2. Appropriately labels the data set with descriptive variable names &
#	3. Extracts only the measurements on the mean and standard deviation for each measurement. 

	#	get features
		setwd("~/")
		features <- read.delim("features.txt", header=FALSE, sep="",stringsAsFactors=FALSE)

	#	add column names and select columns of "mean" and "std"
		fnames <- features$V2
			mycolnames <- c("subject","activity_id",fnames)
			colnames(df) <- mycolnames
		measure <- "mean|std"
			myfeatures <- grep(measure,mycolnames)
			mycols <- c(1,2,myfeatures)
		mydf <- df[,mycols]

#	4. Uses descriptive activity names to name the activities in the data set
	#	name activities using descriptive names
		library(plyr)
		activity <- read.delim("activity_labels.txt", header=FALSE, sep="",stringsAsFactors=FALSE)
			colnames(activity) <- c("activity_id","activity")
			dfact <- arrange(join(activity,mydf),subject)
		dfact <- dfact[,c(3,2,4:82)]

#	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	#	mean of subject & activity
		library(data.table)
		dt <- as.data.table(dfact)
			bygp <- colnames(dfact[,1:2])
			dt2 <- dt[, lapply(.SD,mean), by=bygp]
			cols <- colnames(dt2)
			pattern <- "mean()|meanFreq()|std()"
			col2 <- gsub("()","())", cols, fixed = TRUE)
			col3 <- gsub("mean","mean(mean", col2, fixed = TRUE)
			col4 <- gsub("std","mean(std", col3, fixed = TRUE)
			setnames(dt2,cols,col4)
		myTidyDataSet <- dt2

write.table(myTidyDataSet, file="Mean_by_SubjectActivity.txt",row.names=FALSE)
