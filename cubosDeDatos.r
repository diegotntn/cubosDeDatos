# Instalar si no lo tienes
# install.packages("plotly")
# install.packages("dplyr")

library(plotly)
library(dplyr)
library(htmlwidgets)

# Datos
artistas <- c("fuentesprod", "SKINCARE", "Ezya", "Novato El Flow", "Doony Graff", "The Smiths")
semanas <- c("Semana 1", "Semana 2", "Semana 3", "Semana 4")
metricas <- c("Reproducciones", "Tiempo Escuchado")

# Data frame con datos
datos_spotify <- expand.grid(
  Artista = artistas,
  Semana = semanas,
  Metrica = metricas
)

# Distribución de las reproducciones y minutos por semana
valores <- c(
  # REPRODUCCIONES
  # fuentesprod
  35, 32, 33, 29,
  # SKINCARE
  25, 22, 21, 20,
  # Ezya
  23, 22, 20, 19,
  # Novato El Flow
  21, 19, 18, 17,
  # Doony Graff
  17, 16, 15, 12,
  # The Smiths
  16, 15, 14, 14,
  
  # MINUTOS
  # fuentesprod
  95, 88, 85, 77,
  # SKINCARE
  52, 48, 45, 42,
  # Ezya
  65, 60, 58, 50,
  # Novato El Flow
  58, 54, 52, 44,
  # Doony Graff
  43, 40, 38, 33,
  # The Smiths
  52, 48, 45, 41
)

datos_spotify$Valor <- valores

# Asignar coordenadas para el cubo 3D
x_map <- setNames(0:(length(artistas) - 1), artistas)
y_map <- setNames(0:(length(semanas) - 1), semanas)
z_map <- setNames(0:(length(metricas) - 1), metricas)

datos_spotify <- datos_spotify %>%
  mutate(
    x = x_map[as.character(Artista)],
    y = y_map[as.character(Semana)],
    z = z_map[as.character(Metrica)]
  )


# Graficar
fig <- plot_ly(
  datos_spotify,
  x = ~x,
  y = ~y,
  z = ~z,
  type = "scatter3d",
  mode = "markers+text",
  text = ~paste(Metrica, ":", Valor, ifelse(Metrica == "Tiempo Escuchado", "min", "")),
  marker = list(
    size = 8,
    color = ~Valor,
    colorscale = "Viridis",
    opacity = 0.8
  )
) %>%
  layout(scene = list(
    xaxis = list(
      title = "Artista",
      tickvals = 0:(length(artistas)-1),
      ticktext = artistas
    ),
    yaxis = list(
      title = "Semana",
      tickvals = 0:(length(semanas)-1),
      ticktext = semanas
    ),
    zaxis = list(
      title = "Métrica",
      tickvals = 0:(length(metricas)-1),
      ticktext = metricas
    )
  ),
  title = "Cubo OLAP (Artistas Spotify)")

fig
