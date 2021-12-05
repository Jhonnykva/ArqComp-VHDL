library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_controle is
    port(
        clk, rst: in std_logic;
        instruction: in unsigned(16 downto 0);
        estado: in unsigned(1 downto 0);
        ula_out_2: in STD_LOGIC;
        
        jump_en, pc_read, rom_read: out STD_LOGIC;
        
        regWrite: out STD_LOGIC;
        ramWrite: out std_logic;
        slt_ula: out unsigned(1 downto 0);
        ALUsrcA: out std_logic;
        ALUsrcB: out std_logic;
        slt_reg_read_1, slt_reg_read_2, slt_reg_write: out unsigned(2 downto 0)
        
    );
end entity uni_controle;

architecture a_uni_controle of uni_controle is
    component reg1bit is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN STD_LOGIC ;
            data_out : OUT STD_LOGIC
        );
    end component;
    
    signal opcode: unsigned(7 downto 0);
    signal flagWrite, flag_C: STD_LOGIC:='0';

begin
    flag_Cr: reg1bit port map(
        clk      =>clk,
        rst      =>rst,
        wr_en    =>flagWrite,
        data_in  =>ula_out_2,
        data_out  => flag_C );

    opcode <= instruction(16 downto 9);
    
    pc_read <= '1' when estado ="01" else '0';
    rom_read <= '1' when estado ="00" else '0';
    
    flagWrite <= '1' when opcode="00000101" or opcode="00000111" else '0';
    
    jump_en <= '1' when opcode ="00000110" else
    '1' when opcode="00001000" and flag_C='1' else
    '0';
    
    regWrite <= '1' when (opcode = "00000001" or opcode = "00000010" or opcode = "00000011" or
        opcode = "00000100" or opcode = "00000101" or opcode(7 downto 3)="01001" or opcode="00001011" OR
        opcode="00001100" or opcode="00001101" or opcode="00001110"  )
    and estado = "10" else '0';
    
    ramWrite <= '1' when opcode="00001010" else '0';
    
    slt_ula <= "01" when opcode = "00000101" else
    "10" when opcode="00001101" else
    "11" when opcode="00000111" else
    "00";
    
    ALUsrcA <= '1' when opcode = "00000001" or opcode = "00000101"  or opcode(7 downto 3)="01001" 
    or opcode="00001010" or opcode="00001011" or opcode="00001100"  or opcode="00001110" else '0';
    
    ALUsrcB <= '1' when opcode="00001011" else 
    '0';
    
    slt_reg_read_1 <= "001" when opcode ="00000010" or opcode = "00000100" else
    instruction(2 downto 0) when opcode ="00000011" else
    "010" when opcode="00001010" or opcode="00001011" or opcode="00001101" else
    "000" ;
    
    slt_reg_read_2 <= instruction(2 downto 0) when opcode = "00000100" else
    "001" when opcode = "00000101" or opcode="00001010" or opcode="00001110" else
    "000" ;
    
    slt_reg_write <="001" when opcode="00000001" or opcode = "00000011" or opcode = "00000100" or
    opcode = "00000101" or opcode="00001011" or opcode="00001110" else
    instruction(2 downto 0) when opcode = "00000010" else
    instruction(11 downto 9) when opcode(7 downto 3)="01001" else
    "010" when opcode="00001100" or opcode="00001101" else
    "000" ;
    
end architecture a_uni_controle;