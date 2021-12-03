library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port( clk : in std_logic;
        endereco : in unsigned(6 downto 0);--memória de programa = 4Kbytes 4000bytes = 32000 bits
        instr : out unsigned(16 downto 0)    --32000/17=1882 endereços de 17 bits
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(16 downto 0);--trocar futuramente 127 por 1881
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0 => B"00000001_000000000",
        1 => B"00000010_000000011",
        2 => B"00000001_000000000",
        3 => B"00000010_000000100",
        4 => B"00000011_000000011",
        5 => B"00000100_000000100",
        6 => B"00000010_000000100",
        7 => B"00000001_000000001",
        8 => B"00000100_000000011",
        9 => B"00000010_000000011",
        10=> B"00000111_000000011",
        11=> B"00000011_000000011",
        12=> B"00000101_000011110",
        13=> B"00001000_011110110",
        14=> B"00000011_000000100",
        15=> B"00000010_000000101",
        -- abaixo: casos omissos => (zero em todos os bits)
        others => (others=>'0')
    );

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
        instr <= conteudo_rom(to_integer(endereco));
    end if;
end process;
end architecture;