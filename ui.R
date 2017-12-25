library(shiny)
library(plotly)
ui <- fluidPage(
  sidebarPanel(
    h4("Chart Input Parameters"),
    selectizeInput("currency", label = "Trades in Currency",
                   choices = vCurrency, multiple = F,
                   options = list(maxItems = 1, placeholder = 'Select currency'),
                   selected = "USD"),
    selectizeInput("period", label = "Aggregate Period",
                   choices = vAggr, multiple = F,
                   options = list(maxItems = 1, placeholder = 'Select period'),
                   selected = "hours"),
    helpText("Data: Provided by Bitcoincharts/Markets API ")
  ),
  mainPanel(
    plotlyOutput("plot")
  )
 )