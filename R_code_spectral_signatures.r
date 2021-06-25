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
1 90.5 438.5 28054      210       12       27
#riflettanza banda 1 = 210 (IR)
#riflettanza banda 2 = 12 (red) (assorbe molto)
#riflettanza banda 3 = 27 (green)

#clicco su punto nel fiume e ottengo i seguenti valori:
# x     y   cell defor2.1 defor2.2 defor2.3
1 562.5 227.5 179813       45       81      105


