transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xpm
vlib activehdl/microblaze_v11_0_16
vlib activehdl/xil_defaultlib
vlib activehdl/proc_sys_reset_v5_0_17
vlib activehdl/lmb_v10_v3_0_16
vlib activehdl/lmb_bram_if_cntlr_v4_0_27
vlib activehdl/blk_mem_gen_v8_4_12
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/mdm_v3_2_29
vlib activehdl/iomodule_v3_1_13

vmap xpm activehdl/xpm
vmap microblaze_v11_0_16 activehdl/microblaze_v11_0_16
vmap xil_defaultlib activehdl/xil_defaultlib
vmap proc_sys_reset_v5_0_17 activehdl/proc_sys_reset_v5_0_17
vmap lmb_v10_v3_0_16 activehdl/lmb_v10_v3_0_16
vmap lmb_bram_if_cntlr_v4_0_27 activehdl/lmb_bram_if_cntlr_v4_0_27
vmap blk_mem_gen_v8_4_12 activehdl/blk_mem_gen_v8_4_12
vmap axi_lite_ipif_v3_0_4 activehdl/axi_lite_ipif_v3_0_4
vmap mdm_v3_2_29 activehdl/mdm_v3_2_29
vmap iomodule_v3_1_13 activehdl/iomodule_v3_1_13

vlog -work xpm  -sv2k12 "+incdir+../../../../../../../../../../../../Appz/AMDDesignTools/2025.2/Vivado/data/rsb/busdef" -l xpm -l microblaze_v11_0_16 -l xil_defaultlib -l proc_sys_reset_v5_0_17 -l lmb_v10_v3_0_16 -l lmb_bram_if_cntlr_v4_0_27 -l blk_mem_gen_v8_4_12 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_29 -l iomodule_v3_1_13 \
"C:/Appz/AMDDesignTools/2025.2/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Appz/AMDDesignTools/2025.2/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"C:/Appz/AMDDesignTools/2025.2/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v11_0_16 -93  \
"../../../ipstatic/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_0/sim/bd_fc5c_0_microblaze_I_0.vhd" \

vcom -work proc_sys_reset_v5_0_17 -93  \
"../../../ipstatic/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_1/sim/bd_fc5c_0_rst_0_0.vhd" \

vcom -work lmb_v10_v3_0_16 -93  \
"../../../ipstatic/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_2/sim/bd_fc5c_0_ilmb_0.vhd" \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_3/sim/bd_fc5c_0_dlmb_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_27 -93  \
"../../../ipstatic/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_4/sim/bd_fc5c_0_dlmb_cntlr_0.vhd" \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_5/sim/bd_fc5c_0_ilmb_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_12  -v2k5 "+incdir+../../../../../../../../../../../../Appz/AMDDesignTools/2025.2/Vivado/data/rsb/busdef" -l xpm -l microblaze_v11_0_16 -l xil_defaultlib -l proc_sys_reset_v5_0_17 -l lmb_v10_v3_0_16 -l lmb_bram_if_cntlr_v4_0_27 -l blk_mem_gen_v8_4_12 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_29 -l iomodule_v3_1_13 \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../../../../../../../../../Appz/AMDDesignTools/2025.2/Vivado/data/rsb/busdef" -l xpm -l microblaze_v11_0_16 -l xil_defaultlib -l proc_sys_reset_v5_0_17 -l lmb_v10_v3_0_16 -l lmb_bram_if_cntlr_v4_0_27 -l blk_mem_gen_v8_4_12 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_29 -l iomodule_v3_1_13 \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_6/sim/bd_fc5c_0_lmb_bram_I_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  \
"../../../ipstatic/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_v3_2_29 -93  \
"../../../ipstatic/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_7/sim/bd_fc5c_0_mdm_0_0.vhd" \

vcom -work iomodule_v3_1_13 -93  \
"../../../ipstatic/hdl/iomodule_v3_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/ip/ip_9/sim/bd_fc5c_0_iomodule_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../../../../../../../../../Appz/AMDDesignTools/2025.2/Vivado/data/rsb/busdef" -l xpm -l microblaze_v11_0_16 -l xil_defaultlib -l proc_sys_reset_v5_0_17 -l lmb_v10_v3_0_16 -l lmb_bram_if_cntlr_v4_0_27 -l blk_mem_gen_v8_4_12 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_29 -l iomodule_v3_1_13 \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/bd_0/sim/bd_fc5c_0.v" \
"../../../../SOURCES/IP/MCS/microblaze_mcs_0/sim/microblaze_mcs_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

