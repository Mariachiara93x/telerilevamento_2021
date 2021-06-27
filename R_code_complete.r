#R code compete - Telerilevamento Geo-Ecologico
#..............................................

#Summary:

#1. Remote sensing - first code
#2. R code time series
#3. R code Copernicus
#4. R code knitr
#5. R code multivariate analysis
#6. R code classification
#7. R code ggplot2
#8. Vegetation Indices
#9. R code land cover
#10. R code variability
#11.R_code_no2.r
#12. R code spectral signatures

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
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")

# Exercise: mount a 2x2 multiframe: tramite la funzione par visualizzo contemporaneamente, scegliendo l'opzione 2 row 2 colums, le quattro immagini precedentemente plottate con RGB
pdf("il_mio_primo_pdf_con_r.pdf") #salvare plot come pdf
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")
dev.off()

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #visualizzo 

#par natural colours, false colours and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#Multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988

plot(p224r63_1988)
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="lin")

#hist
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin")
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#..............................................

#2. R code time series

#Time series analysis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

library(raster)

setwd("C:/lab/greenland") 

# cartella greenland con 4 file,4 strati separati
# i file .tif rappresentano la stima della temperatura LST (land surface temperature)

#LST da Copernicus (Global Land Service)
#la funzione brick non può essere utilizzata perchè i 4 file sono 4 file separati

# raster crea un rasterlayer
# uso la funzione raster per ogni file lst_x.tif
lst_2000<- raster("lst_2000.tif")
lst_2005<- raster("lst_2005.tif")
lst_2010<- raster("lst_2010.tif")
lst_2015<- raster("lst_2015.tif")
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#LIST FILES
# list.files crea la lista di file che R utilizzerà per la funzione lapply

# serve un pattern, cioè una configurazione comune a tutti i file, per caricare la lista di tutti questi: in questo caso utilizzo il pattern "lst"

# associo la funzione list.files all'oggetto "rlist" 
rlist<- list.files(pattern="lst")
rlist
# la funzione lapply permette di applicare un'altra funzione (es. raster) ad una lista di file (tipo quella dei file "lst")
# serve X ovvero la lista alla quale applicare la funzione
# serve FUN ovvero la funzione da applicare 
# X= rlist
# FUN= raster
# associo un nome all'oggetto ovvero "import"
import<- lapply(rlist,raster)
import
# la funzione stack permette di raggruppare un numero di file raster tutti assieme in un unico blocco
# associo un nome all'oggetto ovvero "TGr" (Temperature Greenland)
TGr<- stack(import)
# in questo modo posso fare il plot dei file .tif facendo il solo plot dell'ogggetto TGr appena creato
plot(TGr)
# utilizzo la funzione PlotRGB come nei casi studio precedenti
# scelgo uno stretch di tipo lineare
# scelgo le varie bande
plotRGB(TGr,1,2,3,stretch="Lin")
plotRGB(TGr,2,3,4,stretch="Lin")
plotRGB(TGr,4,3,2,stretch="Lin")

#installo pacchetto rasterVis
install.packages(rasterVis)

#day 3
setwd("C:/lab/Greenland/")
library(raster)
library(rasterVis)

rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist,raster)
import
TGr <- stack(import)
TGr

#la funzione levelplot permette di utilizzare un blocco intero di file, con una singola legenda e plottarli tutti insieme 
#applico la funzione levelplot all'immagine "TGr"
levelplot(TGr)

#con un'unico plot ottengo un grafico multivalore di LST
#ottengo una media delle temperature sull'asse X, calcolata per ogni singola colonna 
#ottengo una media delle temperatura sull'asse Y, calcolata per ogni singola riga
levelplot(TGr$lst_2000)

#cambio colore all'immagine
#in questo modo osservo il trend di cambiameneto della temperatura dal 2000 al 2015
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)

