//Bradley Trowbridge
//Computer Architecture
//Lab 6
//Component, Instruction Memory

module lab6com2(
	Address,
	Data, 
	CLK,
	);

input[31:0] Address;
output[31:0] Data;

reg [31:0]instMemory[0:31];
initial begin
	for(i = 0; i < 64; i++) begin
		instMemory	[i] = i;
	end
end
always@(posedge CLK)begin
	Data <= instMemory[Address];
	$display("Loaded %h from %h", Data,Address);
end
endmodule


