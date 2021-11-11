library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_control is 
    port(
        clk :in std_logic;
        rst :in std_logic;
        wr_en: in std_logic;
        data_in: in signed(15 downto 0);
        data_out: out signed(15 downto 0);
        incrementa: in std_logic

    );    
end entity PC_control;

architecture a_PC_control of PC_control is
    component reg16bit
        port(
            clk :in std_logic;
            rst :in std_logic;
            wr_en: in std_logic;
            data_in: in signed(15 downto 0);
            data_out: out signed(15 downto 0)
        );
    end component;

    signal resultado: signed(15 downto 0):="0000000000000000";
begin
    PC: reg16bit port map( clk=>clk,
                            rst=>rst,
                            wr_en=>wr_en,
                            data_in=>resultado,
                            data_out=>data_out
                        );

    
    resultado <=    resultado+1 when incrementa = '1' and rising_edge(clk) else
                    resultado;
    
end architecture a_PC_control;