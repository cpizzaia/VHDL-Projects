library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ReadWriteMachine is
  port(reset, clk, write : in std_logic;
       writevalue, readvalue : in std_logic_vector(0 to 15);
       error_position_vector_out : in std_logic_vector(0 to 255);
       write_enable,done : out std_logic;
       address : out integer range 0 to 255;
       data : out std_logic_vector(0 to 15);
       error_position_vector_in : out std_logic_vector(0 to 255);
       errors : out integer);
end ReadWriteMachine;

architecture arch_ReadWriteMachine of ReadWriteMachine is
  type state_type is (ST0,ST1,ST2,ST3);
  signal PS,NS : state_type;
  signal writecount, readcount, errorcount : integer :=0;
  signal errorposition : integer :=0;

begin
  
 process(clk)
   begin
     if(rising_edge(clk)) then
      PS <= NS;
     end if;
 end process;
 
 process(clk)
  begin
    case PS is
      
    when ST0 =>
    done <= 'U';
    writecount <= 0;
    readcount <= 0;
    errorcount <= 0;
    errorposition <= 0;
    if(rising_edge(clk)) then
     if (write = '1') then
       NS <= ST1;
     else
       NS <= ST0;
     end if;
    end if;
      
    when ST1 =>
     write_enable <= '1';
     if (reset = '1') then
      NS <= ST0;
     end if;
     if(rising_edge(clk)) then
      if (writecount = 256) then
        NS <= ST2;
      else
        if (error_position_vector_out(writecount) = '1') then
          writecount <= writecount + 1;
        else
        address <= writecount;
        data <= writevalue;
        writecount <= writecount + 1;
        NS <= ST1;
        end if;
      end if;
     end if;
    
    when ST2 =>
      if (reset = '1') then
      NS <= ST0;
      end if;
      write_enable <='0';
      NS <= ST3;
      
    when ST3 =>
      if (reset = '1') then
      NS <= ST0;
      end if;
      write_enable <= '0';
     if(rising_edge(clk)) then
      if (readcount = 256) then
        if (errorcount > 0) then
         errors <= errorcount;
         done <='0';
         NS <= ST0;
        else
         errors <= 0;
         done <= '1';
         NS <= ST0;
        end if;
       else
        address <= readcount;
         if (writevalue = readvalue) then
          readcount <= readcount + 1;
          error_position_vector_in(errorposition) <= '0';
          errorposition <= errorposition +1;
         else
           error_position_vector_in(errorposition) <= '1';
           errorcount <= errorcount + 1;
           readcount <= readcount + 1;
           errorposition <= errorposition +1;
         end if;
       NS <= ST3;
       end if;
      end if;
      
    when others =>
    NS <= ST0;
    
    end case;
  end process;
end arch_ReadWriteMachine;
      
      
