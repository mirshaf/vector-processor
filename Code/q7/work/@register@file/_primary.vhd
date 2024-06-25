library verilog;
use verilog.vl_types.all;
entity RegisterFile is
    port(
        clk             : in     vl_logic;
        write_enable    : in     vl_logic;
        write_enable_alu: in     vl_logic;
        write_select    : in     vl_logic_vector(1 downto 0);
        data_in         : in     vl_logic_vector(511 downto 0);
        alu_data_A3     : in     vl_logic_vector(511 downto 0);
        alu_data_A4     : in     vl_logic_vector(511 downto 0);
        A1              : out    vl_logic_vector(511 downto 0);
        A2              : out    vl_logic_vector(511 downto 0);
        A3              : out    vl_logic_vector(511 downto 0);
        A4              : out    vl_logic_vector(511 downto 0)
    );
end RegisterFile;
