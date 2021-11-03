--Alunos: Gabriel Henrique Kwiatkovski Godinho
--        Jhonny Kristyan Vaz-Tostes de Assis

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoDeReg is
end;

architecture a_bancoDeReg of bancoDeReg is
    component reg16bits
        port(   clk      : in std_logic;
                rst       : in std_logic;
                wr_enable : in std_logic;
                data_in   : in unsigned(15 downto 0);
                data_out  : out unsigned(15 downto 0);
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, reset : std_logic;
    
    signal  wr_enable_1,wr_enable_2,wr_enable_3,wr_enable_4,
            wr_enable_5,wr_enable_6,wr_enable_7,wr_enable_0: std_logic :='0';
        
    signal  data_in_1,data_in_2,data_in_3,data_in_4,
            data_in_5,data_in_6,data_in_7: signed (15 downto 0);

    signal  data_out_1,data_out_2,data_out_3,data_out_4,
            data_out_5,data_out_6,data_out_7,data_out_0,: signed (15 downto 0);

    constant data_in_0 : signed (15 downto 0) :='0000000000000000';--registrador 0 é constante


begin
    
    reg1: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_1,
                                data_in=>data_in_1,
                                data_out=>data_out_1
                            );

    reg2: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_2,
                                data_in=>data_in_2,
                                data_out=>data_out_2
                            );

    reg3: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_3,
                                data_in=>data_in_3,
                                data_out=>data_out_3
                            );

    reg4: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_4,
                                data_in=>data_in_4,
                                data_out=>data_out_4
                            );

    reg5: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_5,
                                data_in=>data_in_5,
                                data_out=>data_out_5
                            );
                            
    reg6: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_6,
                                data_in=>data_in_6,
                                data_out=>data_out_6
                            );

    reg7: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_7,
                                data_in=>data_in_7,
                                data_out=>data_out_7
                            );

    reg0: reg16bits port map (  clk=>clk,
                                rst=>reset,
                                wr_enable=>wr_enable_0,
                                data_in=>data_in_0,
                                data_out=>data_out_0
                            );
                            
               

    