

use "$DATA\BLA_Migration_data", clear

preserve 
collapse (first) mig, by(d_iso3 d_region)
drop mig 
tempfile d_reg 
save `d_reg'
restore 

preserve 
collapse (first) mig, by(o_iso3 o_region)
drop mig 
tempfile o_reg 
save `o_reg'
restore 


/* Associating iso3 codes to BLAs data */
import excel using "$DATA\countries_match.xlsx", sheet("CountryA") firstrow clear 
ren NameofcountryA countryA
tempfile CountryA
save `CountryA'


import excel using "$DATA\countries_match.xlsx", sheet("CountryB") firstrow clear 
ren NameofcountryB countryB
tempfile CountryB
save `CountryB'

use "$DATA\BLAs_Formation_Data", clear 

merge n:1 countryA using `CountryA' // assign iso3 codes to country inviting foreign national of country pair 
drop _m 
merge n:1 countryB using `CountryB' // assign iso3 codes to country whose natives are invited to migrate  
drop _m 


* Country names over time

{
/* Case 1- Yougoslavia : Assign BLAs with Yougoslavia (dest) to SRB, MNE, HRV, SVN, MKD, and BIH */
preserve 
keep if o_iso3 == "YUG"
replace d_iso3 = "DEU" if inlist(d_iso3,"DEUw","DEUe") 
replace o_iso3 = "SRB" if o_iso3 == "YUG"
tempfile FYUG_SRB
save `FYUG_SRB'
restore 

preserve 
keep if o_iso3 == "YUG"
replace d_iso3 = "DEU" if inlist(d_iso3,"DEUw","DEUe") 
replace o_iso3 = "MNE" if o_iso3 == "YUG"
tempfile FYUG_MNE
save `FYUG_MNE'
restore 

preserve 
keep if o_iso3 == "YUG"
replace d_iso3 = "DEU" if inlist(d_iso3,"DEUw","DEUe") 
replace o_iso3 = "HRV" if o_iso3 == "YUG"
tempfile FYUG_HRV
save `FYUG_HRV' 
restore 

preserve 
keep if o_iso3 == "YUG"
replace d_iso3 = "DEU" if inlist(d_iso3,"DEUw","DEUe") 
replace o_iso3 = "SVN" if o_iso3 == "YUG"
tempfile FYUG_SVN
save `FYUG_SVN'
restore 

preserve 
keep if o_iso3 == "YUG"
replace d_iso3 = "DEU" if inlist(d_iso3,"DEUw","DEUe") 
replace o_iso3 = "MKD" if o_iso3 == "YUG"
tempfile FYUG_MKD
save `FYUG_MKD'
restore 

preserve 
keep if o_iso3 == "YUG"
replace d_iso3 = "DEU" if inlist(d_iso3,"DEUw","DEUe") 
replace o_iso3 = "BIH" if o_iso3 == "YUG"
tempfile FYUG_BIH
save `FYUG_BIH'
restore 
drop if o_iso3 == "YUG"
}



{
/* Case 2- Yougoslavia : Assign BLAs with Yougoslavia (dest) to SRB, MNE, HRV, SVN, MKD, and BIH */
preserve 
keep if d_iso3 == "YUG"
replace o_iso3 = "DEU" if inlist(o_iso3,"DEUw","DEUe") 
replace d_iso3 = "SRB" if d_iso3 == "YUG"
tempfile FYUGd_SRB
save `FYUGd_SRB'
restore 

preserve 
keep if d_iso3 == "YUG"
replace o_iso3 = "DEU" if inlist(o_iso3,"DEUw","DEUe") 
replace d_iso3 = "MNE" if d_iso3 == "YUG"
tempfile FYUGd_MNE
save `FYUGd_MNE'
restore 

preserve 
keep if d_iso3 == "YUG"
replace o_iso3 = "DEU" if inlist(o_iso3,"DEUw","DEUe") 
replace d_iso3 = "HRV" if d_iso3 == "YUG"
tempfile FYUGd_HRV
save `FYUGd_HRV' 
restore 

preserve 
keep if d_iso3 == "YUG"
replace o_iso3 = "DEU" if inlist(o_iso3,"DEUw","DEUe") 
replace d_iso3 = "SVN" if d_iso3 == "YUG"
tempfile FYUGd_SVN
save `FYUGd_SVN' 
restore 

preserve 
keep if d_iso3 == "YUG"
replace o_iso3 = "DEU" if inlist(o_iso3,"DEUw","DEUe") 
replace d_iso3 = "MKD" if d_iso3 == "YUG"
tempfile FYUGd_MKD
save `FYUGd_MKD' 
restore 

preserve 
keep if d_iso3 == "YUG"
replace o_iso3 = "DEU" if inlist(o_iso3,"DEUw","DEUe") 
replace d_iso3 = "BIH" if d_iso3 == "YUG"
tempfile FYUGd_BIH
save `FYUGd_BIH' 
restore 

drop if d_iso3 == "YUG"
}


