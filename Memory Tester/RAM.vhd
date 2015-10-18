library ieee;
use ieee.std_logic_1164.all;

---------------------------------------------------------------------------
entity ram is
   generic (bits: integer := 16;     -- # of bits per word
            words: integer := 256);  -- # of words in the memory 
   port (wr_enable, clk: in    std_logic;
         addr: 	     in    integer range 0 to words-1;
         data_in:        in    std_logic_vector((bits-1) downto 0);
         data_out:       out   std_logic_vector((bits-1) downto 0)
         );
end entity ram;

architecture behavioral of ram is
   type vector_array is array (0 to (words-1)) of std_logic_vector((bits-1) downto 0);
   signal memory: vector_array;
begin
   process(clk)
   begin
      if rising_edge(clk) then
         if wr_enable = '1' then
            memory(addr) <= data_in;
         else
	          data_out <= memory(addr);
        end if;
     end if;
   end process;
end behavioral; 

