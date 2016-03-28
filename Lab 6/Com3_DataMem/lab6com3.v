//Bradley Trowbridge
//Computer Architecture
//Lab 6
//Component, Data Memory

module lab6com3(
		Address,
		WE, 
		clk, 
		byte, 
		halfword, 
		dataIn,
		Data
	);

input[31:0] Address, dataIn;
input WE, clk, byte, halfword;
output[31:0] Data;

reg[31:0] DataMem [31:0];
initial begin
	for(i = 0; i < 4096; i++) begin
		DataMem[i] = i;
	end
end
always begin
	#5 clk	= !clk	;
end
always @(posedge clk) begin
	if(WE)
		if( !halfword && !byte ) begin
			DataMem	[Address] <= dataIn[31:0];
		else if(halfword && !byte)begin
			DataMem	[Address] <= dataIn[15:0];
		else if(halfword && !byte)begin
			DataMem	[Address] <= dataIn[7:0];
		else begin
			$display("ERROR: undefined data type");
		end
	end
end	
endmodule