library(tidyr)
library(dplyr)

dataX <- read.table("dataset_X.csv", sep=",",header=T)

head(dataX)

?select

dataX %>% select(1:11) #this function removes the columns that come after the first 11

dataX %>% select(!Month) #this function selects every column EXCEPT the month column


#FILTER

dataX %>% 
  filter(Cat_3 > 9) #removes all the rows when cat3 is less than 9

dataX %>% 
  filter(Cat_3 > 9  & Dog_3 > 2) #you can do two of these at once 

dataX %>% 
  filter(Month == "January") %>%
  filter(Cat_3 > 7)

dataX %>%
  filter(Month =="January" | Month == "November") %>%
  filter(Cat_3 > 7)

#RENAME
dataX <- read.table("dataset_X.csv", sep=",",header=T)
dataX %>% rename(Dog_4=Dag_4,
                   Cat_2=cap_2)

fixNamesDogs <- function(x) {gsub("ag","og",x)}
fixNamesCats <- function(x) {gsub("ap","at",x)}

dataX <- dataX %>% 
  rename_with(fixNamesDogs, matches("Dag")) %>%
  rename_with(fixNamesCats, matches("Cap")) %>%
  select(!starts_with("X")) %>%
  rename_with(tolower, everything())

dataX



#The First Pivot

dataX<-dataX %>%
  select(!starts_with("X")) %>% #  getting rid of those unwanted empty columns
  rename_with(fixNamesDogs, matches("Dag")) %>%  # correcting Dog names (as above)
  rename_with(fixNamesCats, matches("Cap")) %>%  # correcting Cat names (as above)
  rename_with(tolower,everything()) %>%  # making all headers lower case (as above)
  pivot_longer(matches("_"), 
               values_to = "count",
               names_to = "spp")

dataX


#SEPARATE
dataX <- read.table("dataset_X.csv", sep=",",header=T)
dataX <- dataX %>%
  select(!starts_with("X")) %>%
  rename_with(fixNamesDogs, matches("Dag")) %>%
  rename_with(fixNamesCats, matches("Cap")) %>%
  rename_with(tolower, everything()) %>%
  pivot_longer(matches("_"),
               values_to = "count",
               names_to = "spp") %>%
  separate_wider_delim(spp,
                       delim = "_",
                       names = c("animal","tag"))

dataX


#MUTATE
dataX <- read.table("dataset_X.csv", sep = ",", header = TRUE)

dataX <- dataX %>%
  select(!starts_with("X")) %>% 
  rename_with(fixNamesDogs, matches("Dag")) %>% 
  rename_with(fixNamesCats, matches("Cap")) %>% 
  rename_with(tolower, everything()) %>% 
  pivot_longer(
    cols = matches("_"),
    values_to = "count",
    names_to = "spp"
  ) %>% 
  separate_wider_delim(
    spp,
    delim = "_",
    names = c("animal", "tag")
  )

library(tidyverse)

dataX <- read.table("dataset_X.csv", sep = ",", header = TRUE)

dataX <- dataX %>%
  select(!starts_with("X")) %>% 
  rename_with(fixNamesDogs, matches("Dag")) %>% 
  rename_with(fixNamesCats, matches("Cap")) %>% 
  rename_with(tolower, everything()) %>% 
  pivot_longer(
    cols = matches("_"),
    values_to = "count",
    names_to = "spp"
  ) %>%
  mutate(spp = gsub("_", " ", spp))

dataX


#Mutate --> Replacing Values With Mutate

casesdf <- read.table("WMR2022_reported_cases_3.txt",
                      sep="\t",
                      header=T,
                      na.strings=c("")) %>% 
  fill(country) %>% 
  pivot_longer(cols=c(3:14),
               names_to="year",
               values_to="cases") %>%
  pivot_wider(names_from = method,
              values_from = cases)

casesdf

casesdf <- casesdf %>% rename(c("suspected" = "Suspected cases",
                                "examined" = "Microscopy examined",
                                "positive" = "Microscopy positive"))

casesdf

str(casesdf)

casesdf <- casesdf %>% mutate(year=gsub("X","",year))
casesdf

casesdf <- casesdf %>% mutate(year=as.numeric(gsub("X","",year)))
casesdf

str(casesdf)

unique(casesdf$country)
unique(casesdf$suspected)
unique(casesdf$positive)

casesdf<-casesdf %>%
  mutate("country"=gsub("[0-9]","",country)) 

casesdf

casesdf <- casesdf %>%
  mutate(suspected = as.numeric(gsub("[^0-9]", "", suspected)))
casesdf

clean_number <-function(x) {as.numeric(gsub("[^0-9]}","",x))}


#i made a function called clean_number so that i can just use that function instead of typing it out so many times
casesdf %>% mutate(across(c(suspected,examined,positive),clean_number))

casesdf<-casesdf %>% mutate(across(!country,clean_number)) 
casesdf

#Calculations with Mutate

casesdf<-casesdf %>% 
  mutate(across(!country,clean_number)) %>%
  mutate(test_positivity = round(positive / examined,2)) 

casesdf

str(casesdf)

casesdf <- casesdf %>% mutate(country = as.factor(country)) 

str(casesdf)

levels(casesdf$country)

#so we made countries a factor with 6 levels

casesdf <- casesdf %>% 
  mutate(country = gsub("Eritrae",
                        "Eritrea",
                        country)) %>%
  mutate(country = as.factor(country)) 

casesdf

#this just spelt eritrea correctly and alos made country a factor

#Write To File

write.table(casesdf, "WMR2022_reported_cases_clean.txt",
            sep="\t",
            col.names = T,
            row.names = F,
            quote = F)

casesdf


sessionInfo()
