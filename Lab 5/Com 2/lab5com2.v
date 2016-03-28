// Author: Bradley Trowbridge
// Purpose: Lab 5 Computer architecture

//Component 2 – 1 bit 4-to-1 Multiplexor

module lab5com2 (
S,		// one input
D0,		// another input
D1,		// yet another input
D2,		//input
D3,		//input
Y		// an output
);
//  Input ports
input[1:0]	S;
input 	D0;
input 	D1;
input 	D2;
input 	D3;

// Output ports
output Y;

wire S;
wire D0;
wire D1;
wire D2;
wire D3;
wire S00;
wire S01;
wire S10;
wire S11;
wire Y;


and (S00,S==2'b00,D0);
and (S01,S==2'b01,D1);
and (S10,S==2'b10,D2);
and (S11,S==2'b11,D3);
or  (Y,S00,S01,S02,S03);


endmodule

module lab5com2_tb;  // Note, no interface to testbenches
 reg[1:0] wS;
 reg D0,D1,D2,D3;      // signals to be commanded must be "reg"
 wire wY;			// output from unit-under-test is "wire"
	reg [6:0] testvectors[0:10]; // the size of the array must match
								 // the number of bits per line, the size of the array should 
								 // meet or exceed the length of the file, warnings are fine.
	reg [7:0] errors;
	reg [7:0] vectornum;
	reg rightY;
 
initial  begin
    $dumpfile ("lab5com2.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemb("lab5com2test_vec.txt", testvectors); // loads file into an array
	vectornum = 0;
	errors = 0;
end

always // self-checking test bench needs a loop structure that will process lines from a text file
	begin
	
	if (testvectors[vectornum] === 4'bXXXX) begin    // XXXX is the "End of File" indicator I used
		$display("Test completed with %d errors.", errors);
		$finish;
	end
	{wS, wD0, wD1, wD2, wD3, rightY} = testvectors[vectornum];	
	#1; 
	if (rightY !== wY)
	begin
		errors = errors+1;
		$display("Input %b %b %b %b incorrectly creates %b.", wS, wD0, wD1, wD2, wD3, wY);
	end
	$display ("S=%b  D0=%b  D1=%b  D2=%b  D3=%b  Y=%b", wS, wD0, wD1, wD2, wD3, wY);
	
	vectornum = vectornum+1;
	
	
end

// Connect UUT to test bench signals
lab5com2 uut(
.S	(wS),
.D0	(wD0),
.D1	(wD1),
.D2	(wD2),
.D3	(wD3),
.Y	(wY)
);
endmodule