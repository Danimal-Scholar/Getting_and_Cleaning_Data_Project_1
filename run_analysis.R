#set working directory one above the test and train
library(dplyr)

###Check for existence of processed file alldata.csv
#x_test and x_train are the actual numbers of the 561 variables

if(file.exists("alldata.csv") != TRUE){
     print("preparing file")
     x_test <- read.table("./test/x_test.txt")
     x_train<- read.table("./train/x_train.txt")

     # subject test and train are the people involved - 1->30

     subject_test <- read.table("./test/subject_test.txt")
     subject_train <- read.table("./train/subject_train.txt")

     #y_test and y_train are the types of activity (walking, etc)
     #enumerated from 1 to 6

     y_test <- read.table("./test/y_test.txt")
     y_train <- read.table("./train/y_train.txt")
     activity_labels <- read.table("activity_labels.txt")



     # what you call the variables!
     features_ <- read.table("features.txt")


     subject_total <- rbind(subject_test,subject_train)
     x_total <- rbind(x_test,x_train)
     y_total <- rbind(y_test,y_train)

     #pull names from the file to be used as colnames for data frame
     names(x_total) <- as.character(features_[,2])

     names(subject_total) <- "subject"
     #right_join from dplyr package identifies numbers with activity
     #WHILE PRESERVING THE ORDER OF THE VALUES
     #this is the MOST ELEGANT way I can think of which does this
     labels_total <-  right_join(activity_labels,y_total)
     names(labels_total) = c("activity_number", "activity_type")

     alldata <- cbind(subject_total, labels_total, x_total)
     write.csv(alldata,"alldata.csv")


     #clean out the junk and leave only the big file - the underscore is the selection
     rm(list = ls(pattern = "_"))
}
##########################################################################################
##########################################################################################
#After writing big file, we drill down to what we need

if (!any(grepl("alldata",ls()))){
     alldata <- read.csv("alldata.csv")
}

use_columns <- grep("subject|activity|[Mm]ean|std",names(alldata),value = TRUE)


#We remove the "MeanFreq from the search - these are related to power spectra and
#are not averages in time window but weighted averages in frequency space.

use_columns <- use_columns[!grepl("[Mm]ean[Ff]req",use_columns)]
means_std_subset <- subset.data.frame(alldata, select = use_columns)

#From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.

meanZ <- tbl_df(means_std_subset) %>% arrange(subject, activity_type) %>%
     group_by(subject,activity_type) %>% summarize_all(mean)

write.table(means_std_subset,"subsetdata.txt", row.names = FALSE)
write.table(meanZ, "subject_activity_means.txt", row.names = FALSE)

#leave CSV's, and final data set, no other footprints.

rm(alldata)
rm(list = ls(pattern = "_"))