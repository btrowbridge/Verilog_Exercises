//Bradley Trowbridge
//Computer Architecture
//Lab 6
//Component, Register File

module lab6com1(
	Input1,
	Input2, 
	WriteReg, 
	DataWrite, 
	WE, 
	CLK,
	);

input[4:0] Input1, Input2, WriteReg;
input[31:0] DataWrite;
input WE, Clk;

output[31:0] DataOut1, DataOut2;

reg[31:0] Register[0:31];


always begin
	#5 Clk = !CLK;
end

always @(posedge CLK) begin
	if(WE)begin
		Register[WriteReg] <= DataWrite;
		$display("Wrote %h to %b",DataWrite,WriteReg);
	end
end
always@(Input1)
	if(!WE)begin
		DataOut2 <= Register[Input2];
		$display("Loaded %h from %b", DataOut2,Input2);
	end
end
always@(Input2)
	if(!WE)begin
		DataOut2 <= Register[Input2];
		$display("Loaded %h from %b", DataOut2,Input2);
	end
end

endmodule