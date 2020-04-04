AUC_IF <- function(TP, FP, FN, TN, B=2000, alpha=0.95, Cores=detectCores()){

	N <- length(TP)   # number of studies
	p <- 2  # dimension of the multivariate meta-analysis

	n1 <- TP+FN
	n2 <- TN+FP

	expit <- function(x) exp(x)/(1+exp(x))		# expit function

	dt1 <- data.frame(TP,FP,FN,TN)
	fit0 <- reitsma(dt1)
	auc <- summary(fit0)$AUC$AUC

	cl <- makeSOCKcluster(Cores)
	registerDoSNOW(cl)
	
	print("This computation will take a lot of time. Please don't stop the computation at least a few hours to obtain the outputs.")

	R1 <- foreach(out = 1:N, .combine = rbind, .packages=c("MASS","mada")) %dopar% {

		dti.1 <- dt1[-out,]
		auci <- summary(reitsma(dti.1))$AUC$AUC

		delta <- auci - auc		# deltaAUC

		mu1 <- as.numeric(fit0$coefficients)
		G1 <- fit0$Psi
 
		dt.pb <- dt1
		auc.pb <- auci.pb <- numeric(B)

			for(b in 1:B){
 
				t.pb <- expit(mvrnorm(N, mu1, G1))

				dt.pb[,1] <- rbinom(N,prob=t.pb[,1],size=n1)
				dt.pb[,2] <- rbinom(N,prob=t.pb[,2],size=n2)
				dt.pb[,3] <- n1 - dt.pb[,1]
				dt.pb[,4] <- n2 - dt.pb[,2]

				fit.pb <- reitsma(dt.pb)
				auc.pb[b] <- summary(fit.pb)$AUC$AUC
	
				dti.pb <- dt.pb[-out,]
				fiti.pb <- reitsma(dti.pb)
				auci.pb[b] <- summary(fiti.pb)$AUC$AUC
	
			}

		delta.pb <- auci.pb - auc.pb

		Q1 <- quantile(delta.pb,c(.5*(1-alpha),1-.5*(1-alpha)))		# deltaAUCが、この範囲を超えたら、外れ値と見なす

		c(out,auci,delta,Q1)

	}

	stopCluster(cl)
	
	R1 <- R1[rev(order(abs(R1[,3]))),]
	colnames(R1) <- c("id","AUC(-i)","dAUC","Q1","Q2")
	
	R2 <- list(AUC=auc,IF=R1)
	
	return(R2)

}

