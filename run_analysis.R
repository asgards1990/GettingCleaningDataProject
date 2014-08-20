#For my personal computer only
#setwd("C:/Users/sya/Desktop/GettingCleaningDataProject")

#Before beggining one should understand that there are basically
#3 different labels: the variables, which will always be the name
#of the columns of my data frames, they are unique and is the only
#one to be out of 3; the activities which will be displayed as contents 
#of a column; the subjects treated in the same fashion.

#Step 1: obtaining all raw data in a single dataframe.
trainRaw <- read.table("UCI HAR Dataset/train/X_train.txt")
testRaw <- read.table("UCI HAR Dataset/test/X_test.txt")
dataRaw <- rbind(trainRaw,testRaw)

#Obtaining the total number of variables and observations
nVar = ncol(dataRaw) 
nObs = nrow(dataRaw)

#Obtaining the labels of activities with their english name
#the result is column-labeled dataframe
activities <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"),
                    read.table("UCI HAR Dataset/test/y_test.txt"))
colnames(activities)="activities"
activities$activities[activities$activities==1]="WALKING"
activities$activities[activities$activities==2]="WALKING_UPSTAIRS"
activities$activities[activities$activities==3]="WALKING_DOWNSTAIRS"
activities$activities[activities$activities==4]="SITTING"
activities$activities[activities$activities==5]="STANDING"
activities$activities[activities$activities==6]="LAYING"

#Retrieving the names of the variables
nameFeatures <- as.vector(read.table("UCI HAR Dataset/features.txt")[,2])

#Step 2&3&4: Retrieving only measurements on mean&std,
#            and adding the appropriate variable AND activities labels.
#            the former as names of columns and the latter as values
#            in a separate column.

#Initializing the returned dataframe with appropriate dimensions and the
#labels of activities. cleanData will answer step 4.
cleanData <- data.frame(matrix(ncol=0,nrow = nObs))
cleanData <- cbind(cleanData,activities)

for (k in 1:nVar) {
        nameTemp = nameFeatures[k]
        #Check if it is a mean&std measurement, I have 
        #discarded the last few variables via angle()
        #since I don't consider them "measurements"
        #I also discarded the meanFreq() measurements
        if (grepl("mean()",nameTemp,fixed=T)
            ||grepl("std()",nameTemp,fixed=T)) {
                cleanData[nameTemp]=dataRaw[,k]
        }
}

#Step 5: I'll add subjects as column, and a simple conditions-chcking
#        will allow me to get what I want.

#Retrieving the subjects by their numeric labels        
subjects <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"),
                  read.table("UCI HAR Dataset/test/subject_test.txt"))
nameActivities=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                 "SITTING","STANDING","LAYING")

#Adding the labels of the subjects and the activitiesto the rowData
#Since we'll need all initial variables
colnames(dataRaw)=nameFeatures
dataRaw["subjects"]=subjects
dataRaw["activities"]=activities


#Initializing the to be submitted clean data. There are 2 more columns
#compared to the initial raw data since we wish to add activities and
#subjects as new variables.
averagePerActivityAndPerSubject=data.frame(matrix(ncol=nVar+2,nrow = 0))
colnames(averagePerActivityAndPerSubject)<-colnames(dataRaw)

for (subject in 1:30) {
        #Extract the sub data frame containing only measurements of a single 
        #specific subject.
        tempSubject = dataRaw[dataRaw$subject==subject,]
        for (activity in nameActivities) {
                #The name I'll use as row name
                nameTemp = paste("Average values for subject",subject,activity)
                
                #Extract the sub data frame containing only measurements of 
                #a single specific subject and of a single specific activity.             
                tempActivity = tempSubject[tempSubject$activities==activity,]
                
                #Calculate means per column et transform it as a signle row
                #dataframe of correct row name
                tempActivity$activities=0
                tempDataFrame = data.frame(t(colMeans(tempActivity)),check.names=F)
                tempDataFrame$activities=activity
                rownames(tempDataFrame)=nameTemp
                
                #Bind the row to the final data frame to be submitted
                averagePerActivityAndPerSubject = rbind(
                        averagePerActivityAndPerSubject,tempDataFrame)
        }
}

#Writing a .txt output of the clean data, the header is present.
#I chose to set quote to false since the double quotes really mess up
#the readability
write.table(averagePerActivityAndPerSubject,
            "averagePerActivityAndPerSubject.txt",quote=F)

outputVariables <- colnames(averagePerActivityAndPerSubject)
write.table(outputVariables,"features.txt",quote=F)