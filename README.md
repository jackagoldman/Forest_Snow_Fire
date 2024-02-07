# Data and code to analyze the direct and indirect effects of forest structure and snow cover on wildfire burn severity
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

## Repository organization

`code` folder contains analysis scripts and has a subfolder `functions` which contains functions required to reproduce analysis.

`data` folder contains cleaned data used in the analysis.


## File description

[0_forest_snow_fire_data.csv](https://github.com/jackagoldman/Forest_Snow_Fire/blob/main/data/0_forest_snow_fire_data.csv)

These are the cleaned data that are used to generate all analyses and figures in the paper. These data represent wildfire's that burned between 2001 and 2019 in the boreal shield of Ontario. For methodology see article.

| Variable            | Description| 
| :---------------- | :------ | 
| Fire_ID        |  Unique name identifyer for each fire | 
| Fire_Year          |   Year that the fire burned (YYYY)   | 
| Fire_Start    |  Date that fire started to burn as reported by Ontario Ministry of Natural Resources and Forestry (YYYY-MM-DD)   | 
| BurnDay |  Julian day of burn as identified using Google Earth Engine |
| sdd | Snow-free date as indentified using Google Earth Engine |
| tssm | Snow-free duration calculated as difference between sdd and BurnDay |
| avgBio | mean total aboveground biomass (t/ ha)|
| cc | mean canopy closure (%)|
| age| mean stand age (YY)|
| tri | mean terrain ruggedness index |
| RBR_median| median relativized burn ratio |
| RBR_quant | 90th percentile relativized burn ration|
| RBR_cv | coefficent of variation of relativized burn ratio|
| FIRE_FINAL |final fire size (ha) as reported by Ontario Ministry of Natural Resources and Forestry |
| size_class | fire size class 1 = small < 500 ha, 2 = medium <= 500 ha & < 10,000 ha, 3 = large >= 10,000 ha|
| dc | drought code as interpolated to the centroid of the fire perimeter|
| pyroregion | east or west broeal shield. 1 = west, 0 = east |



[1_sem_entire_boreal_shield.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/1_sem_entire_fire_boreal_shield.R)

Code to analyze entire boreal shield (689 fires). This code runs a structural equation model for both median and extreme severity. It calculates the indirect effects using a custom function.

[2_sem_east_west_shield.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/2_sem_east_west_shield_shield.R)

Code to analyze east and west boreal shield. This code runs four separate structural equation models for both median and extreme severity, one for each ecoregion. It then calcualtes the indirect effects using a custom function.

[3_sem_multigroup_east_west.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/3_sem_multigroup_east_west.R)

Code to analyze difference between indirect pathways for east and west ecoregion using a multigroup analysis. This code requires the outputs of `1_sem_entire_boreal_shield.R`. It calculates the indirect effects and combines them into a dataframe before plotting the results.

[4_sem_variability.R](/github.com/jackagoldman/Forest_Snow_Fire/blob/main/code/3_sem_variability.R)

Code to analyze within-fire variability in burn severity for fires > 500 ha. This code runs a single structural equation model. It then calculates the indirect effects and plots the results. 
