## 0. Define some constants
#N = 100 # Data is too large, so we play with 100 rows first.
N = -1
w = 16 # fixed width of data
fnum = 561

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement. 
features = read.csv("UCI HAR Dataset/features.txt", 
                    header=FALSE, 
                    sep=" ", 
                    colClasses=c("integer","character"))
dat_X_test = read.fwf("UCI HAR Dataset/test/X_test.txt", 
                      n=N, 
                      widths=rep(w,fnum), 
                      col.names=features$V2, 
                      check.names=FALSE, 
                      colClasses=rep("numeric",fnum))
dat_X_train = read.fwf("UCI HAR Dataset/train/X_train.txt", 
                       n=N, 
                       widths=rep(w,fnum), 
                       col.names=features$V2, 
                       check.names=FALSE, 
                       colClasses=rep("numeric",fnum))
dat_X = rbind(dat_X_test[,grep("mean\\(|std\\(",names(dat_X_test))],
              dat_X_train[,grep("mean\\(|std\\(",names(dat_X_train))])

## 3. Uses descriptive activity names to name the activities in the data set
labels = read.csv("UCI HAR Dataset/activity_labels.txt", 
                  header=FALSE, 
                  sep=" ", 
                  colClasses=c("integer","character"))
dat_Y_test = read.csv("UCI HAR Dataset/test/y_test.txt", 
                      header=FALSE, 
                      col.names = c("Activity"), 
                      colClasses = c("integer"),
                      nrows=N)
dat_Y_train = read.csv("UCI HAR Dataset/train/y_train.txt", 
                       header=FALSE, 
                       col.names = c("Activity"), 
                       colClasses = c("integer"),
                       nrows=N)
dat_Y = rbind(dat_Y_test,dat_Y_train)
activity = sapply(dat_Y,function(x) labels$V2[x])

subject_test = read.csv("UCI HAR Dataset/test/subject_test.txt", 
                        header = FALSE,
                        colClasses = c("integer"),
                        col.names = c("SubjectID"),
                        nrows = N)
subject_train = read.csv("UCI HAR Dataset/train/subject_train.txt", 
                         header = FALSE,
                         colClasses = c("integer"),
                         col.names = c("SubjectID"),
                         nrows = N)
subject = rbind(subject_test, subject_train)

dat = cbind(subject, activity, dat_X)

## 4. Appropriately labels the data set with descriptive variable names. 
# Done using col.names above

## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
newdat = aggregate(subset(dat,select = c(-SubjectID,-Activity)), 
                   by = list(SubjectID=dat$SubjectID,Activity=dat$Activity), 
                   FUN = mean)
write.table(newdat,file='newdat.txt',row.names=FALSE)