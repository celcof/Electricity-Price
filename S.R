# download data by eurostat package
library(eurostat)
get_eurostat("nrg_ind_id", time_format = "num")
search_eurostat("dependency")$code

C <- read.table(file = 'eConsumption.tsv', sep = '\t', header = TRUE)
reshape(D,direction="long", varying = 2:13, sep="")

PRI <- PRI[grep("S2", PRI$TIME), ]
PRI$TIME <- gsub("S2", "", PRI$TIME)
write.csv(X, "X2.csv", row.names=F)
X$Nuclear <- gsub(NA, 0, X$Nuclear)
X <- merge(X, MS, by=c("TIME", "GEO"), all.x=TRUE)
X$Nuclear <- as.numeric(gsub(",","",X$Nuclear, fixed=TRUE))


# price of oil is taken from https://www.macrotrends.net/1369/crude-oil-price-history-chart

# simple linear model
A <- plm(log(Price) ~ Dependency + log(GDP) + Green + mShare + log(Quantity.Consumed) + log(Oil.Price) + Nuclear, X, model="pooling")

# fixed time effects model
B <- plm(log(Price) ~ Dependency + log(GDP) + Green + mShare + log(Oil.Price)+ log(Quantity.Consumed) + Nuclear, X, index=c("GEO", "TIME"), model="within", effect="time")
summary(fixef(B), type="dmean")