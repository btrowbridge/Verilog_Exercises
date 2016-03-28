// Author: Bradley Trowbridge
// Purpose: Lab 5 Computer architecture

//Component 3 32 bit 2-to-1 Multiplexor

module lab5com3 (
S,		// one input
D0,		// another input
D1,		// yet another input
Y		// an output
);
//  Input ports
input	S;
input[31:0] 	D0;
input[31:0] 	D1;
// Output ports
output[31:0]	 Y;

wire S;
wire[31:0] D0;
wire[31:0] D1;
wire[31:0] D0nS;
wire[31:0] D1S;
wire[31:0] Y;

not (nS,S);
and (D0nS,D0,nS);
and (D1S,D1,S);
or  (Y,D0nS,D1S);

endmodule

module lab5com3_tb;  // Note, no interface to testbenches
 reg wS;
 reg [31:0] sD0,wD1;      // signals to be commanded must be "reg"
 wire wY;			// output from unit-under-test is "wire"
	reg [96:0] testvectors[0:10]; // the size of the array must match
								 // the number of bits per line, the size of the array should 
								 // meet or exceed the length of the file, warnings are fine.
	reg [7:0] errors;
	reg [7:0] vectornum;
	reg rightY;
 
initial  begin
    $dumpfile ("lab5com3.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemb("lab5com3test_vec.txt", testvectors); // loads file into an array
	vectornum = 0;
	errors = 0;
end

always // self-checking test bench needs a loop structure that will process lines from a text file
	begin
	
	if (testvectors[vectornum] === 4'bXXXX) begin    // XXXX is the "End of File" indicator I used
		$display("Test completed with %d errors.", errors);
		$finish;
	end
	{wS, wD0, wD1, rightY} = testvectors[vectornum];	
	#1; 
	if (rightY !== wY)
	begin
		errors = errors+1;
		$display("Input %b %b %b incorrectly creates %b.", wS, wD0, wD1, wY);
	end
	$display ("S=%b  D0=%b  D1=%b  Y=%b", wS, wD0, wD1, wY);
	
	vectornum = vectornum+1;
	
	
end

// Connect UUT to test bench signals
lab5com3 uut(
.S	(wS),
.D0	(wD0),
.D1	(wD1),
.Y	(wY)
);
endmodule