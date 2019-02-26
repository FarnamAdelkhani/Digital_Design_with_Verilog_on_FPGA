library verilog;
use verilog.vl_types.all;
entity bitCount is
    port(
        K               : in     vl_logic;
        CLK             : in     vl_logic;
        reset           : in     vl_logic;
        Q               : out    vl_logic_vector(1 downto 0)
    );
end bitCount;
