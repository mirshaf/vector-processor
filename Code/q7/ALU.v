module ALU (
    input [511:0] A1,
    input [511:0] A2,
    output reg [511:0] A3,
    output reg [511:0] A4,
    input operation // 0: add, 1: multiply
);
    integer i;
    reg signed [32:0] add_temp [15:0];
    reg signed [63:0] mul_temp [15:0];

    always @(*) begin
        if (operation == 1'b0) begin // Addition
            for (i = 0; i < 16; i = i + 1) begin
                add_temp[i] = $signed(A1[32*i +: 32]) + $signed(A2[32*i +: 32]);
                A3[32*i +: 32] = add_temp[i][31:0];
                A4[32*i +: 32] = {32{add_temp[i][32]}}; // Correctly sign-extend
            end
        end else begin // Multiplication
            for (i = 0; i < 16; i = i + 1) begin
                mul_temp[i] = $signed(A1[32*i +: 32]) * $signed(A2[32*i +: 32]);
                A3[32*i +: 32] = mul_temp[i][31:0];
                A4[32*i +: 32] = mul_temp[i][63:32];
            end
        end
    end
endmodule
