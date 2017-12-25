library(shiny)
library(plotly)
shinyServer(function(input, output) {
  output$plot <- renderPlotly({
    if (input$currency == ''|| input$period == '') {
      print("Please select currency and aggregation period")
    } else {
      sCUR <- input$currency
      if (input$period == 'mins') { j<-1 } else { j<-2 }

      sPlotTitle<-paste0(sTmpTitle,sCUR)
      graph_title  <- sPlotTitle
      
      df=read.csv(paste0(sURL,sCUR))
      colnames(df)<-c('utime','price','volume')
      df$date<-round(as.POSIXct(df$utime,origin='1970-01-01',tz='GMT'),fmtDt[j,1])
      df$dstr<-as.factor(format(df$date,format=fmtDt[j,2] ,tz='GMT'))
      tmp<-data.frame()
      for(i in levels(df$dstr)){
        x.df<-df[which(df$dstr==i),]
        x.size<-nrow(x.df)
        if(x.size<1){ return('NA') }
        ifelse((x.size==1),
               y<-list(dt=x.df$date,op=x.df$price,hi=x.df$price,
                       lo=x.df$price,cl=x.df$price,vol=x.df$volume),
               y<-list(dt=x.df[1,'date'],
                       op=x.df[1,'price'],
                       hi=max(x.df$price),
                       lo=min(x.df$price),
                       cl=x.df[x.size,'price'],
                       vol=sum(x.df$volume))
        )
        ifelse((nrow(tmp)<1),
               tmp<-data.frame(y),
               tmp<-rbind(tmp,y))
      }##for
      # renderPlotly()

        p<-tmp %>%
          plot_ly(x=~dt,type='candlestick',open=~op,close=~cl,high=~hi,low=~lo,increasing=i1,decreasing=d1) %>%
          layout(title=sPlotTitle)
        pp<-tmp %>%
          plot_ly(x=~dt,y=~vol,type='bar') %>%
          layout(yaxis = list(title = "Volume"))
        subplot(p,pp,heights=c(0.7,0.2),nrows=2,shareX=TRUE,titleY=TRUE)

    }##else
  })
  
  }
)
