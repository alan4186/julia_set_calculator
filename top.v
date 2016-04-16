module top (clk, rst,VGA_R, VGA_G, VGA_B,VGA_HS, VGA_VS,VGA_CLK,VGA_SYNC, VGA_BLANK,sram_addrF,sram_dqF, ce_n,oe_n,we_n,ub_n,lb_n,ledwe, select, data,state);
input clk, rst;
input select;//switch to enter C value 
input [15:0] data;//switches to set C values

//input/output sram data bus
inout [15:0] sram_dqF;

//meune state
output [2:0] state;
// sram output pins
output ce_n,oe_n,we_n,ub_n,lb_n,ledwe;
//vga output pins
output VGA_BLANK, VGA_SYNC, VGA_CLK, VGA_HS, VGA_VS;
//vga color data
output [7:0] VGA_R, VGA_G, VGA_B;
//sram address signal
output [19:0] sram_addrF;


//sram wires/regs
wire [15:0] sram_dqW;
wire [19:0] sram_addrW,sram_addrR;
reg [15:0]sram_dq_reg;

//menu wires/regs
wire [2:0] state;
wire startFlag;
wire [31:0] rC,iC;
wire select_clean;
wire[15:0] data_clean;



//108MHz plls
wire clk108;
pll108 clkmain(clk, clk108);
pll108 vga(clk, VGA_CLK);

// if writing to sram use the sram()module address, else use the vga_sram() moudule address
assign sram_addrF= we_n ? sram_addrR:sram_addrW;
// if reading sram set sram_dqF to high impedance mode
assign sram_dqF= we_n ? 16'hzzzz:sram_dqW;



//writes a black to red scale to sram 1024bits long
//sram(clk108, rst,sram_addrW,sram_dqW, ce_n,oe_n,we_n,ub_n,lb_n);


assign ledwe=we_n ;
//julia calculator with shifts
iteratio_tester tester0(clk108, rst,done,sram_addrW,sram_dqW,ce_n,oe_n,we_n,ub_n,lb_n,startFlag,rC,iC);
								//clk108



//reads sram and displays on vga monitor
// uses 1280x1024 but sram can only hold data for 2 colors (16bits) at 1024x1024 
//displays a black to red scale on monitor
vga_sram vga0(clk108,rst,VGA_R, VGA_G, VGA_B,VGA_HS, VGA_VS,VGA_SYNC, VGA_BLANK,sram_addrR,sram_dqF,we_n);


// menu to input C values
menu menu1(clk108, rst, select_clean, data_clean, rC, iC, startFlag,state);

debounce sw17(clk, select,select_clean);

debounce sw15(clk, data[15],data_clean[15]);
debounce sw14(clk, data[14],data_clean[14]);
debounce sw13(clk, data[13],data_clean[13]);
debounce sw12(clk, data[12],data_clean[12]);
debounce sw11(clk, data[11],data_clean[11]);
debounce sw10(clk, data[10],data_clean[10]);
debounce sw9(clk, data[9],data_clean[9]);
debounce sw8(clk, data[8],data_clean[8]);
debounce sw7(clk, data[7],data_clean[7]);
debounce sw6(clk, data[6],data_clean[6]);
debounce sw5(clk, data[5],data_clean[5]);
debounce sw4(clk, data[4],data_clean[4]);
debounce sw3(clk, data[3],data_clean[3]);
debounce sw2(clk, data[2],data_clean[2]);
debounce sw1(clk, data[1],data_clean[1]);
debounce sw0(clk, data[0],data_clean[0]);



endmodule
