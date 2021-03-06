#R_code_vegetation_indices.r

library(raster)
setwd("C:/lab/")

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#plotto con RGB un par di entrambe le immagini
#osservo la variazione di vegetazione nel tempo
#b1=NIR, b2=rosso, b3=verde
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#visualizzo informazioni su immagine defor1
defor1

#DIffERENCE VEGETATION INDEX
#osservo in che stato di salute è la vegetazione
#noto che la vegetazione (foresta amazzonica) è molto verde
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")

#osservo il cambiamento della vegetazione nella foresta amazzonica
#si nota un'importante deforestazione
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

difdvi <- dvi1-dvi2

cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

#ndvi
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)


ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)
 
#RStoolbox: spectralIndices
library(RStoolbox)# for vegetation indices calculation
vi1<- spectralIndices (defor1, green=3, red=2, nir=1)
plot (vi1, col=cl)

vi2<- spectralIndices (defor2, green=3, red=2, nir=1)
plot (vi2, col=cl)

difndvi <- ndvi1 -ndvi2
plot(difndvi)

#5 MAGGIO
#il pacchetto rasterdiv contiene un dataset globale derivato da Copernicus 
#nel dataset globale è presente una media di valori di NDVI dal 1999 al 2017 
#in pratica osservo quanta biomassa è presente sulla Terra
install.packages("rasterdiv")
library(rasterdiv)

#worldwide NDVI
#plottando copNDVI ottengo una mappa globale in cui è visibile l'acqua
plot(copNDVI)

# per eliminare l'acqua utilizzo l'argomento cbind della funzione reclassify
#in pratica i pixel 253,254,255 possono essere trasformati in NA (= not assigned = "non valori")
#il : serve a dare il range di valori dei pixel
copNDVI<-reclassify(copNDVI, cbind (253:255,NA))
plot(copNDVI)
#noto in nord america e nord europa un NDVI più alto

#richiamo la libreria rasterVis per fare un levelplot dell'immagine precedentemente plottata
library(rasterVis)
levelplot(copNDVI)
#osservo la variazione di NDVI dal '99 al 2017 
#i valori massimi si trovano all'equatore perché c'è il massimo di luce
