##Changing the working directory to the data folder "UCI HAR Dataset"
setwd("C:/Users/konan/Desktop/Coursera - Data Science/UCI HAR Dataset")

##Reading columns' names from the file "feature.txt"
columns <- read.table("features.txt", colClasses = "character")

##Reading training's data
x_train <-read.table("./train/X_train.txt")
y_train <-read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
train_columns <- cbind(subject_train,y_train,x_train)

##Reading test's data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt") 
test_columns <- cbind(subject_test,y_test,x_test)

##Merging the training and the test sets to create one data set (Question 1)
dataset <- rbind(train_columns,test_columns)

##Changing dataset1's columns' names (Question 4)
names(dataset)[1]<-"Subject"
names(dataset)[2]<-"Activity"
for(i in 3:563) { 
  names(dataset)[i] <- columns$V2[i-2]
}

##Reading activity labels and setting them in "dataset" (Question 3)
actlabels_tmp <- scan("activity_labels.txt", character(), quote ="")
actlabels <- actlabels_tmp[c(2,4,6,8,10,12)]
dataset$Activity <- actlabels[dataset$Activity]

##Searching for "mean" and "std" in the columns' names and extracting the chosen columns (Question 2)
chosen_columns <- grep("mean|std", names(dataset), value = TRUE)
dataset <- dataset[ ,c("Subject","Activity",chosen_columns)]

##Writing the last dataset
library(magrittr)
library(dplyr)
last_dataset <- dataset%>% group_by(Subject,Activity)%>% summarise_all(mean)
write.table(last_dataset, file = "Course Project.txt", row.names = FALSE)
