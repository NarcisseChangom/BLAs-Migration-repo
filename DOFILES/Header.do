
*------------------------------------------------------------------------------*
*				1.0 - Load the data and create necessary indicators and groups *
*------------------------------------------------------------------------------*
use "$DATA\BLA_Migration_data", clear 
		lab var dum_BLAs_10 "Bilateral labor agreement (BLA)"


replace devcat = 2 if devcat==.

** x-tiles based of governance indicators 
		bys o_iso3 (d_iso3 year): gen __x = _n

		xtile __gee_2 = gee if __x ==1, nq(2)
		egen gee_2 = max(__gee_2), by(o_iso3)

		lab define gee_2 1 "Bottom half" 2 "Top half", modify 
		lab values gee_2 gee_2 

		xtile __gee_3 = gee if __x ==1, nq(3)
		egen gee_3 = max(__gee_3), by(o_iso3)
		lab define gee_3 1 "Bottom tercile" 2 "Middle tercile" 3 "Top tercile", modify  
		lab values gee_3 gee_3 

		xtile __gee_4 = gee if __x ==1, nq(4)
		egen gee_4 = max(__gee_4), by(o_iso3)
		lab define gee_4 1 "Bottom quartile" 2 "Third quartile" 3 "Second quartile" 4 "First quartile", modify 
		lab values gee_4 gee_4
		 
** Instrument (Leave one out)
replace BLAs_signed = 0 if mi(BLAs_signed)
cap drop leave_out leave_in 
egen leave_out = sum(BLAs_signed), by(d_iso3 year)
egen leave_in = sum(BLAs_signed), by(o_iso3 year)
replace leave_out = leave_out-BLAs_signed
replace leave_in = leave_in - BLAs_signed

	g ln_leave_out = asinh(leave_out) 
	g ln_leave_in = asinh(leave_in)
	lab var ln_leave_out "Leave one out (destination)"
	lab var ln_leave_in "Leave one out (origin)"
** Structural pattern of the economy overtime (1960-2020)
		g momentum = .
		replace momentum = 1 if inrange(year,1960,1970)
		replace momentum = 2 if inrange(year,1980,1990)
		replace momentum = 3 if inrange(year,2000,2020)
		lab define momentum 1 "Post WW-II" 2 "Eco. stagnation" 3 "Post Cold War", modify
		lab values momentum momentum 

** Relative size of corridors (percent)
		bys o_iso3 d_iso3: egen Smig = total(mig)
		egen SSmig = total(mig)
		egen pctile = xtile(Smig), nq(100) 
		gsort -Smig 
		g order = _n 
		egen N = total(order)
		egen pct = xtile(order), nq(100)
		egen minmig = min(mig), by(o_iso3 d_iso3) // Regular corridors 
		g amig = asinh(mig) // log migration (inverse hyperbolic sine transformation)

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

