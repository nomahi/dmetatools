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

fit1 <- reitsma(CT)		# DTA meta-analysis using the Reitsma model
summary(fit1)
fit2 <- reitsma(LAG)
summary(fit2)
fit3 <- reitsma(MRI)
summary(fit3)

plot(fit1)		# Plot the SROC curves
lines(sroc(fit2), lty=2, col="blue")
ROCellipse(fit2, lty=2, pch=2, add=TRUE, col="blue")
lines(sroc(fit3), lty=3, col="red")
ROCellipse(fit3, lty=3, pch=3, add=TRUE, col="red")
points(fpr(CT), sens(CT), cex = .5)
points(fpr(LAG), sens(LAG), pch = 2, cex = 0.5, col="blue")
points(fpr(MRI), sens(MRI), pch = 3, cex = 0.5, col="red")
legend("bottomright", c("CT", "LAG", "MRI"), pch = 1:3, lty = 1:3, col=c("black","blue","red"))

AUC_boot(CT$TP,CT$FP,CT$FN,CT$TN)
AUC_boot(LAG$TP,LAG$FP,LAG$FN,LAG$TN)
AUC_boot(MRI$TP,MRI$FP,MRI$FN,MRI$TN)
}
