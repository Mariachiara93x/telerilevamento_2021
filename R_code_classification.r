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
#lego la mappa all'immagine 
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

library(raster)
library(RStoolbox)
setwd("C:/lab/") 

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot (gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

