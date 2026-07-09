library verilog;
use verilog.vl_types.all;
entity Jkcfq_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        CLR             : in     vl_logic;
        J               : in     vl_logic;
        K               : in     vl_logic;
        PRN             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Jkcfq_vlg_sample_tst;
