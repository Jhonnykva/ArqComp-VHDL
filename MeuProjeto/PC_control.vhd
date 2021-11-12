library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_control is
    port(
        clk :in std_logic;
        rst :in std_logic;
        wr_en: in std_logic;
        data_in: in unsigned(6 downto 0);
        data_out: out unsigned(6 downto 0);
        top_lvl: out unsigned(16 downto 0)
        
    );
end entity PC_control;

architecture a_PC_control of PC_control is
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
            dado : out unsigned(16 downto 0)    --32000/17=1882 endereços de 17 bits
        );
    end component;

    component maquina_de_estados is
        port(
            clk: in std_logic;
            reset: in std_logic;
            estado: out std_logic
        );
    end component;

    signal resultado: unsigned(6 downto 0):="0000000";
    signal endereco : unsigned(6 downto 0);
    signal dado : unsigned(16 downto 0);
    signal estado_maq: std_logic;
    signal opcode: unsigned(7 downto 0);
    signal jump_en: std_logic;

begin
    PC1: reg7bit port map( clk=>clk,
        rst=>rst,
        wr_en=>wr_en,
        data_in=>resultado,
        data_out=>data_out
    );
    
    ROM1: ROM port map(  clk=>clk,
        endereco=>resultado,
        dado=>dado
    );

    ME1: maquina_de_estados port map(    clk=>clk,
        reset=>rst,
        estado=>estado_maq
    );

    
    
    resultado <=    dado(6 downto 0) when jump_en ='1' and wr_en = '1' and rising_edge(clk) and estado_maq='1' else
                    resultado+1 when wr_en = '1' and rising_edge(clk) and estado_maq='1' else
                    resultado;
    
    top_lvl <= dado when estado_maq='0' else
                "00000000000000000";
    
    opcode<=dado(16 downto 9) when estado_maq = '1' else
            "00000000";
    
    jump_en <= '1' when opcode ="00000011" else
    '0';
    
end architecture a_PC_control;