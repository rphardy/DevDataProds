library(shiny)

# Define server logic required to draw facet plot of lifeExp vs gdpPercap
shinyServer(function(input, output) {

    output$gdplife <- renderPlot({

        # generate bins based on input$year from ui.R
        x    <- gapminder$gdpPercap
        year <- seq(min(x), max(x), length.out = input$year + 1)

        # draw the histogram with the specified number of bins
        gap_bit <- subset(gapminder, year == input$year & continent != "Oceania")
        gap_bit <- gap_bit[with(gap_bit, order(continent, year, -1 * pop)), ]
        ggplot(gap_bit, aes(x = gdpPercap, y = lifeExp, size = pop)) +
            scale_x_log10(limits = c(150, 115000)) + ylim(c(16, 96)) +
            geom_point(pch = 21, color = 'grey20', show.legend = FALSE) +
            scale_size_area(max_size = 40) +
            facet_wrap(~ continent) + coord_fixed(ratio = 1/43) +
            aes(fill = country) + scale_fill_manual(values = country_colors) +
            theme_bw() + theme(strip.text = element_text(size = rel(1.1)))
    })

})
