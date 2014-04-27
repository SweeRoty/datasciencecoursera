CodeBook---Getting and Cleaning Data Project
============================================
This file describes the variables in the final tidy data set and all the transformations performed to clean up the data.

1. The tidy data set has 180 rows and 68 columns. 

2. The first column is named "subject", referring to the subject who was performing the activity. The subject information is obtained from the subject_train and subject_test text files in the training and test directories. Then cbind function is used to add the subject information to the tidy data set. 

3. The second column is named "activity_name", referring to what kind of activities this particular subject was performing. The activity name mapping information is recorded in the activity_labels text file. The following code is used to perform the mapping.
<pre><code>y &lt;- read.table(y.name)              # Read the training or test labels from the y_train or y_test file.
    y$V1 &lt;- as.factor(y$V1)              # Change the type of the labels to factor.
    levels(y$V1) &lt;- activity.labels$V2   # Reset the levels of the labels using their activity names.
    names(y) &lt;- c(activity_name)       # Change the column name to activity_name.
</code></pre>

4. All the rest columns are about the mean and standard deviation for each measurement in the original data set. They are exctracted by using the grep function. 
<pre><code>names.match &lt;- grep((mean|std)[^F], feature.names$V2, value = TRUE) # The feature.names variable refers to a data frame containing all the feature names.
</code></pre>
According to the following R variable name restrictions: 
<pre><code>A syntactically valid name consists of letters, numbers and the dot or underline characters and starts with a letter or the dot not followed by a number.
</code></pre>
Trasformations below have been performed by using the gsub function to make the variable name valid:
<pre><code>name.valid &lt;- gsub(-, _, name)	             # replace all the - with _ in the variable names
    name.valid &lt;- gsub(\\(\\), , name.valiid)	  # delete all the ( and ) in the variable names
</code></pre>
Their names are showed as follows, "mean" represents the mean value and "std" represents the standard deviation value: 
<pre><code>tBodyAcc_mean_X 
tBodyAcc_mean_Y 
tBodyAcc_mean_Z 
tBodyAcc_std_X 
tBodyAcc_std_Y 
tBodyAcc_std_Z 
tGravityAcc_mean_X 
tGravityAcc_mean_Y 
tGravityAcc_mean_Z 
tGravityAcc_std_X 
tGravityAcc_std_Y 
tGravityAcc_std_Z 
tBodyAccJerk_mean_X 
tBodyAccJerk_mean_Y 
tBodyAccJerk_mean_Z 
tBodyAccJerk_std_X 
tBodyAccJerk_std_Y 
tBodyAccJerk_std_Z 
tBodyGyro_mean_X 
tBodyGyro_mean_Y 
tBodyGyro_mean_Z 
tBodyGyro_std_X 
tBodyGyro_std_Y 
tBodyGyro_std_Z 
tBodyGyroJerk_mean_X 
tBodyGyroJerk_mean_Y 
tBodyGyroJerk_mean_Z 
tBodyGyroJerk_std_X 
tBodyGyroJerk_std_Y 
tBodyGyroJerk_std_Z 
tBodyAccMag_mean 
tBodyAccMag_std 
tGravityAccMag_mean 
tGravityAccMag_std 
tBodyAccJerkMag_mean 
tBodyAccJerkMag_std 
tBodyGyroMag_mean 
tBodyGyroMag_std 
tBodyGyroJerkMag_mean 
tBodyGyroJerkMag_std 
fBodyAcc_mean_X 
fBodyAcc_mean_Y 
fBodyAcc_mean_Z 
fBodyAcc_std_X 
fBodyAcc_std_Y 
fBodyAcc_std_Z 
fBodyAccJerk_mean_X 
fBodyAccJerk_mean_Y 
fBodyAccJerk_mean_Z 
fBodyAccJerk_std_X 
fBodyAccJerk_std_Y 
fBodyAccJerk_std_Z 
fBodyGyro_mean_X 
fBodyGyro_mean_Y 
fBodyGyro_mean_Z 
fBodyGyro_std_X 
fBodyGyro_std_Y 
fBodyGyro_std_Z 
fBodyAccMag_mean 
fBodyAccMag_std 
fBodyBodyAccJerkMag_mean 
fBodyBodyAccJerkMag_std 
fBodyBodyGyroMag_mean 
fBodyBodyGyroMag_std 
fBodyBodyGyroJerkMag_mean 
fBodyBodyGyroJerkMag_std
</code></pre>