CodeBook---Getting and Cleaning Data Project
============================================
This file describes the variables in the final tidy data set and all the transformations performed to clean up the data.

1. The tidy data set has 180 rows and 68 columns. 

2. The first column is named "subject", referring to the subject who was performing the activity. The subject information is obtained from the "subject_train" and "subject_test" text files in the training and test directories. Then "cbind" function is used to add the subject information to the tidy data set. 

3. The second column is named "activity_name", referring to what kind of activities this particular subject was performing. The activity name mapping information is recorded in the "activity_labels" text file. The following code was used to perform the mapping.
<pre><code>y &lt;- read.table(y.name)              # Read the training or test labels from the "y_train" or "y_test" file.
    y$V1 &lt;- as.factor(y$V1)              # Change the type of the labels to factor.
    levels(y$V1) &lt;- activity.labels$V2   # Reset the levels of the labels using their activity names.
    names(y) &lt;- c("activity_name")       # Change the column name to "activity_name".
</code></pre>

4. All the rest columns are about the mean and standard deviation for each measurement in the original data set. They are exctracted by using the "grep" function. 
<pre><code>names.match &lt;- grep("(mean|std)[^F]", feature.names$V2, value = TRUE) # The "feature.names" variable refers to a data frame containing all the feature names.
</code></pre>
According to the following R variable name restrictions: 
<pre><code>A syntactically valid name consists of letters, numbers and the dot or underline characters and starts with a letter or the dot not followed by a number.
</code></pre>
Trasformations below have been performed by using the "gsub" function to make the variable name valid:
<pre><code>name.valid &lt;- gsub("-", "_", name)	             # replace all the "-" with "_" in the variable names
    name.valid &lt;- gsub("\\(\\)", "", name.valiid)	  # delete all the "(" and "}" in the variable names
</code></pre>	