# Question 1

# 2006 - 2008 
moments1 <-
  tidydata %>% 
  filter(ymd(20060101) <= Date & ymd(20081231) >= Date) %>% 
  group_by(Stock) %>% 
  summarise(mean = mean(Return, na.rm = T)*100, variance = var(Return, na.rm = T)*100) %>% 
  tbl_df()

# 2010 - 2013 
moments2 <-
  tidydata %>% 
  filter(ymd(20100101) <= Date & ymd(20131231) >= Date) %>% 
  group_by(Stock) %>% 
  summarise(mean = mean(Return, na.rm = T)*100, variance = var(Return, na.rm = T)*100) %>% 
  tbl_df()

#Data only goes up to 2015
# 2016 - July 2017 
#moments3 <-
#  tidydata %>% 
#  filter(ymd(20160101) <= Date & ymd(20170731) >= Date) %>% 
#  group_by(Stock) %>% 
#  summarise(period1_mean = mean(Return, na.rm = T), period1_variance = var(Return, na.rm = T)) %>% 
#  tbl_df()
