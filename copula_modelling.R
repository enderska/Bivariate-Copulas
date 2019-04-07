########################ReadMe#########################################


#Line 32: Working directory
#Line 59: Feri data file name. Change the name accoring to the country
#Line 108: Change the indicator name
#Line 112: Change the KPI name
#Line 117: Change the lead time
#Line 141: Outlier correction. Used only for spain ebit
#Line 207: Copula fitting. Change to force a copula family fit


#######################################################################



#reqired packages
#install.packages("skewt")
#install.packages("copula")
#install.packages("VineCopula")
#install.packages("ggplot2")
#install.packages("scatterplot3d")
#install.packages("forecast")
#install.packages("CDVine")
#install.packages("ggplot2")
#install.packages("tseries")



rm(list = ls())

# Set wd
wd <- ('C:/Temp/workspace/copulas/copulaForecast')
setwd(wd)

library(skewt)
library(copula)
library(VineCopula)
library(ggplot2)
library(scatterplot3d)
library(forecast)
library(CDVine)
library(ggplot2)
library(tseries)

source('copula_helpers.R')

set.seed(1234)
#Reading the data and parsing the dates
data <- read.csv("LI_KPI_Copula_Analysis.csv", header = TRUE)
date<-as.Date(paste0('01.',data$Month,'.',data$Year),format = '%d.%b.%Y')
country<-'ESP.FS'
colnm<-colnames(data)
colnm<-colnm[grepl(country,colnm)]
data<-data[,colnm]
data=data[,!(colnames(data) %in% c('Date'))]
data$Date<-date

feri_data<-read.csv('M_data_feri_SPAIN.csv')
#feri_data<-read.csv('M_data_feri_BRAZIL.csv')
#feri_data<-read.csv('M_data_feri_USA.csv')
feri_data$date<-as.Date(feri_data$date,format='%Y-%m-%d')
feri_data$Date<-feri_data$date
feri_data$date<-NULL

data<-merge(data,feri_data,by='Date')
date<-data$Date
data$Date<-NULL

#Transform to month over month values for stationarising the data
data_mom<-as.data.frame(sapply(data,function(x) getMoM(x)))
colnames(data_mom)<-paste0(colnames(data_mom),'_MoM')

#Year over year transformation is not being used  anymore
data_yoy<-as.data.frame(sapply(data,function(x) getYoY(x)))
colnames(data_yoy)<-paste0(colnames(data_yoy),'_YoY')


data2<-data


data<-data_mom
#data cleaning
for(i in colnames(data)){
  if(length(which(complete.cases(data[,i])))<70){
    data[,i]<-NULL
  }
}

data_diff<-data[1:(nrow(data)-1),]

for(i in colnames(data)){
  data_diff[,i]=diff(data[,i])
}
data_temp<-data




#Names of the KPIs
y_names=c(paste0(country,'_Portfolio'),
          paste0(country,'_Ebit') ,
          paste0(country,'_Acqu'))

y_names<-paste0(y_names,'_MoM')
#The indicator and lead time to be used

indicator_name<-'SPAIN_M184SRUNY.INT_MoM' #for Spain
#indicator_name<-'BRA.FS_CLI_MoM'         #for Brazil
#indicator_name<-'USA_M111NM1MS.INT_MoM'  #for US

KPI_name<-paste0(country,'_Ebit_MoM')     #for Spain
#KPI_name<-paste0(country,'_Portfolio_MoM') #for Brazil
#KPI_name<-paste0(country,'_Acqu_MoM')      #for US


#change of lags for BRAZIL 13/USA 12
lag=17




KPI<-data[,y_names]


indicators<-data[,!(colnames(data) %in% c(y_names))]


for(i in colnames(indicators)){
  if(length(which(is.na(indicators[,i])))<100){
    indicators[,i]<-NULL
  }else if(length(unique(indicators[,i]))<100){
    indicators[,i]<-NULL
  }
}


