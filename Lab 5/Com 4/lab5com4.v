// Author: Bradley Trowbridge
// Purpose: Lab 5 Computer architecture

//Component 4 – Signed/Unsigned Extender

module lab5com4 (
data,		// one input
byte,		// another input
sign,		// yet another input
extData		// an output
);
//  Input ports
input	data;
input 	byte;
input 	sign;
// Output ports
output extData;

wire A;
wire B;
wire C;
wire nS;
wire D0nS;
wire D1S;
wire Y;

not(nS,S)
and (D0nS,D0,nS);
and (D1S,D1,S);
or  (Y,D0nS,D1S);

endmodule

module lab5com4_tb;  // Note, no interface to testbenches
 reg wA,wB,wC;      // signals to be commanded must be "reg"
 wire wY;			// output from unit-under-test is "wire"
	reg [3:0] testvectors[0:10]; // the size of the array must match
								 // the number of bits per line, the size of the array should 
								 // meet or exceed the length of the file, warnings are fine.
	reg [7:0] errors;
	reg [7:0] vectornum;
	reg rightY;
 
initial  begin
    $dumpfile ("lab5com4.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemb("lab5com4test_vec.txt", testvectors); // loads file into an array
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
lab5com4 uut(
.S	(wS),
.D0	(wD0),
.D1	(wD1),
.Y	(wY)
);
endmodule