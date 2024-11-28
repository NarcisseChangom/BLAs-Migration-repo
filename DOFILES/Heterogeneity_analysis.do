
*------------------------------------------------------------------------------*
*					3.0 - Heterogeneity analysis 							   *
*------------------------------------------------------------------------------*

*======================================= 
* 			3.1 - Heterogeneous migration response to BLAs -- Table 4   	          
*======================================= 

eststo clear 
	eststo ols_GCCa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE2) cl($CL)
	estadd local ot "Y": ols_GCCa
	estadd local od "Y": ols_GCCa
	eststo GCCa_tot : nlcom _b[dum_BLAs_10] + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_GCCb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE4) cl($CL)
	estadd local ot "Y": ols_GCCb
	estadd local dt "Y": ols_GCCb
	estadd local od "Y": ols_GCCb
	eststo GCCb_tot : nlcom _b[dum_BLAs_10]  + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_AFRa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE2) cl($CL)
	estadd local ot "Y": ols_AFRa
	estadd local od "Y": ols_AFRa
	eststo AFRa_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post
	
	eststo ols_AFRb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE3) cl($CL)
	estadd local ot "Y": ols_AFRb
	estadd local dt "Y": ols_AFRb
	estadd local od "Y": ols_AFRb
	eststo AFRb_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post	
	
	eststo ols_devcata : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE2) cl($CL)
	estadd local ot "Y": ols_devcata
	estadd local od "Y": ols_devcata
	eststo devcata_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post	
	
	eststo ols_devcatb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE3) cl($CL)
	estadd local ot "Y": ols_devcatb
	estadd local dt "Y": ols_devcatb
	estadd local od "Y": ols_devcatb
	eststo devcatb_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post
