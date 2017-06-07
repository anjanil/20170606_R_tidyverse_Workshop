# We are loading the tidyverse package


library("tidyverse")

#Read in the data from directory. Call the dataset "gapminder"

gapminder <- read_csv(file = "Data/gapminder-FiveYearData.csv")

gapminder
