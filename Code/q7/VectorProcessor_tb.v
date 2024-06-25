module VectorProcessor_tb;

    reg clk;
    reg [1:0] instruction;
    reg [8:0] mem_addr;
    reg [1:0] reg_select;
    wire out_of_bound;

    integer i;

    // Instantiate the VectorProcessor
    VectorProcessor vp (
        .clk(clk),
        .instruction(instruction),
        .mem_addr(mem_addr),
        .reg_select(reg_select),
        .out_of_bound(out_of_bound)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Initialize memory with specific values
    initial begin
        // Normal values initialization
        for (i = 0; i < 16; i = i + 1) begin
            vp.mem.memory[i] = i + 1; // Memory 0-15 with values 1 to 16
        end
        for (i = 16; i < 32; i = i + 1) begin
            vp.mem.memory[i] = (i - 15) * 2; // Memory 16-31 with values 2, 4, 6, ..., 32
        end

        // Edge cases
        vp.mem.memory[32] = 32'h7FFFFFFF; // Edge case: Maximum positive value
        vp.mem.memory[33] = 32'h80000000; // Edge case: Maximum negative value
        vp.mem.memory[34] = 32'h00000001; // Small positive value
        vp.mem.memory[35] = 32'hFFFFFFFF; // Edge case: -1 in two's complement
        vp.mem.memory[36] = 32'h80000001;
        vp.mem.memory[37] = 32'h80000000;
        vp.mem.memory[38] = 32'h7FFFFFFF;
        vp.mem.memory[39] = 32'h7FFFFFFF;

        // Random values
        for (i = 0; i < 32; i = i + 1) begin
            vp.mem.memory[i + 48] = $random;
        end
    end

    // Helper function to display 512-bit registers
    task display_512bit;
        input [511:0] reg_val;
        integer j;
        begin
            for (j = 15; j >= 0; j = j - 1) begin
                $write("%h", reg_val[32*j +: 32]);
                if (j != 0) $write("-");
            end
            $write("\n");
        end
    endtask

    // Test sequence
    initial begin
        // Test normal load/store operations
        instruction = 2'b00; // Load
        mem_addr = 9'd0; // Load from memory address 0
        reg_select = 2'b00; // Load into A1
        #10;
        
        // Debug: Check values in A1
        $display("A1 after loading from memory address 0:");
        display_512bit(vp.rf.A1);
        
        instruction = 2'b00; // Load
        mem_addr = 9'd16; // Load from memory address 16
        reg_select = 2'b01; // Load into A2
        #10;

        // Debug: Check values in A2
        $display("A2 after loading from memory address 16:");
        display_512bit(vp.rf.A2);

        // Perform addition
        instruction = 2'b10; // Add
        #10;

        // Check for addition result
        if (out_of_bound) $display("Test Failed: Out of Bound Detected During Add");
        else begin
            // Display result for verification
            $display("Addition Result A3:");
            display_512bit(vp.rf.A3);
            $display("Addition Overflow A4:");
            display_512bit(vp.rf.A4);
        end

        // Perform multiplication
        instruction = 2'b11; // Multiply
        #10;

        // Check for multiplication result
        if (out_of_bound) $display("Test Failed: Out of Bound Detected During Multiply");
        else begin
            // Display result for verification
            $display("Multiplication Result A3:");
            display_512bit(vp.rf.A3);
            $display("Multiplication Upper A4:");
            display_512bit(vp.rf.A4);
        end

        $display("----------------------------------------------------------------------");
        $display("----------------------------------------------------------------------");

        // Load edge case values into A1 and A2
        instruction = 2'b00; // Load
        mem_addr = 9'd32; // Load maximum positive value
        reg_select = 2'b00; // Load into A1
        #10;

        // Debug: Check values in A1
        $display("A1 after loading from memory address 32:");
        display_512bit(vp.rf.A1);

        instruction = 2'b00; // Load
        mem_addr = 9'd33; // Load maximum negative value
        reg_select = 2'b01; // Load into A2
        #10;

        // Debug: Check values in A2
        $display("A2 after loading from memory address 33:");
        display_512bit(vp.rf.A2);

        // Perform addition on edge cases
        instruction = 2'b10; // Add
        #10;

        // Check for addition result
        if (out_of_bound) $display("Test Failed: Out of Bound Detected During Add");
        else begin
            // Display result for verification
            $display("Addition Result A3:");
            display_512bit(vp.rf.A3);
            $display("Addition Overflow A4:");
            display_512bit(vp.rf.A4);
        end

        // Perform multiplication on edge cases
        instruction = 2'b11; // Multiply
        #10;

        // Check for multiplication result
        if (out_of_bound) $display("Test Failed: Out of Bound Detected During Multiply");
        else begin
            // Display result for verification
            $display("Multiplication Result A3:");
            display_512bit(vp.rf.A3);
            $display("Multiplication Upper A4:");
            display_512bit(vp.rf.A4);
        end

        $display("----------------------------------------------------------------------");
        $display("----------------------------------------------------------------------");

        // Test out-of-bound load
        instruction = 2'b00; // Load
        mem_addr = 9'd500; // Out of bound
        reg_select = 2'b00;
        #10;
        if (out_of_bound) $display("Test Passed: Out of Bound Load Detected");
        else $display("Test Failed: Out of Bound Load Not Detected");

        // Test out-of-bound store
        instruction = 2'b01; // Store
        mem_addr = 9'd500; // Out of bound
        reg_select = 2'b00;
        #10;
        if (out_of_bound) $display("Test Passed: Out of Bound Store Detected");
        else $display("Test Failed: Out of Bound Store Not Detected");

        $display("----------------------------------------------------------------------");
        $display("----------------------------------------------------------------------");

        // Test random cases

        instruction = 2'b00; // Load random values
        mem_addr = 9'd48;
        reg_select = 2'b00; // Load into A1
        #10;

        // Debug: Check values in A1
        $display("A1 after loading from memory address 48:");
        display_512bit(vp.rf.A1);

        instruction = 2'b00; // Load random values
        mem_addr = 9'd64;
        reg_select = 2'b01; // Load into A2
        #10;

        // Debug: Check values in A2
        $display("A2 after loading from memory address 64:");
        display_512bit(vp.rf.A2);

        // Perform addition on random values
        instruction = 2'b10; // Add
        #10;

        // Display addition result
        if (out_of_bound) $display("Test Failed: Out of Bound Detected During Add");
        else begin
            $display("Random Addition Result A3:");
            display_512bit(vp.rf.A3);
            $display("Random Addition Overflow A4:");
            display_512bit(vp.rf.A4);
        end

        // Perform multiplication on random values
        instruction = 2'b11; // Multiply
        #10;

        // Display multiplication result
        if (out_of_bound) $display("Test Failed: Out of Bound Detected During Multiply");
        else begin
            $display("Random Multiplication Result A3:");
            display_512bit(vp.rf.A3);
            $display("Random Multiplication Upper A4:");
            display_512bit(vp.rf.A4);
        end

        // Store the result of a test back into memory
        instruction = 2'b01; // Store
        mem_addr = 9'd100; // Store result at memory address 100
        reg_select = 2'b10; // Store A3
        #10;

        // Debug: Check stored values in memory
        $display("Memory after storing A3:");
        for (i = 15; i >= 0; i = i - 1) begin
            $write("%h", vp.mem.memory[100 + i]);
            if (i != 0) $write("-");
        end
        $write("\n");
        $display("----------------------------------------------------------------------");
        $display("----------------------------------------------------------------------");

        $stop;
    end

endmodule
