module cpu
	(
		input wire clk, //change back etc
		input wire rst, //change back to inout if having issues
		output wire RAMWrite,
		output wire [7:0] address,
		input wire [7:0] fromRAM,
		input wire [7:0] fromROM,
		output wire [7:0] toRAM, 
		output wire [7:0] toOutput
	);
	
	wire [2:0] bus1Select;
	wire [2:0] bus2Select;
	wire flagRegisterLoad;
	wire IRLoad;
	wire aLoad;
	wire bLoad;
	wire [2:0] aluOperationSelect;
	wire memoryAccessRegisterLoad;
	wire counterLoad;
	wire counterIncrement;
	wire [7:0] IRBridge;
	wire [3:0] flagRegisterBridge;
	wire counterIncrement2;
	wire [1:0] outputLoad;
	
	dataPath d1 (
			.clk (clk),
			.rst (rst),
			.bus1Select (bus1Select),
			.bus2Select (bus2Select),
			.flagRegisterLoad (flagRegisterLoad),
			.IRLoad (IRLoad),
			.aLoad (aLoad),
			.bLoad (bLoad),
			.aluOperationSelect (aluOperationSelect),
			.memoryAccessRegisterLoad (memoryAccessRegisterload),
			.counterLoad (counterLoad),
			.counterIncrement (counterIncrement),
			.IROut (IRBridge),
			.flagRegisterOut (flagRegisterBridge),
			.toRAM (toRAM),
			.address (address),
			.fromROM (fromROM),
			.fromRAM (fromRAM),
			.counterIncrement2 (counterIncrement2),
			.outputLoad (outputLoad),
			.outputRegisterOut (toOutput)
		);
		
	controlUnit c1 (
			.clk (clk),
			.rst (rst),
			.bus1Select (bus1Select),
			.bus2Select (bus2Select),
			.flagRegisterLoad (flagRegisterLoad),
			.IRLoad (IRLoad),
			.aLoad (aLoad),
			.bLoad (bLoad),
			.aluOperationSelect (aluOperationSelect),
			.memoryAccessRegisterLoad (memoryAccessRegisterload),
			.counterLoad (counterLoad),
			.counterIncrement (counterIncrement),
			.IRIn (IRBridge),
			.flagRegisterIn (flagRegisterBridge),
			.RAMWrite (RAMWrite),
			.counterIncrement2 (counterIncrement2),
			.outputLoad (outputLoad)
		);
	
endmodule