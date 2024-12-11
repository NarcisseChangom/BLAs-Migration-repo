*==============================================================================*
* 			Table 1 & B.1 - Structure of migration and BLAs 			   	           *
*==============================================================================*
g regular = (minmig>9)
g mpos = (mig>0)
egen BLA = max(dum_BLAs_10), by(o_iso3 d_iso3)
gen BLAreg = BLA if regular==1 


forval i = 1960(10)2020{
	gen mig`i' = mig/1000000 if year==`i'
	gen mig`i'_reg = mig`i' if regular==1 
	gen mig`i'_BLA = mig`i' if BLA==1 
}


lab var mpos "Share of non empty corridors"
lab var regular "Share of regular corrdiors"
lab var BLA "Share of corridors with BLA"
lab var BLAreg "Share of regular corridors with BLA"
lab var mig2020 "All corridors"
lab var mig2020_reg "Regular corridors"
lab var mig2020_BLA "Corridors with ever a BLA"

gen sample1 = 1
gen sample2 = AFR_o==1
gen sample3 = devcat==1 
gen sample4 = devcat==2 
gen sample5 = GCC_d==1

cap program drop BLAdesc
program define BLAdesc
syntax varname, stat(string) digit(int) handle(string)
qui forval i = 1/5{
	summ `varlist' if sample`i'==1
	local x`i' = string(round(r(`stat'), 0.001), "%9.`digit'f")
}
local lbl: var l `varlist'
file write `handle' " `lbl' & `x1'& `x2' & `x3' & `x4' & `x5' \\" _n
end 


*************
* Table 1
************* 
file open mytexfile using "${REGOUT}\Descs.tex", write replace
file write mytexfile "\begin{tabular}{lccccc}" _n
file write mytexfile "\hline \hline" _n
file write mytexfile "& Full sample & African origins & LLMIC & UMHIC & GCC destinations \\" _n
file write mytexfile " & (1) & (2) & (3) & (4) & (5) \\" _n
file write mytexfile " \cmidrule{2-6} " _n 
file write mytexfile " &\multicolumn{5}{c}{Bilateral migration data} \\" _n 
file write mytexfile " \cmidrule{2-6} " _n

BLAdesc mpos, stat(mean) digit(3) handle(mytexfile)
BLAdesc regular, stat(mean) digit(3) handle(mytexfile)

file write mytexfile " \cmidrule{2-6} " _n
file write mytexfile " &\multicolumn{5}{c}{Bilateral labor agreement data} \\" _n 
file write mytexfile " \cmidrule{2-6} " _n

BLAdesc BLA, stat(mean) digit(3) handle(mytexfile)
BLAdesc BLAreg, stat(mean) digit(3) handle(mytexfile)

file write mytexfile " \cmidrule{2-6} " _n
file write mytexfile " &\multicolumn{5}{c}{Migrant stock (in million) in 2020} \\" _n 
file write mytexfile " \cmidrule{2-6} " _n

BLAdesc mig2020, stat(sum) digit(1) handle(mytexfile)
BLAdesc mig2020_reg, stat(sum) digit(1) handle(mytexfile)
BLAdesc mig2020_BLA, stat(sum) digit(1) handle(mytexfile)

file write mytexfile "\hline \hline" _n
file write mytexfile "\end{tabular}" _n
file close mytexfile 


**************
* Table B.1
**************
file open mytexfile using "${REGOUT}\Descriptives_decadal.tex", write replace
file write mytexfile "\begin{tabular}{lccccc}" _n
file write mytexfile "\hline \hline" _n
file write mytexfile "& Full sample & African origins & LLMIC & UMHIC & GCC destinations \\" _n
file write mytexfile " & (1) & (2) & (3) & (4) & (5) \\" _n
file write mytexfile " \cmidrule{2-6} " _n 
file write mytexfile " &\multicolumn{5}{c}{Migrant stock (in million)} \\" _n 
file write mytexfile " \cmidrule{2-6} " _n

forval y = 1960(10)2020{
	label var mig`y' "`y'"
	BLAdesc mig`y', stat(sum) digit(1) handle(mytexfile)
}

file write mytexfile " \cmidrule{2-6} " _n
file write mytexfile " &\multicolumn{5}{c}{Migrant stock-regular corridors (in million)} \\" _n 
file write mytexfile " \cmidrule{2-6} " _n

forval y = 1960(10)2020{
	label var mig`y'_reg "`y'"
	BLAdesc mig`y'_reg, stat(sum) digit(1) handle(mytexfile)
}

file write mytexfile " \cmidrule{2-6} " _n
file write mytexfile " &\multicolumn{5}{c}{Migrant stock- corridors with BLAs (in million)} \\" _n 
file write mytexfile " \cmidrule{2-6} " _n

forval y = 1960(10)2020{
	label var mig`y'_BLA "`y'"
	BLAdesc mig`y'_BLA, stat(sum) digit(1) handle(mytexfile)
}

file write mytexfile "\hline \hline" _n
file write mytexfile "\end{tabular}" _n
file close mytexfile 

drop sample?
