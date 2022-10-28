#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

require("data.table")
require("rpart")

#Aqui comienza el programa
setwd("~/lab1")

#cargo el dataset donde voy a entrenar
dataset  <- fread("./datasets/competencia2_2022.csv.gz")

#dataset  <- dataset[  foto_mes %in% c( 202101, 202103 ) ]

df <- dataset[, .(count = mpasivos_margen), by=c("foto_mes")]

df <- dataset[, .(mpasivos_margen = sum(mpasivos_margen)
,ctrx_quarter = sum(ctrx_quarter)
,mpasivos_margen = sum(mpasivos_margen)
,cpayroll_trx = sum(cpayroll_trx)
,ctarjeta_visa_transacciones = sum(ctarjeta_visa_transacciones)
,mpayroll = sum(mpayroll)
,mcuentas_saldo = sum(mcuentas_saldo)
,mautoservicio = sum(mautoservicio)
,mprestamos_personales = sum(mprestamos_personales)
,mrentabilidad_annual = sum(mrentabilidad_annual)
,mtarjeta_visa_consumo = sum(mtarjeta_visa_consumo)
,mcaja_ahorro = sum(mcaja_ahorro)
,mcomisiones_mantenimiento = sum(mcomisiones_mantenimiento)
,mcuenta_corriente = sum(mcuenta_corriente)
,ccomisiones_mantenimiento = sum(ccomisiones_mantenimiento)
,Visa_mpagominimo = sum(Visa_mpagominimo)
,mactivos_margen = sum(mactivos_margen)
,cproductos = sum(cproductos)
,mrentabilidad = sum(mrentabilidad)
,Visa_Fvencimiento = sum(Visa_Fvencimiento)
,Visa_msaldopesos = sum(Visa_msaldopesos)
,Master_fechaalta = sum(Master_fechaalta)
,cliente_edad = sum(cliente_edad)
,Master_Fvencimiento = sum(Master_Fvencimiento)
,ctarjeta_debito_transacciones = sum(ctarjeta_debito_transacciones)
,Visa_fechaalta = sum(Visa_fechaalta)
,Visa_msaldototal = sum(Visa_msaldototal)
,ccomisiones_otras = sum(ccomisiones_otras)
,chomebanking_transacciones = sum(chomebanking_transacciones)
,Visa_mpagospesos = sum(Visa_mpagospesos)
,cliente_antiguedad = sum(cliente_antiguedad)
,mcomisiones = sum(mcomisiones))
, by = foto_mes]     # Aggregate data

# Open a pdf file
pdf("rplot.pdf") 
# load the package
library(ggplot2)
# plot the data using barplot
barplot(df$ctrx_quarter, names.arg=df$foto_mes, ylab="suma", xlab="foto mes")
barplot(df$mpasivos_margen, names.arg=df$mpasivos_margen, ylab="suma", xlab="foto mes")
barplot(df$ctrx_quarter, names.arg=df$ctrx_quarter, ylab="suma", xlab="foto mes")
barplot(df$cpayroll_trx, names.arg=df$cpayroll_trx, ylab="suma", xlab="foto mes")
barplot(df$ctarjeta_visa_transacciones, names.arg=df$ctarjeta_visa_transacciones, ylab="suma", xlab="foto mes")
barplot(df$mpayroll, names.arg=df$mpayroll, ylab="suma", xlab="foto mes")
barplot(df$mcuentas_saldo, names.arg=df$mcuentas_saldo, ylab="suma", xlab="foto mes")
barplot(df$mautoservicio, names.arg=df$mautoservicio, ylab="suma", xlab="foto mes")
barplot(df$mprestamos_personales, names.arg=df$mprestamos_personales, ylab="suma", xlab="foto mes")
barplot(df$mrentabilidad_annual, names.arg=df$mrentabilidad_annual, ylab="suma", xlab="foto mes")
barplot(df$mtarjeta_visa_consumo, names.arg=df$mtarjeta_visa_consumo, ylab="suma", xlab="foto mes")
barplot(df$mcaja_ahorro, names.arg=df$mcaja_ahorro, ylab="suma", xlab="foto mes")
barplot(df$mcomisiones_mantenimiento, names.arg=df$mcomisiones_mantenimiento, ylab="suma", xlab="foto mes")
barplot(df$mcuenta_corriente, names.arg=df$mcuenta_corriente, ylab="suma", xlab="foto mes")
barplot(df$ccomisiones_mantenimiento, names.arg=df$ccomisiones_mantenimiento, ylab="suma", xlab="foto mes")
barplot(df$Visa_mpagominimo, names.arg=df$Visa_mpagominimo, ylab="suma", xlab="foto mes")
barplot(df$mactivos_margen, names.arg=df$mactivos_margen, ylab="suma", xlab="foto mes")
barplot(df$cproductos, names.arg=df$cproductos, ylab="suma", xlab="foto mes")
barplot(df$mrentabilidad, names.arg=df$mrentabilidad, ylab="suma", xlab="foto mes")
barplot(df$Visa_Fvencimiento, names.arg=df$Visa_Fvencimiento, ylab="suma", xlab="foto mes")
barplot(df$Visa_msaldopesos, names.arg=df$Visa_msaldopesos, ylab="suma", xlab="foto mes")
barplot(df$Master_fechaalta, names.arg=df$Master_fechaalta, ylab="suma", xlab="foto mes")
barplot(df$cliente_edad, names.arg=df$cliente_edad, ylab="suma", xlab="foto mes")
barplot(df$Master_Fvencimiento, names.arg=df$Master_Fvencimiento, ylab="suma", xlab="foto mes")
barplot(df$ctarjeta_debito_transacciones, names.arg=df$ctarjeta_debito_transacciones, ylab="suma", xlab="foto mes")
barplot(df$Visa_fechaalta, names.arg=df$Visa_fechaalta, ylab="suma", xlab="foto mes")
barplot(df$Visa_msaldototal, names.arg=df$Visa_msaldototal, ylab="suma", xlab="foto mes")
barplot(df$ccomisiones_otras, names.arg=df$ccomisiones_otras, ylab="suma", xlab="foto mes")
barplot(df$chomebanking_transacciones, names.arg=df$chomebanking_transacciones, ylab="suma", xlab="foto mes")
barplot(df$Visa_mpagospesos, names.arg=df$Visa_mpagospesos, ylab="suma", xlab="foto mes")
barplot(df$cliente_antiguedad, names.arg=df$cliente_antiguedad, ylab="suma", xlab="foto mes")
barplot(df$mcomisiones, names.arg=df$mcomisiones, ylab="suma", xlab="foto mes")

# Close the pdf file
dev.off() 