{
/* Case 3- Czechoslovakia : Assign BLAs with Czechoslovakia to CZE and SVK */
preserve 
keep if o_iso3 == "CZEa"
replace o_iso3 = "CZE" if o_iso3 == "CZEa"
tempfile FCZE_CZE
save `FCZE_CZE' 
restore 

preserve 
keep if o_iso3 == "CZEa"
replace o_iso3 = "SVK" if "o_iso3" == "CZEa"
tempfile FCZE_SVK
save `FCZE_SVK' 
restore 

replace d_iso3 = "CZE" if d_iso3 == "CZEa"
drop if o_iso3 == "CZEa"
}



{
/* Case 3- Germany : Assign BLAs with Czechoslovakia to CZE and SVK */
preserve 
keep if o_iso3 == "DEUe"
replace o_iso3 = "DEU" if o_iso3 == "DEUe"
tempfile FURSS_DEU
save `FURSS_DEU'
restore 

drop if o_iso3 == "DEUe"

preserve 
keep if o_iso3 == "DEUw"
replace o_iso3 = "DEU" if o_iso3 == "DEUw"
tempfile FDEUw_DEU
save `FDEUw_DEU'
restore 

drop if o_iso3 == "DEUw"
replace d_iso3 = "DEU" if d_iso3 == "DEUe"
replace d_iso3 = "DEU" if d_iso3 == "DEUw"
}

append using  `FYUG_SRB' ///
			 `FYUG_MNE' ///
			  `FYUG_HRV' ///
			 `FYUG_SVN' ///
			`FYUG_MKD' ///
			 `FYUG_BIH' ///
			 `FYUGd_SRB' ///
			 `FYUGd_MNE' ///
			`FYUGd_HRV' ///
			 `FYUGd_SVN' ///
			 `FYUGd_MKD' ///
			 `FYUGd_BIH' ///
			`FCZE_CZE' ///
			 `FCZE_SVK' ///
			 `FURSS_DEU' ///
			`FDEUw_DEU'
drop if o_iso3 == "CZEa"
		
/* Ged rid of overseas territories to be consistent with WDR coding approach*/		
	
	replace o_iso3 = "USA" if inlist(o_iso3,"ASM","ASM","GUM","MNP","PRI","VIR")	
	replace o_iso3 = "DNK" if inlist(o_iso3,"FRO","GRL")
	replace o_iso3 = "FRA" if inlist(o_iso3,"GUF","GLP","MTQ","MYT","SPM","WLF")
	replace o_iso3 = "FRA" if inlist(o_iso3,"REU","PYF","NCL")
	replace o_iso3 = "NLD" if inlist(o_iso3,"BES","CUW","SXM")
	replace o_iso3 = "GBR" if inlist(o_iso3,"AIA","FLK","GIB","MSR","CHA","TCA","BMU")
	replace o_iso3 = "GBR" if inlist(o_iso3,"VGB","CYM","PCN","SHN")
	replace o_iso3 = "NZL" if inlist(o_iso3,"COK","TKL")

	replace d_iso3 = "USA" if inlist(d_iso3,"ASM","ASM","GUM","MNP","PRI","VIR")	
	replace d_iso3 = "DNK" if inlist(d_iso3,"FRO","GRL")
	replace d_iso3 = "FRA" if inlist(d_iso3,"GUF","GLP","MTQ","MYT","SPM","WLF")
	replace d_iso3 = "FRA" if inlist(d_iso3,"REU","PYF","NCL")
	replace d_iso3 = "NLD" if inlist(d_iso3,"BES","CUW","SXM")
	replace d_iso3 = "GBR" if inlist(d_iso3,"AIA","FLK","GIB","MSR","CHA","TCA","BMU")
	replace d_iso3 = "GBR" if inlist(d_iso3,"VGB","CYM","PCN","SHN")
	replace d_iso3 = "NZL" if inlist(d_iso3,"COK","TKL")


