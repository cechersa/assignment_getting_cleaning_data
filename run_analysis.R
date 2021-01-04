## Download the file and unzip it
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="data.zip", method="curl")

unzip("data.zip",exdir="data")


## Read the files into R and build the tables for test and train data sets
library("stringr")
library("dplyr")
list.files("./data")
test <- list.files("./data/test") %>% grep(pattern=".*\\.txt",value=TRUE) %>% paste0("./data/test/",.)
train <- list.files("./data/train") %>% grep(pattern=".*\\.txt",value=TRUE) %>% paste0("./data/train/",.)

tables_test <- lapply(
  test,read.table,header=TRUE
)

tables_train <- lapply(
  train,read.table,header=TRUE
)


## Fix the column names according to info about data sets
colnames(tables_test[[1]]) <- sub("X2","subject",colnames(tables_test[[1]]))
colnames(tables_test[[3]]) <- sub("X5","label",colnames(tables_test[[3]]))
test <- tables_test[[2]]

xcolnames <- read.table("./data/features.txt")
xcolnames <- xcolnames[,2]

for(i in 1:length(colnames(test))){
  for(j in 1:length(xcolnames)){
    if(i == j){
      colnames(test)[i] <- sub(".*",xcolnames[j],colnames(test)[i])
    }
  }
}

test <- cbind(tables_test[[1]],tables_test[[3]],test)

colnames(tables_train[[1]]) <- sub("X1","subject",colnames(tables_train[[1]]))
colnames(tables_train[[3]]) <- sub("X5","label",colnames(tables_train[[3]]))
train <- tables_train[[2]]

for(i in 1:length(colnames(train))){
  for(j in 1:length(xcolnames)){
    if(i == j){
      colnames(train)[i] <- sub(".*",xcolnames[j],colnames(train)[i])
    }
  }
}

train <- cbind(tables_train[[1]],tables_train[[3]],train)

## Merge both data sets
df <- rbind(train,test)


## Extract only features containing means and standard deviations
j <- c(grep("mean|std",colnames(df)))
df <- df[,c(1,2,j)]
df <- subset(df,select=-grep("BodyBody|meanFreq",colnames(df)))


## Transform variable names into descriptive
colnames(df) <- colnames(df) %>%
  gsub(pattern="^t",replacement="timesignal-") %>%
  gsub(pattern="^f",replacement="frecuencysignal-") %>%
  gsub(pattern="\\()",replacement="")

for(i in 1:length(colnames(df))){
  if(str_detect(colnames(df)[i],"time(.*)Jerk-") == TRUE){
    colnames(df)[i] <- sub("^time","jerk",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"time(.*)JerkMag") == TRUE){
    colnames(df)[i] <- sub("timesignal","jerksignalmagnitude",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"time(.*)AccMag|time(.*)GyroMag") == TRUE){
    colnames(df)[i] <- sub("timesignal","timesignalmagnitude",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"frecuency(.*)Jerk-") == TRUE){
    colnames(df)[i] <- sub("^frecuency","frecuencyjerk",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"frecuency(.*)JerkMag") == TRUE){
    colnames(df)[i] <- sub("frecuencysignal","frecuencyjerksignalmagnitude",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"frecuency(.*)AccMag|frecuency(.*)GyroMag") == TRUE){
    colnames(df)[i] <- sub("frecuencysignal","frecuencysignalmagnitude",colnames(df)[i])
  }
}

for(i in 1:length(colnames(df))){
  if(str_detect(colnames(df)[i],"BodyAcc-") == TRUE){
    colnames(df)[i] <- sub("BodyAcc","bodyacceleration",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"BodyAcc(.*)-") == TRUE){
    colnames(df)[i] <- sub("BodyAcc(.*?)-","bodyacceleration-",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"BodyGyro-") == TRUE){
    colnames(df)[i] <- sub("BodyGyro","bodyangularvelocity",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"BodyGyro(.*)-") == TRUE){
    colnames(df)[i] <- sub("BodyGyro(.*?)-","bodyangularvelocity-",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"GravityAcc-") == TRUE){
    colnames(df)[i] <- sub("GravityAcc","gravityacceleration",colnames(df)[i])
  } else if(str_detect(colnames(df)[i],"GravityAcc(.*)-") == TRUE){
    colnames(df)[i] <- sub("GravityAcc(.*?)-","gravityacceleration-",colnames(df)[i])
  }
}

colnames(df) <- tolower(colnames(df))


## Transform activity names into descriptive
colnames(df) <- sub("label","activity",colnames(df))

df$activity <- gsub(1,"walking",df$activity) %>%
  gsub(pattern=2,replacement="walking_upstairs") %>%
  gsub(pattern=3,replacement="walking_downstairs") %>%
  gsub(pattern=4,replacement="sitting") %>%
  gsub(pattern=5,replacement="standing") %>%
  gsub(pattern=6,replacement="laying")


## Creation of a sencond data set with averages for measurements on each activity for each subject
averages_table <- function(x){
  subjects <- unique(x$subject)
  activities <- unique(x$activity)
  
  averages_all <- cbind()
  for(i in seq_len(length(subjects))){
    z <- x[grep(subjects[i],x$subject),]
    for(j in seq_len(length(activities))){
      z2 <- z[grep(activities[j],z$activity),]
      z3 <- data.frame(colMeans(z2[,3:62]))
      colnames(z3) = paste0("subject",subjects[i],"_",activities[j])
      if(exists("averages")==FALSE){
        averages <- z3
      } else{
        averages <- cbind(averages,z3)
      }
    }
    if(exists("averages_all")){
      averages_all <- averages
    } else {
      averages_all <- cbind(averages_all,averages)
    }
  }
  averages_all
}

averages_df <- averages_table(df)


## Transpose the data frame
averages_df <- as.data.frame(t(averages_df))

## Adjust row_names
subject_activity <- rownames(averages_df)
rownames(averages_df) <- NULL
averages_df <- cbind(subject_activity,averages_df)
