# ======================================
# 1. Load libraries
# 2. Import datasets
# 3. Clean health data
# 4. Clean demographic data
# 5. Merge datasets
# 6. Create visualisations (Panels 1–4)
# 7. Combine plots
# ======================================

# -------------------- Install and Load Libraries -------------------- 
# Install and load the libraries of these required packages
install.packages("tidyverse") #for data manipulation
install.packages("dplyr") #also for data manipulation
install.packages("ggrepel") #for labelling points clearly
install.packages("patchwork") #for combining multiple plots into one figure

library(tidyverse)
library(dplyr)
library(ggrepel)
library(patchwork)

# -------------------- Import Datasets -------------------- 

#Assign working directory to variable
wdir <- getwd()

# Import all of the datasets
health <- read.csv(file.path(wdir,"health_data.csv"))
demo <- read.csv(file.path(wdir,"demographics.csv"))
covid_data <- read.csv(file.path(wdir,"covid_data.csv"))

# -------------------- Clean health data -------------------- 

# Convert vaccine coverage columns from wide to long format, also splitting the column into 2
health <- health %>%
  pivot_longer(cols=,8:16,
    names_to = "vaccine",
    values_to = "coverage_percent")%>%
  separate(vaccine,
           into = c("vaccine_name", "vaccine_code"),
           sep = "\\.\\.(?=[^\\.]+\\.$)") %>% 
  # \\.\\. is to match the first ..
  # ?= means that the code should ONLY MATCH THAT .. IF it is followed by the rest of the code
  # ^\\. means any character that is not a dot
  # \\.$ means a dot at the end of the string
  
  # Clean vaccine text labels
  mutate(
    vaccine_name = gsub("\\.", " ", vaccine_name),
    vaccine_name = gsub("\\s+", " ", vaccine_name),
    vaccine_code = gsub("\\.$", "", vaccine_code)) %>%
  
  # Rename column names for consistency and clarity
  rename(
    country = Entity,
    country_code = Code,
    life_expectancy = Life.expectancy,
    alcohol_consumption = Alcohol.consumption,
    pm25_concentration = Concentrations.of.fine.particulate.matter..PM2.5,
    adult_obesity_prevalence = Prevalence.of.obesity.among.adults..BMI....30..) %>%
  
  # Standardise vaccine names, remove the word "vaccine" from vaccine_name
  mutate(vaccine_name = gsub(" vaccine", "", vaccine_name),
         vaccine_name = ifelse(vaccine_name == "H influenza type b","Haemophilus influenza type b", vaccine_name)) %>%
  
  # Convert column names to lowercase for consistency
  rename_with(tolower, everything()) 

# -------------------- Clean demo data -------------------- 

# Fill missing continent values and rename variables for consistency and clarity
demo <- demo %>%
  fill(World.region.according.to.OWID, .direction = "downup") %>%
  rename(country = Entity,
         continent = World.region.according.to.OWID,
         country_code = Code,
         che_percent_gdp = CHE.as.percentage.of.GDP,
         richest_1 = Richest.1.,
         next_9 = Next.9.,
         middle_40 = Middle.40.,
         poorest_50 = Poorest.50.) %>%
  
  # Remove the word "income" from income group labels
  mutate(Income_group = gsub( " income", "", Income_group)) %>%
  
  # Standardise column names to lowercase with underscores
  rename_with(~ gsub("\\.", "_", tolower(.)))

# -------------------- Create joined analysis dataset -------------------- 

# Filter the demo data for what I will be plotting
demo_health_covid <- demo %>%
  filter(year == 2020, continent == "Asia") %>%
  select(country, year, gdp_per_capita, population, continent, income_group, che_percent_gdp) %>%
 
   # Filter the health data that I will be plotting and join it with demo on the left and health on the right
  left_join(
    health %>%
      filter(year == 2020) %>%
      select(country, year, life_expectancy) %>%
      distinct(),
    by = c("country", "year")) %>%
  # Distinct() is important because of duplicated rows
  
  # Remove incomplete cases
  drop_na() %>%
  
  # Turning income_group into an ordered category so it appears in a logical order
  mutate(
    income_group = factor(
      income_group,
      levels = c("Low", "Lower middle", "Upper middle", "High"))) %>%
  
  # Add Covid variables, inner join only keeps variables that matches in both data, renaming any "." to "_"
  inner_join(
    covid_data %>%
      select(country, total_covid_deaths_per_million, total_covid_cases_per_million) %>%
      rename_with(~ gsub("[.]", "_", .)),
    by = "country") %>%
  
  #Calculate death rate and remove any NaN's
  mutate(
    covid_death_rate_per_million = total_covid_deaths_per_million / total_covid_cases_per_million) %>%
  filter(!is.nan(covid_death_rate_per_million))
    
