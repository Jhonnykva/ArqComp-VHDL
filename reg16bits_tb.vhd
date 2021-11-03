--Alunos: Gabriel Henrique Kwiatkovski Godinho
--        Jhonny Kristyan Vaz-Tostes de Assis

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits_tb is
end;

architecture a_reg16bits_tb of reg16bits is
    component reg16bits
        port(   clk      : in std_logic;
                rst       : in std_logic;
                wr_enable : in std_logic;
                data_in   : in unsigned(15 downto 0);
                data_out  : out unsigned(15 downto 0);
    end component;
    
        -- 100 ns é o período que escolhi para o clock
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, reset : std_logic;

begin
    uut: teste port map [...]; -- aqui vai a instância do seu componente
    
    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        reset <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 10 us; -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin -- gera clock até que sim_time_proc termine
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    process -- sinais dos casos de teste (p.ex.)
    begin
        wait for 200 ns;
        wr_en <= '0';
        data_in <= "11111111";
        wait for 100 ns;
        data_in <= "10001101";
        [...]                   -- outros casos
        wait;                   -- <== OBRIGATÓRIO TERMINAR COM WAIT; !!!
    end process;
    end architecture ateste_tb;
    



process --clock
begin   
    clk <='0';
    wait for 50 ns;
    clk <='1';
    wait for 50 ns;
end process;

process --reset
begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait;
end process;