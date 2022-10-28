#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

require("data.table")
require("rpart")

#Aqui comienza el programa
setwd("~/buckets/b1")

#cargo el dataset donde voy a entrenar
dataset  <- fread("./datasets/competencia2_2022_FE.csv.gz")


dataset  <- dataset[ foto_mes %in% c( 202101, 202102, 202103, 202104, 202105 )]
#dataset  <- dataset[  clase_ternaria=="CONTINUA" ]
#dataset  <- dataset[  clase_ternaria=="BAJA+2" ]

#top 20 variables originales
df <- dataset[, .(mpasivos_margen = sum(mpasivos_margen)
,mpasivos_margen_adj = sum(mpasivos_margen_adj)
,ctrx_quarter = sum(ctrx_quarter)
,cpayroll_trx = sum(cpayroll_trx)
,ctarjeta_visa_transacciones = sum(ctarjeta_visa_transacciones)
,mpayroll = sum(mpayroll)
,mpayroll_adj = sum(mpayroll_adj)
,mcuentas_saldo = sum(mcuentas_saldo)
,mcuentas_saldo_adj = sum(mcuentas_saldo_adj)
,mautoservicio = sum(mautoservicio)
,mautoservicio_adj = sum(mautoservicio_adj)
,mprestamos_personales = sum(mprestamos_personales)
,mprestamos_personales_adj = sum(mprestamos_personales_adj)
,mrentabilidad_annual = sum(mrentabilidad_annual)
,mrentabilidad_annual_adj = sum(mrentabilidad_annual_adj)
,mtarjeta_visa_consumo = sum(mtarjeta_visa_consumo)
,mtarjeta_visa_consumo_adj = sum(mtarjeta_visa_consumo_adj)
,mcaja_ahorro = sum(mcaja_ahorro)
,mcaja_ahorro_adj = sum(mcaja_ahorro_adj)
,mcomisiones_mantenimiento = sum(mcomisiones_mantenimiento)
,mcomisiones_mantenimiento_adj = sum(mcomisiones_mantenimiento_adj)
,mcuenta_corriente = sum(mcuenta_corriente)
,mcuenta_corriente_adj_ = sum(mcuenta_corriente_adj)
,ccomisiones_mantenimiento = sum(ccomisiones_mantenimiento)
,Visa_mpagominimo = sum(Visa_mpagominimo)
,mactivos_margen = sum(mactivos_margen)
,mactivos_margen_adj = sum(mactivos_margen_adj)
,cproductos = sum(cproductos)
,mrentabilidad = sum(mrentabilidad)
,mrentabilidad_adj = sum(mrentabilidad_adj)
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


#top 20 variables con funcion frank
#dfr <- dataset[, .(mpasivos_margen_rank = sum(mpasivos_margen_rank)
#                  ,ctrx_quarter_rank = sum(ctrx_quarter_rank)
#                  ,mpasivos_margen_rank = sum(mpasivos_margen_rank)
#                  ,ctrx_quarter_rank = sum(ctrx_quarter_rank)
#                  ,cpayroll_trx_rank = sum(cpayroll_trx_rank)
#                  ,ctarjeta_visa_transacciones_rank = sum(ctarjeta_visa_transacciones_rank)
#                  ,mpayroll_rank = sum(mpayroll_rank)
#                  ,mcuentas_saldo_rank = sum(mcuentas_saldo_rank)
#                  ,mautoservicio_rank = sum(mautoservicio_rank)
#                  ,mprestamos_personales_rank = sum(mprestamos_personales_rank)
#                  ,mrentabilidad_annual_rank = sum(mrentabilidad_annual_rank)
#                  ,mtarjeta_visa_consumo_rank = sum(mtarjeta_visa_consumo_rank)
#                  ,mcaja_ahorro_rank = sum(mcaja_ahorro_rank)
#                  ,mcomisiones_mantenimiento_rank = sum(mcomisiones_mantenimiento_rank)
#                  ,mcuenta_corriente_rank = sum(mcuenta_corriente_rank)
#                  ,ccomisiones_mantenimiento_rank = sum(ccomisiones_mantenimiento_rank)
#                  ,Visa_mpagominimo_rank = sum(Visa_mpagominimo_rank)
#                  ,mactivos_margen_rank = sum(mactivos_margen_rank)
#                  ,cproductos_rank = sum(cproductos_rank)
#                  ,mrentabilidad_rank = sum(mrentabilidad_rank)
#                  ,Visa_Fvencimiento_rank = sum(Visa_Fvencimiento_rank)
#                  ,Visa_msaldopesos_rank = sum(Visa_msaldopesos_rank)
#                  ,Master_fechaalta_rank = sum(Master_fechaalta_rank)
#                  ,cliente_edad_rank = sum(cliente_edad_rank)
#                  ,Master_Fvencimiento_rank = sum(Master_Fvencimiento_rank)
#                  ,ctarjeta_debito_transacciones_rank = sum(ctarjeta_debito_transacciones_rank)
#                  ,Visa_fechaalta_rank = sum(Visa_fechaalta_rank)
#                  ,Visa_msaldototal_rank = sum(Visa_msaldototal_rank)
#                  ,ccomisiones_otras_rank = sum(ccomisiones_otras_rank)
#                  ,chomebanking_transacciones_rank = sum(chomebanking_transacciones_rank)
#                  ,Visa_mpagospesos_rank = sum(Visa_mpagospesos_rank)
#                  ,cliente_antiguedad_rank = sum(cliente_antiguedad_rank)
#                  ,mcomisiones_rank = sum(mcomisiones_rank))
#, by = foto_mes]     # Aggregate data


# Open a pdf file
pdf("rplot_hist_adj.pdf") 
# load the package
library(ggplot2)
# plot the data using barplot
barplot(df$ctrx_quarter, names.arg=df$foto_mes, ylab="suma", xlab="ctrx_quarter")
barplot(df$mpasivos_margen, names.arg=df$foto_mes, ylab="suma", xlab="mpasivos_margen")
barplot(df$mpasivos_margen_adj, names.arg=df$foto_mes, ylab="suma", xlab="mpasivos_margen_adj")

barplot(df$cpayroll_trx, names.arg=df$foto_mes, ylab="suma", xlab="cpayroll_trx")
barplot(df$ctarjeta_visa_transacciones, names.arg=df$foto_mes, ylab="suma", xlab="ctarjeta_visa_transacciones")

barplot(df$mpayroll, names.arg=df$foto_mes, ylab="suma", xlab="mpayroll")
barplot(df$mpayroll_adj, names.arg=df$foto_mes, ylab="suma", xlab="mpayroll_adj")

barplot(df$mcuentas_saldo, names.arg=df$foto_mes, ylab="suma", xlab="mcuentas_saldo")
barplot(df$mcuentas_saldo_adj, names.arg=df$foto_mes, ylab="suma", xlab="mcuentas_saldo_Adj")

barplot(df$mautoservicio, names.arg=df$foto_mes, ylab="suma", xlab="mautoservicio")
barplot(df$mautoservicio_adj, names.arg=df$foto_mes, ylab="suma", xlab="mautoservicio_adj")

barplot(df$mprestamos_personales, names.arg=df$foto_mes, ylab="suma", xlab="mprestamos_personales")
barplot(df$mprestamos_personales_adj, names.arg=df$foto_mes, ylab="suma", xlab="mprestamos_personales_adj")

barplot(df$mrentabilidad_annual, names.arg=df$foto_mes, ylab="suma", xlab="mrentabilidad_annual")
barplot(df$mrentabilidad_annual_adj, names.arg=df$foto_mes, ylab="suma", xlab="mrentabilidad_annual_adj")

barplot(df$mtarjeta_visa_consumo, names.arg=df$foto_mes, ylab="suma", xlab="mtarjeta_visa_consumo")
barplot(df$mtarjeta_visa_consumo_adj, names.arg=df$foto_mes, ylab="suma", xlab="mtarjeta_visa_consumo_adj")

barplot(df$mcaja_ahorro, names.arg=df$foto_mes, ylab="suma", xlab="mcaja_ahorro")
barplot(df$mcaja_ahorro_adj, names.arg=df$foto_mes, ylab="suma", xlab="mcaja_ahorro_adj")

barplot(df$mcomisiones_mantenimiento, names.arg=df$foto_mes, ylab="suma", xlab="mcomisiones_mantenimiento")
barplot(df$mcomisiones_mantenimiento_adj, names.arg=df$foto_mes, ylab="suma", xlab="mcomisiones_mantenimiento_adj")

barplot(df$mcuenta_corriente, names.arg=df$foto_mes, ylab="suma", xlab="mcuenta_corriente")
barplot(df$mcuenta_corriente_adj, names.arg=df$foto_mes, ylab="suma", xlab="mcuenta_corriente_adj")

barplot(df$ccomisiones_mantenimiento, names.arg=df$foto_mes, ylab="suma", xlab="ccomisiones_mantenimiento")
barplot(df$ccomisiones_mantenimiento_adj, names.arg=df$foto_mes, ylab="suma", xlab="ccomisiones_mantenimiento_adj")

barplot(df$Visa_mpagominimo, names.arg=df$foto_mes, ylab="suma", xlab="Visa_mpagominimo")

barplot(df$mactivos_margen, names.arg=df$foto_mes, ylab="suma", xlab="mactivos_margen")
barplot(df$mactivos_margen_adj, names.arg=df$foto_mes, ylab="suma", xlab="mactivos_margen_adj")

barplot(df$cproductos, names.arg=df$foto_mes, ylab="suma", xlab="cproductos")
barplot(df$mrentabilidad, names.arg=df$foto_mes, ylab="suma", xlab="mrentabilidad")
barplot(df$mrentabilidad_adj, names.arg=df$foto_mes, ylab="suma", xlab="mrentabilidad_adj")

barplot(df$Visa_Fvencimiento, names.arg=df$foto_mes, ylab="suma", xlab="Visa_Fvencimiento")
barplot(df$Visa_msaldopesos, names.arg=df$foto_mes, ylab="suma", xlab="Visa_msaldopesos")
barplot(df$Visa_msaldopesos_adj, names.arg=df$foto_mes, ylab="suma", xlab="Visa_msaldopesos_adj")

barplot(df$Master_fechaalta, names.arg=df$foto_mes, ylab="suma", xlab="Master_fechaalta")
barplot(df$cliente_edad, names.arg=df$foto_mes, ylab="suma", xlab="cliente_edad")
barplot(df$Master_Fvencimiento, names.arg=df$foto_mes, ylab="suma", xlab="Master_Fvencimiento")
barplot(df$ctarjeta_debito_transacciones, names.arg=df$foto_mes, ylab="suma", xlab="ctarjeta_debito_transacciones")
barplot(df$Visa_fechaalta, names.arg=df$foto_mes, ylab="suma", xlab="Visa_fechaalta")
barplot(df$Visa_msaldototal, names.arg=df$foto_mes, ylab="suma", xlab="Visa_msaldototal")
barplot(df$Visa_msaldototal_adj, names.arg=df$foto_mes, ylab="suma", xlab="Visa_msaldototal_adj")

barplot(df$ccomisiones_otras, names.arg=df$foto_mes, ylab="suma", xlab="ccomisiones_otras")
barplot(df$chomebanking_transacciones, names.arg=df$foto_mes, ylab="suma", xlab="chomebanking_transacciones")
barplot(df$Visa_mpagospesos, names.arg=df$foto_mes, ylab="suma", xlab="Visa_mpagospesos")
barplot(df$cliente_antiguedad, names.arg=df$foto_mes, ylab="suma", xlab="cliente_antiguedad")
barplot(df$mcomisiones, names.arg=df$foto_mes, ylab="suma", xlab="mcomisiones")


# Close the pdf file
dev.off() 

