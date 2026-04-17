transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+FIR_50k  -L xil_defaultlib -L xbip_utils_v3_0_15 -L axi_utils_v2_0_11 -L xbip_pipe_v3_0_11 -L fir_compiler_v7_2_26 -L secureip -O5 xil_defaultlib.FIR_50k

do {FIR_50k.udo}

run 1000ns

endsim

quit -force
