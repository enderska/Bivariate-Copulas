
#'Normalise the time series
#'Normalise the time series using min-max normalisation
#'@param col The vector to be normalised
#'@return Normalised vector
normalise<-function(col) {
  return((col-min(col,na.rm=TRUE))/(max(col,na.rm=TRUE)-min(col,na.rm=TRUE)))
}
#'Obtain month over month transformation
#'@param column The vector/time series
#'@return The month over month transformation of the column
getMoM<-function(column){
  MoM=numeric()
  MoM=c(MoM,NA)
  for(i in 2:length(column)){
    if(!is.na(column[i-1]))
      if(column[i-1]!=0){
        MoM<-c(MoM,column[i]/column[i-1])
      }
    else{MoM<-c(MoM,NA)}
    else{MoM<-c(MoM,NA)}
  }
  return( MoM)
}

#'Obtain year over year transformation
#'@param column The vector/time series
#'@return The year over year transformation of the column
getYoY<-function(column){
  YoY=numeric()
  YoY=c(YoY,rep(NA,12))
  for(i in 13:length(column)){
    if(!is.na(column[i-12]))
      if(column[i-12]!=0){
        YoY<-c(YoY,column[i]/column[i-12])
      }
    else{YoY<-c(YoY,NA)}
    else{YoY<-c(YoY,NA)}
  }
  return(YoY)
}
#'Obtain lead time adjusted \code{KPI} and \code{indicator}
#'
#'@param KPI The time series which we wish to predict
#'@param indicator The exogeneous time series which we use to predict the \code{KPI}
#'@param lag The lead time between the KPI and the indicator
#'@return A dataframe containing the KPI and the lead time adjusted indicator

getp1p2<-function(KPI,indicator,lag=0){
  k=lag
  p2<-KPI[((1+k):(length(KPI)))]
  p1<-indicator[(1:(length(indicator)-k))]
  return(data.frame('indicator'=p1,'KPI'=p2))
}

#'Find useful indicators for a KPI
#'Obtain the list of combinations of KPI and indicator which have Kenadll's tau above a certain threshold. This is used to obtain KPI and indicator time series pairs
#'@param KPI The time series which we want to find lead time indicators for
#'@param indicators The set of indicators which we need to look at
#'@param lags The set of lead times we look at.
#'@param threshold The threshold for kendall's tau above which we consider an indicator useful in modelling the KPI
#'@return A list conating all the set of indicators and lead times which have kendall's tau above the said threshold
getUseful_combs<-function(KPI,indicators,threshold=.23,lags=0:18){
  x <- array(rep(0, ncol(KPI)*ncol(indicators)*length(lags)), dim=c(ncol(indicators),ncol(KPI),length(lags)))
  count=1
  useful_comb<-list()
  for(i in colnames(indicators)){
    ts1=indicators[,i]
    for(j in colnames(KPI)){
      ts2=KPI[,j]
      for(k in lags){
        ts1_temp=ts1[(1:(length(ts1)-k))]
        ts2_temp=ts2[((1+k):(length(ts2)))]
        x[which(colnames(indicators)==i),which(colnames(KPI)==j),(k+1)]=abs(
          cor(ts1_temp,ts2_temp,method='kendall',use='pairwise.complete.obs'))
        
        cde=abs(cor(ts1_temp,ts2_temp,method='kendall',use='pairwise.complete.obs'))
        if(is.na(cde)){
          cde=0
        }
        if(cde>threshold){
          temp_list=list()
          temp_list[['ts1_name']]=i
          temp_list[['ts2_name']]=j
          temp_list[['lag']]=k
          temp_list[['kendall']]=cde
          temp_list[['pearson']]=abs(cor(ts1_temp,ts2_temp,use='pairwise.complete.obs'))
          useful_comb[[count]]=temp_list
          count=count+1
          
        }
        
        
      }
    }
  }
  return(useful_comb)
}


#'Calculate negative log likelihood
#'Obtain the negative log likelihood for the vector\code{x} for a skew-t distribution
#'@param x The vector for which we wish to find the negative log likelihood
#'@param params The paramters of the skew-t distribution
#'@return The negative log likelihood of the vector \code{x} with respect to the skew-t distribution specified by \code{params}
l_skewT = function(x,params){
  -sum(log(dskt(x, df = params[1],gamma=params[2])))
}
#'Calculate MAPE
#'Get the mean absolute percentage error for the prediction and the target. This is one of the metrics to benchmark our results.
#'
#'@param pred The prediction from the model
#'@param target The actuals for the said period
#'@return The MAPE between the prediction and the target
getMAPE<-function(pred,target){
  err=0
  count=0
  for (i in c(1:length(pred))){
    if((target[i]!=0)&(!is.na(target[i]))){
      err=err+abs((pred[i]-target[i])/(target[i]))
      count=count+1
    }
  }
  
  
  err=err/count
  return (err)
  
}
#'Compute RMSE
#'Get the root mean square error for the prediction and the target. One of the metrics to benchamrk our results.
#'@param pred The prediction from the model
#'@param target The actuals for the said period
#'@return The RMSE between the prediction and the target
getRMSE<-function(pred,target){
  err=0
  count=0
  for (i in c(1:length(pred))){
    if((!is.na(target[i]))){
      err=err+abs((pred[i]-target[i])^2)
      count=count+1
    }
  }
  
  
  err=err/count
  err=err^.5
  return (err)
  
}

