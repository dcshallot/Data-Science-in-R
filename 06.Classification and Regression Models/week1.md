Practical Machine Learning week1
================
Dingchong
Friday, September 05, 2014

Week 1
======

Prediction motivation (8:26)
----------------------------

Study design -train vs test
Consceptual issues - out of sample error, ROC
practical implementation - caret package

What is prediction? (8:39)
--------------------------

Relative importance of steps (9:45)
-----------------------------------

### Components of a predictor:

question -&gt; input data -&gt; features -&gt; algorithm -&gt; parameters -&gt; evaluation
\#\#\#Features matter! Properties of good features:
Load to data compression
Retain relevant information
Are created based on expert application knowledge
\#\#\#Common mistakes trying to automate feature selection
not paying attention to data-specifc quirks:outliers
\#\#\# issues to consider interpretable, simple, accurate, fast, scalable
techblog.netflix.com/2014/04/netflix-recommendations-beyongd-5-stars.html

In and out of sample errors (6:57)
----------------------------------

issues about overfitting

Prediction study design (9:05)
------------------------------

split data into: traning, testing, validation
pick features: use cross-validation; pick prediction function: use cross-validation
www.kaggle.com/
avoid small sample sizes:
for binary outcome, probability of perfect classification is approximately (1/2)^n.
????Խ??????????ȷ?ĸ???ԽС????ģ?͵?????Խ???ԡ?

Ĵָ????
????????60%ѵ��??20%???ԣ?20%???????飻????????60-40%??С??????cross validation

Types of errors (10:35)
-----------------------

### for descrete data

Sensitivity :TP(TP+FN) specificity: TN/(FP+TN) \#\#\# for continuous data MSE,RMSE

Receiver Operating Characteristic (5:03)
----------------------------------------

ROC curve

Cross validation (8:20)
-----------------------

1.use the origin training set,
2.split it into training/test sets;
3.build a model on the training set(new);
4.evaluate on the test set;
5.repeat and average the estimated errors

Used for: pick varibales into model, type of function, parameters , comparing different predictors

types of corss validation: randomsampling, k-fold, leave one out

k-fold: larger k , less bias, more variance, smaller k, more bias, less variance
random sampling must be done without replacement, or else is bootstrap(underestimates of the error)

What data should you use? (6:01)
--------------------------------

Week 2
======

Caret package (6:16)
--------------------

Data slicing (5:40)
-------------------

Training options (7:15)
-----------------------

Plotting predictors (10:39)
---------------------------

Basic preprocessing (10:52)
---------------------------

Covariate creation (17:31)
--------------------------

Preprocessing with principal components analysis (14:07)
--------------------------------------------------------

Predicting with Regression (12:22)
----------------------------------

Predicting with Regression Multiple Covariates (11:12)
------------------------------------------------------

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00
