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