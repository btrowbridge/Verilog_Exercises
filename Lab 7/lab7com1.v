//Bradley Trowbridge
//Computer Architecture
//Lab 7
//Component, ALU

module lab7com1 (
    inA,
    inB,
    operation,
    result,
    zero
);

input signed[31:0] inA,inB;
input[3:0] operation;
output signed[31:0]result;
output zero;

wire signed[31:0] inA,inB;
wire[3:0] operation;
reg signed[31:0] result;
reg zero;

always begin
    #1;
  case (operation)
    4'b0000: result = inA + inB;            // A + B
    4'b0001: result = inA - inB;            // A - B
    4'b0010: result = inA & inB;            // A AND B
    4'b0011: result = inA | inB;            // A OR B
    4'b0100: result = inA^inB;              // A XOR B
    4'b0101: result = inA~^inB;             // A NOR B
    4'b0110: result = (((inA < 0) ? -inA : inA) < ((inB < 0) ? -inB : inB)) ? 1 : 0;  // 1 if inA < inB, 0 otherwise (assume unsigned)
    4'b0111: result = inA<<inB;             // Shift inA logically left by inB bits
    4'b1000: result = inA>>inB;             // Shift inA logically right by inB bits
    4'b1001: result = inA>>>inB;            // Shift inA arithmetically right by inB bits
    4'b1010: result = inA;                  // A
    4'b1011: result = ~inA;                 // NOT A
    4'b1100: result = inA+1;                // A + 1
    4'b1101: result = inA-1;                // A - 1
    4'b1110: $display("Not Implemented.");  // not imppl
    4'b1111: $display("Not Implemented.");  // not imppl
    default: $display("Error: Bad operation input.");
  endcase
  zero = !result;
  
end
endmodule

module lab7com1_tb;
    reg signed[31:0] wA,wB;
    reg[3:0] wOperation;
    wire signed[31:0] wResult;
    wire wZero;
    
    reg signed[31:0] rightResult;
    reg rightZero;
    
        reg[100:0] testvectors[0:70];
		reg[7:0] errors;
		reg[7:0] vectornum;
        
initial  begin
    $dumpfile ("lab7com1.vcd"); 
	$dumpvars; 
end

initial begin
	$readmemb("lab7com1_test.txt",testvectors);
	errors = 0;
	vectornum = 0;
end

always begin

	if (testvectors[vectornum] === 101'bXXXX || vectornum === 73) begin    // XXXX is the "End of File" indicator I used
		$display("Test completed with %d errors.", errors);
		$finish;
	end 
	{wA, wB, wOperation, rightResult, rightZero} = testvectors[vectornum];
	#1; 
	if (rightResult != wResult || wZero != rightZero)begin
		errors = errors+1;
		$display("Input %b %b %b incorrectly creates %b %b at line %d.", wA, wB, wOperation, wResult, wZero, vectornum + 2);
    end else begin
	    $display("InA=%b InB=%b Op=%b | Result=%b Zero=%b", wA, wB, wOperation, wResult, wZero);
    end
	vectornum = vectornum +1;
end

lab7com1 uut(
    .inA        (wA),
    .inB        (wB),
    .operation  (wOperation),
    .result     (wResult),
    .zero       (wZero)
);
endmodule