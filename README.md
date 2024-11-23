# BLAs-Migration-repo
*===================================================================================*
# Do bilateral labor agreements increase migration? Global evidence from 1960 to 2020
*===================================================================================*
            
              Samik Adhikari, Narcisse Cha’ngom,  Heidi Kaila, and Maheshwor Shrestha
            
What the project does: This project combines the most comprehensive dataset on bilateral migration stocks, spanning the period from 1960 to 2020 at ten-year intervals, with the most extensive collection of Bilateral Labor Agreements (BLAs) to date. The dataset includes 1,222 agreements signed between countries since World War II, detailing the year of each BLA and the countries involved. Using a triple-difference approach within a gravity model framework enriched with a rich structure of fixed effects, the study investigates whether the signing of a BLA increases migration between country pairs. The findings reveal that signing a BLA, on average, significantly increases migration within the designated corridor, and this effect persists for up to three decades. Further disaggregation of the analysis highlights the following key points: (1) The effects are more pronounced in corridors without pre-existing regular migration flows and for destinations in the Gulf Cooperation Council (GCC) countries. (2) No significant impact is observed for migration involving African countries, particularly those with weak government effectiveness. (3) BLAs result in substantial welfare gains, especially for migrants from Low- and Lower-Middle-Income Countries.



# 1.	Data on Bilateral Labor Agreements (BLA) and bilateral migration 
This paper uses the most comprehensive dataset on bilateral migration stocks, covering the period from 1960 to 2020 in ten-year intervals. Migration stock data for 1960, 1970, 1980, 1990, and 2000 are sourced from the World Bank (2022), while data for 2010 and 2020 are drawn from UNDESA (2020), which employs a similar methodology. In these datasets, a migrant is defined as an individual residing in a country different from their country of birth. In addition, we incorporate data on BLAs from Chilton et Woda (2022), the most comprehensive collection of BLAs to date, comprising 1,222 agreements signed between countries since World War II including information on the year of each BLA and the countries involved. To match the migration data format, we transform the BLA data by identifying the country of origin, the country of destination, and aligning each BLA with the corresponding year in the migration data. For instance, a BLA signed between 1970 and 1979 is assigned to t=1980 in the migration dataset. For consistency, we classify the country with the lower GDP per capita as the "origin" country and the other as the "destination" country. Origin-destination-year cells without a recorded BLA are assumed to have no agreement in place.


# 2.	Instructions for Use
  Download the entire content of this package “Replication File BLA-Migration” to a location in your computer. The package contains four folders: 
    -	DATA: this folder contains the dataset used throughout the paper (BLA_Migration_data.dta)
    -	DOFILES: this folder contains seven .do files (program to run) and one excel sheet that accompany welfare calculations reported in section five of the paper.
    -	FIG: this folder will contain after the replication of the code the nine figures of the results section (main text + appendix) named accordingly.
    -	REGOUT: this folder will contain 10 tables reported in the result section of the paper (main text + appendix).
  
# 3.	Preparation
    a.	Ensure all the user written Stata Packages needed for the analysis are installed and are up to date.
    b.	Ensure that all directories are consistently specified.

# 4.	Execution
    a.	Change the directory path in line 23 of “Master_file.do” to be the corresponding location in your computer where you store the “Replication File BLA-Migration” folder.
    b.	Run the “Master_file.do” in Stata that jointly takes care of everything. The file will in turn call the following do-files:
      b.1.	Run program “Header.do” to: Load the dataset and create high dimensional fixed effects and macros.
      b.2.	Run program “Main_analysis.do” to: Create Table 2, Table B.2, Table B.3 and Table 3.
      b.3.	Run program “Heterogeneity_analysis.do” to: Create Table 4, Table 5, Table B.4, Table B.5, and Table B.6.
      b.4.	Run program “Event_study.do” to: Create Figure 1 and Figure 2 (panels Figure_2A and Figure_2B).
      b.5.	Run program “Heterogeneity_robust_DiD.do” to: Create Table C.1, Figure C.1, Figure C.2, Figure C.3 (panels Figure_C3A, Figure_C3B, Figure_C3C, and Figure_C3D)
      b.6.	Run program “welfare calculations.do” to produce welfare numbers reported in the section 5 of the paper. 

# 5.	Characteristics of the computer used and runtime. 
  Processor	12th Gen Intel(R) Core (TM) i5-1245U   1.60 GHz
  Installed RAM	16.0 GB  
  System type	64-bit operating system, x64-based processor

# 6.	Stata version: STATA MP.18.0
Time taken to run the entire code: the program elapsed time is 4 minutes 21 seconds.


