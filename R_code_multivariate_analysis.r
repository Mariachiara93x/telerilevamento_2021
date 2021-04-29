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
