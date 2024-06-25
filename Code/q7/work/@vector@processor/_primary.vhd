library verilog;
use verilog.vl_types.all;
entity VectorProcessor is
    port(
        clk             : in     vl_logic;
        instruction     : in     vl_logic_vector(1 downto 0);
        mem_addr        : in     vl_logic_vector(8 downto 0);
        reg_select      : in     vl_logic_vector(1 downto 0);
        out_of_bound    : out    vl_logic
    );
end VectorProcessor;
