library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;	
use ieee.std_logic_unsigned.all;

entity Microcontroller is
  port(clk,reset,btn,btn1,btn2,btn3,btn4 : in std_logic;
       a1,b1,c1,d1,e1,f1,g1,dp1,an1,an2,an3,an0 : out std_logic);
end entity;

architecture arch_Microcontroller of Microcontroller is
  
component InstructionMemory is
  port(PCin : in std_logic_vector(0 to 7);
       IM : out std_logic_vector(0 to 15));
end component InstructionMemory;

component Datapath is
  port(clk,reset,btn : in std_logic;
       ra_data_in,rb_data_in,rd_data_in : in std_logic_vector(0 to 7);
       IM : in std_logic_vector(0 to 15);
       PC_out : out std_logic_vector(0 to 7);
       rd_data_out : out std_logic_vector(0 to 7);
       ra_addr_out,rb_addr_out,rd_addr_out : out std_logic_vector(0 to 3));
end component Datapath;

component RegisterFile is
   port (clk: in    std_logic;
         ra_addr,rb_addr,rd_addr: 	     in    std_logic_vector(0 to 3);
         rd_in:        in    std_logic_vector(0 to 7);
         ra_out,rb_out,rd_out:       out   std_logic_vector(0 to 7)
         );
end component RegisterFile;

component LEDNumberConverter is
  port(PC,RF : in std_logic_vector(0 to 7);
       IM : in std_logic_vector(0 to 15);
       btn1,btn2,btn3,btn4 : in std_logic;
       statep3,statep2,statep1,statep0 : out std_logic_vector(0 to 7));
end component LEDNumberConverter;

component states is
  port(CLK : in std_logic;
       statep3,statep2,statep1,statep0 : in std_logic_vector(0 to 7);
       a1,b1,c1,d1,e1,f1,g1,dp1,an1,an2,an3,an0 : out std_logic);
end component states;

component debounce is
  port(CLK,BTN : in std_logic; 
       pulse  : out std_logic);
end component debounce;

signal PCt : std_logic_vector(0 to 7);
signal IMt : std_logic_vector(0 to 15);
signal ra_data_in,rb_data_in,rd_data_in : std_logic_vector(0 to 7) :="00000001";
signal rd_data_out : std_logic_vector(0 to 7);
signal ra_addr_out,rb_addr_out,rd_addr_out : std_logic_vector(0 to 3);
signal statep3,statep2,statep1,statep0 : std_logic_vector(0 to 7);
signal pulse : std_logic;
begin
  
  Dpath : Datapath port map(clk,reset,pulse,ra_data_in,rb_data_in,rd_data_in,IMt,PCt,rd_data_out,ra_addr_out,rb_addr_out,rd_addr_out);
  Instructions : InstructionMemory port map(PCt,IMt);
  RF : RegisterFile port map(clk,ra_addr_out,rb_addr_out,rd_addr_out,rd_data_out,ra_data_in,rb_data_in,rd_data_in);
  LNC : LEDNumberConverter port map(PCt,rd_data_out,IMt,btn1,btn2,btn3,btn4,statep3,statep2,statep1,statep0);
  StatesDisplay : states port map(clk,statep3,statep2,statep1,statep0,a1,b1,c1,d1,e1,f1,g1,dp1,an1,an2,an3,an0);
  debouncer : debounce port map(clk,btn,pulse); 
end architecture;
  
