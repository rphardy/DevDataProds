library(shiny)
library(ggplot2)
library(plotly)
require(gapminder)

# Define UI for application 
shinyUI(fluidPage(

    # Application title
    titlePanel("Exploring Gapminder data - general improvements in the Health and Wealth of nations with time"),

    # Sidebar with a slider input for year
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "year",
                        label = "slide by 5 year window - right key moves to next",
                        min = 1952,
                        max = 2007,
                        step = 5,
                        value = 1952),
            selectInput(inputId = "country",
                      label = "select a country",
                      choices = gapminder$country,
                      selected = 1)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("world plot: Life expectancy in years by GDP per capita over time"),
            plotOutput("gdplife"),
            h3("Selected country's % difference in GDP per capita between 1952 and 2007:"),
            textOutput("gdpchange"),
            h3("country plot: GDP per capita trend between 1952 and 2007"),
            plotOutput("country"),
            
        )
    )
))
