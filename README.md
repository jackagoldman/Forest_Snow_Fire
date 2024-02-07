# Forest_Snow_Fire
This Repository contains data and code for the manuscript: 

- Direct and indirect effects of forest structure, snow-free date, and duration on wildfire burn severity in the boreal forest

`The authors request that you cite the above article when using these data or modified code to prepare a publication.`

The files contained by this repository are numbered sequentially in the order they appear in our data analysis and figure generation workflow, each of which is described below. 

To use our code, you will need to install R version `4.3.0 (2023-04-21) or later` 

Packages needed to reproduce these analyses are:

```{r}
pkgs <- c("tidyverse", "piecewiseSEM", "ggplot2", "nlme")

install.packages(c(pkgs)

```

[forest_snow_fire_data.csv](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/data/0_forest_snow_fire_data.csv)

These are the cleaned data that are used to generate all analyses and figures in the paper. These data represent wildfire's that burned between 2001 and 2019 in the boreal shield of Ontario. For methodology see article.

| Variable            | Description| 
| :---------------- | :------: | 
| Fire_ID        |  Unique name identifyer for each fire | 
| Fire_Year          |   Year that the fire burned (YYYY)   | 
| Fire_Start    |  Date that fire started to burn as reported by Ontario Ministry of Natural Resources and Forestry (YYYY-MM-DD)   | 
| BurnDay |  Julian day of burn as identified using Google Earth Engine |
| sdd | Snow-free date as indentified using Google Earth Engine |
| tssm | Snow-free duration calculated as difference between sdd and BurnDay |
| avgBio | mean total aboveground biomass t/ ha|
| cc | meanpercentage canopy closure|
| age| mean stand age|
| tri | mean terrain ruggedness index |
| RBR_median| median relativized burn ratio |
| RBR_quant | 90th percentile relativized burn ration|
| RBR_cv | coefficent of variation of relativized burn ratio|
| FIRE_FINAL |final fire size (ha) as reported by Ontario Ministry of Natural Resources and Forestry |
| size_class | fire size class 1 = small < 500 ha, 2 = medium <= 500 ha & < 10,000 ha, 3 = large >= 10,000 ha|
| dc | drought code as interpolated to the centroid of the fire perimeter|
| pyroregion | east or west broeal shield. 1 = west, 0 = east |



[1_sem_entire_boreal_shield.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/1_sem_entire_fire_boreal_shield.R)

Code to analyze...

[2_sem_east_west_shield.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/2_sem_east_west_shield_shield.R)

Code to analyze...

[3_sem_multigroup_east_west.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/3_sem_multigroup_east_west.R)

Code to analyze...

[4_sem_variability.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/3_sem_variability.R)

Code to analyze...


