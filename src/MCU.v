module MCU 
	(
		input clk,
		input rst,
		output wire [7:0] dataOutput
	);
	
	wire [7:0] address;
	wire [7:0] fromROM;
	wire [7:0] fromRAM;
	wire [7:0] toRAM;
	wire RAMWrite;
	
	cpu cpu0 (
		.clk (clk),
		.rst (rst),
		.address (address),
		.fromROM (fromROM),
		.fromRAM (fromRAM),
		.toRAM (toRAM),
		.RAMWrite (RAMWrite),
		.toOutput (dataOutput)
	);
	
	memoryRAM ram0 (
		.clk (clk),
		.address (address),
		.dataOut (fromRAM),
		.dataIn (toRAM),
		.writeEnable (RAMWrite)
	);
	
	memoryROM rom0 (
		.clk (clk),
		.address (address),
		.programMemoryOutput (fromROM)
	);

endmodule