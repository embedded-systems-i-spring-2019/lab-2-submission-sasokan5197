library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Debounce is
Port (btn, clk : in std_logic;	
 dbnc : out std_logic);	
end Debounce;

architecture behavioral of Debounce is
  signal count : std_logic_vector (21 downto 0) := (others => '0');
  signal shift_register : std_logic_vector(1 downto 0) := (others => '0');
begin

process(clk) begin
  if rising_edge(clk) then
    shift_register(1) <= shift_register(0);
    shift_register(0) <= btn;
    if (unsigned(count) < 2500000) then
      dbnc <= '0';
      if shift_register(1) = '1' then
        count <= std_logic_vector( unsigned(count) + 1 ); 
      else count <= (others => '0'); 
    end if;
    else dbnc <= '1';	
         if (btn = '0') then
           dbnc <= '0'; 
           count <= (others => '0'); 
         end if;
end if;
end if;
end process;

end behavioral;