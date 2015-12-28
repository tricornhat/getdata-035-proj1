# Load all the data
subjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjtest <- read.table("UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Regex to identify the mean() and std() measurements and
# set up a logical vector to be applied to columns
NAME_LV <- grepl("-mean\\(|-std\\(", features$V2, ignore.case = TRUE)

# Convert column names to valid R names
names <- make.names(features$V2)

# Make firendlier names (#3)
names <- gsub("^t", "time", names)
names <- gsub("^f", "freq", names)
names <- gsub("Acc", "Accelerometer", names)
names <- gsub("Gyro", "Gyroscope", names)
names <- gsub("Mag", "Magnitude", names)
# Tidy up dots left by make.names()
names <- gsub("\\.\\.\\.", ".", names)
names <- gsub("\\.\\.$", "", names)
names <- gsub("\\.\\.", ".", names)
names <- gsub("\\.$", "", names)

# Assign column names (#4)
colnames(xtest) <- names
colnames(xtrain) <- names

# Mark test vs training
xtest$subject <- "test"
xtrain$subject <- "train"

# Add activities
xtest$activity <- ytest$V1
xtrain$activity <- ytrain$V1

# concatenate data sets (#1)
D <- rbind(xtest, xtrain)

# Convert activity from a number to a chr factor
D$activity <- factor(D$activity, levels=activity$V1, labels=activity$V2)

# Apply logical vector to filter on mean and std columns (#2)
D <- D[,NAME_LV]

# Group by subject and activity then take average of all columns
D2 <- D %>% 
        group_by(subject, activity) %>%
        summarize_each(funs(mean))

write.table(D2, "analysis.txt", row.names = FALSE)
write.csv(D2, file="analysis.csv")
