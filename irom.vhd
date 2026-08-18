-- *********************************************************************
-- Project:		LAB2		
-- Filename:	irom.vhd
-- Author:		Mark Harbar
-- Date:			05/05/2026
-- Provides:	
-- - An instruction ROM responding to addresses on its ADDR bus. 
-- - This ROM is a truth table built using with-select syntax. 
-- *********************************************************************

-- NOTE: THIS FILE IS GIVEN IN COMPLETE FORM. 
-- NOTE: THERE IS NO ADDITIONAL WORK FOR STUDENTS TO COMPLETE 
-- NOTE: Review for reference. 

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;


-- function block symbol
-- inputs: 
--    ADDR  : 32-bit address requesting instruction 
-- outputs: 
--    Q     : 32-bit output of machine code instruction 
-- notes    : ROMs do not reset on power-up so no reset signal 
--          : ROMs do not load in user mode so no load signal  
entity IROM is 
port(ADDR  : in std_logic_vector(31 downto 0);
     Q     : out std_logic_vector(31 downto 0));
end entity IROM;



-- circuit description 
architecture MULTIPLEXER of IROM is 
begin

  -- use address to output correct binary machine code number 
  with ADDR select
Q <= 

X"e3a070ec"	when	X"00000000",
X"e3a080e0"	when	X"00000004",
X"e3a090e4"	when	X"00000008",
X"e3a0c0f0"	when	X"0000000C",
X"e3a0a000"	when	X"00000010",
X"e3a0b000"	when	X"00000014",
X"e3a0100f"	when	X"00000018",
X"e5891000"	when	X"0000001C",
X"e28aa001"	when	X"00000020",
X"e5970000"	when	X"00000024",
X"e2000004"	when	X"00000028",
X"e3500000"	when	X"0000002C",
X"0afffffa"	when	X"00000030",
X"e3a01000"	when	X"00000034",
X"e5891000"	when	X"00000038",
X"e5970000"	when	X"0000003C",
X"e2000004"	when	X"00000040",
X"e3500000"	when	X"00000044",
X"1afffffb"	when	X"00000048",
X"e3a0100c"	when	X"0000004C",
X"e5891000"	when	X"00000050",
X"e28bb001"	when	X"00000054",
X"e5970000"	when	X"00000058",
X"e2000004"	when	X"0000005C",
X"e3500000"	when	X"00000060",
X"0afffffa"	when	X"00000064",
X"e3a01000"	when	X"00000068",
X"e5891000"	when	X"0000006C",
X"e59c0000"	when	X"00000070",
X"e3a010ff"	when	X"00000074",
X"e1a01101"	when	X"00000078",
X"e2811003"	when	X"0000007C",
X"e1500001"	when	X"00000080",
X"1afffff9"	when	X"00000084",
X"e3a0600b"	when	X"00000088",
X"e2466001"	when	X"0000008C",
X"e3560006"	when	X"00000090",
X"0a000010"	when	X"00000094",
X"e3a0100f"	when	X"00000098",
X"e5891000"	when	X"0000009C",
X"e1a0100a"	when	X"000000A0",
X"e2411001"	when	X"000000A4",
X"e3510000"	when	X"000000A8",
X"e3a00001"	when	X"000000AC",
X"e2400001"	when	X"000000B0",
X"1afffffa"	when	X"000000B4",
X"e3a0100c"	when	X"000000B8",
X"e5891000"	when	X"000000BC",
X"e1a0100b"	when	X"000000C0",
X"e2411001"	when	X"000000C4",
X"e3510000"	when	X"000000C8",
X"e3a00001"	when	X"000000CC",
X"e2400001"	when	X"000000D0",
X"1afffffa"	when	X"000000D4",
X"eaffffeb"	when	X"000000D8",
X"e3a01000"	when	X"000000DC",
X"e5891000"	when	X"000000E0",
X"e2466001"	when	X"000000E4",
X"e3560000"	when	X"000000E8",
X"0a000014"	when	X"000000EC",
X"e3a01010"	when	X"000000F0",
X"e5891000"	when	X"000000F4",
X"e3a020ff"	when	X"000000F8",
X"e1a02102"	when	X"000000FC",
X"e2822003"	when	X"00000100",
X"e5882000"	when	X"00000104",
X"e3a0200a"	when	X"00000108",
X"e1a02a02"	when	X"0000010C",
X"e2422001"	when	X"00000110",
X"e3520000"	when	X"00000114",
X"1afffffc"	when	X"00000118",
X"e3a01000"	when	X"0000011C",
X"e5891000"	when	X"00000120",
X"e3a02000"	when	X"00000124",
X"e5882000"	when	X"00000128",
X"e3a0200a"	when	X"0000012C",
X"e1a02a02"	when	X"00000130",
X"e2422001"	when	X"00000134",
X"e3520000"	when	X"00000138",
X"1afffffc"	when	X"0000013C",
X"eaffffe5"	when	X"00000140",



X"EAFF_FFFE" when others;

 end architecture MULTIPLEXER;