colnm_KPI<-colnames(KPI)[grepl('MoM',colnames(KPI))]
colnm_indicators<-colnames(indicators)[grepl('MoM',colnames(indicators))]

#Outlier correction by fitting an ARIMA on the KPI                       
data$ESP.FS_Ebit_MoM[2:nrow(data)]<-as.vector(tsoutliers::tso(ts(data$ESP.FS_Ebit_MoM[2:nrow(data)],frequency=12))$yadj)

ind_orig<-data[,indicator_name]

#Lead time adjusted KPI and indicator object
df_temp=getp1p2(KPI=(data[,KPI_name]),(data[,indicator_name]),lag=lag)


df_dates<-date[1:(length(date)-lag)]
df_temp$date=df_dates
df_temp<-df_temp[complete.cases(df_temp),]

cor(df_temp$indicator,df_temp$KPI,method='kendall')


df<-df_temp[complete.cases(df_temp),]


cor(df$indicator,df$KPI,method = 'kendall')

btest_period<-8
#Split data into training and test sets
start_point<-nrow(df)-lag
df_train<-df[(1:start_point),]

cor(df_train$indicator,df_train$KPI)

df_test<-df[c((start_point+1):(start_point+lag)),]


##########################################################################
#Marginal fitting and copula fitting code
#Marginal: currently using skewt package and optimising using nelder mead(feel free to use other algos)

# params is a vector specifying the parameters for the density function. 
#For skew t it includes gamma and the number of degrees of freedom

df<-df_train
#Normalise the data(both KPI and indicator)
mean_ind<-mean(df$indicator)
mean_KPI<-mean(df$KPI)
sd_ind<-sd(df$indicator)
sd_KPI<-sd(df$KPI)
df_test$indicator<-(df_test$indicator-mean_ind)/sd_ind
df_test$KPI<-(df_test$KPI-mean_KPI)/sd_KPI


# Finding DF for skew t distributed margins using Nelder Mead algorithm 


df$indicator<-as.vector(scale(df$indicator))
df$KPI<-as.vector(scale(df$KPI))
indicator_df = optim(f = l_skewT, par=c(3,0.5),x=df$indicator ,method='Nelder')

KPI_df = optim(f = l_skewT, par=c(3,0.5),x=df$KPI,method='Nelder')

param_indicator<-indicator_df$par
param_KPI<-KPI_df$par


#Calculate CDf instead of pobs. Use pobs for empirical distribution. For simulation purposes we need to fit a distribution and inverse cdf , hence for fitting the copula we calculate the cdf

cdf_indicator<-pskt(df$indicator,df=param_indicator[1],gamma=param_indicator[2])
cdf_KPI<-pskt(df$KPI,df=param_KPI[1],gamma=param_KPI[2])

#Copula fitting . Use bicopselect for copula family, which uses AIC to slect optimal copula fit.
#Method itau is inverse kendall tau. Drawback: restricts to only one parameter copula families
bc<-VineCopula::BiCopSelect(cdf_indicator,cdf_KPI)

bc_list<-VineCopula::BiCopEstList(cdf_indicator,cdf_KPI,familyset=c(0,1,2,3,4,5,13,14,23,24,
                                                                    33,34,104,114,124,134,204,214,224,234))
bc_list_df_spain<-bc_list$summary
colnames(bc_list_df_spain)<-paste0(colnames(bc_list_df_spain),'_',country)
cop_obj<-BiCop(bc$family,bc$par,bc$par2)
#Check kendall's tau for values simulated from the copula 
u<-VineCopula::BiCopSim(5000,bc$family,bc$par,bc$par2)

cor(u,method='kendall')


cop_model<-bc
par<-bc$par
par2<-bc$par2
u<-VineCopula::BiCopSim(500,bc$family,bc$par,bc$par2)
cor(u,method='kendall')
cor(df$indicator,df$KPI,method='kendall')
#plot(bc)


