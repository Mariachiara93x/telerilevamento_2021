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

