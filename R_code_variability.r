#R_code_variability.r
#Faccio un'analisi di pattern spaziali tramite l'uso di indici del paesaggio: ghiacciao del Similaun
#osservo la variabilità spaziale
library(raster)
library(RStoolbox)

setwd("C:/lab/")

sent <- brick("sentinel.png")
#NIR 1, RED 2, GREEN 3
#r=1, g=2, b=3

plotRGB(sent) #non serve che riscrivo i comandi delle tre bande perché vanno di default insieme allo stretch lineare

#osservo l'acqua(nera)
plotRGB(sent, r=2, b=1, g=3, stretch="lin")
nir <- sent$sentinel.1
red <- sent$sentinel.2

ndvi <- (nir-red)/ (nir+red)
plot(ndvi) #dove è bianco non c'è vegetazione, 
#dove è rosato roccia nuda, 
#dove è giallo e verde è bosco, verde scuro le praterie

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)
plot(ndvi,col=cl)

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd) #roccia in blu (molto omogenea)

#media ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)
#valori alti nel giallo e più bassi nella parte di roccia nuda

#changing window size
ndvi13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvimean13, col=clsd)

#changing window size
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd5, col=clsd)

#PCA
sentpca <- rasterPCA(sent)
plot(sentpca$map)
#man mano che si passa da PC1 a PC4 si perdono le info
sentpca

summary(sentpca$model)
#the first PC contains 67.36804% of the original information