#utilizzo l'argomento "names.attr" per rinominare i singoli attributi, inserico i 4 blocchi "July 2000"..."July2015")
levelplot(TGr,col.regions=cl,  names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#inserendo l'argomento "main" posso inserire anche il titolo all'immagine
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
    
# Melt
#tramite i file melt.tif ottengo dati sullo scioglimento dei ghiacci dal 1979 al 2007
#creo una lista dei file melt.tif, scegliendo il pattern comune a tutti "melt"
meltlist <- list.files(pattern="melt")

#applico la funzione lapply alla lista appena creata tramite list.files
#applico la funzione rater a tutti i file
#associo la funzione all'oggetto "melt_import"
melt_import <- lapply(meltlist,raster)

#raggruppo tutti i file appena importati con la funzione stack
melt <- stack(melt_import)
melt

#applico la funzione levelplot ai file importati
levelplot(melt)

#ottengo lo scioglimento dei ghiacci totale verificatosi dal 1979 al 2007
#per fare ciò, utilizzo una matrice algebrica
#sottraggo ai valori del 2007 quelli del 1979
#utilizzo il $ per legare ogni singolo attributo al proprio file
#associo il nome "melt_amount"
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

#cambio colore all'immagine appena creata
clb <- colorRampPalette(c("blue","white","red"))(100)
#plotto l'immagine per osservare lo scioglimento avvenuto dal 1979 al 2007 (visibile in rosso) 
plot(melt_amount, col=clb) 
#applico un levelplot per osservare, oltre allo scioglimento dal 1979 al 2007, anche le medie sugli assi X e Y
levelplot(melt_amount, col.regions=clb)

#installo pacchetto knitr
install.packages("knitr")

setwd("C:/lab/Greenland/")
library(raster)
library(knitr)

#..............................................

#3. R code Copernicus

#R_code_copernicus.r
#Visualizing Copernicus data
#utilizzo il programma Copernicus per visualizzare dati relativi a variabili bio-geofisiche della superficie terrestre

#installo il pacchetto ncdf4 per leggere il formato netCDF
install.packages("ncdf4")
library(raster)
library(ncdf4)

setwd("C:/lab/") 

#seleziono l'immagine in formato .nc per visualizzare le informazioni a riguardo
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

#..............................................

#4. R code knitr

#R_code_knitr.r
#utilizzo il pacchetto knitr per usufruire di un codice esterno
#tramite il codice esterno, importato in R, viene generato un report
#il report sarà poi salvato nella stessa cartella in cui è presente il codice esterno

setwd("C:/lab/")

library(knitr)

#creo un file di testo con il codice creato all'interno di R_code_time series
#rinomino il file con "R_code_greenland.r"
#inserisco il file di testo all'interno della cartella lab

#utilizzo la funzione stitch per creare il report
#inserisco come argomento per stitch il nome del file "R_code_greenland.txt"
#con tutta questa operazione salverò nella cartella lab il report generato
stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#in automatico si genera una cartella di nome figure
#dentro figure sono presenti tutte le immagini del codice

#se la cartella non si genera in automatico, scarico direttamente la cartella di "R_code_time_series.r" 
#inserisco il file nella cartella lab
#e ora applico funzione stitch
stitch("R_code_time_series.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#..............................................

#5. R code multivariate analysis

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
#con la prima componente viene spiegato il 99,98% della variabilità
#con le prime tre bande viene spiegato il 99,99% della variabilità
summary(p224r63_2011res_pca$model)
#plottando la mappa osservo infatti che nella PC1 ho tante informazioni
#nella PC7 c'è molto rumore
plot(p224r63_2011res_pca$map)
#visualizzo le informazioni riguardo all'immagine
p224r63_2011res_pca

#plotto la mappa risultante dal modello
#i tre colori sono relativi alle tre componenti
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#..............................................

#6. R code classification

#R_code_classification.r

library(raster)
setwd("C:/lab/") 

#utilizzo funzione brick per prendere un pacchetto di dati e creare un rasterbrick
#il rasterbrick in questione comprende i tre livelli relativi a tre bande
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#digito so e ottengo le informazioni relative
so

#utilizzo la funzione plotRGB per visualizzare i tre livelli dell'immagine
#utilizzo lo stretch per avere il range completo dei valori da 0 a 255 (255= valore max dell'immagine)
plotRGB(so, 1, 2, 3, stretch="lin")

#una volta plottata l'immagine, osservo esplosioni piuttosto forti alla dx
#osservo un livello energetico intermedio a sinistra
#osservo un livello energetico molto basso al centro
#voglio classificare questi tre livelli energetici

#CLASSIFICAZIONE NON SUPERVISIONATA
#per la classificazione utilizzo il metodo del maximun likelihood
#il maximum likelihood si ottiene tramite un grafico multispettrale
#cioè gruppi di pixel che, per distanza nel grafico e somiglianza tra loro, vengono associati a label (es: NEVE, URBANO, ecc)
#per ottenere questo grafico, il software compie una classificazione non supervisionata
#cioè raggruppa automaticamente i pixel rilevando la loro riflettanza, senza che sia l'utente a definire le classi a monte
#uso il pacchetto RStoolbox per compiere la class. non superv.
library(RStoolbox)
#uso la funzione unsuperClass e scelgo 3 classi di riferimento
#la associo all'oggetto soc
#per ottenere una classificazione che utilizzi sempre le stesse repliche per fare il modello utilizzo la funzione seguente
set.seed(42)
soc <- unsuperClass(so,nClasses=3)

#unsuperClass crea la mappa dell'immagine soc
#plotto la mappa dell'immagine soc con plot
#lego la mappa all'immagine con $
plot(soc$map)
#vedo le classi da 1 a 3 (con classi intermedie:1,5, ecc)

#aumento il numero delle classi
#cambio il nome dell'oggetto associato all'immagine
soc20 <- unsuperClass(so,nClasses=20)
plot(soc20$map)

#Download immagine del Sole
#https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")

#CLASSIFICAZIONE NON SUPERVISIONATA dell'immagine scaricata da ESA
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

#GRAND CANYON
#https://landsat.visibleearth.nasa.gov/view.php?id=80948
#in questa immagine rilevata dal satellite Landsat in data 30 Marzo 2013, si osserva una porzione del Grand Canyon
#"In the image above, the Colorado River traces a line across the arid Colorado Plateau. 
#Treeless areas are beige and orange; green areas are forested. 
#The river water is brown and muddy, a common occurrence in spring when melting snows cause water levels to swell and pick up extra sediment. 
#The black line that follows the river in the upper right side of the image is comprised of shadows." by NASA Landsat Image Gallery

library(raster)
library(RStoolbox)#necessario per analisi multivariata
setwd("C:/lab/") 

#scarico l'immagine e la salvo nella cartella lab
#associo l'immagine all'oggetto gc e utilizzo la funzione brick
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#utilizzo la funzione RGB per plottare un oggetto Raster multi strato
#uso lo stretch, lineare e poi hist, per aumentare rispettivamente la potenza visiva di tutti i colori
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

#uso la funzione unsuperClass e scelgo 2 classi di riferimento
#la associo all'oggetto gcc2
gcc2 <- unsuperClass(gc, nClasses=2)
#visualizzo le informazioni riguardo all'immagine
gcc2
#plotto la mappa dell'immagine gcc2 con plot
#lego la mappa all'immagine con $
plot (gcc2$map)

#aumento il numero di classi e plotto
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#..............................................

#7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#..............................................

#8. Vegetation Indices

#R_code_vegetation_indices.r

library(raster)
setwd("C:/lab/")

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#plotto con RGB un par di entrambe le immagini
#osservo la variazione di vegetazione nel tempo
#b1=NIR, b2=rosso, b3=verde
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#visualizzo informazioni su immagine defor1
defor1

#DIffERENCE VEGETATION INDEX
#osservo in che stato di salute è la vegetazione
#noto che la vegetazione (foresta amazzonica) è molto verde
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")

#osservo il cambiamento della vegetazione nella foresta amazzonica
#si nota un'importante deforestazione
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

difdvi <- dvi1-dvi2

cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

#ndvi
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)


ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)
 
