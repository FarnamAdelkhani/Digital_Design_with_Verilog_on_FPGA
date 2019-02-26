library verilog;
use verilog.vl_types.all;
entity ArithmeticCircuit is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        S1              : in     vl_logic;
        S2              : in     vl_logic;
        Cin             : in     vl_logic;
        Cout            : out    vl_logic;
        F               : out    vl_logic_vector(3 downto 0)
    );
end ArithmeticCircuit;
