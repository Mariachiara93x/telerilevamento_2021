#Time series analysis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

install.packages ("raster")
library(raster)

setwd("C:/lab/greenland") # Windows


 

#day 2

library(raster)
setwd("C:/lab/greenland")
# cartella greenland con 4 file,4 strati separati
# i file .tif rappresentano la stima della temperatura LST (land surface temperature)

# LST da Copernicus (Global Land Service)
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
#list f files
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
