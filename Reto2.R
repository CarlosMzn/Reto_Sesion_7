#Reto 2. Extracción de tablas en un HTML
#De la siguiente dirección donde se muestran los sueldos para Data Scientists
#(https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm), 
#realiza las siguientes acciones:

#1) Extraer la tabla del HTML.
library(rvest) 
URL <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(URL)    # Leemos el html
# Selecciona pedazos dentro del HTML para identificar la tabla
tables <- html_nodes(file, "table")  

#2) Quitar los caracteres no necesarios de la columna sueldos (todo lo que no sea número), 
#para dejar solamente la cantidad mensual (Hint: la función gsub podría ser de utilidad).
table1 <- html_table(tables[1], fill = TRUE)
table <- na.omit(as.data.frame(table1)) 

#Removiendo caracteres inncesarios 
sueldo <- gsub("MXN","",table$Sueldo)
sueldo <- gsub(",","",sueldo)
sueldo <- gsub("/mes","",sueldo)
sueldo <- gsub("[^0-9.]", "", sueldo)

#3) Asignar ésta columna como tipo numérico para poder realizar operaciones con ella.
sueldo <- as.numeric(sueldo)
table$Sueldo <- sueldo


#4) Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y la que menos paga?
#Empresa que más paga.
max.sueldo <- which.max(table$Sueldo)
table[max.sueldo,]
#Empresa que menos paga.
min.sueldo <- which.min(table$Sueldo)
table[min.sueldo,]

