library(shiny)

# Define server logic required to draw the plots
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$priorPlot<-renderPlot({
    #Plotting sequence
    x    <- seq(from=0,to=1,by=0.01)
    #get alpha and beta values from input
    alphaval<-input$alpha
    betaval<-input$beta
    
    if (is.na(alphaval)){alphaval<-1}
    if (is.na(betaval)){betaval<-1}
    
    #draw the prior distribution plot
    plot(x=x,y=dbeta(x=x,shape1=alphaval,shape2=betaval),main="Prior Density for Theta",
         xlab="theta's", ylab="f(theta)",type="l")
    
  })
  
  output$distPlot <- renderPlot({
    #Plotting sequence
    x    <- seq(from=0,to=1,by=0.01)
    #number of success from input slider
    numsuccess <- input$yvalue
    #get alpha and beta values from input
    alphaval<-input$alpha
    betaval<-input$beta
    #sample size
    n<-30

    if (is.na(alphaval)){alphaval<-1}
    if (is.na(betaval)){betaval<-1}
        
    # draw the posterior
    plot(x=x,y=dbeta(x=x,shape1=numsuccess+alphaval,shape2=n-numsuccess+betaval),
         main=paste("Posterior Density for Theta|Y=",numsuccess,sep=""),
         xlab="theta's", ylab="f(theta|y)",type="l")
  })
})