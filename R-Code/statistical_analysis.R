# ============================================================
# WEEK 3 TASK
# STATISTICAL ANALYSIS AND PREDICTIVE MODELING USING R
# Dataset: Breast Cancer Wisconsin (Diagnostic)
# ============================================================


# ============================================================
# STEP 1: CLEAR R ENVIRONMENT
# ============================================================

rm(list = ls())

# Clear console
cat("\014")


# ============================================================
# STEP 2: LOAD DATASET
# ============================================================

data <- read.csv(
  "C:/Users/arkat/OneDrive/Desktop/M.tech/b.techprojects/Internship projects/Virtual R Data Analyst Intern/Week3_Statistical_Analysis_R/wdbc.data",
  header = FALSE,
  stringsAsFactors = FALSE
)


# ============================================================
# STEP 3: INITIAL DATA INSPECTION
# ============================================================

# First 6 rows
head(data)

# Number of rows and columns
dim(data)

# Dataset structure
str(data)

# ============================================================
# STEP 4: ADD COLUMN NAMES
# ============================================================

colnames(data) <- c(
  "id",
  "diagnosis",
  "radius_mean",
  "texture_mean",
  "perimeter_mean",
  "area_mean",
  "smoothness_mean",
  "compactness_mean",
  "concavity_mean",
  "concave_points_mean",
  "symmetry_mean",
  "fractal_dimension_mean",
  "radius_se",
  "texture_se",
  "perimeter_se",
  "area_se",
  "smoothness_se",
  "compactness_se",
  "concavity_se",
  "concave_points_se",
  "symmetry_se",
  "fractal_dimension_se",
  "radius_worst",
  "texture_worst",
  "perimeter_worst",
  "area_worst",
  "smoothness_worst",
  "compactness_worst",
  "concavity_worst",
  "concave_points_worst",
  "symmetry_worst",
  "fractal_dimension_worst"
)


# Check column names
colnames(data)


# Check original diagnosis values
table(data$diagnosis)

# ============================================================
# STEP 5: DATA QUALITY CHECK
# ============================================================

# Check missing values
total_missing <- sum(is.na(data))

total_missing


# Check missing values by column
missing_by_column <- colSums(is.na(data))

missing_by_column


# Check duplicate rows
duplicate_count <- sum(duplicated(data))

duplicate_count

# ============================================================
# STEP 6: CONVERT DIAGNOSIS TO FACTOR
# ============================================================

data$diagnosis <- factor(
  data$diagnosis,
  levels = c("B", "M"),
  labels = c("Benign", "Malignant")
)


# Check diagnosis
table(data$diagnosis)


# Check structure
str(data$diagnosis)


# Check for NA created during conversion
sum(is.na(data$diagnosis))

# ============================================================
# STEP 7: REMOVE ID COLUMN
# ============================================================

data$id <- NULL


# Check dimensions
dim(data)


# Check column names
colnames(data)

# ============================================================
# STEP 8: DESCRIPTIVE STATISTICS
# ============================================================

# Overall summary
summary(data)

# Selected important variables
selected_variables <- data[, c(
  "radius_mean",
  "texture_mean",
  "perimeter_mean",
  "area_mean",
  "smoothness_mean",
  "compactness_mean",
  "concavity_mean"
)]


# Mean
sapply(selected_variables, mean)


# Median
sapply(selected_variables, median)

# Standard deviation
sapply(selected_variables, sd)

# ============================================================
# STEP 9: TARGET VARIABLE DISTRIBUTION
# ============================================================

# Frequency
diagnosis_count <- table(data$diagnosis)

diagnosis_count


# Percentage
diagnosis_percentage <- prop.table(
  diagnosis_count
) * 100

diagnosis_percentage

# STEP 8 — Install and load visualization package

install.packages("ggplot2")
library(ggplot2)

# ============================================================
# STEP 10: DIAGNOSIS DISTRIBUTION PLOT
# ============================================================

ggplot(
  data,
  aes(x = diagnosis)
) +
  geom_bar() +
  labs(
    title = "Distribution of Breast Cancer Diagnosis",
    x = "Diagnosis",
    y = "Number of Cases"
  ) +
  theme_minimal()

# ============================================================
# STEP 11: RADIUS BY DIAGNOSIS
# ============================================================

# Mean radius by diagnosis
aggregate(
  radius_mean ~ diagnosis,
  data = data,
  FUN = mean
)


# Median radius by diagnosis
aggregate(
  radius_mean ~ diagnosis,
  data = data,
  FUN = median
)

ggplot(
  data,
  aes(
    x = diagnosis,
    y = radius_mean
  )
) +
  geom_boxplot() +
  labs(
    title = "Mean Tumor Radius by Diagnosis",
    x = "Diagnosis",
    y = "Mean Tumor Radius"
  ) +
  theme_minimal()

# STEP 11 — Normality testing
radius_mean

# ============================================================
# STEP 12: NORMALITY TESTING
# ============================================================