#RStoolbox: spectralIndices
library(RStoolbox)# for vegetation indices calculation
vi1<- spectralIndices (defor1, green=3, red=2, nir=1)
plot (vi1, col=cl)

vi2<- spectralIndices (defor2, green=3, red=2, nir=1)
plot (vi2, col=cl)

difndvi <- ndvi1 -ndvi2
plot(difndvi)

#5 MAGGIO
#il pacchetto rasterdiv contiene un dataset globale derivato da Copernicus 
#nel dataset globale è presente una media di valori di NDVI dal 1999 al 2017 
#in pratica osservo quanta biomassa è presente sulla Terra
install.packages("rasterdiv")
library(rasterdiv)

#worldwide NDVI
#plottando copNDVI ottengo una mappa globale in cui è visibile l'acqua
plot(copNDVI)

# per eliminare l'acqua utilizzo l'argomento cbind della funzione reclassify
#in pratica i pixel 253,254,255 possono essere trasformati in NA (= not assigned = "non valori")
#il : serve a dare il range di valori dei pixel
copNDVI<-reclassify(copNDVI, cbind (253:255,NA))
plot(copNDVI)
#noto in nord america e nord europa un NDVI più alto

#richiamo la libreria rasterVis per fare un levelplot dell'immagine precedentemente plottata
library(rasterVis)
levelplot(copNDVI)
#osservo la variazione di NDVI dal '99 al 2017 
#i valori massimi si trovano all'equatore perché c'è il massimo di luce