# -------------------- Panel 1: GDP per capita vs life expectancy -------------------- 

# Plotting GDP per capita vs life expectancy in Asia (2020)
Plot_1 <- ggplot(demo_health_covid, aes(x = gdp_per_capita, y = life_expectancy)) +
  # Add scatter points, sized by population and coloured by income group
  geom_point(aes(size = population, colour = income_group)) +
  # Apply viridis colour scale for income group
  scale_colour_viridis_d(option = "viridis") +
  # Adjust point size scale and show min, median, and max population values
  scale_size_continuous(
    range = c(2, 10),
    breaks = c(
      min(demo_health_covid$population),
      median(demo_health_covid$population),
      max(demo_health_covid$population)),
    labels = scales::comma) +
  # Label countries with the highest and lowest GDP per capita and life expectancy
  geom_text_repel(
    data = demo_health_covid %>%
      filter(
        gdp_per_capita == max(gdp_per_capita, na.rm = TRUE) |
          gdp_per_capita == min(gdp_per_capita, na.rm = TRUE) |
          life_expectancy == max(life_expectancy, na.rm = TRUE) |
          life_expectancy == min(life_expectancy, na.rm = TRUE)),
    aes(label = country),
    colour = "black",
    na.rm = TRUE,
    segment.colour = "black",
    min.segment.length = 0,
    segment.size = 1) +
    # Set x-axis range, breaks, and comma formatting for GDP values
  scale_x_continuous(
    limits = c(0, 130000),
    breaks = seq(0, 130000, by = 25000),
    labels = scales::comma) +
  # Set y-axis range and breaks for life expectancy values
  scale_y_continuous(
    limits = c(60, 86),
    breaks = seq(60, 86, by = 5)) +
  # Add title, subtitle, axis labels, and legend titles
  labs(
    title = "Higher GDP per capita is associated with increased life expectancy in Asia (2020)",
    subtitle = str_wrap("Positive relationship between GDP per capita and life expectancy across Asian countries (2020), with higher-income countries generally exhibiting longer life expectancy."),
    x = "GDP per Capita (USD $)",
    y = "Life Expectancy (years)",
    colour = "Income Group",
    size = "Population") +
  # Apply a clean theme and remove legends
  theme_classic() +
  guides(colour = "none", size = "none")

# -------------------- Panel 2: Health expenditure vs Covid cases -------------------- 

# Plotting health expenditure vs total COVID-19 cases per million
Plot_2 <- ggplot(demo_health_covid, aes(x=che_percent_gdp, y=total_covid_cases_per_million, colour=income_group))+
  # Add scatter points, with point size representing population
  geom_point(aes(size = population))+
  # Apply viridis colour scale for income group
  scale_colour_viridis_d(option = "viridis")+
  # Label countries with the highest and lowest health expenditure and COVID-19 case rates
  geom_text_repel(
    data = demo_health_covid %>%
      filter(
        che_percent_gdp == max(che_percent_gdp, na.rm = TRUE) |
          che_percent_gdp == min(che_percent_gdp, na.rm = TRUE) |
          total_covid_cases_per_million == max(total_covid_cases_per_million, na.rm = TRUE) |
          total_covid_cases_per_million == min(total_covid_cases_per_million, na.rm = TRUE)),
    aes(label=country), 
    colour = "black", 
    na.rm = TRUE, 
    segment.colour = "black",
    min.segment.length = 0,
    segment.size=1,
    show.legend=FALSE)+
  # Set y-axis range, breaks, and comma formatting for COVID-19 case values
  scale_y_continuous(
    limits = c(0, 65000),
    breaks = seq(0, 65000, by = 10000),
    labels = scales::comma)+
  # Adjust point size scale and show min, median, and max population values
  scale_size_continuous(
    range = c(2, 10),
    breaks = c(
      min(demo_health_covid$population),
      median(demo_health_covid$population),
      max(demo_health_covid$population)),
    labels = scales::comma) +
  # Add title, subtitle, and axis labels
  labs(
    title = "Health expenditure shows no clear association with COVID-19 cases per million",
       subtitle = str_wrap("No clear relationship between health expenditure (% of GDP) and COVID-19 cases per million, indicating that factors beyond healthcare spending influence infection rates."),
       x = "Current health expenditure as % of GDP (USD $)",
       y = "Total COVID-19 Cases per Million")+
  # Apply a clean theme
  theme_classic()

