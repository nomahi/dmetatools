AUC_boot2 <- function(TP, FP, FN, TN, B=2000){

	N <- length(TP)   # number of studies
	p <- 2  # dimension of the multivariate meta-analysis

	n1 <- TP+FN
	n2 <- TN+FP

	expit <- function(x) exp(x)/(1+exp(x))		# expit function

	dt1 <- data.frame(TP,FP,FN,TN)
	fit0 <- reitsma(dt1)
	auc <- summary(fit0)$AUC$AUC

	mu1 <- as.numeric(fit0$coefficients)
	G1 <- fit0$Psi

	dt.pb <- dt1
	auc.pb <- numeric(B)

	for(b in 1:B){
 
		t.pb <- expit(mvrnorm(N, mu1, G1))

		dt.pb[,1] <- rbinom(N,prob=t.pb[,1],size=n1)
		dt.pb[,2] <- rbinom(N,prob=t.pb[,2],size=n2)
		dt.pb[,3] <- n1 - dt.pb[,1]
		dt.pb[,4] <- n2 - dt.pb[,2]

		fit.pb <- reitsma(dt.pb)
		auc.pb[b] <- summary(fit.pb)$AUC$AUC
	
		print1 <- paste0("The ",b,"th bootstrap for test 1 is completed.")
		print(print1)
	}

	return(auc.pb)

}

