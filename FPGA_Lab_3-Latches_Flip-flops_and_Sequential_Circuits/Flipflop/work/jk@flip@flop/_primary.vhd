library verilog;
use verilog.vl_types.all;
entity jkFlipFlop is
    port(
        J               : in     vl_logic;
        K               : in     vl_logic;
        CLK             : in     vl_logic;
        Q               : out    vl_logic
    );
end jkFlipFlop;
