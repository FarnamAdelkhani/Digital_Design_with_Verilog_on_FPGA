library verilog;
use verilog.vl_types.all;
entity lab2j is
    port(
        a               : in     vl_logic_vector(3 downto 0);
        b               : in     vl_logic_vector(3 downto 0);
        cin             : in     vl_logic;
        S1              : in     vl_logic;
        S0              : in     vl_logic;
        f               : out    vl_logic_vector(3 downto 0);
        cout            : out    vl_logic
    );
end lab2j;
