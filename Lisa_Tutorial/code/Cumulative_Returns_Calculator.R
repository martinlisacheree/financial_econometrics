cumporteqw <- porteqw %>% 
  xts_tbl() %>% 
  mutate(portfolio.returns = coalesce(portfolio.returns, 0)) %>% 
  mutate(Cum_Ret = cumprod(1+portfolio.returns))