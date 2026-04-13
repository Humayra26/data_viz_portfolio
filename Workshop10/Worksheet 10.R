install.packages("tidyverse")
install.packages("patchwork")
library(tidyverse)
library(RColorBrewer)
library(patchwork) 

measles <- read.table("measles_cases_clean.txt", header = T, sep = "\t")
vacc_rates <- read.table("measles_vaccination_clean.txt", header = T, sep = "\t")

# What are the variables? Which years are covered? You may have to google what some of the variables mean.

# variables = entity, year, cases, continent, the group (country), coverage and antigen
# years = 1980-2023

#graph 1
measles %>%
  filter(!year<"1980")%>%
  filter(entity=="United Kingdom")%>%
  ggplot(mapping = aes(x=year, y=cases))+
  geom_point()+
  geom_line()+
  labs(title ="Measles cases in the UK since 1980")

#graph 2
measles %>%
  filter(!year<"1980")%>%
  filter(entity=="United Kingdom")%>%
  ggplot(mapping = aes(x=year, y=cases))+
  geom_point()+
  scale_y_log10()+
  geom_line()+
  labs(title ="Measles cases in the UK since 1980")

#graph 3
measles %>%
  filter(!year<"1980")%>%
  filter(entity=="United Kingdom")%>%
  ggplot(mapping = aes(x=year, y=cases))+
  geom_point()+
  scale_y_log10(breaks=c(10,100,1000,10000,100000),labels=c("10","100","1,000","10,000","100,000"))+
  geom_line()+
  labs(title ="Measles cases in the UK since 1980")


# graph 4
vacc_rates %>%
  filter(!year<"1980")%>%
  filter(entity=="United Kingdom")%>%
  filter(coverage_category=="WUENIC")%>%
  ggplot(mapping = aes(x=year, y=coverage))+
  geom_point(mapping = aes(colour=antigen))+
  geom_line(mapping=aes(colour=antigen))+
  labs(title ="Vaccination rates dropped sharply from 1988 onwards but recovered later.")

#Section 3 - Summary Tables
measles %>%
  group_by(year)

world_cases <- measles %>%
  drop_na() %>% 
  group_by(year) %>% 
  summarise(total = sum(cases))

#graph 5

world_cases %>%
  filter(!year<"1980")%>%
  ggplot(mapping = aes(x=year, y=total))+
  geom_col(data=world_cases, mapping = aes(x=year, y=total))

continent_cases <-measles %>%
  group_by(year) %>%
  group_by(continent)%>%
  summarise(total=sum(cases))
  
  
  ggplot(mapping = aes(x=year, y=total))+
  geom_col(data=world_cases, mapping = aes(x=year, y=total))+
  geom_point(mapping = aes(colour=continent))
  

