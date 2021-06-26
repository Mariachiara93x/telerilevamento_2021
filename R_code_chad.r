#R_code_chad.r

library(raster)

setwd("C:/lab/CH")

chad1 <- brick("chad1973.jpg")
chad1
plot(chad1)

chad2 <- brick("chad1987.jpg")
chad2
plot(chad2)

chad3 <- brick("chad1997.jpg")
chad3
plot(chad3)

chad4 <- brick("chad2017.jpg")
chad4
plot(chad4)

#plotto con RGB un par delle 4 immagini
#osservo la riduzione del contenuto d'acqua all'interno del lago e contemporaneamente la variazione di vegetazione nel tempo
#b1=NIR, b2=rosso, b3=verde
par(mfrow=c(2,2))
plotRGB(chad1, r=1, g=2, b=3, stretch="lin")
plotRGB(chad2, r=1, g=2, b=3, stretch="lin")
plotRGB(chad3, r=1, g=2, b=3, stretch="lin")
plotRGB(chad4, r=1, g=2, b=3, stretch="lin")

#DIffERENCE VEGETATION INDEX ???
#osservo in che stato di salute è la vegetazione
#noto che la vegetazione è molto verde
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)


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





