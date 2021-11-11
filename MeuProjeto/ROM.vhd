library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port( clk : in std_logic;
        endereco : in unsigned(10 downto 0);--memória de programa = 4Kbytes 4000bytes = 32000 bits
        dado : out unsigned(16 downto 0)    --32000/17=1882 endereços de 17 bits
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(16 downto 0);--trocar futuramente 127 por 1881
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0 => "00000000000001000",
        1 => "00000000000000111",
        2 => "00000000000000100",
        -- abaixo: casos omissos => (zero em todos os bits)
        others => (others=>'0')
    );

    begin
    process(clk)
    begin
        if(rising_edge(clk)) then
        dado <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;
