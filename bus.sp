* Digital Design Final project *

.include 'pmos-13u.lib'
.include 'nmos-13u.lib'

.option  post
.option nomod

.param  vdd=3.3v  pulsew=10n  
.param  lmin=6u  wmin=0.12u 

.global vdd

 
****define sub circuts ****



***** inverter ****
.subckt	 	 inverter   	in	 	out 	

mn1		out 	in		GND   0 	nmos    w=wmin   l=lmin
mp1     out     in		vdd	  vdd	   pmos		w=wmin	 l=lmin

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
mpA1 	mid1	sel1		invA	vdd  pmos   w=wmin		l=lmin
mnA2	out		sel2not		mid1     0  nmos	  w=wmin		l=lmin
mpA2	out		sel2		mid1    vdd  pmos	  w=wmin		l=lmin

mnB1 	mid2	sel1not		invB	0  nmos   w=wmin		l=lmin
mpB1 	mid2	sel1		invB	vdd  pmos   w=wmin		l=lmin
mnB2	out		sel2		mid2     0  nmos   w=wmin		l=lmin
mpB2	out		sel2not		mid2     vdd  pmos   w=wmin		l=lmin

mnC1 	mid3	sel1		invC	0  nmos   w=wmin		l=lmin
mpC1 	mid3	sel1not		invC	vdd  pmos   w=wmin		l=lmin
mnC2	out		sel2not		mid3     0  nmos   w=wmin		l=lmin
mpC2	out		sel2		mid3     vdd  pmos   w=wmin		l=lmin

mnD1 	mid4	sel1		invD	0  nmos   w=wmin		l=lmin
mpD1 	mid4	sel1not		invD	vdd  pmos   w=wmin		l=lmin
mnD2	out		sel2		mid4     0  nmos   w=wmin		l=lmin
mpD2	out		sel2not		mid4     vdd  pmos   w=wmin		l=lmin

xinv7  out    result   inverter

.ends   mux4_1


**** main circut ****

vsel1 sel1   0  pwl	0  0  4us  3.3  16us  3.3  20us  0  32us 0   
Vsel2 sel2   0  Pwl  0  0  2us  3.3  14us  3.3  20us  0  32us 0 


va0 A0 0 0
va1 A1 0 0
va2 A2 0 0
va3 A3 0 0
vb0 B0 0 vdd
vb1 B1 0 vdd
vb2 B2 0 vdd
vb3 B3 0 vdd
vc0 C0 0 0
vc1 C1 0 vdd
vc2 C2 0 0
vc3 C3 0 vdd
vd0 D0 0 vdd
vd1 D1 0 0
vd2 D2 0 vdd
vd3 D3 0 0




xtest0   A0   B0     C0    D0   sel1   sel2   out0  mux4_1
xtest1   A1   B1     C1    D1   sel1   sel2   out1	mux4_1
xtest2   A2   B2     C2    D2   sel1   sel2   out2	mux4_1
xtest3   A3   B3     C3    D3   sel1   sel2   out3  mux4_1



.tran  0   200us


.end


