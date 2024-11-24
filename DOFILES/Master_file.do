/* =============================================================================
Project				: 	Do bilateral labor agreements increase migration?
						Global evidence from 1960 to 2020 
File purpose		:   Master do file documenting the work/files/paths

Authors				: 	Samik Adhikari (sadhikari2@worldbank.org)
					:   Narcisse Cha'ngom (chanarcisse@yahoo.fr / nchangom@worldbank.org)
					:   Heidi Kaila (hkaila@worldbank.org)
					:   Maheshwor Shrestha (mshrestha1@worldbank.org)
						
Date created		: 	October 5th, 2023						
Date last modified	:   November 21th, 2024	
============================================================================= */


clear all
  

global UPI = c(username)

*Set directory
gl PATH "C:\Users\\${UPI}\OneDrive - WBG\Replication File BLA-Migration"
cd "$PATH"


* files Locations
gl CODE			   		"$PATH\DOFILES"
gl DATA      			"$PATH\DATA"
gl REGOUT 			  	"$PATH\REGOUT"
gl FIG 					"$PATH\FIG"

/*==========================================
			Required packages
 =========================================== 
 // Uncomment this section and run if you do not have all the required user written commands
ssc install estout, replace
which estout 
which esttab
which estpost
ado update, update
ssc install reghdfe, replace 
ssc install ivreghdfe, replace 
ssc install ppmlhdfe, replace 
ssc install jwdid, replace 
ssc install hdfe, replace
ssc install panelview, replace 

*HK added
ssc install egenmore, replace
ssc install ftools, replace
ssc install ivreg2, replace  // NC
ssc install ivreghdfe, replace
======================================*/

ado
ado uninstall [10] // this remove the initial ivreghdfe which is installed on my computer but is not up to date



cap ado uninstall ivreghdfe
net install ivreghdfe, from(https://raw.githubusercontent.com/sergiocorreia/ivreghdfe/master/src/)
ssc install etime, replace 
*HK added
ssc install coefplot, replace 
ssc install wbopendata, replace 
*------------------------------------------------------------------------------*
*				1.0 - Load the data and create necessary indicators and groups *
*------------------------------------------------------------------------------*
etime, start 
		run "$CODE\Header.do" // Load the dataset and create high dimensional fixed effects and macros 
	
/*------------------------------------------------------------------------------*
*						2.0 - Main analysis (Benchmark)		        		   *
*------------------------------------------------------------------------------*

		do "$CODE\Main_analysis.do"

/*========= Main_analysis.do creates:

	2.1- Table 2
	2.2- Tables B.2 and B.3 
	2.3- Table 3
 ==========*/		
*/	
*------------------------------------------------------------------------------*
*						3.0 - Heterogeneity analysis    	        		   *
*------------------------------------------------------------------------------*

		run "$CODE\Heterogeneity_analysis.do"

/*========= Heterogeneity_analysis.do creates:

	3.1- Table 4
	3.2- Table 5
	3.3- Tables B.4, B.5 and B.6 
 ==========*/
 
*------------------------------------------------------------------------------*
*						4.0 - Event-study design	    	        		   *
*------------------------------------------------------------------------------*
		run "$CODE\Header.do" // reload the dataset for reformatting purposes
		run "$CODE\Event_study.do"

/*========= Event_study.do creates:

	4.1- Figure 1
	4.2- Figure 2: Figure_2A and Figure_2B
 ==========*/
*------------------------------------------------------------------------------*
*						5.0 - Robustness: Heterogeneity-robust DiD     		   *
*------------------------------------------------------------------------------*
		run "$CODE\Header.do" // reload the dataset for reformatting purposes
		run "$CODE\Heterogeneity_robust_DiD.do"		
		
/*========= Heterogeneity_robust_DiD.do creates:

	5.1- Table C.1
	5.2- Figure C.1 
	5.3- Figure C.2 
	5.4- Figure C.3 : Figure_C3A, Figure_C3B, Figure_C3C, and Figure_C3D 
 ==========*/		
	
*------------------------------------------------------------------------------*
*						6.0 - Welfare calculations				     		   *
*------------------------------------------------------------------------------*

		run "$CODE\welfare calculations.do" // this code performs welfare calculations presented in Section 5 of the paper and store on the excel file "welfare calculations.xlsx"
		
etime // display the time duration of the program 
