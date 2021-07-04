#R_code_chad.r
#"Lake Chad sustains people, animals, fishing, irrigation, and economic activity in west-central Africa. 
#But in the past half century, the once-great lake has lost most of its water and now spans less than a tenth of the area it covered in the 1960s. 
#Scientists and resource managers are concerned about the dramatic loss of fresh water that is the lifeblood of more than 30 million people.

#The Chad Basin sits within the Sahel, a semiarid strip of land dividing the Sahara Desert from the humid savannas of equatorial Africa. 
#The basin is bordered by mountain ranges and spans more than 2.4 million square kilometers of Cameroon, Nigeria, Chad, and Niger. 
#The water level in the lake is largely controlled by the inflow from rivers, notably the Chari from the south and, seasonally, the Komodugu-Yobe from the northwest. 
#Rainfall can also reach the lake by way of smaller tributaries and groundwater discharge.(...)
#Extreme swings in Lake Chad’s water levels are not new. The lake has experienced wet and dry periods for thousands of years, according to paleoclimate research.(...)
#In 1973, the lake was in a phase called “Normal Lake Chad”—a single body of water with an archipelago on the north side of the southern basin.(...)
#Throughout the 1970s, severe droughts plagued the African Sahel, and water disappeared from the northern basin. Since then, water has come and gone from the northern lobe depending on the year and season. 
#But the two lobes have never reconnected into a single lake."
#from Earth Observatory

library(raster)

setwd("C:/lab/CH")
#importo le tre immagini del Lago Chad (in falso colore) telerilevate rispettivamente da Landsat 1 (1973), Landsat 5 (1987) e Landsat 8 in 2017
#le immagini sono state scaricate da Earth Observatory (https://earthobservatory.nasa.gov/features/LakeChad)

#utilizzo la funzione brick per importare tutte le bande disponibili (tre per ciascuna immagine in questo caso)
chad1 <- brick("chad1973.jpg")
chad1
plot(chad1)

chad2 <- brick("chad1987.jpg")
chad2
plot(chad2)

chad3 <- brick("chad2017.jpg")
chad3
plot(chad3)

#plotto con RGB un par delle 3 immagini
#osservo nel tempo una generale riduzione del contenuto d'acqua all'interno del lago e contemporaneamente un aumento della vegetazione 
#il colore rosso nelle immagini rappresenta la vegetazione, il grigio-azzurro l'acqua
#b1=NIR, b2=rosso, b3=verde
par(mfrow=c(2,2))
plotRGB(chad1, r=1, g=2, b=3, stretch="lin")
plotRGB(chad2, r=1, g=2, b=3, stretch="lin")
plotRGB(chad3, r=1, g=2, b=3, stretch="lin")

#NDVI
#calcolo NDVI per le tre immagini per ottenere informazioni sullo stato della vegetazione
#(NIR-RED) / (NIR+RED)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
ndvi1 <- (chad1$chad1973.1 - chad1$chad1973.2) / (chad1$chad1973.1 + chad1$chad1973.2)
plot(ndvi1, col=cl, main="NDVI in 1973")
ndvi2 <- (chad2$chad1987.1 - chad2$chad1987.2) / (chad2$chad1987.1 + chad2$chad1987.2)
plot(ndvi2, col=cl, main="NDVI in 1987")
ndvi3 <- ( chad3$chad2017.1 - chad3$chad2017.2) / ( chad3$chad2017.1 + chad3$chad2017.2)
plot(ndvi3, col=cl,main="NDVI in 2017")

#faccio un par delle tre immagini per confrontare i valori NDVI
par(mfrow=c(2,2))
plot(ndvi1, col=cl, main="NDVI in 1973") 
plot(ndvi2, col=cl, main="NDVI in 1987")
plot(ndvi3, col=cl, main="NDVI in 2017")
#per immagine 1973 osservo: valori NDVI da -1 a -0.6 (presenza di acqua nel lago - blu scuro ); ai bordi nella zona SE valori vicini a 0.5 (vegetazione), giallo= mix acqua/sedimento
#per immagine 1987 osservo: valori NDVI circa -0.3 -0.6 (rimanenza lago a SE, blu-giallo= acqua/sedimento/(vegetazione)); intorno al lago a SE valore 1 (fitta vegetazione)
#per immagine 2017 osservo: valori NDVI di -1 (rimanenza lago a SE); il resto del lago riporta valori tra 0.5 e 1 (aumenta superfice vegetativa)


#TIME SERIES ANALYSIS: LAKE CHAD 2017 (chad3) E LAKE CHAD 1973 (chad1)

#utilizzo la funzione raster per richiamare solo la prima banda
chad1 <- raster("chad1973.jpg")
chad1 

