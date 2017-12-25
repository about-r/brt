sURL<-"https://api.bitcoincharts.com/v1/trades.csv?symbol=kraken"
mAPI<-'https://bitcoincharts.com/about/markets-api/'
vCurrency<-c('USD','EUR')
vAggr<-c('mins','hours')
fmtDt<-matrix(nrow=2,ncol=2,byrow=TRUE,data=c('mins','%Y-%m-%d %H:%M','hours','%Y-%m-%d %H'))
sTmpTitle<-'Bitcoin Recent Trades in '
d1 <- list(line = list(color = 'black'))
i1 <- list(line = list(color = 'red'))