# -------------------- Panel 3: Average COVID cases by income group -------------------- 

# Plotting average COVID-19 cases per million by income group
Plot_3 <- demo_health_covid %>%
  # Group data by income group and calculate the average COVID-19 cases per million
  group_by(income_group) %>%
  # Calculate average COVID-19 cases per million for each group
  summarise(avg_cases = mean(total_covid_cases_per_million, na.rm = TRUE)) %>%
  # Create barchart, fill the bars with colour by income_group
  ggplot(aes(x = income_group, y = avg_cases, fill = income_group)) +
  # Create bar chart
  geom_col() +
  # Apply viridis colour scale for income groups
  scale_fill_viridis_d() +
  # Set y-axis range, breaks and comma formatting
  scale_y_continuous(
    limits = c(0, 30000),
    breaks = seq(0, 30000, by = 5000),
    labels = scales::comma)+
  # Add title, subtitle, and axis labels
  labs(
    title = "COVID-19 case rates increase with country income level",
    subtitle = str_wrap("Average COVID-19 cases per million increase with income group, with high-income countries reporting the highest case rates."),
    x = "Income Group",
    y = "Average Number of COVID-19 Cases per Million") +
  # Apply clean theme and remove legend
  theme_classic() +
  theme(legend.position = "none")

# -------------------- Panel 4: Covid death rate by income group -------------------- 

#Conduct one-way ANOVA to test whether COVID-19 death rates differ significantly across income groups
anova_model <- aov(covid_death_rate_per_million ~ income_group, data = demo_health_covid)
summary(anova_model)

# Plotting COVID-19 death rate by income group
Plot_4 <- demo_health_covid %>%
  ggplot(aes(x = income_group, y = covid_death_rate_per_million, fill = income_group)) +
  # Add boxplots to compare the distribution of COVID-19 death rates across income groups
  geom_boxplot() +
  # Label outliers within each income group using the 1.5 × IQR rule
  geom_text_repel(
    data = demo_health_covid %>%
      group_by(income_group) %>%
      filter(
        covid_death_rate_per_million < quantile(covid_death_rate_per_million, 0.25, na.rm = TRUE) -
          1.5 * IQR(covid_death_rate_per_million, na.rm = TRUE) |
          covid_death_rate_per_million > quantile(covid_death_rate_per_million, 0.75, na.rm = TRUE) +
          1.5 * IQR(covid_death_rate_per_million, na.rm = TRUE)) %>%
      ungroup(),
    aes(label = country),  
    colour = "black",
    segment.colour = "black",
    min.segment.length = 0,
    segment.size = 1,
    nudge_x = 0.1,
    show.legend = FALSE) +
  # Apply viridis colour scale to income groups
  scale_fill_viridis_d() +
  # Add title, subtitle, axis labels, and caption
  labs(
    title = "COVID-19 death rates vary significantly across income groups",
    subtitle = str_wrap("COVID-19 death rates differ across income groups, with statistical testing indicating significant variation, particularly higher rates in lower-income countries."),
    x = "Income Group",
    y = "Death Rate by COVID-19",
    caption = "Covid data sourced from https://docs.owid.io/projects/etl/api/covid/") +
  # Apply clean theme and remove legend
  theme_classic() +
  theme(legend.position = "none")


# -------------------- Combine plots into a multi-panel figure -------------------- 

# Combining all plots into a single multi-panel figure
covid_19_graphs <- (Plot_1 + Plot_2 + Plot_3 + Plot_4)+
  # Add an overall title to the combined figure
  plot_annotation(
  title = "Socioeconomic factors and COVID-19 outcomes across Asian countries (2020)")

# Save the figure as a high-resolution PNG file with specified dimensions
ggsave("covid_19_graph.png",width=400,height=200,units="mm")


# -------------------- Saving my tidied data as .csv files -------------------- 

write.csv(demo, "demo_clean.csv", row.names = FALSE)
write.csv(health, "health_clean.csv", row.names = FALSE)
write.csv(demo_health_covid, "demo_health_covid_clean.csv", row.names = FALSE)
