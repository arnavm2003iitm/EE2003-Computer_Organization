`timescale 1ns / 1ps

module bcd_truncation(
    input [31:0] in,
    input [2:0] sel,
    wire [3:0] selected,
    wire [31:0] compare_out,
    wire [31:0] compare_out_shifted,
    wire [31:0] extract_digits,
    wire [31:0] extract_digits_shifted,
    wire [31:0] extracted_digits,
    wire [7:0] carry,
    output [31:0] out,
    output carry_out);
    
    assign selected = in[4*sel + 3 -: 4]; // select the digit to be truncated  
    
    assign compare_out[31:1] = 31'b0; // 31-bit array of zeros. last bit reserved for comparison out 
    assign compare_out[0] = selected[3] | selected[0] & selected[2] | selected[1] & selected[2]; // check if selected digit >= 5    
    
    assign compare_out_shifted = compare_out << 4*sel + 4; // shift to get the compared output on new LSB
    
    assign extract_digits = 32'hffffffff; // array of ones
    assign extract_digits_shifted = extract_digits << 4*sel + 4;
    
    assign extracted_digits = in & extract_digits_shifted;
    
    bcd_adder dig_0 (.a(extracted_digits[3:0]), .b(compare_out_shifted[3:0]), .carry_in(1'b0), .carry(carry[0]), .sum(out[3:0]));
    bcd_adder dig_1 (.a(extracted_digits[7:4]), .b(compare_out_shifted[7:4]), .carry_in(carry[0]), .carry(carry[1]), .sum(out[7:4]));
    bcd_adder dig_2 (.a(extracted_digits[11:8]), .b(compare_out_shifted[11:8]), .carry_in(carry[1]), .carry(carry[2]), .sum(out[11:8]));
    bcd_adder dig_3 (.a(extracted_digits[15:12]), .b(compare_out_shifted[15:12]), .carry_in(carry[2]), .carry(carry[3]), .sum(out[15:12]));
    bcd_adder dig_4 (.a(extracted_digits[19:16]), .b(compare_out_shifted[19:16]), .carry_in(carry[3]), .carry(carry[4]), .sum(out[19:16]));
    bcd_adder dig_5 (.a(extracted_digits[23:20]), .b(compare_out_shifted[23:20]), .carry_in(carry[4]), .carry(carry[5]), .sum(out[23:20]));
    bcd_adder dig_6 (.a(extracted_digits[27:24]), .b(compare_out_shifted[27:24]), .carry_in(carry[5]), .carry(carry[6]), .sum(out[27:24]));
    bcd_adder dig_7 (.a(extracted_digits[31:28]), .b(compare_out_shifted[31:28]), .carry_in(carry[6]), .carry(carry[7]), .sum(out[31:28]));
    
    assign carry_out = carry[7];

endmodule