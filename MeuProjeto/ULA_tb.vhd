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

entity ULA_tb is 
end;

architecture a_ULA_tb of ULA_tb is
    component ULA
        port(   in_termo_1 : in signed (15 downto 0);
                in_termo_2 : in signed (15 downto 0);

                select_op_1 : in std_logic;
                select_op_2 : in std_logic;

                out_op_1 : out signed (15 downto 0);
                out_op_2 : out std_logic);
    end component;

    signal in_termo_1, in_termo_2 : signed (15 downto 0);
    signal select_op_1, select_op_2 : std_logic;
    signal out_op_1 : signed (15 downto 0);
    signal out_op_2 : std_logic;

    begin
        uut: ULA port map(  in_termo_1=>in_termo_1,
                            in_termo_2=>in_termo_2,
                            select_op_1=>select_op_1,
                            select_op_2=>select_op_2,
                            out_op_1=>out_op_1,
                            out_op_2=>out_op_2
                            );
    
    process                        
    begin 
    --testes de soma-----------------------
        --soma normal
        in_termo_1 <= "0010101100100000";
        in_termo_2 <= "0000000010000011";
        select_op_1 <= '0';
        select_op_2 <= '0';
        wait for 50 ns;
    
        --soma com número negativo
        in_termo_1 <= "0100001100001001";
        in_termo_2 <= "1111111111111101";
        select_op_1 <= '0';
        select_op_2 <= '0';
        wait for 50 ns;  
       
    --testes de subtração------------------
        --subtraindo número menor do maior
        in_termo_1 <= "0001001010001001";
        in_termo_2 <= "0000000000000011";
        select_op_1 <= '0';
        select_op_2 <= '1';
        wait for 50 ns;
        --subtraindo número igual
        in_termo_1 <= "0001101100100000";
        in_termo_2 <= "0001101100100000";
        select_op_1 <= '0';
        select_op_2 <= '1';
        wait for 50 ns;
        --subtraindo número maior do menor, o resultado é dado em complemeto de 2
        in_termo_1 <= "0000011111111111";
        in_termo_2 <= "0000100000000000";
        select_op_1 <= '0';
        select_op_2 <= '1';
        wait for 50 ns;
        --subtração com primeiro termo negativo
        in_termo_1 <= "1001101100100000";
        in_termo_2 <= "0000001100100000";
        select_op_1 <= '0';
        select_op_2 <= '1';
        wait for 50 ns;
        --subtração com segundo termo negativo
        in_termo_1 <= "0000000000000001";
        in_termo_2 <= "1111111111111101";
        select_op_1 <= '0';
        select_op_2 <= '1';
        wait for 50 ns;

    --testes para ver se termo_1>termo_2---
        --termo_1>termo_2, ambos positivos
        in_termo_1 <= "0001001100100000";
        in_termo_2 <= "0000000010000011";
        select_op_1 <= '1';
        select_op_2 <= '0';
        wait for 50 ns;
        --termo_1>termo_2, ambos negativos
        in_termo_1 <= "1100001110000010";
        in_termo_2 <= "1000000000000011";
        select_op_1 <= '1';
        select_op_2 <= '0';
        wait for 50 ns;
        --termo_1>termo_2, primeiro positivo e segundo negativo
        in_termo_1 <= "0100001110000010";
        in_termo_2 <= "1000000000000011";
        select_op_1 <= '1';
        select_op_2 <= '0';
        wait for 50 ns;
        --termo_1=termo_2
        in_termo_1 <= "0000001100100010";
        in_termo_2 <= "0000001100100010";
        select_op_1 <= '1';
        select_op_2 <= '0';
        wait for 50 ns;
        --termo_1<termo_2, ambos positivos
        in_termo_1 <= "0001001100100000";
        in_termo_2 <= "0010000010000011";
        select_op_1 <= '1';
        select_op_2 <= '0';
        wait for 50 ns;
        --termo_1<termo_2, ambos negativos
        in_termo_1 <= "1000001110000010";
        in_termo_2 <= "1100000000000011";
        select_op_1 <= '1';
        select_op_2 <= '0';
        wait for 50 ns;
        --termo_1<termo2, primeiro negativo e segundo positivo
        in_termo_1 <= "1000001100100010";
        in_termo_2 <= "0000001100100010";
        select_op_1 <= '1';
        select_op_2 <= '0';
        wait for 50 ns;

    --testes para ver se termo_1!=termo_2---    
        --termo_1!=termo2
        in_termo_1 <= "0000110000100000";
        in_termo_1 <= "0000000010000011";
        select_op_1 <= '1';
        select_op_2 <= '1';
        wait for 50 ns;
        --termo_=termo2
        in_termo_1 <= "0100001110000010";
        in_termo_2 <= "0100001110000010";
        select_op_1 <= '1';
        select_op_2 <= '1';
        wait for 50 ns;    

        wait;
    end process;
end architecture a_ULA_tb;    