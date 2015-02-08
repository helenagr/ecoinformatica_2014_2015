setwd("~/ecoinformatica_2014_2015/sesion_3/retos")
library (raster)

horas <-c('12','13','14','15') # introduciendo horas
valores<-c() # generando vector asociado a valores

# umbral<-0.15

for(index in horas)
{
  cat(paste("Procesando hora", index,"\n"))
  
  imagenes <- list.files(path="~/ecoinformatica_2014_2015/sesion_3/retos/sesion_3/retos/reto_3_p4", full.names = TRUE,recursive=TRUE,
                         pattern=paste("_",index, "..\\.jpg\\.asc$", sep=""))
  imagen <-stack(imagenes)
  
  media <- mean(imagen)
  
  valores <- rbind(valores, mean(media[]))
}

plot(valores)