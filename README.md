# ArqComp-VHDL

comando de compilação:

ghdl -a reg16bits.vhd
ghdl -a bancoDeReg.vhd

ghdl -a gerenciador.vhd
ghdl -a gerenciador_tb.vhd

ghdl -a ULA.vhd
ghdl -a ULA_tb.vhd

ghdl -r gerenciador_tb --vcd=gerenciador_tb.vcd
ghdl -r ULA_tb --vcd=ULA_tb.vcd