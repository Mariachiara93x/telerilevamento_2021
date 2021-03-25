# Il mio primo codice in R per il telerilevamento!

#install.packages ("raster")
library(raster)

setwd("C:/lab/") # Windows

#Questa funzione serve a importare un'immagine satellitare
p224r63_2011 <- brick ("p224r63_2011_masked.grd.")
p224r63_2011

plot(p224r63_2011)


# colour change
cl <- colorRampPalette(c("black","grey","light grey")) (100)

plot(p224r63_2011, col=cl)


# colour change -> new
cl <- colorRampPalette(c("pink", "light blue", "dark green", "purple", "orange", "dark red")) (200)
plot(p224r63_2011, col=cl)

### DAY 3
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# dev.off pulirà la finestra grafica
dev.off()

plot(p224r63_2011$B1_sre)

# plot band 1 with predefined colourramppalette
cl <- colorRampPalette(c("pink", "light blue", "dark green", "purple", "orange", "dark red")) (200)
plot(p224r63_2011$B1_sre, col=cl)

#creo il multiframe di B1 e B2, 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#creo il multiframe di B1 e B2, 2 rows, 1 column
par(mfrow=c(2,1)) #se uso prima le colonne: par(mfcol...)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot the first four bands of Landsat (4 columns, 1 row)
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#plot the first four bands of Landsat (2 columns, 2 rows)
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#plotto la prima banda di Landsat
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

#aggiungo al plot della prima banda, il plot della seconda
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

#aggiungo al plot della prima e della seconda banda, il plot della terza
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

#aggiungo al plot della prima, seconda e terza banda, il plot della quarta 
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)





