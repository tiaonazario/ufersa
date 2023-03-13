# chmod +x run.sh

set -e

echo "Step 1 - Analysis of description files."

ghdl -a adder.vhd
ghdl -a amount_decoder.vhd
ghdl -a change_register.vhd
ghdl -a comparator.vhd
ghdl -a control.vhd
ghdl -a machine.vhd
ghdl -a operative.vhd
ghdl -a price_decoder.vhd
ghdl -a subtractor.vhd
ghdl -a tot_register.vhd

echo "Step 2 - Analysis of testbench files."
ghdl -a machine_tb.vhd

echo "Step 3 - Tests elaboration."
ghdl -e machine_tb

echo "Step 4 - Simulation and waveforms export."
ghdl -r machine_tb --wave=./waves/machine_tb.ghw

echo "Step 5 - Waveforms."
gtkwave ./waves/machine_tb.ghw

echo "Done!"
