#R code compete - Telerilevamento Geo-Ecologico
#..............................................

#Summary:

#1. Remote sensing - first code

#..............................................

# Il mio primo codice in R per il telerilevamento!

#install.packages ("raster")
library(raster)

setwd("C:/lab/") # Windows

#Questa funzione serve a importare un'immagine satellitare
p224r63_2011 <- brick ("p224r63_2011_masked.grd.") #brick 
p224r63_2011

plot(p224r63_2011) #tramite la funzione plot posso visualizzare l'immagine direttamente su R


# colour change: cambio colore utilizzando la funzione colorRampPalette selezionando le tonalità nero-grigio
cl <- colorRampPalette(c("black","grey","light grey")) (100)

plot(p224r63_2011, col=cl)


# colour change -> new: scelgo dei colori a piacimento variando anche i livelli (da 100 a 200)
cl <- colorRampPalette(c("pink", "light blue", "dark green", "purple", "orange", "dark red")) (200)
plot(p224r63_2011, col=cl)

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

plot(p224r63_2011$B1_sre)#visualizzo l'immagine nella banda del BLU utlizzando il simbolo $ che serve a collegare un blocco ad un altro

# plot band 1 with predefined colourramppalette
cl <- colorRampPalette(c("pink", "light blue", "dark green", "purple", "orange", "dark red")) (200)
plot(p224r63_2011$B1_sre, col=cl)

#creo il multiframe di B1 e B2, 1 row, 2 columns: potrò visualizzare tramite la funzione par, la stessa immagine due volte, una nella banda del blu, l'altra nella banda del verde
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#creo il multiframe di B1 e B2, 2 rows, 1 column: modifico la vizualizzazione delle due immagini variando il numero di righe e colonne
par(mfrow=c(2,1)) #se uso prima le colonne: par(mfcol...)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot the first four bands of Landsat (4 columns, 1 row): visualizzo l'immagine nelle 4 bande, scegliendo l'opzione 4 rows 1 column
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#plot the first four bands of Landsat (2 columns, 2 rows): visualizzo l'immagine nelle 4 bande, scegliendo l'opzione 2 rows 2 columns
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#plotto la prima banda di Landsat (BLU): utilizzo la funzione colourramppalette per selezionare le tonalità del BLU
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

#aggiungo al plot della prima banda (BLU), il plot della seconda(VERDE): utilizzo la funzione colourramppalette per selezionare le tonalità del VERDE
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

#aggiungo al plot della prima (BLU) e della seconda banda (VERDE), il plot della terza (ROSSO): utilizzo la funzione colourramppalette per selezionare le tonalità del ROSSO
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

#aggiungo al plot della prima (BLU), seconda (VERDE) e terza banda (ROSSO), il plot della quarta (NIR):  utilizzo la funzione colourramppalette per selezionare delle tonalità a piacimento 
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

#Visualizing data by RGB
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#Utilizzo schema RGB con il quale visualizzo tre bande alla volta -> spiega stretch
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# Exercise: mount a 2x2 multiframe: tramite la funzione par visualizzo contemporaneamente, scegliendo l'opzione 2 row 2 colums, le quattro immagini precedentemente plottate con RGB
pdf("il_mio_primo_pdf_con_r.pdf") #salvare plot come pdf
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #visualizzo 

#par natural colours, false colours and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#Multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988

plot(p224r63_1988)
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#hist
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
