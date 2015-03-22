
X_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"")

y_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"")

X_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"")

y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"")

features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"")

# prob useless but attempt to m ake data frame
X_train_df <- data.frame(matrix(unlist(X_train), nrow=7352, byrow=T))
X_test_df <- data.frame(matrix(unlist(X_test), nrow=2947, byrow=T))

# at this point, try to issolate the mean and stv
hold <- as.vector(features[[2]])
truths <- replicate(561, FALSE)
# for Mean
true <- grep("mean", hold)
truths[true] <- TRUE
# for standard deviation
stdtrue <- grep("std", hold)
truths[stdtrue] <- TRUE



# pointless but for my own reference, Set names of x values
colnames(X_train_df) <- features[[2]]
colnames(X_test_df) <- features[[2]]

# Set names of y value
colnames(y_train) <- c("Excercise")
colnames(y_test) <- c("Excercise")

# Group aggregate data sets to either train or test
train <- cbind(y_train, X_train_df)
test <- cbind(y_test, X_test_df)

# here i will inistialize vectors with identitifer and add simply from thruths
train_true <- train[[1]]
count_train <- 2
for(i in truths){
  if(i == TRUE) {
    train_true <- cbind(train_true, train[[count_train]])
  }
  count_train <- count_train + 1
}
# for test
test_true <- test[[1]]
count_test <- 2
for(i in truths){
  if(i == TRUE) {
    test_true <- cbind(test_true, test[[count_test]])
  }
  count_test <- count_test + 1
}
## reinitialize train and test
train <- train_true
test <- test_true

# adding labels
hold2 <- append("identifier", hold)
colnames(test) <- hold2
colnames(train) <- hold2

# add test/train identifier
id_train <- replicate(7352, "train")
id_test <- replicate(2947, "test")
id_train <- as.data.frame(id_train)
id_test <- as.data.frame(id_test)
colnames(id_train) <- "identitifer"
colnames(id_test) <- "identitifer"
train <- cbind(id_train, train)
test <- cbind(id_test, test)


# Aggregate both test and train to 1 data set
data <- rbind(train, test)

# To output the file
write.table(data, file = "~/OneDrive/DataScience/GETing+Cleaning+Data/random.txt", row.name=FALSE) 