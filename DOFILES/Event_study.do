

*==============================================================================*
* 			BLAs and Migration: Does signing a BLA affect migration?           *
*==============================================================================*


use "$DATA\BLA_Migration_data", clear 
lab var dum_BLAs_10 "Bilateral labor agreement (BLA)"

egen minmig = min(mig), by(o_iso3 d_iso3) // Regular corridors
g mzero = (mig>0) // Regular corridors 
g amig = asinh(mig) // log migration (arcsinc transformation because of the large proportion of zeros)


** Fixed effects 
egen od  = group(o_iso3 d_iso3)  // Origin-Destination Fixed Effects 
egen ot  = group(o_iso3 year)    // Origin-Decade Fixed Effects 
egen dt  = group(d_iso3 year)    // Destination -Decade Fixed Effects 
egen rdt = group(d_region year)  // Destination region - Decade Fixed Effects 



** Macros (fixed effects)
gl FE1 od year // origin-destination pair and decade 
gl FE2 od ot // origin destination pair and origin-decade 
gl FE3 od ot dt // origin destination pair, origin-decade and destination-decade 
gl FE4 od ot rdt // origin-destination pair, origin-decade and destination region decade fixed effects 
gl CL od // corridor level cluster 

*==================================== 
* 			1.0 - Data formatting        	          
*====================================
*drop if dum_BLAs_10==.
replace dum_BLAs_10 = 0 if dum_BLAs_10==.	// already prompted during the data preparation stage 

bys o_iso3 (d_iso3 year): gen __x = _n
xtile __gee_3 = gee if __x ==1, nq(3)
egen gee_3 = max(__gee_3), by(o_iso3)
gen notB3 = inlist(gee_3, 2, 3)

tsset od year, delta(10)
egen wanted = max(dum_BLAs_10 == 1), by(od) // flag corridors with BLAs 
keep if wanted ==1 // keep only corridors with BLAs 

keep o_iso3 d_iso3 devcat devcatd AFR_o AFR_d od ot dt mig dum_BLAs_10 year d_region gee* notB3
 
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
*lab define event2 1 "t-6" 2 "t-5" 3 "t-4" 4 "t-3" 5 "t-2" 6 "t-1" 7 "t0" 8 "t+1" 9 "t+2" 10 "t+3" 11 "t+4" 12 "t+5" 13 "t+6"
lab define event2 1 "-6" 2 "-5" 3 "-4" 4 "-3" 5 "-2" 6 "-1" 7 "0" 8 "1" 9 "2" 10 "3" 11 "4" 12 "5" 13 "6"
lab values event2 event2 
recode event2 (1=2) (13=12)

gen GCC_d = 1 if inlist(d_iso3,"BHR","KWT","OMN","QAT","SAU","ARE")
replace GCC_d = 0 if GCC_d==. 

egen rt = group(d_region year)
gl xvars dum_BLAs_10 logBLAs
gl xvar  dum_BLAs_10
gl HETER dum_5 dum90 AFR_o devcat
gl FE od ot rt  
gl CL od 

*==================================== 
* 			2.0 - Benchmark analysis - Figure 1   	          
*====================================

reghdfe amig ib6.event2 [pw=wt], a(od ot dt) cl($CL)
coefplot, drop(_cons) level(95) vertical base ciopts(recast(rcap) ) yline(0, lcolor(gray)  lpattern(solid)) xline(5, lcolor(gray) lp(solid)) xlabel(, noticks) ylabel(-.2(.1).7, noticks ) yti("Impact of BLAs on migration stock, in log points") xti("Decades relative to signing (signing decade = 0)") name(baseline, replace)
graph export "$FIG/Figure_1.png", replace		

 
*==================================== 
* 			3.0 - Heterogeneity        	          
*====================================

*================  
* 			3.1 - Africa vs. non Africa origin         	          
*================ 

eststo clear 
eststo afr : reghdfe amig ib6.event2 if AFR_o ==1  [pw=wt], a(od ot dt) cl($CL) coeflegend
eststo oth : reghdfe amig ib6.event2 if AFR_o ==0  [pw=wt], a(od ot dt) cl($CL) coeflegend
coefplot afr oth , drop( _cons) vertical base ciopts(recast(rcap rcap)) xline(5, lcolor(gray) lp(solid)) yline(0, lcolor(gray) lp(solid)) xlabel(, noticks) ylabel(-.4(.2)1, noticks) yti("Impact of BLAs on migration stock, in log points") xti("Decades relative to signing (signing decade = 0)")  legend(order(2 "Africa" 1 "95% CI" 4 "Non-Africa" 3 "95% CI") col(2) ring(0) pos(11)) p1(pstyle(p2)) p2(pstyle(p1))
graph export "$FIG/Figure_2A.png", replace		

				  
				  
*================  
* 			3.2 - GCC vs. non-GCC destinations          	          
*================ 

eststo clear 
eststo gcc : reghdfe amig ib6.event2 if GCC_d ==1  [pw=wt], a(od ot rt) cl(od) coeflegend   
eststo oth : reghdfe amig ib6.event2 if GCC_d ==0  [pw=wt], a(od ot rt) cl(od) coeflegend

coefplot gcc oth , drop( _cons) vertical base ciopts(recast(rcap rcap)) xline(5, lcolor(gray) lp(solid)) yline(0, lcolor(gray) lp(solid)) xlabel(, noticks) ylabel(-.5(.5)2.5, noticks) yti("Impact of BLAs on migration stock, in log points") xti("Decades relative to signing (signing decade = 0)")  legend(order(2 "GCC destinations" 1 "95% CI" 4 "Other destinations" 3 "95% CI") col(2) ring(0) pos(11) size(small))
graph export "$FIG/Figure_2B.png", replace	

				  
