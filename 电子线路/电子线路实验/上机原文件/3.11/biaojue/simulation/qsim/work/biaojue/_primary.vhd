library verilog;
use verilog.vl_types.all;
entity biaojue is
    port(
        f               : out    vl_logic;
        b               : in     vl_logic;
        a               : in     vl_logic;
        c               : in     vl_logic
    );
end biaojue;
