##dplyr##

#les inn datasett:
library(tidyverse)
gapminder <- read_csv("Data/gapminder-FiveYearData.csv")
gapminder

#Repetere kommando:
rep("This is an example", times = 3)
"This is an example"%>% rep(times = 3)

# %>% for å gruppere data

#Selectere data ved overskriftene i datasettet (Select dataframe)
year_country_gdp <- select(gapminder, year, country, gdpPercap)
head (year_country_gdp)

year_country_gdp <- gapminder %>% select(year, country, gdpPercap)

gapminder %>%
  filter(year==2002) %>%
  ggplot(mapping = aes(x=continent, y=pop))+
  geom_boxplot()

year_country_gdp_euro <- 
  filter(country=="Europe") %>%
  select(year,country,gdpPercap)

country_lifeExp_Norway <- gapminder %>%
  filter(country=="Norway") %>%
  select(year, lifeExp, gdpPercap)

country_lifeExp_Norway

gapminder %>%
  group_by(continent)

gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdPercap=mean(gdpPercap)) %>%
  ggplot(mapping = aes(x=continent, y=mean_gdPercap))+
  geom_point()

#Filtrere ut land med min og max gjennomsnittlig forventet levealder
gapminder %>%
  filter(continent=="Asia") %>%
  group_by(country) %>%
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  filter(mean_lifeExp==min(mean_lifeExp)|mean_lifeExp==max(mean_lifeExp)) %>%
  ggplot(mapping = aes(x=country, y=mean_lifeExp))+
  geom_point()+
  order()+
  coord_flip()


#Sortere ut land i Asia og gruppere pr land gjennomsnittlig levealder
gapminder %>%
  filter(continent=="Asia") %>%
  group_by(country) %>%
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  ggplot(mapping = aes(x=reorder(country, mean_lifeExp), y=mean_lifeExp))+
  geom_point()+
  coord_flip()

#Funksjonen mutate

gapminder %>%
  mutate(gdp_billion=gdpPercap*pop/10^9) %>%
  head()

gapminder %>%
  mutate(gdp_billion=gdpPercap*pop/10^9) %>%
  group_by(continent, year) %>%
  summarize(mean_gdp_billion=mean(gdp_billion))

gapminder_country_summary <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp))

#Visualize lifeExp pr country with library "maps":

library(maps)

map_data("world") %>%
  head()

#rename "region" to "country" og plotte data gra gapminder i world map:

map_data("world") %>%
  rename(country=region) %>%
  left_join(gapminder_country_summary, by="country") %>%
  ggplot()+
  geom_polygon(aes(x=long, y=lat, group=group,fill = mean_lifeExp))+
  scale_fill_gradient(low="blue", high="red")+
  coord_equal()
