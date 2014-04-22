feature.names <- read.table("features.txt")
activity.labels <- read.table("activity_labels.txt")

x.train.name <- "train/X_train.txt"
y.train.name <- "train/y_train.txt"
subject.train.name <- "train/subject_train.txt"
x.test.name <- "test/X_test.txt"
y.test.name <- "test/y_test.txt"
subject.text.name <- "test/subject_test.txt"

extract <- function(x.name, y.name, subject.name) {
	subject <- read.table(subject.name)
	names(subject) <- c("subject")
	x <- read.table(x.name)
	names(x) <- feature.names$V2
	names.match <- grep("(mean|std)[^F]", feature.names$V2, value = TRUE)
	x.sub <- data.frame(row.names = 1:nrow(x))
	names.valid <- c()
	for (name in names.match) {
		x.sub <- cbind(x.sub, x[[name]])
		name.valid <- gsub("-", "_", name)
		name.valid <- gsub("\\(\\)", "", name.valid)
		names.valid <- c(names.valid, name.valid)
	}
	names(x.sub) <- names.valid
	y <- read.table(y.name)
	y$V1 <- as.factor(y$V1)
	levels(y$V1) <- activity.labels$V2
	names(y) <- c("activity_label")
	data <- cbind(subject, x.sub, y)
	invisible(data)
}

data.train <- extract(x.train.name, y.train.name, subject.train.name)
data.test <- extract(x.test.name, y.test.name, subject.text.name)
data <- rbind(data.train, data.test)

library(reshape2)
variable.names <- names(data)[2:(length(names(data)) - 1)]
data.melting <- melt(data, id = c("subject", "activity_label"), measure.vars = variable.names)
data.casting <- dcast(data.melting, subject + activity_label ~ variable , mean)
write.table(data.casting, file = "dataset.txt")
