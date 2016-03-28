//Bradley Trowbridge
//Computer Architectire
//Lab 4 part 4
//Purpose: simple sequential machine to detect 01110

module lab4part4 (
A,		// serial input signal
CLK,	// clock input
RESET,	// state machine reset
Y		// output signal indicating 101 has been detected
);
//  Input ports
input	A;
input 	CLK;
input	RESET;
// Output ports
output Y;

wire A;
wire CLK;
wire RESET;
reg [1:0] state;
reg Y;

always @ (posedge CLK) // Only positive transition on clock is the sensitivity list
						// can add or RESET for asynchronous reset
begin
	#2;
	if (RESET == 1) begin
		state = "init";
	end 
	else begin	// This implements the transitions of the state machine
		if (state == "init")	begin		// state where no bits have been found
			if(A == 0) state = 5'b0;
		end 
		else if (state == 5'b0) begin // state with _ _ _ _ 0 found
			if(A == 1) state = 5'b01;
		end 
		else if (state == 5'b01) begin // state with _ _ _ 0 1 found	
			if(A == 0) state = 5'b0;
			if(A == 1) state = 5'b011;
		end 
		else if (state == 5'b011) begin // state with _ _ 0 1 1 found
			if(A == 0) state = 5'b0;
			if(A == 1) state = 5'b0111;	
		end
		else if (state == 5'b0111) begin // state with _ 0 1 1 1 found	
			if(A == 0) state = 5'b01110;
			if(A == 1) state = "init";
		end 
		else if (state == 5'b01110) begin // state with 0 1 1 1 0 found
			if(A == 0) state = 5'b0;
			if(A == 1) state = 5'b01;	
		end
	end
end

// Moore machine output section
always @ (state) 
begin
	if (state == "init") Y = 0; // pattern hasn't been detected...
	if (state == 5'b0) Y = 0;  
	if (state == 5'b01) Y = 0;
	if (state == 5'b011) Y = 0;
	if (state == 5'b0111) Y = 0;
	if (state == 5'b01110) Y = 1; //pattern is found
end
	
endmodule

module lab4part4_tb;  	// Note, no interface to testbenches
 reg wA,wCLK,wRESET;    // signals to be commanded must be "reg"
 wire wY;				// output from unit-under-test is "wire"

 
initial  begin
    $dumpfile ("lab4part4.vcd"); 
	$dumpvars; 
end 

initial begin
	wRESET = 1;
	wCLK = 0;
	wA = 0;
	#8 wRESET = 0;	
	#10 wA = 0;		// test 00
	#10 wA = 1;		
	#10 wA = 0;		// test 010
	#10 wA = 1;		 
	#10 wA = 1;		 
	#10 wA = 0;		// test 0110
	#10 wA = 1;		
	#10 wA = 1;
	#10 wA = 1;
	#10 wA = 0;		//test 01110
	#10 wA = 1;		
	#10 wA = 1;
	#10 wA = 1;
	#10 wA = 1;
	#10 wA = 1;		//test 011110		
	#20;
	$finish;
end

always begin
	#5 wCLK =! wCLK;
end

// Connect UUT to test bench signals
lab4part3 uut(
.A		(wA),
.CLK	(wCLK),
.RESET	(wRESET),
.Y		(wY)
);
endmodule