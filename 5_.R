rm(list=ls())

# cria um diretório para salvar o arquivo
#dir.create(  ".\\Arquivos\\shp1", showWarnings = FALSE)

# pega o link onde está o shapefile
#u_ibge <- paste0("ftp://geoftp.ibge.gov.br/organizacao_do_territorio/",
#                 "malhas_territoriais/malhas_municipais/",
#                 "municipio_2015/Brasil/BR/br_municipios.zip",
#                 collapse = "")

#httr::GET(u_ibge, # lê a url
#          httr::write_disk(".\\Arquivos\\shp1\\br.zip")  # salva em disco
#)



# dezipa os arquivo com unzip()

# unzip(".\\Arquivos\\shp1\\shapefile_sede_ibge_2015.zip", exdir = ".\\Arquivos\\shp1\\br")


### ............................................................................
                         
                           # LENDO O .SHP #

### ............................................................................
rm(list=ls())
library(tidyverse)
library(sf)

  # lendo os arquivos
sf_pr_polig <- st_read("./Arquivos/shp/pr/sf_parana.shp", quiet = TRUE) %>% 
  st_transform(crs = "+proj=longlat +ellps=WGS84 +no_defs")

sf_pr_point <- st_read("./Arquivos/shp1/br/5570_municipios2015.shp", quiet = TRUE) %>%
  filter(UF=="pr") %>% 
  st_transform(crs = "+proj=longlat +ellps=WGS84 +no_defs")

  # extrai somente as coordenadas de um objeto 
sp_pr <- sf_pr_polig %>% as("Spatial")
sp::coordinates(sp_pr) # obj matrix

  # dados de área st_area() retorna em metros quadrados
Area <- st_area(sf_pr_polig)
hist(Area)

### ............................................................................

                                  # Visualizando #

### ............................................................................

# via ggplot2::geom_sf()
# gera os mapas
poligono <- ggplot(sf_pr_polig)  +
  geom_sf() +
  ggtitle("Malha de municípios Paraná") +
  theme_minimal()

centroides <- ggplot(sf_pr_point)  +
  geom_sf() +
  #ggtitle() +
  theme_minimal()

ggpubr::ggarrange(poligono, centroides, ncol = 1, nrow = 2, align  = "hv")

# via base::plot()
plot(st_geometry(sf_pr_polig))
plot(sf_pr_point, add = TRUE, pch = 16, col = "red")

# via tmap::tm_shape()
#     **best one!**
library(tmap)
tm_shape(sf_pr_polig) + 
    tm_polygons(alpha = 0.5) +
    tm_dots()
 


### ............................................................................

                         # Matriz de contiguidade #

### ............................................................................

library(spdep)
micro <- read.gal("./Arquivos/shp/w/micro.gal", override.id = TRUE)
geoda <- read.gal("./Arquivos/shp1/br/5570_municipios2015.gal", override.id = TRUE)

nb2listw(micro, zero.policy=TRUE)

