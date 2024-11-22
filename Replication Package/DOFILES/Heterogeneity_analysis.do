
*------------------------------------------------------------------------------*
*					3.0 - Heterogeneity analysis 							   *
*------------------------------------------------------------------------------*

*======================================= 
* 			3.1 - Heterogeneous migration response to BLAs -- Table 4   	          
*======================================= 

eststo clear 
	eststo ols_GCCa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo GCCa_tot : nlcom _b[dum_BLAs_10] + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_GCCb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE4) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo GCCb_tot : nlcom _b[dum_BLAs_10]  + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_AFRa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo AFRa_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post
	
	eststo ols_AFRb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo AFRb_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post	
	
	eststo ols_devcata : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo devcata_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post	
	
	eststo ols_devcatb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace	
	eststo devcatb_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post
*	lab var _nl "BLA + Interaction"
	
esttab ols_AFRa ols_AFRb ///
	   ols_GCCa ols_GCCb /// 
	   ols_devcata ols_devcatb ///
	   GCCa_tot GCCb_tot AFRa_tot ///
	   AFRb_tot devcata_tot devcatb_tot, ///
	   label nomtitles r2 se star(* 0.1 ** 0.05 *** 0.01) ///
	   drop(_cons 0.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 0.GCC_d#c.dum_BLAs_10) ///
	   varlabels(_nl_1  "BLA + Interaction") ///
	   nonotes nomtitles collabels(none) compress sfmt(0) ///
	   s(N r2 ot dt od, fmt(%9.0fc %9.3fc %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   addnotes("Standard errors in parentheses are clustered at the origin-destination level. " ///
				" BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years" ///
				"and zero otherwise. The dependent variable is the number of dyadic migrations in protocols." ///
				"Columns (1) and (2) report heterogeneity with respect to whether the country of origin is" ///
				"African or not. Columns (3) and (4) report the heterogeneous response of migration to BLA " ///
				" depending on whether the region of destination is GCC or not. The last two columns examine" ///
				"the heterogeneity with respect to the level of development of the country of origin " ///
				" (low and lower middle income, upper middle income, and high income).  For each of " ///
				" the highlighted categories, we consider two specifications: one that includes origin-destination" ///
				"and origin-time fixed effects, and another that complements this set of fixed effects with" ///
				"destination-time fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).")
				
				
/* Preparing stack output table for Latex*/
/* Top panel */
esttab  ols_GCCa ols_GCCb ols_AFRa ols_AFRb ols_devcata ols_devcatb using "$REGOUT\Table_4.tex", replace f ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	   b(3) se(3) nomtitle /*r2 label*/ star(* 0.10 ** 0.05 *** 0.01) /// 
	   drop(_cons 0.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 0.GCC_d#c.dum_BLAs_10) ///
	   varlabels(dum_BLAs_10 "Bilateral labor agreement (BLA)" ///
				 1.GCC_d#c.dum_BLAs_10 "BLA X GCC destination" ///
				 1.AFR_o#c.dum_BLAs_10 "BLA X African origin" ///
				 2.devcat#c.dum_BLAs_10 "BLA X UM-HIC") ///
	   label booktabs noobs nonotes nomtitle  collabels(none) ///
	   mgroups("GCC destination" "African origin" "Development group", pattern(1 0 1 0 1 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})
				 
				 
/* Bottom panel (middle-like) */				 
esttab GCCa_tot GCCb_tot AFRa_tot AFRb_tot devcata_tot devcatb_tot using "$REGOUT\Table_4.tex", append f ///
	   b(3) se(3) star(* 0.10 ** 0.05 *** 0.01)  /// 
	   varlabels(_nl_1  "BLA + Interaction", elist(_nl_1 \bottomrule)) ///
	   label  booktabs collabels(none) nomtitle noobs  nolines nonum  sfmt(%6.0fc)


/* Bottom panel (meant to add relevant statistics of interest) */
esttab ols_GCCa ols_GCCb ols_AFRa ols_AFRb ols_devcata ols_devcatb using "$REGOUT\Table_4.tex", append f ///
	   postfoot(\bottomrule \end{tabular}) ///
	   b(3) se(3) r2 star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(_cons 0.AFR_o#c.dum_BLAs_10  1.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 2.devcat#c.dum_BLAs_10 ///
	   0.GCC_d#c.dum_BLAs_10  1.GCC_d#c.dum_BLAs_10 ///
	   dum_BLAs_10 _cons) ///
	   s(N r2 ot dt od, fmt(%9.0fc %9.3fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   addnotes("Standard errors in parentheses are clustered at the origin-destination level. BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years and zero otherwise. The dependent variable is the inverse hyperbolic sine of the number of dyadic migrations in protocols. Columns (1) and (2) report heterogeneity with respect to whether the country of origin is African or not. Columns (3) and (4) report the heterogeneous response of migration to BLA depending on whether the region of destination is GCC or not. The last two columns examine the heterogeneity with respect to the level of development of the country of origin (low and lower middle income, upper middle income, and high income).  For each of the highlighted categories, we consider two specifications: one that includes origin-destination and origin-time fixed effects, and another that complements this set of fixed effects with destination-time fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") ///
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
	  
	
*======================================= 
* 			3.2 - Heterogeneous migration response to BLAs -- (Appendix)   	          
*======================================= 
	
** Heterogeneous migration response to BLAs (Pseudo Poisson Maximum Likelihood) -- Table B.4
eststo clear 
	eststo ppml_GCCa : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo GCCa_tot : nlcom _b[dum_BLAs_10] + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ppml_GCCb : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE4) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo GCCb_tot : nlcom _b[dum_BLAs_10]  + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ppml_AFRa : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo AFRa_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post
	
	eststo ppml_AFRb : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo AFRb_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post	
	
	eststo ppml_devcata : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo devcata_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post	
	
	eststo ppml_devcatb : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace	
	eststo devcatb_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post

	
/* Preparing stack output table for Latex*/
/* Top panel */
esttab  ppml_GCCa ppml_GCCb ppml_AFRa ppml_AFRb ppml_devcata ppml_devcatb using "$REGOUT\Table_B4.tex", replace f ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	   b(3) se(3) nomtitle /*r2 label*/ star(* 0.10 ** 0.05 *** 0.01) /// 
	   drop(_cons 0.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 0.GCC_d#c.dum_BLAs_10) ///
	   varlabels(dum_BLAs_10 "Bilateral labor agreement (BLA)" ///
				 1.GCC_d#c.dum_BLAs_10 "BLA X GCC destination" ///
				 1.AFR_o#c.dum_BLAs_10 "BLA X African origin" ///
				 2.devcat#c.dum_BLAs_10 "BLA X UM-HIC") ///
	   label booktabs noobs nonotes nomtitle  collabels(none) ///
	   mgroups("GCC destination" "African origin" "Development group", pattern(1 0 1 0 1 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})
				 
				 
/* Bottom panel (middle-like) */				 
esttab GCCa_tot GCCb_tot AFRa_tot AFRb_tot devcata_tot devcatb_tot using "$REGOUT\Table_B4.tex", append f ///
	   b(3) se(3) star(* 0.10 ** 0.05 *** 0.01)  /// 
	   varlabels(_nl_1  "BLA + Interaction", elist(_nl_1 \bottomrule)) ///
	   label  booktabs collabels(none) noobs  nomtitle nolines nonum  sfmt(%6.0fc)


/* Bottom panel (meant to add relevant statistics of interest) */
esttab ppml_GCCa ppml_GCCb ppml_AFRa ppml_AFRb ppml_devcata ppml_devcatb using "$REGOUT\Table_B4.tex", append f ///
	   postfoot(\bottomrule \end{tabular}) ///
	   b(3) se(3) r2 star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(_cons 0.AFR_o#c.dum_BLAs_10  1.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 2.devcat#c.dum_BLAs_10 ///
	   0.GCC_d#c.dum_BLAs_10  1.GCC_d#c.dum_BLAs_10 ///
	   dum_BLAs_10 _cons) ///
	   s(N r2 ot dt od, fmt(%9.0fc %9.3fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   addnotes("Standard errors in parentheses are clustered at the origin-destination level. BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years and zero otherwise. The dependent variable is the number of dyadic migrations in protocols. Columns (1) and (2) report heterogeneity with respect to whether the country of origin is African or not. Columns (3) and (4) report the heterogeneous response of migration to BLA depending on whether the region of destination is GCC or not. The last two columns examine the heterogeneity with respect to the level of development of the country of origin (low and lower middle income, upper middle income, and high income).  For each of the highlighted categories, we consider two specifications: one that includes origin-destination and origin-time fixed effects, and another that complements this set of fixed effects with destination-time fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") ///
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
	  
	
	
** Heterogenous migration response to BLAs along the economic momentum and the timing of the BLA -- Table B.4
eststo clear // economic momentum OLS 
	eststo ols_moma :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.momentum, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace

	eststo olsmoma_tot : nlcom _b[dum_BLAs_10] + _b[2.momentum#c.dum_BLAs_10] + _b[3.momentum#c.dum_BLAs_10], post
	eststo ols_momb :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.momentum, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo olsmomb_tot : nlcom _b[dum_BLAs_10] + _b[2.momentum#c.dum_BLAs_10] + _b[3.momentum#c.dum_BLAs_10], post	
	
	eststo ols_dum5a :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.dum_5, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo ols_dum5a_tot : nlcom _b[dum_BLAs_10] + _b[1.dum_5#c.dum_BLAs_10], post
	
	eststo ols_dum5b :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.dum_5, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace	 
	eststo ols_dum5b_tot : nlcom _b[dum_BLAs_10] + _b[1.dum_5#c.dum_BLAs_10], post

	esttab ols_moma ols_momb ols_dum5a ols_dum5b, label nomtitles r2 se star(* 0.1 ** 0.05 *** 0.01)

	
/* Preparing stack output table for Latex*/
/* Top panel */
esttab  ols_moma ols_momb ols_dum5a ols_dum5b using "$REGOUT\Table_B5.tex", replace f ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	   b(3) se(3) nomtitle star(* 0.10 ** 0.05 *** 0.01) /// 
	   drop(_cons 1.momentum#c.dum_BLAs_10 ///
	   0.dum_5#c.dum_BLAs_10) ///
	   varlabels(dum_BLAs_10 "Bilateral labor agreement (BLA)" ///
				 2.momentum#c.dum_BLAs_10 "BLA X Eco. stagnation" ///
				 3.momentum#c.dum_BLAs_10 "BLA X Post Cold War (>1990)" ///
				 1.dum_5#c.dum_BLAs_10 "BLA X Signed in the last 5 years") ///
	   label booktabs noobs nonotes nomtitle  collabels(none) ///
	   mgroups("Long run economic momentum" "Last 5 years", pattern(1 0 1 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})
				 				 
/* Bottom panel (middle-like) */				 
esttab olsmoma_tot olsmomb_tot ols_dum5a_tot ols_dum5b_tot using "$REGOUT\Table_B5.tex", append f ///
	   b(3) se(3) star(* 0.10 ** 0.05 *** 0.01)  /// 
	   varlabels(_nl_1  "BLA + Interaction", elist(_nl_1 \bottomrule)) ///
	   label  booktabs collabels(none) noobs  nomtitle nolines nonum  sfmt(%6.0fc)

/* Bottom panel (meant to add relevant statistics of interest) */
esttab ols_moma ols_momb ols_dum5a ols_dum5b using "$REGOUT\Table_B5.tex", append f ///
	   postfoot(\bottomrule \end{tabular}) ///
	   b(3) se(3) r2 star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(dum_BLAs_10 _cons 1.momentum#c.dum_BLAs_10 2.momentum#c.dum_BLAs_10 ///
	   3.momentum#c.dum_BLAs_10 0.dum_5#c.dum_BLAs_10 1.dum_5#c.dum_BLAs_10)  ///
	   s(N r2 ot dt od, fmt(%9.0fc %9.3fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   addnotes("Standard errors in parentheses are clustered at the origin-destination level. BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years and zero otherwise. The dependent variable is the inverse hyperbolic sine of the number of dyadic migrations in protocols. Columns (1) and (2) report heterogeneity with respect to economic momentum that have over time. Columns (3) and (4) report the heterogeneous response of migration to BLA with respect to the timing of the BLA (whether they were signed during the last five years or not). For each of the highlighted categories, we consider two specifications: one that includes origin-destination and origin-time fixed effects, and another that complements this set of fixed effects with destination-time fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)") ///
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
	
	
	
	
** Heterogeneous migration response to BLAs (regular corridors only) -- Table B.6	
eststo clear 
	eststo ols_GCCa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo GCCa_tot : nlcom _b[dum_BLAs_10] + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_GCCb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d if minmig>9, abs($FE4) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo GCCb_tot : nlcom _b[dum_BLAs_10]  + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_AFRa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo AFRa_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post
	
	eststo ols_AFRb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo AFRb_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post	
	
	eststo ols_devcata : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "No", replace
	estadd local od "Yes", replace
	eststo devcata_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post	
	
	eststo ols_devcatb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace	
	eststo devcatb_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post
	
/* Preparing stack output table for Latex*/
/* Top panel */
esttab  ols_GCCa ols_GCCb ols_AFRa ols_AFRb ols_devcata ols_devcatb using "$REGOUT\Table_B6.tex", replace f ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	   b(3) se(3) nomtitle /*r2 label*/ star(* 0.10 ** 0.05 *** 0.01) /// 
	   drop(_cons 0.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 0.GCC_d#c.dum_BLAs_10) ///
	   varlabels(dum_BLAs_10 "Bilateral labor agreement (BLA)" ///
				 1.GCC_d#c.dum_BLAs_10 "BLA X GCC destination" ///
				 1.AFR_o#c.dum_BLAs_10 "BLA X African origin" ///
				 2.devcat#c.dum_BLAs_10 "BLA X UM-HIC") ///
	   label booktabs noobs nonotes nomtitle  collabels(none) ///
	   mgroups("GCC destination" "African origin" "Development group", pattern(1 0 1 0 1 0) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})
				 				 
/* Bottom panel (middle-like) */				 
esttab GCCa_tot GCCb_tot AFRa_tot AFRb_tot devcata_tot devcatb_tot using "$REGOUT\Table_B6.tex", append f ///
	   b(3) se(3) star(* 0.10 ** 0.05 *** 0.01)  /// 
	   varlabels(_nl_1  "BLA + Interaction", elist(_nl_1 \bottomrule)) ///
	   label  booktabs collabels(none) nomtitle noobs  nolines nonum  sfmt(%6.0fc)


/* Bottom panel (meant to add relevant statistics of interest) */
esttab ols_GCCa ols_GCCb ols_AFRa ols_AFRb ols_devcata ols_devcatb using "$REGOUT\Table_B6.tex", append f ///
	   postfoot(\bottomrule \end{tabular}) ///
	   b(3) se(3) r2 star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(_cons 0.AFR_o#c.dum_BLAs_10  1.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 2.devcat#c.dum_BLAs_10 ///
	   0.GCC_d#c.dum_BLAs_10  1.GCC_d#c.dum_BLAs_10 ///
	   dum_BLAs_10 _cons) ///
	   s(N r2 ot dt od, fmt(%9.0fc %9.3fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   addnotes("Standard errors in parentheses are clustered at the origin-destination level. BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years and zero otherwise. The dependent variable is the inverse hyperbolic sine of the number of dyadic migrations in protocols. Columns (1) and (2) report heterogeneity with respect to economic momentum that have over time. Columns (3) and (4) report the heterogeneous response of migration to BLA with respect to the timing of the BLA. For each of the highlighted categories, we consider two specifications: one that includes origin-destination and origin-time fixed effects, and another that complements this set of fixed effects with destination-time fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)") ///
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 


	   * Resume from here after lunch 
	
*======================================= 
* 			3.2 - Heterogeneous migration response to BLAs by governance -- Table 5  	          
*=======================================  
**  On the mechanics of the african puzzle : does governance plays a role?  (Governance effectiveness) 	          
   
eststo clear 
	eststo olsc :  reghdfe amig dum_BLAs_10  c.dum_BLAs_10#AFR_o c.dum_BLAs_10#gee_2 c.dum_BLAs_10#AFR_o#gee_2, abs($FE3) cl($CL) // bottom third
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo olsd :  reghdfe amig dum_BLAs_10  c.dum_BLAs_10#AFR_o c.dum_BLAs_10#gee_3 c.dum_BLAs_10#AFR_o#gee_3, abs($FE3) cl($CL) // bottom third
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace
	eststo olse :  reghdfe amig dum_BLAs_10  c.dum_BLAs_10#AFR_o c.dum_BLAs_10#gee_4 c.dum_BLAs_10#AFR_o#gee_4, abs($FE3) cl($CL) // bottom quater 
	estadd local ot "Yes", replace
	estadd local dt "Yes", replace
	estadd local od "Yes", replace

	/* Resume here once at home*/
esttab olsc olsd olse, ///
	   label nomtitles r2 se star(* 0.1 ** 0.05 *** 0.01) nolabel varwidth(35) ///
	   drop(_cons 1.gee_2#c.dum_BLAs_10 ///
				  0.AFR_o#c.dum_BLAs_10  ///
				  0.AFR_o#1.gee_2#c.dum_BLAs_10  0.AFR_o#2.gee_2#c.dum_BLAs_10 ///
				  1.gee_3#c.dum_BLAs_10  0.AFR_o#c.dum_BLAs_10  0.AFR_o#1.gee_3#c.dum_BLAs_10 ///
				  0.AFR_o#2.gee_3#c.dum_BLAs_10 0.AFR_o#3.gee_3#c.dum_BLAs_10 ///
				  1.AFR_o#1.gee_2#c.dum_BLAs_10 1.AFR_o#1.gee_3#c.dum_BLAs_10 ///
				  1.AFR_o#1.gee_4#c.dum_BLAs_10 ///
				  1.gee_4#c.dum_BLAs_10  0.AFR_o#c.dum_BLAs_10  ///
				  0.AFR_o#1.gee_4#c.dum_BLAs_10  0.AFR_o#2.gee_4#c.dum_BLAs_10 ///
				  0.AFR_o#3.gee_4#c.dum_BLAs_10  0.AFR_o#4.gee_4#c.dum_BLAs_10) ///
				  order(dum_BLAs_10 1.AFR_o#c.dum_BLAs_10 2.gee_2#c.dum_BLAs_10 ///
						2.gee_3#c.dum_BLAs_10 3.gee_3#c.dum_BLAs_10 2.gee_4#c.dum_BLAs_10 ///
						3.gee_4#c.dum_BLAs_10 4.gee_4#c.dum_BLAs_10 ///
						1.AFR_o#2.gee_2#c.dum_BLAs_10) ///
				  varlabels(dum_BLAs_10 "Bilateral labor agreement (BLA)" ///
				  1.AFR_o#c.dum_BLAs_10 "BLA x Africa" ///
				  2.gee_2#c.dum_BLAs_10 "BLA x Top half" ///
				  2.gee_3#c.dum_BLAs_10 "BLA x Middle tercile" ///
				  3.gee_3#c.dum_BLAs_10 "BLA x Top tercile" ///
				  2.gee_4#c.dum_BLAs_10 "BLA x Third quartile" ///
				  3.gee_4#c.dum_BLAs_10 "BLA x Second quartile" ///
				  4.gee_4#c.dum_BLAs_10 "BLA x Fiurth quartile" ///
				  1.AFR_o#2.gee_2#c.dum_BLAs_10 "BLA x Africa x Top half" ///
				  1.AFR_o#2.gee_3#c.dum_BLAs_10 "BLA x Africa x Middle tercile" ///
				  1.AFR_o#3.gee_3#c.dum_BLAs_10 "BLA x Africa x Top tercile" ///
				  1.AFR_o#2.gee_4#c.dum_BLAs_10 "BLA x Africa x Third quartile" ///
				  1.AFR_o#3.gee_4#c.dum_BLAs_10 "BLA x Africa x Second quartile" ///
				  1.AFR_o#4.gee_4#c.dum_BLAs_10 "BLA x Africa x First quartile") ///
				  addnotes("Standard errors in parentheses are clustered at the origin-destination level. BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years and zero otherwise. The dependent variable is the inverse hyperbolic ssine of the number of dyadic migrations in protocols.   For each of the highlighted categories, we consider consider the specification with the most stringent set of fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)") ///
	   nonotes nomtitles collabels(none) compress sfmt(0) ///
	   s(N r2 ot dt od, fmt(%9.0fc %9.3fc %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) 	
	

	
esttab olsc olsd olse  using "$REGOUT\Table_5.tex", ///
	   label nomtitles r2 se star(* 0.1 ** 0.05 *** 0.01) nolabel varwidth(35) ///
	   drop(_cons 1.gee_2#c.dum_BLAs_10 ///
				  0.AFR_o#c.dum_BLAs_10  ///
				  0.AFR_o#1.gee_2#c.dum_BLAs_10  0.AFR_o#2.gee_2#c.dum_BLAs_10 ///
				  1.gee_3#c.dum_BLAs_10  0.AFR_o#c.dum_BLAs_10  0.AFR_o#1.gee_3#c.dum_BLAs_10 ///
				  0.AFR_o#2.gee_3#c.dum_BLAs_10 0.AFR_o#3.gee_3#c.dum_BLAs_10 ///
				  1.AFR_o#1.gee_2#c.dum_BLAs_10 1.AFR_o#1.gee_3#c.dum_BLAs_10 ///
				  1.AFR_o#1.gee_4#c.dum_BLAs_10 ///
				  1.gee_4#c.dum_BLAs_10  0.AFR_o#c.dum_BLAs_10  ///
				  0.AFR_o#1.gee_4#c.dum_BLAs_10  0.AFR_o#2.gee_4#c.dum_BLAs_10 ///
				  0.AFR_o#3.gee_4#c.dum_BLAs_10  0.AFR_o#4.gee_4#c.dum_BLAs_10) ///
				  order(dum_BLAs_10 1.AFR_o#c.dum_BLAs_10 2.gee_2#c.dum_BLAs_10 ///
						2.gee_3#c.dum_BLAs_10 3.gee_3#c.dum_BLAs_10 2.gee_4#c.dum_BLAs_10 ///
						3.gee_4#c.dum_BLAs_10 4.gee_4#c.dum_BLAs_10 ///
						1.AFR_o#2.gee_2#c.dum_BLAs_10) ///
				  varlabels(dum_BLAs_10 "Bilateral labor agreement (BLA)" ///
				  1.AFR_o#c.dum_BLAs_10 "BLA x Africa" ///
				  2.gee_2#c.dum_BLAs_10 "BLA x Top half" ///
				  2.gee_3#c.dum_BLAs_10 "BLA x Middle tercile" ///
				  3.gee_3#c.dum_BLAs_10 "BLA x Top tercile" ///
				  2.gee_4#c.dum_BLAs_10 "BLA x Third quartile" ///
				  3.gee_4#c.dum_BLAs_10 "BLA x Second quartile" ///
				  4.gee_4#c.dum_BLAs_10 "BLA x Fiurth quartile" ///
				  1.AFR_o#2.gee_2#c.dum_BLAs_10 "BLA x Africa x Top half" ///
				  1.AFR_o#2.gee_3#c.dum_BLAs_10 "BLA x Africa x Middle tercile" ///
				  1.AFR_o#3.gee_3#c.dum_BLAs_10 "BLA x Africa x Top tercile" ///
				  1.AFR_o#2.gee_4#c.dum_BLAs_10 "BLA x Africa x Third quartile" ///
				  1.AFR_o#3.gee_4#c.dum_BLAs_10 "BLA x Africa x Second quartile" ///
				  1.AFR_o#4.gee_4#c.dum_BLAs_10 "BLA x Africa x First quartile") ///
				  addnotes("Standard errors in parentheses are clustered at the origin-destination level. BLA (dummy) in decade N takes the value 1 if a BLA was signed in the last 10 years and zero otherwise. The dependent variable is the inverse hyperbolic ssine of the number of dyadic migrations in protocols.   For each of the highlighted categories, we consider consider the specification with the most stringent set of fixed effects. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)") ///
	   nonotes nomtitles collabels(none) compress sfmt(0) s(N r2 ot dt od, fmt(%9.0fc %9.3fc %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   title("Heterogenous migration response to BLAs by governance category") ///
	   mgroups("Top half" "Top two terciles" "Top three quartiles", ///
	   pattern(1 1 1) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) ///
	   span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) replace 
	   
	