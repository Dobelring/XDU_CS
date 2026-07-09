onerror {exit -code 1}
vlib work
vlog -work work Jkcfq.vo
vlog -work work Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Jkcfq_vlg_vec_tst -voptargs="+acc"
vcd file -direction Jkcfq.msim.vcd
vcd add -internal Jkcfq_vlg_vec_tst/*
vcd add -internal Jkcfq_vlg_vec_tst/i1/*
run -all
quit -f
