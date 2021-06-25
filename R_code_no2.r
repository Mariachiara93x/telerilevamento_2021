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