# Overall Shapiro-Wilk test
shapiro_overall <- shapiro.test(
  data$radius_mean
)

shapiro_overall

# Benign group
shapiro_benign <- shapiro.test(
  data$radius_mean[
    data$diagnosis == "Benign"
  ]
)

shapiro_benign

# Malignant group
shapiro_malignant <- shapiro.test(
  data$radius_mean[
    data$diagnosis == "Malignant"
  ]
)

shapiro_malignant

# ============================================================
# STEP 13: Q-Q PLOT
# ============================================================

qqnorm(
  data$radius_mean,
  main = "Q-Q Plot of Mean Tumor Radius"
)

qqline(
  data$radius_mean
)

# ============================================================
# STEP 14: INDEPENDENT TWO-SAMPLE T-TEST
# ============================================================

t_test_result <- t.test(
  radius_mean ~ diagnosis,
  data = data
)

t_test_result

# ============================================================
# STEP 15: WILCOXON RANK-SUM TEST
# ============================================================

wilcox_result <- wilcox.test(
  radius_mean ~ diagnosis,
  data = data,
  exact = FALSE
)

wilcox_result

# STEP 15 — Correlation analysis

#radius_mean ↔ area_mean

# ============================================================
# STEP 16: PEARSON CORRELATION TEST
# ============================================================

correlation_test <- cor.test(
  data$radius_mean,
  data$area_mean,
  method = "pearson"
)

correlation_test

# STEP 16 — Correlation visualization
# ============================================================
# STEP 17: CORRELATION PLOT
# ============================================================

ggplot(
  data,
  aes(
    x = radius_mean,
    y = area_mean,
    color = diagnosis
  )
) +
  geom_point(alpha = 0.6) +
  geom_smooth(
    method = "lm",
    se = FALSE
  ) +
  labs(
    title = "Relationship Between Mean Radius and Mean Area",
    x = "Mean Radius",
    y = "Mean Area",
    color = "Diagnosis"
  ) +
  theme_minimal()

# STEP 17 — Install & Load packages for predictive modeling
install.packages("caret")
install.packages("pROC")

library(caret)
library(pROC)

# ============================================================
# STEP 18: TRAIN / TEST SPLIT
# ============================================================
# 80% training + 20% testing

set.seed(123)

train_index <- createDataPartition(
  data$diagnosis,
  p = 0.80,
  list = FALSE
)

train_data <- data[train_index, ]

test_data <- data[-train_index, ]

# ============================================================
# STEP 19: LOGISTIC REGRESSION MODEL
# ============================================================

logistic_model <- glm(
  diagnosis ~
    radius_mean +
    texture_mean +
    smoothness_mean +
    compactness_mean +
    concavity_mean,
  data = train_data,
  family = binomial
)


# Model summary
summary(logistic_model)

# Check dimensions
dim(train_data)
dim(test_data)


# Check target distribution
table(train_data$diagnosis)
table(test_data$diagnosis)

# ============================================================
# STEP 20: TEST SET PREDICTIONS
# ============================================================

# Predicted probabilities
test_probabilities <- predict(
  logistic_model,
  newdata = test_data,
  type = "response"
)


# Convert probability into class
test_predictions <- ifelse(
  test_probabilities >= 0.5,
  "Malignant",
  "Benign"
)


# Convert to factor
test_predictions <- factor(
  test_predictions,
  levels = c("Benign", "Malignant")
)


# Display first predictions
head(test_predictions)

# ============================================================
# STEP 21: CONFUSION MATRIX
# ============================================================

confusion_matrix <- confusionMatrix(
  data = test_predictions,
  reference = test_data$diagnosis,
  positive = "Malignant"
)


# Display confusion matrix
confusion_matrix

# ============================================================
# STEP 22: MODEL PERFORMANCE METRICS
# ============================================================

accuracy <- confusion_matrix$overall[
  "Accuracy"
]

sensitivity <- confusion_matrix$byClass[
  "Sensitivity"
]

specificity <- confusion_matrix$byClass[
  "Specificity"
]

precision <- confusion_matrix$byClass[
  "Pos Pred Value"
]

f1_score <- confusion_matrix$byClass[
  "F1"
]


# Display individual metrics

accuracy
sensitivity
specificity
precision
f1_score

# ============================================================
# STEP 23: PERFORMANCE SUMMARY TABLE
# ============================================================

performance <- data.frame(
  Metric = c(
    "Accuracy",
    "Sensitivity / Recall",
    "Specificity",
    "Precision",
    "F1 Score"
  ),
  
  Value = c(
    accuracy,
    sensitivity,
    specificity,
    precision,
    f1_score
  )
)

performance

# ============================================================
# STEP 24: ROC CURVE AND AUC
# ============================================================

roc_model <- roc(
  response = test_data$diagnosis,
  predictor = test_probabilities,
  levels = c("Benign", "Malignant"),
  direction = "<"
)


# AUC
auc_value <- auc(roc_model)

