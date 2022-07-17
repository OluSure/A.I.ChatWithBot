﻿name:  Tobi_stata_workings
       log:  file:///storage/3739-3333/Assignment/402/statalog.log
  log type:  text
 opened on:   16 july 2022, 03:00:49

* access directory path where my work are stored
cd "file:///storage/3739-3333/Assignment/402/Tobi"

* open my dataset press F2 to view it if using Windows 
use "ipumsi_00013.dta", clear

* incase your data has more observations
set maxvar 32767

* if the file is stored in a .csv
import delimited "ipumsi_00013.csv", /*

* for assistance run the help command
help

* gen wt
gen wt = 20055/1000000

* explore the data 
tab age chborn

*  Simple chart, I used to view each variable
histogram chborn, width(5) freq

* recode value "99" and "98
recode chborn = 0 if chborn == 98 & chborn == 99

* Total pop. (may add 'in')
count age = total_pop

*  No. of all female response
count sex = all_female if sex == 2

No. of female 15-49
count sex = female_15_49 if sex == 2

*  No. of children born
sum chborn = all_children if sex == 2 

*  no. of female below 15 years assumed to be the no. of female children 
sum chborn = female_child if sex == 2 & age < 15

 *  Age range no. of births ÷ no. of females in age group
(sum chborn if sex == 2 & age >= 15 & age <= 19) / (count age if sex == 2 & age = 15/19) = asfr_15_19

(sum chborn if sex == 2 & age >= 20 & age <= 24) / (count age if sex == 2 & age >= 20 & age <= 24) = asfr_20_24

(sum chborn if sex == 2 & age >= 25 & age <= 29) / (count age if sex == 2 & age >= 25 & age <= 29) = asfr_25_29

(sum chborn if sex == 2 & age >= 30 & age <= 34) / (count age if sex == 2 & age >= 30 & age <= 34) = asfr_30_34

(sum chborn if sex == 2 & age >= 35 & age <= 39) / (count age if sex == 2 & age >= 35 & age <= 39) = asfr_35_39

(sum chborn if sex == 2 & age >= 40 & age <= 44) / (count age if sex == 2 & age >= 40 & age <= 44) = asfr_40_44

(sum chborn if sex == 2 & age >= 45 & age <= 49) / (count age if sex == 2 & age >= 45 & age <= 49) = asfr_45_49 

*  CBR
sum ((all_children / total.pop) * 1000) = cbr

* GFR
sum (all_children / all.female) * 1000) = gfr

* ASFR sum in array
sum asfr_15_19 asfr_20_24 asfr_25_29 asfr_30_34 asfr_35_39 asfr_40_44 asfr_45_49 = asfr

* TFR
sum (asfr * 5) = tfr

* GRR
sum ((female_child / female_15_49) * 1000)) = grr

* display fertility measured
list total.pop all_female female_15_49 all_children female_child cbr gfr tfr grr asfr_15_19
