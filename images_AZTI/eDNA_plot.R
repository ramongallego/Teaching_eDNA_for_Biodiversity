library(plotly)
library(here)

x_vals <- seq(-5, 5, length.out = 50)  
y_vals <- seq(0, 5, length.out = 50)   


gamma <- 0.5  # Controls minimum travel time for DNA from far away

z_matrix <- outer(x_vals, y_vals, function(x, y) {
  # Ensure DNA does not appear before travel time is met
  ifelse(y >= gamma * abs(x), exp(- (x^2 + (y - gamma * abs(x))^2)), 0)
})

# Transpose to align correctly with plotly
DNA_amount <- t(z_matrix)

# Create interactive plot
nice_plot <- function(matrix){
  plot_ly(x = ~x_vals, y = ~y_vals, z = matrix) %>%
    add_surface(colorscale = list(
      c(0, 0.01, 1),  # Set low values to white, rest to Viridis
      c("#FFFFFF","#FFFFFF", "Viridis")  # White for 0, then Viridis scale
    ),
    colorbar = list(title = "DNA Amount")) %>%
    layout(
      title = "DNA Detection Over Time and Space",
      scene = list(
        xaxis = list(title = "Distance"),
        yaxis = list(title = "Time Before Sampling"),
        zaxis = list(title = "DNA Amount")
      )
    )
}
nice_plot(matrix = DNA_amount) -> p
saveWidget(p, here("images_AZTI","plotly_dna.html"), selfcontained = TRUE)

z_matrix_soft1 <- outer(x_vals, y_vals, function(x, y) {
  ifelse(y >= gamma * abs(x), 
         exp(-((x^2 + (y - gamma * abs(x))) / 4)), 
         0)  # Prevents DNA from appearing instantly at far distances
})
z_matrix_soft1 <- t(z_matrix_soft1)

nice_plot(matrix = z_matrix_soft1)-> q

saveWidget(q, here("images_AZTI","plotly_sponge.html"), selfcontained = TRUE)
