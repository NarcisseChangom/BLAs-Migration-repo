
*------------------------------------------------------------------------------*
*					2.0 - Main analysis 									   *
*------------------------------------------------------------------------------*
use "$DATA\BLA_Migration_data", clear 		
label var dum_BLAs_10 "BLA"

gen sample1 = 1 
gen sample2 = minmig>9 if !mi(minmig)
gen sample3 = pct>1
g amig = asinh(mig)
*==================================== 
* 					2.1 - Benchmark estimation (Migration response to BLAs (Tab. 2))    	          
*==================================== 

eststo clear 
qui forval s = 1/2{
	forval f= 1/3{
		eststo ols`s'_`f':  reghdfe amig dum_BLAs_10 if sample`s'==1, abs(${FE`f'}) cl($CL)
		tokenize `"${FE`f'}"'
		while "`1'" != ""{
			estadd local "l`1'" "Y": ols`s'_`f'
			macro shift
		}
	}
}

file open mytexfile using "${REGOUT}\Table_2.tex", write replace
file write mytexfile "\begin{tabular}{lccccccc}" _n
file write mytexfile "\hline \hline" _n
file write mytexfile "&\multicolumn{3}{c}{Full sample} & & \multicolumn{3}{c}{Regular corridors (\$M_{ij}\geq 10\$)} \\" _n
file write mytexfile "\cmidrule(lr){2-4} \cmidrule(lr){5-8}" _n
file write mytexfile "& (1) & (2) & (3) & & (4) & (5) & (6) \\" _n
file close mytexfile 

estout ols1_1 ols1_2 ols1_3 ols2_1 ols2_2 ols2_3  using "$REGOUT\Table_2.tex", append style(tex) cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) starlevels(\$^*\$ 0.10 \$^{**}\$ 0.05 \$^{***}\$ 0.01) keep(dum_BLAs_10) stats(N fe lot ldt lod lyear, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.0fc %9.0fc) labels("\hline Observations" "Fixed effects" "Origin \$\times\$ Decade " "Destination \$\times\$ Decade" "Origin \$\times\$ Destination"  "Decade"))  label coll(none) mlab(none)  extracols(4) prehead(\hline) postfoot(\cmidrule(lr){2-4} \cmidrule(lr){5-8}) 

forval i = 1/2{
	summ mig if sample`i'==1
	local m`i' = string(r(sum)/7, "%13.0fc")
	summ BLAs_signed if sample`i'==1
	local s`i' = string(r(sum)/7, "%13.0fc")	
}
file open mytexfile using "${REGOUT}\Table_2.tex", write append
file write mytexfile "Migrants per decade &\multicolumn{3}{c}{`m1'} & & \multicolumn{3}{c}{`m2'} \\" _n
file write mytexfile "BLAs per decade &\multicolumn{3}{c}{`s1'} & & \multicolumn{3}{c}{`s2'} \\" _n
file write mytexfile "\hline \end{tabular}" _n
file close mytexfile 


*==================================== 
* 					2.2 - Robustness w.r.t estimation method (PPML) 
*						  (Migration response to BLAs (PPML) -- Tab. B.2)
*						  as well as with exclusion of top 1 percent corridors 
*						  (Migration response to BLAs (top 1% od excluded)-- Tab. B.3)    	          
*==================================== 	   
	


