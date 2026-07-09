library verilog;
use verilog.vl_types.all;
entity qjq is
    port(
        Q0              : out    vl_logic;
        A0              : in     vl_logic;
        B0              : in     vl_logic;
        Cin             : in     vl_logic;
        Q1              : out    vl_logic;
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        Q2              : out    vl_logic;
        A2              : in     vl_logic;
        B2              : in     vl_logic;
        Q3              : out    vl_logic;
        A3              : in     vl_logic;
        B3              : in     vl_logic;
        Cout            : out    vl_logic
    );
end qjq;
