
*==============================================================================*
* 			Table 01 & B2 - Structure of migration and BLAs 			   	           *
*==============================================================================*
g regular = (minmig>9)
g mzero = (mig>0)
g blazero = (dum_BLAs_10==1)
replace devcat = 2 if devcat==.
egen BLAe = max(dum_BLAs_10), by(o_iso3 d_iso3)
g BLAex = (BLAe>0) 
g un = 1
g mig1 = mig/1000000
clonevar BLAex2 = BLAex
g un2 = un 
g un3 = un 

lab define regular 1 "Share of regular corridors" 0 "Share of non regular corridors"
lab values regular regular 
lab define mzero 1 "Share of non empty corridors" 0 "Share of empty corridors" 
lab values mzero mzero 

lab define un 1 "Number of migrants" 
lab values un un 
lab define un2 1 "Regular corridors" 
lab values un2 un2 
lab define un3 1 "Corridors with BLA" 
lab values un3 un3 
lab define BLAex 1 "Share of corridors with BLA"
lab values BLAex BLAex 
lab define BLAex2 1 "Share of regular corridors with BLA"
lab values BLAex2 BLAex2 
lab var mzero "Share of non empty corridors"
lab var regular "Share of regular corrdiors"
lab var BLAex "Share of corridors with BLA"
lab var BLAex2 "Share of regular corridors with BLA"
lab var un "Number of migrants"
lab var un2 "Number of migrants in regular corridors"
lab var un3 "Number of migrants in corridors with BLA"

preserve 
*putexcel set "$REGOUT\Table_01.xlsx", replace 
/* Column 1 table 1 (Full sample)*/
table (mzero), statistic(percent) nototals nformat(%9.1fc percent) /*% non empty corrdiors */
table (regular), statistic(percent) nototals nformat(%9.1fc percent) append /*% regular corrdiors */
table (BLAex), statistic(percent) nototals nformat(%9.1fc percent) append /*% corridors with BLA*/
table (BLAex2) if regular==1, statistic(percent) nototals nformat(%9.1fc percent) append  /*% regular corridors with BLA*/
table (un) if year==2020, statistic(total mig1) nototals nformat(%9.2fc total) append  /* Number of migrants in 2020 */
table (un2) if year==2020 & regular==1, statistic(total mig1) nototals nformat(%9.2fc total) append  /* Number of migrants in 2020 within regular corridors */
table (un3) if year==2020 & BLAex==1, statistic(total mig1) nototals nformat(%9.2fc total) append  /* Number of migrants in 2020 within corridors with BLAs*/
collect layout (mzero[1] regular[1] BLAex[1] BLAex2[1] un un2 un3) (result) 
collect export "$REGOUT\Table_01.xlsx", sheet("Full-sample") replace 
/*
putexcel set "$REGOUT\Table_01.xlsx", sheet("Table_1", replace) modify 
putexcel A1 = collect 
putexcel C1 "Full-sample"
*/
/* Column 2 table 1 (Africa)*/
table (mzero) if AFR_o==1, statistic(percent) nototals nformat(%9.1fc percent) 
table (regular) if AFR_o==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex) if AFR_o==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex2) if regular==1 & AFR_o==1, statistic(percent) nototals nformat(%9.1fc percent) append  
table (un) if year==2020 & AFR_o==1, statistic(total mig1) nototals nformat(%9.2fc total) append 
table (un2) if year==2020 & regular==1 & AFR_o==1, statistic(total mig1) nototals nformat(%9.2fc total) append  
table (un3) if year==2020 & BLAex==1 & AFR_o==1, statistic(total mig1) nototals nformat(%9.2fc total) append
collect layout (mzero[1] regular[1] BLAex[1] BLAex2[1] un un2 un3) (result) 
collect export "$REGOUT\Table_01.xlsx", sheet("Africa-origin") modify 
/*
putexcel "$REGOUT\Table_01.xlsx", sheet("Table_1") modify 
putexcel A1 = collect 
putexcel D1 "Africa"
*/

/* Column 3 table 1 (LLMIC)*/
table (mzero) if devcat==1, statistic(percent) nototals nformat(%9.1fc percent) 
table (regular) if devcat==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex) if devcat==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex2) if regular==1 & devcat==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (un) if year==2020 & devcat==1, statistic(total mig1) nototals nformat(%9.2fc total) append 
table (un2) if year==2020 & regular==1 & devcat==1, statistic(total mig1) nototals nformat(%9.2fc total) append  
table (un3) if year==2020 & BLAex==1 & devcat==1, statistic(total mig1) nototals nformat(%9.2fc total) append
collect layout (mzero[1] regular[1] BLAex[1] BLAex2[1] un un2 un3) (result) 
collect export "$REGOUT\Table_01.xlsx", sheet("LLMIC") modify
/*
putexcel "$REGOUT\Table_01.xlsx", sheet("Table_1") modify 
putexcel A1 = collect 
putexcel E1 "LLMIC"
*/
/* Column 4 table 1 (UMHIC)*/
table (mzero) if devcat==2, statistic(percent) nototals nformat(%9.1fc percent) 
table (regular) if devcat==2, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex) if devcat==2, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex2) if regular==1 & devcat==2, statistic(percent) nototals nformat(%9.1fc percent) append 
table (un) if year==2020 & devcat==2, statistic(total mig1) nototals nformat(%9.2fc total) append 
table (un2) if year==2020 & regular==1 & devcat==2, statistic(total mig1) nototals nformat(%9.2fc total) append  
table (un3) if year==2020 & BLAex==1 & devcat==2, statistic(total mig1) nototals nformat(%9.2fc total) append
collect layout (mzero[1] regular[1] BLAex[1] BLAex2[1] un un2 un3) (result) 
collect export "$REGOUT\Table_01.xlsx", sheet("UMHIC") modify
/*
putexcel "$REGOUT\Table_01.xlsx", sheet("Table_1") modify 
putexcel A1 = collect 
putexcel F1 "UMHIC"
*/

