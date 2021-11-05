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

            select_op_1 : in std_logic;
            select_op_2 : in std_logic;

            out_op_1 : out signed (15 downto 0);
            out_op_2 : out std_logic);
end entity;

architecture a_ULA of ULA is
begin
    out_op_1 <= in_termo_1+in_termo_2 when select_op_1='0' and select_op_2='0' else
                in_termo_1-in_termo_2 when select_op_1='0' and select_op_2='1' else
                "0000000000000000";

    out_op_2 <= '1' when select_op_1='1' and select_op_2='0' and (in_termo_1 > in_termo_2) else
                '1' when select_op_1='1' and select_op_2='1' and (in_termo_1 /= in_termo_2) else
                '0';

end architecture;

--------------------------------------------------