eststo clear 
qui forval s = 1/3{
	forval f= 1/3{
		eststo ppml`s'_`f':  ppmlhdfe mig dum_BLAs_10 if sample`s'==1, abs(${FE`f'}) cl($CL)
		tokenize `"${FE`f'}"'
		while "`1'" != ""{
			estadd local "l`1'" "Y": ppml`s'_`f'
			macro shift
		}
	}
}
*==================================== 
* 					2.2.1 - Migration response to BLAs (PPML) -- Tab. B.2   	          
*==================================== 

file open mytexfile using "${REGOUT}\Table_B2.tex", write replace
file write mytexfile "\begin{tabular}{lccccccc}" _n
file write mytexfile "\hline \hline" _n
file write mytexfile "&\multicolumn{3}{c}{Full sample} & & \multicolumn{3}{c}{Regular corridors (\$M_{ij}\geq 10\$)} \\" _n
file write mytexfile "\cmidrule(lr){2-4} \cmidrule(lr){5-8}" _n
file write mytexfile "& (1) & (2) & (3) & & (4) & (5) & (6) \\" _n
file close mytexfile 

estout ppml1_1 ppml1_2 ppml1_3 ppml2_1 ppml2_2 ppml2_3  using "$REGOUT\Table_B2.tex", append style(tex) cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) starlevels(\$^*\$ 0.10 \$^{**}\$ 0.05 \$^{***}\$ 0.01) keep(dum_BLAs_10) stats(N fe lot ldt lod lyear, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.0fc %9.0fc) labels("\hline Observations" "Fixed effects" "Origin \$\times\$ Decade " "Destination \$\times\$ Decade" "Origin \$\times\$ Destination"  "Decade"))  label coll(none) mlab(none)  extracols(4) prehead(\hline) postfoot(\hline \hline \end{tabular}) 

	   
*==================================== 
* 					2.2.2 - Migration response to BLAs -- Tab. B.3
*						    (top 1 percent corridors excluded)   	          
*==================================== 	 

estout ppml3_1 ppml3_2 ppml3_3 using "$REGOUT\Table_B3.tex", replace style(tex) cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) starlevels(\$^*\$ 0.10 \$^{**}\$ 0.05 \$^{***}\$ 0.01) keep(dum_BLAs_10) stats(N fe lot ldt lod lyear, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.0fc %9.0fc) labels("\hline Observations" "Fixed effects" "Origin \$\times\$ Decade " "Destination \$\times\$ Decade" "Origin \$\times\$ Destination"  "Decade"))  label coll(none) mlab(none) number   prehead(\begin{tabular}{lccc} \hline \hline) posthead(\hline) postfoot(\hline \hline \end{tabular}) 
 
	   
	   
	   
/* More time needed to properly build the layout of table 3*/	   
*==================================== 
* 			2.2 - IV estimation     	          
*==================================== 
	gen instr = . 
	label var instr "Leave one out"

eststo clear    
	forval s = 1/2{ //samples
		foreach i in in out{ //instruments 
			replace instr = ln_leave_`i'
			eststo fs_s`s'_`i': reghdfe dum_BLAs_10 instr if sample`s'==1, abs($FE3) cl($CL) //FS
			estadd local ot "Y": fs_s`s'_`i'
			estadd local dt "Y": fs_s`s'_`i'
			estadd local od "Y": fs_s`s'_`i'

			eststo iv_s`s'_`i': ivreghdfe amig (dum_BLAs_10 = instr) if sample`s'==1, abs($FE3) cl($CL) //FS
			estadd local ot "Y": iv_s`s'_`i'
			estadd local dt "Y": iv_s`s'_`i'
			estadd local od "Y": iv_s`s'_`i'
			estadd scalar kpaap = `e(widstat)' : fs_s`s'_`i'

		}
	}

	
	
/* Stack table s*/
** top panel - Full sample 
esttab  fs_s1_in iv_s1_in fs_s1_out iv_s1_out using "$REGOUT\Table_3.tex", replace f ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	   postfoot(\bottomrule) ///
	    b(3) se(3) nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(_cons) order(dum_BLAs_10 instr) s(N kpaap, fmt(%9.0fc %9.2fc  %9.2fc) ///
	   label("Observations" "K. Paap F.")) ///
	    label booktabs nonotes nomtitle  collabels(none) ///
	   mgroups("First stage" "IV" "First stage" "IV", pattern(1 1 1 1) ///	
	   prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) 
	   

	   
** Bottom panel - Regular corridors 
esttab fs_s2_in iv_s2_in fs_s2_out iv_s2_out using "$REGOUT\Table_3.tex", append f ///
	   postfoot(\bottomrule \end{tabular}) ///
	   b(3) se(3) r2 star(* 0.10 ** 0.05 *** 0.01) drop(_cons) ///
	   order(dum_BLAs_10 instr) s(N kpaap fe ot dt od, fmt(%9.0fc %9.3fc  %9.2fc  %9.2fc %9.2fc) ///
	   label("\bottomrule Observations" "K. Paap F." "\bottomrule Fixed effects" "Origin x Decade" "Destination x Decade" ///
	   "Origin x Destination " )) ///
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
