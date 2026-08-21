# Dataset

## Dataset Name

Breast Cancer Wisconsin (Diagnostic) Dataset

## Description

This folder contains the dataset used for the Week 3 statistical analysis and predictive modeling project.

The dataset contains measurements calculated from digitized images of fine needle aspirate samples of breast masses.

The target variable is the diagnosis of the tumor.

## Dataset Details

- Observations: 569
- Original variables: 32
- Predictor variables: 30
- Target variable: Diagnosis
- Benign cases: 357
- Malignant cases: 212
- Missing values: 0
- Duplicate records: 0

## Files

### wdbc.data

The raw dataset used in the R analysis.

### wdbc.names

Dataset description and feature information.

## Target Variable

The original diagnosis values are:

- B = Benign
- M = Malignant

During analysis, these were converted to:

- Benign
- Malignant

## Data Preparation

The following preprocessing steps were performed:

1. Dataset imported into R.
2. Column names were assigned.
3. Missing values were checked.
4. Duplicate records were checked.
5. Diagnosis was converted into a factor.
6. The identifier column was removed before modeling.
7. The dataset was divided into training and testing data.

## Source

The dataset is associated with the UCI Machine Learning Repository.

