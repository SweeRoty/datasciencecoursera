Getting and Cleaning Data Project
=================================
This README file explains the working flow of the "run_analysis.R" script

###1st: Load the feature names and activity labels from the text file "features.txt" and "activity_labels.txt" in the working directory.
<pre><code>feature.names `<`- read.table("features.txt")
activity.labels `<`- read.table("activity_labels.txt")</code></pre>

###2nd: set the file name of in both train and test set.


