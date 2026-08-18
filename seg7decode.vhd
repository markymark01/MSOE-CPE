-- ******************************************************************
-- * Project:	   DIGIBOTPUP	
-- * Filename:	   seg7decode.vhd
-- * Author:	   Mark Harbar 
-- * Date:	   MSOE Spring Semester 2026
-- * Provides:	   A seven-segment decoder for the CPE 1510 computer
-- ******************************************************************

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- function block symbol
-- inputs: 
--    A     : 32-bit value for hexadecimal display
-- outputs: 
--    DE10 Lite only has five (5) seven-segment displays 
--    and so the two most significant nibbles will not be displayed
-- 
--    SEG5  : 8-bit 7-segment display output for nibble A(23 downto 24) 
--    SEG4  : 8-bit 7-segment display output for nibble A(19 downto 16)
--    SEG3  : 8-bit 7-segment display output for nibble A(15 downto 12)
--    SEG2  : 8-bit 7-segment display output for nibble A(11 downto 8)
--    SEG1  : 8-bit 7-segment display output for nibble A(7 downto 4)
--    SEG0  : 8-bit 7-segment display output for nibble A(3 downto 0)
entity SEG7DECODE is 
port(A: in std_logic_vector(31 downto 0);
     SEG5: out std_logic_vector(7 downto 0);
     SEG4: out std_logic_vector(7 downto 0);
     SEG3: out std_logic_vector(7 downto 0);
     SEG2: out std_logic_vector(7 downto 0);
     SEG1: out std_logic_vector(7 downto 0);
     SEG0: out std_logic_vector(7 downto 0));
end entity SEG7DECODE;

