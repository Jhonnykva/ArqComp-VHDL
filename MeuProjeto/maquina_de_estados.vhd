library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquina_de_estados is
    port(
        clk: in std_logic;
        rst: in std_logic;
        estado: out std_logic
    );
end entity maquina_de_estados;

architecture a_maquina_de_estados of maquina_de_estados is 
    signal estado_s: std_logic;

    begin
    process
    begin
        if rising_edge(clk) then
            estado_s <= not estado_s;
        end if;
    end process;
    estado <= estado_s;

end architecture a_maquina_de_estados;
       
