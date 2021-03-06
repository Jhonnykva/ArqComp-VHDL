library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador is
    port(
        clk,rst: in STD_LOGIC;
        
        TL_estado: out unsigned(1 downto 0);
        TL_PC: out unsigned(6 downto 0);
        TL_instrucao: out unsigned(16 downto 0);
        TL_regA_out: out signed(15 downto 0);
        TL_regB_out: out signed(15 downto 0);
        TL_ULA_out: out signed(15 downto 0)
    );
end entity processador;

architecture a_processador of processador is
    component maquina_de_estados is
        port
        (
            clk    : IN std_logic ;
            rst    : IN std_logic ;
            estado : OUT unsigned(1 downto 0)
        );
    end component;
    
    component reg7bit is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (6 downto 0);
            data_out : OUT unsigned (6 downto 0)
        );
    end component;
    
    component rom is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (6 downto 0);
            instr    : OUT unsigned (16 downto 0)
        );
    end component;
    
    component uni_controle is
        port
        (
            clk     : IN std_logic ;
            rst     : IN std_logic ;
            instruction  : IN unsigned (16 downto 0);
            jump_en : OUT STD_LOGIC;
            pc_read : out STD_LOGIC;
            estado : in unsigned(1 downto 0);
            rom_read: out STD_LOGIC;
            regWrite: out STD_LOGIC;
            ramWrite: out std_logic;
            slt_ula: out unsigned(1 downto 0);
            ALUsrcA: out std_logic;
            ALUsrcB: out std_logic;
            slt_reg_read_1: out unsigned(2 downto 0);
            slt_reg_read_2: out unsigned(2 downto 0);
            slt_reg_write: out unsigned(2 downto 0);
            ula_out_2: in STD_LOGIC
        );
    end component;
    
    component reg17bit is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (16 downto 0);
            data_out : OUT unsigned (16 downto 0)
        );
    end component;
    
    component reg16bit is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN signed (15 downto 0);
            data_out : OUT signed (15 downto 0)
        );
    end component;
    
    component ULA is
        port
        (
            in_termo_1 : IN signed (15 downto 0);
            in_termo_2 : IN signed (15 downto 0);
            select_op  : IN unsigned (1 downto 0);
            out_op_1   : OUT signed (15 downto 0);
            out_op_2   : OUT std_logic
        );
    end component;
    
    component bancoreg is
        port
        (
            slt_read1   : IN unsigned (2 downto 0);
            slt_read2   : IN unsigned (2 downto 0);
            dados_write : IN signed (15 downto 0);
            slt_write   : IN unsigned (2 downto 0);
            wr_en       : IN STD_LOGIC ;
            clk         : IN STD_LOGIC ;
            rst         : IN STD_LOGIC ;
            dados_read1 : OUT signed (15 downto 0);
            dados_read2 : OUT signed (15 downto 0)
        );
    end component;
    
    component mux1x2 is
        port
        (
            slt  : IN std_logic ;
            in0  : IN signed (15 downto 0);
            in1  : IN signed (15 downto 0);
            out0 : OUT signed (15 downto 0)
        );
    end component;

    component RAM is
        port
        (
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            wr_en    : in std_logic;
            dado_in  : in signed(15 downto 0);
            dado_out : out signed(15 downto 0) 
        );
    end component;
    
    signal estado: unsigned(1 downto 0);
    
    signal pc_read: STD_LOGIC;
    signal pc_in, pc_out: unsigned(6 downto 0);
    
    signal instruction,rom_out,ir_out: unsigned(16 downto 0):= "00000000000000000";
    
    signal jump_en,rom_read: STD_LOGIC;
    
    signal cte: signed(7 downto 0);
    signal regWrite,ramWrite: STD_LOGIC;
    signal slt_ula: unsigned(1 downto 0);
    signal slt_reg_read_1, slt_reg_read_2, slt_reg_write: unsigned(2 downto 0);
    signal ALUsrcA,ALUsrcB: std_logic;
    
    signal banco_out_1,banco_out_2,regA_out,regB_out,out_mux,out_op_1,out_mux2: signed(15 downto 0);
    signal out_op_2: STD_LOGIC:='0';
    
    signal in1:signed(15 downto 0);

    signal ram_out:signed(15 downto 0);
    
begin

    state: maquina_de_estados port map(
        clk => clk,
        rst => rst,
        estado => estado
    );
    
    pc: reg7bit port map(
        clk      =>clk ,
        rst      =>rst ,
        wr_en    =>pc_read ,
        data_in  =>pc_in ,
        data_out =>pc_out
    );
    
    mem_rom: rom port map(
        clk      =>clk,
        endereco =>pc_out,
        instr    =>rom_out
    );
    
    uc: uni_controle port map(
        clk     => clk,
        rst     => rst,
        instruction  =>rom_out,
        jump_en =>jump_en,
        pc_read =>pc_read,
        estado =>estado,
        rom_read=>rom_read,
        regWrite =>regWrite ,
        ramWrite=>ramWrite,
        slt_ula =>slt_ula,
        ALUsrcA =>ALUsrcA,
        ALUsrcB =>ALUsrcB,
        slt_reg_read_1=>slt_reg_read_1,
        slt_reg_read_2=>slt_reg_read_2,
        slt_reg_write=>slt_reg_write,
        ula_out_2=>out_op_2
    );
    
    ir: reg17bit port map(
        clk      =>clk,
        rst      =>rst,
        wr_en    =>rom_read,
        data_in  =>rom_out,
        data_out =>ir_out
    );
    
    regA: reg16bit port map(
        clk=>clk,
        rst=>rst,
        wr_en=>'1',
        data_in=>banco_out_1,
        data_out=>regA_out
    );
    
    regB: reg16bit port map(
        clk=>clk,
        rst=>rst,
        wr_en=>'1',
        data_in=>banco_out_2,
        data_out=>regB_out
    );
    
    alu: ULA port map(
        in_termo_1=>out_mux,
        in_termo_2=>out_mux2,
        select_op=>slt_ula,
        out_op_1=>out_op_1,
        out_op_2=>out_op_2
    );
    
    banco_reg: bancoreg port map(
        slt_read1=>slt_reg_read_1,
        slt_read2=>slt_reg_read_2,
        dados_write=>out_op_1,
        slt_write=>slt_reg_write,
        wr_en=>regWrite,
        clk=>clk,
        rst=>rst,
        dados_read1=>banco_out_1,
        dados_read2=>banco_out_2
    );
    
    mux_regA: mux1x2 port map(
        slt=>ALUsrcA,
        in0=>regA_out,
        in1=>in1,
        out0=>out_mux
    );

    mux_regB: mux1x2 port map(
        slt=>ALUsrcB,
        in0=>banco_out_2,
        in1=>ram_out,
        out0=>out_mux2
    );

    ram1: RAM port map(
        clk=>clk,
        endereco=>unsigned(banco_out_1(6 downto 0)),
        wr_en =>ramWrite,
        dado_in =>out_op_1,
        dado_out=>ram_out
    );

    cte<=signed(ir_out(7 downto 0));
    in1<=signed("00000000" & ir_out(7 downto 0));
    
    pc_in <= pc_out + 1 when jump_en = '0' else
    pc_out+1+ir_out(6 downto 0) when jump_en='1' and ir_out(16 downto 9)="00001000" else
    ir_out(6 downto 0) when jump_en='1' else
    "0000000";
    
    TL_estado<= estado;
    TL_PC<=pc_out;
    TL_instrucao<=ir_out;
    TL_regA_out<=regA_out;
    TL_regB_out<=regB_out;
    TL_ULA_out<=out_op_1;

end architecture ;