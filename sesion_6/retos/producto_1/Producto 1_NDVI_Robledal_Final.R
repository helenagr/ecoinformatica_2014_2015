#MI DIRECTORIO DE TRABAJO.
setwd("~/ecoinformatica_2014_2015/sesion_6/retos/producto_1")

library(Kendall)

#ANÁLISIS DE TENDENCIAS DEL NDVI.
datos1<-read.csv("ndvi_robledal.csv", sep=";", header=T)
tendencia_ndvi<-data.frame()
tendencia_aux<-data.frame(iv_malla_modi_id=NA,tau_ndvi=NA,pvalor_ndvi=NA)
pixels<-unique(datos1$iv_malla_modi_id)
for(i in pixels){
  aux<-datos1[datos1$iv_malla_modi_id==i,]
  Kendall<-MannKendall(aux$ndvi_i)
  tendencia_aux$iv_malla_modi_id<-i
  tendencia_aux$tau_ndvi<-Kendall[[1]][1]
  tendencia_aux$pvalor_ndvi<-Kendall[[2]][1]
  tendencia_ndvi<-rbind(tendencia_ndvi,tendencia_aux)
}
head(tendencia_ndvi)

library(plyr)

##TRATANDO DATOS DATAFRAME_NDVI:
datos1<-datos1[,c(1,4,5)]
unique_datos1<-unique(datos1)
resultado1<-join(unique_datos1,tendencia_ndvi, by="iv_malla_modi_id")
head(resultado1)

##PINTAR MAPA NDVI_ROBLEDAL:
library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)
coordinates(resultado1) =~lng+lat
proj4string(resultado1)=CRS("+init=epsg:4326")
clases <- classIntervals(resultado1$tau_ndvi, n = 5)
plotclr <- rev(brewer.pal(5, "Spectral"))
colcode <- findColours(clases, plotclr)
plot(resultado1, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias de ndvi en robledal")
legend("topright",legend=names(attr(colcode, "table")), fill=attr(colcode, "palette"), bty="n")
