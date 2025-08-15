`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07.11.2024 16:23:25
// Design Name:
// Module Name: TEA_de
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module TEA_de(
input clk,
input rst,
input [31:0] d1_y,
input [31:0] d2_z,
input [127:0] key,
input [31:0] delta,
input ready,
output done,
output work_in_progress,
output [63:0] data
    );
   
    reg [31:0] y;
    reg [31:0] y_new;
    reg [31:0] z;
    reg [31:0] z_new;
    wire [31:0] k0;
    wire [31:0] k1;
    wire [31:0] k2;
    wire [31:0] k3;
    reg [31:0] sum;
    reg [31:0] sum_next;
    reg [6:0] i_cur;
    reg [6:0] i_next;
   
//    assign i_next = rst ? 0 : (i_cur+1) ;
    assign k0 = key[127:96];
    assign k1 = key[95:64];
    assign k2 = key[63:32];
    assign k3 = key[31:0];
    assign work_in_progress = (i_cur>=32) ?  0 : 1;
    assign data = {y_new,z_new};
  
     
    always @*
    begin
        if(ready)
        begin
            y=d1_y;
            z=d2_z;
            sum=32'hc6ef3720;
        end
        else
        begin
            z = z_new - ( ((y_new<<4)+k2) ^ (y_new+sum_next) ^ ((y_new>>5)+k3) ) ;
            y = y_new - ( ((z<<4)+k0) ^ (z+sum_next) ^ ((z>>5)+k1) ) ;
            sum = sum_next-delta;
        end
    end
   
    always @(posedge clk)
    begin
        if(rst)
        begin
            y_new<=0;
            z_new<=0;
            sum_next<=0;
        end
        else
        begin
            
                y_new<=y;
                z_new<=z;
                sum_next<=sum;
            
        end
    end
   
  
   
   
endmodule

