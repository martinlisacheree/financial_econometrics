<<<<<<< HEAD
dailydata <- read_csv("https://raw.githubusercontent.com/Nicktz/ExDat/master/extdata/findata.csv", 
                      col_types = cols(.default = "d", Date = "D"))

# Clean data
tidydata <- 
  dailydata %>% 
  gather("Stock", "Close", -Date) 


#Saving cleaned data
#write.csv(dailydata, "data/cleandata.csv")


=======
dailydata <- read_csv("https://raw.githubusercontent.com/Nicktz/ExDat/master/extdata/findata.csv", 
                      col_types = cols(.default = "d", Date = "D"))

# Clean data
tidydata <- 
  dailydata %>% 
  gather("Stock", "Close", -Date) 


#Saving cleaned data
#write.csv(dailydata, "data/cleandata.csv")


>>>>>>> 3dc00ed77eacc1a7de76b869918382bec92f4710
#data <- read.csv("data/cleandata.csv")