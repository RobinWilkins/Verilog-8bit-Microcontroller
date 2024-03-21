module memoryROM
	(
		clk,
		programMemoryOutput,
		address
	);

	input clk; 
	
	output programMemoryOutput;
	reg [7:0] programMemoryOutput;
	
	input [7:0] address;

	reg [7:0] memorySpace [0:255];

initial begin
//	memorySpace[0] = 8'h01; //load a rom
//	memorySpace[1] = 8'h05; //value 5 for load
//	
//	memorySpace[2] = 8'h0B; //inc a
//	memorySpace[3] = 8'h0B; //inc a
//	memorySpace[4] = 8'h0B; //inc a
//	memorySpace[5] = 8'h0B; //inc a
//	memorySpace[6] = 8'h0B; //inc a
//	memorySpace[7] = 8'h0B; //inc a
//	
//	memorySpace[8] = 8'h05; //store a to ram
//	memorySpace[9] = 8'h05; //ram address 5
//	
//	memorySpace[10] = 8'h05; //store a to ram
//	memorySpace[11] = 8'h06; //ram address 6
//	
//	memorySpace[12] = 8'h05; //store a to ram
//	memorySpace[13] = 8'h07; //ram address 7
//	
//	memorySpace[14] = 8'h05; //store a to ram
//	memorySpace[15] = 8'h08; //ram address 8
//	
//	memorySpace[16] = 8'h05; //store a to ram
//	memorySpace[17] = 8'h09; //ram address 9
//	
//	memorySpace[18] = 8'h05; //store a to ram
//	memorySpace[19] = 8'h0A; //ram address 10
//	
//	memorySpace[20] = 8'h04; //load b from ram
//	memorySpace[21] = 8'h09; //ram address 9

//	memorySpace[0] = 8'h01;
//	memorySpace[1] = 8'b01111100;
//	
//	memorySpace[2] = 8'h0B;
//	
//	memorySpace[3] = 8'h14;
//	memorySpace[4] = 8'h02;
//	
//	memorySpace[5] = 8'h02;
//	memorySpace[6] = 8'b00000001;
//	

	memorySpace[0] = 8'h01;
	memorySpace[1] = 8'b10101010;
	memorySpace[2] = 8'h18;
	
	memorySpace[3] = 8'h0B;
	memorySpace[4] = 8'h0B;
	memorySpace[5] = 8'h0B;
	
	memorySpace[6] = 8'h18;
	
	memorySpace[7] = 8'h02;
	memorySpace[8] = 8'b00001111;
	
	memorySpace[9] = 8'h19;
	
	memorySpace[10] = 8'h0C;
	memorySpace[11] = 8'h0C;
	memorySpace[12] = 8'h0C;
	
	memorySpace[13] = 8'h19;
	
	memorySpace[14] = 8'h1A;
	
	memorySpace[15] = 8'h18;
	memorySpace[16] = 8'h19;
	
end
	
always@(posedge clk)
begin
	programMemoryOutput <= memorySpace[address];
end
	
endmodule