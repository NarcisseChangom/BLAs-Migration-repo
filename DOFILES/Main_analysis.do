
*------------------------------------------------------------------------------*
*					2.0 - Main analysis 									   *
*------------------------------------------------------------------------------*

*==================================== 
* 					2.1 - Benchmark estimation (Migration response to BLAs (Tab. 2))    	          
*==================================== 

eststo clear 
	eststo ols1a : quiet reghdfe amig dum_BLAs_10, abs($FE1) cl($CL)
	estadd local ot "No", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	estadd local year "Yes", replace
	
	eststo ols2a : quiet reghdfe amig dum_BLAs_10, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	
	eststo ols3a : quiet reghdfe amig dum_BLAs_10, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
	eststo ols1b : quiet reghdfe amig dum_BLAs_10 if minmig>9, abs($FE1) cl($CL)
	estadd local ot "No", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	estadd local year "Yes", replace
	
	eststo ols2b : quiet reghdfe amig dum_BLAs_10 if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	
	eststo ols3b : quiet reghdfe amig dum_BLAs_10 if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace	
	
	
esttab ols1a  ///
	   ols2a  ///
	   ols3a ///
	   ols1b ///
	   ols2b ///
	   ols3b, ///
	   label nomtitles se star(* 0.1 ** 0.05 *** 0.01) ///
	   keep(dum_BLAs_10) ///
	   order(dum_BLAs_10) ///
	   nonotes nomtitles collabels(none) compress sfmt(0) ///
	   s(N ot dt od year, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "Origin country x decade FE" "Destination country x decade FE" ///
	   "Origin x destination countries FE" "Decade FE")) ///
	   title("Migration response to BLAs (Benchmark)") ///
	   mgroups("Full sample" "Regular corridors only (M_ij>=10)", ///
	   pattern(1 0 0 1 0 0)) ///
	   addnotes("The table presents the estimate of $\gamma$ from OLS estimate of equation \eqref{baseline}." ///
				"It shows the impact of a BLA on migration. The outcome variable is the inverse hyperbolic" ///
				"sine of migration. Columns (4) to (6) restrict the analysis to `regular' corridors which have at " ///
				"least 10 migrants across all time period. Standard errors in parentheses are clustered" ///
				"at the origin-destination level. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).")
	   
	   
esttab ols1a  ///
	   ols2a  ///
	   ols3a ///
	   ols1b ///
	   ols2b ///
	   ols3b ///
	   using "$REGOUT\Table_2.tex", /// 
	   b(3) se(3) nomtitle label star(* 0.10 ** 0.05 *** 0.01) /// 
	   booktabs  order(dum_BLAs_10) /// 
	   keep(dum_BLAs_10) /// 
	   addnotes("The table presents the estimate of $\gamma$ from OLS estimate of equation \eqref{baseline}. It shows the impact of a BLA on migration. The outcome variable is the inverse hyperbolic sine of migration. Columns (4) to (6) restrict the analysis to `regular' corridors which have at least 10 migrants across all time period. Standard errors in parentheses are clustered at the origin-destination level. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") /// 
	   s(N ot dt od year, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.1fc) /// 
	   label("Observations" "Origin country x decade FE" ///
	   "Destination country x decade FE" ///
	   "Origin x destination countries FE"  "Decade FE")) ///
	   title("Migration response to BLAs (Benchmark)") ///
	   mgroups("Full sample" "Regular corridors only (M_ij>=10)", ///
	   pattern(1 0 0 1 0 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) ///
	   span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) replace	  	

*==================================== 
* 					2.2 - Robustness w.r.t estimation method (PPML) 
*						  (Migration response to BLAs (PPML) -- Tab. B.2)
*						  as well as with exclusion of top 1 percent corridors 
*						  (Migration response to BLAs (top 1% od excluded)-- Tab. B.3)    	          
*==================================== 	   
	

*==================================== 
* 					2.2.1 - Migration response to BLAs (PPML) -- Tab. B.2   	          
*==================================== 

eststo clear 
	eststo ppml1a : quiet ppmlhdfe mig dum_BLAs_10, abs($FE1) cl($CL)
	estadd local ot "No", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	estadd local year "Yes", replace
	
	eststo ppml2a : quiet ppmlhdfe mig dum_BLAs_10, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	
	eststo ppml3a : quiet ppmlhdfe mig dum_BLAs_10, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
	eststo ppml1b : quiet ppmlhdfe mig dum_BLAs_10 if minmig>9, abs($FE1) cl($CL)
	estadd local ot "No", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	estadd local year "Yes", replace
	
	eststo ppml2b : quiet ppmlhdfe mig dum_BLAs_10 if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	
	eststo ppml3b : quiet ppmlhdfe mig dum_BLAs_10 if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace	
	
	
