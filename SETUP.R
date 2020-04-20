# download data by eurostat package
library(eurostat)

# electricity price data
X <- get_eurostat("ten00117", time_format = "num")
X <- X[grep("MSHH", X$indic_en), c(5:7)]
X <- X[!(X$geo %in% c("EU28", "NO", "TR", "EA", "EU27_2020", "AL", "BA", "GE", "IS", "LI", "MD", "ME", "MK", "RS", "UA", "XK")),]
names(X)[3] <- "PRI"
X$geo <- as.factor(as.character(X$geo))

# dependency
I <- get_eurostat("nrg_ind_id", time_format = "num")
I <- I[grep("TOTAL", I$siec), ]
I <- I[,c(3:5)]
names(I)[3] <- "DEP"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# consumption
I <- get_eurostat("sdg_07_20", time_format = "num")
I <- I[, -1]
names(I)[3] <- "CON"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# real gdp per capita
I <- get_eurostat("sdg_08_10", time_format = "num")
I <- I[grep("CLV10_EUR_HAB", I$unit), ]
I <- I[, -c(1,2)]
names(I)[3] <- "GDP"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# oil price
time <- c(2008:2019)
OIL <- c(99.67,61.95,79.48,94.88,94.05,97.98,93.17,48.72,43.58,50.84,64.90,57.05)
I <- data.frame(time, OIL)
X <- merge(X, I, by="time", all.x=TRUE)

# share of renewable energy
I <- get_eurostat("sdg_07_40", time_format = "num")
I <- I[I$nrg_bal == "REN", ]
I <- I[, -c(1,2)]
names(I)[3] <- "REN"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# nuclear energy production
search_eurostat("nuclear")$code
I <- get_eurostat("nrg_inf_nuc", time_format = "num")
I <- I[grep("PRD_NUCH", I$plant_tec), ]
I <- I[,c(3:5)]
names(I)[3] <- "NUC"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# price index
I <- get_eurostat("prc_hicp_aind", time_format = "num")
I <- I[grep("CP00", I$coicop), ]
I <- I[grep("INX_A_AVG", I$unit), c(3:5)]
names(I)[3] <- "CPI"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# emissions
I <- get_eurostat("sdg_13_20", time_format = "num")
I <- I[,-1]
names(I)[3] <- "EMI"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# market concentration
I <- get_eurostat("ten00119", time_format = "num")
I <- I[,c(4:6)]
names(I)[3] <- "MAR"
X <- merge(X, I, by=c("time", "geo"), all.x=TRUE)

# substitute NA with zero for nuclear capacity
for (row in 1:length(X$NUC)){
  if(X$time[row] %in% c(2009:2018) & is.na(X$NUC[row])){
    X$NUC[row] <- 0
  }
}
for (country in levels(X$geo)){
  X[X$time == 2008 & X$geo == country, "NUC"] <- X[X$time == 2009 & X$geo == country, "NUC"]
}
# substitute NA for Market Concentration

# of Bulgaria. we miss values until 2012: we just substitute with first value available (2013)
X[X$geo == "BG" & X$time %in% c(2008:2012), "MAR"] <- X[X$geo == "BG" & X$time == 2013, "MAR"]

# of Germany.
# goes from 28.4 in 2010 to 32.0 in 2013. we expect linear behaviour
in2011 <- 28.4 + (32 - 28.4) / 3
in2012 <- in2011 + (32 - 28.4) / 3
X[X$geo == "DE" & X$time == 2011, "MAR"] <- in2011
X[X$geo == "DE" & X$time == 2012, "MAR"] <- in2012

# of Greece. in 2011, average between previous and subsequent years
X[X$geo == "EL" & X$time == 2011, "MAR"] <- mean(c(X[X$geo == "EL" & X$time == 2010, "MAR"], X[X$geo == "EL" & X$time == 2012, "MAR"]))

# of Luxembourg. we miss values until 2009: we just substitute with first value available (2010)
X[X$geo == "LU" & X$time %in% c(2008:2009), "MAR"] <- X[X$geo == "LU" & X$time == 2010, "MAR"]

# of Austria. we miss values until 2010: we just substitute with first value available (2011)
# also miss values from 2014 on. substitute with ones from 2013
X[X$geo == "AT" & X$time %in% c(2008:2010), "MAR"] <- X[X$geo == "AT" & X$time == 2011, "MAR"]
X[X$geo == "AT" & X$time %in% c(2014:2018), "MAR"] <- X[X$geo == "AT" & X$time == 2013, "MAR"]

# of Netherlands: average year values from Belgium, Luxembourg and Germany
# also take a look at https://www.sciencedirect.com/science/article/pii/S0301421518308061
for (i in 1:nrow(X)) {
  year <- X$time[i]
  if (X$geo[i] == "NL" && X$time[i] != 2019){
    DEvalue <- X[X$geo == "DE" & X$time == year, "MAR"]
    BEvalue <- X[X$geo == "BE" & X$time == year, "MAR"]
    LUvalue <- X[X$geo == "LU" & X$time == year, "MAR"]
    DKvalue <- X[X$geo == "DK" & X$time == year, "MAR"]
    NLvalue <- mean(c(DEvalue, BEvalue, LUvalue, DKvalue), na.rm=T)
    X[X$geo == "NL" & X$time == year, "MAR"] <- NLvalue
  }
  X$MAR <- round(X$MAR,1)
}

# of UK we miss values from 2014 on. substitute with ones from 2013
X[X$geo == "UK" & X$time %in% c(2014:2018), "MAR"] <- X[X$geo == "UK" & X$time == 2013, "MAR"]