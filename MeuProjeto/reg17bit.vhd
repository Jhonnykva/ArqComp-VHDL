library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg17bit is
    port(
        clk :in std_logic;
        rst :in std_logic;
        wr_en: in std_logic;
        data_in: in unsigned(16 downto 0);
        data_out: out unsigned(16 downto 0)
    );
end entity reg17bit;

architecture a_reg17bit of reg17bit is
    signal registro: unsigned(16 downto 0);
begin

   process (clk,rst,wr_en)
   begin
       if rst='1' then
           registro<="00000000000000000";
       elsif wr_en='1' then
           if rising_edge(clk) then
               registro<=data_in;
           end if;
       end if;
   end process;
   
   data_out <= registro;

end architecture a_reg17bit;