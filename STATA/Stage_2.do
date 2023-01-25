set more off
gen wt=v005/1000000

******************weighting****************
svyset[pw=wt], psu(v021) strata(v022)
svyset [pw=wt], psu(v021) strata (v022) singleunit(centered)

******************generate of womens region****************
keep if inrange(v024, 1, 3)

*********************generate of womens child ever born*******************
ta v201
recode v201 (0=1 "0") (1 2=2 "1-2") (3 4=3 "3-4") (5/17=4 "5+"), gen(ceb)
ta ceb

******************generate of womens autonomy****************
ta v743a
gen ownhealth =v743a==1
ta v743b
gen largepurchases =v743b==1
ta v743d
gen visits =v743d==1
ta v743f
gen husbandmoney =v743f==1
factor ownhealth largepurchases visit husbandmoney, factor(4)
rotate
alpha ownhealth largepurchases visit husbandmoney
egen finalsay =rsum(ownhealth largepurchases visit husbandmoney)
tab finalsay
xtile finalsaycat =finalsay, n(3)
tab finalsaycat
ren finalsaycat autonomy
ta autonomy
la var autonomy "autonomy tertile"
la def autonomy 1 "low" 2 "medium" 3 "high"
la val autonomy autonomy
ta autonomy

*********************INTERVENING VARIABLES*************************
***********************place of residence***********************
ta v102

************generate of womens education***************

rename v106 education
gen woedu=0
replace woedu=1 if education==0
replace woedu=2 if education==1
replace woedu=3 if education==2 
replace woedu=4 if education==3
la var woedu "education status"
la def woedu 1"no education" 2"primary education" 3"secondary" 4 "postsecondary"
la val woedu woedu
tab woedu

************generate of women�s religion*****************
recode v130 (1/2=1 "Christianity") (3=2 "Islam") (4 96=3 "Others") (99=.), gen(rel)
ta rel

*********************generate of women�s occupation status**************
recode v717 (1 2 3 7 8=1 "Working") (9 10 11=2 "Not working"), gen(occupation)

********************generate of women�s exposure of mass media*************
tab1 v156 v157 v158 v159
replace v157=. if v157==9
replace v158=. if v158==9
replace v159=. if v159==9
tab1 v156 v157 v158 v159
gen exposure=.
replace exposure=0 if v157==0 | v158==0 | v159==0
replace exposure=1 if v157!=0 & v158!=0 & v159!=0
la def exposure 0 "not exposed" 1 "exposed"
la val exposure exposure
ta exposure

*******************generate of women�s wealth status*******************
ta v190
recode v190 (1 2=1 "poor") (3=2 "moderate") (4 5=3 "rich"), gen(wealth)
ta wealth

********************generate of women�s age*****************
recode v012 (15/19=1 "15-19") (20/24=2 "20-24") (25/29=3 "25-29") (30/34=4 "30-34") (35/39=5 "35-39") (40/44=6 "40-44") (45/max=7 "45+"), gen(age)
su v012

***********************generate of women�s marital status***************
recode v501 (0=1 "single") (1 2=2 "married") (3=3 "widowed") (4 5=4 "divorced"), gen(marriage)

***********************generate of women�s ethnicity***************
recode v131 (6=1 "ibo") (2 3=2 "hausa/fulani") (10=3 "yoruba") (1 4 5 7 8 9 96 98=4 "others"), gen(tribe)

*********************dependent variable*******************

************generate of women�s contraceptive knowledge***************
ta v301
recode v301 (0=1 "Knows no method") (1 2=2 "Knows traditional method") (3=3 "Knows modern method"), gen(kmethod)

************generate of women�s contraceptive method use***************
ta v364
recode v364 (1=1 "no method") (2 3=2 "Traditional method") (4=3 "Modern method"), gen(method)

************generate of women�s contraceptive use***************
ta v364
recode v364 (1=0 "Not using") (2 3 4=1 "Using"), gen(cuse)

************generate of women�s contraceptive decision ***************
gen decideuse=.
replace decideuse=1 if v632==1 | v632a==1
replace decideuse=2 if v632==3 | v632a==3
replace decideuse=3 if v632==2 | v632a==2
replace decideuse=4 if v632==6 | v632a==6
la def decideuse 1 "wife only" 2 "wife and husband" 3 "husband only" 4 "others"
la val decideuse decideuse
ta decideuse

*******************Univariate Analysis****************
ta autonomy [iw=wt]
ta v024 [iw=wt]
ta v102 [iw=wt]
ta marriage [iw=wt]
ta woedu [iw=wt]
ta occupation [iw=wt]
ta exposure [iw=wt]
ta kmethod [iw=wt]
ta ceb [iw=wt]
ta method [iw=wt]
ta wealth [iw=wt]
ta age [iw=wt]
ta decideuse [iw=wt]
ta rel [iw=wt]
ta tribe [iw=wt]
ta cuse [iw=wt]

***************************Bivariate Analysis*****************
tab autonomy cuse, col chi
tab v024 cuse, col chi
tab v102 cuse, col chi
tab marriage cuse, col chi
tab woedu cuse, col chi
tab occupation cuse, col chi
tab exposure cuse, col chi
tab kmethod cuse, col chi
tab ceb cuse, col chi
tab method cuse, col chi
tab wealth cuse, col chi
tab age cuse, col chi
tab decideuse cuse, col chi
tab rel cuse, col chi
tab tribe cuse, col chi

*********************Multivariate Analysis********************
xi: logistic cuse i.autonomy

********************2nd Model*********************************************
xi: logistic cuse i.autonomy i.v024 i.v102 i.marriage i.woedu i.occupation i.exposure i.ceb i.wealth i.age i.rel i.tribe