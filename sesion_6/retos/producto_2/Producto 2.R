#Producto 2

setwd("~/ecoinformatica_2014_2015/sesion_6/retos/producto_2")
datos<-read.csv("robles_ecoinfo.csv", header = T, sep = ",", dec=".")
variables<- subset(datos, select=-c(x,y))
n_cluster<-3
cluster<-kmeans(variables,n_cluster, iter.max=200)
cluster[[1]]
cluster$size
resultado<-subset(datos,select=c(x,y))
head(resultado)
resultado<-cbind(resultado, cluster[[1]])
head(resultado)
str(resultado)
colnames(resultado)[3]<-"cluster"
head(resultado)
plot(resultado)

library(rgdal)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(datos) =~x+y
## definimos el sistema de coordenadas WGS84
proj4string(datos)=CRS("+init=epsg:23030")

## obtenemos n_cluster colores para una paleta de colores que se llama "Spectral", para cada cluster creado
plotclr <- rev(brewer.pal(n_cluster, "Spectral"))

## plot, asignando el color en función del cluster al que pertenece
plot(datos, col=plotclr[datos$cluster], pch=19, cex = .6, main = "Mapa de grupos de roble")



