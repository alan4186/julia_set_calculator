module iteratio_tester (clk, rst,done,sram_addr,sram_dq,ce_n,oe_n,we_n,ub_n,lb_n,startFlag,rCin,iCin);
input clk, rst;
input startFlag;
input [31:0] rCin,iCin;
reg [15:0] sram_dq_reg;
wire [15:0] pisoOut;
//wire [15:0] sram_dq_reg;
inout [15:0] sram_dq;
//output [15:0]sram_dq_reg;

output ce_n,oe_n,we_n,ub_n,lb_n;
output done;

//output [7:0] r_value, b_value;
output [19:0] sram_addr;
reg we_n;
wire ce_n,ub_n,lb_n,oe_n;
reg  done,shift;

wire [7:0] b_value0,b_value1,b_value2,b_value3,b_value4,b_value5,b_value6,b_value7,b_value8,b_value9,b_value10,b_value11,b_value12,b_value13,b_value14,b_value15,r_value0,r_value1,r_value2,r_value3,r_value4,r_value5,r_value6,r_value7,r_value8,r_value9,r_value10,r_value11,r_value12,r_value13,r_value14,r_value15;


reg [12:0] count;
reg [7:0] iterationCount;
reg [19:0] sram_addr;
reg[10:0] pixelcounter;
reg [31:0] 	rCoordinate0=32'hbf800000;
reg [31:0]		rCoordinate1,
					rCoordinate2,
					rCoordinate3,
					rCoordinate4,
					rCoordinate5,
					rCoordinate6,
					rCoordinate7,
					rCoordinate8,
					rCoordinate9,
					rCoordinate10,
					rCoordinate11,
					rCoordinate12,
					rCoordinate13,
					rCoordinate14,
					rCoordinate15;
reg[31:0]	iCoordinate=32'h3f800000;
//reg [31:0] rZin,iZin;




wire [7:0] color0;
reg first;

wire [31:0] rCin,iCin;
reg [31:0] rZin,iZin;
wire [31:0] rNextCoord0,rNextCoord1,rNextCoord2,rNextCoord3,rNextCoord4,rNextCoord5,rNextCoord6,rNextCoord7,rNextCoord8,rNextCoord9,rNextCoord10,rNextCoord11,rNextCoord12,rNextCoord13,rNextCoord14,rNextCoord15,iNextCoord;

//assign rZin=32'h38d1b717,//0.0001
//		 iZin=32'h38d1b717;
		  
//assign rZin=32'hbf800000,//-1
//	 iZin=32'h3f800000;//1
		 
		 //constant C value
//assign rCin=32'hbf4ccccd,//-0.8
//		 iCin=32'h3e1fbe77;//0.156
		 
assign ce_n=1'b0,//the chip is always selected
		 oe_n=1'b0,//the output is always enabled
		 ub_n=1'b0,//the upper byte [15:8] will be read/writed each read/write command
		 lb_n=1'b0;//the lower byte [7:0] will be read/writed each read/write command
		 

assign sram_dq = we_n ? 16'hzzzz:sram_dq_reg;

//assign overflow=overflow1|overflow2;