/* Ratified date */	
gen ratdate = date(ratified,"MDY")
format ratdate %td
gen yearrat = year(ratdate)

 /* Signed date */
* replace datesigned = "5/2/1997" if datesigned == "5/2/2997" // I guess that this is a typo
gen signdate = date(datesigned,"MDY")
format signdate %td
gen yearsig = year(signdate) 
replace yearsig = 1997 if yearsig == 2997 // I guess that this is a typo 
gen dumBLA = (yearsig !=.)

preserve 
collapse (rawsum) dumBLA, by(d_iso3 yearsig)
drop if yearsig==. 
gen id = 1
bys d_iso3 (yearsig): gen Cumul_BLAs = sum(dumBLA)
sort yearsig d_iso3 
bys id (yearsig): gen Tot_BLAs = sum(dumBLA)
encode d_iso3, gen(isod)
tsset isod yearsig
collapse (first) Tot_BLAs, by (yearsig)

tw line Tot_BLAs yearsig, xli(1945 1973 1990) xla(1920(10)2020) yla(0(200)1200) ///
	   text(605 1945 "Post WW-II" "(Post war reconstruction)", place(e) size(.3cm)) ///
	   text(605 1975 "Eco. stagnation" "(in Europe)", place(e) size(.3cm)) ///
	   text(605 2000 "New BLA's Golden age" "(post- Cold War)", place(e) size(.3cm)) ///
	   xti("BLA's signing year") yti("Cumulative number of BLAs")
graph export "$FIG\Figure_A1.png", replace 
restore 


merge n:1 d_iso3 using `d_reg' 
keep if _m==3 
drop _m 
merge n:1 o_iso3 using `o_reg' 
keep if _m==3 
drop _m 

preserve  /* Dynamic by region (destination) */
replace d_region = "GCC" if inlist(d_iso3,"BHR","KWT","OMN","QAT","SAU","ARE")
replace d_region = "EAP" if d_region == "EAS"
replace d_region = "ECA" if d_region == "ECS"
replace d_region = "LAC" if d_region == "LCN"
replace d_region = "MENA" if d_region == "MEA"
replace d_region = "NOAM" if d_region == "NAC"
replace d_region = "SOA" if d_region == "SAS"
replace d_region = "SSA" if d_region == "SSF"

replace o_region = "GCC" if inlist(o_iso3,"BHR","KWT","OMN","QAT","SAU","ARE")
replace o_region = "EAP" if o_region == "EAS"
replace o_region = "ECA" if o_region == "ECS"
replace o_region = "LAC" if o_region == "LCN"
replace o_region = "MENA" if o_region == "MEA"
replace o_region = "NOAM" if o_region == "NAC"
replace o_region = "SOA" if o_region == "SAS"
replace o_region = "SSA" if o_region == "SSF"

collapse (rawsum) dumBLA, by(d_region yearsig)
drop if yearsig==. 
bys d_region (yearsig): gen Tot_BLAs = sum(dumBLA)
encode d_region, gen(region)
tsset region yearsig

drop d_region dumBLA
reshape wide Tot_BLAs, i(yearsig) j(region)
rename (Tot_BLAs1 Tot_BLAs2 Tot_BLAs3 Tot_BLAs4 Tot_BLAs5 Tot_BLAs6 Tot_BLAs7 Tot_BLAs8) /// 
	   (EAP ECA GCC LAC MENA_OTH NOAM SOA SSA)
	   lab var EAP "EAP (axis-1)"
	   lab var ECA "ECA (axis-1)"
	   lab var GCC "GCC"
	   lab var LAC "LAC"
	   lab var MENA_OTH "MENA_OTH"
	   lab var NOAM "NOAM"
	   lab var SOA "SOA"
	   lab var SSA "SSA"
	   
