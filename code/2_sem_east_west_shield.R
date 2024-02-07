# SEM for east and west boreal shield

# required libraries
library(piecewiseSEM)
library(nlme)
library(tidyverse)
library(kableExtra)


# source custom functions 
source("code/functions/indirect_effects_function.R")


# read in data
data <- read_csv("data/0_forest_snow_fire_data.csv")

# sqrt transform rbr quant
new_data <- data %>% mutate(rbr_qs = sqrt((max(RBR_quant+1)-RBR_quant)))

# split data frames into east and west
new_data_w <- new_data %>% filter(pyroregion == 1)
new_data_e <- new_data %>% filter(pyroregion == 0)



# SEM

# western boreal shield extreme severity
west_sem_ext <- psem(
  lme(sdd ~  avgBio + age + cc+ tri, random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML"),
  lme(tssm ~ sdd +  + dc   , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML"),
  lme(rbr_qs ~ dc + tssm + sdd +tri +age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML")
)

# western boreal shield median severity
west_sem_med <- psem(
  lme(sdd ~  avgBio + age + cc+ tri, random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML"),
  lme(tssm ~ sdd +  dc  , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML"),
  lme(RBR_median ~ dc + tssm + sdd +tri +age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML")
)

# eastern boreal shield extreme

east_sem_ext <- psem(
  lme(sdd ~  avgBio + age + cc+ tri, random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML"),
  lme(tssm ~ sdd +  dc  , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML"),
  lme(rbr_qs ~ dc + tssm + sdd +tri +age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML")
)


# eastern boreal shield median
east_sem_med <- psem(
  lme(sdd ~  avgBio + age + cc+ tri, random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML"),
  
  lme(tssm ~ sdd + dc  , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML"),
  
  lme(RBR_median ~ dc + tssm + sdd +tri +age + 
        avgBio + cc, random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML")
)


# calculate indirect effects


# west extreme
west_ext_ont_ind_effects <- ind.eff(west_sem_ext, response = "extreme")

# west median
west_med_ont_ind_effects <- ind.eff(west_sem_med, response = "median")

# east extreme
east_ext_ont_ind_effects <- ind.eff(east_sem_ext, response = "extreme")

# east median
east_med_ont_ind_effects <- ind.eff(east_sem_med, response = "median")
