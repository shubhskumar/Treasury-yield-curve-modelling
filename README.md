# US Treasury Yield Curve Modeling and Default Risk Assessment

This project focuses on utilizing **advanced statistical models** such as **B-splines**, **Principal Component Analysis (PCA)**, and the **Vasicek model** to analyze **US Treasury yield rates** and assess **default risk** in the banking sector.

## Table of Contents
- [Project Overview](#project-overview)
- [Techniques Used](#techniques-used)
- [Models Applied](#models-applied)
- [Results](#results)
- [Business Use Case](#business-use-case)
- [Conclusion](#conclusion)

## Project Overview
Our objective is to leverage **financial modeling** and **statistical techniques** to gain insights into the behavior of the **US Treasury bond yield curve** and to model **default probabilities** in the banking sector. The project integrates multiple techniques:
- **B-splines** to interpolate missing bond yield data.
- **PCA** to identify the most influential risk factors behind yield curve trends.
- **Vasicek model** to assess the **probability of default** using factors derived from PCA.

## Techniques Used
### 1. **B-Splines for Curve Fitting**
- **B-splines** are piecewise-defined functions, ideal for creating smooth curves that closely follow the shape of data.
- Applied to model the **yield curve** for different US Treasury bonds with varying maturities.
- Used to estimate unknown bond yields by fitting a smooth curve to the available data points.

### 2. **Principal Component Analysis (PCA)**
- PCA was used to reduce the dimensionality of the yield curve data and identify key risk factors:
  - **First Component** (Level Factor): Captures the overall movement of the yield curve.
  - **Second Component** (Slope Factor): Reflects the steepness of the yield curve.
  - **Third Component** (Curvature Factor): Indicates more complex shifts in the curve's shape.

### 3. **Vasicek Model for Default Probability**
- The **Vasicek model** was employed to estimate the **probability of default** (PD) in the banking sector.
- Used the factors derived from PCA to model how interest rate fluctuations impact credit risk and default probabilities.

## Models Applied
- **B-Splines**: Used to fit smooth curves to the yield-to-maturity (YTM) data for US Treasury bonds.
- **PCA**: Applied to daily bond yield data to uncover the principal risk factors influencing yield trends.
- **Vasicek Model**: Utilized to model default probabilities in relation to the risk factors (primarily the **duration factor**) derived from PCA.

## Results
- **Yield Curve Fitting**: Successfully modeled the US Treasury yield curve using B-splines. The curve helped interpolate missing yield values and offered a smooth trend for understanding bond pricing.
- **Risk Factor Identification**: PCA revealed that the **level factor** (capturing the overall shift in yields) and the **slope factor** (representing the steepness) were the most influential components affecting yield rates.
- **Default Probability Estimation**: Using the Vasicek model, we modeled the long-term default probability based on the duration factor, demonstrating a relationship between interest rates and banking sector risk.

## Business Use Case
### Yield Curve Construction for Bond Pricing:
- The yield curve is essential for predicting **bond prices** and assessing the **fair yield** for bonds with varying maturities.
- Investors use the yield curve to price bonds and determine reasonable demand for bond purchases, considering factors such as **credit risk** and **default probabilities**.
  
### Default Risk in the Banking Sector:
- The project also models **credit risk** in the banking sector by analyzing the **duration factor** and simulating default probabilities using historical bond data and PCA-derived risk factors.

## Conclusion
This project demonstrates the power of combining **splines**, **PCA**, and the **Vasicek model** to gain a deeper understanding of **US Treasury yields** and **default risk**. By fitting yield curves and identifying the primary components driving yield changes, we provide useful insights for **investors** and **financial analysts** to assess **bond pricing** and **banking sector risk** more effectively.
