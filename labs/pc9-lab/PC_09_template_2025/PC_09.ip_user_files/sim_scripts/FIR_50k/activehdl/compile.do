transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xbip_utils_v3_0_15
vlib activehdl/axi_utils_v2_0_11
vlib activehdl/xbip_pipe_v3_0_11
vlib activehdl/fir_compiler_v7_2_26
vlib activehdl/xil_defaultlib

vmap xbip_utils_v3_0_15 activehdl/xbip_utils_v3_0_15
vmap axi_utils_v2_0_11 activehdl/axi_utils_v2_0_11
vmap xbip_pipe_v3_0_11 activehdl/xbip_pipe_v3_0_11
vmap fir_compiler_v7_2_26 activehdl/fir_compiler_v7_2_26
vmap xil_defaultlib activehdl/xil_defaultlib

vcom -work xbip_utils_v3_0_15 -93  \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work axi_utils_v2_0_11 -93  \
"../../../ipstatic/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_11 -93  \
"../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work fir_compiler_v7_2_26 -93  \
"../../../ipstatic/hdl/fir_compiler_v7_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../SOURCES/IP/FIR_50k/FIR_50k/sim/FIR_50k.vhd" \