#..............................................

#9. R code land cover

#R_code_land_cover.r
library(raster)
library(RStoolbox) #classification

#installo il pacchetto ggplot2
install.packages("ggplot2")
library(ggplot2)

setwd("C:/lab/") 

defor1 <- brick("defor1.jpg")

#NIR 1, RED 2, GREEN 3
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

#utilizzo la funzione ggR per plottare immagini ottenendo le coordinate spaziali dell'oggetto
#anzichè usare la funzione plot, uso "gg"
#uso ggRGB e creo un'immagine singola delle tre bande
#è necessario caricare la libreria RStoolbox
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")


defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#per fare il multiframe con il ggplot, non uso par(mfrow)
#installo il pacchetto gridExtra
install.packages("gridExtra")
library(gridExtra)

#utilizzo la funzione grid.arrange per creare multiframe in un grafico
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <-ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1,p2,nrow=2)

#7 MAGGIO

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/") 

#classificazione non supervisionata
d1c<-unsuperClass(defor1, nClasses=2) #set.seed() oer ottenere lo stesso risultato
plot(d1c$map)

defor2 <- brick("defor2.jpg")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
d2c <-unsuperClass(defor2, nClasses=2) 
plot(d2c$map)

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#frequecies
freq(d1c$map)
#     value  count
[1,]     1  34181
[2,]     2 307111

s1<-307111 + 34181
s1

prop1 <- freq(d1c$map)/s1
prop1
#prop forest:0.8983012
#prop agriculture: 0.1016988

s2<-342726
s2
prop2 <- freq(d2c$map) / s2
prop2

#build a dataframe
cover <- c("Forest", "Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

#plotto il dataframe con ggplot
p1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="light green")
p2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="pink")

grid.arrange(p1,p2, nrow=1)

#..............................................

#10. R code variability

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

#..............................................

#11.R_code_no2.r

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


#..............................................


#12. R code spectral signatures

#R_code_spectral_signatures.r
# la firma spettrale è una sorta di impronta digitale della relativa specie di un organismo, habitat, roccia, minerale, ecc
# è specifica per ogni combinazione di riflessi e assorbimenti delle radiazioni elettromagnetiche (EM) a diverse lunghezze d'onda.

library (raster)
setwd("C:/lab/")

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist") # differenze dei colori più accentuate con hist, perché uso curva logistica anziché linea

#gdal è la libreria generale per dati geospaziali sia raster sia vettoriali
library(rgdal)

# utilizzo la funzione click per cliccare su una mappa e ottenere informazioni relative a quel punto
# in questo caso, le info sono relative alla riflettanza
#T= true
#id= argomento che stabilisce se voglio creare un identificativo per ogni punto
#xy= arg che indica che vogliamo utilizzare un'informazione parziale
#cell= arg che indica che clicco su un pixel
#type= arg che indica il tipo di click, in questo caso il "punto, p"
#pch= arg che indica lo stile del punto
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#RESULTS
#cliccando su un punto rosso (vegetato) ottengo i seguenti valori:
# x     y  cell defor2.1 defor2.2 defor2.3
#1 90.5 438.5 28054      210       12       27
#riflettanza banda 1 = 210 (IR)
#riflettanza banda 2 = 12 (red) (assorbe molto)
#riflettanza banda 3 = 27 (green)

#clicco su punto nel fiume e ottengo i seguenti valori:
# x     y   cell defor2.1 defor2.2 defor2.3
#1 562.5 227.5 179813       45       81      105

#CREO TABELLA
#b= banda (prima colonna); F= foresta(seconda colonna); w= acqua (terza colonna)
#per "forest" e "water" riporto i valori ottenuti in precedenza tramite il click
band <- c(1,2,3)
forest <- c(210,12,27)
water <- c(45,81,105)

