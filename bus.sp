* Digital Design Final project *

.include 'pmos-13u.lib'
.include 'nmos-13u.lib'

.option  post
.option nomod

.param  vdd=3.3v  pulsew=10n  
.param  lmin=6u  wmin=0.12u 

 
****define sub circuts ****



***** inverter ****
.subckt	 	 inverter   	in	 	out 	

mn1		out 	in		GND   0 	nmos    w=wmin   l=lmin
mp1     out     in		vdd	  0	   pmos		w=wmin	 l=lmin

.ends  inverter

**** multiplexer 4-1 with transmission gate****

.subckt     mux4_1			A  	B   C    D   sel1  sel2    result
xinv1  A  invA  inverter
xinv2  B  invB	inverter
xinv3  C  invC  inverter
xinv4  D  invD  inverter
xinv5  sel1  sel1not  inverter
xinv6  sel2   sel2not  inverter


mnA1 	mid1	sel1not		invA	0  nmos   w=wmin		l=lmin
mnA2	out		sel2not		mid     0  nmos	  w=wmin		l=lmin

mnB1 	mid2	sel1not		invB	0  nmos   w=wmin		l=lmin
mnB2	out		sel2		mid     0  nmos   w=wmin		l=lmin

mnC1 	mid3	sel1		invC	0  nmos   w=wmin		l=lmin
mnC2	out		sel2not		mid     0  nmos   w=wmin		l=lmin

mnD1 	mid4	sel1		invD	0  nmos   w=wmin		l=lmin
mnD2	out		sel2		mid     0  nmos   w=wmin		l=lmin

xinv7  out    result   inverter

.ends   mux4_1


**** main circut ****



vdd    sel2   GND  vdd



xtest   A   B     C    D sel1   sel2   out


.dc  B     vdd   0    1

.end