#imposto una colorramppalette a scelta
cl <- colorRampPalette(c("dark blue","light blue","light green","orange","yellow")) (200)
plot(chad1, col=cl)

chad3 <- raster("chad2017.jpg")
chad3 
plot(chad3, col=cl)

#faccio la differenza tra la mappa del 2017 (chad3) e quella del 1973 (chad1) e la plotto nella colorramppalette creata prima
CHdif1 <- chad3 - chad1
plot(CHdif1, col=cl)

#inverto, facendo 1973 - 2017 (solo per fare una "prova del 9")
CHdif2 <- chad1 - chad3
plot(CHdif2, col=cl)

#(questo par mi serve solo per osservare le due differenze messe a confronto)
#noto che nella prima (CHdif1) la differenza si concentra nell' arancio-giallo (differenza in positivo poiché chad2017 ha valori più alti)
#nella seconda (CHdif2) la differenza si concentra nel colore azzurro (differenza in negativo che conferma che chad1973 ha valori inferiori)
par(mfrow=c(1,2))
plot(CHdif1, col=cl)
plot(CHdif2, col=cl)

#plotto tutte le immagini insieme per osservare la time series analysis:
#Chad Lake nel 1973, Chad Lake nel 2017 e differenza tra Chad Lake 2017 e Chad Lake 1973
par(mfrow=c(1,3))
plot(chad1, col=cl, main="Chad Lake in 1973")
plot(chad3, col=cl, main="Chad Lake in 2017")
plot(CHdif1, col=cl, main="Difference (2017 - 1973)")

#SPECTRAL SIGNATURES

chad1 <- brick("chad1973.jpg")
plotRGB(chad1, r=1, g=2, b=3, stretch="hist")

#utilizzo la funzione CLICK per cliccare su una mappa e ottenere informazioni relative a quel punto
#in questo caso, le info sono relative alla riflettanza
#T= true
#id= argomento che stabilisce se voglio creare un identificativo per ogni punto
#xy= arg che indica che vogliamo utilizzare un'informazione parziale
#cell= arg che indica che clicco su un pixel
#type= arg che indica il tipo di click, in questo caso il "punto, p"
#pch= arg che indica lo stile del punto

click(chad1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
#OUTPUT:
#  x     y   cell        chad1973.1 chad1973.2 chad1973.3
# 1 201.5 335.5 160978        1         53         67
#  x     y   cell        chad1973.1 chad1973.2 chad1973.3
# 1 232.5 218.5 242441        7         45         58
#  x     y   cell        chad1973.1 chad1973.2 chad1973.3
# 1 354.5 124.5 307987        6         71         73

#PUNTO 1 N 
#riflettanza banda 1 = 1 (NIR) 
#riflettanza banda 2 = 53 (red) 
#riflettanza banda 3 = 67 (green)

#PUNTO 2 Centro-W 
#riflettanza banda 1 = 7 (NIR)
#riflettanza banda 2 = 45 (red) 
#riflettanza banda 3 = 58 (green)

#PUNTO 3 S 
#riflettanza banda 1 = 6 (NIR)
#riflettanza banda 2 = 71 (red) 
#riflettanza banda 3 = 73 (green)


chad2 <- brick("chad1987.jpg")
plotRGB(chad2, r=1, g=2, b=3, stretch="hist")

click(chad2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
#OUTPUT:
#  x     y   cell      chad1987.1 chad1987.2 chad1987.3
# 1 201.5 336.5 160282      138        103         83
#  x     y   cell      chad1987.1 chad1987.2 chad1987.3
# 1 231.5 219.5 241744      25          4          3
#  x     y   cell      chad1987.1 chad1987.2 chad1987.3library(raster)
#1 353.5 123.5 308682       165        31         20

#PUNTO 1 N 
#riflettanza banda 1 = 138 (NIR) 
#riflettanza banda 2 = 103 (red) 
#riflettanza banda 3 = 83 (green)

#PUNTO 2 Centro-W 
#riflettanza banda 1 = 25 (NIR)
#riflettanza banda 2 = 4 (red) 
#riflettanza banda 3 = 3 (green)

#PUNTO 3 S 
#riflettanza banda 1 = 165 (NIR)
#riflettanza banda 2 = 31 (red) 
#riflettanza banda 3 = 20 (green)

    
chad3 <- brick("chad2017.jpg")
plotRGB(chad3, r=1, g=2, b=3, stretch="hist")

click(chad3, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
#OUTPUT:
#  x     y   cell       chad2017.1 chad2017.2 chad2017.3
# 1 201.5 333.5 162370     151         22         52
#   x     y   cell      chad2017.1 chad2017.2 chad2017.3
# 1 232.5 218.5 242441     164         29         59
#   x     y    cell     chad2017.1 chad2017.2 chad2017.3
# 1 354.5 124.5 307987     19         58         73

#PUNTO 1 N
#riflettanza banda 1 = 151 (NIR)
#riflettanza banda 2 = 22 (red) 
#riflettanza banda 3 = 52 (green)

#PUNTO 2 Centro-W
#riflettanza banda 1 = 164 (NIR)
#riflettanza banda 2 = 29 (red) 
#riflettanza banda 3 = 59 (green)

#PUNTO 3 S
#riflettanza banda 1 = 19 (NIR) (ritorna acqua)
#riflettanza banda 2 = 58 (red) 
#riflettanza banda 3 = 73 (green)

#CREO TABELLE
#b= banda (prima colonna); P1a= punto a Nord (seconda colonna); P2a= punto al centro (terza colonna); P3a= punto a Sud (quarta colonna)
#per "P1a", "P2a" e "P3a" riporto i valori ottenuti in precedenza tramite il click

#TABELLA CHAD 1973
band <- c(1,2,3)
P1a <- c(1,53,67)
P2a <- c(7,45,58)
P3a <- c(6,71,73)

#utilizzo la funzione data.frame per creare la tabella
data.frame(band,P1a, P2a, P3a)
spectrals <- data.frame(band,P1a, P2a, P3a)

##FIRMA SPETTRALE CHAD 1973
library(ggplot2)
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=P1a), color="green")+
geom_line (aes(y=P2a), color="blue")+
geom_line (aes(y=P3a), color="red")+
labs(x="band", y="reflactance Lake Chad 1973")

#TABELLA CHAD 1987
band <- c(1,2,3)
P1b <- c(138,103,83)
P2b <- c(25,4,3)
P3b <- c(165,31,28)

data.frame(band,P1b, P2b, P3b)
spectrals <- data.frame(band,P1b, P2b, P3b)

#FIRMA SPETTRALE CHAD 1987
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=P1b), color="green")+
geom_line (aes(y=P2b), color="blue")+
geom_line (aes(y=P3b), color="red")+
labs(x="band", y="reflactance Lake Chad 1987")

