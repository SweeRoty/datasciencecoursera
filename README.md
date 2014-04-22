Getting and Cleaning Data Project
=================================
This README file explains the working flow of the run_analysis.R script

1. Load the feature names and activity labels from the text file "features.txt" and "activity_labels.txt" in the working directory.
<pre><code>feature.names &lt;- read.table("features.txt")
	activity.labels &lt;- read.table("activity_labels.txt")
</code></pre>

2. Set the filenames of the X, y and subject data in both training and test set to corresponding character variables.
<pre><code>x.train.name &lt;- "train/X_train.txt"
	y.train.name &lt;- "train/y_train.txt"
	subject.train.name &lt;- "train/subject_train.txt"
	x.test.name &lt;- "test/X_test.txt"
	y.test.name &lt;- "test/y_test.txt"
	subject.text.name &lt;- "test/subject_test.txt"
</code></pre>

3. Extract the mean and standard deviation for measurements in X and then merge it with y and subject data using descriptive names for each variable and different activities.
<pre><code>extract &lt;- function(x.name, y.name, subject.name) {
		subject &lt;- read.table(subject.name)
		names(subject) &lt;- c("subject")
		x &lt;- read.table(x.name)
		names(x) &lt;- feature.names$V2
		names.match &lt;- grep("(mean|std)[^F]", feature.names$V2, value = TRUE)
		x.sub &lt;- data.frame(row.names = 1:nrow(x))
		names.valid &lt;- c()
		for (name in names.match) {
			x.sub &lt;- cbind(x.sub, x[[name]])
			name.valid &lt;- gsub("-", "_", name)
			name.valid &lt;- gsub("\\(\\)", "", name.valid)
			names.valid &lt;- c(names.valid, name.valid)
		}
		names(x.sub) &lt;- names.valid
		y &lt;- read.table(y.name)
		y$V1 &lt;- as.factor(y$V1)
		levels(y$V1) &lt;- activity.labels$V2
		names(y) &lt;- c("activity_label")
		data &lt;- cbind(subject, x.sub, y)
		invisible(data)
	}

	data.train &lt;- extract(x.train.name, y.train.name, subject.train.name)
	data.test &lt;- extract(x.test.name, y.test.name, subject.text.name)
	data &lt;- rbind(data.train, data.test)
</code></pre>

4. Get a tidy data set with the average of each variable for each activity and each subject using melt and dcast functions in reshape2 package.
<pre><code>library(reshape2)
variable.names &lt;- names(data)[2:(length(names(data)) - 1)]
data.melting &lt;- melt(data, id = c("subject", "activity_label"), measure.vars = variable.names)
data.casting &lt;- dcast(data.melting, subject + activity_label ~ variable , mean)
write.table(data.casting, file = "dataset.txt")
</code></pre>

