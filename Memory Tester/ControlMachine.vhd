library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ControlMachine is
  port(reset,clk,start,done : in std_logic;
       error_position_vector_in : in std_logic_vector(0 to 255);
       write : out std_logic;
       writevalue : out std_logic_vector(0 to 15);
       error_position_vector_out : out std_logic_vector(0 to 255);
       failedcase : out integer);
end ControlMachine;

architecture arch_ControlMachine of ControlMachine is
  type state_type is (ST0,ST1,ST2,ST3,ST4,ST5,ST6,ST7,ST8,ST9);
  signal PS,NS : state_type;
  signal writeflipper1,writeflipper2 : std_logic :='0';
  signal flippercounter1,flippercounter2 : integer :=1;
  signal addresswriter : std_logic_vector(0 to 15) :="1111111111111111";
  signal addresscounter : integer :=0;
  
  
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
     writeflipper1 <= '0';
     writeflipper2 <= '0';
     flippercounter1 <= 1;
     flippercounter2 <= 1;
     addresswriter <= "1111111111111111";
     addresscounter <= 0;
     write <= '0';
     error_position_vector_out <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
     if (reset = '1') then
       NS <= ST0;
     end if;
     if (rising_edge(clk)) then
       if (start = '1') then
         NS <= ST1;
       else
         NS <= ST0;
       end if;
     end if;
     
    when ST1 =>
      if (reset = '1') then
       NS <= ST0;
      end if;
      if (rising_edge(clk)) then
        if (done = '0') then
          failedcase <= 1;
          write <= '0';
          NS <= ST0;
        elsif (done = '1') then
          write <='0';
          NS <= ST2;
        else
         write <= '1';
         writevalue <= "1111111111111111";
        end if;
      end if;
      
    when ST2 =>
      if (reset = '1') then
       NS <= ST0;
      end if;
      if (rising_edge(clk)) then
        if (done = '0') then
          failedcase <= 2;
          write <= '0';
          NS <= ST0;
        elsif (done = '1') then
          write <='0';
          NS <= ST3;
        else
         write <= '1';
         writevalue <= "0000000000000000";
        end if;
      end if;
      
     when ST3 =>
       if (reset = '1') then
       NS <= ST0;
       end if;
       if (rising_edge(clk)) then
        if (done = '0') then
          failedcase <= 3;
          write <= '0';
          NS <= ST0;
        elsif (done = '1') then
          write <='0';
          NS <= ST4;
        elsif (flippercounter1 = 262) then
          if (writeflipper1 = '1') then
           write <= '1';
           writevalue <= "1010101010101010";
           writeflipper1 <= NOT writeflipper1;
          else
           write <= '1';
           writevalue <= "0101010101010101";
           writeflipper1 <= NOT writeflipper1;
          end if;
        elsif (writeflipper1 = '1') then
          write <= '1';
          writevalue <= "0101010101010101";
          writeflipper1 <= NOT writeflipper1;
          flippercounter1 <= flippercounter1 +1;
        else
          write <= '1';
          writevalue <= "1010101010101010";
          writeflipper1 <= NOT writeflipper1;
          flippercounter1 <= flippercounter1 +1;
        end if;
      end if;
      
      when ST4 =>
       if (reset = '1') then
        NS <= ST0;
       end if;
       if (rising_edge(clk)) then
        if (done = '0') then
          failedcase <= 4;
          write <= '0';
          NS <= ST0;
        elsif (done = '1') then
          write <='0';
          NS <= ST5;
        elsif (flippercounter2 = 262) then
          if (writeflipper2 = '1') then
           write <= '1';
           writevalue <= "0101010101010101";
           writeflipper2 <= NOT writeflipper2;
          else
           write <= '1';
           writevalue <= "1010101010101010";
           writeflipper2 <= NOT writeflipper2;
          end if;
        elsif (writeflipper2 = '1') then
          write <= '1';
          writevalue <= "1010101010101010";
          writeflipper2 <= NOT writeflipper2;
          flippercounter2 <= flippercounter2 +1;
        else
          write <= '1';
          writevalue <= "0101010101010101";
          writeflipper2 <= NOT writeflipper2;
          flippercounter2 <= flippercounter2 +1;
        end if;
      end if;
      
     when ST5 =>
      if (reset = '1') then
       NS <= ST0;
      end if;
      if (rising_edge(clk)) then
        if (done = '0') then
          failedcase <= 5;
          write <= '0';
          NS <= ST0;
        elsif (done = '1') then
          write <='0';
          NS <= ST6;
        elsif (addresscounter = 261) then
          write <= '1';
          writevalue <= addresswriter;
          addresswriter <= "0000000000000000";
          addresscounter <= addresscounter +1;
        elsif (addresscounter > 261) then
          write <= '1';
          writevalue <= addresswriter;
          addresswriter <= addresswriter + "0000000000000001";
        elsif (addresscounter > 255) then
          write <= '1';
          writevalue <= addresswriter;
          addresscounter <= addresscounter +1;
        else
          write <= '1';
          writevalue <= addresswriter;
          addresswriter <= addresswriter + "0000000000000001";
          addresscounter <= addresscounter +1;
        end if;
      end if;
      
     when ST6 =>
      if (reset = '1') then
       NS <= ST0;
      end if;
      if (rising_edge(clk)) then
        if (done = '0') then
          error_position_vector_out <= error_position_vector_in(2 to 255) & error_position_vector_in(0 to 1);
          write <= '0';
          NS <= ST7;
        elsif (done = '1') then
          error_position_vector_out <= error_position_vector_in(2 to 255) & error_position_vector_in(0 to 1);
          write <='0';
          NS <= ST7;
        else
         write <= '1';
         writevalue <= "0000000000000000";
        end if;
      end if;
      
      when ST7 =>
      if (reset = '1') then
       NS <= ST0;
      end if;
      if (rising_edge(clk)) then
        if (done = '0') then
          write <= '0';
          NS <= ST8;
        elsif (done = '1') then
          write <='0';
          NS <= ST8;
        else
         write <= '1';
         writevalue <= "1111111111111111";
        end if;
      end if;
      
       when ST8 =>
      if (reset = '1') then
       NS <= ST0;
      end if;
      if (rising_edge(clk)) then
        if (done = '0') then
          error_position_vector_out <= error_position_vector_in(2 to 255) & error_position_vector_in(0 to 1);
          write <= '0';
          NS <= ST9;
        elsif (done = '1') then
          error_position_vector_out <= error_position_vector_in(2 to 255) & error_position_vector_in(0 to 1);
          write <='0';
          NS <= ST9;
        else
         write <= '1';
         writevalue <= "1111111111111111";
        end if;
      end if;
      
      when ST9 =>
      if (reset = '1') then
       NS <= ST0;
      end if;
      if (rising_edge(clk)) then
        if (done = '0') then
          write <= '0';
          NS <= ST0;
        elsif (done = '1') then
          write <='0';
          NS <= ST0;
        else
         write <= '1';
         writevalue <= "0000000000000000";
        end if;
      end if;
       
       
     when others =>
      NS <= ST0;
    
    end case;
  end process;
end arch_ControlMachine;
        

