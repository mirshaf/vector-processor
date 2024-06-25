module RegisterFile (
    input clk,
    input write_enable,
    input write_enable_alu,
    input [1:0] write_select,
    input [511:0] data_in,
    input [511:0] alu_data_A3,
    input [511:0] alu_data_A4,
    output reg [511:0] A1,
    output reg [511:0] A2,
    output reg [511:0] A3,
    output reg [511:0] A4
);

    always @(posedge clk) begin
        if (write_enable) begin
            case (write_select)
                2'b00: A1 <= data_in;
                2'b01: A2 <= data_in;
                2'b10: A3 <= data_in;
                2'b11: A4 <= data_in;
            endcase
        end

        if (write_enable_alu) begin
            A3 <= alu_data_A3;
            A4 <= alu_data_A4;
        end
    end
endmodule
