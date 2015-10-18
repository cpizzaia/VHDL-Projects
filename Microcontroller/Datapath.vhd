library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;	
use ieee.std_logic_unsigned.all;


entity Datapath is
  port(clk,reset,btn : in std_logic;
       ra_data_in,rb_data_in,rd_data_in : in std_logic_vector(0 to 7);
       IM : in std_logic_vector(0 to 15);
       PC_out : out std_logic_vector(0 to 7);
       rd_data_out : out std_logic_vector(0 to 7);
       ra_addr_out,rb_addr_out,rd_addr_out : out std_logic_vector(0 to 3));
end Datapath;

architecture arch_Datapath of Datapath is
signal IMreg : std_logic_vector(0 to 15) :="0000000000000000";
signal opcode,ra,rb,rd : std_logic_vector(0 to 3) :="0000";
signal PC,PCreg,PCdecode1,PCdecode2,PCdecode3 : std_logic_vector(0 to 7) :="00000000";
signal skip,jump,jumpback : std_logic := '0';
signal rd_data : std_logic_vector(0 to 7);
signal jump_addr : std_logic_vector(0 to 7);
begin
    
Fetch: process(clk,btn,reset)
begin
  if(reset = '1') then
  PC <= "00000000";
  
  elsif(rising_edge(clk)) then
  IMreg <= IM;
  PC_out <= PC;
  PCdecode1 <= PC;
  
  if (btn = '1') then 
    if (skip = '1') then
      PC <= PC + "00000010";
    elsif (jump = '1') then
      PC <= jump_addr;
    elsif (jumpback = '1') then
      PC <= PCreg + "00000001";
    else
      PC <= PC + "00000001";
    end if;   
  end if;
  end if;
end process Fetch;

Decode: process(clk)
begin
    if(rising_edge(clk)) then
    opcode <= IMreg(0 to 3);
    ra <= IMreg(4 to 7);
    rb <= IMreg(8 to 11);
    rd <= IMreg(12 to 15);
    PCdecode2  <= PCdecode1;
    end if;
end process Decode;

Execute: process(clk)
begin
  if(rising_edge(clk)) then
  ra_addr_out <= ra;
  rb_addr_out <= rb;
  rd_addr_out <= rd;
  PCdecode3 <= PCdecode2;
  
  
  if(opcode = "0110") then
    skip <= '1';
  else
    skip <= '0';
  end if;
  
  if(PC = PCreg + "00000001")then
    jumpback <= '0';
  end if;
  
  if(opcode = "1100") then
    jump <= '1';
    jumpback <= '1';
    PCreg <= PCdecode3;
  else
    jump <= '0';
  end if;
  
  case opcode is
    
  when "0001" =>
    rd_data <= ra & rb;
    
    
  when "0010" =>
    rd_data <= ra_data_in + rb_data_in;
    
    
    
  when "0011" =>
    rd_data <= ra_data_in - rb_data_in;
    
    
    
  when "0100" =>
    rd_data <= ra_data_in OR rb_data_in;
    
    
  when "0101" =>
    null;
    
  when "1000" =>
    rd_data <= ra_data_in XOR rb_data_in;
    
    
  when "0110" =>
    null;
    
  when "0111" =>
    rd_data <= rb_data_in + "00000001";
    
    
  when "1010" =>
    rd_data <= rb_data_in - "00000001";
    
    
  when "1011" =>
    rd_data <= (NOT rb_data_in) + "00000001";
    
    
  when "1100" =>
    jump_addr <= ra & rb;
    
  
  when others =>
    null;

    
  end case;
  end if;
end process Execute;

Store: process(clk)
begin
  if(rising_edge(clk)) then
  rd_data_out <= rd_data;
  end if;
end process Store;

end architecture;