-- circuit description 
architecture MULTIPLEXER of SEG7DECODE is 

  -- constants to help make corrections easier 
  constant HEX0 : std_logic_vector(7 downto 0) := B"11000000"; -- DE10 Lite uses active-low LEDs, this is the pattern for 0
  constant HEX1 : std_logic_vector(7 downto 0) := B"11111001"; -- DE10 Lite uses active-low LEDs, this is the pattern for 1
  constant HEX2 : std_logic_vector(7 downto 0) := B"10100100"; -- DE10 Lite uses active-low LEDs, this is the pattern for 2
  constant HEX3 : std_logic_vector(7 downto 0) := B"10110000"; 
  constant HEX4 : std_logic_vector(7 downto 0) := B"10011001";
  constant HEX5 : std_logic_vector(7 downto 0) := B"10010010";
  constant HEX6 : std_logic_vector(7 downto 0) := B"10000010";
  constant HEX7 : std_logic_vector(7 downto 0) := B"11111000";
  constant HEX8 : std_logic_vector(7 downto 0) := B"10000000"; 
  constant HEX9 : std_logic_vector(7 downto 0) := B"10011000";
  --didnt need these for lab 2, expanding for lab 3
  constant HEXA : std_logic_vector(7 downto 0) := B"10001000";
  constant HEXB : std_logic_vector(7 downto 0) := B"10000011";
  constant HEXC : std_logic_vector(7 downto 0) := B"10100111"; 
  constant HEXD : std_logic_vector(7 downto 0) := B"10100001"; 
  constant HEXE : std_logic_vector(7 downto 0) := B"10000110"; 
  constant HEXF : std_logic_vector(7 downto 0) := B"10001110";
  constant HEXH : std_logic_vector(7 downto 0) := B"10001001";
  constant HEXI : std_logic_vector(7 downto 0) := B"11111001";
  constant HEXN : std_logic_vector(7 downto 0) := B"10101011";
  constant HEXP : std_logic_vector(7 downto 0) := B"10001100";
  constant HEXR : std_logic_vector(7 downto 0) := B"10101111";
  constant HEXT : std_logic_vector(7 downto 0) := B"10000111";
  constant HEXU : std_logic_vector(7 downto 0) := B"11000001";
  constant HEXY : std_logic_vector(7 downto 0) := B"10010001";
  constant HEXL : std_logic_vector(7 downto 0) := B"11000111";
  --W will have 2 partts
  constant WLEFT : std_logic_vector(7 downto 0) := B"11000011";
  constant WRIGHT : std_logic_vector(7 downto 0) := B"11100001";
  constant BLANK : std_logic_vector(7 downto 0) := B"11111111";

  
  --logic must be changed 
  
  --31-28 ->command 
  --27-24 ->unused 
  --23-0 ->data 
  
   begin
   process(A)
	begin
	
	--make it change for switch values
		case A(31 downto 28) is

		--take the 4 bit and turn it into a pattern
		--0 is regular decoder
		
      when X"0" => 

		  -- SEG5
		  case A(23 downto 20) is
			 when X"0" => SEG5 <= HEX0;
			 when X"1" => SEG5 <= HEX1;
			 when X"2" => SEG5 <= HEX2;
			 when X"3" => SEG5 <= HEX3;
			 when X"4" => SEG5 <= HEX4;
			 when X"5" => SEG5 <= HEX5;
			 when X"6" => SEG5 <= HEX6;
			 when X"7" => SEG5 <= HEX7;
			 when X"8" => SEG5 <= HEX8;
			 when X"9" => SEG5 <= HEX9;
			 when X"A" => SEG5 <= HEXA;
			 when X"B" => SEG5 <= HEXB;
			 when X"C" => SEG5 <= HEXC;
			 when X"D" => SEG5 <= HEXD;
			 when X"E" => SEG5 <= HEXE;
			 when others => SEG5 <= HEXF;
		  end case;

		  -- SEG4
		  case A(19 downto 16) is
			 when X"0" => SEG4 <= HEX0;
			 when X"1" => SEG4 <= HEX1;
			 when X"2" => SEG4 <= HEX2;
			 when X"3" => SEG4 <= HEX3;
			 when X"4" => SEG4 <= HEX4;
			 when X"5" => SEG4 <= HEX5;
			 when X"6" => SEG4 <= HEX6;
			 when X"7" => SEG4 <= HEX7;
			 when X"8" => SEG4 <= HEX8;
			 when X"9" => SEG4 <= HEX9;
			 when X"A" => SEG4 <= HEXA;
			 when X"B" => SEG4 <= HEXB;
			 when X"C" => SEG4 <= HEXC;
			 when X"D" => SEG4 <= HEXD;
			 when X"E" => SEG4 <= HEXE;
			 when others => SEG4 <= HEXF;
		  end case;

		  -- SEG3
		  case A(15 downto 12) is
			 when X"0" => SEG3 <= HEX0;
			 when X"1" => SEG3 <= HEX1;
			 when X"2" => SEG3 <= HEX2;
			 when X"3" => SEG3 <= HEX3;
			 when X"4" => SEG3 <= HEX4;
			 when X"5" => SEG3 <= HEX5;
			 when X"6" => SEG3 <= HEX6;
			 when X"7" => SEG3 <= HEX7;
			 when X"8" => SEG3 <= HEX8;
			 when X"9" => SEG3 <= HEX9;
			 when X"A" => SEG3 <= HEXA;
			 when X"B" => SEG3 <= HEXB;
			 when X"C" => SEG3 <= HEXC;
			 when X"D" => SEG3 <= HEXD;
			 when X"E" => SEG3 <= HEXE;
			 when others => SEG3 <= HEXF;
		  end case;

		  -- SEG2
		  case A(11 downto 8) is
			 when X"0" => SEG2 <= HEX0;
			 when X"1" => SEG2 <= HEX1;
			 when X"2" => SEG2 <= HEX2;
			 when X"3" => SEG2 <= HEX3;
			 when X"4" => SEG2 <= HEX4;
			 when X"5" => SEG2 <= HEX5;
			 when X"6" => SEG2 <= HEX6;
			 when X"7" => SEG2 <= HEX7;
			 when X"8" => SEG2 <= HEX8;
			 when X"9" => SEG2 <= HEX9;
			 when X"A" => SEG2 <= HEXA;
			 when X"B" => SEG2 <= HEXB;
			 when X"C" => SEG2 <= HEXC;
			 when X"D" => SEG2 <= HEXD;
			 when X"E" => SEG2 <= HEXE;
			 when others => SEG2 <= HEXF;
		  end case;

		  -- SEG1
		  case A(7 downto 4) is
			 when X"0" => SEG1 <= HEX0;
			 when X"1" => SEG1 <= HEX1;
			 when X"2" => SEG1 <= HEX2;
			 when X"3" => SEG1 <= HEX3;
			 when X"4" => SEG1 <= HEX4;
			 when X"5" => SEG1 <= HEX5;
			 when X"6" => SEG1 <= HEX6;
			 when X"7" => SEG1 <= HEX7;
			 when X"8" => SEG1 <= HEX8;
			 when X"9" => SEG1 <= HEX9;
			 when X"A" => SEG1 <= HEXA;
			 when X"B" => SEG1 <= HEXB;
			 when X"C" => SEG1 <= HEXC;
			 when X"D" => SEG1 <= HEXD;
			 when X"E" => SEG1 <= HEXE;
			 when others => SEG1 <= HEXF;
		  end case;

		  -- SEG0
		  case A(3 downto 0) is
			 when X"0" => SEG0 <= HEX0;
			 when X"1" => SEG0 <= HEX1;
			 when X"2" => SEG0 <= HEX2;
			 when X"3" => SEG0 <= HEX3;
			 when X"4" => SEG0 <= HEX4;
			 when X"5" => SEG0 <= HEX5;
			 when X"6" => SEG0 <= HEX6;
			 when X"7" => SEG0 <= HEX7;
			 when X"8" => SEG0 <= HEX8;
			 when X"9" => SEG0 <= HEX9;
			 when X"A" => SEG0 <= HEXA;
			 when X"B" => SEG0 <= HEXB;
			 when X"C" => SEG0 <= HEXC;
			 when X"D" => SEG0 <= HEXD;
			 when X"E" => SEG0 <= HEXE;
			 when others => SEG0 <= HEXF;
		  end case;
		
        

		--HI
      when X"1" => 
        SEG5 <= BLANK;
        SEG4 <= BLANK;
        SEG3 <= HEXH;
        SEG2 <= HEXI;
        SEG1 <= BLANK;
        SEG0 <= BLANK;

		-- Fido
      when X"2" =>
        SEG5 <= BLANK;
        SEG4 <= HEXF;
        SEG3 <= HEXI;
        SEG2 <= HEXD;
        SEG1 <= HEX0;
        SEG0 <= BLANK;

		-- Puppy
      when X"3" =>
        SEG5 <= BLANK;
        SEG4 <= HEXP;
        SEG3 <= HEXU;
        SEG2 <= HEXP;
        SEG1 <= HEXP;
        SEG0 <= HEXY;
		  
		-- In Pen
      when X"4" =>
        SEG5 <= HEXI;
        SEG4 <= HEXN;
        SEG3 <= BLANK;
        SEG2 <= HEXP;
        SEG1 <= HEXE;
        SEG0 <= HEXN;

		-- Patrol
      when X"5" =>
        SEG5 <= HEXP;
        SEG4 <= HEXA;
        SEG3 <= HEXT;
        SEG2 <= HEXR;
        SEG1 <= HEX0;
        SEG0 <= HEXL;

		-- Fetch
      when X"6" =>
        SEG5 <= BLANK;
        SEG4 <= HEXF;
        SEG3 <= HEXE;
        SEG2 <= HEXT;
        SEG1 <= HEXC;
        SEG0 <= HEXH;

		-- Wag
      when X"7" =>
        SEG5 <= BLANK;
        SEG4 <= WLEFT;
        SEG3 <= WRIGHT;
        SEG2 <= HEXA;
        SEG1 <= HEX6;
        SEG0 <= BLANK;

		-- Crawl
      when X"8" =>
        SEG5 <= HEXC;
        SEG4 <= HEXR;
        SEG3 <= HEXA;
        SEG2 <= WLEFT;
        SEG1 <= WRIGHT;
		  SEG0 <= HEXL;

		-- Beg
      when X"9" => 
        SEG5 <= BLANK;
        SEG4 <= BLANK;
        SEG3 <= BLANK;
        SEG2 <= HEXB;
        SEG1 <= HEXE;
        SEG0 <= HEX6;

		--wake
      when X"A" => 
        SEG5 <= BLANK;
        SEG4 <= WLEFT;
        SEG3 <= WRIGHT;
        SEG2 <= HEXA;
        SEG1 <= HEXH; 
        SEG0 <= HEXE;

      when others =>
        SEG5 <= BLANK;
        SEG4 <= BLANK;
        SEG3 <= BLANK;
        SEG2 <= BLANK;
        SEG1 <= BLANK;
        SEG0 <= BLANK;

    end case;

  end process;
  
end architecture MULTIPLEXER; 
