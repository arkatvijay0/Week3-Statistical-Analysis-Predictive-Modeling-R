# R Code

## Description

This folder contains the complete R script used for the Week 3 Statistical Analysis and Predictive Modeling project.

## Main File

### statistical_analysis.R

This script contains the complete analysis workflow from dataset loading to model evaluation.

## Analysis Steps

The R script performs the following tasks:

1. Clear the R environment
2. Load the dataset
3. Inspect the dataset
4. Assign column names
5. Check missing values
6. Check duplicate records
7. Convert diagnosis into a factor
8. Remove the ID column
9. Calculate descriptive statistics
10. Analyze diagnosis distribution
11. Perform normality testing
12. Generate Q-Q plots
13. Perform an independent two-sample t-test
14. Perform a Wilcoxon rank-sum test
15. Perform Pearson correlation analysis
16. Generate exploratory visualizations
17. Split the data into training and testing sets
18. Build a logistic regression model
19. Generate predictions
20. Create a confusion matrix
21. Calculate classification metrics
22. Perform 5-fold cross-validation
23. Generate an ROC curve
24. Calculate AUC
25. Perform model diagnostics
26. Calculate Cook's distance
27. Save model results

## Packages Used

```r
library(ggplot2)
library(caret)
library(pROC)
