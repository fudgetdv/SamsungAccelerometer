# SamsungAccelerometer
Creates a tidy data set the the samsung accelerometer sample set

# Raw Data
The raw data is retrieved from the data folder.  

* activity_label: Has id and activity name
* features:  Has all measurements taken by the Samsung Accelerometer
* subject_train:  Has a list of subjects identified by numbers
* suject_test:  Sames as subject_train
* Y_train:  List the activity conducted by the subject
* Y_test:  Same as Y_train
* X_train:  List the values of each measurement.  Rows or observations for each subject and acitvity is by row.
* X_test:  Same as X_train
 
# Merging Raw Data

1. Joined Y_train and Y_test to activity_label by id to name activity
2. Merged subject_test and subject_train columns
3. Filtered out the feature measurement by searching on std and mean.
4. Removed columns numbers from X_train and X_test to filter out measurement values
5. Combined train and test data sets
6. Showed tidy data set by melting or pivoting on measurements
7. Found the average and standard deviation of subject, activity, and measurement grouping
8. Ordered by subject in descending order
 


