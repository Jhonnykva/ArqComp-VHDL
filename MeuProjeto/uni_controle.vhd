library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_controle is
    port(
        clk, rst: in std_logic;
        top_lvl: out unsigned(16 downto 0)
        
    );
end entity uni_controle;

architecture a_uni_controle of uni_controle is
    component reg7bit is
        port(
            clk :in std_logic;
            rst :in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    component ROM is
        port( clk : in std_logic;
            endereco : in unsigned(6 downto 0);--memória de programa = 4Kbytes 4000bytes = 32000 bits
            instr : out unsigned(16 downto 0)    --32000/17=1882 endereços de 17 bits
        );
    end component;

    component maquina_de_estados is
        port(
            clk: in std_logic;
            rst: in std_logic;
            estado: out std_logic
        );
    end component;

    signal PC_i,PC_o: unsigned(6 downto 0):="0000000";
    signal estado_maq,wr_en: std_logic;
    signal instr: unsigned(16 downto 0);
    signal opcode: unsigned(7 downto 0);
    signal jump_en: std_logic:='0';

begin
    process (rst, clk, estado_maq)
    begin
        if rst='1' then
            PC_i<="0000000";
            elsif rising_edge(clk) then
                if jump_en='1' then
                    PC_i<=instr(6 downto 0);
                else
                    PC_i<=PC_o +1;
                end if;
            end if;
    end process;
    
    ME1: maquina_de_estados port map(    clk=>clk,
        rst=>rst,
        estado=>estado_maq
    );
    
    PC1: reg7bit port map( clk=>clk,
        rst=>rst,
        wr_en=>wr_en,
        data_in=>PC_i,
        data_out=>PC_o
    );
    
    ROM1: ROM port map(  clk=>clk,
        endereco=>PC_i,
        instr=>instr
    );
    
    top_lvl <= instr when estado_maq='0' else
                "00000000000000000";
    
    opcode<=instr(16 downto 9);
    
    wr_en<= '1' when estado_maq ='1' else
            '0';
    
    jump_en <= '1' when opcode ="00000011" else
    '0';
    
end architecture a_uni_controle;