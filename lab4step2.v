//Bradley Trowbridge
//Computer Architecture
//Lab 4

//Step 1
//G =A'∙B'+A∙B∙D + B'∙D'+A∙C∙D
module lab4step2(
	A,		//input	
	B,		//input	
	C,		//input
	D,		//input	
	//intermediate output for printing
	nA,nB,nD,
	nAnB,ABD,nBnD,ACD,
	G		//output
	);
//input ports
input A,B,C,D;
//output ports
output G;

//intermediate output for printing purposes
output nA,nB,nD;
output nAnB,ABD,nBnD,ACD;

//wires
//input wires
wire A,B,C,D;
//logical not wires
wire nA,nB,nD;
//logical and wires
wire nAnB,ABD,nBnD,ACD;
//ouput wires
wire G;

//logic
not(nA,A);
not(nB,B);
not(nD,D);
and(nAnB,nA,nB);
and(ABD,A,B,D);
and(nBnD,nB,nD);
and(ACD,A,C,D);
or(G,nAnB,ABD,nBnD,ACD);

endmodule

module lab4step2_tb;
	reg wA,wB,wC,wD;
	//logical not wires
	wire wnA,wnB,wnD;
	//logical and wires
	wire wnAnB,wABD,wnBnD,wACD;
	wire wG;
//$monitor ("A=%b B=%b C=%b D=%b nA=%b nB=%b nD=%b nAnB=%b ABD=%b nBnD=%b ACD=%b G=%b", wA,wB, wC,wD,wnA,wnB,wnD,wnAnB,wABD,wnBnD,wACD, wG);

//test bench
initial begin
	wA = 0;		//test 0000
	wB = 0;
	wC = 0;
	wD = 0;

	$monitor ("A=%b B=%b C=%b D=%b nA=%b nB=%b nD=%b nAnB=%b ABD=%b nBnD=%b ACD=%b G=%b", wA,wB, wC,wD,wnA,wnB,wnD,wnAnB,wABD,wnBnD,wACD, wG);
	#5 wD = 1;	//0001
	#5 wC = 1;	//0011
	#5 wD = 0;	//0010
	#5 wB = 1;  //0110
	#5 wD = 1;	//0111
	#5 wC = 0;	//0101
	#5 wD = 0;	//0100
	#5 wA = 1;	//1100
	#5 wD = 1;	//1101
	#5 wC = 1;	//1111
	#5 wD = 0;	//1110
	#5 wB = 0;	//1010
	#5 wD = 1;	//1011
	#5 wC = 0;	//1001
	#5 wD = 0;	//1000
	#5 $finish;
end


//connect UUT to test bench signals
lab4step2 uut(
.A  (wA),
.B  (wB),
.C  (wC),
.D  (wD),
.nA (wnA),
.nB (wnB),
.nD (wnD),
.nAnB (wnAnB),
.ABD (wABD),
.nBnD (wnBnD),
.ACD (wACD),
.G  (wG)
);
endmodule