esttab ppml1a  ///
	   ppml2a  ///
	   ppml3a ///
	   ppml1b ///
	   ppml2b ///
	   ppml3b, ///
	   label nomtitles se star(* 0.1 ** 0.05 *** 0.01) ///
	   keep(dum_BLAs_10 _cons) ///
	   order(dum_BLAs_10) ///
	   nonotes nomtitles collabels(none) compress sfmt(0) ///
	   s(N ot dt od year, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "Origin country x decade FE" "Destination country x decade FE" ///
	   "Origin x destination countries FE" "Decade FE")) ///
	   title("Migration response to BLAs (Benchmark)") ///
	   mgroups("Full sample" "Regular corridors only (M_ij>=10)", ///
	   pattern(1 0 0 1 0 0)) ///
	   addnotes("The table presents the estimate of $\gamma$ from PPML estimate of equation \eqref{baseline}. It shows the impact of a BLA on migration. The outcome variable is the inverse hyperbolic sine of migration. Columns (4) to (6) restrict the analysis to `regular' corridors which have at least 10 migrants across all time period. Standard errors in parentheses are clustered at the origin-destination level. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).")
	    
	   
	   
esttab ppml1a  ///
	   ppml2a  ///
	   ppml3a ///
	   ppml1b ///
	   ppml2b ///
	   ppml3b ///
	   using "$REGOUT\Table_B2.tex", /// 
	   b(3) se(3) nomtitle label star(* 0.10 ** 0.05 *** 0.01) /// 
	   booktabs  order(dum_BLAs_10) /// 
	   keep(dum_BLAs_10) /// 
	   addnotes("The table presents the estimate of $\gamma$ from PPML estimate of equation \eqref{baseline}." ///
				"It shows the impact of a BLA on migration. The outcome variable is the inverse hyperbolic" ///
				"sine of migration. Columns (4) to (6) restrict the analysis to `regular' corridors which have at " ///
				"least 10 migrants across all time period. Standard errors in parentheses are clustered" ///
				"at the origin-destination level. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") /// 
	   s(N ot dt od year, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.1fc) /// 
	   label("Observations" "Origin country x decade FE" ///
	   "Destination country x decade FE" ///
	   "Origin x destination countries FE"  "Decade FE")) ///
	   title("Migration response to BLAs (Benchmark)") ///
	   mgroups("Full sample" "Regular corridors only (M_ij>=10)", ///
	   pattern(1 0 0 1 0 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) ///
	   span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) replace	 


	   
*==================================== 
* 					2.2.2 - Migration response to BLAs -- Tab. B.3
*						    (top 1 percent corridors excluded)   	          
*==================================== 	   

eststo clear 
	eststo ppml1a : quiet ppmlhdfe mig dum_BLAs_10 if pct>1, abs($FE1) cl($CL)
	estadd local ot "No", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	estadd local year "Yes", replace
	
	eststo ppml2a : quiet ppmlhdfe mig dum_BLAs_10 if pct>1, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	
	eststo ppml3a : quiet ppmlhdfe mig dum_BLAs_10 if pct>1, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	

	
esttab ppml1a  ///
	   ppml2a  ///
	   ppml3a, ///
	   label nomtitles se star(* 0.1 ** 0.05 *** 0.01) ///
	   keep(dum_BLAs_10) ///
	   order(dum_BLAs_10) ///
	   nonotes nomtitles collabels(none) compress sfmt(0) ///
	   s(N ot dt od year, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "Origin country x decade FE" "Destination country x decade FE" ///
	   "Origin x destination countries FE" "Decade FE"))  /// 
	   addnotes("The table presents the estimate of $\gamma$ from PPML estimate of equation \eqref{baseline}." ///
				"It shows the impact of a BLA on migration when top 1\% of corridors (large corridors) are excluded." ///
				"The outcome variable is the number of migrants. Standard errors in parentheses are clustered at the" ///
				"origin-destination level.  \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") ///
	   mgroups("Top 1 percent removed",  pattern(1 0 0)) alignment(D{.}{.}{-1}) replace 
	   
	   
esttab ppml1a  ///
	   ppml2a  ///
	   ppml3a ///
	   using "$REGOUT\Table_B3.tex", /// 
	   b(3) se(3) nomtitle label star(* 0.10 ** 0.05 *** 0.01) /// 
	   booktabs  order(dum_BLAs_10) /// 
	   keep(dum_BLAs_10) /// 
	   addnotes("The table presents the estimate of $\gamma$ from PPML estimate of equation \eqref{baseline}. It shows the impact of a BLA on migration when top 1\% of corridors (large corridors) are excluded. The outcome variable is the number of migrants. Standard errors in parentheses are clustered at the origin-destination level.  \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") /// 
	   s(N ot dt od year, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.1fc) /// 
	   label("Observations" "Origin country x decade FE" ///
	   "Destination country x decade FE" ///
	   "Origin x destination countries FE"  "Decade FE")) ///
	   title("Migration response to BLAs (Benchmark)") ///
	   mgroups("Top 1 percent removed",  pattern(1 0 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) ///
	   span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) replace 



	   
	   
	   
	   
	   
