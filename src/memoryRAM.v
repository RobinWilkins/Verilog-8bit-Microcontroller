module memoryRAM
	( 
		clk,
		dataIn,
		dataOut,
		address,
		writeEnable
	);

	input clk; 

	output dataOut;
	reg [7:0] dataOut;

	input [7:0] dataIn;

	input [7:0] address;

	input writeEnable;

	reg [7:0] memorySpace [0:255];
		
	always@(posedge clk)
	begin
		if (writeEnable)
			memorySpace[address] <= dataIn;
		else
			dataOut <= memorySpace[address];

	end
	
endmodule