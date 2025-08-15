`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2024 17:22:26
// Design Name: 
// Module Name: TEA_en_tb
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



module pipeline_tb();

    // Parameters for testing
    reg clk;
    reg rst;
    reg ready;
    reg [63:0] data;
    reg [127:0] key;
    reg [31:0] delta;
    wire done;
    wire work_in_progress;
    wire [63:0] encrypted_data;
    
    // Instantiate the TEA_en module
    pipeline uut (
        .clk(clk),
        .rst(rst),
        .data(data),
        .key(key),
        .delta(delta),
        .ready(ready),
        .done(done),
        .work_in_progress(work_in_progress)
        ,.encrypted_data(encrypted_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    initial begin
        // Test setup
        rst = 1;
        ready = 0;
        data = 5; // Example data
//        key = 128'h95b3a17446cf51e1d8c4f6b493a71922; 
 key = 0;
        delta = 32'h9E3779B9; // delta = 2654435769 in hex
        
        // Reset
        #10;
        rst = 0;
        ready = 1;
        
        // Wait for ready signal to be captured
        #10;
        ready = 0;

        // Wait for encryption process to complete
        
        
        // Display results
        $display("Encryption Complete.");
        $display("Output Y (Encrypted High 32 bits): %h", uut.y_new);
        $display("Output Z (Encrypted Low 32 bits): %h", uut.z_new);
        
        // End simulation
        #1000;
        $stop;
    end

endmodule
