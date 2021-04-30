#R_code_multivariate_analysis.r
#utilizzo l'ANALISI MULTIVARIATA nel caso in cui ho tante bande a disposizione, ma un'informazione molto correlata (all'aumentare di riflettanza di banda x aumenta anche quella di banda y)
#compatto dati per vedere tutti il sistema insieme in poche bande
#riesco a compattare perché in pratica scelgo di utilizzare una banda che spieghi una quantità maggiore di variabilità

library(raster)
library(RStoolbox)

setwd("C:/lab/")
#scelgo l'immagine della riserva del Parakana (p224r63_2011_masked.grd)
#utilizzo la funzione brick per caricare un set multiplo di dati 
#associo la funzione brick con l'immagine al nome e poi plotto
p224r63_2011<- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
#visualizzo le varie informazioni sull'immagine
p224r63_2011

#creo un grafico plottando i valori dei pixel della banda 1 contro i valori dei pixel della banda 2
#utilizzo il $ per legare la B1 all'immagine, poiché si trova all'interno del dataset p224r63_2011
#faccio lo stesso per la B2
#scelgo colore dei punti plottati con col
#scelgo il tipo dei punti plottati con pch
#scelgo l'esagerazione della dimensione dei punti con cex
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=18, cex=2)
#noterò due informazioni molto correlate
#ossia, l'informazione di un punto è molto simile all'informazione di un altro punto in un'altra banda

#uso PAIRS per plottare tutte le correlazioni possibili tra tutte le variabili di un dataset
#vedo a coppie come le variabili (ossia le bande) sono correlate fra loro
#applico pairs all'immagine
#è presente indice di correlazion che varia tra -1 e 1
#se c'è correlazione positiva va a 1, al contrario a -1
pairs(p224r63_2011)

#28/04
library(raster)
library(RStoolbox)

setwd("C:/lab/")
p224r63_2011<- brick("p224r63_2011_masked.grd")
p224r63_2011
pairs(p224r63_2011)

#AGGREGATE CELLS
#utilizzo la funzione AGGREGATE per diminuire la risoluzione dell'immagine, aumentando la dimensione del pixel
#questo processo si chiama resampling
#quindi associo la funzione aggregate con fattore 10 all'oggetto sotto indicato
p224r63_2011res<-aggregate(p224r63_2011, fact=10)
#da risoluzione iniziale di 30x30m, riduco a 300x300m
p224r63_2011res

#applico par per vedere le due immagini insieme
#la prima avrà una risoluzione più alta della seconda
par(mfrow=c(2,1))
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="lin")
plotRGB(p224r63_2011res,r=4,g=3,b=2, stretch="lin")

#faccio la PCA del dataset p224r63_2011res
#questo dataset contiene al suo interno il modello, la mappa, ecc
#prende pacchetto di dati e lo compatta in un numero minore di bande
p224r63_2011res_pca<-rasterPCA(p224r63_2011res)
#applico la funzione SUMMARY per ottenere un sommario del modello
#con la prima componente viene spiegato lo 99,98% della variabilità
#con le prime tre bande viene spiegato lo 99,99% della variabilità
summary(p224r63_2011res_pca$model)
#plottando la mappa osservo infatti che nella PC1 ho tante informazioni
#nella PC7 c'è molto rumore
plot(p224r63_2011res_pca$map)
#visualizzo le informazioni riguardo all'immagine
p224r63_2011res_pca

#plotto la mappa risultante dal modello
#i tre colori sono relativi alle tre componenti
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")