/* Column 5 table 1 (GCC destinations)*/
table (mzero) if GCC_d==1, statistic(percent) nototals nformat(%9.1fc percent) 
table (regular) if GCC_d==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex) if GCC_d==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (BLAex2) if regular==1 & GCC_d==1, statistic(percent) nototals nformat(%9.1fc percent) append 
table (un) if year==2020 & devcat==2, statistic(total mig1) nototals nformat(%9.2fc total) append 
table (un2) if year==2020 & regular==1 & GCC_d==1, statistic(total mig1) nototals nformat(%9.2fc total) append  
table (un3) if year==2020 & BLAex==1 & GCC_d==1, statistic(total mig1) nototals nformat(%9.2fc total) append
collect layout (mzero[1] regular[1] BLAex[1] BLAex2[1] un un2 un3) (result) 
collect export "$REGOUT\Table_01.xlsx", sheet("GCC_d") modify
/*
putexcel "$REGOUT\Table_01.xlsx", sheet("Table_1") modify 
putexcel A1 = collect 
putexcel F1 "UMHIC"
*/

/* Combine various columns */
import excel "$REGOUT\Table_01.xlsx", sheet("Full-sample") firstrow clear
replace Percent = Total if Percent==.
drop Total
drop if Percent==.
ren Percent Full 
lab var Full "Full sample"
ren A fid 
tempfile full 
save `full'

import excel "$REGOUT\Table_01.xlsx", sheet("Africa-origin") firstrow clear
replace Percent = Total if Percent==.
drop Total
drop if Percent==.
ren Percent Africa 
lab var Africa "Africa origins"
ren A fid 
tempfile afri  
save `afri'


import excel "$REGOUT\Table_01.xlsx", sheet("LLMIC") firstrow clear
replace Percent = Total if Percent==.
drop Total
drop if Percent==.
ren Percent LLMIC 
lab var LLMIC "LLMIC"
ren A fid 
tempfile llmic  
save `llmic'

import excel "$REGOUT\Table_01.xlsx", sheet("UMHIC") firstrow clear
replace Percent = Total if Percent==.
drop Total
drop if Percent==.
ren Percent UMHIC 
lab var UMHIC "UMHIC"
ren A fid 
tempfile umhic  
save `umhic'


