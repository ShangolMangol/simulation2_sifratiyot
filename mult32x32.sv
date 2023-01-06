// 32X32 Iterative Multiplier template
module mult32x32 (
    input logic clk,            // Clock
    input logic reset,          // Reset
    input logic start,          // Start signal
    input logic [31:0] a,       // Input a
    input logic [31:0] b,       // Input b
    output logic busy,          // Multiplier busy indication
    output logic [63:0] product // Miltiplication product
);

// Put your code here
// ------------------

logic [1:0] a_sel_out;
logic b_sel_out;
logic [2:0] shift_sel_out;
logic upd_prod_out;
logic clr_prod_out; 

mult32x32_fsm fsm_unit (
    .clk(clk),
    .reset(reset),
    .start(start),
    .busy(busy),
    .a_sel(a_sel_out),
    .b_sel(b_sel_out),
    .shift_sel(shift_sel_out),
    .upd_prod(upd_prod_out),
    .clr_prod(clr_prod_out)
);

mult32x32_arith arith_unit (
    .clk(clk),
    .reset(reset),
    .a(a),
    .b(b),
    .a_sel(a_sel_out),
    .b_sel(b_sel_out),
    .shift_sel(shift_sel_out),
    .upd_prod(upd_prod_out),
    .clr_prod(clr_prod_out),
    .product(product)
);


// End of your code

endmodule
