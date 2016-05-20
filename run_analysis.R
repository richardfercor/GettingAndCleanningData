#Check if the download.zip file already exist. If not, download from the website

if (!file.exists("download.zip")){
  uri<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(uri,destfile = "download.zip")
}

#once downloaded the file, we need to unzip it.

unzip("download.zip", files = NULL)


#read subject datasets and merge into one
subjecttraintable<-read.table("UCI HAR Dataset/train/subject_train.txt",header = F)
subjecttesttable<-read.table("UCI HAR Dataset/test/subject_test.txt",header = F)
mainsubjecttable<-rbind(subjecttraintable,subjecttesttable)
names(mainsubjecttable)<-"Subject"


#read activity datasets and merge into one
trainlabels<-read.table("UCI HAR Dataset/train/Y_train.txt",header = F)
testlabels<-read.table("UCI HAR Dataset/test/Y_test.txt",header = F)
mainlabelstable<-rbind(trainlabels,testlabels)
names(mainlabelstable)<-c("Activity")

##read activity list to get the names and apply this name to the column to treat it as factor
labels<-read.delim("UCI HAR Dataset/activity_labels.txt",header = FALSE)
labels$V1<-gsub("[0-9] ","",labels$V1)
names(labels)<-"name"
mainlabelstable$Activity<-as.factor(mainlabelstable$Activity)
levels(mainlabelstable$Activity)<-labels$name



##read measurements train and test tables and merge them into one
measurementstrainingtable<-read.table("UCI HAR Dataset/train/X_train.txt",header = F)
measurementstesttable<-read.table("UCI HAR Dataset/test/X_test.txt",header = F)
mainmeasurementstable<-rbind(measurementstrainingtable,measurementstesttable)

#read features for mean and std and create the index vector
features<-read.table("UCI HAR Dataset/features.txt")
names(features)<-c("index","name")
indexes<-features[grep("mean|std",features$name),1]

#filter X table with column indexes
mainmeasurementstable<-mainmeasurementstable[,indexes]

#use feature names to name all column properly
names(mainmeasurementstable)<-features[indexes,2]


##merge all main datasets into one by columns
finaldataset<-cbind(mainsubjecttable,mainmeasurementstable,mainlabelstable)


# creates tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
meangroup<-group_by(finaldataset,Activity,Subject)
tidy<-summarise_each(meangroup,funs(mean))

write.table(tidy,row.name=FALSE,file="tidy.txt")