// calc nextCoord
//these will have the next coord 14 clks after count==0
altera_fp_add rCoord0(clk, rCoordinate0, 32'h3d000000, rNextCoord0);
altera_fp_add rCoord1(clk, rCoordinate1, 32'h3d000000, rNextCoord1);
altera_fp_add rCoord2(clk, rCoordinate2, 32'h3d000000, rNextCoord2);
altera_fp_add rCoord3(clk, rCoordinate3, 32'h3d000000, rNextCoord3);
altera_fp_add rCoord4(clk, rCoordinate4, 32'h3d000000, rNextCoord4);
altera_fp_add rCoord5(clk, rCoordinate5, 32'h3d000000, rNextCoord5);
altera_fp_add rCoord6(clk, rCoordinate6, 32'h3d000000, rNextCoord6);
altera_fp_add rCoord7(clk, rCoordinate7, 32'h3d000000, rNextCoord7);
altera_fp_add rCoord8(clk, rCoordinate8, 32'h3d000000, rNextCoord8);
altera_fp_add rCoord9(clk, rCoordinate9, 32'h3d000000, rNextCoord9);
altera_fp_add rCoord10(clk, rCoordinate10, 32'h3d000000, rNextCoord10);
altera_fp_add rCoord11(clk, rCoordinate11, 32'h3d000000, rNextCoord11);
altera_fp_add rCoord12(clk, rCoordinate12, 32'h3d000000, rNextCoord12);
altera_fp_add rCoord13(clk, rCoordinate13, 32'h3d000000, rNextCoord13);
altera_fp_add rCoord14(clk, rCoordinate14, 32'h3d000000, rNextCoord14);
altera_fp_add rCoord15(clk, rCoordinate15, 32'h3d000000, rNextCoord15);
altera_fp_add iCoord(clk, iCoordinate, 32'hbb000000, iNextCoord);		 


		 
// add aclr, on aclr: clear all, update inputs
//julia_iteration calc0(clk, rst,aclr, rZin, iZin, rCin, iCin, color0, first,count);

julia_iteration calc0(clk, rst,aclr, rCoordinate0, iCoordinate, rCin, iCin, r_value0, b_value0,count);
julia_iteration calc1(clk, rst,aclr, rCoordinate1, iCoordinate, rCin, iCin, r_value1, b_value1,count);
julia_iteration calc2(clk, rst,aclr, rCoordinate2, iCoordinate, rCin, iCin, r_value2, b_value2,count);
julia_iteration calc3(clk, rst,aclr, rCoordinate3, iCoordinate, rCin, iCin, r_value3, b_value3,count);
julia_iteration calc4(clk, rst,aclr, rCoordinate4, iCoordinate, rCin, iCin, r_value4, b_value4,count);
julia_iteration calc5(clk, rst,aclr, rCoordinate5, iCoordinate, rCin, iCin, r_value5, b_value5,count);
julia_iteration calc6(clk, rst,aclr, rCoordinate6, iCoordinate, rCin, iCin, r_value6, b_value6,count);
julia_iteration calc7(clk, rst,aclr, rCoordinate7, iCoordinate, rCin, iCin, r_value7, b_value7,count);
julia_iteration calc8(clk, rst,aclr, rCoordinate8, iCoordinate, rCin, iCin, r_value8, b_value8,count);
julia_iteration calc9(clk, rst,aclr, rCoordinate9, iCoordinate, rCin, iCin, r_value9, b_value9,count);
julia_iteration calc10(clk, rst,aclr, rCoordinate10, iCoordinate, rCin, iCin, r_value10, b_value10,count);
julia_iteration calc11(clk, rst,aclr, rCoordinate11, iCoordinate, rCin, iCin, r_value11, b_value11,count);
julia_iteration calc12(clk, rst,aclr, rCoordinate12, iCoordinate, rCin, iCin, r_value12, b_value12,count);
julia_iteration calc13(clk, rst,aclr, rCoordinate13, iCoordinate, rCin, iCin, r_value13, b_value13,count);
julia_iteration calc14(clk, rst,aclr, rCoordinate14, iCoordinate, rCin, iCin, r_value14, b_value14,count);
julia_iteration calc15(clk, rst,aclr, rCoordinate15, iCoordinate, rCin, iCin, r_value15, b_value15,count);


// incriment rZ, decrease iZ
//	32'h3acccccc, 32'hbb000000
// 32'd0.0015625, -0.001953125
always@(posedge clk or negedge rst)
begin 
	if(rst==1'b0)
		begin
					rCoordinate0<=32'hbf800000;//-1
					rCoordinate1<=32'hbf7f8000;
					rCoordinate2<=32'hbf7f0000;
					rCoordinate3<=32'hbf7e8000;
					rCoordinate4<=32'hbf7e0000;
					rCoordinate5<=32'hbf7d8000;
					rCoordinate6<=32'hbf7d0000;
					rCoordinate7<=32'hbf7c8000;
					rCoordinate8<=32'hbf7c0000;
					rCoordinate9<=32'hbf7b8000;
					rCoordinate10<=32'hbf7b0000;
					rCoordinate11<=32'hbf7a8000;
					rCoordinate12<=32'hbf7a0000;
					rCoordinate13<=32'hbf798000;
					rCoordinate14<=32'hbf790000;
					rCoordinate15<=32'hbf788000;

					iCoordinate<=32'h3f800000;//1
					pixelcounter<=11'd0;
					done<=1'b0;
					// at start set these to -1,1
					//rZin=32'hbf800000;//-1
					//iZin=32'h3f800000;//1
		end
	else
		begin
			// will need to update rCoord 1024 times then update icoord
			if(13'd8191&&pixelcounter>=11'd1024)
				begin
					done<=1'b1;
					pixelcounter<=11'd0;
					iCoordinate<=iNextCoord;

					// set r values to start of row
					rCoordinate0<=32'hbf800000;//-1
					rCoordinate1<=32'hbf7f8000;
					rCoordinate2<=32'hbf7f0000;
					rCoordinate3<=32'hbf7e8000;
					rCoordinate4<=32'hbf7e0000;
					rCoordinate5<=32'hbf7d8000;
					rCoordinate6<=32'hbf7d0000;
					rCoordinate7<=32'hbf7c8000;
					rCoordinate8<=32'hbf7c0000;
					rCoordinate9<=32'hbf7b8000;
					rCoordinate10<=32'hbf7b0000;
					rCoordinate11<=32'hbf7a8000;
					rCoordinate12<=32'hbf7a0000;
					rCoordinate13<=32'hbf798000;
					rCoordinate14<=32'hbf790000;
					rCoordinate15<=32'hbf788000;
					
				end
			else
				begin
				if(count==13'd8191)
					begin
						pixelcounter<=pixelcounter+11'd16;
						done<=1'b0;
						
						//update rcoord, by the time this happens, nextCoord will be correct value
						rCoordinate0<=rNextCoord0;
						rCoordinate1<=rNextCoord1;
						rCoordinate2<=rNextCoord2;
						rCoordinate3<=rNextCoord3;
						rCoordinate4<=rNextCoord4;
						rCoordinate5<=rNextCoord5;
						rCoordinate6<=rNextCoord6;
						rCoordinate7<=rNextCoord7;
						rCoordinate8<=rNextCoord8;
						rCoordinate9<=rNextCoord9;
						rCoordinate10<=rNextCoord10;
						rCoordinate11<=rNextCoord11;
						rCoordinate12<=rNextCoord12;
						rCoordinate13<=rNextCoord13;
						rCoordinate14<=rNextCoord14;
						rCoordinate15<=rNextCoord15;	
					end
				else
					begin
					//very first time
					if(first==1'b0 && count==13'd0)
						begin
							rCoordinate0<=32'hbf800000;//-1
							rCoordinate1<=32'hbf7f8000;
							rCoordinate2<=32'hbf7f0000;
							rCoordinate3<=32'hbf7e8000;
							rCoordinate4<=32'hbf7e0000;
							rCoordinate5<=32'hbf7d8000;
							rCoordinate6<=32'hbf7d0000;
							rCoordinate7<=32'hbf7c8000;
							rCoordinate8<=32'hbf7c0000;
							rCoordinate9<=32'hbf7b8000;
							rCoordinate10<=32'hbf7b0000;
							rCoordinate11<=32'hbf7a8000;
							rCoordinate12<=32'hbf7a0000;
							rCoordinate13<=32'hbf798000;
							rCoordinate14<=32'hbf790000;
							rCoordinate15<=32'hbf788000;
							iCoordinate<=32'h3f800000;//1
							// at start set these to -1,1
						end
					//else
					//	begin
						//	rCoordinate<=rCoordinate;
						//	iCoordinate<=iCoordinate;
							//rZin<=rZin;
							//iZin<=iZin;
					//	end
				end
		end
end
end

//assign sram_dq_reg=pisoOut;
always@(*)
begin
		sram_dq_reg<=pisoOut;
end
				//				shift
PiSo_8bit red(clk, rst, shift,r_value0,r_value1,r_value2,r_value3,r_value4,r_value5,r_value6,r_value7,r_value8,r_value9,r_value10,r_value11,r_value12,r_value13,r_value14,r_value15, pisoOut[15:8]);

PiSo_8bit blue(clk, rst, shift,b_value0,b_value1,b_value2,b_value3,b_value4,b_value5,b_value6,b_value7,b_value8,b_value9,b_value10,b_value11,b_value12,b_value13,b_value14,b_value15, pisoOut[7:0]);
/*
always@(posedge clk or negedge rst)
begin
	if (rst==1'b0)
		begin
			shift<=1'b0;
			we_n<=1'b0;
			sram_addr<=20'h00000;
		end
	else	
		begin
			//shift values, only shift 16 times then shift=0
			shift<=1'b1;
			//write 16 times to sram
			if(first==1'b1 && count==13'd8191)
				begin
					//write data
					sram_dq_reg<={r_value0,b_value0};
					//incriment addr
					sram_addr<=sram_addr+20'd1;	
					if( sram_addr==20'hfffff)//changed from 20'hfffff
						we_n<=1'b1;//end writing after every addr has been writen to
				end
			else
				begin
					// with shift 0 piso out stays last value
					// this allows the we_n to stay activated all the time
					shift<=1'b0;
				end
		end
end
*/

 
//use count to write values to PISO
always@(posedge clk or negedge rst)
begin
	if (rst==1'b0)
		begin
			shift<=1'b0;
			we_n<=1'b0;
			sram_addr<=20'h00000;
		end
	else	
		begin
			//shift values, only shift 16 times then shift=0
			//shift<=1'b1;
			//write 16 times to sram
			//if(first==1'b1 && count[4:0]==5'b00000)
			//if(first==1'b1&&count<13'd16)
			if(first==1'b1&&count<13'd16)
				begin
					// shift piso
					shift<=1'b1;
					//incriment addr
					//sram_addr<=sram_addr+20'd1;	
					//if( sram_addr==20'hfffff)
					//	we_n<=1'b1;//end writing after every addr has been writen to
				end
			else
				begin
					// with shift 0 piso out stays last value
					// this allows the we_n to stay activated all the time
					shift<=1'b0;
				end
			if(first==1'b1&&count<13'd17&&count>13'd0)
				begin
				sram_addr<=sram_addr+20'd1;	
				if( sram_addr==20'hfffff)
						we_n<=1'b1;//end writing after every addr has been writen to
				end
		end
end//always

/*
// counter
always@(posedge clk or negedge rst)
begin 
	if (rst==1'b0)
		begin
		count<=14'd0;
		first<=1'b0;
		end
	else
		//if(we_n==1'b0)
		begin
		if(count==14'd12544)
			begin
			count<=14'd0;
			first<=1'b1;
			end
		else
			count<=count+14'd1;
		end
end
*/

// counter
always@(posedge clk or negedge rst)
begin 
	if (rst==1'b0)
		begin
		count<=13'd0;
		first<=1'b0;
		end
	else
		if(startFlag==1'b1)
			begin
				if(count==13'd8191)//13 bit max
					begin
						count<=13'd0;
						first<=1'b1;
					end
				else
					begin
						count<=count+13'd1;
					end
			end
end


endmodule
