module julia_algorithm(clk, rst,aclr, rZin, iZin, rCin, iCin, rfinal, ifinal,overflow);
input clk, rst;
input aclr;
input [31:0] rZin, iZin, rCin, iCin;
output [31:0] rfinal, ifinal;
output overflow;

reg  notfirst;
reg[5:0] aclrcounter;
wire [31:0] rZ, iZ;
wire [31:0] rC, iC;
//wire [31:0] rZ, iZ, rC, iC;
wire [31:0] rresult, iresult;


wire [31:0] rr,ri,ir,ii;
//wire overflow1,overflow2,overflow3,overflow4,overflow5,overflow6,overflow7,overflow8;


//assign overflow = overflow1||overflow2||overflow3||overflow4||overflow5||overflow6||overflow7||overflow8;
assign rC=rCin;
assign iC=iCin;
assign rZ=rZin;
assign iZ=iZin;
////////////////////////////////////////////
//altera_fp_add (clock,dataa,datab,overflow,result);
//altera_fp_mult (clock,dataa,datab,overflow,result);
///////////////////////////////////////////////////

//square complex number
altera_fp_mult RR( aclr,clk,rZ,rZ,overflow1,rr);
altera_fp_mult RI( aclr,clk,rZ,iZ,overflow2,ri);
altera_fp_mult IR( aclr,clk,iZ,rZ,overflow3,ir);
altera_fp_mult II( aclr,clk,iZ,iZ,overflow4,ii);

altera_fp_add RRplusII(clk, rr, {!ii[31], ii[30:0]},rresult);//invert sign because of i^2
altera_fp_add RIplusIR(clk, ri, ir,iresult);
//end square

// add constant
altera_fp_add rZplusC (clk, rresult, rC, rfinal);
altera_fp_add iZplusC (clk, iresult, iC, ifinal);
//end


parameter NUMCYCLES=5'd31;
/*
// set aclr signals
always@(posedge clk or negedge rst)
begin
	if(rst==1'b0)
		aclrcounter<=1'b0;
	else
		begin
		// clear when calcs done
		if (aclrcounter==NUMCYCLES)
			begin
			//clear modules
			aclr<=1'b1;
			//reset counter
			aclrcounter<=6'd0;
			// store result
			rZ<=rfinal;
			iZ<=ifinal;
			notfirst<=1'b1;
			end
		else
			begin
				if(notfirst==1'b0)
					begin
					rZ<=rZin;
					iZ<=iZin;
					end
				aclr<=1'b1;
				aclrcounter<=aclrcounter+1;
			end
		end
end
*/
/*
always@(posedge clk or negedge rst)
begin
	if(rst==1'b0)
		notfirst<=1'b0;
	else
		if(notfirst==1'b0)
			begin
				rZ<=rZin;
				iZ<=iZin;
			end
end
*/
/*
// set inputs to fp modules
always@(posedge clk or negedge rst)
begin
	if(rst==1'b0)
		incounter<=1'b0;
	else
		begin
		incounter<=incounter+1;
		// mult inputs
		if(incounter<11)
			begin 
				//mult inputs = initial values
				rZ <=rZin;
				iZ <=iZin;
				rC	<=rCin;
				iC <=iCin;
			end
		else
			begin
				//mult inputs = results
				
			end
		end
	*/
endmodule

