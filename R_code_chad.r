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


#DIFFERENZA TRA CHAD 2017 E CHAD 1973

setwd("C:/lab/CH")
library(raster)
library(RStoolbox)

chad1 <- raster("chad1973.jpg")
chad1
plot(chad1)

cl <- colorRampPalette(c("dark blue","light blue","light green","orange", "yellow")) (200)
plot(chad1, col=cl)


chad3 <- raster("chad2017.jpg")
chad3
plot(chad3)

cl <- colorRampPalette(c("dark blue","light blue","light green","orange", "yellow")) (200)
plot(chad3, col=cl)

par(mfrow=c(1,2))
plot(chad1, col=cl1)
plot(chad3, col=cl2)

# faccio la differenza tra la mappa del 2017 (chad3) e quella del 1973 (chad1) e la plotto nella colorramppalette creata prima
CHdif1 <- chad3 - chad1
plot(CHdif1, col=cl)

#inverto, facendo 1973 - 2017
CHdif2 <- chad1 - chad3
plot(CHdif2, col=cl)

#questo par mi serve solo per osservare bene le due differenze messe a confronto
#noto che nella prima (CHdif1) la differenza si concentra nell' arancio-giallo (differenza in positivo poiché chad2017 ha valori più alti)
#nella seconda (CHdif2) la differenza si concentra nel colore azzurro (differenza in negativo che conferma che chad1973 ha valori inferiori)
par(mfrow=c(1,2))
plot(CHdif1, col=cl)
plot(CHdif2, col=cl)

#plotto tutte le immagini insieme per osservare:
#Chad Lake nel 1973, Chad Lake nel 2017 e differenza tra Chad Lake 2017 e Chad Lake 1973
par(mfrow=c(1,3))
plot(chad1, col=cl, main="Chad Lake in 1973")
plot(chad3, col=cl, main="Chad Lake in 2017")
plot(CHdif1, col=cl, main="Difference (2017 - 1973)")

#PCA
#importo tutto il set di immagini della cartella CH 
#tramite la funzione list.files visualizzo la lista dei file; scelgo un pattern comune ai file
#tramite la funzione lapply applico un'altra funzione (raster) alla lista di file
#con la funzione stack raggruppo un numero di file raster tutti assieme in un unico set
#plotto il set di dati 
#in questo modo ottengo un grafico con i 3 file direttamente presentati con il loro nome
rlist<- list.files(pattern="chad")
rlist
import<- lapply(rlist,raster)
import
CH <- stack(import)
plot(CH, col=cl)

#Faccio una PCA relativamente alle 3 immagini
#per fare la PCA serve il pacchetto RStoolbox
CHpca<-rasterPCA(CH)
summary(CHpca$model)
plotRGB(CHpca$map, r=1, g=2, b=3, stretch="lin")
PC1sd <- focal (CHpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cl)



#SPECTRAL SIGNATURES
library(raster)
setwd("C:/lab/CH")

#gdal è la libreria generale per dati geospaziali sia raster sia vettoriali
library(rgdal)
chad1 <- brick("chad1973.jpg")
plotRGB(chad1, r=1, g=2, b=3, stretch="hist")

click(chad1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

# x     y   cell       chad1973.1 chad1973.2 chad1973.3
#1 215.5 367.5 138720          3         55         76
#       x     y   cell chad1973.1 chad1973.2 chad1973.3
#1 232.5 218.5 242441          7         45         58
#x     y   cell chad1973.1 chad1973.2 chad1973.3
#1 354.5 124.5 307987          6         71         73

#PUNTO 1 N
#riflettanza banda 1 = 3 (IR)
#riflettanza banda 2 = 55 (red) 
#riflettanza banda 3 = 76 (green)

#PUNTO 2 Centro-W
#riflettanza banda 1 = 7 (IR)
#riflettanza banda 2 = 45 (red) 
#riflettanza banda 3 = 58 (green)

#PUNTO 3 S
#riflettanza banda 1 = 6 (IR)
#riflettanza banda 2 = 71 (red) 
#riflettanza banda 3 = 73 (green)


chad2 <- brick("chad1987.jpg")
plotRGB(chad2, r=1, g=2, b=3, stretch="hist")

click(chad2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
#x     y   cell chad1987.1 chad1987.2 chad1987.3
#1 213.5 367.5 138718        150        105         82
#      x     y   cell chad1987.1 chad1987.2 chad1987.3
#1 231.5 219.5 241744         25          4          3
# x     y   cell chad1987.1 chad1987.2 chad1987.3
#1 353.5 123.5 308682        165         31         20

#PUNTO 1 N
#riflettanza banda 1 = 150 (IR)
#riflettanza banda 2 = 105 (red) 
#riflettanza banda 3 = 82 (green)

#PUNTO 2 Centro-W
#riflettanza banda 1 = 25 (IR)
#riflettanza banda 2 = 4 (red) 
#riflettanza banda 3 = 3 (green)

#PUNTO 3 S
#riflettanza banda 1 = 165 (IR)
#riflettanza banda 2 = 31 (red) 
#riflettanza banda 3 = 20 (green)
    

chad3 <- brick("chad2017.jpg")
plotRGB(chad3, r=1, g=2, b=3, stretch="hist")

click(chad3, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
  #x     y   cell chad2017.1 chad2017.2 chad2017.3
#1 215.5 367.5 138720        175         15         49
  #x     y   cell chad2017.1 chad2017.2 chad2017.3
#1 232.5 218.5 242441        164         29         59
    #  x     y   cell chad2017.1 chad2017.2 chad2017.3
#1 354.5 124.5 307987         19         58         73

#PUNTO 1 N
#riflettanza banda 1 = 175 (IR)
#riflettanza banda 2 = 15 (red) 
#riflettanza banda 3 = 49 (green)

#PUNTO 2 Centro-W
#riflettanza banda 1 = 164 (IR)
#riflettanza banda 2 = 29 (red) 
#riflettanza banda 3 = 59 (green)

#PUNTO 3 S
#riflettanza banda 1 = 19 (IR)
#riflettanza banda 2 = 58 (red) 
#riflettanza banda 3 = 73 (green)




