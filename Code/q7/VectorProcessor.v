module VectorProcessor (
    input clk,
    input [1:0] instruction, // 00: load, 01: store, 10: add, 11: multiply
    input [8:0] mem_addr,
    input [1:0] reg_select,
    output out_of_bound
);

    wire [511:0] mem_data_out;
    reg [511:0] mem_data_in;
    reg mem_write_enable;
    reg reg_write_enable;
    reg reg_write_enable_alu;

    wire [511:0] alu_A3;
    wire [511:0] alu_A4;

    wire [511:0] A1;
    wire [511:0] A2;
    wire [511:0] A3;
    wire [511:0] A4;

    // Instantiate Memory
    Memory mem (
        .clk(clk),
        .mem_addr(mem_addr),
        .data_in(mem_data_in),
        .write_enable(mem_write_enable),
        .data_out(mem_data_out)
    );

    // Instantiate Register File
    RegisterFile rf (
        .clk(clk),
        .write_enable(reg_write_enable),
        .write_enable_alu(reg_write_enable_alu),
        .write_select(reg_select),
        .data_in(mem_data_out),
        .alu_data_A3(alu_A3),
        .alu_data_A4(alu_A4),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .A4(A4)
    );

    // Instantiate ALU
    ALU alu (
        .A1(A1),
        .A2(A2),
        .operation(instruction[0]), // 0: add, 1: multiply
        .A3(alu_A3),
        .A4(alu_A4)
    );

    // Address bounds checking
    assign out_of_bound = (mem_addr + 16 > 512);

    always @(*) begin
        mem_write_enable = 0;
        reg_write_enable = 0;
        reg_write_enable_alu = 0;
        mem_data_in = 0;

        if (!out_of_bound) begin
            case (instruction)
                2'b00: begin // Load
                    reg_write_enable = 1;
                end
                2'b01: begin // Store
                    mem_write_enable = 1;
                    case (reg_select)
                        2'b00: mem_data_in = A1;
                        2'b01: mem_data_in = A2;
                        2'b10: mem_data_in = A3;
                        2'b11: mem_data_in = A4;
                    endcase
                end
                2'b10: begin // Add
                    reg_write_enable_alu = 1;
                end
                2'b11: begin // Multiply
                    reg_write_enable_alu = 1;
                end
            endcase
        end
    end
endmodule
