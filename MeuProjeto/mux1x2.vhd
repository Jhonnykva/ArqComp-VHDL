library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux1x2 is
    port(
        slt: in std_logic;
        in0,in1: in signed(15 downto 0);
        
        out0:out signed(15 downto 0)
    );
end entity mux1x2;

architecture a_mux1x2 of mux1x2 is
    
begin

    out0<= in0 when slt='0' else
            in1 when slt='1' else
            "0000000000000000";

end architecture a_mux1x2;