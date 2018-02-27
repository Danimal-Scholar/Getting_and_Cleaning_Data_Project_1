###This file describes additional analysis to the measurements obtained in the files "features_info.txt" and "features.txt".


Values for x_test.txt, y_test.txt, x_train.txt, y_train.txt,subject_test.txt, subject_train.txt (test and training sets) were merged into columns, in sequence of test/train.
x_test and x_train correspond to the measurements and y_test, y_train to the particular activity (enumerated 1-6), and subject_test, subject_train enumerate the human performing the activity.


Column headers were added verbatim from the file "features.txt" for each of the 561 measurements, and the description of the activities (STANDING,WALKING, etc) corresponding to the numbers 1-6 were parsed into a column with order of subject and activity number preserved.

##First portion of R-script "run_analysis.R" delineates the procedure of combining these data, into file "alldata.csv"
Functions in R including specialized expressions from the DPLYR package produce this data frame.

Our post-processing instruction was to select all time-window-average (mean) and standard deviation (STD) taken for relevant measurements. Note that 'meanfreq' measurements do not apply. These are NOT time-averages of the t-window measurements, they are weighted averages of the FFT power spectrum.

See file "code_book.txt" for included variables. These are placed in the file "subsetdata.txt". 
Data were sorted first by subject and then by activity type, and each sort- pair was then averaged, e.g. subject 1, WALKING, subject 1, STANDING, etc.

##Second portion selects and sorts the data as instructed and processes the requested means over subject/activity
See file "subject_activity_means.txt"  Note script checks if files are written to avoid duplication of effort. Deleting or renaming "alldata.csv" will start the process from the beginning if desired.

Corresponding column names in code book are formatted as follows - note however DPLYR replacement of characters ',' '(' ')' '-' with '.' to make them DPLYR-friendly titles.:

subject
activity_number
activity_type
tBodyAcc.mean...X
etc.

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.