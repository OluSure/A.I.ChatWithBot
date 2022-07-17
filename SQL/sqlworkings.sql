-- NOTE: I am using IPUMS Ghana 2010 dataset to get Crude:
-- Birth Rate (CBR), 
-- General Fertility Rate (GFR), 
-- Total Fertility Rate (TFR), 
-- Gross Reproductive Rate (GRR) 
-- and Age-Specific Fertility Rate (ASFR).
-- Download the data with this URL
-- https:// live.ipumsi.datadownload.ipums.org/web/extracts/ipumsi/1748632/ipumsi_00013.csv.gz


-- Install the file into the sql database  

select * into ipumsi_00013 FROM (file:-- /storage/3739-3333/Assignment/402/Tobi/ipumsi_00013.xls, [Sheet1$])

-- Or

use ipumsi_00013 

bulk insert ipumsi_00013 from 'file:-- /storage/3739-3333/Assignment/402/Tobi/ipumsi_00013.csv' 

-- View the data you have uploaded
select * from ipumsi_00013

-- Recode value "99" and "98" of chborn to "0"
update chborn set 98 = 0 and 99 = 0  from ipumsi_00013 

-- Count of pop.
select count sex from ipumsi_00013 as total_pop

-- Count all female response
select count age from ipumsi_00013 where sex = 2 as Total_female

--  Count all female response age 15-49
select count age between 15 and 49 from ipumsi_00013 where sex = 2 as Total_female_15_49

-- No. of children born
select sum chborn from ipumsi_00013 as Total_children

-- No. of female below 15 years assumed to be the no. of female children
select count sex from ipumsi_00013 where age between 0 and 14 as Total_female_children

# Age range: no. of births ÷ no. of females in age group

(select sum chborb from ipumsi_00013 where sex = 2 and age between 15 and 19 / select count age between 15 and 19 from ipumsi_00013 where sex = 2 ) as Asfr_15_19

(select sum chborb from ipumsi_00013 where sex = 2 and age between 20 and 24 / select count age between 20 and 24 from ipumsi_00013 where sex = 2) as Asfr_20_24

(select sum chborb from ipumsi_00013 where sex = 2 and age between 25 and 29 / select count age between 25 and 29 from ipumsi_00013 where sex = 2) as Asfr_25_29

(select sum chborb from ipumsi_00013 where sex = 2 and age between 30 and 34 / select count age between 30 and 34 from ipumsi_00013 where sex = 2) as Asfr_30_34

(select sum chborb from ipumsi_00013 as Asfr_35_39 where sex = 2 and age between 35 and 39 / select count age between 35 and 39 from ipumsi_00013 where sex = 2) as Asfr_35_39

(select sum chborb from ipumsi_00013 where sex = 2 and age between 40 and 44 / select count age between 40 and 44 from ipumsi_00013 where sex = 2) as Asfr_40_44

(select sum chborb from ipumsi_00013 where sex = 2 and age between 45 and 49 / select count age between 45 and 49 from ipumsi_00013 where sex = 2) as Asfr_45_49
  
Select Asfr_15_19, Asfr_20_24, Asfr_24_30, Asfr_31_34, Asfr_35_39, Asfr_40_44, Asfr_45_49 as asfr_15_49

-- CBR
(select Total_children from ipumsi_00013 / select Total_pop from ipumsi_00013) * 1000 as CBR

-- GFR
(select Total_children from ipumsi_00013 / select Total_females from ipumsi_00013) * 1000 as GFR

-- CBR
(select Total_children from ipumsi_00013 / select Total_pop from ipumsi_00013) * 1000 as CBR

-- ASFR
select sum Asfr_45_49, Asfr_40_44, Asfr_35_39, Asfr_30_34, Asfr_25_29, Asfr_20_24, Asfr_15_19 from ipumsi_00013 as Asfr

-- TFR
((select Asfr from ipumsi_00013) * 5) as TFR

(select Total_female_children from ipumsi_00013 / select Total_female_15_49 from ipumsi_00013) * 1000 as TFR2

-- Display the fertility measured
select total_pop total_female total_female_15_49 total_children cbr grr asfr tfr grr from ipumsi_00013

