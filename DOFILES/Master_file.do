/* =============================================================================
Project				: 	Do bilateral labor agreements increase migration?
						Global evidence from 1960 to 2020 
File purpose		:   Master do file documenting the work/files/paths

Authors				: 	Samik Adhikari (sadhikari2@worldbank.org)
					:   Narcisse Cha'ngom (chanarcisse@yahoo.fr / nchangom@worldbank.org)
					:   Heidi Kaila (hkaila@worldbank.org)
					:   Maheshwor Shrestha (mshrestha1@worldbank.org)
						
Date created		: 	October 5th, 2023						
Date last modified	:	December 8th, 2024	
============================================================================= */


clear all
  

global UPI = c(username)

*Set directory
gl PATH "PUT THE DIRECTORY REFERENCE TO THE LOCATION WHERE THE FOLDERS ARE STORED"
cd "$PATH"


* files Locations
gl CODE			   		"$PATH\DOFILES"
gl DATA      			"$PATH\DATA"
gl REGOUT 			  	"$PATH\REGOUT"
gl FIG 					"$PATH\FIG"


/*==========================================
			Required packages
 =========================================== */

local pkg "estout esttab estpost reghdfe ivreghdfe ppmlhdfe jwdid hdfe ftools ivreg2 ranktest ivreghdfe etime coefplot wbopendata"
foreach pk of local pkg{
	cap which `pk'
	if _rc !=0 ssc install `pk'
}


etime, start

*------------------------------------------------------------------------------*
*				0.0 - Load the data and create necessary indicators and groups *
*------------------------------------------------------------------------------*
 
		run "$CODE\Header.do" // Load the dataset and create high dimensional fixed effects and macros 
	
*------------------------------------------------------------------------------*
*						1.0 - Main analysis (Benchmark)		        		   *
*------------------------------------------------------------------------------*

		do "$CODE\Descriptives_Tab1_Tab_B1.do"

/*========= Main_analysis.do creates:

	1.1- Table 1
	1.2- Tables B.1
 ==========*/		

*------------------------------------------------------------------------------*
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

		do "$CODE\Heterogeneity_analysis.do"

/*========= Heterogeneity_analysis.do creates:

	3.1- Table 4
	3.2- Table 5
	3.3- Tables B.4, B.5 and B.6 
 ==========*/
 
*------------------------------------------------------------------------------*
*						4.0 - Event-study design	    	        		   *
*------------------------------------------------------------------------------*
		run "$CODE\Header.do" // reload the dataset for reformatting purposes
		do "$CODE\Event_study.do"

/*========= Event_study.do creates:

	4.1- Figure 1
	4.2- Figure 2: Figure_2A and Figure_2B
 ==========*/
*------------------------------------------------------------------------------*
*						5.0 - Robustness: Heterogeneity-robust DiD     		   *
*------------------------------------------------------------------------------*
		run "$CODE\Header.do" // reload the dataset for reformatting purposes
		do "$CODE\Heterogeneity_robust_DiD.do"		
		
/*========= Heterogeneity_robust_DiD.do creates:

	5.1- Table C.1
	5.2- Figure C.1 
	5.3- Figure C.2 
	5.4- Figure C.3 : Figure_C3A, Figure_C3B, Figure_C3C, and Figure_C3D 
 ==========*/		
	
*------------------------------------------------------------------------------*
*						6.0 - Welfare calculations for section 5				     		   *
*------------------------------------------------------------------------------*

		do "$CODE\welfare calculations.do" // this code produces the descriptives statistics needed to perform the welfare calculations presented in Section 5 of the paper. These results should be manually put in the excel file "welfare calculations.xlsx" to perform the welfare calculations

*------------------------------------------------------------------------------*
*				7.0 - Figures A-1 to A-6 of Appendix A         *
*------------------------------------------------------------------------------*
		run "$CODE\Appendix_A.do" // This exercise is done at the initial stage because it directly builds on rawdata prior formating 
/*========= Appendix_A.do creates:

	7.1- Figure A.1 
	7.2- Figure A.2
	7.3- Figure A.3
	7.4- Figure A.4
	7.5- Figure A.5
	7.6- Figure A.6
 ==========*/

etime // display the time duration of the program 
