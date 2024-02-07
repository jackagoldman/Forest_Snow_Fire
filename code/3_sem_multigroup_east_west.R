# multigroup analysis

# for this analysis to work, make sure that 1_sem_entire_shield.R is run as this code requires model objects
source("code/1_sem_entire_shield.R")

# reuqired packages
library(nlme)
library(piecewiseSEM)


# prepare data
new_data = new_data %>% mutate(group = case_when(pyroregion == 1 ~ "e",
                                                 pyroregion == 0 ~ "w"))
new_data$group <- as.factor(new_data$group)
new_data$size_class <- as.factor(new_data$size_class)
new_data$Fire_Year <- as.numeric(new_data$Fire_Year)

new_data$sdd <- as.numeric(new_data$sdd)
new_data$tssm <- as.numeric(new_data$tssm)
new_data$pyroregion <- as.factor(new_data$pyroregion)




#Models grouped by response

# EXTREME SEVERITY

# Fixed model for average biomass
ext_bio <- psem(
  lme(sdd ~ pyroregion/avgBio + age + cc + tri, random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion), na.action = na.omit, data = new_data, method = "ML"),
  
  lme(tssm ~ pyroregion/sdd + dc ,  random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML"),
  
  lme(rbr_qs ~ dc + pyroregion/tssm + sdd + tri + age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML")
)

# compare fixed to free
sem_ext_chi <- fisherC(sem_ext)[,1]
sem_ext_df <- fisherC(sem_ext)[,2]
ext_bio_chi <- fisherC(ext_bio)[,1]
ext_bio_df <- fisherC(ext_bio)[,2]

chi.diff_bio = (ext_bio_chi - sem_ext_chi)
df.diff_bio= (ext_bio_df - sem_ext_df)

1-pchisq(chi.diff_bio, df.diff_bio)


# fixed model for canopy closure
ext_cc  <- psem(
  lme(sdd ~  avgBio + age + pyroregion/cc+ tri, random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion), na.action = na.omit, data = new_data, method = "ML"),
  
  lme(tssm ~ pyroregion/sdd + dc ,  random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML"),
  
  lme(rbr_qs ~ dc + pyroregion/tssm + sdd + tri + age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML")
)

# compare fixed canopy closure to free
sem_ext_chi <- fisherC(sem_ext)[,1]
sem_ext_df <- fisherC(sem_ext)[,2]
ext_cc_chi <- fisherC(ext_cc)[,1]
ext_cc_df <- fisherC(ext_cc)[,2]

chi.diff_cc = (ext_cc_chi - sem_ext_chi)
df.diff_cc= (ext_cc_df - sem_ext_df)

1-pchisq(chi.diff_cc, df.diff_cc)

#fixed model for stand age
ext_age  <- psem(
  lme(sdd ~  avgBio + pyroregion/age + cc+ tri, random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion), na.action = na.omit, data = new_data, method = "ML"),
  
  lme(tssm ~ pyroregion/sdd + dc ,  random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML"),
  
  lme(rbr_qs ~dc + pyroregion/tssm + sdd + tri + age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML")
)

# compare fixed stand age to free
sem_ext_chi <- fisherC(sem_ext)[,1]
sem_ext_df <- fisherC(sem_ext)[,2]
ext_age_chi <- fisherC(ext_age)[,1]
ext_age_df <- fisherC(ext_age)[,2]

chi.diff_age = (ext_age_chi - sem_ext_chi)
df.diff_age= (ext_age_df - sem_ext_df)


1-pchisq(chi.diff_age, df.diff_age)

# MEDIAN SEVERITY

# fixed model for biomass
med_bio <- psem(
  lme(sdd ~ pyroregion/avgBio + age + cc + tri, random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion), na.action = na.omit, data = new_data, method = "ML"),
  
  lme(tssm ~ pyroregion/sdd + dc ,  random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML"),
  
  lme(RBR_median ~ dc + pyroregion/tssm + sdd + tri + age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML")
)

# compare fixed biomass to free
sem_med_chi <- fisherC(sem_med)[,1]
sem_med_df <- fisherC(sem_med)[,2]
med_bio_chi <- fisherC(med_bio)[,1]
med_bio_df <- fisherC(med_bio)[,2]

chi.diff_bio = (med_bio_chi - sem_med_chi)
df.diff_bio= (med_bio_df - sem_med_df)

1-pchisq(chi.diff_bio, df.diff_bio)

# fixed model for stand age
med_age <- psem(
  lme(sdd ~ avgBio + pyroregion/age + cc + tri, random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion), na.action = na.omit, data = new_data, method = "ML"),
  
  lme(tssm ~ pyroregion/sdd + dc ,  random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML"),
  
  lme(RBR_median ~ dc + pyroregion/tssm + sdd + tri + age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML"))
  
  
# comapre fixed age to free
med_age_chi <- fisherC(med_age)[,1]
med_age_df <- fisherC(med_age)[,2]

chi.diff_age = (med_age_chi - sem_med_chi)
df.diff_age= (med_age_df - sem_med_df)

1-pchisq(chi.diff_age, df.diff_age)

# fixed model for canopy closure
med_cc <- psem(
  lme(sdd ~ avgBio + age + pyroregion/cc + tri, random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion), na.action = na.omit, data = new_data, method = "ML"),
  
  lme(tssm ~ pyroregion/sdd + dc ,  random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML"),
  
  lme(RBR_median ~ dc + pyroregion/tssm + sdd + tri + age + 
        avgBio + cc , random = ~1 | Fire_Year/size_class, weights=varIdent(form =~1|pyroregion),na.action = na.omit, data = new_data, method = "ML")
)

#compare fixed cc to free
sem_med_chi <- fisherC(sem_med)[,1]
sem_med_df <- fisherC(sem_med)[,2]
med_cc_chi <- fisherC(med_cc)[,1]
med_cc_df <- fisherC(med_cc)[,2]

chi.diff_cc = (med_cc_chi - sem_med_chi)
df.diff_cc= (med_cc_df - sem_med_df)

1-pchisq(chi.diff_cc, df.diff_cc)

# PLOTS

# collect coefficients