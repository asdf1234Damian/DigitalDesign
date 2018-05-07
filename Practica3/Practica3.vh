module sumadorrestador ( 
	a,
	b,
	ci,
	s,
	cf,
	overflow
	) ;

input [3:0] a;
input [3:0] b;
input  ci;
inout [3:0] s;
inout  cf;
inout  overflow;
