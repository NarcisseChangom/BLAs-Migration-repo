# Replication package for "Do bilateral labor agreements increase migration? Global evidence from 1960 to 2020"
_Samik Adhikari, Narcisse Cha’ngom,  Heidi Kaila,_ and _Maheshwor Shrestha_

## 1.	Data on Bilateral Labor Agreements (BLA) and bilateral migration 
This paper uses data on bilateral migration stocks, covering the period from 1960 to 2020 in ten-year intervals. Migration stock data for 1960, 1970, 1980, 1990, and 2000 are sourced from the World Bank (2022), while data for 2010 and 2020 are drawn from UNDESA (2020), which employs a similar methodology. 

The data on bilateral labor agreements (BLAs) come from Chilton and Woda (2022), comprising 1,222 agreements signed between countries since World War II including information on the year of each BLA and the countries involved. 

To match the migration data format, we transform the BLA data by identifying the country of origin, the country of destination, and aligning each BLA with the corresponding year in the migration data. For instance, a BLA signed between 1970 and 1979 is assigned to t=1980 in the migration dataset. For consistency, we classify the country with the lower GDP per capita as the "origin" country and the other as the "destination" country. Origin-destination-year cells without a recorded BLA are assumed to have no agreement in place.

The combined data is provided with this repository. Users may check out the following sources for the original data:  

Bilateral Labor Agreements data 1945-2020 available at: https://dataverse.harvard.edu/dataverse/BLA
            
Bilateral Migration data 1960-2000 available at: https://databank.worldbank.org/source/global-bilateral-migration 
            
Bilateral Migration data 2010-2020 available at: https://www.un.org/development/desa/pd/content/international-migration-1 


## 2.	Instructions for Use
  Download the entire content of this package “Replication File BLA-Migration” to a location in your computer. The package contains four folders: 
  
  * DATA: this folder contains the dataset used throughout the paper (BLA_Migration_data.dta)
 
  * DOFILES: this folder contains seven .do files (program to run) and one excel sheet that accompany welfare calculations reported in section five of the paper.
    
  * FIG: this folder will contain after the replication of the code the nine figures of the results section (main text + appendix) named accordingly.
    
  * REGOUT: this folder will contain 10 tables reported in the result section of the paper (main text + appendix).
    
  
## 3.	Preparation
* Ensure all the user written Stata Packages needed for the analysis are installed and are up to date (file "master_file.do" installs all user-written commands. You can uncomment them if you already have the necessary commands). 
* Ensure that all directories are consistently specified.

## 4.	Execution
* Change the directory path in line 23 of “Master_file.do” to be the corresponding location in your computer where you store the “Replication File BLA-Migration” folder.
* Run the “Master_file.do” in Stata that jointly takes care of everything. The file will in turn call the following do-files:
  - “Header.do” to: Load the dataset and create high dimensional fixed effects and macros.
  - “Main_analysis.do” to: Create Table 2, Table B.2, Table B.3 and Table 3.
  - “Heterogeneity_analysis.do” to: Create Table 4, Table 5, Table B.4, Table B.5, and Table B.6.
  - “Event_study.do” to: Create Figure 1 and Figure 2 (panels Figure_2A and Figure_2B).
  - “Heterogeneity_robust_DiD.do” to: Create Table C.1, Figure C.1, Figure C.2, Figure C.3 (panels Figure_C3A, Figure_C3B, Figure_C3C, and Figure_C3D)
  - “welfare calculations.do” to produce welfare numbers reported in the section 5 of the paper. 

# 5.	Runtime 
  **Machine details**: 
  
  Processor: 12th Gen Intel(R) Core (TM) i5-1245U   1.60 GHz
  
  Installed RAM: 16.0 GB  
  
  System type: 64-bit operating system, x64-based processor

  **Software**: 
  STATA MP 18.0

  **Runtime**: 4 minutes 21 seconds.


