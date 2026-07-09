library verilog;
use verilog.vl_types.all;
entity aa is
    port(
        Q               : out    vl_logic;
        CLR             : in     vl_logic;
        clk             : in     vl_logic;
        D               : in     vl_logic;
        PRN             : in     vl_logic
    );
end aa;
