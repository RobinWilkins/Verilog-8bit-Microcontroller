module dataPath
	( 
		output reg [7:0] address,
		output reg [7:0] toRAM,
		input wire [7:0] fromRAM,
		input wire [7:0] fromROM,
		
		input wire [1:0] bus1Select, 
		input wire [1:0] bus2Select, 
		
		input wire flagRegisterLoad, 
		output wire [3:0] flagRegisterOut,
		
		input wire IRLoad,
		output wire [7:0] IROut,
		
		input wire memoryAccessRegisterLoad, 
		
		input wire counterLoad, 
		input wire counterIncrement, 
		input wire counterIncrement2,
		
		input wire aLoad, 
		input wire bLoad, 
		
		input wire [2:0] aluOperationSelect, 
		inout wire [7:0] aluResultDP,
		
		inout wire [3:0] NZVCflags, 
		
		input wire clk, 
		input wire rst,
		
		output wire [7:0] outputRegisterOut,
		
		input wire [1:0] outputLoad //00: do nothing, 01: latch A, 10: latch B, 11: reset
		
	); 
	
	reg [7:0] IRRegister;
	reg [7:0] memoryAccessRegister;
	reg [7:0] programCounter;
	reg [7:0] scratchA;
	reg [7:0] scratchB;
	reg [3:0] flagRegister;
	reg [7:0] bus1;
	reg [7:0] bus2;
	reg [7:0] outputRegister;
	
	ALUmodule d0 (.operand1 (scratchA),
				.operand2 (scratchB),
				.operationSelect (aluOperationSelect[2:0]),
				.aluResult (aluResultDP[7:0]),
				.NZVCflags (NZVCflags));
		
	always@(bus1Select, programCounter, scratchA, scratchB)
	begin: bus1Multiplexer
		case (bus1Select)
			2'b00: bus1 = programCounter;
			2'b01: bus1 = scratchA;
			2'b10: bus1 = scratchB;
			default: bus1 = 8'b11111111;
		endcase
	end
	
	always@(bus2Select, bus1, fromRAM, fromROM, aluResultDP)
	begin: bus2Multiplexer
		case (bus2Select)
			2'b00: bus2 = aluResultDP;	
			2'b01: bus2 = bus1;
			2'b10: bus2 = fromRAM;
			2'b11: bus2 = fromROM;
			default: bus2 = 8'b11111111;
		endcase
	end
	
	always@(bus1, memoryAccessRegister)
	begin
		toRAM = bus1;
		address = memoryAccessRegister;
	end
	
	always@(posedge clk, negedge rst)
	begin: IRegisterModule
		if(!rst)
			IRRegister <= 8'b00000000;
		else if(IRLoad)
			IRRegister <= bus2;
	end
	
	always@(posedge clk, negedge rst)
	begin: memoryRegisterModule
		if(!rst)
			memoryAccessRegister <= 8'b00000000;
		else if(memoryAccessRegisterLoad)
			memoryAccessRegister <= bus2;
	end
	
	
	always@(posedge clk, negedge rst)
	begin: programCounterModule
		if(!rst)
			programCounter <= 8'b00000000;
		else if(counterLoad)
			programCounter <= bus2;
		else if(counterIncrement)
			programCounter <= memoryAccessRegister + 1'b1;
		else if(counterIncrement2)
			programCounter <= memoryAccessRegister + 2'b10;
	end
	
	always@(posedge clk, negedge rst)
	begin: scratchAModule
		if(!rst)
			scratchA <= 8'b00000000;
		else if(aLoad)
			scratchA <= bus2;
	end
	
	always@(posedge clk, negedge rst)
	begin: scratchBModule
		if(!rst)
			scratchB <= 8'b00000000;
		else if(bLoad)
			scratchB <= bus2;
	end
	
	always@(posedge clk, negedge rst)
	begin: flagRegisterModule
		if(!rst)
			flagRegister <= 4'b0000;
		else if(flagRegisterLoad)
			flagRegister <= NZVCflags;
	end
	
	always@(posedge clk, negedge rst)
	begin: outputModule
		if(!rst)
			outputRegister <= 8'b00000000;
		else if(outputLoad == 2'b01)
			outputRegister <= scratchA;
		else if(outputLoad == 2'b10)
			outputRegister <= scratchB;
		else if(outputLoad == 2'b11)
			outputRegister <= 8'b00000000;
	end
	
	assign flagRegisterOut = flagRegister;
	assign IROut = IRRegister;
	assign outputRegisterOut = outputRegister;
	
endmodule