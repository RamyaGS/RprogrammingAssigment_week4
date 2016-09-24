
The following are performed  by `run_analysis.R` in that order:

1.The features that are the mean and standard deviation measures  are extracted and cleaned to obtain readable names.`featuresRequired` contains the indexes of the required features and `featuresRequired.Names` contains the names.

2.Subject data is extracted into `testSubject` and `trainingSubject` for test and train data respectively.

3.Activity data is extracted into `testActivity` and `trainActivity`.

4.The `test` and `train` objects contain data extracted only by the features selected.

5.`fullData` contains the merged test and train data with meaningful column names.The data is combined using `rbind()`.

6.The `activity` and `subject` variable names are converted to factors with levels .

7.Another dataset containing the averages of the variables with `finalData` grouped by `subject` and `activity` using the `dplyr` functions `group_by()` and `summarize_each()` is created and stored in `tidy_data.txt`


