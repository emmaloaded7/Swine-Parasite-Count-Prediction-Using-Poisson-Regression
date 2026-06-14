# Swine Parasite Count Prediction Using Poisson Regression

## Project Overview

This project investigates factors associated with parasite burden in
swine using Poisson regression modelling. The study evaluates the
relationship between parasite counts and several environmental and
physiological variables, including disease status, temperature, feed
intake, body weight, and humidity.

## Objectives

1.  To identify factors associated with parasite count in swine.
2.  To develop a Poisson regression model suitable for count data.
3.  To evaluate model fit using diagnostic techniques.
4.  To compare competing models using Akaike Information Criterion
    (AIC).
5.  To assess predictive performance using a train-test validation
    framework.
6.  To predict parasite counts for new animals based on observed
    characteristics.

## Dataset Description

Variables: - Parasite_Count - Disease_Status - Temperature_C -
Feed_Intake - Current_Weight - Humidity_Percent - Age_Days - Death

## Methodology

1.  Data Preparation
2.  Exploratory Data Analysis
3.  Poisson Regression Modelling
4.  Model Interpretation
5.  Model Selection using AIC
6.  Overdispersion Assessment
7.  Predictive Modelling
8.  Model Evaluation using RMSE
9.  Prediction Visualization
10. Prediction for New Animals
11. Negative Binomial Comparison

## Key Findings

-   Disease status was consistently associated with increased parasite
    counts.
-   Humidity showed a statistically significant positive association
    with parasite burden.
-   Temperature, feed intake, and weight showed weaker associations.
-   The Poisson model demonstrated acceptable fit with minimal evidence
    of overdispersion.
-   The predictive model achieved reasonable accuracy with an RMSE of
    approximately 1.19.

## Software

-   R
-   Base R Statistics Package
-   MASS Package

## Author

Ometoro Emmanuel 
Statistical Modelling Project

Poisson Regression Analysis for Swine Parasite Count Prediction
