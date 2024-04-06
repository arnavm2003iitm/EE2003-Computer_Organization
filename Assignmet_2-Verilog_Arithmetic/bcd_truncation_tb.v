`timescale 1ns / 1ps

module bcd_truncation_tb();
    
    reg [31:0] t_in; 
    reg [2:0] t_sel;
    wire [31:0] t_out;
    wire t_carry_out;
    
    bcd_truncation dut(.in(t_in), .sel(t_sel), .out(t_out), .carry_out(t_carry_out));
    
    initial begin
    
    t_in = 32'b1110110010101000011001000010000; t_sel = 3'b101; // t_in = 76543210 t_sel = 5
    #10
    t_in = 32'b10011001100110011001100110011001; t_sel = 3'b000; // t_in = 99999999 t_sel = 0
    #10
    t_in = 32'b00011001001110010101100101111001; t_sel = 3'b001; // t_in = 19395979 t_sel = 1 
    #10
    t_in = 32'b10011001100110011001100110010101; t_sel = 3'b000; // t_in = 99999995 t_sel = 0 
    #10
    t_in = 32'b10010001100110011001100110011001; t_sel = 3'b110; // t_in = 91999999 t_sel = 6
    #10
    
    $stop;
    
    end    

endmodule