tw (line EAP yearsig, c(l) yaxis(1)) ///
   (line ECA yearsig, c(l) yaxis(1)) ///
   (line GCC yearsig, c(l) yaxis(2)) ///
   (line LAC yearsig, c(l) yaxis(2)) ///
   (line MENA_OTH yearsig, c(l) yaxis(2)) ///
   (line NOAM yearsig, c(l) yaxis(2)) ///
   (line SOA yearsig, c(l) yaxis(2)) ///
   (line SSA yearsig, c(l) yaxis(2)) ///
   , xli(1945 1973 1990) xla(1920(10)2020, angle(90)) ///
	   text(550 1945 "Post WW-II", place(e) size(.3cm)) ///
	   text(550 1975 "Eco. stagnation", place(e) size(.3cm)) ///
	   text(600 2000 "New BLAs'" "Golden age", place(e) size(.3cm)) ///
	   legend(ring(0) pos(11)) ///
	   xti("BLA's signing year") yti("Cumulative number of BLAs") 
graph export "$FIG\Figure_A2.png", replace 
restore 

preserve /* Dynamic by region (origin) */
replace d_region = "GCC" if inlist(d_iso3,"BHR","KWT","OMN","QAT","SAU","ARE")
replace d_region = "EAP" if d_region == "EAS"
replace d_region = "ECA" if d_region == "ECS"
replace d_region = "LAC" if d_region == "LCN"
replace d_region = "MENA" if d_region == "MEA"
replace d_region = "NOAM" if d_region == "NAC"
replace d_region = "SOA" if d_region == "SAS"
replace d_region = "SSA" if d_region == "SSF"

replace o_region = "GCC" if inlist(o_iso3,"BHR","KWT","OMN","QAT","SAU","ARE")
replace o_region = "EAP" if o_region == "EAS"
replace o_region = "ECA" if o_region == "ECS"
replace o_region = "LAC" if o_region == "LCN"
replace o_region = "MENA" if o_region == "MEA"
replace o_region = "NOAM" if o_region == "NAC"
replace o_region = "SOA" if o_region == "SAS"
replace o_region = "SSA" if o_region == "SSF"

collapse (rawsum) dumBLA, by(o_region yearsig)
drop if yearsig==. 
bys o_region (yearsig): gen Tot_BLAs = sum(dumBLA)
encode o_region, gen(region)
tsset region yearsig

tw line Tot_BLAs yearsig, by(region, note("")) xli(1945 1973 1990) xla(1920(10)2020, angle(90)) ///
	   text(400 1945 "Post WW-II", place(e) size(.3cm)) ///
	   text(400 1975 "Eco. stagnation", place(e) size(.15cm)) ///
	   text(400 2000 "New Golden age", place(e) size(.25cm)) ///
	   xti("BLA's signing year") yti("Cumulative number of BLAs")   
graph export "$FIG\Figure_A3.png", replace 
restore 


/* Appendix A4-A6*/

use "$DATA/BLAs_Coding_Data.dta", clear


isid treatyID


*All African countries in the dataset
gen any_africa=0
replace any_africa=1 if ( countryA=="Algeria" | countryA=="Angola" | countryA=="Benin" | countryA=="Botswana"  | countryA=="Burkina Faso"  | countryA=="Cameroon"  | countryA=="Cape Verde"  | countryA=="Central African Republic"   | countryA=="Congo"   | countryA=="Egypt"   | countryA=="Ethiopia" | countryA=="Gabon"  | countryA=="Gambia"   | countryA=="Ghana"    | countryA=="Guinea"  | countryA=="Guinea-Bissau"  | countryA=="Ivory Coast"  | countryA=="Lesotho"  | countryA=="Libya"  | countryA=="Libya" | countryA=="Malawi" | countryA=="Malawi" | countryA=="Mali" | countryA=="Mauritania" | countryA=="Morocco" |  countryA=="Mozambique" | countryA=="Niger" |countryA=="Nigeria" |  countryA=="Senegal" | countryA=="Seychelles" | countryA=="Somalia" | countryA=="South Africa" |  countryA=="Sudan" |  countryA=="Swaziland" | countryA=="Togo" | countryA=="Tunisia" | countryA=="Uganda" | countryA=="Zambia" | countryA=="Zimbabwe" | countryB=="Algeria" | countryB=="Angola" | countryB=="Benin" | countryB=="Botswana"  | countryB=="Burkina Faso"  | countryB=="Cameroon"  | countryB=="Cape Verde"  | countryB=="Central African Republic"   | countryB=="Congo"   | countryB=="Egypt"   | countryB=="Ethiopia" | countryB=="Gabon"  | countryB=="Gambia"   | countryB=="Ghana"    | countryB=="Guinea"  | countryB=="Guinea-Bissau"  | countryB=="Ivory Coast"  | countryB=="Lesotho"  | countryB=="Libya"  | countryB=="Libya" | countryB=="Malawi" | countryB=="Malawi" | countryB=="Mali" | countryB=="Mauritania" | countryB=="Morocco" |  countryB=="Mozambique" | countryB=="Niger" |countryB=="Nigeria" |  countryB=="Senegal" | countryB=="Seychelles" | countryB=="Somalia" | countryB=="South Africa" |  countryB=="Sudan" |  countryB=="Swaziland" | countryB=="Togo" | countryB=="Tunisia" | countryB=="Uganda" | countryB=="Zambia" | countryB=="Zimbabwe" )




