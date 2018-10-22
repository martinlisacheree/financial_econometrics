cl = makePSOCKcluster(10)

porteqw = Return.portfolio(widedata, weight = NULL, geometric = FALSE)

AC = autoarfima(as.numeric(porteqw), ar.max = 2, ma.max = 2, 
                criterion = "AIC", method = "partial", arfima = FALSE, include.mean = NULL, 
                distribution.model = "norm", solver = "solnp", cluster = cl)
#show(head(AC$rank.matrix))

garch11 <- ugarchspec(variance.model = list(model = c("sGARCH", 
                      "gjrGARCH", "eGARCH", "fGARCH", "apARCH")[1], garchOrder = c(2,2)), 
                      mean.model = list(armaOrder = c(1, 0), include.mean = TRUE), 
                      distribution.model = c("norm", "snorm", "std", "sstd", "ged", 
                                             "sged", "nig", "ghyp", "jsu")[1])

garchfit1 = ugarchfit(spec = garch11, data = as.numeric(porteqw))

# Note it saved a S4 class object - having its own plots and
# functionalities:
class(garchfit1)

