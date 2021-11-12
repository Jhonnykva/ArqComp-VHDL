library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_control_tb is    
end entity PC_control_tb;

architecture a_PC_control_tb of PC_control_tb is
    component PC_control
        port(
            clk :in std_logic;
            rst :in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0);
            top_lvl: out unsigned(16 downto 0)
            
        );
    end component;

    signal wr_en: std_logic;
    signal data_in, data_out: unsigned(6 downto 0);

    constant period_time : time := 50 ns;
    signal finished : std_logic := '0';
    signal clk, reset : std_logic;
    signal top_lvl: unsigned(16 downto 0);

begin
    uut: PC_control port map(   clk=>clk,
                                rst=>reset,
                                wr_en=>wr_en,
                                data_in=>data_in,
                                data_out=>data_out,
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
        wait for 600 ns;
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
        wait for 100 ns;
        wr_en <='1';
        data_in <="0000000";
        wait for 50 ns;
        wr_en <='0';
        wait for 100 ns;
        wr_en <='1';
        wait;
    end process;

end architecture a_PC_control_tb;