--Alunos: Gabriel Henrique Kwiatkovski Godinho
--        Jhonny Kristyan Vaz-Tostes de Assis

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoDeReg is
    port(   reg_read_1 : out signed(15 downto 0);--leitura
            reg_read_2 : out signed(15 downto 0);--leitura
            reg_write : in signed(15 downto 0);--escrita
            
            select_read_1 : in unsigned(2 downto 0);--registrador que será lido
            select_read_2 : in unsigned(2 downto 0);--registrador que será lido
            select_write : in unsigned(2 downto 0);--registrador que será escrito

            rst_reg : in std_logic;
            clk_reg : in std_logic;
            write_enable : in std_logic);
end entity;

architecture a_bancoDeReg of bancoDeReg is
    -------------------------COMPONENTES------------------------
    component reg16bits
        port(   clk      : in std_logic;
                rst       : in std_logic;
                wr_enable : in std_logic;
                data_in   : in signed(15 downto 0);
                data_out  : out signed(15 downto 0));
    end component;
    
    ------------------------ SINAIS----------------------
    signal clk, reset : std_logic;
    
    signal  wr_enable_1,wr_enable_2,wr_enable_3,wr_enable_4,
            wr_enable_5,wr_enable_6,wr_enable_7,wr_enable_0: std_logic :='0';

    signal  data_out_1,data_out_2,data_out_3,data_out_4,
            data_out_5,data_out_6,data_out_7,data_out_0: signed (15 downto 0);

    constant data_0 : signed (15 downto 0) :="0000000000000000";--registrador 0 é constante

begin
    
    wr_enable_1 <= '1' when select_write="001" and write_enable='1' else
                    '0';
    wr_enable_2 <= '1' when select_write="010" and write_enable='1' else
                    '0';
    wr_enable_3 <= '1' when select_write="011" and write_enable='1' else
                    '0';
    wr_enable_4 <= '1' when select_write="100" and write_enable='1'else
                    '0';
    wr_enable_5 <= '1' when select_write="101" and write_enable='1' else
                    '0';
    wr_enable_6 <= '1' when select_write="110" and write_enable='1' else
                    '0';            
    wr_enable_7 <= '1' when select_write="111" and write_enable='1' else
                    '0';


    reset <= rst_reg;
    clk <= clk_reg;
    ----------------------INSTANCIAS------------------------
    reg1: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_1,
                                data_in=>reg_write,   --data_in=>data_in_1,
                                data_out=>data_out_1
                            );

    reg2: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_2,
                                data_in=>reg_write,
                                data_out=>data_out_2
                            );

    reg3: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_3,
                                data_in=>reg_write,
                                data_out=>data_out_3
                            );

    reg4: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_4,
                                data_in=>reg_write,
                                data_out=>data_out_4
                            );

    reg5: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_5,
                                data_in=>reg_write,
                                data_out=>data_out_5
                            );
                            
    reg6: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_6,
                                data_in=>reg_write,
                                data_out=>data_out_6
                            );

    reg7: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_7,
                                data_in=>reg_write,
                                data_out=>data_out_7
                            );

    reg0: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_0,
                                data_in=>data_0,
                                data_out=>data_out_0
                            );
    
    reg_read_1 <=   data_out_1 when select_read_1="001" else
                    data_out_2 when select_read_1="010" else
                    data_out_3 when select_read_1="011" else
                    data_out_4 when select_read_1="100" else
                    data_out_5 when select_read_1="101" else
                    data_out_6 when select_read_1="110" else
                    data_out_7 when select_read_1="111" else
                    data_out_0;

    reg_read_2 <=   data_out_1 when select_read_2="001" else
                    data_out_2 when select_read_2="010" else
                    data_out_3 when select_read_2="011" else
                    data_out_4 when select_read_2="100" else
                    data_out_5 when select_read_2="101" else
                    data_out_6 when select_read_2="110" else
                    data_out_7 when select_read_2="111" else
                    data_out_0;

                    

end architecture a_bancoDeReg;



               

    