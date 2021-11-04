library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gerenciador_tb is
end entity gerenciador_tb;

architecture a_gerenciador_tb of gerenciador_tb is
    component gerenciador is
        port
        (
            top_level       : IN signed (15 downto 0);
            clk             : IN STD_LOGIC ;
            rst             : IN STD_LOGIC ;
            wr_en           : IN STD_LOGIC ;
            slt_ula         : IN unsigned (1 downto 0);
            slt_reg_read_1  : IN unsigned (2 downto 0);
            slt_reg_read_2  : IN unsigned (2 downto 0);
            slt_reg_write   : IN unsigned (2 downto 0);
            ALUscr          : IN std_logic; 
            debug_top_level : OUT signed (15 downto 0)
        );
    end component;


    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, reset : std_logic;

    signal top_level :signed (15 downto 0);
    signal wr_en : std_logic;
    signal slt_ula : unsigned (1 downto 0);
    signal slt_reg_read_1, slt_reg_read_2, slt_reg_write :  unsigned (2 downto 0);
    


begin

    uut: gerenciador port map(  top_level=>top_level,
                                clk=>clk,
                                rst=>reset,
                                wr_en=>wr_en,
                                slt_ula=>slt_ula,
                                slt_reg_read_1=>slt_reg_read_1,
                                slt_reg_read_2=>slt_reg_read_2,
                                slt_reg_write=>slt_reg_write
                                ALUscr=>ALUscr
                                debug_top_level=>debug_top_level);

--TESTES

    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        reset <= '0';
        wait;
    end process;
  
    sim_time_proc: process
    begin
        wait for 900 ns;
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

end architecture a_gerenciador_tb;