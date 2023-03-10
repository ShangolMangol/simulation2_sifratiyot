// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------

logic [7:0] a_out;
logic [15:0] b_out;
logic [23:0] current_product;
logic [63:0] shift_out;




//a mux
always_comb begin
    case (a_sel)
        2'b00: a_out = a[7:0];
        2'b01: a_out = a[15:8];
        2'b10: a_out = a[23:16];
        2'b11: a_out = a[31:24];
    endcase
end

//b mux
always_comb begin
    case(b_sel)    
        1'b0: b_out = b[15:0];
        1'b1: b_out = b[31:16];
    endcase    
end

//shift mux
always_comb begin 
    current_product = b_out * a_out;
    case(shift_sel)
        3'b000: shift_out = current_product;
        3'b001: shift_out = current_product << 8;
        3'b010: shift_out = current_product << 16;
        3'b011: shift_out = current_product << 24;
        3'b100: shift_out = current_product << 32;
        3'b101: shift_out = current_product << 40;
    endcase 

end

always_ff @( posedge clk, posedge reset ) begin
    if(reset == 1'b1) begin
        product <= 64'b0;
    end
    else begin
        if(clr_prod == 1'b1) begin
            product <= 64'b0;
        end
        else if(upd_prod == 1'b1) begin
            product <= product + shift_out;

        end
    end
end

// End of your code

endmodule
