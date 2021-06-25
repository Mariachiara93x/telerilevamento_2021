#R_code_no2.r
#Osservo la distribuzione e la concentrazione di NO2 

#1. Set the working directory EN
#Ho creato una cartella nominata EN all'interno di lab: al suo interno sono presenti file png
#i file sono relativi a immagini telerilevate ed elaborate
#questi mostrano la distribuzione e concentrazione di NO2 in Europa da Gennaio a Marzo 2020

setwd("C:/lab/EN")
library(raster)

#Importo la prima immagine (banda 1)

EN01 <- raster("EN_0001.png")
EN01
plot(EN01)

# creo una mia colorrampalette: il giallo rappresenta le zone di gennaio con no2 più elevato
cl <- colorRampPalette(c("light blue","light green","orange", "yellow")) (200)
plot(EN01, col=cl)

#importo l'ultima immagine (n°13) e la plotto

EN013 <- raster("EN_0013.png")
EN013
plot(EN013)

#plotto l'immagine EN013, utilizzando la colorrampalette creata da me prima
cl <- colorRampPalette(c("light blue","light green","orange", "yellow")) (200)
plot(EN013, col=cl)

# facccio la differenza tra la mappa di marzo (EN013) e quella di gennaio (EN01) e la plotto
ENdif <- EN013 - EN01
plot(ENdif, col=cl)
#avendo valori più bassi a marzo, noto che la differenza è in negativo (colore azzurrino)

#inverto, facendo gennaio - marzo
ENdif2 <- EN01 -EN013
plot(ENdif2, col=cl)
#in questo caso noto che la differenza si concentra nel colore arancio-giallo

#plotto tutte le immagini insieme
par(mfrow=c(3,1))
plot(EN01, col=cl, main="NO2 in January")
plot(EN013, col=cl, main="NO2 in March")
plot(ENdif2, col=cl, main="Difference (January - March)")

#Importo tutto il set di immagini
#per selezionare una lista di files utilizzo la funzione list.files, scegliendo un pattern comune a tutti ("EN")
#per importare il set di dati utilizzo la funzione lapply, applicando la funz raster a tutti gli elementi
rlist <- list.files(pattern="EN")
import <- lapply(rlist,raster)
import

#la funzione stack permette di raggruppare un numero di file raster tutti assieme in un unico blocco
#plotto lo stack creato nella colorramppalette utilizzata anche prima
EN <- stack(import)
plot(EN, col=cl)

# Replicare il plot dell'immagine 1 e 13 usando lo stack
# ossia, pesco le immagini 1 e 13 direttamente dallo stack e poi lo plotto con par
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

# Faccio una PCA relativamente alle 13 immagini
#per fare la PCA serve il pacchetto RStoolbox
library(RStoolbox)
ENpca<-rasterPCA(EN)
summary(ENpca$model)
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")
#gran parte dell'informazione è nella componente red: in rosso è ciò che si è mantenuto circa stabile all'interno del set di dati

#Calcola la variabilità (local standard deviation) della prima PCA
PC1sd <- focal (ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cl)
#osservo che la stadard deviation aumenta dove c'è la linea di separazione tra un Paese e l'altro



