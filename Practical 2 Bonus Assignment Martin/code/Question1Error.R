
MonthlyReturns <- 
  #Finding the last observation of each month for each ticker in each sector per country
  data %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, Ticker) %>% 
  mutate(YM = format(date,"%Y_%B")) %>% 
  ungroup() %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, YM) %>%
  filter(date == last(date)) %>% 
  ungroup() %>% 
  
  #Calculating the total market cap at month end for each sector
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, date) %>% 
  mutate(SectorMarketCap = sum(Market.Cap)) %>% 
  
  #Calculating monthly returns using market cap values instead of prices
  mutate(IndexReturn = (SectorMarketCap/lag(SectorMarketCap)) -1) %>% 
  
  ungroup()