#Este script está pensado para correr en Google Cloud
# debe  cambiase el setwd() si se desea correr en Windows

#Aplicacion de los mejores hiperparametros encontrados en una bayesiana
#Utilizando clase_binaria =  [  SI = { "BAJA+1", "BAJA+2"} ,  NO="CONTINUA ]
rm( list=ls() )  #Borro todos los objetos
gc()   #Garbage Collection

#cargo las librerias que necesito
require("data.table")
require("rpart")
require("rpart.plot")
require("caret")

#Aqui se debe poner la carpeta de la materia de SU computadora local
setwd("~/lab1")  #Establezco el Working Directory

#cargo el dataset
dataset  <- fread("./datasets/competencia1_2022_FE.csv" )

a <- c(2,3)
b <- mean(a)

#creo la clase_binaria SI={ BAJA+1, BAJA+2 }    NO={ CONTINUA }
dataset[ , clase_binaria :=  ifelse( clase_ternaria=="CONTINUA", "NO", "SI" ) ]



dtrain  <- dataset[ foto_mes==202101 ]  #defino donde voy a entrenar
dapply  <- dataset[ foto_mes==202103 ]  #defino donde voy a aplicar el modelo


# Entreno el modelo
# obviamente rpart no puede ve  clase_ternaria para predecir  clase_binaria

modelo  <- rpart(formula=   "clase_binaria ~ . -clase_ternaria",
                 data=      dtrain,  #los datos donde voy a entrenar
                 xval=          0,
                 cp=           -0.765,
                 minsplit=    492,
                 minbucket=   244,
                 maxdepth=      7   )

print(modelo)

#aplico el modelo a los datos nuevos
prediccion  <- predict( object=  modelo,
                        newdata= dapply,
                        type = "prob")


vim <- varImp(modelo,useModel=T)
vim



#prediccion es una matriz con DOS columnas, llamadas "NO", "SI"
#cada columna es el vector de probabilidades 

#agrego a dapply una columna nueva que es la probabilidad de BAJA+2
dfinal  <- copy( dapply[ , list(numero_de_cliente) ] )
dfinal[ , prob_SI := prediccion[ , "SI"] ]


# por favor cambiar por una semilla propia
# que sino el Fiscal General va a impugnar la prediccion
set.seed(999953)  
dfinal[ , azar := runif( nrow(dapply) ) ]

# ordeno en forma descentente, y cuando coincide la probabilidad, al azar
setorder( dfinal, -prob_SI, azar )


dir.create( "./exp/" )
dir.create( "./exp/KA3720" )


for( corte  in  c( 4800, 5000, 5200, 7500, 8000, 8500, 9000, 9500, 10000, 10500, 11000 ) )
#for( corte  in  c( 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000 ) )
{
  #le envio a los  corte  mejores,  de mayor probabilidad de prob_SI
  dfinal[ , Predicted := 0L ]
  dfinal[ 1:corte , Predicted := 1L ]


  fwrite( dfinal[ , list(numero_de_cliente, Predicted) ], #solo los campos para Kaggle
           file= paste0( "./exp/KA3720/KA3720_001_",  corte, ".csv"),
           sep=  "," )
}

