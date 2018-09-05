source("code/packageload.R") 

data <-
  read_rds("data/Fin_Data_SA_US_NKY.rds")

data <- na.omit(data)

MonthlyReturns <- 
  data %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, Ticker) %>% 
  mutate(YM = format(date,"%Y_%B")) %>% 
  ungroup() %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, YM) %>%
  filter(date == last(date)) %>% 
  ungroup() %>% 
  group_by(Ticker) %>%
  arrange(date) %>% 
  mutate(Returns = TRI/lag(TRI) - 1) %>% 
  mutate(Returns = coalesce(Returns, 0)) %>%  
  ungroup() %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, YM) %>% 
  mutate(SectorMarketCap = sum(Market.Cap)) %>%
  mutate(WeightedMarketCap = Market.Cap/SectorMarketCap) %>% 
  mutate(WeightedReturns = sum(Returns*WeightedMarketCap)) %>% 
  summarise(IndexReturn = mean(WeightedReturns)) %>%
  ungroup()

MonthlyReturns_Sharpe <- 
  MonthlyReturns  %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME) %>% 
  summarise(Sharpe = mean(MonthlyReturns, na.rm = TRUE) / sd(MonthlyReturns, na.rm = TRUE)) %>%
  ungroup() 

Fin_Index_Returns <-
  MonthlyReturns %>% 
  group_by(BICS_LEVEL_1_SECTOR_NAME) %>% 
  filter(BICS_LEVEL_1_SECTOR_NAME %in% "Financials") %>% 
  group_by(Universe, Ticker) %>% 
  mutate(Cum_IndexReturns = cumprod(1 + IndexReturn)) %>% 
  ungroup()
  ggplot(Fin_Index_Returns) +
  geom_line(aes(x = date, y = Cum_IndexReturns, color=Universe))

MonthlyReturns_JALSH <- 
  data %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, Ticker) %>% 
  mutate(YM = format(date,"%Y_%B")) %>% 
  ungroup() %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, YM) %>%
  filter(date == last(date)) %>% 
  ungroup() %>% 
  group_by(Ticker) %>%
  arrange(date) %>% 
  mutate(Returns = TRI/lag(TRI) - 1) %>% 
  mutate(Returns = coalesce(Returns, 0)) %>%  
  ungroup() %>% 
  group_by(Universe, BICS_LEVEL_1_SECTOR_NAME, YM) %>% 
  mutate(SectorMarketCap = sum(Market.Cap)) %>%
  mutate(WeightedMarketCap = Market.Cap/SectorMarketCap) %>% 
  filter(Universe %in% "JALSHAll") %>% 
  arrange(WeightedMarketCap) %>% 
  mutate(CumWeight = cumsum(WeightedMarketCap)) %>% 
  filter(CumWeight >= 0.05) %>% 
  mutate(WeightedReturn = sum(Returns*WeightedMarketCap)) %>%
  summarise(JALSHReturn = mean(WeightedReturn)) %>%
  ungroup()

Mat_IndexReturns <-
  data %>% 
  group_by(BICS_LEVEL_1_SECTOR_NAME) %>% 
  filter(BICS_LEVEL_1_SECTOR_NAME %in% "Materials") %>% 
  group_by(Ticker) %>%
  arrange(date) %>% 
  mutate(Returns = TRI/lag(TRI) - 1) %>% 
  mutate(Returns = coalesce(Returns, 0)) %>%  
  ungroup() %>% 
  group_by(Universe, date) %>% 
  mutate(SectorMarketCap = sum(Market.Cap)) %>%
  mutate(WeightedMarketCap = Market.Cap/SectorMarketCap) %>% 
  mutate(WeightedReturns = sum(Returns*WeightedMarketCap)) %>% 
  summarise(IndexReturn = mean(WeightedReturns)) %>%
  ungroup() %>% 
  
  tbl_xts(., cols_to_xts = "IndexReturn", spread_by = "Universe")
  
  chart.RollingPerformance(R = Mat_IndexReturns, FUN = "sd", 
                         width = 60, main = "Rolling 60 Day Standard Deviation for Materials Sector", 
                         legend.loc = "bottom")


