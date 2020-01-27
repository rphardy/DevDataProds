library(shiny)

# Define UI for application that draws a series of plots
shinyUI(fluidPage(

    # Application title
    titlePanel("Gapminder - Life Expectancy by GDP over time"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "year",
                        label = "slide by year",
                        min = 1952,
                        max = 2007,
                        step = 5,
                        value = 1987)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("gdplife")
        )
    )
))
