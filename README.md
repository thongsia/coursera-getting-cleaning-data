# coursera-getting-cleaning-data
1. Merges the training and the test sets to create one data set. Uses features.txt as descriptive measurement names.

2. Extracts only the measurements on the mean and standard deviation for each measurement. Uses regular expression "mean\\(|std\\(" to pick only mean and standard deviation measurements.

3. Uses descriptive activity names to name the activities in the data set. Uses activity_labels.txt as descriptive activity names.

4. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. Uses aggregate function. Writes to newdat.txt.
