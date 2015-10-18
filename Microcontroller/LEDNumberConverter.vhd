library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LEDNumberConverter is
  port(PC,RF : in std_logic_vector(0 to 7);
       IM : in std_logic_vector(0 to 15);
       btn1,btn2,btn3,btn4 : in std_logic;
       statep3,statep2,statep1,statep0 : out std_logic_vector(0 to 7));
end entity;

architecture arch_LEDNumberConverter of LEDNumberConverter is
signal convert_vector : std_logic_vector(0 to 15);
begin
  
Decode: process(convert_vector)
begin
  
  case convert_vector(0 to 3) is
    
  when "0000" =>
    statep3 <= "00000011";
  
  when "0001" =>
    statep3 <= "10011111";
  
  when "0010" =>
    statep3 <= "00100101";
    
  when "0011" =>
    statep3 <= "00001101";
    
  when "0100" =>
    statep3 <= "10011001";
    
  when "0101" =>
    statep3 <= "01001001";
    
  when "0110" =>
    statep3 <= "01000001";
    
  when "0111" =>
    statep3 <= "00011111";
    
  when "1000" =>
    statep3 <= "00000001";
    
  when "1001" =>
    statep3 <= "00001001";
    
  when "1010" =>
    statep3 <= "00010001";
    
  when "1011" =>
    statep3 <= "11000001";
    
  when "1100" =>
    statep3 <= "01100011";
    
  when "1101" =>
    statep3 <= "10000101";
    
  when "1110" =>
    statep3 <= "01100001";
    
  when "1111" =>
    statep3 <= "01110001";
    
  when others =>
    statep3 <= "00000000";
    
  end case;
  
  case convert_vector(4 to 7) is
    
  when "0000" =>
    statep2 <= "00000011";
  
  when "0001" =>
    statep2 <= "10011111";
  
  when "0010" =>
    statep2 <= "00100101";
    
  when "0011" =>
    statep2 <= "00001101";
    
  when "0100" =>
    statep2 <= "10011001";
    
  when "0101" =>
    statep2 <= "01001001";
    
  when "0110" =>
    statep2 <= "01000001";
    
  when "0111" =>
    statep2 <= "00011111";
    
  when "1000" =>
    statep2 <= "00000001";
    
  when "1001" =>
    statep2 <= "00001001";
    
  when "1010" =>
    statep2 <= "00010001";
    
  when "1011" =>
    statep2 <= "11000001";
    
  when "1100" =>
    statep2 <= "01100011";
    
  when "1101" =>
    statep2 <= "10000101";
    
  when "1110" =>
    statep2 <= "01100001";
    
  when "1111" =>
    statep2 <= "01110001";
    
  when others =>
    statep2 <= "00000000";
    
  end case;
  
  case convert_vector(8 to 11) is
    
  when "0000" =>
    statep1 <= "00000011";
  
  when "0001" =>
    statep1 <= "10011111";
  
  when "0010" =>
    statep1 <= "00100101";
    
  when "0011" =>
    statep1 <= "00001101";
    
  when "0100" =>
    statep1 <= "10011001";
    
  when "0101" =>
    statep1 <= "01001001";
    
  when "0110" =>
    statep1 <= "01000001";
    
  when "0111" =>
    statep1 <= "00011111";
    
  when "1000" =>
    statep1 <= "00000001";
    
  when "1001" =>
    statep1 <= "00001001";
    
  when "1010" =>
    statep1 <= "00010001";
    
  when "1011" =>
    statep1 <= "11000001";
    
  when "1100" =>
    statep1 <= "01100011";
    
  when "1101" =>
    statep1 <= "10000101";
    
  when "1110" =>
    statep1 <= "01100001";
    
  when "1111" =>
    statep1 <= "01110001";
    
  when others =>
    statep1 <= "00000000";
    
  end case;
  
  case convert_vector(12 to 15) is
    
  when "0000" =>
    statep0 <= "00000011";
  
  when "0001" =>
    statep0 <= "10011111";
  
  when "0010" =>
    statep0 <= "00100101";
    
  when "0011" =>
    statep0 <= "00001101";
    
  when "0100" =>
    statep0 <= "10011001";
    
  when "0101" =>
    statep0 <= "01001001";
    
  when "0110" =>
    statep0 <= "01000001";
    
  when "0111" =>
    statep0 <= "00011111";
    
  when "1000" =>
    statep0 <= "00000001";
    
  when "1001" =>
    statep0 <= "00001001";
    
  when "1010" =>
    statep0 <= "00010001";
    
  when "1011" =>
    statep0 <= "11000001";
    
  when "1100" =>
    statep0 <= "01100011";
    
  when "1101" =>
    statep0 <= "10000101";
    
  when "1110" =>
    statep0 <= "01100001";
    
  when "1111" =>
    statep0 <= "01110001";
    
  when others =>
    statep0 <= "00000000";
    
  end case;
end process Decode;

Assign: process(btn1,btn2,btn3,btn4,PC,RF,IM)
begin
  if(btn1 = '1') then
    convert_vector <= IM;
  elsif(btn2 = '1') then
    convert_vector <= "00000000" & PC;
  elsif(btn3 = '1') then
    convert_vector <= "00000000" & RF;
  elsif(btn4 = '1') then
    convert_vector <= "000000000000" & IM(0 to 3);
  else
    convert_vector <= "0000000000000000";
  end if;
end process Assign;
  
  
end architecture;

