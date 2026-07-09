library verilog;
use verilog.vl_types.all;
entity Jkcfq is
    port(
        Q               : out    vl_logic;
        PRN             : in     vl_logic;
        CLR             : in     vl_logic;
        K               : in     vl_logic;
        J               : in     vl_logic;
        clk             : in     vl_logic
    );
end Jkcfq;
