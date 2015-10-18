library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;	
use ieee.std_logic_unsigned.all;


entity InstructionMemory is
  port(PCin : in std_logic_vector(0 to 7);
       IM : out std_logic_vector(0 to 15));
end entity;

architecture arch_InstructionMemory of InstructionMemory is
  begin
    
process(PCin)
  begin
    
    case PCin is
    when "00000000" =>
      IM <= "0001000000000110";
    
    when "00000001" =>
      IM <= "0001000000000111";
      
    when "00000010" =>
      IM <= "0001001001000001";
      
    when "00000011" =>
      IM <= "0001000110110010";
      
    when "00000100" =>
      IM <= "0010000100100011";
      
    when "00000101" =>
      IM <= "1000001000110101";
      
    when "00000110" =>
      IM <= "0111000001010110";
      
    when "00000111" =>
      IM <= "0110000000000000";
      
    when "00001000" =>
      IM <= "0100011001000111";
      
    when "00001001" =>
      IM <= "1010000000110100";
      
    when "00001010" =>
      IM <= "1100000010000000";
      
    when "00001011" =>
      IM <= "0001100101001000";
      
    when "00001100" =>
      IM <= "0001010110111001";
      
    when "00001101" =>
      IM <= "0011100010010101";
      
    when "00001110" =>
      IM <= "0101000000000000";
      
    when "00001111" =>
      IM <= "1000010100110001";
      
    when "00010000" =>
      IM <= "0001011000011011";
      
    when "00010001" =>
      IM <= "1011000010110001";
      
    when "00010010" =>
      IM <= "1100000001000000";
      
    when "00010011" =>
      IM <= "0100001110110110";
     
    when "00010100" =>
      IM <= "1000011010011000";
      
    when "00010101" =>
      IM <= "0000000000000000";
      
    when others =>
      IM <= "0000000000000000";
      
    end case;
end process;
end architecture;
                   