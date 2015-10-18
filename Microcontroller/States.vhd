library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity states is
  port(CLK : in std_logic;
       statep3,statep2,statep1,statep0 : in std_logic_vector(0 to 7);
       a1,b1,c1,d1,e1,f1,g1,dp1,an1,an2,an3,an0 : out std_logic);
end entity states;

architecture arch_states of states is
  type state_type is (ST0,ST1,ST2,ST3);
  signal PS,NS : state_type;
  
  
begin
 process1 : process(CLK)
   variable count : std_logic_vector (0 to 12):="0000000000000";
   begin
     if (rising_edge(CLK)) then
      if(count = "0000000000000") then PS <= NS; count := "0000000000001";
      else count := count + '1';
      end if;
     end if;
 end process process1;
 
 process2 : process(PS)
  begin
    case PS is
  when ST0 =>
    a1 <= statep3(0);
    b1 <= statep3(1);
    c1 <= statep3(2);
    d1 <= statep3(3);
    e1 <= statep3(4);
    f1 <= statep3(5);
    g1 <= statep3(6);
    dp1 <= statep3(7);
    an3 <= '0';
    an2 <= '1';
    an1 <= '1';
    an0 <= '1';
    NS <= ST1;
  when ST1 =>
    a1 <= statep2(0);
    b1 <= statep2(1);
    c1 <= statep2(2);
    d1 <= statep2(3);
    e1 <= statep2(4);
    f1 <= statep2(5);
    g1 <= statep2(6);
    dp1 <= statep2(7);
    an3 <= '1';
    an2 <= '0';
    an1 <= '1';
    an0 <= '1';
    NS <= ST2;
  when ST2 =>
    a1 <= statep1(0);
    b1 <= statep1(1);
    c1 <= statep1(2);
    d1 <= statep1(3);
    e1 <= statep1(4);
    f1 <= statep1(5);
    g1 <= statep1(6);
    dp1 <= statep1(7);
    an3 <= '1';
    an2 <= '1';
    an1 <= '0';
    an0 <= '1';
    NS <= ST3;
  when ST3 =>
    a1 <= statep0(0);
    b1 <= statep0(1);
    c1 <= statep0(2);
    d1 <= statep0(3);
    e1 <= statep0(4);
    f1 <= statep0(5);
    g1 <= statep0(6);
    dp1 <= statep0(7);
    an3 <= '1';
    an2 <= '1';
    an1 <= '1';
    an0 <= '0';
    NS <= ST0;
  when others =>
    NS <= ST0;
  end case;
end process process2;
end architecture arch_states;
    
    
     
