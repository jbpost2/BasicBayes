###########################################################################
##R Shiny App to plot different possible posterior distributions from coin example
##Justin Post - Fall 2016 (updated 2017)
###########################################################################

#Load package
library(shiny)
library(shinydashboard)

# Define UI for application that displays an about page and the app itself

dashboardPage(skin="red",

  #add title
  dashboardHeader(title="Posterior Distribution for Coin Example",titleWidth=1000),
  
  #define sidebar items
  dashboardSidebar(sidebarMenu(
    menuItem("About", tabName = "about", icon = icon("archive")),
    menuItem("Application", tabName = "app", icon = icon("laptop"))
  )),

  #define the body of the app
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "about",
        fluidRow(
          #add in latex functionality if needed
          withMathJax(),
          
          #two columns for each of the two items
          column(6,
            #Description of App
            h1("What does this app do?"),
            #box to contain description
            box(background="red",width=12,
              h4("This application shows the relationship between the prior distribution and the posterior distribution for a simple Bayesian model."),
              h4("The prior distribution is assumed to be a Beta distribution and the likelihood is a Binomial distribution with 30 trials (of which you can change the number of successes).  This yields a Beta distribution as the posterior. Note: As the prior distribution is in the same family as the posterior, we say the prior is conjugate for the likelihood."),
              h4("This application corresponds to an example in ",span("Mathematical Statistics and Data Analysis",style = "font-style:italic"), "section 3.5, example E, by John Rice."),
              h4("The goal of the example is to update our belief about the parameter \\(\\Theta\\) = the probability of obtaining a head when a particular coin is flipped.  The experiment is to flip the coin 30 times and observe the number of heads. The likelihood is then a binomial distribution. The prior is assumed to be a Beta distribution.")
            )
          ),
          
          column(6,
            #How to use the app
            h1("How to use the app?"),
            #box to contain description
            box(background="red",width=12,
              h4("The controls for the app are located to the left and the visualizations are available on the right."),
              h4("To change the number of successes observed (for example the number of coins landing head side up), the slider on the top left can be used."),
              h4("To change the prior distribution, the hyperparameters can be set using the input boxes on the left.  The changes in this distribution can be seen on the first graph."),
              h4("The resulting changes to the posterior distribution can be seen on the second graph.")
            )
          )
        )
      ),
      
      #actual app layout      
      tabItem(tabName = "app",
        fluidRow(
          column(width=3,
            box(width=12,background="red",sliderInput("yvalue","Y=Number of Successes",min = 0,max = 30,value = 15)
            ),
            box(width=12,
              title="Hyperparameters of the prior distribution for \\(\\Theta\\)",
              background="red",
              solidHeader=TRUE,
              p("\\(\\frac{\\Gamma(\\alpha+\\beta)}{\\Gamma(\\alpha)\\Gamma(\\beta)}\\theta^{\\alpha-1}(1-\\theta)^{\\beta-1}\\)"),
              h5("(Set to 1 if blank.)"),
              numericInput("alpha",label=h5("\\(\\alpha\\) Value (> 0)"),value=1,min=0,step=0.1),
              numericInput("beta",label=h5("\\(\\beta\\) Value (> 0)"),value=1,min=0,step=0.1)
            )
          ),
          column(width=9,
            fluidRow(
              box(width=6,
                plotOutput("priorPlot"),
                br(),
                h4("Prior distribution for the probability of success parameter \\(\\Theta\\).")
              ),
              box(width=6,
                plotOutput("distPlot"),
                br(),
                h4("Posterior distribution for the probability of success \\(\\Theta\\).")
              )
            )
          )
        )
      )
    )
  )
)

