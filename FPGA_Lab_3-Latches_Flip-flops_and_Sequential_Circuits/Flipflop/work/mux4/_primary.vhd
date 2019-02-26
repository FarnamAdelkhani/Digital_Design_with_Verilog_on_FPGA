library verilog;
use verilog.vl_types.all;
entity mux4 is
    port(
        i0              : in     vl_logic_vector(3 downto 0);
        i1              : in     vl_logic_vector(3 downto 0);
        i2              : in     vl_logic_vector(3 downto 0);
        i3              : in     vl_logic_vector(3 downto 0);
        out1            : out    vl_logic_vector(3 downto 0);
        S0              : in     vl_logic;
        S1              : in     vl_logic
    );
end mux4;
