Getting and Cleaning Data Course Project: Code Book
===================================================

The following code book describes all the variables and summaries
calculated in the `{run_analysis.R}` script.

**1. Downloading the data**
---------------------------

-   Data was downloaded from the [Human Activity Recognition Using
    Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
    online data set. The folder was unzipped and extracted under the
    folder called `{UCI HAR Dataset}`.

**2. Assigning each relevant data set to variables**
----------------------------------------------------

-   `{activities}` &lt;- `{activity_labels.txt}`: (6 rows, 2 columns)
    *List of activities performed when measurements were taken and their
    corresponding numeric code*
-   `{features}` &lt;- `{features.txt}`: (561 rows, 2 columns) *List of
    variables measured. The selected features come from the
    accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and
    tGyro-XYZ.*
-   `{subject_test}` &lt;- `{test/subject_test.txt}`: (2947 rows, 1
    column) *Each row identifies the subject who performed the activity
    for each window sample. Test subjects represent 30% of the complete
    subject group.*
-   `{x_test}` &lt;- `{test/X_test.txt}`: (2947 rows, 561 columns)
    *Contains feature measurements for test subjects*
-   `{y_test}` &lt;- `{test/y_test.txt}`: (2947 rows, 1 column)
    *Contains activity labels for the test data set*
-   `{subject_train}` &lt;- `{train/subject_train.txt}`: (7352 rows, 1
    column) *Each row identifies the subject who performed the activity
    for each window sample. Train subjects represent 70% of the complete
    subject group.*
-   `{x_train}` &lt;- `{train/X_train.txt}`: (7352 rows, 561 columns)
    *Contains feature measurements for train subjects*
-   `{y_train}` &lt;- `{train/y_train.txt}`: (7352 rows, 1 column)
    *Contains activity labels for the train data set*

**3. Merging data sets**
------------------------

-   `{compfeatX}` (10299 rows, 561 columns) was created by merging
    `{x_test}` and `{x_train}` using the **rbind()** function. It
    contains the complete feature measurements.
-   `{compactsY}` (10299 rows, 1 column) was created by merging
    `{y_test}` and `{y_train}` using the **rbind()** function. It
    contains the complete set of activity labels.
-   `{compsub}` (10299 rows, 1 column) was created by merging
    `{subject_test}` and `{subject_train}` using the **rbind()**
    function. It contains the complete subject identification list.
-   `{mergedDF}` (10299 rows, 563 columns) was created by merging
    `{compsub}`, `{compactsY}` and `{compfeatX}` using the **cbind()**
    function. It represents the complete data. Variable names were
    assigned to each column using the **names()** function (for
    `{compfeatX}`, the second column of `{features}` was used to assign
    column names).

**4. Extracting only mean and standard deviation measurements**
---------------------------------------------------------------

-   `{tidydata}` (10299 rows, 68 columns) was created by subsetting
    `{subject}`, `{activity}` and mean and standard deviation columns
    from `{mergedDF}` using the **select()** function from the **dplyr**
    package. Mean and standard deviation variables were isolated using
    the **grep()** function.

**5. Using descriptive activity names**
---------------------------------------

-   The `{activity}` column values from `{tidydata}` were replaced with
    the corresponding activities extracted from the second column of the
    `{activities}` data frame.

**6. Labeling data set with descriptive variable names**
--------------------------------------------------------

The following substitutions were made in the `{tidydata}` variable names
using the **gsub()** function:  
+ Old: Initial lowercase *t* -&gt; New: *Time* + Old: Initial lowercase
*f* -&gt; New: *Frequency* + Old: *Acc* -&gt; New: *Accelerometer* +
Old: *Gyro* -&gt; New: *Gyroscope* + Old: *Mag* -&gt; New: *Magnitude* +
Old: *BodyBody* -&gt; New: *Body* + Old: *-mean* -&gt; New: *Mean* +
Old: *-std* -&gt; New: *STD*

**7. Creating second tidy data set with group averages**
--------------------------------------------------------

-   `{tidyavg}` (180 rows, 68 columns) was created using the
    **group\_by()** and **summarise()** functions from the **dplyr**
    package. The data was grouped by subject and activity and then
    summarized by obtaining the average for each group.
-   `{FinalData.txt}` was created by exporting `{tidyavg}` as a text
    file using the **write.table()** function.
