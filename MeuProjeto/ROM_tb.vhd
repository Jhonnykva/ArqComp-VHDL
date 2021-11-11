library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_tb is 
end;

architecture a_ROM_tb of ROM_tb is
    component ROM
        port(   clk : in std_logic;
                endereco : in unsigned(6 downto 0);--memória de programa = 4Kbytes 4000bytes = 32000 bits
                dado : out signed(16 downto 0)    --32000/17=1882 endereços de 17 bits
            );
    end component;

    signal endereco : unsigned(6 downto 0);
    signal dado : signed(16 downto 0);

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, reset : std_logic;

    begin
        uut: ROM port map(  clk=>clk,
                            endereco=>endereco,
                            dado=>dado
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
        wait for 700 ns;
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
       
        endereco <= "0000000";
        wait for 100 ns;

        endereco <= "0000001";
        wait for 100 ns;

        endereco <= "0000010";
        wait for 100 ns;

        endereco <= "0000111";
        wait for 100 ns;

        endereco <= "1000111";
        wait;
    end process;
    end architecture a_ROM_tb;