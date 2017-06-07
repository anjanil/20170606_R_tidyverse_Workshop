# We are loading the tidyverse package


library("tidyverse")

#Read in the data from directory. Call the dataset "gapminder"

gapminder <- read_csv(file = "Data/gapminder-FiveYearData.csv")

gapminder

#Make a plot from the gapminder dataset (+ merket indikerer at kommando fortsetter i neste linje)

ggplot(data = gapminder) +
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp))


#3 dimensjoner
ggplot(data = gapminder) +
  geom_jitter(mapping = aes(x = gdpPercap, y = lifeExp, color = continent))

#4 dim
ggplot(data = gapminder) +
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent, size = pop))


# Hvis man vil ha samme format og farge på alle parametre må det stå utenfor "aes" klammen
ggplot(data = gapminder) +
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp), alpha= 0.1, size=2, color= "blue") 


ggplot(data = gapminder) +
  geom_line(mapping = aes(x = year, y = lifeExp, group=country, color= continent))

#Boxplot
ggplot(data = gapminder) +
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))

#Boxplot og poinplot i samme plot (kan bytte på hva som vises foran og bak ved å bytte om på rekkefølgen):
ggplot(data = gapminder) +
  geom_jitter(mapping= aes(x = continent, y = lifeExp, color = continent))+
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))




#Enklere måte å bruke kommando over på:
ggplot(data = gapminder, mapping = aes (x = continent, y = lifeExp, color = continent)) +
  geom_jitter()+
  geom_boxplot()

ggplot(data = gapminder) +
  geom_jitter(mapping= aes(x = continent, y = lifeExp, color = continent, size = pop))+
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))
            
ggplot(data = gapminder) +
  geom_jitter(mapping= aes(x = continent, y = lifeExp, color = continent))+
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))

#lm = linear model (one line pr continent)
ggplot(data = gapminder, mapping = aes (x = log(gdpPercap), y = lifeExp, color = continent)) +
  geom_jitter(alpha=0.1)+
  geom_smooth(method = "lm")


# linear model not split by contitnent
ggplot(data = gapminder, mapping = aes (x = log(gdpPercap), y = lifeExp)) +
  geom_jitter(mapping = aes (color = continent), alpha=0.1)+
  geom_smooth(method = "lm")

# Bruke as.factor for å kategorisere variablene
ggplot(data = gapminder) +
  geom_boxplot(mapping = aes(x = as.factor (year), y = lifeExp))

ggplot(data = gapminder) +
  geom_boxplot(mapping = aes(x = as.factor (year), y = log(gdpPercap)))

ggplot(data = gapminder) +
  geom_density2d(mapping = aes(x = lifeExp, y = log(gdpPercap)))

#Split the data pr continent (geom_smooth= loess), 
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()+
  geom_smooth()+
  scale_x_log10()+
  facet_wrap(~ continent)

#Split the data pr year an g with a linear model "lm":
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()+
  geom_smooth(method = "lm")+
  scale_x_log10()+
  facet_wrap(~ year)

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()+
  geom_smooth(method = "lm")+
  scale_x_log10()+
  facet_wrap(~ continent)

#Filter function:
filter(gapminder, year==2007)

ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping = aes(x = continent))

ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping = aes(x = continent), stat = "count")

#Filtrere med to variable (år og continent):
filter(gapminder, year==2007, continent=="Oceania")

ggplot(data=filter(gapminder, year==2007, continent=="Oceania"))+
  geom_bar(mapping = aes(x = country, y =pop), stat = "identity")

ggplot(data=filter(gapminder, year==2007, continent=="Oceania"))+
  geom_col(mapping = aes(x = country, y =pop))

ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
  geom_col(mapping = aes(x = country, y =pop))

# Flip coordinates for more readability
ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
  geom_col(mapping = aes(x = country, y =pop))+
  coord_flip()


ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
  geom_col(mapping = aes(x = country, y =pop))+
  coord_flip()  

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/10^6)) +
  geom_point()+
  scale_x_log10()+
  facet_wrap(~ year)

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/10^6)) +
  geom_point()+
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title="life expectancy vs GDP pr capita over time", subtitle="In the last 50 year life exp has improved",
  caption="Source: Gapminder foundation, gapminder.com", x="GDP pr capita, in 100 USD", y = "life expectancy in years", color="Continent", size="population, in millions")

ggsave("my_fancy_plot.tiff", dpi = 600)



