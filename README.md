
# dmetatools package


## Computational tools for meta-analysis of diagnostic accuracy test

A R package for computational tools for meta-analysis of diagnostic accuracy test (DTA):

- Implementing parametic bootstrap for DTA meta-analysis
- Calculating a confidence interval for the AUC of summary ROC curve
- Testing the difference of AUCs for summary ROC curves of multiple diagnostic tests
- Influence diagnostics based on the AUC of summary ROC curve by leave-one-out analysis


## Installation

Please download "dmetatools_1.1.2.tar.gz" and install it by R menu: "packages" -> "Install package(s) from local files...".

Download: [please click this link](https://github.com/nomahi/dmetatools/raw/master/dmetatools_1.1.2.tar.gz)

Manual: [please click this link](https://github.com/nomahi/dmetatools/blob/master/dmetatools_1.1.2.pdf)



## CRAN

The dmetatools package is also available on CRAN (https://doi.org/10.32614/CRAN.package.dmetatools); please try installing it in R using install.packages("dmetatools").




## Example code
```r

pkgCheck <- function(pkg){
	if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
	library(pkg, character.only = TRUE)
}

pkgCheck("dmetatools")			# load and/or install "dmetatools" package


# Computation of the 95% CI for the AUC of SROC curve

data(cervical)

CT <- cervical[cervical$method==1,]
LAG <- cervical[cervical$method==2,]
MRI <- cervical[cervical$method==3,]

AUC_boot(CT$TP,CT$FP,CT$FN,CT$TN)
AUC_boot(LAG$TP,LAG$FP,LAG$FN,LAG$TN)
AUC_boot(MRI$TP,MRI$FP,MRI$FN,MRI$TN)


# Comparing the differences of AUCs
AUC_comparison(CT$TP,CT$FP,CT$FN,CT$TN,LAG$TP,LAG$FP,LAG$FN,LAG$TN)
AUC_comparison(MRI$TP,MRI$FP,MRI$FN,MRI$TN,LAG$TP,LAG$FP,LAG$FN,LAG$TN)
AUC_comparison(MRI$TP,MRI$FP,MRI$FN,MRI$TN,CT$TP,CT$FP,CT$FN,CT$TN)


# Influence diagnostics by the delta-AUC
data(asthma)
AUC_IF(asthma$TP, asthma$FP, asthma$FN, asthma$TN) 
