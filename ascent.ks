//ag1 on. 
ag5 on.
IF body = Mun AND ALTITUDE > 10000 {RUNPATH("0:/E.KS").}
IF body = Mun AND ALTITUDE < 10000 {RUNPATH("0:/a3.KS").}
IF body = KERBIN AND ALTITUDE < 10000 {RUNPATH("0:/A4.KS"). }
