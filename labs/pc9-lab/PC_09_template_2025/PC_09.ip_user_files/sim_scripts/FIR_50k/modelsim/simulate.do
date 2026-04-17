onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L xil_defaultlib -L xbip_utils_v3_0_15 -L axi_utils_v2_0_11 -L xbip_pipe_v3_0_11 -L fir_compiler_v7_2_26 -L secureip -lib xil_defaultlib xil_defaultlib.FIR_50k

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {FIR_50k.udo}

run 1000ns

quit -force
