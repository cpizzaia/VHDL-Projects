library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;	
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

---------------------------------------------------------------------------
entity RegisterFile is
   port (clk: in    std_logic;
         ra_addr,rb_addr,rd_addr: 	     in    std_logic_vector(0 to 3);
         rd_in:        in    std_logic_vector(0 to 7);
         ra_out,rb_out,rd_out:       out   std_logic_vector(0 to 7)
         );
end entity RegisterFile;

architecture behavioral of RegisterFile is
   type vector_array is array (0 to 15) of std_logic_vector(0 to 7);
   signal memory: vector_array;
begin
   process(clk)
   begin
       memory(conv_integer(rd_addr)) <= rd_in;
       ra_out <= memory(conv_integer(ra_addr));
       rb_out <= memory(conv_integer(rb_addr));
       rd_out <= memory(conv_integer(rd_addr));        
   end process;
end behavioral; 
