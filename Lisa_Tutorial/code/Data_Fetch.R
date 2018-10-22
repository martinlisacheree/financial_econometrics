dailydata <- read_csv("https://raw.githubusercontent.com/Nicktz/ExDat/master/extdata/findata.csv", 
                      col_types = cols(.default = "d", Date = "D"))

# Clean data
tidydata <- 
  dailydata %>% 
  gather("Stock", "Close", -Date) 


#Saving cleaned data
#write.csv(dailydata, "data/cleandata.csv")


#data <- read.csv("data/cleandata.csv")