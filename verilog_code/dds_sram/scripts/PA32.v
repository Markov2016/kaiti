module PA32(clk,reset,init,fcw,phase);
  input clk,reset;
  input [31:0] fcw;
  input [31:0] init;
  output [15:0] phase;
  
  wire [6:0] carry;
  wire [3:0] temp_out [0:7];
  wire [3:0] temp_pre [0:27];
  wire [3:0] temp_pos [0:2];
  wire [7:0] temp_carry;

  assign phase[15:12] = temp_out[7];
  
  // 0:3 PA
  PA4 P0(clk,reset,init[3:0],fcw[3:0],1'b0,temp_out[0],temp_carry[0]);
  D_trigger1 tc0(clk,reset,temp_carry[0],carry[0]);
  
  //4:7 PA
  D_trigger4 tpre10(clk,reset,fcw[7:4],temp_pre[0]);
  PA4 P1(clk,reset,init[7:4],temp_pre[0],carry[0],temp_out[1],temp_carry[1]);
  D_trigger1 tc1(clk,reset,temp_carry[1],carry[1]);
  
  //8:11 PA
  D_trigger4 tpre20(clk,reset,fcw[11:8],temp_pre[1]);
  D_trigger4 tpre21(clk,reset,temp_pre[1],temp_pre[2]);
  PA4 P2(clk,reset,init[11:8],temp_pre[2],carry[1],temp_out[2],temp_carry[2]);
  D_trigger1 tc2(clk,reset,temp_carry[2],carry[2]);
  
  //12:15 PA
  D_trigger4 tpre30(clk,reset,fcw[15:12],temp_pre[3]);
  D_trigger4 tpre31(clk,reset,temp_pre[3],temp_pre[4]);
  D_trigger4 tpre32(clk,reset,temp_pre[4],temp_pre[5]);
  PA4 P3(clk,reset,init[15:12],temp_pre[8],carry[2],temp_out[3],temp_carry[3]);
  D_trigger1 tc3(clk,reset,temp_carry[3],carry[3]);

  //16:19 PA
  D_trigger4 tpre40(clk,reset,fcw[19:16],temp_pre[6]);
  D_trigger4 tpre41(clk,reset,temp_pre[6],temp_pre[7]);
  D_trigger4 tpre42(clk,reset,temp_pre[7],temp_pre[8]);
  D_trigger4 tpre43(clk,reset,temp_pre[8],temp_pre[9]);
  PA4 P4(clk,reset,init[19:16],temp_pre[9],carry[3],temp_out[4],temp_carry[4]);
  D_trigger1 tc4(clk,reset,temp_carry[4],carry[4]);
  D_trigger4 tpos40(clk,reset,temp_out[4],temp_pos[0]);
  D_trigger4 tpos41(clk,reset,temp_pos[0],temp_pos[1]);
  D_trigger4 tpos42(clk,reset,temp_pos[1],phase[3:0]);
  
  
  //20:23 PA
  D_trigger4 tpre50(clk,reset,fcw[23:20],temp_pre[10]);
  D_trigger4 tpre51(clk,reset,temp_pre[10],temp_pre[11]);
  D_trigger4 tpre52(clk,reset,temp_pre[11],temp_pre[12]);
  D_trigger4 tpre53(clk,reset,temp_pre[12],temp_pre[13]);
  D_trigger4 tpre54(clk,reset,temp_pre[13],temp_pre[14]);
  PA4 P5(clk,reset,init[23:20],temp_pre[14],carry[4],temp_out[5],temp_carry[5]);
  D_trigger1 tc5(clk,reset,temp_carry[5],carry[5]);
  D_trigger4 tpos50(clk,reset,temp_out[5],temp_pos[2]);
  D_trigger4 tpos51(clk,reset,temp_pos[2],phase[7:4]);
  
  //24:27 PA
  D_trigger4 tpre60(clk,reset,fcw[27:24],temp_pre[15]);
  D_trigger4 tpre61(clk,reset,temp_pre[15],temp_pre[16]);
  D_trigger4 tpre62(clk,reset,temp_pre[16],temp_pre[17]);
  D_trigger4 tpre63(clk,reset,temp_pre[17],temp_pre[18]);
  D_trigger4 tpre64(clk,reset,temp_pre[18],temp_pre[19]);
  D_trigger4 tpre65(clk,reset,temp_pre[19],temp_pre[20]);
  PA4 P6(clk,reset,init[27:24],temp_pre[20],carry[5],temp_out[6],temp_carry[6]);
  D_trigger1 tc6(clk,reset,temp_carry[6],carry[6]);
  D_trigger4 tpos60(clk,reset,temp_out[6],phase[11:8]);
  
  //28:31 PA
  D_trigger4 tpre70(clk,reset,fcw[31:28],temp_pre[21]);
  D_trigger4 tpre71(clk,reset,temp_pre[21],temp_pre[22]);
  D_trigger4 tpre72(clk,reset,temp_pre[22],temp_pre[23]);
  D_trigger4 tpre73(clk,reset,temp_pre[23],temp_pre[24]);
  D_trigger4 tpre74(clk,reset,temp_pre[24],temp_pre[25]);
  D_trigger4 tpre75(clk,reset,temp_pre[25],temp_pre[26]);
  D_trigger4 tpre76(clk,reset,temp_pre[26],temp_pre[27]);
  PA4 P7(clk,reset,init[31:28],temp_pre[27],carry[6],temp_out[7],temp_carry[7]);
  
endmodule