#TABELLA CHAD 2017
band <- c(1,2,3)
P1c <- c(151,22,52)
P2c <- c(164,29,59)
P3c <- c(19,58,73)

data.frame(band,P1c, P2c, P3c)
spectrals <- data.frame(band,P1c, P2c, P3c)

#FIRMA SPETTRALE CHAD 2017
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=P1c), color="green")+
geom_line (aes(y=P2c), color="blue")+
geom_line (aes(y=P3c), color="red")+
labs(x="band", y="reflactance Lake Chad 2017")

#TABELLA + FIRME SPETTRALI CHAD 1973 E CHAD 2017
#1) andamento generalmente opposto tra i punti del 1973 e il 2017
#2) si nota però che il P3c ha un andamento simile ai punti del 1973 e opposto a quelli del 2017 
band <- c(1,2,3)
P1a <- c(1,53,67)
P2a <- c(7,45,58)
P3a <- c(6,71,73)
P1c <- c(151,22,52)
P2c <- c(164,29,59)
P3c <- c(19,58,73)

data.frame(band,P1a, P2a, P3a, P1c, P2c, P3c)
spectrals7317 <- data.frame(band,P1a, P2a, P3a, P1c, P2c, P3c)

ggplot(spectrals7317, aes(x=band)) + 
geom_line (aes(y=P1a), color="green")+
geom_line (aes(y=P2a), color="blue")+
geom_line (aes(y=P3a), color="red")+
geom_line (aes(y=P1c), color="pink")+
geom_line (aes(y=P2c), color="black")+
geom_line (aes(y=P3c), color="orange")+ #noto che assume simile andamento ai Pa, questo proprio perché in quel punto è tornata l'acqua!
labs(x="band", y="reflactance Lake Chad 1973-2017")

#PLOTTO P3a, P3b e P3C
#voglio osservare il ritorno dell'acqua in quel punto 

band <- c(1,2,3)
P3a <- c(6,71,73) #presenza di acqua (valore basso nella banda NIR)
P3b <- c(165,31,28) #assenza di acqua, presenza di vegetazione (alto valore nella banda NIR)
P3c <- c(19,58,73) #ritorno dell'acqua (valore basso nella banda NIR)

