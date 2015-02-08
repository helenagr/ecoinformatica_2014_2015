library(Kendall)

datos2<-read.csv("nieve_robledal.csv", sep=";", header=T)
tendencia_nieve<-data.frame()
tendencia_aux_nieve<-
  data.frame(nie_malla_modi_id=NA,tau_nieve=NA,pvalor_nieve=NA)
pixels<-unique(datos2$nie_malla_modi_id)
for(i in pixels){
  aux<-datos2[datos2$nie_malla_modi_id==i,]
  Kendall<-MannKendall(aux$scd)
  tendencia_aux_nieve$nie_malla_modi_id<-i
  tendencia_aux_nieve$tau_nieve<-Kendall[[1]][1]
  tendencia_aux_nieve$pvalor_nieve<-Kendall[[2]][1]
  tendencia_nieve<-rbind(tendencia_nieve,tendencia_aux_nieve)
}
head(tendencia_nieve)

library(plyr)

##Tratando datos para tener el dataframe adecuado(nieve)
datos2<-datos2[,c(2,10,11)]
unique_datos2<-unique(datos2)
resultado2<-join(unique_datos2,tendencia_nieve, by="nie_malla_modi_id")
head(resultado2)

##Pintamos mapa nieve robledal:

resultado2$significativa <- ifelse(resultado2$pvalor_nieve< 0.05, 1, 2)
plot(resultado2, col=colcode, pch=c(17, 19)[as.numeric(resultado2$significativa)], cex = .6, main = "Mapa de tendencias")
legend("topright", legend=names(attr(colcode, "table")), fill=attr(colcode, "palette"), bty="n")

