`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07.11.2024 16:23:57
// Design Name:
// Module Name: TEA_de_tb
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

module TEA_de_tb;

    reg clk;
    reg rst;
    reg [31:0] d1_y;
    reg [31:0] d2_z;
    reg [127:0] key;
    reg [31:0] delta;
    reg ready;
    wire done;
    wire work_in_progress;
    wire [63:0] data;
   
    TEA_de uut (
        .clk(clk),
        .rst(rst),
        .d1_y(d1_y),
        .d2_z(d2_z),
        .key(key),
        .delta(delta),
        .ready(ready),
        .done(done),
        .work_in_progress(work_in_progress), .data(data)
       
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        
        d1_y = 32'h2cdc0ff5;
        d2_z = 32'h427e1e21;
        key = 128'h95b3a17446cf51e1d8c4f6b493a71922; 
//        key = 128'h0; // k = 0
        delta = 32'h9E3779B9;
        ready = 0;

        // Reset the circuit
        #5 rst = 0;
        ready = 1;

        // Provide the ready signal to start decryption
        #10 ready = 0;

        // Wait for the decryption process to complete
        wait (done);
        #10;
        $display("Decryption done");
        $display("Output Y: %h", uut.y_new);
        $display("Output Z: %h", uut.z_new);

        $stop;
    end

    // Clock generator
    always #5 clk = ~clk;

endmodule


