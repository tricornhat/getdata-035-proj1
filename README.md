# getdata-035-proj1

The R script run_analysis.R loads data sample from a training session and a test
session in a trial of Samsung Galaxy S accelerometer data.

Two sessions of data, one training and one test, are merged and the standard deviation
and mean values are extracted. Data is organized by subject (test or training)
across six different activities.

The test data set is a zip file that unpacks to a "UCI HAR Dataset" directory. The 
run_analysis.R script expects the to be run in the same directory as this.
