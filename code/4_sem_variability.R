# Within-fire variability SEM



# load required packages
library(tidyverse)
library(nlme)
library(piecewiseSEM)


# get custom functions 
source("code/functions/indirect_effects_function.R")
source("code/functions/total_effects_function.R")


# read in data
data <- read_csv("data/0_forest_snow_fire_data.csv")


#lets get fires that are bigger than 500ha
new_data <- new_data %>% filter(size_class >=2)

#log transform cv
new_data_cv <- new_data %>% mutate(rbr_cv= log10(RBR_cv))
hist(new_data_cv$rbr_cv)

# SEM

sem_cv <- psem(
  lme(sdd ~  avgBio + cc+ age + tri, random = ~1 | Fire_Year, na.action = na.omit, data = new_data_cv, method = "ML"),
  lme(tssm ~ sdd + dc  + age + avgBio  , random = ~1 | Fire_Year, na.action = na.omit, data = new_data_cv, method = "ML"),
  lme(rbr_cv ~ dc + tssm + sdd +tri +age + 
        avgBio + cc , random = ~1 | Fire_Year, na.action = na.omit, data = new_data_cv, method = "ML")
)


# calculate indirect effects

#indirect effects
cv_ind_eff <- ind.eff(sem_cv, response = "heterogeneity")
cv_ind_eff
#total causal effects
cv_tot_eff <- tot.eff(sem_cv, response = "heterogeneity", total = FALSE)
cv_tot_eff

#plot effects
cv_eff_plot <- pathway.plot(cv_ind_eff, cv_tot_eff, response = "heterogeneity")
cv_eff_plot

