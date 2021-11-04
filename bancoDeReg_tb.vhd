--Alunos: Gabriel Henrique Kwiatkovski Godinho
--        Jhonny Kristyan Vaz-Tostes de Assis

    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
entity bancoDeReg_tb is
end entity;
    
  architecture a_bancoDeReg_tb of bancoDeReg_tb is
        -------------------------COMPONENTES------------------------
        component reg16bits
            port(   clk      : in std_logic;
                    rst       : in std_logic;
                    wr_enable : in std_logic;
                    data_in   : in unsigned(15 downto 0);
                    data_out  : out unsigned(15 downto 0));
        end component;
  
        component bancoDeReg is
          port(   reg_in_1 : in unsigned(15 downto 0);
                  reg_in_2 : in unsigned(15 downto 0);
                  reg_in_3 : in unsigned(15 downto 0);
                  
                  select_reg_1 : in unsigned(2 downto 0);
                  select_reg_2 : in unsigned(2 downto 0);
                  select_reg_3 : in unsigned(2 downto 0);
      
                  rst_reg : in std_logic;
                  clk_reg : in std_logic;
                  write_enable : in std_logic);
        end component;
  
    signal reg_in_1, reg_in_2, reg_in_3: unsigned(15 downto 0);
    signal select_reg_1, select_reg_2, select_reg_3: unsigned(2 downto 0);
    signal reset, clk, write_enable: std_logic;
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

      
    begin  
        uut: bancoDeReg port map(   reg_in_1=>reg_in_1,
                                    reg_in_2=>reg_in_2,
                                    reg_in_3=>reg_in_3,
                                    select_reg_1=>select_reg_1,
                                    select_reg_2=>select_reg_2,
                                    select_reg_3=>select_reg_3,
                                    rst_reg=>reset,
                                    clk_reg=>clk,
                                    write_enable=>write_enable
                                );
  
  
  ----------TESTES----------

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

    
    process 
    begin
        wait for 200 ns;
        reg_in_1 <= "0000000000000111";
        reg_in_2 <= "0000000000001111";
        select_reg_1 <= "100";
        select_reg_2 <= "001";
        select_reg_3 <= "110";
        write_enable <= '0';
        wait for 200 ns;
        reg_in_1 <= "0000000000000001";
        reg_in_2 <= "0000000000000010";
        select_reg_1 <= "010";
        select_reg_2 <= "011";
        select_reg_3 <= "100";
        write_enable <= '1';
        wait for 200 ns;
        reg_in_1 <= "0000000000000010";
        reg_in_2 <= "0000000000000011";
        select_reg_1 <= "001";
        select_reg_2 <= "010";
        select_reg_3 <= "011";
        write_enable <= '1';
        wait;
    end process;
end architecture a_bancoDeReg_tb;