#'Compute \code{L2} norm
#'Get the \code{L2} norm for each row of the matrix
#'@param diff_mat The matrix for which we want to calculate the norm for each row
#'@return A vector containing the \code{L2} norm for each row
getNorms<-function(diff_mat){
  nm<-numeric()
  for(i in 1:nrow(diff_mat)){
    nm<-c(nm,norm(as.matrix(diff_mat[i,])))
  }
  return(nm)
}

#'Calculate optimal lead time
#'Plot the variation of kendall's tau with varying lead times. Useful to identify optimal lead time between KPI and indicator
#'@param KPI A vector which we wish to find the optimal lead time
#'@param indicator The exogeneous time series vector
#'@param max.lag The maximum lead time which we look at while finding the optimal lead time
#'@param plot A boolean option which we use to indicate whether plot should be generated or not
#'@return The lead time for which we find the kendall's tau value to be maximum

plotccf_kendall<-function(KPI,indicator,max.lag=18,plot=FALSE){
  corr_vals<-numeric()
  for(i in 0:max.lag){
    df<-getp1p2(KPI=KPI,indicator = indicator,lag=i)
    corr_vals<-c(corr_vals,cor(df,method = 'kendall',use='complete.obs')[1,2])
  }
  if(plot==TRUE){
    plot(corr_vals,type='b')
  }
  return(which.max(corr_vals))
}

#'Extract trend
#'Extract the trend from the \code{data} vector
#'@param data The vector/time series from which the trend is to be extracted
#'@return The trend after extraction from data
getTrend<-function(data,s.window=7,t.window=12){
  return(as.vector(stl(ts(data,frequency=12),s.window=s.window,t.window=t.window)$time.series[,2]))
}
#'Extract Seasonality
#'Extract the seasonality from the \code{data} vector
#'@param data The vector/time series from which the seasonality is to be extracted
#'@return The seasonality after extraction from data
getSeasonality<-function(data,s.window=7,t.window=12){
  return(as.vector(stl(ts(data,frequency=12),s.window=s.window,t.window=t.window)$time.series[,1]))
}
#'Remove trend and seasonality
#'Remove the trend and seasonality from the \code{data} vector
#'@param data The vector/time series from which the trend and seasonality is to be removed
#'@return The data after removing trend and seasonality
remTrendSeasonality<-function(data,s.window=7,t.window=12,seasonality=1,trend=1){
  return(data-trend*getTrend(data,s.window=s.window,t.window=t.window)-seasonality*getSeasonality(data,s.window=s.window,t.window=t.window))
}
#'Find best indicator and lead time
#'Gets the indicator and lead time from a set of indicators which ahs the maximum kendall's tau with repsect to the said KPI
#'@param KPI The KPi for which we wish to find an exogeneous time series and appropriate lead time
#'@param indicators The set of indicators which we look at to find the best exogeneous time series variable
#'@param max.lag The maximum lag which is considered while finding an exogeneous time series
#'@param min.lag The minimum lag which is considered while finding an exogeneous time series
#'@return A list conating the indicator name and the lag which provide maximum dependency with the KPI
getMaxKtau<-function(KPI,indicators,max.lag=18,min.lag=5){
  max=0
  max_ind=indicators[,1]
  max_lag<-0
  cnt=1
  for(i in indicators){
    for(j in min.lag:max.lag){
      df<-getp1p2(KPI,i,lag=j)
      
      cor_val<-cor(df$KPI,df$indicator,method='kendall',use='pairwise.complete.obs')
      if(is.na(cor_val)){
        cor_val<-0
      }
      if(abs(cor_val)>max){
        max=abs(cor_val)
        max_ind_name<-colnames(indicators)[cnt]
        max_lag<-j
      }
    }
    cnt=cnt+1
  }
  ret_list<-list()
  ret_list[[1]]<-max
  ret_list[[2]]<-max_ind_name
  ret_list[[3]]<-max_lag
  return(ret_list)
}
#'Compute MASE
#'Get the mean absolute square error for the prediction and the target. One of the metrics to benchamrk our results.
#'@param pred The prediction from the model
#'@param target The actuals for the said period
#'@return The MASE between the prediction and the target
getMASE<-function(pred,target){
  total<-length(pred)
  nr<-0
  dr<-0
  for(i in 1:total){
    nr<-nr+abs(pred[i]-target[i])
    if(i!=1){
      dr<-dr+abs(target[i]-target[i-1])  
    }
    
    
  }
  mase<-nr/dr
  mase<-mase*(total-1)/total
  return(mase)
}

