#Return Calculation

tidydata <-
  tidydata %>% 
  group_by(Stock) %>% 
  mutate(Return = Close/lag(Close)-1) %>% 
  mutate(LogReturn = log(1 + Return/100)*100)

widedata <-
  subset(tidydata, select = -c(Close, Return)) %>% 
  spread(key = Stock, value = LogReturn) %>% 
  tbl_xts()
  
widedata <- na.omit(widedata)
