# SEM for entire boreal shield

# required libraries
library(piecewiseSEM)
library(nlme)
library(tidyverse)
library(kableExtra)


# source custom functions 
source("code/functions/indirect_effects_function.R")


# read in data
data <- read_csv("data/0_forest_snow_fire_data.csv")


#sqrt transform rbr quant
new_data <- data %>% mutate(rbr_qs = sqrt((max(RBR_quant+1)-RBR_quant)))


#SEM 

# Extreme burn severity
sem_ext <- psem(
  lme(sdd ~  avgBio + age + cc + tri, 
      random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data, method = "ML"),
  lme(tssm ~ sdd  + dc + age, 
      random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data, method = "ML"),
  lme(rbr_qs ~ dc + tssm + sdd +tri +age + cc + avgBio, 
      random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data, method = "ML")
  
)


# Median Burn Severity

sem_med <- psem(
  lme(sdd ~ avgBio + age + cc +tri,
      random = ~1 |Fire_Year/size_class, na.action = na.omit, data = new_data, method = "ML"),
  lme(tssm ~ sdd + dc + age, 
      random = ~1 |Fire_Year/size_class, na.action = na.omit, data = new_data, method = "ML"),
  lme(RBR_median ~ dc + tssm + sdd +tri +age + cc +avgBio, 
      random = ~1 |Fire_Year/size_class, na.action = na.omit, data = new_data, method = "ML")
)


# calculate indirect effects

# extreme
ext_ont_ind_effects <- ind.eff(sem_ext, response = "extreme")

# median
med_ont_ind_effects <- ind.eff(sem_med, response = "median")

# plot indirect effects
