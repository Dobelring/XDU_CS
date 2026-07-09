library verilog;
use verilog.vl_types.all;
entity tong is
    port(
        Z               : out    vl_logic;
        CLR             : in     vl_logic;
        CLK             : in     vl_logic;
        Q4              : out    vl_logic;
        Q3              : out    vl_logic;
        Q2              : out    vl_logic;
        Q1              : out    vl_logic
    );
end tong;
