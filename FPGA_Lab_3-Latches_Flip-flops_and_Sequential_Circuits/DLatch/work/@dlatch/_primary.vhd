library verilog;
use verilog.vl_types.all;
entity Dlatch is
    port(
        G               : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic;
        Q1              : out    vl_logic
    );
end Dlatch;
