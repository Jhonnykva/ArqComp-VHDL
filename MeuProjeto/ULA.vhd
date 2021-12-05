--Alunos: Jhonny Kristyan Vaz-Tostes de Assis
--        Gabriel Henrique Kwiatkovski Godinho
-- entrega ULA

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--------------------
-- 00 = soma
-- 01 = subtração
-- 10 = maior
-- 11 = diferente
--------------------

entity ULA is 
    port(   in_termo_1 : in signed (15 downto 0);
            in_termo_2 : in signed (15 downto 0);

            select_op : in unsigned(1 downto 0);

            out_op_1 : out signed (15 downto 0);
            out_op_2 : out std_logic);
end entity;

architecture a_ULA of ULA is
    signal in_1_17, in_2_17, soma_17: signed(16 downto 0);
begin
    in_1_17 <= '0' & in_termo_1;
    in_2_17 <= '0' & in_termo_2;
    soma_17 <= in_termo_1 + in_2_17;
    
    out_op_1 <= in_termo_1+in_termo_2 when select_op="00" else
                in_termo_2-in_termo_1 when select_op="01" else
                in_termo_1+1 when select_op="10" else
                "0000000000000000";

    out_op_2 <= soma_17(1) when select_op="00" else
                '1' when select_op="01" and in_termo_1 > in_termo_2 else
                '1' when select_op="10" and (in_termo_1 > in_termo_2) else
                '1' when select_op="11" and (in_termo_1 /= in_termo_2) else
                '0';

end architecture;

--------------------------------------------------