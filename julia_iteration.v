module julia_iteration(clk, rst, aclr, rZin, iZin, rCin, iCin, red_out, blue_out,  count);
input clk, rst;
input aclr;
input [31:0] rZin, iZin, rCin, iCin;


//output first;
output [7:0] red_out, blue_out;
input [12:0] count;
reg first;
//reg [13:0] count;//14
reg[7:0] r_value, b_value, red_out,blue_out;
reg[31:0] rZ, iZ;
//reg [31:0] rResult, iResult;

reg temp;
wire [31:0] rfinal, ifinal;
wire [31:0] rC, iC;
wire overflow;

assign rC=rCin,
		 iC=iCin;
		 
parameter NUMCYCLES=5'd31;
			 //NUMCYCLESm1=14'd48;

julia_algorithm algorithm0(clk, rst,aclr, rZ, iZ, rC, iC,rfinal, ifinal, overflow);

always@(posedge clk or negedge rst)
begin
	if (rst ==1'b0)
		begin
			rZ<=rZin;
			iZ<=iZin;
		end
	else
	if(first==1'b0)
		begin
			rZ<=rZin;
			iZ<=iZin;
		end
	else
		if (count[4:0]==NUMCYCLES)
			begin
				rZ<=rfinal;
				iZ<=ifinal;
			end
end
/*
//temp for finals
always@(posedge clk )
begin
		if(rfinal==ifinal)
			temp<=1'b1;
		else
			temp<=1'b0;
			
end
*/
//moved counting up a module
// counter
always@(posedge clk or negedge rst)
begin 
	if (rst==1'b0)
		begin
		first<=1'b0;
		end
	else
		begin
		if(count<NUMCYCLES)
			begin
			first<=1'b0;
			end
		else
			first<=1'b1;
		end
end

/*
// done
always@(posedge clk or negedge rst)
begin 
	if (rst==1'b0)
		begin
		done<=1'b0;
		end
	else
		begin
		if (totalcalculated>=32'd1310720)
			done<=1'b1;
		else
			done<=1'b0;
		end
end
*/
// color
always@(posedge clk or negedge rst)
begin 
	if (rst==1'b0)
		begin
		red_out<=8'hff;
		blue_out<=8'h00;
		end
	else
		begin
				// if exp >32 magnitude >1000 ish
				// will create blue fractal on R|B background				//changed from 12544
			if ( (rfinal[30:23]<=8'h9b || ifinal[30:23]<=8'h9b)&&count<13'd8190)
				begin
				red_out<=r_value;
				blue_out<=b_value;
				end
			else																				//changed from ==12544
				if ( (rfinal[30:23]<=8'h9b || ifinal[30:23]<=8'h9b)&&count >=13'd8190)
					begin
					red_out<=8'h00;
					blue_out<=8'h00;
					end
		end
end



// rb scale

always@ (posedge clk or negedge rst)
begin 
	if(rst==1'b0)
		begin
		r_value<=8'hff;
		b_value<=8'h00;
		end
	else
		begin
		if(count<14'd4096)
			begin
			r_value<=8'hff;
			b_value<=count[11:4];
			//b_value<=count[12:5];//will probably need to change to 8msb of count less than 6272
			//b_value<={iterationcount[6:0],1'b1};
			end
		else
			begin
			b_value<=8'hff;
			r_value<=~count[11:4];
			//r_value<=~count[12:5];
			//r_value<=~{iterationcount[6:0],1'b0};
			end
		end
end


endmodule





































/*
module julia_iteration(clk, rst, rZ, iZ, rC, iC, color, done);

input clk, rst;

input [31:0] rZ, iZ, rC, iC;

output [7:0] color;
output done;

reg done, aclr;
reg [7:0] color;
reg [31:0] count;
reg [31:0] rZhold, iZhold;

wire [31:0] rresult, iresult;
julia_algorithm(clk, rst, rZhold, iZhold, rC, iC, rresult, iresult, overflow);

always@(posedge clk or negedge rst)
begin
	if (rst==1'b0)
		count<=32'd0;
	else
			begin
			//update holds
			if (count==32'd0)
				begin
				rZhold<=rZ;
				iZhold<=iZ;
				end
			else
				if (count[5:0]==6'b100000)
					begin
						rZhold<=rresult;
						iZhold<=iresult;
					end
			// set done flag, set color bits
			if (count[12:0]==13'b1000000000000)
				begin
					// clear fp modules
					aclr<=1'b1;
					// set done flag
					done<=1'b1;
					//reset count
					count<=32'd0;
				end
			else
				begin
					aclr<=1'b0;
					done<=1'b0;
					count<=count+32'd1;
				end
			// set colors
			if (overflow==1'b1)
				color<=8'hff;
			end

end



endmodule
*/