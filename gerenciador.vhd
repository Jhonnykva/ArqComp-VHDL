--Alunos: Gabriel Henrique Kwiatkovski Godinho
--        Jhonny Kristyan Vaz-Tostes de Assis

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
    
entity gerenciador is
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
end entity;

        
architecture a_gerenciador of gerenciador is
-------------------------COMPONENTES------------------------
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


 
    signal sselect_reg_1, sselect_reg_2, sselect_reg_3: unsigned(2 downto 0);
    signal swr_enable, srst_reg, sclk_reg : std_logic;
    signal bancoRegToUla_1, bancoRegToUla_2, sULA_out_1 : signed (15 downto 0);
    signal sselect_op_1, sselect_op_2, sULA_out_2 : std_logic;
    signal reg_write_3, sreg_1, sreg_2 : signed (15 downto 0);

begin
    --valores dos registradores
    reg_write_3 <= reg_3;

    --id do registrador
    sselect_reg_1 <= select_reg_1;
    sselect_reg_2 <= select_reg_2;
    sselect_reg_3 <= select_reg_3;

    --seleção de operações da ULA
    sselect_op_1 <= select_op_1;
    sselect_op_2 <= select_op_2;

    --sinais adicionais
    swr_enable <= wr_enable;
    srst_reg <= rst_reg;
    sclk_reg <= clk_reg;

    

    bancoReg1: bancoDeReg port map  (   reg_read_1=>sreg_1,
                                        reg_read_2=>sreg_2,
                                        reg_write_3=>reg_write_3,
                                        select_reg_1=>sselect_reg_1,
                                        select_reg_2=>sselect_reg_2,
                                        select_reg_3=>sselect_reg_3,
                                        rst_reg=>srst_reg,
                                        clk_reg=>sclk_reg,
                                        write_enable=>swr_enable
                                    );
    
    bancoRegToUla_1 <= sreg_1;
    bancoRegToUla_2 <= sreg_2;

    ula1: ULA port map  (   in_termo_1=>bancoRegToUla_1,
                            in_termo_2=> bancoRegToUla_2,
                            select_op_1=>sselect_op_1,
                            select_op_2=>sselect_op_2,
                            out_op_1=>sULA_out_1,
                            out_op_2=>sULA_out_2
                        );

    --sreg_3 <= sULA_out_1;

end architecture a_gerenciador;