*Rename ILO variables

rename intl_instr 			ilo1     			
rename info_exch  			ilo2      		
rename info_dissem 	    	ilo3		
rename govt_agencies  		ilo4 			
rename joint_commit  		ilo5   		
rename recruit_cost_mig  	ilo6 		
rename recruit_auth			ilo7 		
rename labor_union_orig   	ilo8 	
rename labor_union_dest   	ilo9 	
rename labor_union_join 	ilo10 	
rename emp_orgs 			ilo11 	
rename ngos    				ilo12 		 
rename migrant_info 		ilo13 	
rename prot_equal 			ilo14 	
rename prot_women 			ilo15 	
rename prot_women_det 		ilo16 	
rename prot_other 			ilo17 	
rename contract_req 		ilo18 	
rename contract_standard    ilo19 	
rename contract_terms 		ilo20 	
rename wage_prot 			ilo21 	
rename housing_req 			ilo22 		
rename housing_cond 		ilo23 	
rename housing_monitor 		ilo24 		
rename work_monitor 		ilo25 	
rename passport 			ilo26 	
rename social_security 		ilo27 		
rename disputes_emp_mig 	ilo28 	
rename mig_human_cap 		ilo29 	
rename credentials 			ilo30 		
rename remittances 			ilo31 		
rename reintegration 		ilo32  
rename contract_renewal 	ilo33  
rename perm_resid 			ilo34  



 *Reshape the data from wide to long format
reshape long ilo, i(treatyID) j(ilocode)

* Calculate the mean of each variable by SSA / non-SSA
*collapse (mean) ilo, by(any_ssa ilocode)
collapse (mean) ilo, by(ilocode any_africa)


*Back to wide for ILO to be the only category
reshape wide ilo, i(ilocode) j(any_africa)

lab var ilo0 "No African country in treaty"
lab var ilo1 "At least one African country in treaty"

