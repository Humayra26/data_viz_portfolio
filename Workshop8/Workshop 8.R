install.packages("palmerpenguins")
library(palmerpenguins)
library(tidyverse)

print (penguins)

ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g))
#this gives a scatterplot but its black and white


ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g, colour = species, shape = island))
#this is gonna give it colour per species and shape per island



ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_smooth(mapping = aes(x = bill_length_mm, y = body_mass_g))
#this is trying to see if the data is separated by island

ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth()

ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species, shape=island)) +
  geom_smooth(mapping = aes(colour = species))

ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(mapping = aes(colour = species, shape=species))
pengu_plot +
  geom_smooth(method=lm, se=F, aes(colour = species))

#this made the line of best fit kind of thing straight and not curved ^

#-----------------Question 3------------------

ggsave(filename = "PenguinPlot1.png", plot = pengu_plot, width = 300,height = 200, units=("mm"))
#this saves the plot as 300mm wide and 200mm tall, and the units as mm

ggsave("penguin_plot_2.png") #this function will save the most recent plot you make


#-----------------Question 4------------------

ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(fill = species, colour=species))

#so most data is in alphabetical order, but that would be annoying for days of the week

df_days <-
  data.frame(day = c("Mon", "Tues", "Wed", "Thu"),
             counts = c(3, 8, 10, 5))
df_days$day <- as.factor(df_days$day)
str(df_days)
#u know in this ^ u didnt define the levels in the order you want, it automatically
#does it as alphanumerical

ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()


df_days$day <- factor(df_days$day, levels = c("Mon", "Tues", "Wed", "Thu"))
str(df_days)
ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()

#this is now in the order that I ASKED FOR and therefore, it's normal


#reproduce the violin looking plots

df_penguins <- penguins
df_penguins$species <-
  factor(df_penguins$species, levels = c("Chinstrap", "Gentoo", "Adelie"))
str(df_penguins)

ggplot(data = df_penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(mapping = aes(fill = island))

#so we had to reorder the levels because we wanted a specific order that isn't alphabetical


#-----------------Question 5------------------

ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  coord_flip()

?geom_bar() #so geom_bar is only x and its against count
?geom_col()# and geom_col is x and y


#-----------------Question 6------------------

penguins %>% filter(!species == "Chinstrap") %>%
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species, shape = island))


penguins %>% filter(!is.na(sex)) %>%
  ggplot(mapping = aes(x = species, y = body_mass_g )) +
  geom_violin(mapping = aes(fill = sex))

#here we filtered, we removed the NA's from the sex column and then we plotted, filled it by sex


#-----------------Question 7------------------

penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       fill = "Sex",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  )


penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(fill = sex)) +
  geom_point(aes(shape = sex), position = position_jitterdodge(),alpha=0.5)+
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  ) +
  scale_fill_discrete(name = "Sex", # the legend title can be changed here or in labs()
                      labels = c("Female", "Male", "Unknown"),
                      type = c("yellow", "magenta", "grey"))



