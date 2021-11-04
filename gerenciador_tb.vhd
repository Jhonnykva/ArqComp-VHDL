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
                  data_in   : in signed(15 downto 0);
                  data_out  : out signed(15 downto 0));
      end component;

      component bancoDeReg is
        port(   reg_read_1 : out signed(15 downto 0);--leitura
                reg_read_2 : out signed(15 downto 0);--leitura
                reg_write_3 : in signed(15 downto 0);--escrita
                
                select_reg_1 : in unsigned(2 downto 0);--registrador que será lido
                select_reg_2 : in unsigned(2 downto 0);--registrador que será lido
                select_reg_3 : in unsigned(2 downto 0);--registrador que será escrito

                rst_reg : in std_logic;
                clk_reg : in std_logic;
                write_enable : in std_logic);
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
      --uut: gerenciador port map();


----------TESTES----------
end architecture a_gerenciador_tb;


