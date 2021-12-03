library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_controle_tb is
end entity uni_controle_tb;

architecture a_uni_controle_tb of uni_controle_tb is
    component uni_controle
    port(
        clk :in std_logic;
        rst :in std_logic;
        top_lvl: out unsigned(16 downto 0)
        
    );
end component;

constant period_time : time := 100 ns;
signal finished : std_logic := '0';
signal clk, reset : std_logic;
signal top_lvl: unsigned(16 downto 0);

begin
    uut: uni_controle port map(
        clk=>clk,
        rst=>reset,
        top_lvl=>top_lvl
    );

    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        reset <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 1400 ns;
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

    process
    begin
        wait for 200 ns;

        wait;
    end process;

end architecture a_uni_controle_tb;