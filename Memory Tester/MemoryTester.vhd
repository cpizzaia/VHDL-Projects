library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MemoryTester is
  port(reset, clk, start : in std_logic;
       failedcase,errors : out integer);
end MemoryTester;

architecture arch_MemoryTester of MemoryTester is
  
component ReadWriteMachine
  port(reset, clk, write : in std_logic;
       writevalue, readvalue : in std_logic_vector(0 to 15);
       error_position_vector_out : in std_logic_vector(0 to 255);
       write_enable,done : out std_logic;
       address : out integer range 0 to 255;
       data : out std_logic_vector(0 to 15);
       error_position_vector_in : out std_logic_vector(0 to 255);
       errors : out integer);
end component ReadWriteMachine;

component ram
   generic (bits: integer := 16;     -- # of bits per word
            words: integer := 256);  -- # of words in the memory 
   port (wr_enable, clk: in    std_logic;
         addr: 	     in    integer range 0 to words-1;
         data_in:        in    std_logic_vector((bits-1) downto 0);
         data_out:       out   std_logic_vector((bits-1) downto 0)
         );
end component ram;

component ControlMachine is
  port(reset,clk,start,done : in std_logic;
       error_position_vector_in : in std_logic_vector(0 to 255);
       write : out std_logic;
       writevalue : out std_logic_vector(0 to 15);
       error_position_vector_out : out std_logic_vector(0 to 255);
       failedcase : out integer);
end component ControlMachine;

signal data_out_RWmachine, data_out_ram, writevalue : std_logic_vector(0 to 15) := "0000000000000000";
signal wr_en, write, done : std_logic := '0';
signal address : integer := 0;
signal error_position_vector_in : std_logic_vector(0 to 255) :="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal error_position_vector_out : std_logic_vector(0 to 255) :="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";


begin
CMachine : ControlMachine port map(reset,clk,start,done,error_position_vector_in,write,writevalue,error_position_vector_out,failedcase);
RWMachine : ReadWriteMachine port map(reset,clk,write,writevalue,data_out_ram,error_position_vector_out,wr_en,done,address,data_out_RWmachine,error_position_vector_in,errors);
SRAM : ram port map(wr_en,clk,address,data_out_RWmachine,data_out_ram);
  
end arch_MemoryTester;
       
       