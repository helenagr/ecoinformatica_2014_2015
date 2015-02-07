#Reto 3_p2

numeros<-c(5,10,20,3,1,6,19,2,16,7) 
umbral<-15  
contador<-0
k<-1
for(k in numeros)
{
  if(k>umbral)
  {
    contador<-contador+1
  }  
}
print (contador)
