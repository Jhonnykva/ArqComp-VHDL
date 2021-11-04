library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gerenciador is
    port(
        top_level: in signed(15 downto 0);
        clk,rst,wr_en: in STD_LOGIC;
        
        slt_ula: in unsigned(1 downto 0);
        slt_reg_read_1, slt_reg_read_2, slt_reg_write, slt_mux: in unsigned(2 downto 0);
        
        debug_top_level: out signed(15 downto 0)
    );
end entity gerenciador;

architecture a_gerenciador of gerenciador is
    component ULA is
        port
        (
            in_termo_1  : IN signed (15 downto 0);
            in_termo_2  : IN signed (15 downto 0);
            select_op   : IN unsigned(1 downto 0);
            out_op_1    : OUT signed (15 downto 0);
            out_op_2    : OUT std_logic
        );
    end component;
    
    component bancoreg is
        port
        (
            slt_read1   : IN unsigned (2 downto 0);
            slt_read2   : IN unsigned (2 downto 0);
            dados_write : IN signed (15 downto 0);
            slt_write   : IN signed (2 downto 0);
            wr_en       : IN STD_LOGIC ;
            clk         : IN STD_LOGIC ;
            rst         : IN STD_LOGIC ;
            dados_read1 : OUT signed (15 downto 0);
            dados_read2 : OUT signed (15 downto 0)
        );
    end component;
    
    component mux2x4 is
        port
        (
            slt  :  unsigned (1 downto 0);
            in0  : IN signed (15 downto 0);
            in1  : IN signed (15 downto 0);
            in2  : IN signed (15 downto 0);
            in3  : IN signed (15 downto 0);
            out0 : OUT signed (15 downto 0)
        );
    end component;
    
    signal out_banco_1,out_banco_2,out_mux,out_ULA: signed(15 downto 0);
    signal out_ULA_2: STD_LOGIC;
    
begin
    ULA1 : ULA port map(
        in_termo_1=>out_banco_1, 
        in_termo_2=>out_mux,
        select_op=>slt_ula, 
        out_op_1=>out_ULA, 
        out_op_2=>out_ULA_2 
    );
    
    banco: bancoreg port map(
        slt_read1=>slt_reg_read_1, 
        slt_read2=>slt_reg_read_2, 
        dados_write=>out_ULA, 
        slt_write=>slt_reg_write, 
        wr_en=>wr_en, 
        clk=>clk, 
        rst=>rst, 
        dados_read1=>out_banco_1, 
        dados_read2=>out_banco_2
    );
    
    mux: mux2x4 port map(
        slt=>slt_mux, 
        in0=>out_banco_2, 
        in1=>top_level, 
        in2=>"0000000000000000", 
        in3=>"0000000000000000", 
        out0=>out_mux
    );
    
    debug_top_level<=out_ULA;


end architecture a_gerenciador;