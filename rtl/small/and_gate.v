module and_gate (
    input  wire a,
    input  wire [2:0] b,
    output wire [2:0] out
);

    assign out = {3{a}} & b;

endmodule