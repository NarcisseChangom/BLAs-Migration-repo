

*-------------------------------------------------------------------------------
/* Extended TWFE estimands applied to gravity setting */

preserve 
*------------------------------------------------------------------------------*
*						 Define the first treatment period 					   *
*------------------------------------------------------------------------------*
g treat = dum_BLAs_10*year  
replace treat = . if dum_BLAs_10==0
egen firstBLA = min(treat), by(o_iso3 d_iso3) /* The issue here is that there are corridors treated more than once. To get everything right, let me drop those */
replace firstBLA=0 if firstBLA==.
eststo clear
eststo eq1twfeolsF : quiet reghdfe amig dum_BLAs_10, abs(ot od dt) cl(od)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace

eststo eq1twfeppmlF : quiet ppmlhdfe mig dum_BLAs_10, abs(ot od dt) cl(od)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
quiet jwdid amig, ivar(od) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot od dt) cluster(od) never hettype(cohort)
eststo : estat simple, predict(xb) post // ATT ETWFE
eststo eq1etwfeolsF  
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
quiet jwdid mig, ivar(od) tvar(year) gvar(firstBLA) method(ppmlhdfe) fevar(ot od dt) cluster(od) never hettype(cohort)
eststo : estat simple, predict(xb) post // ATT ETWFE
eststo eq1etwfeppmlF 
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace	

keep if minmig>9
*eststo clear
eststo eq1twfeols : quiet reghdfe amig dum_BLAs_10, abs(ot od dt) cl(od)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace

eststo eq1twfeppml : quiet ppmlhdfe mig dum_BLAs_10, abs(ot od dt) cl(od)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
quiet jwdid amig, ivar(od) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot od dt) cluster(od) never hettype(cohort)
eststo : estat simple, predict(xb) post // ATT ETWFE
eststo eq1etwfeols  
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	
quiet jwdid mig, ivar(od) tvar(year) gvar(firstBLA) method(ppmlhdfe) fevar(ot od dt) cluster(od) never  hettype(cohort)
eststo : estat simple, predict(xb) post // ATT ETWFE
eststo eq1etwfeppml 
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
			
	
esttab eq1twfeolsF ///
	   eq1twfeppmlF ///
	   eq1etwfeolsF ///
	   eq1etwfeppmlF ///
	   eq1twfeols ///
	   eq1twfeppml ///
	   eq1etwfeols ///
	   eq1etwfeppml, ///
	   label nomtitles se star(* 0.1 ** 0.05 *** 0.01) ///
	   nonotes nomtitles collabels(none) compress sfmt(0) drop(_cons) ///
	   varlabels(dum_BLAs_10 "BLA_{ijt} (TWFE)" simple  "BLA_{ijt} (ETWFE)") ///
	   s(N ot dt od year, fmt(%9.0fc %9.0fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "Origin country x decade FE" "Destination country x decade FE" ///
	   "Origin x destination countries FE" "Decade FE")) ///
	   title("Comparison of TWFE and ETWFE estimators for different samples") ///
	   mgroups("Full sample" "Regular corridors only (M_ij>=10)", ///
	   pattern(1 0 0 0 1 0 0 0)) ///
	   addnotes("The table presents OLS and PPML estimations using three-ways fixed effects (TWFE) and extended three-ways fixed effects (ETWFE) estimators. ETWFE estimator is obtained by aggregating the cohort-time specific treatment effects across cohort to obtain and aggregate treatment effect estimate. The dependent variable is bilateral migration flows, which varies across origin-destination-decade dimension. The full sample contains all the corridors irrespective of whether those are used (presence of migrants) or not. The regular corridors restricts the analysis to corridors with at least 10 migrants. Standards errors in parenthesis are clustered at origin-decade level. \sym{***}, \sym{**}, and \sym{*} indicate the significance at the 1\%, 5\% and 10\% level, respectively. Extended three-ways fixed effects (ETWFE) estimates are obtained using the \emph{STATA} {\fontfamily{qcr}\selectfont jwdid} command built by \cite{stata_jwdid} from \cite{wooldridge2023simple} and extended to gravity setting by \cite{nagengast2023staggered}.")
	   
	   
esttab eq1twfeolsF ///
	   eq1twfeppmlF ///
	   eq1etwfeolsF ///
	   eq1etwfeppmlF ///
	   eq1twfeols ///
	   eq1twfeppml ///
	   eq1etwfeols ///
	   eq1etwfeppml using "$REGOUT\Table_C1.tex", /// 
	   b(3) se(3) nomtitle label star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(_cons) varlabels(dum_BLAs_10 "BLA_{ijt} (TWFE)" simple  "BLA_{ijt} (ETWFE)") ///
	   booktabs addnotes("The table presents OLS and PPML estimations using three-ways fixed effects (TWFE) and extended three-ways fixed effects (ETWFE) estimators. ETWFE estimator is obtained by aggregating the cohort-time specific treatment effects across cohort to obtain and aggregate treatment effect estimate. The dependent variable is bilateral migration flows, which varies across origin-destination-decade dimension. The full sample contains all the corridors irrespective of whether those are used (presence of migrants) or not. The regular corridors restricts the analysis to corridors with at least 10 migrants. Standards errors in parenthesis are clustered at origin-decade level. \sym{***}, \sym{**}, and \sym{*} indicate the significance at the 1\%, 5\% and 10\% level, respectively. Extended three-ways fixed effects (ETWFE) estimates are obtained using the \emph{STATA} {\fontfamily{qcr}\selectfont jwdid} command built by \cite{stata_jwdid} from \cite{wooldridge2023simple} and extended to gravity setting by \cite{nagengast2023staggered}.") /// 
	   s(N ot dt od, fmt(%9.0fc %9.0fc  %9.0fc) /// 
	   label("Observations" "Origin country x decade FE" ///
	   "Destination country x decade FE" ///
	   "Origin x destination countries FE"  "Decade FE")) ///
	   title("Migration response to BLAs (Benchmark)") ///
	   mgroups("Full sample" "Regular corridors only (M_ij>=10)", ///
	   pattern(1 0 0 0 1 0 0 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) ///
	   span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) replace	  	
	   
