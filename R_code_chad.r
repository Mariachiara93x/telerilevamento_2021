#R_code_chad.r

library(raster)

setwd("C:/lab/CH")


chad1 <- brick("chad1973.jpg")
chad1
plot(chad1)

chad2 <- brick("chad1987.jpg")
chad2
plot(chad2)

chad3 <- brick("chad2017.jpg")
chad3
plot(chad3)

#plotto con RGB un par delle 4 immagini
#osservo nel tempo una generale riduzione del contenuto d'acqua all'interno del lago e contemporaneamente un aumento della vegetazione 
#il colore rosso nelle immagini rappresenta la vegetazione, il grigio-azzurro l'acqua
#b1=NIR, b2=rosso, b3=verde
par(mfrow=c(2,2))
plotRGB(chad1, r=1, g=2, b=3, stretch="lin")
plotRGB(chad2, r=1, g=2, b=3, stretch="lin")
plotRGB(chad3, r=1, g=2, b=3, stretch="lin")


#DIffERENCE VEGETATION INDEX
#osservo in che stato di salute è la vegetazione

#calcolo il DVI per l'anno 1973
#NIR - RED
dvi1 <- chad1$chad1973.1 - chad1$chad1973.2
plot(dvi1)

#color change dvi 1973
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI in 1973")

#calcolo il DVI per l'anno 1987
dvi2 <- chad2$chad1987.1 - chad2$chad1987.2
plot(dvi2)

#color change dvi 1987
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI in 1987")

#calcolo il DVI per l'anno 2017
dvi3 <- chad3$chad2017.1 - chad3$chad2017.2
plot(dvi3)

#color change dvi 2017
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi3, col=cl, main="DVI in 2017")

#tramite un par osservo i differenti DVI nei tre anni
par(mfrow=c(2,2))
plot(dvi1, col=cl, main="DVI in 1973")
plot(dvi2, col=cl, main="DVI in 1987")
plot(dvi3, col=cl, main="DVI in 2017")

#calcolo la differenza di DVI tra l'anno 2017 e il 19
difdvi <- dvi1-dvi3

cld <- colorRampPalette(c('blue','light blue','white','yellow','red'))(300)
plot(difdvi, col=cld)

#ndvi
# (NIR-RED) / (NIR+RED)
ndvi1 <- (chad1$chad1973.1 - chad1$chad1973.2) / (chad1$chad1973.1 + chad1$chad1973.2)
plot(ndvi1, col=cl, main="NDVI in 1973")

ndvi2 <- (chad2$chad1987.1 - chad2$chad1987.2) / (chad2$chad1987.1 + chad2$chad1987.2)
plot(ndvi2, col=cl, main="NDVI in 1987")

ndvi3 <- ( chad3$chad2017.1 - chad3$chad2017.2) / ( chad3$chad2017.1 + chad3$chad2017.2)
plot(ndvi2, col=cl,main="NDVI in 2017")

par(mfrow=c(2,2))
plot(ndvi1, col=cl, main="NDVI in 1973") 
plot(ndvi2, col=cl, main="NDVI in 1987")
plot(ndvi3, col=cl, main="NDVI in 2017")
#per immagine 1973 osservo: valori NDVI da -1 a -0.4 (presenza di acqua nel lago); ai bordi nella zona SE valori vicini a 0.5
#per immagine 1987 osservo: valori NDVI circa 0.4 (rimanenza lago a SE); intorno al lago a SE valore 1 (fitta vegetazione)
#per immagine 2017 osserv0: valori NDVI vicini a -1 (rimanenza lago a SE); il resto del lago riporta valori tra 0.5 e 1 (aumenta superfice vegetativa)
####################

plot(ndvi1, ndvi3, col="red", pch=18, cex=2)#non va, perché???


#PCA
#SPECTRAL SIGNATURES

#tramite la funzione list.files visualizzo la lista dei file; scelgo un pattern comune ai file
#tramite la funzione lapply applico un'altra funzione (raster) alla lista di file
#con la funzione stack raggruppo un numero di file raster tutti assieme in un unico set
#plotto il set di dati 
#in questo modo ottengo un grafico con i 4 file direttamente presentati con il loro nome
library(rasterVis)#necessaria per levelplot

rlist<- list.files(pattern="chad")
rlist
import<- lapply(rlist,brick)
import
ch <- stack(import)
levelplot(ch) 





