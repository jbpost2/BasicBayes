library(shiny)

# Define server logic required to draw the plots
shinyServer(function(input, output) {

  #Create prior plot output
  output$priorPlot<-renderPlot({

    #Plotting sequence
    x <- seq(from=0,to=1,by=0.01)

    #get alpha and beta values from input
    alphaval<-input$alpha
    betaval<-input$beta

    #set defaults if not supplied
    if (is.na(alphaval)){alphaval<-1}
    if (is.na(betaval)){betaval<-1}

    #draw the prior distribution plot
    plot(x=x,y=dbeta(x=x,shape1=alphaval,shape2=betaval),main="Prior Density for Theta",xlab="theta's", ylab="f(theta)",type="l", ylim = c(0, max(dbeta(x=x,shape1=alphaval,shape2=betaval)) + 0.1))

  })

  #create posterior plot
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

    #set defaults if not supplied
    if (is.na(alphaval)){alphaval<-1}
    if (is.na(betaval)){betaval<-1}

    # draw the posterior
    plot(x=x,y=dbeta(x=x,shape1=numsuccess+alphaval,shape2=n-numsuccess+betaval),main=paste("Posterior Density for Theta|Y=",numsuccess,sep=""),xlab="theta's", ylab="f(theta|y)",type="l",ylim = c(0, max(dbeta(x=x,shape1=numsuccess+alphaval,shape2=n-numsuccess+betaval))+0.1))
  })



  #Create prior plot output
  output$priorPlot2 <- renderPlot({

    #get alpha and beta values from input
    alphaval<-input$alpha2
    betaval<-input$beta2

    #set defaults if not supplied
    if (is.na(alphaval)){alphaval<-1}
    if (is.na(betaval)){betaval<-1}

    #Plotting sequence
    x <- seq(from=0,to=alphaval/betaval+4*sqrt(alphaval/betaval),length = 2000)

        #draw the prior distribution plot
    plot(x=x,y=dgamma(x=x,shape=alphaval,rate=betaval),main="Prior Density for Lambda",xlab="lambda's", ylab="f(lambda)",type="l")

  })

  #create posterior plot
  output$distPlot2 <- renderPlot({

    #get alpha and beta values from input
    alphaval<-input$alpha2
    betaval<-input$beta2

    #set defaults if not supplied
    if (is.na(alphaval)){alphaval<-1}
    if (is.na(betaval)){betaval<-1}

    #number of success from input slider
    sampMean <- input$sampleMean
    sampSize <- input$sampleSize

    newalpha <- alphaval + sampMean*sampSize
    newbeta <- betaval + sampSize

    #Plotting sequence
    x <- seq(from=0,to=newalpha/newbeta+4*sqrt(newalpha/newbeta),length = 2000)

    # draw the posterior
    plot(x=x,y=dgamma(x=x,shape=newalpha,rate = newbeta),main=paste("Posterior Density for Lambda|y's",sep=""),xlab="lambda's", ylab="f(lambda|y's)",type="l")
  })

})
