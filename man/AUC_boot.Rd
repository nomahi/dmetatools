\name{AUC_boot}
\alias{AUC_boot}
\title{Confidence interval for AUC of summary ROC curve}
\usage{
AUC_boot(TP, FP, FN, TN, B=2000, alpha=0.95)
}
\arguments{
\item{TP}{A vector of the number of true positives (TP)}

\item{FP}{A vector of the number of false positives (FP)}

\item{FN}{A vector of the number of false negatives (FN)}

\item{TN}{A vector of the number of true negatives (TN)}

\item{B}{The number of bootstrap resampling (defalt: 2000)}

\item{alpha}{The confidence level (default: 0.05)}
}
\value{
The confidence interval for AUC of summary ROC curve is calculated. 
\itemize{
\item \code{AUC}: The AUC of the summary ROC curve.
\item \code{AUC_CI}: The \code{alpha}\% confidence interval for the AUC of the summary ROC curve.
}
}
\description{
Calculating the confidence interval for AUC of summary ROC curve by parametric bootstrap.
}
\examples{
data(cervical)

CT <- cervical[cervical$method==1,]
LAG <- cervical[cervical$method==2,]
MRI <- cervical[cervical$method==3,]

AUC_boot(CT$TP,CT$FP,CT$FN,CT$TN)
AUC_boot(LAG$TP,LAG$FP,LAG$FN,LAG$TN)
AUC_boot(MRI$TP,MRI$FP,MRI$FN,MRI$TN)
}
