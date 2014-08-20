   Code Book
===============

All data hereby present derive from dataset present under the folder UCI HAR Dataset which description 
can be found on http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

====================================================

This code book deals exclusively with the final result saved under 'averagePerActivityAndPerSubject.txt'
which is a dataframe of 180 observations for 563 variables and represents the average value of 561 numeric
variables deduced from different measuments per activity (there are 6 activities: WALKING,WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING) and per subject (there are 30) from the following experience:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled 
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal,
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore 
a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating 
variables from the time and frequency domain.

The list of variables is deduce by following means:
====================================================

Note that all variables are average per activity per subject for the same variable which is consistenly obtained by
using specific functions on different measurements. 

Here is the list of the measurement:
====================================
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Here is the list of functions used to obtain the variables:
===========================================================

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional variables are obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
============================================================================================================================

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The last two variables are:
===========================

- subjects: indicating the subject over whom the average of the variable is calculated. It is an unique integer attributed to the subject.

- activities: indicating the activity over which the average of the variable is calculated. There are 6 possible activities:
	      WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING


The complete list of variables of each feature vector is available in 'features.txt'

How the code works:
===================

All code is in the file 'run_analysis.R'. Explanations are provided in the body of the code.

The tidy data fufilling the project purpose is called averagePerActivityAndPerSubject and is saved
under the .txt file of the same name. It is obtained by using the test and train sets from the folder
'UCI HAR Dataset'.

We have:
- Load the data into R.
- Append the test sets to train sets to obtain a dataset of name 'dataRaw'.
- load the data relative to activities. 
- Change to numeric labeling to its English equivalent and append the test activities to train activities 
to obtain a dataframe of name 'activities' of single column
- Same steps for subjects and we obtain the dataframe of name 'subjects' of single column.
- Append 'subjects' and 'activities' to 'dataRaw' to create a dataframe with 563 varibales.
- We create 'averagePerActivityAndPerSubject' by giving it 563 columns and same names as dataRaw.
It will be out output clean data.
- Use a double for loop by fixing first the subject and extract the sub-dataframe of 'dataRaw' corresponding 
to that subject and then extract from the resulting dataframe the sub-dataframe of a single activity. 
- We average over the resulting sub-sub-dataframe and append the result to 'averagePerActivityAndPerSubject'.
As row names I have used the sentence "average values for subject x y" where x is the label of the subject and
y is the performed activity.

- By then end we should obtain an 'averagePerActivityAndPerSubject' dataframe of dimensions 180*563. The variables
are ordered exactly by by increasing order for the labels of subjects first then to the activities ordered exactly
as mentionned in the steps above.

Here is the Github link to the work:
====================================
https://github.com/asgards1990/GettingCleaningDataProject

Author:
=========
SU YANG
FREQUENTED INSTITUTIONS: ECOLE POLYTECHNIQUE, ECOLE DES MINES DE PARIS, ECOLE TELECOM DE PARIS
FOR GETTING AND CLEANING DATA COURSE OF UNIVERSITY JOHNS HOPKINS ON COURSERA.
AUGUST,20TH,2014