restore 


*======================================= 
* 			3.1 - Dis-aggregated effects of BLAs on migration  (Event study design)  	          
*======================================= 

*==================== 
* 			Data formatting   	          
*==================== 

keep o_iso3 d_iso3 devcat devcatd AFR_o AFR_d od ot dt mig dum_BLAs_10 year devcat_o devcat_d d_region 
egen count = sum(dum_BLAs_10), by(od)
egen blarank = rank(year) if dum_BLAs_10==1, by(od)

tab count
expand count
bys od year: gen repcount = _n 
g refyear = blarank==repcount

sort od repcount year

g odrep = od*100 + repcount
tsset odrep year, delta(10)

g event = 0 if refyear ==1 
forval i = 1/7{
	replace event = -`i' if F`i'.refyear==1
	replace event = `i' if L`i'.refyear==1
}

g wt = 1/repcount
g amig = asinh(mig)
g lmig = log(1+mig)

g event2 = event+7 
lab define event2 1 "-6" 2 "-5" 3 "-4" 4 "-3" 5 "-2" 6 "-1" 7 "0" 8 "1" 9 "2" 10 "3" 11 "4" 12 "5" 13 "6"
lab values event2 event2 
recode event2 (1=2) (13=12)

gen GCC_d = 1 if inlist(d_iso3,"BHR","KWT","OMN","QAT","SAU","ARE")
replace GCC_d = 0 if GCC_d==. 

gen post= event>=0 
gen BLA = event==0 

gen __firstBLA = year if BLA==1 
egen firstBLA = max(__firstBLA), by(odrep)

egen minmig = min(mig), by(odrep)
gen regular = minmig>9


*==================== 
* 			Pre-trend test   (Figure C.1)	          
*==================== 
 
quiet jwdid amig, ivar(odrep) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot od dt) never cluster(od) 
estat event, predict(xb) pretrend window(-40 -10)
estat plot, yti("Impact of BLAs on migration stock, in log points") xti("Decades relative to signing") pstyle1(p2) ///
 xla(-40(10)-10 -40 "-4" -30 "-3" -20 "-2" -10 "-1") ///
 legend(off) yla(-.8(.2).4)
graph export "$FIG/Figure_C1.png ", replace
/* Joint test for the significance of the pre-trend: prob = 0.6615 */
 


*==================== 
* 			Event-decade specific effects of signing a BLA   (Figure C.2)	          
*==================== 

qui jwdid amig, ivar(odrep) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot dt od) cluster(od) never
estat event, predict(xb) cwindow(-40 30) 
estat plot,xla(-40(10)30 -40 "-4" -30 "-3" -20 "-2" -10 "-1" 0 "0" 10 "1" 20 "2" 30 "3") ///
 xti("Decades relative to signing") yti("Impact of BLAs on migration stock, in log points")
graph export "$FIG/Figure_C2.png ", replace



*==================== 
* 			Regional variations in migration response to BLAs   (Figure C.3)	          
*==================== 

qui jwdid amig if AFR_o==1, ivar(odrep) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot dt od)  cluster(od) never
estat event, predict(xb) pretrend cwindow(-40 30) 
estat plot, xla(-40(10)30 -40 "-4" -30 "-3" -20 "-2" -10 "-1" 0 "0" 10 "1" 20 "2" 30 "3") ///
			xti("Decades relative to signing") ///
			yti("Impact of BLAs on migration stock, in log points") ///
			leg(off) 
graph export "$FIG/Figure_C3A.png ", replace

qui jwdid amig if AFR_o==0, ivar(odrep) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot dt od)  cluster(od) never
estat event, predict(xb) pretrend cwindow(-40 30) 
estat plot, xla(-40(10)30  -40 "-4" -30 "-3" -20 "-2" -10 "-1" 0 "0" 10 "1" 20 "2" 30 "3") ///
			xti("Decades relative to signing") ///
			yti("Impact of BLAs on migration stock, in log points") ///
			leg(off) 
graph export "$FIG/Figure_C3B.png ", replace

egen rt = group(d_region year)
qui jwdid amig if GCC_d==0, ivar(odrep) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot od rt)  cluster(od) never
estat event, pretrend cwindow(-40 30)
estat plot, xla(-40(10)30  -40 "-4" -30 "-3" -20 "-2" -10 "-1" 0 "0" 10 "1" 20 "2" 30 "3") ///
			xti("Decades relative to signing") ///
			yti("Impact of BLAs on migration stock, in log points") ///
			leg(off) 
graph export "$FIG/Figure_C3C.png ", replace

qui jwdid amig if GCC_d==1, ivar(odrep) tvar(year) gvar(firstBLA) method(reghdfe) fevar(ot od rt)  cluster(od) never
estat event, pretrend cwindow(-20 20)
estat plot, xla(0(10)20  -20 "-2" -10 "-1" 0 "0" 10 "1" 20 "2" ) ///
			xti("Decades relative to signing") ///
			yti("Impact of BLAs on migration stock, in log points") ///
			leg(off)  
graph export "$FIG/Figure_C3D.png ", replace
