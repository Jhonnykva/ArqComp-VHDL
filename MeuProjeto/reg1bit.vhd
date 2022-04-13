library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg1bit is
    port(
        clk :in std_logic;
        rst :in std_logic;
        wr_en: in std_logic;
        data_in: in STD_LOGIC;
        data_out: out STD_LOGIC
    );
end entity reg1bit;

architecture a_reg1bit of reg1bit is
    signal registro: STD_LOGIC;
begin

   process (clk,rst,wr_en)
   begin
       if rst='1' then
           registro<='0';
       elsif wr_en='1' then
           if rising_edge(clk) then
               registro<=data_in;
           end if;
       end if;
   end process;
   
   data_out <= registro;

end architecture a_reg1bit;