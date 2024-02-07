# multigroup analysis

# for this analysis to work, make sure that 1_sem_entire_shield.R is run as this code requires model objects
source("code/1_sem_entire_shield.R")

# reuqired packages
library(nlme)
library(piecewiseSEM)
library(ggplot2)
library(patchwork)


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
# BIOMASS
# west
pc.sdd.bio.g1 <- lme(sdd ~  avgBio , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML")

pc.tssm.sdd.g1 <-  lme(tssm ~ sdd  ,  random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_w, method = "ML")

pc.rbr.tssm.g1 <- lme(RBR_median ~ tssm, random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_w, method = "ML")

coef1 <- coefs(pc.sdd.bio.g1)[,8]
coef2 <- coefs(pc.tssm.sdd.g1)[,8]
coef3 <- coefs(pc.rbr.tssm.g1)[,8]

ind.path.bio.g1 <- (coef1*coef2*coef3)

# east
pc.sdd.bio.g2 <- lme(sdd ~  avgBio , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML")

pc.tssm.sdd.g2 <-  lme(tssm ~ sdd  ,  random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_e, method = "ML")

pc.rbr.tssm.g2 <- lme(RBR_median ~ tssm, random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_e, method = "ML")

coef1 <- coefs(pc.sdd.bio.g2)[,8]
coef2 <- coefs(pc.tssm.sdd.g2)[,8]
coef3 <- coefs(pc.rbr.tssm.g2)[,8]

ind.path.bio.g2 <- (coef1*coef2*coef3)

# Canopy closure
#g1 = west, g2 = east
# west
pc.sdd.cc.g1 <- lme(sdd ~  cc , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML")

pc.tssm.sdd.g1 <-  lme(tssm ~ sdd  ,  random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_w, method = "ML")

pc.rbr.tssm.g1 <- lme(RBR_median ~ tssm, random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_w, method = "ML")

coef1 <- coefs(pc.sdd.cc.g1)[,8]
coef2 <- coefs(pc.tssm.sdd.g1)[,8]
coef3 <- coefs(pc.rbr.tssm.g1)[,8]

ind.path.cc.g1 <- (coef1*coef2*coef3)

#east
pc.sdd.cc.g2 <- lme(sdd ~  cc , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML")

pc.tssm.sdd.g2 <-  lme(tssm ~ sdd  ,  random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_e, method = "ML")

pc.rbr.tssm.g2 <- lme(RBR_median ~ tssm, random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_e, method = "ML")

coef1 <- coefs(pc.sdd.cc.g2)[,8]
coef2 <- coefs(pc.tssm.sdd.g2)[,8]
coef3 <- coefs(pc.rbr.tssm.g2)[,8]

ind.path.cc.g2 <- (coef1*coef2*coef3)

# Stand Age
#g1 = west, g2 = east
pc.sdd.age.g1 <- lme(sdd ~  age , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_w, method = "ML")

pc.tssm.sdd.g1 <-  lme(tssm ~ sdd  ,  random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_w, method = "ML")

pc.rbr.tssm.g1 <- lme(RBR_median ~ tssm, random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_w, method = "ML")

coef1 <- coefs(pc.sdd.age.g1)[,8]
coef2 <- coefs(pc.tssm.sdd.g1)[,8]
coef3 <- coefs(pc.rbr.tssm.g1)[,8]

ind.path.age.g1 <- (coef1*coef2*coef3)

#east
pc.sdd.age.g2 <- lme(sdd ~  age , random = ~1 | Fire_Year/size_class, na.action = na.omit, data = new_data_e, method = "ML")

pc.tssm.sdd.g2 <-  lme(tssm ~ sdd  ,  random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_e, method = "ML")

pc.rbr.tssm.g2 <- lme(RBR_median ~ tssm, random = ~1 | Fire_Year/size_class,na.action = na.omit, data = new_data_e, method = "ML")

coef1 <- coefs(pc.sdd.age.g2)[,8]
coef2 <- coefs(pc.tssm.sdd.g2)[,8]
coef3 <- coefs(pc.rbr.tssm.g2)[,8]

ind.path.age.g2 <- (coef1*coef2*coef3)

# create data frame
names <- c("Indirect Pathway", "Path Coefficient", "Ecoregion")
ind.mult.med <- matrix(c("Stand Age", "Biomass", "Canopy Closure",
                         "Stand Age", "Biomass", "Canopy Closure",
                         ind.path.age.g1, ind.path.age.g2, ind.path.bio.g1, ind.path.bio.g2, 
                         ind.path.cc.g1, ind.path.cc.g2, "West", "East","West", "East","West", "East"), ncol = 3)
ind.mult.med <-  as.table(ind.mult.med)
colnames(ind.mult.med) <-  names
df.ind.mult.med = as.data.frame.matrix(ind.mult.med)
rownames(df.ind.mult.med) = NULL
tbl.ind.mult.med<- tidyr::as_tibble(df.ind.mult.med)
tbl.ind.mult.med<- dplyr::mutate(tbl.ind.mult.med, Response = rep("Median Burn Severity"))
tbl.ind.mult.med$`Path Coefficient` <- round(as.numeric(tbl.ind.mult.med$`Path Coefficient`), digits = 3)

# MEDIAN
mmult_eff <- ggplot()+
  geom_point(data = tbl.ind.mult.med, aes(x = `Path Coefficient`, y = `Indirect Pathway`, colour = Ecoregion), size = 5)+
  theme_bw()+
  theme(axis.title = element_text(size = 14, family = "Helvetica"), 
        axis.text = element_text(size = 10, family = "Helvetica"),
        plot.title = element_text(hjust = 0.5),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA, linewidth=1)) + xlim(-0.015, 0.02)+ coord_flip()+ 
  theme(legend.position ="right") + xlab("Standardized Effects")+
  scale_colour_viridis_d("Ecoregion", option = "viridis") +
  labs(title = "Median Burn Severity")

# EXTREME

emult_eff <- ggplot()+
  geom_point(data = tbl.ind.mult.ext, aes(x = `Path Coefficient`, y = `Indirect Pathway`, colour = Ecoregion), size = 5)+
  theme_bw()+
  theme(axis.title = element_text(size = 14, family = "Helvetica"), 
        axis.text = element_text(size = 10, family = "Helvetica"),
        plot.title = element_text(hjust = 0.5),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA, linewidth=1)) + coord_flip()+
  theme(legend.position ="right") + xlab("Standardized Effects")+
  scale_colour_viridis_d("Ecoregion", option = "viridis") +
  labs(title = "Burn Severity Extremes")


# Combine plots

emult_eff + mmult_eff + plot_layout(guides = "collect") 