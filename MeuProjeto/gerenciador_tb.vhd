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
            slt_mux         : IN unsigned (2 downto 0);
            debug_top_level : OUT signed (15 downto 0)
        );
    end component;
begin

    [concurrent statements]

end architecture a_gerenciador_tb;