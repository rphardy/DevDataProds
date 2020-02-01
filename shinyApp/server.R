library(shiny)

# Define server logic required to draw facet plot of lifeExp vs gdpPercap
shinyServer(function(input, output) {

    output$gdplife <- renderPlot({

        # generate year based on input$year from ui.R
        x    <- gapminder$gdpPercap
        year <- seq(min(x), max(x), length.out = input$year + 1)

        # draw the plot
        gap_bit <- subset(gapminder, year == input$year & continent != "Oceania")
        gap_bit <- gap_bit[with(gap_bit, order(continent, year, -1 * pop)), ]
            ggplot(gap_bit, aes(x = gdpPercap, y = lifeExp, size = pop)) +
            scale_x_log10(limits = c(150, 115000)) + ylim(c(16, 96)) +
            geom_point(pch = 21, color = 'grey20', show.legend = FALSE) +
            scale_size_area(max_size = 40) + ylab("Life expectancy (years)") +
            xlab("GDP per capita (US$, inflation-adjusted)") +
            facet_wrap(~ continent) + coord_fixed(ratio = 1/43) +
            aes(fill = country) + scale_fill_manual(values = country_colors) +
            theme_bw() + theme(strip.text = element_text(size = rel(1.1)))
    })
    output$country <- renderPlot({
        # show country gdp track over years between 1952-2007: 5 year interval
        x <- gapminder$gdpPercap
        country <- input$country
        
        gap_country <- subset(gapminder, country == input$country)
        gap_country <- gap_country[with(gap_country, order(continent, year, -1 * pop)), ]
        
        gdp <- ggplot(gap_country, aes(x = year, y = gdpPercap)) +
            geom_point(pch = 21, color = 'grey0', show.legend = FALSE) +
            geom_line(color = 'grey0') + theme_bw() +
            facet_wrap(~ country) + ylab("GDP per capita (US$, inflation-adjusted)")
            aes(fill = country)
        gdp
        
    })
    output$country2 <- renderPlot({
        # show country lifeexp track over years between 1952-2007: 5 year interval
        x <- gapminder$lifeExp
        country <- input$country
        
        gap_country <- subset(gapminder, country == input$country)
        gap_country <- gap_country[with(gap_country, order(continent, year, -1 * pop)), ]
        
        lifeexp <- ggplot(gap_country, aes(x = year, y = lifeExp)) +
            geom_point(pch = 21, color = 'grey0', show.legend = FALSE) +
            geom_line(color = 'grey0') + theme_bw() +
            facet_wrap(~ country) + ylab("Life expectancy (years)") +
            aes(fill = country)
        lifeexp
    })
    percentchange <- reactive({
        countryInput <- input$country
        (gapminder$gdpPercap[gapminder$country == as.character(countryInput) & gapminder$year == 2007] 
        - gapminder$gdpPercap[gapminder$country == as.character(countryInput) & gapminder$year == 1952])/ 
        gapminder$gdpPercap[gapminder$country == as.character(countryInput) & gapminder$year == 1952] * 100
        
    })
    lifeexpchange <- reactive({
        countryinput <- input$country
        (gapminder$lifeExp[gapminder$country == as.character(countryinput) & gapminder$year == 2007]
        -gapminder$lifeExp[gapminder$country == as.character(countryinput) & gapminder$year == 1952])
    })
    
    output$gdpchange <- renderText(paste("%",round(percentchange(),2)), )
    output$lifeexpchange <- renderText(paste(round(lifeexpchange(),0)," years"))
        
    
    
    

})
