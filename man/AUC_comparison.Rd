\name{AUC_comparison}
\alias{AUC_comparison}
\title{Bootstrap test for AUCs of summary ROC curves for multiple diagnostic tests}
\usage{
AUC_comparison(TP1, FP1, FN1, TN1, TP2, FP2, FN2, TN2, B=2000, alpha=0.05)
}
\arguments{
\item{TP1}{A vector of the number of true positives (TP) of test 1}

\item{FP1}{A vector of the number of false positives (FP) of test 1}

\item{FN1}{A vector of the number of false negatives (FN) of test 1}

\item{TN1}{A vector of the number of true negatives (TN) of test 1}

\item{TP2}{A vector of the number of true positives (TP) of test 2}

\item{FP2}{A vector of the number of false positives (FP) of test 2}

\item{FN2}{A vector of the number of false negatives (FN) of test 2}

\item{TN2}{A vector of the number of true negatives (TN) of test 2}

\item{B}{The number of bootstrap resampling (defalt: 2000)}

\item{alpha}{The significance level (default: 0.05)}
}
\value{
The AUCs of the summary ROC curves and their confidence intervals are calculated. 
Also, the difference of the AUCs (\code{dAUC}) and its confidence interval, and the p-value for the test of "\code{dAUC=0}" are provided.
\itemize{
\item \code{AUC1}: The AUC of the summary ROC curve for test 1.
\item \code{AUC1_CI}: The \code{1-alpha}\% confidence interval for the AUC of the summary ROC curve for test 1.
\item \code{AUC2}: The AUC of the summary ROC curve for test 2.
\item \code{AUC2_CI}: The \code{1-alpha}\% confidence interval for the AUC of the summary ROC curve for test 2.
\item \code{dAUC}: The difference of the AUC1 and AUC2.
\item \code{dAUC_CI}: The \code{1-alpha}\% confidence interval for \code{dAUC}.
\item \code{pvalue}: The p-value of the test of \code{dAUC=0}.
}
}
\description{
Calculating the difference of AUCs of summary ROC curves (\code{dAUC}) and its confidence interval, and the p-value for the test of "\code{dAUC=0}" by parametric bootstrap.
}
\examples{
data(cervical)

CT <- cervical[cervical$method==1,]
LAG <- cervical[cervical$method==2,]
MRI <- cervical[cervical$method==3,]

AUC_comparison(CT$TP,CT$FP,CT$FN,CT$TN,LAG$TP,LAG$FP,LAG$FN,LAG$TN)
AUC_comparison(MRI$TP,MRI$FP,MRI$FN,MRI$TN,LAG$TP,LAG$FP,LAG$FN,LAG$TN)
AUC_comparison(MRI$TP,MRI$FP,MRI$FN,MRI$TN,CT$TP,CT$FP,CT$FN,CT$TN)
}
