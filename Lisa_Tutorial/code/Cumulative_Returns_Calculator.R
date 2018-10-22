<<<<<<< HEAD
cumporteqw <- porteqw %>% 
  xts_tbl() %>% 
  mutate(portfolio.returns = coalesce(portfolio.returns, 0)) %>% 
=======
cumporteqw <- porteqw %>% 
  xts_tbl() %>% 
  mutate(portfolio.returns = coalesce(portfolio.returns, 0)) %>% 
>>>>>>> 3dc00ed77eacc1a7de76b869918382bec92f4710
  mutate(Cum_Ret = cumprod(1+portfolio.returns))