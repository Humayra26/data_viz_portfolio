beetles1 <- read.csv("beetles_v1.csv")
beetles1

beetles2 <- read.csv("beetles_v2.csv")
beetles2

beetles3 <- read.csv("beetles_v3.csv")
beetles3

beetles4 <- read.csv("beetles_v4.csv")
beetles4

usites <- unique(beetles1$Site)
length(usites)

colnames(beetles1)[3:ncol(beetles1)]

usites_beetle3 <-unique(beetles3$spp)
length(usites_beetle3)

#table 4 allows us to look at all unique values for Sites, Months and Species

str(beetles4) 
summary(beetles4)
head(beetles4)
View(beetles4)   # <-- this one is in Rstudio only

beetlesdf <- read.table("beetles_read_1.csv", sep=",",header=T)  # notice how we set the separator
beetlesdf

?read.table()

read.table("beetles_read_2.txt", sep="\t", header=T)


read.table("beetles_read_3.txt", sep="\t",header=F, fill=TRUE)

#question 5. Fill --------------------------------------------------------

library(tidyr)

?fill()
fill(beetlesdf,Site)  

beetlesdf <- fill(beetlesdf,Site)  #careful - this is a common source of errors, this one is wrong
beetlesdf

beetlesdf2 <- read.table("beetles_read_4.txt", sep="\t", header=T, na.strings="-")

beetlesdf2 <- fill(beetlesdf2,Site)
beetlesdf2

#question 6. The Pipe --------------------------------------------------------

beetlesdf <- read.table("beetles_read_1.csv", sep=",",header=T) %>% fill(Site)
beetlesdf

#question 7. Pivoting --------------------------------------------------------

# 7.1 pivot_longer

pivot_longer(data=beetlesdf, cols = c("blue_beetle", "green_beetle", "purple_beetle", "red_beetle", "brown_beetle", "black_beetle", "orange_beetle", "white_beetle"),names_to="species")

beetlesdf

pivot_longer (
  beetlesdf,
  cols=contains ("beetle"),
  names_to="species"
)

pivot_longer(data=beetlesdf, cols = contains("blue") )

?(pivot_longer)

pivot_longer(data=beetlesdf, cols = c(3:10),names_to="species")

pivot_longer(data=beetlesdf, cols = contains("_be"), values_to = "count")


#--------------- Question 7.2 - pivot_wider -------------------

casesdf <- read.table("WMR2022_reported_cases_1.txt",sep="\t")
casesdf

#fix the code:

casesdf <- read.table("WMR2022_reported_cases_1.txt",
                      sep="\t",
                      header=T,
                      na.strings=c("")) %>% 
  fill(country)
casesdf

pivot_wider(casesdf,names_from="method",values_from ="n")

sessionInfo()
