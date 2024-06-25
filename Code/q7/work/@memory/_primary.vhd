library verilog;
use verilog.vl_types.all;
entity Memory is
    port(
        clk             : in     vl_logic;
        mem_addr        : in     vl_logic_vector(8 downto 0);
        data_in         : in     vl_logic_vector(511 downto 0);
        write_enable    : in     vl_logic;
        data_out        : out    vl_logic_vector(511 downto 0)
    );
end Memory;
