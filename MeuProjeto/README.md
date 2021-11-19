# ArqComp-VHDL

comando de compilação:

ghdl -a reg16bit.vhd
ghdl -a bancoreg.vhd

ghdl -a gerenciador.vhd
ghdl -a gerenciador_tb.vhd

ghdl -a ULA.vhd
ghdl -a ULA_tb.vhd

ghdl -r gerenciador_tb --vcd=gerenciador_tb.vcd
ghdl -r ULA_tb --vcd=ULA_tb.vcd



ghdl -a maquina_de_estados.vhd
ghdl -a maquina_de_estados_tb.vhd
ghdl -r maquina_de_estados_tb --vcd=maquina_de_estados_tb.vcd

ghdl -a ROM.vhd
ghdl -a ROM_tb.vhd
ghdl -r ROM_tb --vcd=ROM_tb.vcd

ghdl -a PC_control.vhd
ghdl -a PC_control_tb.vhd
ghdl -r PC_control_tb --vcd=PC_control_tb.vcd

ghdl -a reg7bit.vhd

ghdl -a uni_controle.vhd
ghdl -a mux2x1.vhd
ghdl -a reg7bit.vhd
ghdl -a ROM.vhd
ghdl -a reg16bit.vhd
ghdl -a bancoreg.vhd
ghdl -a ULA.vhd
ghdl -a maquina_de_estados.vhd
ghdl -a processador.vhd
ghdl -a processador_tb.vhd
ghdl -r processador_tb --vcd=processador.vcd