data.frame(band,P3a, P3b, P3c)
spectralsw <- data.frame(band, P3a, P3b, P3c)
#tramite l'argomento size scelgo lo spessore della linea
ggplot(spectralsw, aes(x=band))+ 
geom_line (aes(y=P3a), color="red", size=1)+
geom_line (aes(y=P3b), color="green",size=1)+
geom_line (aes(y=P3c), color="blue", size=1)+ #noto che assume simile andamento ai P3a perché in quel punto è tornata l'acqua!
labs(x="band", y="reflactance") 


#CORRELATION BETWEEN LAKE CHAD WATER LEVEL AND SAHEL RAINFALL ANOMALIES
install.packages("readxl")#installo il pacchetto readxl per importare file excel
setwd("C:/lab/CH")
library(readxl)

#LAKE CHAD WATER LEVEL
#ho ricavato i dati delle fluttuazione del livello del lago dal seguente sito: http://hydroweb.theia-land.fr/hydroweb/view/L_tchad?lang=en
#ho riportato in un documento excel gli anni dal 1960 al 2020 (di 5 anni in 5 anni) in una colonna e i valori del livello del lago in un'altra
#per i valori, ho scelto i mesi da giugno ad ottobre e ne ho fatto la media
#ho utilizzato la funzione read_excel per importare il file creato
chadmslm <- read_excel("levelchad.xlsx")                                                                             
chadmslm
# A tibble: 13 x 2
#year `Lake Chad water level (a.m.s.l.)`
#   <dbl> <chr>                             
# 1  1960 282.5                             
# 2  1965 282.2                             
# 3  1970 280.7                             
# 4  1975 279.8                             
# 5  1980 279.7                             
# 6  1985 278.7                             
# 7  1990 278.6                             
# 8  1995 279.5                             
# 9  2000 279.8                             
#10  2005 279.9                             
#11  2010 280.2                             
#12  2015 280.0                             
#13  2020 280.4    

#creo il dataframe con i dati importati da excel
lakelevel<- data.frame(chadmslm)
colnames(lakelevel)[2] <- "Lake_Chad_water_level"

#plotto il grafico delle fluttuazioni del livello del lago
plot(lakelevel$year, lakelevel$Lake_Chad_water_level, xlab="year", ylab="a.m.s.l.", col="red", type="o", cex=3, main="Lake-level fluctuations")


#SAHEL RAINFALL ANOMALY
#"The Sahel rainy season is centered on June through October, and the means are taken for those months."
#Ho ricavato i dati delle anomalie di precipitazione nel Sahel da questo sito: http://research.jisao.washington.edu/data/sahel/#values
#ho riportato in un documento excel gli anni dal 1960 al 2017 in una colonna e i valori sulle anomalie in un'altra
#per i valori, ho scelto i mesi da giugno ad ottobre, ne ho fatto la media e ho moltiplicato il valore ottenuto x 0,1, così da avere la conversione in mm
#ho utilizzato la funzione read_excel per importare il file creato
sahelprec <- read_excel("Sahel prec anomaly.xlsx")
sahelprec
#A tibble: 58 x 2
 #YEAR       `SAHEL RAINFALL ANOMALY (mm)`
#  <dbl>                         <dbl>
# 1  1960                         13.7 
# 2  1961                         18.7 
# 3  1962                         19.9 
# 4  1963                         15.5 
# 5  1964                         24.7 
# 6  1965                         22.6 
# 7  1966                         17.1 
# 8  1967                         23.3 
# 9  1968                         -5.64
# 10  1969                         22.0 
# ... with 48 more rows

#creo il dataframe con i dati importati da excel
anomaly <- data.frame(sahelprec)
anomaly
#  YEAR     SAHEL.RAINFALL.ANOMALY..mm.
#1  1960                       13.66
#2  1961                       18.74
#3  1962                       19.88
#4  1963                       15.52
#5  1964                       24.74
#6  1965                       22.58
#7  1966                       17.10
#8  1967                       23.32
#9  1968                       -5.64
#10 1969                       21.98
#......seguono gli altri 48 valori per ciascuna colonna

#plotto il grafico delle anomalie di precipitazione
plot(anomaly$YEAR, anomaly$SAHEL.RAINFALL.ANOMALY..mm., xlab="year", ylab="mm", col="blue", type="o", cex=3, main="Sahel rainfall anomaly")

#RESULTS
#si osserva una effettiva correlazione tra i due grafici: da metà anni '60=>inizia a diminuire il livello del lago e allo stesso tempo si verifica un netto calo delle precipitazioni
#da metà degli anni '80 forte diminuzione delle piogge e conseguentemente una netta riduzione del livello del lago (fino a 278.6 m.s.l.m.)
#in seguito agli anni 2000, il livello del lago ha ricominciato a salire, ma non è più ritornato ai valori originari

