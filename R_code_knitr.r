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

