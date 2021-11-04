library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux2x4 is
    port(
        slt: unsigned(1 downto 0);
        in0,in1,in2,in3: in signed(15 downto 0);
        
        out0:out signed(15 downto 0)
    );
end entity mux2x4;

architecture a_mux2x4 of mux2x4 is
    
begin

    out0<= in0 when slt="00" else
            in1 when slt="01" else
            in2 when slt="10" else
            in3 when slt="11" else
            "0000000000000000";

end architecture a_mux2x4;