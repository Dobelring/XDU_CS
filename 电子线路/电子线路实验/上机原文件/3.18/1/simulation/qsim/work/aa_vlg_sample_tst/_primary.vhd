library verilog;
use verilog.vl_types.all;
entity aa_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        CLR             : in     vl_logic;
        D               : in     vl_logic;
        PRN             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end aa_vlg_sample_tst;