#'Place multiple plots together
#'Utility function to place multiple plots generated by \code{ggplot} on the same page
#'@return NULL
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
#'Calculate required business transformation
#'Calculate month-over-month or year-over-year transformation based on argument
#'@param series The time series which needs to be transformed
#'@param trafo A string which should be one of c(NULL, 'mom','yoy') to specify which transformation.
#'@return Return the transformed series.
get_transformed_series<-function(series,trafo=NULL){
  if(is.null(trafo)){
    return(series)
  }
  if(trafo=='mom'){
    return(getMoM(series))
  }
  if(trafo=='yoy'){
    return(getYoY(series))
  }
  return(series)
}
#'Reverse business tranformation
#'Reverse the business transformation to obtain the raw forecast and time series
#'@param series The transformed series
#'@param trafo A string which should be one of c(NULL, 'mom','yoy') to specify which transformation to reverse
#'@param init_vals The initial values from the raw time series.
#'@return The raw time series after reversing the business transformation.
rev_transformation<-function(series,trafo=NULL,init_vals){
  if(is.null(trafo)){
    return(series)
  }
  if(trafo=='mom'){
    return(revMoM(init_vals[1],series))
  }
  if(trafo=='yoy'){
    return(revYoY(init_vals[1:12],series))
  }
  
}
#'Reverse month over month transformation
#'@param series The transformed series
#'@param init_vals The initial values from the raw time series.
#'@return The raw time series after reversing the month over month transformation.
revMoM<-function(init_val,MoM_vals){
  raw_data<-numeric()
  raw_data<-c(raw_data,init_val)
  for(i in 1:length(MoM_vals)){
    raw_data<-c(raw_data,raw_data[i]*MoM_vals[i])
  }
  return(raw_data)
}
#'Reverse month over month transformation
#'@param series The transformed series
#'@param init_vals The initial values from the raw time series.
#'@return The raw time series after reversing the year over year transformation.
revYoY<-function(init_vals,YoY_vals){
  raw_data<-numeric()
  raw_data<-c(raw_data,init_vals)
  for(i in 1:length(YoY_vals)){
    raw_data<-c(raw_data,raw_data[i]*YoY_vals[i])
  }
  return(raw_data)
}
#'Wrapper function for copula forecast
#'@param KPI The time series which needs to be predicted
#'@param indicator_set The set of indicators which are looked through for finding an exogeneous time series
#'@param indicator_name The indicator which is used to forecast the \code{KPI}. If it is \code{NULL}, then maximum kendall's tau is used to automatically pick the exogeneous time series
#'@param min.lag The minimum lead time which is looked at while picking the exogeneous time series 
#'@param max.lag The maximum lwead time which is looked at while picking the exogeneous time series
#'@param kpi_trafo The transformation which is applied to the KPI before forecasting
#'@param ind_trafo The transformation which is applied to the indicator before forecasting
#'@param KPI_outlier_corr Boolean to indicate whether to perform outlier correction on the KPI
#'@param indicator_outlier_corr Boolean to indicate whether to perform outlier correction on the indicator
#'@param offset Indicates whether the copula forecast should be offset or not. The offset is determined by the 
#'@param dates Deprecated
#'@return The median and 2 sigma forecast from the copula model
getCopfc<-function(KPI,indicator_set,indicator_name=NULL,min.lag=5,
                   max.lag=18,lag=NULL,kpi_trafo=NULL,ind_trafo=NULL,
                   KPI_outlier_corr=FALSE,indicator_outlier_corr=FALSE,
                   offset=TRUE,dates=NULL){
  KPI_orig<-KPI
  KPI<-get_transformed_series(KPI,trafo=kpi_trafo)
  indicator_set<-as.data.frame(sapply(indicator_set,function(x) get_transformed_series(x,trafo=ind_trafo)))
  
  if(is.null(indicator_name)){
    best_ind<-getMaxKtau(KPI,indicator_set,min.lag = min.lag,max.lag = max.lag)
    indicator_name<-best_ind[[2]]
    lag<-best_ind[[3]]
    
  }
  indicator<-indicators[,indicator_name]
  indicator<-imputeTS::na.ma(indicator)
  if(is.null(lag)){
    lag<-plotccf_kendall(KPI,indicator=indicator)
  }
  #browser()
  df<-as.data.frame(cbind(KPI,indicator))
  colnames(df)<-c('KPI','indicator')
  if(!is.null(dates)){
    df$dates<-dates
  }
  df<-df[complete.cases(df),]
  df_beg<-df[1:12,]
  
  
  ind_vals<-df$indicator[(nrow(df)-lag+1):nrow(df)]
  dates<-df$dates
  df<-getp1p2(df$KPI,df$indicator,lag=lag)
  #df$dates<-dates[]
  if(KPI_outlier_corr){
    df$KPI<-as.vector(tsoutliers::tso(ts(df$KPI))$yadj)
  }
  if(indicator_outlier_corr){
    df$KPI<-as.vector(tsoutliers::tso(ts(df$indicator))$yadj)
  }
  mean_ind<-mean(df$indicator)
  mean_KPI<-mean(df$KPI)
  sd_ind<-sd(df$indicator)
  sd_KPI<-sd(df$KPI)
  
  df$indicator<-as.vector(scale(df$indicator))
  df$KPI<-as.vector(scale(df$KPI))
  indicator_df = optim(f = l_skewT, par=c(3,0.5),x=df$indicator ,method='Nelder')
  KPI_df = optim(f = l_skewT, par=c(3,0.5),x=df$KPI,method='Nelder')
  param_indicator<-indicator_df$par
  param_KPI<-KPI_df$par
  cdf_indicator<-pskt(df$indicator,df=param_indicator[1],gamma=param_indicator[2])
  cdf_KPI<-pskt(df$KPI,df=param_KPI[1],gamma=param_KPI[2])
  bc<-VineCopula::BiCopSelect(cdf_indicator,cdf_KPI)
  median_fc<-numeric()
  
  mean_fc<-numeric()
  low_fc <- numeric()
  high_fc <- numeric()
  high2_fc<-numeric()
  low2_fc<-numeric()
  quantiles_fc<-list()
  i=1
  s<-(1:99)/100
  quantiles_mat<-matrix(nrow=length(s),ncol=lag)
  #browser()
  ind_vals<-(ind_vals-mean_ind)/sd_ind
  for(ind_val in ind_vals){ # ind_val = -1.559593
    ind_cdf<-pskt(ind_val,df=param_indicator[1],gamma=param_indicator[2])
    cond_sim_cdf<-VineCopula::BiCopCondSim(100000,cond.val=ind_cdf,cond.var = 1,obj=bc)
    cond_sim<-qskt(cond_sim_cdf,df=param_KPI[1],gamma=param_KPI[2])
    median_fc<-c(median_fc,median(cond_sim))
    mean_fc<-c(mean_fc,mean(cond_sim))
    high_fc <-c(high_fc, summary(cond_sim)[5])
    low_fc <-c(low_fc, summary(cond_sim)[2])
    high2_fc<-c(high2_fc,quantile(cond_sim,.95))
    low2_fc<-c(low2_fc,quantile(cond_sim,.05))
    quantiles_fc[[i]]<-c(quantiles_fc,quantile(cond_sim,s))
    quantiles_mat[,i]<-as.vector(quantile(cond_sim,s))
    i<-i+1
    
  }
  
  fc_df<-as.data.frame(cbind(as.vector(low2_fc),as.vector(low_fc),as.vector(mean_fc),as.vector(median_fc),
                             as.vector(high_fc),as.vector(high2_fc)))
  colnames(fc_df)<-c('minus_two_sig','minus_sig','mean','median','sig','two_sig')
  fc_df<- as.data.frame( apply(fc_df, 1, function(x) return(x*sd_KPI+mean_KPI) ))
  fc_df<-as.data.frame( apply(fc_df, 1, function(x) rev_transformation(x,trafo = kpi_trafo,df_beg$KPI) ))
  
  if(offset){
    ar_mod<-auto.arima(KPI)
    next_fc<-forecast(ar_mod,h=1)
    next_fc<-as.vector(next_fc$mean)
    offset<-fc_df$mean[1]-next_fc
    fc_df<-fc_df-offset
  }
  combined_df<-as.data.frame(matrix(NA,nrow=length(KPI_orig),ncol=ncol(fc_df)))
  colnames(combined_df)<-colnames(fc_df)
  combined_df<-rbind(combined_df,fc_df)
  combined_df$KPI<-c(KPI_orig,rep(NA,lag))
  return(fc_df)
}