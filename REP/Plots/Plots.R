library(eurostat)

X <- get_eurostat("nrg_pc_204", time_format = "num")
X <- X[X$consom == "4161903" & X$tax == "I_TAX" & X$currency == "EUR", c(6:8)]
X <- X[(X$geo == "EU28"),]
X$time <- as.character(as.character(X$time))
names(X)[3] <- "PRI"
X$time <- as.numeric(as.character(X$time))
X$geo <- as.factor(as.character(X$geo))

I <- get_eurostat("nrg_pc_202", time_format = "num")
I <- I[I$consom == "4141902" & I$tax == "I_TAX" & I$currency == "EUR" & I$unit== "GJ_GCV",c(6:8)]
names(I)[3] <- "GAS"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

I <- get_eurostat("nrg_pc_204_h", time_format = "num")
J <- get_eurostat("nrg_pc_202_h", time_format = "num")
I <- I[I$tax == "I_TAX" & I$currency == "EUR" & I$unit == "KWH" & I$consom == "4161150", c(6:8)]
J <- J[J$tax == "I_TAX" & J$currency == "EUR" & J$unit== "GJ_GCV" & J$consom == "4141150", c(6:8)]
names(I)[3] <- "PRI"
names(J)[3] <- "GAS"
I <- merge(I, J, by=c("time", "geo"), all.x=TRUE)
I <- I[I$time < 2007 & I$geo == "EU15",]

X <- rbind(X, I)
X <- X[order(X$time),]

I <- get_eurostat("ei_cphi_m", time_format = "num")
I <- I[I$indic == "CP-HI00" & I$unit == "HICP2015", ]
I <- I[, -c(1:3)]
names(I)[3] <- "INF"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

U <- X[seq(1,57,2),]
P <- c("5.484742751","6.217376909","4.854166667","4.718413284","4.42664550286656","3.55884083117293","3.11207791953274","2.41551787239232","2.15717918055056","3.15076707022592","3.37396699038281","2.42443661219694","2.09199838997658","2.28621706801675","2.48769665164086","2.66631494577072","2.51066565240339","4.1649719352477","0.83926224679384","1.53112270420924","3.28944939564212","2.66284165508017","1.21999342274305","0.199343826570849","-0.0616446800641176","0.183334861123848","1.42910743319297","1.73860861988181","1.63052260754338")
X$INF <- P
