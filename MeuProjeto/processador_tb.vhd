library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador_tb is
end entity processador_tb;

architecture a_processador_tb of processador_tb is
    component processador is
        port
        (
            clk : IN STD_LOGIC ;
            rst : IN STD_LOGIC
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, reset : std_logic;
    
begin

    uut: processador port map (
        clk => clk,
        rst => reset
    );
    
    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2; 
        reset <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 1800 ns;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin 
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
        
        wait;
    end process;

end architecture ;