library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        A1              : in     vl_logic_vector(511 downto 0);
        A2              : in     vl_logic_vector(511 downto 0);
        A3              : out    vl_logic_vector(511 downto 0);
        A4              : out    vl_logic_vector(511 downto 0);
        operation       : in     vl_logic
    );
end ALU;
