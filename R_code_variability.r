#R_code_variability.r
#Faccio un'analisi di pattern spaziali tramite l'uso di indici del paesaggio: ghiacciao del Similaun
#osservo la variabilità spaziale
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra) # per plottare ggplot insieme
install.packages("viridis")
library(viridis) # per colorare i plot di ggplot in modo automatico

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

pc1 <- sentpca$map$PC1

pc1sd5 <- focal(pc1, w=matrix,(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(pc1sd5, col=clsd)

source("source_test_lezione.r")

source("source_ggplot.r")

ggplot() +
p1<-geom_raster(pc1sd5, mapping = aes(x= x, y= y, fill=layer)) +
scale_fill_viridis()
ggtitle("Standard deviation of PC1 by viridis colour scale")

ggplot() +
p2<-geom_raster(pc1sd5, mapping = aes(x= x, y= y, fill=layer)) +
scale_fill_viridis(option= "magma")
ggtitle("Standard deviation of PC1 by magma colour scale")

ggplot() +
p3<-geom_raster(pc1sd5, mapping = aes(x= x, y= y, fill=layer)) +
scale_fill_viridis(option= "turbo") +
ggtitle("Standard deviation of PC1 by turbo colour scale")

grid.arrange(p1,p2,p3, nrow=2)
