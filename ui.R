###########################################################################
##R Shiny App to plot different possible posterior distributions from coin example
##Justin Post - Fall 2016
###########################################################################

#Load package
library(shiny)
library(shinydashboard)

# Define UI for application that draws the prior and posterior distributions given a value of y
dashboardPage(skin="red",
              dashboardHeader(title="Posterior Distribution for Coin Example",titleWidth=1000),
              dashboardSidebar(disable = TRUE),
              dashboardBody(
                column(width=1),
                column(
                  width=3,
                  box(background="red",width=12,title="Description of Example",solidHeader=TRUE,
                      h5("Prior/posterior example. Corresponds
                         to Mathematical Statistics and Data 
                         Analysis section 3.5, example E, by 
                         John Rice. The goal is to update our
                         belief about the parameter theta - 
                         the probability of obtaining a head
                         when a particular coin is flipped.
                         The experiment is to flip the coin
                         30 times and observe the number of
                         heads. The likelihood is then a
                         binomial distribution. The prior is
                         assumed to be a Beta distribution (a conjugate prior for theta)."
                      )
                      ),
                  
                  
                  box(width=12,background="red",
                      sliderInput("yvalue","Y=Number of Successes",min = 0,max = 30,value = 15)
                  ),
                  box(width=12,
                      title="Hyperparameters of the prior distribution",
                      background="red",
                      solidHeader=TRUE,
                      h5("(Set to 1 if blank.)"),
                      numericInput("alpha",label=h5("Alpha Value (> 0)"),value=1,min=0,step=0.1),
                      numericInput("beta",label=h5("Beta Value (> 0)"),value=1,min=0,step=0.1)
                  )
                      ),
                column(width=7,
                       fluidRow(
                         box(
                           width=6,
                           plotOutput("priorPlot"),
                           br(),
                           h4("The plot above displays the prior distribution for the probability of success parameter theta.  This prior can be manipulated by changing the values of alpha and beta on the left of the app.")
                         ),
                         box(
                           width=6,
                           plotOutput("distPlot"),
                           br(),
                           h4("The plot above displays the posterior distribution for the probability of success theta.  This distribution represents an updated belief about the paramter.  It combines the information from the prior with the observed data from the experiment (or likelihood) - the latter of which can be changed using the slider on the top left.")
                         )
                       )
                )
                  )
                )

