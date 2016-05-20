##Code Book

 - This script download data from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
 - This data contains two data sets training and test that is merged into only one dataset
 - Meassurements for this dataset are on X_training.txt and X_test.txt
 - Activity for this dataset are on Y_training.txt and Y_test.txt.
 - Subjects for this dataset are on subject_train.txt and subject_test.txt
 - The script filter data to keep only variables with mean or std values
 - The script group by activity and subject and perform a mean for all previous variables
 - At the end write tidy dataset into a text file: tidy.txt