/* More time needed to properly build the layout of table 3*/	   
*==================================== 
* 			2.2 - IV estimation     	          
*==================================== 

eststo clear    
	eststo fs2MH : reghdfe dum_BLAs_10 ln_leave_in, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
	*HK try this
	*ivreg2 amig (dum_BLAs_10 = ln_leave_in), i.od i.ot i.dt cl($CL)  
	eststo iv2MH : ivreghdfe amig (dum_BLAs_10 = ln_leave_in), abs($FE3) cl($CL) first savefirst savefprefix(st2_dum_BLAs_10) 
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	estadd scalar Fst2_dum_BLAs_10 = `e(widstat)' : fs2MH

	eststo fs2BM : reghdfe dum_BLAs_10 ln_leave_out, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace

	eststo iv2BM : ivreghdfe amig (dum_BLAs_10 = ln_leave_out), abs($FE3) cl($CL) first savefirst savefprefix(st3_dum_BLAs_10) 
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	estadd scalar Fst3_dum_BLAs_10 = `e(widstat)' : fs2BM 
	
	eststo fs2MHb : reghdfe dum_BLAs_10 ln_leave_in if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
	eststo iv2MHb : ivreghdfe amig (dum_BLAs_10 = ln_leave_in) if minmig>9, abs($FE3) cl($CL) first savefirst savefprefix(st2_dum_BLAs_10) 
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	estadd scalar Fst2_dum_BLAs_10b = `e(widstat)' : fs2MHb

	eststo fs2BMb : reghdfe dum_BLAs_10 ln_leave_out if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
		  		  
	eststo iv2BMb : ivreghdfe amig (dum_BLAs_10 = ln_leave_out) if minmig>9, abs($FE3) cl($CL) first savefirst savefprefix(st3_dum_BLAs_10) 
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	estadd scalar Fst3_dum_BLAs_10b = `e(widstat)' : fs2BMb 

	
*HK: with fixed effects, add "keep(dum_BLAs_10)". You already have drop. But the fixed effects are sometimes hard to drop, unless you have a pattern in the names and you can use "*od* or similar. You have to see how the value label appears in the regression output, and then  use those with *, if just using keep does not work. 
	
/* Stack table s*/
** top panel - Full sample 
esttab  fs2MH iv2MH fs2BM iv2BM using "$REGOUT\Table_3.tex", replace f ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	    b(3) se(3) nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(_cons) s(N Fst2_dum_BLAs_10 Fst3_dum_BLAs_10, fmt(%9.0fc %9.2fc  %9.2fc) ///
	   label("Observations" "K. Paap F."  "K. Paap F.")) ///
	    label booktabs nonotes nomtitle  collabels(none) ///
	   mgroups("First stage" "IV" "First stage" "IV", pattern(1 1 1 1) ///	
	   prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) 
	   

	   
** Bottom panel - Regular corridors 
esttab fs2MHb iv2MHb fs2BMb iv2BMb using "$REGOUT\Table_3.tex", append f ///
	   postfoot(\bottomrule \end{tabular}) ///
	   b(3) se(3) r2 star(* 0.10 ** 0.05 *** 0.01) drop(_cons) ///
	   s(N ot dt od Fst2_dum_BLAs_10b Fst3_dum_BLAs_10b, fmt(%9.0fc %9.3fc  %9.2fc  %9.2fc %9.2fc) ///
	   label("Observations" "Origin country x decade FE" "Destination country x decade FE" ///
	   "Origin x destination countries FE" "K. Paap F."  "K. Paap F.")) ///
	   addnotes("Standard errors in parentheses are clustered at the origin-destination level. BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years and zero otherwise. The dependent variable is the inverse hyperbolic sine of the number of dyadic migrations in protocols. Columns (1) and (2) report heterogeneity with respect to whether the country of origin is African or not. Columns (3) and (4) report the heterogeneous response of migration to BLA depending on whether the region of destination is GCC or not. The last two columns examine the heterogeneity with respect to the level of development of the country of origin (low and lower middle income, upper middle income, and high income).  For each of the highlighted categories, we consider two specifications: one that includes origin-destination and origin-time fixed effects, and another that complements this set of fixed effects with destination-time fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") ///
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
