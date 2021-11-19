library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_controle is
    port(
        clk, rst: in std_logic;
        instruction: in unsigned(16 downto 0);
        estado: in unsigned(1 downto 0);
        
        jump_en, pc_read, rom_read: out STD_LOGIC;
        
        regWrite: out STD_LOGIC;
        slt_ula: out unsigned(1 downto 0);
        ALUsrcA: out std_logic;
        slt_reg_read_1, slt_reg_read_2, slt_reg_write: out unsigned(2 downto 0)
        
    );
end entity uni_controle;

architecture a_uni_controle of uni_controle is
    
    signal opcode: unsigned(7 downto 0);

begin

    opcode <= instruction(16 downto 9);
    
    jump_en <= '1' when opcode ="00000110" else '0';
    pc_read <= '1' when estado ="01" else '0';
    rom_read <= '1' when estado ="00" else '0';
    regWrite <= '1' when (opcode = "00000010" or opcode = "00000001" or opcode = "00000101") and estado = "10" else '0';
    slt_ula <= "00" when opcode = "00000100" else "00";
    ALUsrcA <= '1' when opcode = "00000001" or opcode = "00000101" else '0';
    slt_reg_read_1 <= instruction(2 downto 0) when opcode ="00000010" else "000" ;
    slt_reg_read_2 <= "001" when opcode="00000010" else "000" ;
    slt_reg_write <="001" when opcode="00000001" else "000" ;
    
end architecture a_uni_controle;