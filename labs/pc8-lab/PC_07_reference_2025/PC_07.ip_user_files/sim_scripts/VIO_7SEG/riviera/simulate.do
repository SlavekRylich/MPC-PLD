transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+VIO_7SEG  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.VIO_7SEG xil_defaultlib.glbl

do {VIO_7SEG.udo}

run 1000ns

endsim

quit -force