median_fc<-numeric()

mean_fc<-numeric()
low_fc <- numeric()
high_fc <- numeric()
high2_fc<-numeric()
low2_fc<-numeric()
quantiles_fc<-list()
i=1
s<-(1:99)/100
quantiles_mat<-matrix(nrow=length(s),ncol=nrow(df_test))


#Simulate KPI values, conditioning on the current value of the indicator
for(ind_val in df_test$indicator){ 
  ind_cdf<-pskt(ind_val,df=param_indicator[1],gamma=param_indicator[2])
  
  cond_sim_cdf<-BiCopCondSim(100000,cond.val=ind_cdf,cond.var = 1,obj=bc)
  cond_sim<-qskt(cond_sim_cdf,df=param_KPI[1],gamma=param_KPI[2])
  median_fc<-c(median_fc,median(cond_sim))
  mean_fc<-c(mean_fc,mean(cond_sim))
  #Store the various percentiles from the 
  high_fc <-c(high_fc, summary(cond_sim)[2])
  low_fc <-c(low_fc, summary(cond_sim)[5])
  high2_fc<-c(high2_fc,quantile(cond_sim,.95))
  low2_fc<-c(low2_fc,quantile(cond_sim,.05))
  quantiles_fc[[i]]<-c(quantiles_fc,quantile(cond_sim,s))
  quantiles_mat[,i]<-as.vector(quantile(cond_sim,s))
  i<-i+1
  
}









df<-df[with(df,order(df[,3])),]
ar_mod<-auto.arima(ts(df$KPI,frequency = 12),xreg=df$indicator)
ar_fc<-forecast(ar_mod,h=12,xreg=df_test$indicator)
dates<-(c(df$date,df_test$date))

#Generate the plots 

plt_df<-as.data.frame(cbind(c(((df_train$KPI-mean_KPI)/sd_KPI),df_test$KPI),
                            c((df_train$indicator-mean_ind)/sd_ind,df_test$indicator),
                      
               c(rep(NA, length(df_train$KPI)),low_fc),
                 c(rep(NA, length(df_train$KPI)),high_fc),
               c(rep(NA, length(df_train$KPI)),median_fc),
               c(rep(NA, length(df_train$KPI)),high2_fc),
               c(rep(NA, length(df_train$KPI)),low2_fc),
               c(rep(NA, length(df_train$KPI)),as.vector(ar_fc$mean))))
colnames(plt_df)<-c('Original_Data','indicator','minus_one_sigma','one_sigma','median','two_sigma','minus_two_sigma',
                     'arimax_forecast')
plt_df$date<-dates
plt_df$ensemble<-(plt_df$median+plt_df$arimax_forecast)/2
fc1<-tail(plt_df$median,lag)
fc2<-tail(plt_df$arimax_forecast,lag)
fc3 <- (fc1 + fc2)/2



ggplot(plt_df,aes(date))+
  geom_line(aes(y=Original_Data,colour='Original data'))+
  geom_line(aes(y=median,colour='Median fc'))+
  geom_ribbon(aes(ymin=minus_two_sigma, ymax=two_sigma), alpha=0.1)+
  geom_line(aes(y=arimax_forecast,colour='ARIMAX forecast'),linetype='dashed',size=1)+
  xlab('Year')+
  ylab('Spain Ebit')+
  geom_line(aes(y=ensemble,colour='Ensemble forecast'),linetype='dashed',size=1)+
  geom_vline(xintercept = plt_df$date[(nrow(df_train)+1)],linetype='dotted')+
  annotate('text',x=plt_df$date[40],y=2,label='Training set')+
  annotate('text',x=plt_df$date[(start_point+lag/2)],y=2,label='Test set')

#Generate error metrics

err_med_fc<-getRMSE(pred=median_fc,target=df_test$KPI)
arima_mape<-getRMSE(pred=as.vector(ar_fc$mean),target=df_test$KPI)

