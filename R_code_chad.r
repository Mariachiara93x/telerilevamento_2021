#R_code_chad.r

library(raster)

setwd("C:/lab/CH")

chad1 <- raster("chad1973.jpg")
chad1
plot(chad1)

chad2 <- raster("chad1987.jpg")
chad2
plot(chad2)

chad3 <- raster("chad1997.jpg")
chad3
plot(chad3)

chad4 <- raster("chad2001.jpg")
chad4
plot(chad4)

#tramite la funzione list.files visualizzo la lista dei file; scelgo un pattern comune ai file
#tramite la funzione lapply applico un'altra funzione (raster) alla lista di file
#con la funzione stack raggruppo un numero di file raster tutti assieme in un unico set
#plotto il set di dati 
#in questo modo ottengo un grafico con i 4 file direttamente presentati con il loro nome
rlist<- list.files(pattern="chad")
rlist
import<- lapply(rlist,raster)
import
ch<- stack(import)
plot(ch)
