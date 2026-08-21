# Week 3 – Statistical Analysis and Predictive Modeling Using R

## Internship Task

This project was completed as part of the Week 3 task focused on **Statistical Analysis and Predictive Modeling using R**.

The objective of this project was to perform statistical analysis on a publicly available dataset, formulate and test hypotheses, develop a predictive classification model, evaluate its performance, and perform model diagnostics.

---

## Project Overview

The **Breast Cancer Wisconsin (Diagnostic) Dataset** was selected for this project.

The analysis was performed using **R and RStudio**.

The project includes:

- Dataset identification and preparation
- Data quality analysis
- Descriptive statistics
- Exploratory data analysis
- Normality testing
- Hypothesis testing
- Correlation analysis
- Logistic regression
- Train/test data splitting
- Confusion matrix analysis
- Model performance evaluation
- 5-fold cross-validation
- ROC curve and AUC analysis
- Model diagnostics
- Cook's distance analysis
- Model limitations and improvement recommendations

---

## Dataset

The project uses the Breast Cancer Wisconsin (Diagnostic) dataset.

### Dataset Information

- Observations: 569
- Original variables: 32
- Predictive features: 30
- Target variable: Diagnosis
- Classes:
  - Benign: 357
  - Malignant: 212
- Missing values: 0
- Duplicate records: 0

The original dataset contains an identifier column, which was removed before predictive modeling.

---

## Technologies Used

- R
- RStudio
- ggplot2
- caret
- pROC

---

## Statistical Analysis

The following statistical techniques were performed:

### Descriptive Statistics

Summary statistics such as:

- Mean
- Median
- Standard deviation
- Minimum
- Maximum

were calculated for important numerical variables.

### Normality Testing

The Shapiro-Wilk test and Q-Q plots were used to examine the distribution of tumor radius.

### Hypothesis Testing

An independent two-sample t-test and Wilcoxon rank-sum test were performed to examine whether tumor radius differs between benign and malignant cases.

### Correlation Analysis

Pearson correlation was used to analyze the relationship between:

`radius_mean`

and

`area_mean`.

---

## Predictive Modeling

A **Logistic Regression** classification model was developed.

The model used the following predictors:

- radius_mean
- texture_mean
- smoothness_mean
- compactness_mean
- concavity_mean

The target variable was:

`diagnosis`

with two classes:

- Benign
- Malignant

---

## Train/Test Split

The dataset was divided into:

- 80% training data
- 20% testing data

A fixed random seed was used to make the results reproducible.

---

## Model Performance

The final model achieved the following results on the independent test set:

| Metric | Result |
|---|---:|
| Accuracy | 95.58% |
| Sensitivity / Recall | 95.24% |
| Specificity | 95.77% |
| Precision | 93.02% |
| F1 Score | 94.12% |
| ROC-AUC | 99.06% |

---

## Confusion Matrix

| Actual / Reference | Predicted Benign | Predicted Malignant |
|---|---:|---:|
| Benign | 68 | 2 |
| Malignant | 3 | 40 |

The model correctly classified 68 benign and 40 malignant observations.

There were:

- 2 false positives
- 3 false negatives

---

## Cross-Validation

5-fold cross-validation was performed using the training dataset.

### Cross-Validation Results

- Accuracy: 93.42%
- Kappa: 0.8584

The cross-validation result supports the consistency of the model across different training and validation folds.

---

## ROC-AUC

The model achieved:

**ROC-AUC = 0.9906**

This indicates excellent discrimination between benign and malignant cases on the evaluated test data.

---

## Model Diagnostics

The following diagnostic analyses were performed:

- Residuals vs Fitted
- Q-Q Residuals
- Scale-Location
- Residuals vs Leverage
- Cook's Distance

Potential influential observations were examined using Cook's distance.

---

## Repository Structure


Week3_Statistical_Analysis_R/
│
├── Dataset/
├── R_Code/
├── Results/
├── Screenshots/
├── Report/
└── README.md
