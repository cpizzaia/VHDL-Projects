library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity debounce is
  port(CLK,BTN : in std_logic; 
       pulse  : out std_logic);
end debounce;


architecture arch_debounce of debounce is
  signal count  : std_logic_vector (0 to 16);
begin
  process (CLK)
  begin
    
    if BTN = '1' then
      count <= "00000000000000001";
    elsif (clk'EVENT and CLK = '1') then
      if (count /= "00000000000000000") then count <= count + 1; 
      end if;
    end if;
    
    if(clk'EVENT and CLK = '1') then
      if(count = "10000000000000000") and (BTN = '0') then pulse <= '1';
      else pulse <= '0'; 
      end if;
    end if;
    
  end process;
end arch_debounce;