--Alunos: Gabriel Henrique Kwiatkovski Godinho
--        Jhonny Kristyan Vaz-Tostes de Assis

  library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  
  entity gerenciador_tb is
  end entity;
  
architecture a_gerenciador_tb of gerenciador_tb is
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
                clk_reg : in std_logic);
      end component;

      component ULA
        port(   in_termo_1 : in signed (15 downto 0);
                in_termo_2 : in signed (15 downto 0);

                select_op_1 : in std_logic;
                select_op_2 : in std_logic;

                out_op_1 : out signed (15 downto 0);
                out_op_2 : out std_logic);
      end component;

    signal reg_in_1, reg_in_2, reg_in_3: unsigned(15 downto 0);
    signal select_reg_1, select_reg_2, select_reg_3: unsigned(2 downto 0);
    signal rst_reg, clk_reg: std_logic;
    
    begin  
      uut: bancoDeReg port map(   reg_in_1=>reg_in_1,
                                  reg_in_2=>reg_in_2,
                                  reg_in_3=>reg_in_3,
                                  select_reg_1=>select_reg_1,
                                  select_reg_2=>select_reg_2,
                                  select_reg_3=>select_reg_3,
                                  rst_reg=>rst_reg,
                                  clk_reg=>clk_reg
                              );


----------TESTES----------
end architecture a_gerenciador_tb;


