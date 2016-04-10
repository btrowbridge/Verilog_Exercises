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

input[31:0] inA,inB;
input[3:0] operation;
output[31:0]result;
output zero;

wire[31:0] inA,inB;
wire[3:0] operation;
reg[31:0] result;
reg zero;

initial begin
  case (operation) begin
    4'b0000: result = inA + inB;            // A + B
    4'b0001: result = inA - inB;            // A - B
    4'b0010: result = inA & inB;            // A AND B
    4'b0011: result = inA | inB;            // A OR B
    4'b0100: result = inA^inB;              // A XOR B
    4'b0101: result = inA~^inB              // A NOR B
    4'b0110: result = (inA < inB) ? 1 : 0;  // 1 if inA < inB, 0 otherwise (assume unsigned)
    4'b0111: result = inA<<inB;             // Shift inA logically left by inB bits
    4'b1000: result = inA>>inB;             // Shift inA logically right by inB bits
    4'b1001: result = inA>>>inB;            // Shift inA arithmetically right by inB bits
    4'b1010: result = inA;                   // A
    4'b1011: result = !inA;                  // NOT A
    4'b1100: result = inA+1;                 // A + 1
    4'b1101: result = inA-1;                 // A - 1
    4'b1110: $display("Not Implemented.")// not imppl
    4'b1111: $display("Not Implemented.")// not imppl
    default: 
        $display("Error: Bad operation input.")
  endcase
  zero = (result) ? 0 : 1;
  
end
endmodule

module lab7com1_tb;
    reg[31:0] wA,wB;
    reg[3:0] wOperation;
    wire[31:0] wResult;
    wire wZero;
    
initial begin
  f = $fopen("test.txt","w")
end

initial begin
    wA = 32'b00000000000000000000000000000000
    wB = 32'b00000000000000000000000000000000
    wOperation = 4'b0000
    for(k=0; k < 14; k++)begin
        wOperation = wOperation + 1
        for( i = 0; i < 32 i++)begin
            wA = wA+1
            for (j = 0 ;j < 32; j++ ) begin
                wB = wB+1
            end
        end
    end  
end
always @(wA or wB or wOperation) begin
  $fwrite(f,"%b_%b_%b_%b_%b",wA,wB,wOperation,wResult,wZero)
end

lab6com1 uut(
    .inA        (wA),
    .inB        (wB),
    .operation  (wOperation),
    result      (wResult),
    zero        (wZero)
);
endmodule