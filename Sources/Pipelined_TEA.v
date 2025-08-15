`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2024 17:22:06
// Design Name: 
// Module Name: TEA_en
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


module pipeline(
input clk,
input rst,
input [63:0] data,
input [127:0] key,
input [31:0] delta,
input ready,
output done,
output work_in_progress,
output [63:0] encrypted_data        // encrypted_data = { y,z}
    );
    
    reg [31:0] y;
    reg [31:0] y_new;
    reg [31:0] y1;
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
    
   // localparam delta=1;
//    assign i_next = rst ? 0 : (i_cur+1) ;
    assign k0 = key[127:96];
    assign k1 = key[95:64];
    assign k2 = key[63:32];
    assign k3 = key[31:0];
    assign work_in_progress = (i_cur>=32) ?  0 : 1;
    assign encrypted_data = { y_new,z_new};
    
    always @*
    begin
        if(ready)
        begin
            i_next=0;
        end
        else if(i_cur<32)
        begin
            i_next=i_cur+1;
        end
    end
    
    always @*
    begin
        if(ready)
        begin
           
            z=data[31:0];
          
        end
        else if(i_cur<32)
        begin
            z = z_new + ( ((y<<4)+k2) ^ (y+sum) ^ ((y>>5)+k3) ) ;
        end  
    end
    
    
    
     always @*
    begin
        if(ready)
        begin
            y=data[63:32];
            sum_next=delta;
        end
        else if(i_cur<32)
        begin
            sum_next = sum + delta;
            y = y1 + ( ((z_new<<4)+k0) ^ (z_new+sum) ^ ((z_new>>5)+k1) ) ;
        end  
    end
    
    
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            y_new<=0;
            sum<=0;
        end
        begin
                y_new<=y1;
                sum<=sum_next;
        end
    end
    
     
    always @(posedge clk)
    begin
        if(rst)
        begin
            y1<=0;
        end
        begin
                y1<=y;
        end
    end
    
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            z_new<=0;
        end
        begin
                z_new<=z;
        end
    end
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            i_cur<=7'd0;
        end
        else
        begin
                i_cur<=i_next;
        end
    end
    
    
    assign done = (i_cur>=32)?1:0;
    
    
endmodule

