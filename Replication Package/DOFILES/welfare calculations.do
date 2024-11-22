
*------------------------------------------------------------------------------*
*					6.0 - Welfare calculations 								   *
*------------------------------------------------------------------------------*


*Generates numbers to plug into "welfare calculations.xlsx" for back of the envelope welfare calculations in Section 5 of the paper. 

**************
* Get GDP data -- 
* Note: since the GDP data in WDI Online database changes for recent years, the numbers may not match the one used in the paper. 
**************
wbopendata, indicator("NY.GDP.PCAP.CD") clear // Data downloaded on Sep 16, 2024 
gen llmic = inlist(incomelevel, "LIC", "LMC")
gen ssa = inlist(adminregion, "SSA")
gen gcc = inlist(countrycode, "ARE", "BHR", "KWT", "OMN", "QAT", "SAU" )

summ yr2020 yr2022
summ yr2020 yr2022 if llmic==1
summ yr2020 yr2022 if ssa==1

/*=================== "welfare calculations.xlsx"
	 Numbers obtained with these summary statistics need to be copied in the excel sheet
	 (as done and saved on "welfare calculations.xlsx") for the welfare calculations.
 ==================*/
 
 
*****************************
* Average migration across various types of corridors
*****************************

run "$CODE\Header.do" // reload the dataset for reformatting purposes

g regular = (minmig>9)
lab define regular 1 "Regular" 0 "Irregular"
lab values regular regular 
g mzero = (mig>0)
g blazero = (dum_BLAs_10==1)
lab define blazero 1 "With BLA" 0 "Without BLA"
lab values blazero blazero 
lab define GCC_d 1 "GCC destination" 0 "Non GCC destination"
lab values GCC_d GCC_d 
lab define mzero 1 "Non empty corridors" 0 "Empty corridors" 
lab values mzero mzero 
replace devcat = 2 if devcat==.

gen llmic = inlist(o_incomelevel, "LIC", "LMC")

summ mig if year==2020
summ mig if year==2020 & GCC_d==1
summ mig if year==2020 & AFR_o ==1
summ mig if year==2020 & llmic ==1
summ mig if year==2020 & llmic ==1 & regular ==1
summ mig if year==2020 & AFR_o ==1 & regular ==1
summ mig if year==2020 & GCC_d ==1 & regular ==1
summ mig if year==2020 & regular ==1
summ mig if year==2020 & GCC_d ==1 & llmic ==1
summ mig if year==2020 & GCC_d ==1 & llmic ==1 & regular ==1
summ mig if year==2020 & AFR_o ==1 & llmic ==1 & regular ==1
summ mig if year==2020 & AFR_o ==1 & regular ==1
summ mig if year==2020 & AFR_o ==1 & GCC_d ==1
summ mig if year==2020 & AFR_o ==1 & GCC_d ==1 & regular ==1


/*=================== "welfare calculations.xlsx"
	 Numbers obtained with these summary statistics need to be copied in the excel sheet
	 (as done and saved on "welfare calculations.xlsx") for the welfare calculations.
 ==================*/