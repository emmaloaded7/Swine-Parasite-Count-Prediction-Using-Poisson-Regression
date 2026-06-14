# =====================================================
# IMPORT DATASET
# =====================================================

dataset <- read.csv(file.choose())

# Display dataset dimensions
dim(dataset)

# Display variable names
names(dataset)

# Display first six rows
head(dataset)

# Summary statistics
summary(dataset)

# =====================================================
# DATA PREPARATION
# =====================================================

dataset$Disease_Status <- as.factor(dataset$Disease_Status)

dataset$Death <- as.factor(dataset$Death)

# Check summary again after conversion
summary(dataset)

# =====================================================
# EXPLORE PARASITE COUNT
# =====================================================

table(dataset$Parasite_Count)

hist(
  dataset$Parasite_Count,
  main = "Parasite Count Frequency",
  xlab = "Parasite Count",
  ylab = "Herd Population"
)

# =====================================================
# AGE VS WEIGHT VISUALIZATION
# =====================================================

plot(
  dataset$Age_Days,
  dataset$Current_Weight,
  main = "Age vs Weight",
  xlab = "Age in Days",
  ylab = "Current Weight"
)

model <- lm(
  Current_Weight ~ Age_Days,
  data = dataset
)

abline(
  model,
  col = "blue",
  lwd = 3
)

# Correlation between age and weight
cor(
  dataset$Age_Days,
  dataset$Current_Weight
)

# =====================================================
# POISSON REGRESSION MODEL 1
# =====================================================

model1 <- glm(
  Parasite_Count ~ Disease_Status,
  data = dataset,
  family = poisson
)

summary(model1)

# Incidence Rate Ratios
exp(coef(model1))

# Confidence Intervals
exp(confint(model1))

# =====================================================
# POISSON REGRESSION MODEL 2
# =====================================================

model2 <- glm(
  Parasite_Count ~ Disease_Status +
    Temperature_C,
  data = dataset,
  family = poisson
)

summary(model2)

exp(coef(model2))

exp(confint(model2))

# =====================================================
# POISSON REGRESSION MODEL 3
# =====================================================

model3 <- glm(
  Parasite_Count ~ Disease_Status +
    Temperature_C +
    Feed_Intake,
  data = dataset,
  family = poisson
)

summary(model3)

exp(coef(model3))

exp(confint(model3))

# =====================================================
# POISSON REGRESSION MODEL 4
# =====================================================

model4 <- glm(
  Parasite_Count ~ Disease_Status +
    Temperature_C +
    Feed_Intake +
    Current_Weight,
  data = dataset,
  family = poisson
)

summary(model4)

exp(coef(model4))

exp(confint(model4))

# =====================================================
# POISSON REGRESSION MODEL 5
# =====================================================

model5 <- glm(
  Parasite_Count ~ Disease_Status +
    Temperature_C +
    Feed_Intake +
    Current_Weight +
    Humidity_Percent +
    Age_Days,
  data = dataset,
  family = poisson
)

summary(model5)

exp(coef(model5))

exp(confint(model5))

# =====================================================
# MODEL DIAGNOSTICS
# =====================================================

plot(model5)

# Compare AIC values
AIC(
  model1,
  model2,
  model3,
  model4,
  model5
)

# =====================================================
# PREDICTED COUNTS
# =====================================================

predicted_counts <- predict(
  model5,
  type = "response"
)

dataset$Predicted_Counts <- predicted_counts

# =====================================================
# OVERDISPERSION CHECK
# =====================================================

deviance(model5)

df.residual(model5)

deviance(model5) /
  df.residual(model5)

# Interpretation:
# Ratio ≈ 1 = Good Poisson fit
# Ratio > 1.5 = Overdispersion may exist
# Ratio > 2 = Strong overdispersion

# =====================================================
# TRAIN / TEST SPLIT
# =====================================================

set.seed(123)

train_index <- sample(
  1:nrow(dataset),
  0.8 * nrow(dataset)
)

train <- dataset[train_index, ]

test <- dataset[-train_index, ]

# =====================================================
# PREDICTIVE POISSON MODEL
# =====================================================

model6 <- glm(
  Parasite_Count ~ Disease_Status +
    Temperature_C +
    Feed_Intake +
    Current_Weight +
    Humidity_Percent +
    Age_Days,
  data = train,
  family = poisson
)

summary(model6)

# =====================================================
# TEST SET PREDICTIONS
# =====================================================

test_pred <- predict(
  model6,
  newdata = test,
  type = "response"
)

# RMSE
sqrt(
  mean(
    (test$Parasite_Count -
       test_pred)^2
  )
)

# =====================================================
# PREDICT PARASITE COUNT FOR A NEW PIG
# =====================================================

newswine <- data.frame(
  Disease_Status = factor(
    "0",
    levels = levels(dataset$Disease_Status)
  ),
  Temperature_C = 23.3,
  Feed_Intake = 4.46,
  Current_Weight = 128.4,
  Humidity_Percent = 80.6,
  Age_Days = 300
)

predict(
  model6,
  newdata = newswine,
  type = "response"
)

# =====================================================
# OPTIONAL: NEGATIVE BINOMIAL MODEL
# (IF OVERDISPERSION IS HIGH)
# =====================================================

library(MASS)

model_nb <- glm.nb(
  Parasite_Count ~ Disease_Status +
    Temperature_C +
    Feed_Intake +
    Current_Weight +
    Humidity_Percent +
    Age_Days,
  data = dataset
)

summary(model_nb)

AIC(model5, model_nb)
