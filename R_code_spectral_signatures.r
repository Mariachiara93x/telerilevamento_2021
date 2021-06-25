#R_code_spectral_signatures.r
# la firma spettrale è una sorta di impronta digitale della relativa specie di un organismo, habitat, roccia, minerale, ecc
# è specifica per ogni combinazione di riflessi e assorbimenti delle radiazioni elettromagnetiche (EM) a diverse lunghezze d'onda.

library (raster)
setwd("C:/lab/")

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist") # differenze dei colori più accentuate con hist, perché uso curva logistica anziché linea

#gdal è la libreria generale per dati geospaziali sia raster che vettoriali
library(rgdal)

# utilizzo la funzione click per cliccare su una mappa e ottenere informazioni relative a quel punto
# in questo caso, le info sono relative alla riflettanza
#T= true
#id= argomento che stabilisce se voglio creare un identificativo per ogni punto
#xy= arg che indica che vogliamo utilizzare un'informazione parziale
#cell= arg che indica che clicco su un pixel
#type= arg che indica il tipo di click, in questo caso il "punto, p"
#pch= arg che indica lo stile del punto
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#RESULTS
#cliccando su un punto rosso (vegetato) ottengo i seguenti valori:
# x     y  cell defor2.1 defor2.2 defor2.3
#1 90.5 438.5 28054      210       12       27
#riflettanza banda 1 = 210 (IR)
#riflettanza banda 2 = 12 (red) (assorbe molto)
#riflettanza banda 3 = 27 (green)

#clicco su punto nel fiume e ottengo i seguenti valori:
# x     y   cell defor2.1 defor2.2 defor2.3
#1 562.5 227.5 179813       45       81      105

#CREO TABELLA
#b= banda (prima colonna); F= foresta(seconda colonna); w= acqua (terza colonna)
#per "forest" e "water" riporto i valori ottenuti in precedenza tramite il click
band <- c(1,2,3)
forest <- c(210,12,27)
water <- c(45,81,105)

#utilizzo la funzione data.frame per creare la tabella
data.frame(band,forest, water)
spectrals <- data.frame(band,forest, water)

#PLOTTO LA FIRMA SPETTRALE (SPECTRAL SIGNATURES)
library(ggplot2)
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=forest), color="green") #inserisce le geometrie nel plot (ad. es linee)
#ottengo grafico in cui osservo la riflettanza di un singolo pixel nelle tre bande
#alta riflettanza in banda 1
#bassa riflettanza in banda 2
#media riflettanza nella banda 3

#aggiungo il ggplot della componente water
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=forest), color="green") +
geom_line (aes(y=water), color="blue") 
#osservo come l'acqua abbia un comportamento nettamente opposto rispetto alla vegetazione
#(in questo caso non è acqua pura, ci sono anche solidi disciolti)

ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=forest), color="green") +
geom_line (aes(y=water), color="blue") +
labs(x="band", y="reflactance") #rinomino i due assi

#SPECTRAL SIGNATURES defor1
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#  x     y  cell defor1.1 defor1.2 defor1.3
#1 43.5 339.5 98576      227       13       39
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 61.5 342.5 96452      183       13       22
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 78.5 333.5 102895      214       22       37
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 76.5 369.5 77189      231       24       44
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 80.5 406.5 50775      230       27       47

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#   x     y  cell defor2.1 defor2.2 defor2.3
#1 90.5 338.5 99754      186      149      141
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 106.5 325.5 109091      181      123      122
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 103.5 353.5 89012      190      177      161
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 123.5 367.5 78994      174      182      158
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 85.5 321.5 111938      186      176      166

#creo le colonne del dataset
band <- c(1,2,3)
time1 <-c(227,13,39) #valori riflettanza nelle bande di defor1
time2 <- c(186,149,141) #valori riflettanza nelle bande di defor2

spectralst <- data.frame(band, time1, time2)
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=time1), color="red") +
geom_line (aes(y=time2), color="grey") +
labs(x="band", y="reflactance") 

#inserisco anche i dati dei secondi punti, rispettivamente per defor1 e defor 2
band <- c(1,2,3)
time1 <-c(227,13,39)
time1p2 <- c(183,13,22)
time2 <- c(186,149,141)
time2p2 <- c(181,123,122)

spectralst <- data.frame (band, time1,time2,time1p2, time2p2)

ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=time1), color="red", linetype="dotted") +
geom_line (aes(y=time1p2), color="red",linetype="dotted") +
geom_line (aes(y=time2), color="green",linetype="dotted") +
geom_line (aes(y=time2p2), color="green",linetype="dotted") +
labs(x="band", y="reflactance") 

#IMMAGINE DA EARTH OBSERVATORY

stromboli <- brick("stromboli.jpg")
plotRGB(stromboli, 1,2,3, stretch="hist")
click(stromboli, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#OUTPUT; scelgo tre punti nell'immagine dello stromboli
# x     y  cell stromboli.1 stromboli.2 stromboli.3    ######zona gialla (fianco NE)
# 1 312.5 439.5 72313          46          72          63
# x     y  cell stromboli.1 stromboli.2 stromboli.3    ######zona rosso-marrone (Sciara del Fuoco)
# 1 225.5 408.5 94546           1           6          26
# x     y   cell stromboli.1 stromboli.2 stromboli.3   ######zona bianca (cratere)
#1 249.5 350.5 136330         210         209         207
# x     y   cell stromboli.1 stromboli.2 stromboli.3   ######zona blu (mare)
#1 160.5 120.5 301841           2          20          56

#creo il set di colonne
band <- c(1,2,3)
zona1 <- c(46,72,63)
zona2 <- c(1,6,26)
zona3 <- c(210,209,207)
zona4 <- c(2,20,56)

spectralsgeo <- data.frame (band, zona1, zona2, zona3, zona4)

ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=zona1), color="yellow") +
geom_line (aes(y=zona2), color="green") +
geom_line (aes(y=zona3), color="red") +
geom_line (aes(y=zona4), color="blue") +
labs(x="band", y="reflactance") 




