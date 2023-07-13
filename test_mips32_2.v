`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:35:39 07/05/2023
// Design Name:   pipe_MIPS32
// Module Name:   /home/dcodelab/Desktop/Verilog project/MIPS32/test_mips32_2.v
// Project Name:  MIPS32
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipe_MIPS32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mips32_2;

	// Inputs
	reg clk1;
	reg clk2;
	integer k;

	// Instantiate the Unit Under Test (UUT)
	pipe_MIPS32 uut (
		.clk1(clk1), 
		.clk2(clk2)
	);

	initial begin
		// Initialize Inputs
		clk1 = 0;
		clk2 = 0;

		// Wait 100 ns for global reset to finish
		
		//#100;
        
		// Add stimulus here
		repeat (100)   // generating two phase clock
		begin
		#5 clk1 = 1; #5 clk1 = 0;
		#5 clk2 = 1; #5 clk2 = 0;
		end
	end
	
	initial begin
       for(k=0;k<31;k=k+1)
           uut.Reg[k]=k;

		 uut.Mem[200]=7;  //find factorial of 7
		 
		 uut.pc = 0;
		 uut.HALTED = 0;
		 uut.TAKEN_BRANCH = 0;

       uut.Mem[0] = 32'h280a00c8; //ADDI R10, R0, 200
       uut.Mem[1] = 32'h28020001; //ADDI R2, R0, 1
       uut.Mem[2] = 32'h0e94a000; //OR R20, R20, R20 ---dummy instruction
       uut.Mem[3] = 32'h21430000; //LW R3, 0(R10)
		 uut.Mem[4] = 32'h0e94a000; //OR R20, R20, R20 ---dummy instruction
       uut.Mem[5] = 32'h14431000; //Loop: MUL R2, R2, R3
		 uut.Mem[6] = 32'h2c630001; //SUBI R3, R3, 1
		 uut.Mem[7] = 32'h0e94a000; //OR R20, R20, R20  ---dummy instruction
		 uut.Mem[8] = 32'h3460fffc; //BNEQZ R3, Loop (i.e. -4 offset)
		 uut.Mem[9] = 32'h2542fffe; //SW R2, -2(R10)
		 uut.Mem[10] = 32'hfc000000; //halt
		 

		 #2000 $display("Mem[200] = %2d, Mem[198] = %6d", uut.Mem[200], uut.Mem[198]);
		 end
		 
		 initial begin
		 $monitor ("R2: %4d", uut.Reg[2]);
		 //#3000 $finish;
		 end
      
endmodule