#utilizzo la funzione data.frame per creare la tabella
data.frame(band,forest, water)
spectrals <- data.frame(band,forest, water)

#PLOTTO LA FIRMA SPETTRALE (SPECTRAL SIGNATURES)
library(ggplot2)
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=forest), color="green") #inserisce le geometrie nel plot (ad. es linee)
#ottengo grafico in cui osservo la riflettanza di un singolo pixel nelle tre bande
#alta riflettanza in banda 1
#bassa riflettanza in banda 2
#media riflettanza nella banda 3

#aggiungo il ggplot della componente water
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=forest), color="green") +
geom_line (aes(y=water), color="blue") 
#osservo come l'acqua abbia un comportamento nettamente opposto rispetto alla vegetazione
#(in questo caso non è acqua pura, ci sono anche solidi disciolti)

ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=forest), color="green") +
geom_line (aes(y=water), color="blue") +
labs(x="band", y="reflactance") #rinomino i due assi

#SPECTRAL SIGNATURES defor1
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#  x     y  cell defor1.1 defor1.2 defor1.3
#1 43.5 339.5 98576      227       13       39
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 61.5 342.5 96452      183       13       22
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 78.5 333.5 102895      214       22       37
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 76.5 369.5 77189      231       24       44
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 80.5 406.5 50775      230       27       47

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#   x     y  cell defor2.1 defor2.2 defor2.3
#1 90.5 338.5 99754      186      149      141
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 106.5 325.5 109091      181      123      122
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 103.5 353.5 89012      190      177      161
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 123.5 367.5 78994      174      182      158
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 85.5 321.5 111938      186      176      166

#creo le colonne del dataset
band <- c(1,2,3)
time1 <-c(227,13,39) #valori riflettanza nelle bande di defor1
time2 <- c(186,149,141) #valori riflettanza nelle bande di defor2

spectralst <- data.frame(band, time1, time2)
ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=time1), color="red") +
geom_line (aes(y=time2), color="grey") +
labs(x="band", y="reflactance") 

#inserisco anche i dati dei secondi punti, rispettivamente per defor1 e defor 2
band <- c(1,2,3)
time1 <-c(227,13,39)
time1p2 <- c(183,13,22)
time2 <- c(186,149,141)
time2p2 <- c(181,123,122)

spectralst <- data.frame (band, time1,time2,time1p2, time2p2)

ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=time1), color="red", linetype="dotted") +
geom_line (aes(y=time1p2), color="red",linetype="dotted") +
geom_line (aes(y=time2), color="green",linetype="dotted") +
geom_line (aes(y=time2p2), color="green",linetype="dotted") +
labs(x="band", y="reflactance") 

#IMMAGINE DA EARTH OBSERVATORY

stromboli <- brick("stromboli.jpg")
plotRGB(stromboli, 1,2,3, stretch="hist")
click(stromboli, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#OUTPUT; scelgo tre punti nell'immagine dello stromboli
# x     y  cell stromboli.1 stromboli.2 stromboli.3    ######zona gialla (fianco NE)
# 1 312.5 439.5 72313          46          72          63
# x     y  cell stromboli.1 stromboli.2 stromboli.3    ######zona rosso-marrone (Sciara del Fuoco)
# 1 225.5 408.5 94546           1           6          26
# x     y   cell stromboli.1 stromboli.2 stromboli.3   ######zona bianca (cratere)
#1 249.5 350.5 136330         210         209         207
# x     y   cell stromboli.1 stromboli.2 stromboli.3   ######zona blu (mare)
#1 160.5 120.5 301841           2          20          56

#creo il set di colonne
band <- c(1,2,3)
zona1 <- c(46,72,63)
zona2 <- c(1,6,26)
zona3 <- c(210,209,207)
zona4 <- c(2,20,56)

spectralsgeo <- data.frame (band, zona1, zona2, zona3, zona4)

ggplot(spectrals, aes(x=band)) + 
geom_line (aes(y=zona1), color="yellow") +
geom_line (aes(y=zona2), color="green") +
geom_line (aes(y=zona3), color="red") +
geom_line (aes(y=zona4), color="blue") +
labs(x="band", y="reflactance") 













