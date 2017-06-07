# GAPMINDER PLUS 
download.file(url = "https://raw.githubusercontent.com/dmi3kno/SWC-tidyverse/master/data/gapminder_plus.csv", 
              destfile = "Data/gapminder_plus.csv")
library(tidyverse)
gapminder_plus <- read_csv(file = "Data/gapminder_plus.csv")

gapminder_plus

#Sortere ut land i Africa 
gapminder_plus %>%
  filter(continent=="Africa") %>%
  mutate(babies_dead=infantMort*pop/1000) %>%  #Lager en ny kolonne i datasettet "babies_dead"#
  filter(babies_dead>2e6, year==2007) %>%
  select(country) %>%
#"left_join# av de filtrerte dataene til de ufiltrerte dataene, #filtreres på basis av de filtrerte landene#  
  left_join(gapminder_plus) %>%
  mutate(gdp_bln=gdpPercap*pop/1e9, pop_mln=pop/1e9)%>%
  select(-c(continent, pop)) %>%
  gather(key= variables, value= values, -c(country, year))%>%
  ggplot()+
  geom_text(data=. %>% filter(year==2007) %>% group_by(variables) %>% 
              mutate(max_value=max(values)) %>% filter(values==max_value),
            aes(x=year, y=values, label = country, color=country))+
  geom_line(mapping = aes(x=year, y= values, color = country))+
  facet_wrap(~variables, scales="free_y")+
  labs(title= "kjhj", subtitle="kljk", caption ="jkjk", y=NULL, X ="Year")+
  theme_bw()+
  theme(legend.position = "none")
  
  
