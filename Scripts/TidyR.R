library(tidyr)
library(tidyverse)


#TIDYR FILES:

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")

library("readxl")

gapminder

fert <- indicator_undata_total_fertility %>%
  rename (country= `Total fertility rate`) %>%
  gather(key=year, value=fert,-country) %>%
  mutate(year=as.integer(year))
fert
