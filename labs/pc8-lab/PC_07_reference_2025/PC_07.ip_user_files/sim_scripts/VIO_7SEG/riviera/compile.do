transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../../../../../../../../Appz/AMDDesignTools/2025.2/Vivado/data/rsb/busdef" "+incdir+../../../../SOURCES/IP/vio_7seg/VIO_7SEG/hdl/verilog" "+incdir+../../../../SOURCES/IP/vio_7seg/VIO_7SEG/hdl" -l xpm -l xil_defaultlib \
"C:/Appz/AMDDesignTools/2025.2/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Appz/AMDDesignTools/2025.2/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"C:/Appz/AMDDesignTools/2025.2/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../../SOURCES/IP/vio_7seg/VIO_7SEG/sim/VIO_7SEG.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