auc_value

plot(
  roc_model,
  main = "ROC Curve - Logistic Regression"
)

# ============================================================
# STEP 25: 5-FOLD CROSS-VALIDATION
# ============================================================

set.seed(123)

cv_control <- trainControl(
  method = "cv",
  number = 5,
  classProbs = TRUE,
  savePredictions = "final"
)

cv_model <- train(
  diagnosis ~
    radius_mean +
    texture_mean +
    smoothness_mean +
    compactness_mean +
    concavity_mean,
  
  data = train_data,
  
  method = "glm",
  
  family = binomial,
  
  trControl = cv_control
)

cv_model
cv_model$results

# ============================================================
# STEP 26: CROSS-VALIDATION PREDICTIONS
# ============================================================

cv_predictions <- cv_model$pred

head(cv_predictions)

# ============================================================
# STEP 27: CROSS-VALIDATION CONFUSION MATRIX
# ============================================================

cv_confusion <- confusionMatrix(
  data = cv_predictions$pred,
  reference = cv_predictions$obs,
  positive = "Malignant"
)

cv_confusion

# ============================================================
# STEP 28: MODEL DIAGNOSTICS
# ============================================================

# Residual plots
par(mfrow = c(2, 2))

plot(logistic_model)

# ============================================================
# STEP 29: INFLUENTIAL OBSERVATIONS
# ============================================================

cooks_distance <- cooks.distance(
  logistic_model
)

# Largest Cook's distance values
head(
  sort(cooks_distance, decreasing = TRUE),
  10
)

# ============================================================
# STEP 30: SAVE RESULTS
# ============================================================

# Create Results folder if it does not already exist
if (!dir.exists("Results")) {
  dir.create("Results")
}

# Save model performance
write.csv(
  performance,
  "Results/model_performance.csv",
  row.names = FALSE
)

# Save cross-validation results
write.csv(
  cv_model$results,
  "Results/cross_validation_results.csv",
  row.names = FALSE
)

# Check that files were created
list.files("Results")

# ============================================================
# STEP 31: FINAL MODEL PERFORMANCE
# ============================================================

performance

# AUC
auc_value

# ============================================================
# STEP 32: CROSS-VALIDATION RESULTS
# ============================================================

cv_model

# ============================================================
# STEP 33: FINAL CONFUSION MATRIX
# ============================================================

confusion_matrix

# ============================================================
# STEP 34: LOGISTIC REGRESSION SUMMARY
# ============================================================

summary(logistic_model)

# ============================================================
# STEP 35: AUC
# ============================================================

auc_value

# ============================================================
# STEP 36: SAVE ROC CURVE
# ============================================================

png(
  "Results/roc_curve.png",
  width = 1000,
  height = 800
)

plot(
  roc_model,
  main = "ROC Curve - Logistic Regression"
)

dev.off()

# ============================================================
# STEP 37: SAVE MODEL DIAGNOSTICS
# ============================================================

png(
  "Results/model_diagnostics.png",
  width = 1200,
  height = 900
)

par(mfrow = c(2, 2))

plot(logistic_model)

dev.off()

par(mfrow = c(1, 1))

cooks_distance

# ============================================================
# STEP 38: SAVE INFLUENTIAL OBSERVATIONS
# ============================================================

top_cooks <- data.frame(
  Observation = order(
    cooks_distance,
    decreasing = TRUE
  )[1:10],
  
  Cooks_Distance = sort(
    cooks_distance,
    decreasing = TRUE
  )[1:10]
)

top_cooks

write.csv(
  top_cooks,
  "Results/top_influential_observations.csv",
  row.names = FALSE
)

# ============================================================
# STEP 39: CHECK SAVED RESULTS
# ============================================================

list.files("Results")

head(data)
str(data)
dim(data)
sum(is.na(data))
table(data$diagnosis)
summary(data)

shapiro_overall
t_test_result
wilcox_result
correlation_test
summary(logistic_model)
confusion_matrix
performance
cv_model
auc_value
par(mfrow = c(2,2))
plot(logistic_model)
par(mfrow = c(1,1))
png(
  "Results/diagnosis_distribution.png",
  width = 1000,
  height = 800
)

ggplot(
  data,
  aes(x = diagnosis)
) +
  geom_bar() +
  labs(
    title = "Distribution of Breast Cancer Diagnosis",
    x = "Diagnosis",
    y = "Number of Cases"
  ) +
  theme_minimal()

dev.off()

png(
  "Results/radius_by_diagnosis.png",
  width = 1000,
  height = 800
)

ggplot(
  data,
  aes(
    x = diagnosis,
    y = radius_mean
  )
) +
  geom_boxplot() +
  labs(
    title = "Mean Tumor Radius by Diagnosis",
    x = "Diagnosis",
    y = "Mean Tumor Radius"
  ) +
  theme_minimal()

dev.off()

list.files("Results")

performance
cv_model$results
confusion_matrix
auc_value
