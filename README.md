# assignment_getting_cleaning_data

---
title: "CODEBOOK"
author: "CH"
date: "2/1/2021"
output: pdf_document
---

## The following code can be performed in the R console or through the CODEBOOK_MD.Rmd in order to get the CODEBOOK for the variables in the tidy_data_Set

## The run_analysis.R is the script to obtain the data set

```{r}
library("stringr")

CODEBOOK <- data.frame("Variable"=c("subject","activity"),"Original_name"=c("X1 in train data set and X2 in test data set", "X5"), "Data_description"=c("Subject who performed the activity","The activity performed by the subject when measurement was taken"))


MEASUREMENTS <- data.frame("Variable" = c("timesignal-bodyacceleration-mean-x",
"timesignal-bodyacceleration-mean-y",
"timesignal-bodyacceleration-mean-z",
"timesignal-bodyacceleration-std-x",
"timesignal-bodyacceleration-std-y",
"timesignal-bodyacceleration-std-z",
"timesignal-gravityacceleration-mean-x",
"timesignal-gravityacceleration-mean-y",
"timesignal-gravityacceleration-mean-z",
"timesignal-gravityacceleration-std-x",
"timesignal-gravityacceleration-std-y",
"timesignal-gravityacceleration-std-z",
"jerksignal-bodyacceleration-mean-x",
"jerksignal-bodyacceleration-mean-y",
"jerksignal-bodyacceleration-mean-z",
"jerksignal-bodyacceleration-std-x",
"jerksignal-bodyacceleration-std-y",
"jerksignal-bodyacceleration-std-z",
"timesignal-bodyangularvelocity-mean-x",
"timesignal-bodyangularvelocity-mean-y",
"timesignal-bodyangularvelocity-mean-z",
"timesignal-bodyangularvelocity-std-x",
"timesignal-bodyangularvelocity-std-y",
"timesignal-bodyangularvelocity-std-z",
"jerksignal-bodyangularvelocity-mean-x",
"jerksignal-bodyangularvelocity-mean-y",
"jerksignal-bodyangularvelocity-mean-z",
"jerksignal-bodyangularvelocity-std-x",
"jerksignal-bodyangularvelocity-std-y",
"jerksignal-bodyangularvelocity-std-z",
"timesignalmagnitude-bodyacceleration-mean",
"timesignalmagnitude-bodyacceleration-std",
"timesignalmagnitude-gravityacceleration-mean",
"timesignalmagnitude-gravityacceleration-std",
"jerksignalmagnitude-bodyacceleration-mean",
"jerksignalmagnitude-bodyacceleration-std",
"timesignalmagnitude-bodyangularvelocity-mean",
"timesignalmagnitude-bodyangularvelocity-std",
"jerksignalmagnitude-bodyangularvelocity-mean",
"jerksignalmagnitude-bodyangularvelocity-std",
"frecuencysignal-bodyacceleration-mean-x",
"frecuencysignal-bodyacceleration-mean-y",
"frecuencysignal-bodyacceleration-mean-z",
"frecuencysignal-bodyacceleration-std-x",
"frecuencysignal-bodyacceleration-std-y",
"frecuencysignal-bodyacceleration-std-z",
"frecuencyjerksignal-bodyacceleration-mean-x",
"frecuencyjerksignal-bodyacceleration-mean-y",
"frecuencyjerksignal-bodyacceleration-mean-z",
"frecuencyjerksignal-bodyacceleration-std-x",
"frecuencyjerksignal-bodyacceleration-std-y",
"frecuencyjerksignal-bodyacceleration-std-z",
"frecuencysignal-bodyangularvelocity-mean-x",
"frecuencysignal-bodyangularvelocity-mean-y",
"frecuencysignal-bodyangularvelocity-mean-z",
"frecuencysignal-bodyangularvelocity-std-x",
"frecuencysignal-bodyangularvelocity-std-y",
"frecuencysignal-bodyangularvelocity-std-z",
"frecuencysignalmagnitude-bodyacceleration-mean",
"frecuencysignalmagnitude-bodyacceleration-std"),"Original_name"=c("tBodyAcc-mean()-X",
"tBodyAcc-mean()-Y",
"tBodyAcc-mean()-Z",
"tBodyAcc-std()-X",
"tBodyAcc-std()-Y",
"tBodyAcc-std()-Z",
"tGravityAcc-mean()-X",
"tGravityAcc-mean()-Y",
"tGravityAcc-mean()-Z",
"tGravityAcc-std()-X",
"tGravityAcc-std()-Y",
"tGravityAcc-std()-Z",
"tBodyAccJerk-mean()-X",
"tBodyAccJerk-mean()-Y",
"tBodyAccJerk-mean()-Z",
"tBodyAccJerk-std()-X",
"tBodyAccJerk-std()-Y",
"tBodyAccJerk-std()-Z",
"tBodyGyro-mean()-X",
"tBodyGyro-mean()-Y",
"tBodyGyro-mean()-Z",
"tBodyGyro-std()-X",
"tBodyGyro-std()-Y",
"tBodyGyro-std()-Z",
"tBodyGyroJerk-mean()-X",
"tBodyGyroJerk-mean()-Y",
"tBodyGyroJerk-mean()-Z",
"tBodyGyroJerk-std()-X",
"tBodyGyroJerk-std()-Y",
"tBodyGyroJerk-std()-Z",
"tBodyAccMag-mean()",
"tBodyAccMag-std()",
"tGravityAccMag-mean()",
"tGravityAccMag-std()",
"tBodyAccJerkMag-mean()",
"tBodyAccJerkMag-std()",
"tBodyGyroMag-mean()",
"tBodyGyroMag-std()",
"tBodyGyroJerkMag-mean()",
"tBodyGyroJerkMag-std()",
"fBodyAcc-mean()-X",
"fBodyAcc-mean()-Y",
"fBodyAcc-mean()-Z",
"fBodyAcc-std()-X",
"fBodyAcc-std()-Y",
"fBodyAcc-std()-Z",
"fBodyAccJerk-mean()-X",
"fBodyAccJerk-mean()-Y",
"fBodyAccJerk-mean()-Z",
"fBodyAccJerk-std()-X",
"fBodyAccJerk-std()-Y",
"fBodyAccJerk-std()-Z",
"fBodyGyro-mean()-X",
"fBodyGyro-mean()-Y",
"fBodyGyro-mean()-Z",
"fBodyGyro-std()-X",
"fBodyGyro-std()-Y",
"fBodyGyro-std()-Z",
"fBodyAccMag-mean()",
"fBodyAccMag-std()"),"Data_description"=rep("desc",each=60))

CODEBOOK <- rbind(CODEBOOK,MEASUREMENTS)

for(i in 1:nrow(CODEBOOK)){
  if(str_detect(CODEBOOK$Variable[i],"mean") == TRUE){
    CODEBOOK$Data_description[i] <- sub("desc","The mean of ",CODEBOOK$Data_description[i])
  } else if(str_detect(CODEBOOK$Variable[i],"std") == TRUE){
    CODEBOOK$Data_description[i] <- sub("desc","The standard deviation of ",CODEBOOK$Data_description[i])
  }
}

for(i in 1:nrow(CODEBOOK)){
  if(str_detect(CODEBOOK$Variable[i],"frecuencysignal-") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"the Fast Fourier Transform (FFT) applied to the signals ")
  } else if(str_detect(CODEBOOK$Variable[i],"frecuency") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"the Fast Fourier Transform (FFT) applied to ")
  }
}

for(i in 1:nrow(CODEBOOK)){
  if(str_detect(CODEBOOK$Variable[i],"frecuencysignalmagnitude-") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"the magnitude, calculated using the Euclidean norm, of the signals ")
  } else if(str_detect(CODEBOOK$Variable[i],"magnitude") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"the magnitude, calculated using the Euclidean norm, of ")
  }
}

for(i in 1:nrow(CODEBOOK)){
  if(str_detect(CODEBOOK$Variable[i],"timesignal") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"the time raw signals ")
  } else if(str_detect(CODEBOOK$Variable[i],"jerksignal") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"the Jerk signals derived from time raw signals ")
  }
}

for(i in 1:nrow(CODEBOOK)){
  if(str_detect(CODEBOOK$Variable[i],"acceleration") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"obtained from accelerometer ")
  } else if(str_detect(CODEBOOK$Variable[i],"angularvelocity") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"obtained from gyroscope ")
  }
}

for(i in 1:nrow(CODEBOOK)){
  if(str_detect(CODEBOOK$Variable[i],"body") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"on the body")
  } else if(str_detect(CODEBOOK$Variable[i],"gravity") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"on the gravity")
  }
}

for(i in 1:nrow(CODEBOOK)){
  if(str_detect(CODEBOOK$Variable[i],"-y$") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"'s Y axis")
  } else if(str_detect(CODEBOOK$Variable[i],"-x$") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"'s X axis")
  } else if(str_detect(CODEBOOK$Variable[i],"-z$") == TRUE){
    CODEBOOK$Data_description[i] <- paste0(CODEBOOK$Data_description[i],"'s Z axis")
  } 
}

CODEBOOK
```

