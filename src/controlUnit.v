module controlUnit
	( 
		
		bus1Select,
		bus2Select,
		
		flagRegisterLoad,
		flagRegisterIn,
		
		IRLoad,
		IRIn,
		
		memoryAccessRegisterLoad,
		
		counterLoad,
		counterIncrement,
		counterIncrement2,
		
		aLoad,
		bLoad,
		RAMWrite,
		
		aluOperationSelect,
		
		outputLoad,
		
		clk,
		rst
		
	); 
	
	output bus1Select;
	reg [1:0] bus1Select;
	
	output bus2Select;
	reg [1:0] bus2Select;
	
	output flagRegisterLoad;
	reg flagRegisterLoad;
	
	input [3:0] flagRegisterIn;
	
	output IRLoad;
	reg IRLoad;
	
	input [7:0] IRIn;
	//reg [7:0] IRIn = 8'b00000110; //used for testing
	
	output memoryAccessRegisterLoad;
	reg memoryAccessRegisterLoad;
	
	output counterLoad;
	reg counterLoad;
	
	output counterIncrement;
	reg counterIncrement;
	
	output counterIncrement2;
	reg counterIncrement2;
	
	output aLoad;
	reg aLoad;
	
	output bLoad;
	reg bLoad;
	
	output aluOperationSelect;
	reg [2:0] aluOperationSelect;
	
	output RAMWrite;
	reg RAMWrite;
	
	input clk;
	
	input rst;
	
	reg [7:0] currentState;
	reg [7:0] nextState;
	
	output outputLoad;
	reg [1:0] outputLoad;
	
	parameter //contains names for state machines that will handle machine instructions
	fetch0 = 0,
	fetch1 = 1,
	fetch2 = 2,
	
	decode0 = 3,
	
	loadAImm0 = 4,
	loadAImm1 = 5,
	loadAImm2 = 6,
	
	loadBImm0 = 7,
	loadBImm1 = 8,
	loadBImm2 = 9,
	
	loadADir0 = 10,
	loadADir1 = 11,
	loadADir2 = 12,
	loadADir3 = 13,
	loadADir4 = 14,
	
	loadBDir0 = 15,
	loadBDir1 = 16,
	loadBDir2 = 17,
	loadBDir3 = 18,
	loadBDir4 = 19,
	
	storeADir0 = 20,
	storeADir1 = 21,
	storeADir2 = 22,
	storeADir3 = 23,
	
	storeBDir0 = 24,
	storeBDir1 = 25,
	storeBDir2 = 26,
	storeBDir3 = 27,
	
	addAB0 = 28,
	
	subAB0 = 29,
	
	andAB0 = 30,
	
	orAB0 = 31,
	
	incA0 = 32,
	incB0 = 33,
	
	decA0 = 34,
	decB0 = 35,
	
	branchAlways0 = 36,
	branchAlways1 = 37,
	branchAlways2 = 38,
	
	branchIfTrue0 = 39,
	branchIfTrue1 = 40,
	branchIfTrue2 = 41,
	branchIfTrue3 = 42,
	
	outA0 = 43,
	outB0 = 44,
	resetOut0 = 45;
		
	always@(posedge clk or negedge rst)
	begin: stateDriver
		if(!rst)
			currentState <= fetch0;
		else
			currentState <= nextState;
	end 
	
	always@(currentState)
	begin: nextStateDriver
		case (currentState)
			fetch0: nextState = fetch1;
			fetch1: nextState = fetch2;
			fetch2: nextState = decode0;
			
			decode0: case(IRIn)
						8'b00000001: nextState = loadAImm0;
						8'b00000010: nextState = loadBImm0;
						8'b00000011: nextState = loadADir0;
						8'b00000100: nextState = loadBDir0;
						8'b00000101: nextState = storeADir0;
						8'b00000110: nextState = storeBDir0;
						8'b00000111: nextState = addAB0;
						8'b00001000: nextState = subAB0;
						8'b00001001: nextState = andAB0;
						8'b00001010: nextState = orAB0;
						8'b00001011: nextState = incA0;
						8'b00001100: nextState = incB0;
						8'b00001101: nextState = decA0;
						8'b00001110: nextState = decB0;
						8'b00001111: nextState = branchAlways0; 
						
						8'b00010000: if(flagRegisterIn[3] == 1)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00010001: if(flagRegisterIn[2] == 1)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00010010: if(flagRegisterIn[1] == 1)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00010011: if(flagRegisterIn[0] == 1)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00010100: if(flagRegisterIn[3] == 0)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00010101: if(flagRegisterIn[2] == 0)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00010110: if(flagRegisterIn[1] == 0)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00010111: if(flagRegisterIn[0] == 0)
												nextState = branchIfTrue0;
										 else
												nextState = branchIfTrue3;
												
						8'b00011000: nextState = outA0;
						8'b00011001: nextState = outB0;
						8'b00011010: nextState = resetOut0;


					endcase
						
			loadAImm0: nextState = loadAImm1;
			loadAImm1: nextState = loadAImm2;
			loadAImm2: nextState = fetch0;
			
			loadBImm0: nextState = loadBImm1;
			loadBImm1: nextState = loadBImm2;
			loadBImm2: nextState = fetch0;
			
			loadADir0: nextState = loadADir1;
			loadADir1: nextState = loadADir2;
			loadADir2: nextState = loadADir3;
			loadADir3: nextState = loadADir4;
			loadADir4: nextState = fetch0;

			loadBDir0: nextState = loadBDir1;
			loadBDir1: nextState = loadBDir2;
			loadBDir2: nextState = loadBDir3;
			loadBDir3: nextState = loadBDir4;
			loadBDir4: nextState = fetch0;
			
			storeADir0: nextState = storeADir1;
			storeADir1: nextState = storeADir2;
			storeADir2: nextState = storeADir3;
			storeADir3: nextState = fetch0;
			
			storeBDir0: nextState = storeBDir1;
			storeBDir1: nextState = storeBDir2;
			storeBDir2: nextState = storeBDir3;
			storeBDir3: nextState = fetch0;
			
			addAB0: nextState = fetch0;
			subAB0: nextState = fetch0;
			andAB0: nextState = fetch0;
			orAB0: nextState = fetch0;
			incA0: nextState = fetch0;
			incB0: nextState = fetch0;
			decA0: nextState = fetch0;
			decB0: nextState = fetch0;
			
			branchAlways0: nextState = branchAlways1;
			branchAlways1: nextState = branchAlways2;
			branchAlways2: nextState = fetch0;
			
			branchIfTrue0: nextState = branchIfTrue1;
			branchIfTrue1: nextState = branchIfTrue2;
			branchIfTrue2: nextState = fetch0;
			
			branchIfTrue3: nextState = fetch0;
			
			outA0: nextState = fetch0;
			outB0: nextState = fetch0;
			resetOut0: nextState = fetch0;
			
		endcase
	end
	
	always@(currentState)
	begin: stateLogic
		case (currentState)
		
			fetch0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			fetch1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b1;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			fetch2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b1;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			decode0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadAImm0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadAImm1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b1;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadAImm2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBImm0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBImm1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b1;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBImm2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b1;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadADir0: 
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadADir1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b1;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadADir2: 
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadADir3:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadADir4:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b10; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBDir0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBDir1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b1;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBDir2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBDir3:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			loadBDir4:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b10; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b1;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
				
			storeADir0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			storeADir1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b1;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			storeADir2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			storeADir3:
			begin
				bus1Select = 2'b01; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b1;
				outputLoad = 2'b00;
			end
			
			storeBDir0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			storeBDir1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b1;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			storeBDir2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			storeBDir3:
			begin
				bus1Select = 2'b10; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000;
				RAMWrite = 1'b1;
				outputLoad = 2'b00;
			end
			
			addAB0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			subAB0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0; 
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b001; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			andAB0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b010; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			orAB0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b011; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			incA0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b100; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			incB0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b1;
				aluOperationSelect = 3'b101; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			decA0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b1;
				bLoad = 1'b0;
				aluOperationSelect = 3'b110; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			decB0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b1;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b1;
				aluOperationSelect = 3'b111; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			branchAlways0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			branchAlways1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			branchAlways2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b1;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			branchIfTrue0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b01; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b1;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			branchIfTrue1:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			branchIfTrue2:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b11; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b1;
				counterIncrement = 1'b0; 
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			branchIfTrue3:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b1;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b00;
			end
			
			outA0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b01;
			end
			
			outB0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b10;
			end
			
			resetOut0:
			begin
				bus1Select = 2'b00; //00: PC, 01: A, 10: B
				bus2Select = 2'b00; //00: aluResult, 01: bus1, 10: RAM, 11: ROM
				flagRegisterLoad = 1'b0;
				IRLoad = 1'b0;
				memoryAccessRegisterLoad = 1'b0;
				counterLoad = 1'b0;
				counterIncrement = 1'b0;
				counterIncrement2 = 1'b0;
				aLoad = 1'b0;
				bLoad = 1'b0;
				aluOperationSelect = 3'b000; //000: add, 001: subtract, 010: AND, 011: OR, 100: inc op1, 101: inc op2, 110: dec op1, 111: dec op2
				RAMWrite = 1'b0;
				outputLoad = 2'b11;
			end
			
		endcase
	end
	
endmodule