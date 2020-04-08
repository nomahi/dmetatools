\name{AUC_IF}
\alias{AUC_IF}
\title{Influence diagnostics based on the AUC of summary ROC curve}
\usage{
AUC_IF(TP, FP, FN, TN, B=2000, alpha=0.95, Cores=detectCores())
}
\arguments{
\item{TP}{A vector of the number of true positives (TP)}

\item{FP}{A vector of the number of false positives (FP)}

\item{FN}{A vector of the number of false negatives (FN)}

\item{TN}{A vector of the number of true negatives (TN)}

\item{B}{The number of bootstrap resampling (defalt: 2000)}

\item{alpha}{The error level to be calculated for the bootstrap interval of \code{deltaAUC} (default: 0.95)}

\item{Cores}{The number of cores to be used for parallel computations (if the user don't want to implement parallel computations, please set to 1).}
}
\value{
Influence diagnostic statistics based on the AUC of the summary ROC curve. The output is sorted by the absolute size of \code{deltaAUC}.
\itemize{
\item \code{AUC}: The AUC of the summary ROC curve.
\item \code{id}: identification number.
\item \code{AUC(-i)}: The AUC estimate if \code{i}th study is excluded.
\item \code{deltaAUC}: The difference of AUC estimates for all study and for the subpopulation that \code{i}th study is excluded.
\item \code{Q1}: Default 2.5th percentile of the bootstrap distribution of \code{deltaAUC} (can be changed by \code{alpha}).
\item \code{Q2}: Default 97.5th percentile of the bootstrap distribution of \code{deltaAUC} (can be changed by \code{alpha}).
}
}
\author{Hisashi Noma <noma@ism.ac.jp>}
\references{
Noma, H. and Matsushima, Y. (2020). 
Confidence interval for the AUC of SROC curve and some related methods using bootstrap for meta-analysis of diagnostic accuracy studies. 
Under Preparation.
}
\description{
Influence diagnostics based on AUC of the summary ROC curve by leave-one-out analysis. 
The threthold to determine influential outlying study is computed by parametric bootstrap.
}
\examples{
data(asthma)

fit1 <- reitsma(asthma)		# DTA analysis using the Reitsma model
summary(fit1)

plot(fit1)		# Plot the SROC curves
points(fpr(asthma), sens(asthma), cex = .5)

attach(asthma)
AUC_IF(TP, FP, FN, TN)		# Influential analysis based on the AUC
detach(asthma)
}
