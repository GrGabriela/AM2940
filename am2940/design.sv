// Code your design here


//registre pe 8 biti pe care le folosesc si pentru registrul
//de adresa si pentru cel de cuvinte
module reg8(di,dout,clk,pl);
  input [7:0] di;
  input clk,pl;
  output reg [7:0] dout;
  always @(posedge clk)
    if(pl==1)
      dout<=di;
endmodule


//registrul de control

module ctrl_reg(di,dout,clk,plcr);
  input [2:0] di;
  input clk,plcr;
  output reg [2:0] dout;
  
  always @(posedge clk)
    if(plcr==1)
      dout<=di;
  
endmodule


//multiplexor 1_2 folosit pentru ambele multiplexoare
module mux(di0,di1,dout,sel);
  
  input [7:0] di0,di1;
  input sel;
  output reg [7:0] dout;
  
  always @(di0 or di1 or sel)
    case(sel)
      1'b0:dout=di0;
      1'b1:dout=di1;
    endcase
  
endmodule


//multiplexor 1_3
module data_mux(di0,di1,di2,dout,seld);
  
  input [7:0] di0,di1;
  input [2:0] di2;
  input [1:0] seld;
  output reg [7:0] dout;
  
  always @(di0 or di1 or di2 or seld)
    begin
    casex(seld)
      2'b00:dout<=di0;
      2'b01:dout<=di1;
      2'b1x:dout<={5'b11111,di2};
      
    endcase
    end
  
endmodule

//numarator-la numaratorul de adresa punem resetul pe 0

module cnt(clk,reset,pl,enable,inc,dec,CIn,COn,in,out);
  input clk,reset,pl,enable,inc,dec,CIn;
  input [7:0] in;
  output reg [7:0] out;
  output COn;
  
  reg [7:0] do_next;
  wire co_inc,co_dec;
  
  always @(posedge clk)
    if(reset==1)
      out<=8'b0;
    else
      out<=do_next;
  always @(pl or enable or inc or dec or in or out or CIn)
    casex({pl,enable,inc,dec,CIn})
      5'b1xxxx:do_next=in;
      5'b0xxx1,5'b00xxx,5'b01000:do_next=out;
      5'b011x0:do_next=out+1;
      5'b01010:do_next=out-1;
      default: do_next=out;
    endcase
  
  assign co_inc=(out===8'hff) & enable &inc & (~CIn);
  assign co_dec=(out===8'b0) & enable & dec & (~CIn);
  assign COn=~(co_inc | co_dec);
endmodule
    


module done_gen(dowc,dowr,doac,cinw,mode,done);
  
  input [7:0] dowc,dowr,doac;
  input [1:0] mode;
  input cinw;
  output reg done;
  
  always @(dowc or dowr or doac or cinw or mode)
    begin
		casex ({ mode, cinw})
        3'b00_0: done=(dowc===8'b1);
		3'b00_1: done=~(|dowc);
		3'b01_0: done=(dowc+1===dowr);
		3'b01_1:done=(dowc===dowr);
		3'b10_x: done=(dowc===doac);
		3'b11_x:done=1'b0;
	endcase
    end
endmodule


module instruction_decoder(i,cr,plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata);
  
  input [2:0] i,cr;
  output reg plar,plwr,sela,selw,plcr,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata;
  output reg [1:0] seld;
  
  
  always @(i or cr)
    casex({i,cr})
      6'b000_xxx:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00001000000000000; //0-incarcarea registrului de control
      6'b001_xxx:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000100000000001; //1-citim registrul de control
      6'b010_xxx:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000010000000001; //2-citim registrul de cuvinte
      6'b011_xxx:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000000000000001; //3-citim registrul de adrese
      6'b100_xx0,6'b100_x11:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00110001000010000; //4-reinitializarea numaratoarelor
      6'b100_001:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00100001000100000;
      6'b101_xxx:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b10000001000000000; //5-datain se incarca in registrul de adrese
      6'b110_xx0,6'b110_x11:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b01000000000010000; //6-datain se incarca in registrul de cuvinte
      6'b110_x01:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b01000000000100000;
      6'b111_000:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000000110001010; //7->0 se inc num de adrese si se dec num de cuvinte
      6'b111_0x1:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000000110001100; //7->1,3 se inc num de adrese,se inc num de cuvinte
      6'b111_010:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000000110000000; //7->2 se inc num de adrese,iar num de cuvinte->hold
      6'b111_100:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000000101001010; //7->... asemanatoare doar ca num de adrese de dec
      6'b111_1x1:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000000101001100;
      6'b111_110:{plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}=17'b00000000101000000;
    endcase
endmodule
      


module am2940(clk,instr,address,datain,dataout,oedata,cina,cona,cinw,conw,done);
  
  //semnalele generale de input si output
  input clk;
  input [2:0] instr;
  output [7:0] address;
  input [7:0] datain;
  output [7:0] dataout;
  output oedata;
  input cina,cinw;
  output cona,conw;
  output done;
  
  
  //semnalele din interior
  
  wire [7:0] doar; //semnalul ce iese din registrul de adrese
  wire [7:0] dowr; //semnalul din registrul de cuvinte
  wire [2:0] docr; //semnalul din registrul de control
  
  wire [7:0] diac; //semnalul ce iese din mux si intra in addr counter
  wire [7:0] diwc; //semnalul ce iese din mux si intra in word counter
  wire [1:0] seld;
  wire [7:0] dowc;
  
  //semnalele ce tin de blocuri
  
  wire plar;
  wire plwr;
  wire sela;
  wire selw;
  wire plcr;
  wire plac;
  wire ena;
  wire inca;
  wire deca;
  wire resw;
  wire plwc;
  wire enw;
  wire incw;
  wire decw;
  
  //instantiem blocurile
  
  reg8 addr_reg(.di(datain),.dout(doar),.clk(clk),.pl(plar));
  
  reg8 word_reg(.di(datain),.dout(dowr),.clk(clk),.pl(plwr));
  
  ctrl_reg ctrl(.di(datain[2:0]),.dout(docr),.clk(clk),.plcr(plcr));
  
  mux addr_mux(.di0(datain),.di1(doar),.dout(diac),.sel(sela));
  
  mux w_mux(.di0(datain),.di1(dowr),.dout(diwc),.sel(selw));
  
  data_mux data(.di0(address),.di1(dowc),.di2(docr),.dout(dataout),.seld(seld));
  
  cnt addr_cnt(.clk(clk),.reset(1'b0),.pl(plac),.enable(ena),.inc(inca),.dec(deca),.CIn(cina),.COn(cona),.in(diac),.out(address));
  
  cnt w_cnt(.clk(clk),.reset(resw),.pl(plwc),.enable(enw),.inc(incw),.dec(decw),.CIn(cinw),.COn(conw),.in(diwc),.out(dowc));
  
  done_gen done_gen_inst(.dowc(dowc),.dowr(dowr),.doac(address),.cinw(cinw),.mode(docr[1:0]),.done(done));
  
  instruction_decoder dec_inst(.i(instr),.cr(docr),.plar(plar),.plwr(plwr),.sela(sela),.selw(selw),.plcr(plcr),.seld(seld),.plac(plac),.ena(ena),.inca(inca),.deca(deca),.resw(resw),.plwc(plwc),.enw(enw),.incw(incw),.decw(decw),.oedata(oedata));
  
endmodule