import excel "$REGOUT\Table_01.xlsx", sheet("GCC_d") firstrow clear
replace Percent = Total if Percent==.
drop Total
drop if Percent==.
ren Percent GCC 
lab var GCC "GCC destinations"
ren A fid 
tempfile gcc  
save `gcc'

use `full', clear 
merge 1:1 fid using `afri'
drop _m 
merge 1:1 fid using `afri'
drop _m 
merge 1:1 fid using `llmic'
drop _m 
merge 1:1 fid using `umhic'
drop _m 
merge 1:1 fid using `gcc'
drop _m 

g id =.
replace id = 1 if fid == "  Share of non empty corridors"
replace id = 2 if fid == "  Share of regular corridors"
replace id = 3 if fid == "  Share of corridors with BLA"
replace id = 4 if fid == "  Share of regular corridors with BLA"
replace id = 5 if fid == "  Number of migrants"
replace id = 6 if fid == "  Regular corridors"
replace id = 7 if fid == "  Corridors with BLA"

lab define id 1 "Share of non empty corridors" ///
		      2 "Share of regular corridors" ///
		      3 "Share of corridors with BLA" ///
		      4 "Share of regular corridors with BLA" ///
		      5 "Number of migrants" ///
		      6 "Regular corridors" ///
		      7 "Corridors with BLA" 
lab values id id 

drop fid 
order id 

xtable id, c(mean Full mean Africa mean LLMIC mean UMHIC mean GCC) noput format(%5.1fc) 
putexcel set "$REGOUT\Table_1.xlsx", replace 
putexcel A1 = ("Structure of migration and BLAs") A3 = matrix(r(xtable)), rownames  
putexcel B2 = "Full sample"
putexcel C2 = "Africa origins"
putexcel D2 = "LLMIC" 
putexcel E2 = "UMHIC"
putexcel F2 = "GCC destinations"

restore 


*Table B-1
/* Column 1 table 1 (Full sample)*/
g year2 = year 
g year3 = year 

table (year), statistic(total mig1) nototals nformat(%9.1fc total)
table (year2) if regular==1, statistic(total mig1) nototals nformat(%9.1fc total) append
table (year3) if BLAex==1, statistic(total mig1) nototals nformat(%9.1fc percent) append
collect layout (year year2 year3) (result) 
collect export "$REGOUT\Table_ok.xlsx", sheet("total") replace 


/* Column 2 table 1 (Africa)*/
table (year) if AFR_o==1, statistic(total mig1) nototals nformat(%9.1fc total)
table (year2) if regular==1 & AFR_o==1, statistic(total mig1) nototals nformat(%9.1fc total) append
table (year3) if BLAex==1 & AFR_o==1, statistic(total mig1) nototals nformat(%9.1fc percent) append
collect layout (year year2 year3) (result) 
collect export "$REGOUT\Table_ok.xlsx", sheet("africa") modify 


/* Column 3 table B1 (LLMIC)*/
table (year) if devcat==1, statistic(total mig1) nototals nformat(%9.1fc total)
table (year2) if regular==1 & devcat==1, statistic(total mig1) nototals nformat(%9.1fc total) append
table (year3) if BLAex==1 & devcat==1, statistic(total mig1) nototals nformat(%9.1fc percent) append
collect layout (year year2 year3) (result) 
collect export "$REGOUT\Table_ok.xlsx", sheet("llmic") modify 


/* Column 4 table B2 (UMHIC)*/
table (year) if devcat==2, statistic(total mig1) nototals nformat(%9.1fc total)
table (year2) if regular==1 & devcat==2, statistic(total mig1) nototals nformat(%9.1fc total) append
table (year3) if BLAex==1 & devcat==2, statistic(total mig1) nototals nformat(%9.1fc percent) append
collect layout (year year2 year3) (result) 
collect export "$REGOUT\Table_ok.xlsx", sheet("umhic") modify 

/* Column 5 table 1 (GCC destinations)*/
table (year) if GCC_d==1, statistic(total mig1) nototals nformat(%9.1fc total)
table (year2) if regular==1 & GCC_d==1, statistic(total mig1) nototals nformat(%9.1fc total) append
table (year3) if BLAex==1 & GCC_d==1, statistic(total mig1) nototals nformat(%9.1fc percent) append
collect layout (year year2 year3) (result) 
collect export "$REGOUT\Table_ok.xlsx", sheet("gcc") modify 


/* Combine various columns */
import excel "$REGOUT\Table_ok.xlsx", sheet("total") firstrow clear
ren A fid 
g id = _n 
tempfile full 
save `full'

import excel "$REGOUT\Table_ok.xlsx", sheet("africa") firstrow clear
ren Total Africa 
lab var Africa "Africa origins"
ren A fid 
g id = _n 
tempfile afri  
save `afri'


import excel "$REGOUT\Table_ok.xlsx", sheet("llmic") firstrow clear
ren Total LLMIC 
ren A fid 
g id = _n 
tempfile llmic  
save `llmic'

import excel "$REGOUT\Table_ok.xlsx", sheet("umhic") firstrow clear
ren Total UMHIC 
lab var UMHIC "UMHIC"
ren A fid 
g id = _n 
tempfile umhic  
save `umhic'


import excel "$REGOUT\Table_ok.xlsx", sheet("gcc") firstrow clear
ren Total GCC 
lab var GCC "GCC destinations"
ren A fid 
g id = _n 
tempfile gcc  
save `gcc'

use `full', clear 
merge 1:1 id using `afri'
drop _m 
merge 1:1 id using `afri'
drop _m 
merge 1:1 id using `llmic'
drop _m 
merge 1:1 id using `umhic'
drop _m 
merge 1:1 id using `gcc'
drop _m 

/*
g id =.
replace id = 1 if fid == "  Share of non empty corridors"
replace id = 2 if fid == "  Share of regular corridors"
replace id = 3 if fid == "  Share of corridors with BLA"
replace id = 4 if fid == "  Share of regular corridors with BLA"
replace id = 5 if fid == "  Number of migrants"
replace id = 6 if fid == "  Regular corridors"
replace id = 7 if fid == "  Corridors with BLA"

lab define id 1 "Share of non empty corridors" ///
		      2 "Share of regular corridors" ///
		      3 "Share of corridors with BLA" ///
		      4 "Share of regular corridors with BLA" ///
		      5 "Number of migrants" ///
		      6 "Regular corridors" ///
		      7 "Corridors with BLA" 
lab values id id 

drop fid 
order id 
*/
labmask id, values(fid)
xtable id, c(mean Total mean Africa mean LLMIC mean UMHIC mean GCC) noput format(%5.1fc) 
putexcel set "$REGOUT\Table_B1.xlsx", replace 
putexcel A1 = ("Migration and migration corridors with BLAs over time") A3 = matrix(r(xtable)), rownames  
putexcel B2 = "Full sample"
putexcel C2 = "Africa origins"
putexcel D2 = "LLMIC" 
putexcel E2 = "UMHIC"
putexcel F2 = "GCC destinations"

