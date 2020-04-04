AUC_test <- function(TP1, FP1, FN1, TN1, TP2, FP2, FN2, TN2, B=2000, alpha=0.05){

	dt1 <- data.frame(TP1,FP1,FN1,TN1)
	colnames(dt1) <- c("TP","FP","FN","TN")
	fit1 <- reitsma(dt1)
	auc1 <- summary(fit1)$AUC$AUC

	dt2 <- data.frame(TP2,FP2,FN2,TN2)
	colnames(dt2) <- c("TP","FP","FN","TN")
	fit2 <- reitsma(dt2)
	auc2 <- summary(fit2)$AUC$AUC

	boot1 <- AUC_boot(TP1,FP1,FN1,TN1,B=B)
	boot2 <- AUC_boot(TP2,FP2,FN2,TN2,B=B)

	dAUC <- auc1 - auc2

	dboot <- boot1 - boot2

	Q1 <- quantile(boot1,c(.5*alpha,1-.5*alpha))
	Q2 <- quantile(boot2,c(.5*alpha,1-.5*alpha))
	Q3 <- quantile(dboot,c(.5*alpha,1-.5*alpha))

	P <- 2*min(mean(dboot>0), 1-mean(dboot>0))		# two-sided p-value

	R1 <- list(AUC1=auc1,AUC1_CI=Q1,AUC2=auc2,AUC2_CI=Q2,dAUC=dAUC,dAUC_CI=Q3,pvalue=P)
	
	return(R1)

}

