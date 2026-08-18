-- ************************************************************************
-- Project:		CPE1510 Single-cycle Processor		
-- Filename:	rotator.vhd
-- Author:		Mark Harbar
-- Date:			03/18/2026
-- Provides:	
-- - Rotates the immediate NUM right in two-bit rotation increments. 
-- - The number of rotations is specified on the ROT input. 
-- - Output named B because the rotated immediate is SRC2 heading to ALUB.
-- ************************************************************************

-- use library packages 
-- std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;

-- function block symbol 
-- NUM is the input 32-bit number
-- ROT4 is a 4-bit number encoding the number of 2-bit right rotates
-- B is the rotated output for use by the ALU
entity ROTATOR is 
port(NUM:  in std_logic_vector(31 downto 0);
     ROT:  in std_logic_vector(3 downto 0);
     B:    out std_logic_vector(31 downto 0));
end entity ROTATOR;

-- circuit description 
architecture DATAFLOW of ROTATOR is 
begin

   -- USE CONCATENATION (&) TO FORM ROTATED OUTPUT
   -- HINT: Make a paper table of bits labled 31 downto 0
   --       then start rotating right by two-bit rotations 
   --       remember that rotation wraps bits around to the other end
   -- HINT: Check your machine code slideset. 
   --       Does the table already exist?

   with ROT select 
        
        -- rotate right 15 two-bit rotations 
   B <= NUM(29 downto 0)&B"00" when B"1111",
        -- rotate right 14 two-bit rotations
        NUM(27 downto 0)&B"00_00" when B"1110",
		  -- rotate right 13 two-bit rotations
        NUM(25 downto 0)&B"00_00_00" when B"1101",
		  -- rotate right 12 two-bit rotations
        NUM(23 downto 0)&B"00_00_00_00" when B"1100",
		  -- rotate right 11 two-bit rotations
		  NUM(21 downto 0)&B"00_00_00_00_00" when B"1011",
		  -- rotate right 10 two-bit rotations
		  NUM(19 downto 0)&B"00_00_00_00_00_00" when B"1010",
		  -- rotate right 9 two-bit rotations
		  NUM(17 downto 0)&B"00_00_00_00_00_00_00" when B"1001",
		  -- rotate right 8 two-bit rotations
		  NUM(15 downto 0)&B"00_00_00_00_00_00_00_00" when B"1000",
		  -- rotate right 7 two-bit rotations
		  NUM(13 downto 0)&B"00_00_00_00_00_00_00_00_00" when B"0111",
		  -- rotate right 6 two-bit rotations
		  NUM(11 downto 0)&B"00_00_00_00_00_00_00_00_00_00" when B"0110",
		  -- rotate right 5 two-bit rotations
		  NUM(9 downto 0)&B"00_00_00_00_00_00_00_00_00_00_00" when B"0101",
		  -- rotate right 4 two-bit rotations
		  NUM(7 downto 0)&B"00_00_00_00_00_00_00_00_00_00_00_00" when B"0100",
		  -- rotate right 3 two-bit rotations
		  NUM(5 downto 0)&B"00_00_00_00_00_00_00_00_00_00_00_00_00" when B"0011",
		  -- rotate right 2 two-bit rotations
		  NUM(3 downto 0)&B"00_00_00_00_00_00_00_00_00_00_00_00_00_00" when B"0010",
		  -- rotate right 1 two-bit rotations
		  NUM(1 downto 0)&B"00_00_00_00_00_00_00_00_00_00_00_00_00_00_00" when B"0001",		 
		  NUM when others;  
        
 end architecture DATAFLOW;
