library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bancoreg is
    port(
        slt_read1: in unsigned(2 downto 0);
        slt_read2: in unsigned(2 downto 0);
        dados_write: in unsigned(15 downto 0);
        slt_write: in unsigned(2 downto 0);
        wr_en: in STD_LOGIC;
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        
        dados_read1: out unsigned(15 downto 0);
        dados_read2: out unsigned(15 downto 0)
    );
end entity bancoreg;

architecture a_bancoreg of bancoreg is
    component reg16bit is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal wr_en1,wr_en2,wr_en3,wr_en4,wr_en5,wr_en6,wr_en7: STD_LOGIC :='0';
    signal data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7: unsigned(15 downto 0);
    constant wr_en0:STD_LOGIC:='0';
    
begin

    reg0: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en0, data_in=>dados_write, data_out=>data_out0);
    reg1: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en1, data_in=>dados_write, data_out=>data_out1);
    reg2: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en2, data_in=>dados_write, data_out=>data_out2);
    reg3: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en3, data_in=>dados_write, data_out=>data_out3);
    reg4: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en4, data_in=>dados_write, data_out=>data_out4);
    reg5: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en5, data_in=>dados_write, data_out=>data_out5);
    reg6: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en6, data_in=>dados_write, data_out=>data_out6);
    reg7: reg16bit port map(clk=>clk, rst=>rst, wr_en=>wr_en7, data_in=>dados_write, data_out=>data_out7);
    
    wr_en1<='1' when slt_write = "001" else '0';
    wr_en2<='1' when slt_write = "010" else '0';
    wr_en3<='1' when slt_write = "011" else '0';
    wr_en4<='1' when slt_write = "100" else '0';
    wr_en5<='1' when slt_write = "101" else '0';
    wr_en6<='1' when slt_write = "110" else '0';
    wr_en7<='1' when slt_write = "111" else '0';
    
    dados_read1 <= data_out0 when slt_read1 ="000" else
                    data_out1 when slt_read1 ="001" else
                    data_out2 when slt_read1 ="010" else
                    data_out3 when slt_read1 ="011" else
                    data_out4 when slt_read1 ="100" else
                    data_out5 when slt_read1 ="101" else
                    data_out6 when slt_read1 ="110" else
                    data_out7 when slt_read1 ="111" else
                    "0000000000000000";
    
    dados_read2 <= data_out0 when slt_read2 ="000" else
                    data_out1 when slt_read2 ="001" else
                    data_out2 when slt_read2 ="010" else
                    data_out3 when slt_read2 ="011" else
                    data_out4 when slt_read2 ="100" else
                    data_out5 when slt_read2 ="101" else
                    data_out6 when slt_read2 ="110" else
                    data_out7 when slt_read2 ="111" else
                    "0000000000000000";

end architecture a_bancoreg;