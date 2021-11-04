--Alunos: Gabriel Henrique Kwiatkovski Godinho
--        Jhonny Kristyan Vaz-Tostes de Assis

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
entity gerenciador_tb is
end entity;
  
architecture a_gerenciador_tb of gerenciador_tb is
      -------------------------COMPONENTES------------------------
      component gerenciador
        port(   reg_1 : out signed (15 downto 0);--leitura
                reg_2 : out signed (15 downto 0);--leitura
                reg_3 : in signed (15 downto 0);--escrita

                select_reg_1 : in unsigned (2 downto 0);--registrador que será lido
                select_reg_2 : in unsigned (2 downto 0);--registrador que será lido
                select_reg_3 : in unsigned (2 downto 0);--registrador que será escrito

                wr_enable : in std_logic;
                rst_reg : in std_logic;
                clk_reg : in std_logic;
                
                select_op_1 : std_logic;
                select_op_2 : std_logic;

                ULA_out_1 : out signed (15 downto 0);
                ULA_out_2 : out std_logic);
      end component;


    signal reg_1, reg_2, reg_3: signed(15 downto 0);
    signal select_reg_1, select_reg_2, select_reg_3: unsigned(2 downto 0);
    signal rst_reg, clk_reg, wr_enable: std_logic;
    signal select_op_1, select_op_2: std_logic;
    signal ULA_out_1: signed (15 downto 0);
    signal ULA_out_2: std_logic;
    
    begin  
      uut: gerenciador port map(  reg_1=>reg_1,
                                  reg_2=>reg_2,
                                  reg_3=>reg_3,
                                  select_reg_1=>select_reg_1,
                                  select_reg_2=>select_reg_2,
                                  select_reg_3=>select_reg_3,
                                  rst_reg=>rst_reg,
                                  clk_reg=>clk_reg,
                                  wr_enable=>wr_enable,
                                  select_op_1=>select_op_2,
                                  ULA_out_1=>ULA_out_1,
                                  ULA_out_2=>ULA_out_2);


----------TESTES----------
end architecture a_gerenciador_tb;