/*
label define ilolabel 1 "(1)" 2  "(2)" 3 "(3)" 4  "(4)" 5  "(5)" 6  "(6a)" 7 "(6b)" 8 "(7a)" 9 "(7b)" 10 "(7c)" 11	"(7d)" 12 "(7e)"  13	"(8)" 14 "(9)" 15	"(10a)" 16	"(10b)" 17	"(10c)" 18	"(11a)" 19   "(11b)" 20	"(11c)" 21	"(12)" 22	"(13a)" 23	"(13b)" 24	"(13c)" 25	"(13d)" 26	"(14)" 27	"(15)" 28 	"(16)" 29	"(17)" 30	"(18)" 31	"(19)" 32	"(20a)" 33 	"(20b)" 34	"(20c)"

label values ilocode ilolabel
*/
label define ilolabel 1 "(1) References to Int'l Instruments" ///
					  2 "(2) Exchange of Info. b/w Countries" ///
					  3 "(3) Dissemination of Info. on BLA's Existence" ///
					  4 "(4) Defining Clear Responsibilities b/w Parties" ///
					  5 "(5) Establishing a Joint Committee" ///
					  6 "(6a) Migrant Should Not Pay Recruitment Fees" ///
					  7 "(6b) Specifies Agents Authorized to Recruit" ///
					  8 "(7a) Role of Lab. Unions in Orig. ctry." ///
					  9 "(7b) Role of Lab. Unions in Dest. ctry." ///
					  10 "(7c) Migrants Can Join Lab. Unions in Dest. ctry." ///
					  11 "(7d) Role of Employer Organizations" ///
					  12 "(7e) Role of Other NGOs or Civil Society Orga." ///
					  13 "(8) Provision of Relevant Info. to Mig." ///
					  14 "(9) Equal Treatment and Non-Discri. of Mig. Workers" ///
					  15 "(10a) General Gender Protection of Women" ///
					  16 "(10b) Gender Protection of Domestic Workers" ///
					  17 "(10c) Other Protections (Race, Relig., etc.)" ///
					  18 "(11a) Employment Contract Required" ///
					  19 "(11b) Standard Employment Contract" ///
					  20 "(11c) Specific Contract Terms Required" ///
					  21 "(12) Wage Protection" ///
					  22 "(13a) Employer Required to Provide Housing" ///
					  23 "(13b) Housing Must Meet Certain Condit." ///
					  24 "(13c) Gov't Monitors Housing" ///
					  25 "(13d) Gov't Monitors Work Condi." ///
					  26 "(14) Prohibet to Confisc Travel Documents" ///
					  27 "(15) Social Protec. and Health-Care Benef." ///
					  28 "(16) Mechanisms for Compl. and Dispute Res." ///
					  29 "(17) HR Devpt and Skills Improvement" ///
					  30 "(18) Recognition of Skills and Qualifications" ///
					  31 "(19) Transfer of Savings and Remittances" ///
					  32 "(20a) Reintegration of Migrants upon Return" ///
					  33 "(20b) Possibility of Contract Renewal" ///
					  34 "(20c) Pathway to Legal Permanent Residence"
					  					  
label values ilocode ilolabel
*Appendix A Figure A4

preserve 
keep if ilocode==1 | ilocode==2  | ilocode==3 | ilocode==4 | ilocode==5 | ilocode==6 | ilocode==7 | ilocode==8 | ilocode==9 | ilocode==10 | ilocode==11 | ilocode==12


graph bar (mean) ilo0 ilo1, over(ilocode, label(labsize(vsmall)) axis(outergap(*40)))  horizontal ytitle("Share of BLAs that mention a topic related" "to governance of labor migration")  xsize(3) ysize(2) legend( label(1 "`:variable label ilo0'") label(2 "`:variable label ilo1'") pos(6) rows(2)) 
graph export  "$FIG/Figure_appendixA4_afr.png", replace 

restore

*Appendix A Figure A5
preserve 


keep if  ilocode==13 | ilocode==14 | ilocode==15 | ilocode==16 | ilocode==17 | ilocode==18 | ilocode==19 | ilocode==20  | ilocode==21 | ilocode==22 | ilocode==23 | ilocode==24 | ilocode==25 | ilocode==26 | ilocode==27 | ilocode==28 


graph bar (mean) ilo0 ilo1, over(ilocode, label(labsize(vsmall)) axis(outergap(*40)))  horizontal ytitle("Share of BLAs that mention a topic related" "to protection and empowerment of migrant workers")  legend(rows(1)) xsize(3) ysize(2) legend( label(1 "`:variable label ilo0'") label(2 "`:variable label ilo1'") pos(6) rows(2)) 
graph export  "$FIG/Figure_appendixA5_afr.png", replace 

restore


*Appendix A Figure A6
preserve 
keep if  ilocode==29 | ilocode==30 | ilocode==31 | ilocode==32 | ilocode==33 | ilocode==34

graph bar (mean) ilo0 ilo1, over(ilocode, label(labsize(vsmall)) axis(outergap(*40)))  horizontal ytitle("Share of BLAs that mention a topic related" "to migration and development")  legend(rows(1)) xsize(3) ysize(2) legend( label(1 "`:variable label ilo0'") label(2 "`:variable label ilo1'") pos(6) rows(2)) 
graph export  "$FIG/Figure_appendixA6_afr.png", replace 

restore 