*	lab var _nl "BLA + Interaction"
					
				
/* Preparing stack output table for Latex*/
/* Top panel */
esttab  ols_GCCa ols_GCCb ols_AFRa ols_AFRb ols_devcata ols_devcatb using "$REGOUT\Table_4.tex", replace f ///
	   prehead(\resizebox{\textwidth}{!}{ \begin{tabular}{l*{@M}{r}} \toprule) ///
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
	   postfoot(\bottomrule \end{tabular}}) ///
	   b(3) se(3) r2 star(* 0.10 ** 0.05 *** 0.01) ///
	   drop(_cons 0.AFR_o#c.dum_BLAs_10  1.AFR_o#c.dum_BLAs_10 ///
	   1.devcat#c.dum_BLAs_10 2.devcat#c.dum_BLAs_10 ///
	   0.GCC_d#c.dum_BLAs_10  1.GCC_d#c.dum_BLAs_10 ///
	   dum_BLAs_10 _cons) ///
	   s(N r2 ot dt od, fmt(%9.0fc %9.3fc  %9.0fc  %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
	  

*======================================= 
* 			3.2 - Heterogeneous migration response to BLAs -- (Appendix)   	          
*======================================= 
qui{	
** Heterogeneous migration response to BLAs (Pseudo Poisson Maximum Likelihood) -- Table B.4
eststo clear 


	eststo ppml_GCCa : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE2) cl($CL)
	estadd local ot "Y": ppml_GCCa
	estadd local od "Y": ppml_GCCa
	eststo GCCa_tot : nlcom _b[dum_BLAs_10] + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ppml_GCCb : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d, abs($FE4) cl($CL)
	estadd local ot "Y": ppml_GCCb
	estadd local dt "Y": ppml_GCCb
	estadd local od "Y": ppml_GCCb
	eststo GCCb_tot : nlcom _b[dum_BLAs_10]  + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ppml_AFRa : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE2) cl($CL)
	estadd local ot "Y": ppml_AFRa
	estadd local od "Y": ppml_AFRa
	eststo AFRa_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post
	
	eststo ppml_AFRb : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o, abs($FE3) cl($CL)
	estadd local ot "Y": ppml_AFRb
	estadd local dt "Y": ppml_AFRb
	estadd local od "Y": ppml_AFRb
	eststo AFRb_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post	
	
	eststo ppml_devcata : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE2) cl($CL)
	estadd local ot "Y": ppml_devcata
	estadd local od "Y": ppml_devcata
	eststo devcata_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post	
	
	eststo ppml_devcatb : quiet ppmlhdfe mig dum_BLAs_10 c.dum_BLAs_10#i.devcat, abs($FE3) cl($CL)
	estadd local ot "Y": ppml_devcatb
	estadd local dt "Y": ppml_devcatb
	estadd local od "Y": ppml_devcatb
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
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
	  
	
** Heterogenous migration response to BLAs along the economic momentum and the timing of the BLA -- Table B.4
eststo clear // economic momentum OLS 
	eststo ols_moma :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.momentum, abs($FE2) cl($CL)
	estadd local ot "Y": ols_moma
	estadd local od "Y": ols_moma
	eststo olsmoma_tot : nlcom _b[dum_BLAs_10] + _b[2.momentum#c.dum_BLAs_10] + _b[3.momentum#c.dum_BLAs_10], post
	
	eststo ols_momb :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.momentum, abs($FE3) cl($CL)
	estadd local ot "Y": ols_momb
	estadd local dt "Y": ols_momb
	estadd local od "Y": ols_momb
	eststo olsmomb_tot : nlcom _b[dum_BLAs_10] + _b[2.momentum#c.dum_BLAs_10] + _b[3.momentum#c.dum_BLAs_10], post	
	
	eststo ols_dum5a :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.dum_5, abs($FE2) cl($CL)
	estadd local ot "Y": ols_dum5a
	estadd local od "Y": ols_dum5a
	eststo ols_dum5a_tot : nlcom _b[dum_BLAs_10] + _b[1.dum_5#c.dum_BLAs_10], post
	
	eststo ols_dum5b :  quiet reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.dum_5, abs($FE3) cl($CL)
	estadd local ot "Y": ols_dum5b
	estadd local od "Y": ols_dum5b
	estadd local dt "Y": ols_dum5b
	eststo ols_dum5b_tot : nlcom _b[dum_BLAs_10] + _b[1.dum_5#c.dum_BLAs_10], post


/* Preparing stack output table for Latex*/
/* Top panel */
esttab  ols_moma ols_momb ols_dum5a ols_dum5b using "$REGOUT\Table_B5.tex", replace f ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	   b(3) se(3) nomtitle star(* 0.10 ** 0.05 *** 0.01) /// 
	   drop(_cons 1.momentum#c.dum_BLAs_10 ///
	   0.dum_5#c.dum_BLAs_10) ///
	   varlabels(dum_BLAs_10 "Bilateral labor agreement (BLA)" ///
				 2.momentum#c.dum_BLAs_10 "BLA X Eco. stagnation" ///
				 3.momentum#c.dum_BLAs_10 "BLA X Post Cold War (\$>1990\$)" ///
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
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 
	

	
** Heterogeneous migration response to BLAs (regular corridors only) -- Table B.6	
eststo clear 
	eststo ols_GCCa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Y": ols_GCCa
	estadd local od "Y": ols_GCCa
	eststo GCCa_tot : nlcom _b[dum_BLAs_10] + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_GCCb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.GCC_d if minmig>9, abs($FE4) cl($CL)
	estadd local ot "Y": ols_GCCb
	estadd local dt "Y": ols_GCCb
	estadd local od "Y": ols_GCCb
	eststo GCCb_tot : nlcom _b[dum_BLAs_10]  + _b[1.GCC_d#c.dum_BLAs_10], post
	
	eststo ols_AFRa : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Y": ols_AFRa
	estadd local od "Y": ols_AFRa
	eststo AFRa_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post
	
	eststo ols_AFRb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.AFR_o if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Y": ols_AFRb
	estadd local dt "Y": ols_AFRb
	estadd local od "Y": ols_AFRb
	eststo AFRb_tot : nlcom _b[dum_BLAs_10] + _b[1.AFR_o#c.dum_BLAs_10], post	
	
	eststo ols_devcata : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat if minmig>9, abs($FE2) cl($CL)
	estadd local ot "Y": ols_devcata
	estadd local od "Y": ols_devcata
	eststo devcata_tot : nlcom _b[dum_BLAs_10] + _b[2.devcat#c.dum_BLAs_10], post	
	
	eststo ols_devcatb : reghdfe amig dum_BLAs_10 c.dum_BLAs_10#i.devcat if minmig>9, abs($FE3) cl($CL)
	estadd local ot "Y": ols_devcatb
	estadd local dt "Y": ols_devcatb
	estadd local od "Y": ols_devcatb
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
	   label  booktabs collabels(none) nomtitle nolines nonum  sfmt(%6.0fc) 

}
	
*======================================= 
* 			3.3 - Heterogeneous migration response to BLAs by governance -- Table 5  	          
*=======================================  
**  On the mechanics of the african puzzle : does governance plays a role?  (Governance effectiveness) 	          
   
eststo clear 
	eststo olsc :  reghdfe amig dum_BLAs_10  c.dum_BLAs_10#AFR_o c.dum_BLAs_10#gee_2 c.dum_BLAs_10#AFR_o#gee_2, abs($FE3) cl($CL) // bottom third
	estadd local ot "Y": olsc 
	estadd local dt "Y": olsc 
	estadd local od "Y": olsc 
	eststo olsd :  reghdfe amig dum_BLAs_10  c.dum_BLAs_10#AFR_o c.dum_BLAs_10#gee_3 c.dum_BLAs_10#AFR_o#gee_3, abs($FE3) cl($CL) // bottom third
	estadd local ot "Y": olsd 
	estadd local dt "Y": olsd
	estadd local od "Y": olsd
	eststo olse :  reghdfe amig dum_BLAs_10  c.dum_BLAs_10#AFR_o c.dum_BLAs_10#gee_4 c.dum_BLAs_10#AFR_o#gee_4, abs($FE3) cl($CL) // bottom quater 
	estadd local ot "Y": olse 
	estadd local dt "Y": olse
	estadd local od "Y": olse


	
esttab olsc olsd olse  using "$REGOUT\Table_5.tex", ///
	   postfoot(\bottomrule \end{tabular}) ///
	   prehead(\begin{tabular}{l*{@M}{r}} \toprule) ///
	   b(3) se(3) nomtitle /*r2 label*/ star(* 0.10 ** 0.05 *** 0.01) /// 
	   keep(dum_BLAs_10 1.AFR_o#c.dum_BLAs_10 2.gee_2#c.dum_BLAs_10 ///
						2.gee_3#c.dum_BLAs_10 3.gee_3#c.dum_BLAs_10 2.gee_4#c.dum_BLAs_10 ///
						3.gee_4#c.dum_BLAs_10 4.gee_4#c.dum_BLAs_10 ///
						1.AFR_o#2.gee_2#c.dum_BLAs_10 1.AFR_o#2.gee_3#c.dum_BLAs_10 ///
				  1.AFR_o#3.gee_3#c.dum_BLAs_10 1.AFR_o#2.gee_4#c.dum_BLAs_10 ///
				  1.AFR_o#3.gee_4#c.dum_BLAs_10 1.AFR_o#4.gee_4#c.dum_BLAs_10) ///
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
	   nonotes nomtitles collabels(none) compress sfmt(0) s(N r2 ot dt od, fmt(%9.0fc %9.3fc %9.0fc %9.0fc) ///
	   label("Observations" "R-sq" "Origin country x decade FE" "Destination country x decade FE" "Origin x destination countries FE")) ///
	   title("Heterogenous migration response to BLAs by governance category") ///
	   mgroups("Top half" "Top two terciles" "Top three quartiles", ///
	   pattern(1 1 1) ///
	   prefix(\multicolumn{@span}{c}{) suffix(}) ///
	   span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) replace 
	   
	