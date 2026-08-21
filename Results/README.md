# Results

## Description

This folder contains the outputs generated during the statistical analysis and predictive modeling process.

## Model Performance

The final logistic regression model achieved:

| Metric | Result |
|---|---:|
| Accuracy | 95.58% |
| Sensitivity | 95.24% |
| Specificity | 95.77% |
| Precision | 93.02% |
| F1 Score | 94.12% |
| ROC-AUC | 99.06% |

## Cross-Validation

5-fold cross-validation produced:

- Accuracy: 93.42%
- Kappa: 0.8584

## Confusion Matrix

| Actual | Predicted Benign | Predicted Malignant |
|---|---:|---:|
| Benign | 68 | 2 |
| Malignant | 3 | 40 |

## Result Files

### model_performance.csv

Contains the final classification metrics.

### cross_validation_results.csv

Contains the cross-validation performance results.

### diagnosis_distribution.png

Shows the distribution of benign and malignant cases.

### radius_by_diagnosis.png

Shows the distribution of mean tumor radius for the two diagnosis groups.

### roc_curve.png

Shows the ROC curve of the logistic regression model.

### model_diagnostics.png

Contains the four main model diagnostic plots.

### top_influential_observations.csv

Contains the observations with the largest Cook's distance values.

## Interpretation

The model demonstrates strong predictive performance. The test accuracy was 95.58%, while the ROC-AUC was 0.9906, indicating excellent discrimination between the two diagnosis classes.

The 5-fold cross-validation accuracy of 93.42% provides additional evidence that the model performs consistently across different validation folds.
