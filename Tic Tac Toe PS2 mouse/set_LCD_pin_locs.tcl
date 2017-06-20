
# Requre quartus project
package require ::quartus::project

# Set pin locations for LCD
set_location_assignment PIN_AF26 -to LT24_D[0]
set_location_assignment PIN_AF25 -to LT24_D[1]
set_location_assignment PIN_AE24 -to LT24_D[2]
set_location_assignment PIN_AE23 -to LT24_D[3]
set_location_assignment PIN_AJ27 -to LT24_D[4]
set_location_assignment PIN_AK29 -to LT24_D[5]
set_location_assignment PIN_AK28 -to LT24_D[6]
set_location_assignment PIN_AK27 -to LT24_D[7]
set_location_assignment PIN_AJ26 -to LT24_D[8]
set_location_assignment PIN_AK26 -to LT24_D[9]
set_location_assignment PIN_AH25 -to LT24_D[10]
set_location_assignment PIN_AJ25 -to LT24_D[11]
set_location_assignment PIN_AJ24 -to LT24_D[12]
set_location_assignment PIN_AK24 -to LT24_D[13]
set_location_assignment PIN_AG23 -to LT24_D[14]
set_location_assignment PIN_AK23 -to LT24_D[15]
set_location_assignment PIN_AD21 -to LT24_RESETn
set_location_assignment PIN_AH27 -to LT24_RS
set_location_assignment PIN_AH23 -to LT24_CSn
set_location_assignment PIN_AG26 -to LT24_RDn
set_location_assignment PIN_AH24 -to LT24_WRn
set_location_assignment PIN_AC22 -to LT24_LCD_ON

# Set pin location for Clock
set_location_assignment PIN_AA16 -to clock

# Set pin location for globalReset
set_location_assignment PIN_AB12 -to globalReset

# Other assignments
set_location_assignment PIN_AA14 -to pause
set_location_assignment PIN_AD7 -to ps2c
set_location_assignment PIN_AE7 -to ps2d
set_location_assignment PIN_AE26 -to SevenSeg[0]
set_location_assignment PIN_AE27 -to SevenSeg[1]
set_location_assignment PIN_AE28 -to SevenSeg[2]
set_location_assignment PIN_AG27 -to SevenSeg[3]
set_location_assignment PIN_AF28 -to SevenSeg[4]
set_location_assignment PIN_AG28 -to SevenSeg[5]
set_location_assignment PIN_AH28 -to SevenSeg[6]
set_location_assignment PIN_AJ29 -to SevenSeg[7]
set_location_assignment PIN_AH29 -to SevenSeg[8]
set_location_assignment PIN_AH30 -to SevenSeg[9]
set_location_assignment PIN_AG30 -to SevenSeg[10]
set_location_assignment PIN_AF29 -to SevenSeg[11]
set_location_assignment PIN_AF30 -to SevenSeg[12]
set_location_assignment PIN_AD27 -to SevenSeg[13]
set_location_assignment PIN_AB23 -to SevenSeg[14]
set_location_assignment PIN_AE29 -to SevenSeg[15]
set_location_assignment PIN_AD29 -to SevenSeg[16]
set_location_assignment PIN_AC28 -to SevenSeg[17]
set_location_assignment PIN_AD30 -to SevenSeg[18]
set_location_assignment PIN_AC29 -to SevenSeg[19]
set_location_assignment PIN_AC30 -to SevenSeg[20]
set_location_assignment PIN_AD26 -to SevenSeg[21]
set_location_assignment PIN_AC27 -to SevenSeg[22]
set_location_assignment PIN_AD25 -to SevenSeg[23]
set_location_assignment PIN_AC25 -to SevenSeg[24]
set_location_assignment PIN_AB28 -to SevenSeg[25]
set_location_assignment PIN_AB25 -to SevenSeg[26]
set_location_assignment PIN_AB22 -to SevenSeg[27]
set_location_assignment PIN_AA24 -to SevenSeg[28]
set_location_assignment PIN_Y23 -to SevenSeg[29]
set_location_assignment PIN_Y24 -to SevenSeg[30]
set_location_assignment PIN_W22 -to SevenSeg[31]
set_location_assignment PIN_W24 -to SevenSeg[32]
set_location_assignment PIN_V23 -to SevenSeg[33]
set_location_assignment PIN_W25 -to SevenSeg[34]
set_location_assignment PIN_V25 -to SevenSeg[35]
set_location_assignment PIN_AA28 -to SevenSeg[36]
set_location_assignment PIN_Y27 -to SevenSeg[37]
set_location_assignment PIN_AB27 -to SevenSeg[38]
set_location_assignment PIN_AB26 -to SevenSeg[39]
set_location_assignment PIN_AA26 -to SevenSeg[40]
set_location_assignment PIN_AA25 -to SevenSeg[41]
set_location_assignment PIN_V16 -to leds[0]
set_location_assignment PIN_W16 -to leds[1]
set_location_assignment PIN_V17 -to leds[2]
set_location_assignment PIN_V18 -to leds[3]
set_location_assignment PIN_W17 -to leds[4]
set_location_assignment PIN_W19 -to leds[5]
set_location_assignment PIN_Y19 -to leds[6]
set_location_assignment PIN_W20 -to leds[7]
set_location_assignment PIN_W21 -to leds[8]
set_location_assignment PIN_Y21 -to leds[9]

# Commit assignments
export_assignments