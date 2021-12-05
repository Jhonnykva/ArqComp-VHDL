library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador_tb is
end entity processador_tb;

architecture a_processador_tb of processador_tb is
    component processador is
        port
        (
            clk          : IN STD_LOGIC ;
            rst          : IN STD_LOGIC ;
            TL_estado    : OUT unsigned(1 downto 0);
            TL_PC        : OUT unsigned (6 downto 0);
            TL_instrucao : OUT unsigned (16 downto 0);
            TL_regA_out  : OUT signed (15 downto 0);
            TL_regB_out  : OUT signed (15 downto 0);
            TL_ULA_out   : OUT signed (15 downto 0)
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, reset : std_logic;
    
    signal TL_estado : unsigned(1 downto 0);
    signal TL_PC: unsigned(6 downto 0);
    signal TL_instrucao: unsigned(16 downto 0);
    signal TL_regA_out, TL_regB_out, TL_ULA_out: signed(15 downto 0);
    
begin

    uut: processador port map (
        clk => clk,
        rst => reset,
        TL_estado=>TL_estado,
        TL_PC=>TL_PC,
        TL_instrucao=>TL_instrucao,
        TL_regA_out=>TL_regA_out,
        TL_regB_out=>TL_regB_out,
        TL_ULA_out=>TL_ULA_out
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
        wait for 260000 ns;
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