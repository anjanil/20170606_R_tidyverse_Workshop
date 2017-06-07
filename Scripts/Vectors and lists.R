#Vectors (same typeof data in one element (either numeric or ))

x <- 5 * 6
x
is.vector(x)
length(x)
x[2] <-31
x

x[5] <-44
x


x[11]

x[0]

x <- 1:4
x

y <- x^2
y

x <- 1:5

y <- 3:7

x
y
x+y

z <- y[-5]

x + z

z <- 1:10

x+z

z^x

y <- x[-5]
y[5] <-NA
x+y

str(c("Hello", "workshop", "Particitpants"))

c(9:11, 200,x)
str(c(9:11, 200,x))

c("something", pi, 2:4, pi>3)

str(c(pi, 2:4, pi>3))

str(c("something", pi, 2:4, pi>3))
str(c(2L:4L, pi>3))

w <- rnorm(10)
seq_along(w)
w
which(w < 0)
w[which(w < 0)]

w[-c(2,5)]

#Lists (different types of data in one element)

list("something", pi, 2:4, pi> 3)
str(list("something", pi, 2:4, pi> 3))

x <- list(vegetable = "cabbage",
     number = pi,
     series = 2:4,
     telling = pi > 3)

str(x)

x$vegetable

x[1] 
str(x[1] )

x[3]
str(x[[3]])

x <- list(vegetable = list("cabbage", "carrot", "spinach"),
          number = list(c(pi,0,2.14,3:5)),
          series = list(list(2:4, 3:5)),
          telling = pi > 3)
str(x)

str(x$vegetable)

#Practice: how to fetch an element

mod <-lm(lifeExp ~gdpPercap, data=gapminder_plus)
mod
str(mod)
mod[["df.residual"]]
mod$df.residual
mod["df.residual"]
mod[8]

mod$qr$qr[1,1]



gapminder_plus %>% 
  group_by(continent)%>%
  summarize(mean_le=mean(lifeExp), min_le=min(lifeExp), max_le=max(lifeExp))

gapminder_plus %>%
  ggplot() +
  geom_line(mapping=aes(x=year, y=lifeExp, color=continent, group=country))+
  geom_smooth(mapping=aes(x=year, y=lifeExp), metod="lm", color="black") +
  facet_wrap(~ continent)
  
by_country <- gapminder_plus %>% group_by(continent, country) %>% 
  nest()

by_country$data[[1]]

#map(list, function)

map(1:3, sqrt)

by_country %>% 
  mutate(model=map(data, ~lm(lifeExp~year, data=.)))

library(purrr)

by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.))) 
  
model_by_country <- by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.))) %>% 
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% 
  ggplot()+
  geom_jitter(mapping=aes(x=continent, y=r.squared))

model_by_country
model_by_country$summr[[1]]

by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.))) %>% 
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.3) %>% 
  select(country) %>%
  left_join(gapminder_plus) %>% 
  ggplot() +
  geom_line(mapping=aes(x=year, y=lifeExp, color=country, group=country))
 

by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~gdpPercap, data=.))) %>% 
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.3) %>% 
  select(country) %>%
  left_join(gapminder_plus) %>% 
  ggplot() +
  geom_line(mapping=aes(x=log(gdpPercap), y=lifeExp, color=continent, group=country))

##life Exp over gdpPercap
by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~log(gdpPercap), data=.))) %>% 
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.1) %>% 
  select(country) %>%
  left_join(gapminder_plus) %>% 
  ggplot() +
  geom_point(mapping=aes(x=log(gdpPercap), y=lifeExp, color=country))

#SAve data
saveRDS(by_country, "by_country_tibble.rds")
write_csv(gapminder_plus, "gapminder_plus_for_professor.csv")
