library verilog;
use verilog.vl_types.all;
entity adder is
    port(
        x               : in     vl_logic_vector(3 downto 0);
        y               : in     vl_logic_vector(3 downto 0);
        cin             : in     vl_logic;
        S               : out    vl_logic_vector(3 downto 0);
        cout            : out    vl_logic
    );
end adder;
