#R_code_copernicus.r
#Visualizing Copernicus data
#utilizzo il programma Copernicus per visualizzare dati relativi a variabili bio-geofisiche della superficie terrestre

#installo il pacchetto ncdf4 per leggere il formato netCDF
install.packages("ncdf4")
library(raster)
library(ncdf4)

setwd("C:/lab/") 

criosfera <- raster ("c_gls_SCE500_202104150000_CEURO_MODIS_V1.0.1.nc")

cl <- colorRampPalette(c("light blue", "red", "green", "orange")) (200)
plot(criosfera, col=cl)

#Resampling
#utilizzo la funzione aggregate per portare l'immagine ad un numero inferiore di pixel
#in questo modo l'immagine sarà meno pesante
#utilizzo il fattore "fact=10" per diminuire linearmente di 10 volte
#in questo modo, ogni 10 pixel avrò 1 solo pixel
criosferares <- aggregate(criosfera, fact=10)
plot(criosferares, col=cl)
