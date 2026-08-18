-- *********************************************************************
-- Project:		CPE1510 Single-cycle Processor		
-- Filename:	irom.vhd
-- Author:		Mark Harbar
-- Date:			03/18/2026
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
  Q <= X"E3A0_90E4" when X"00000000",  -- MOV R9,#0xE4 // motor register
        X"E3A0_A0E8" when X"00000004", -- MOV R10,#0xE8 //seg register
        X"E3A0_B0EC" when X"00000008", -- MOV R11,#0xEC //sensor register

        X"E3A0_4000" when X"0000000C", -- MOV R4,#0 // count = 0
        X"E3A0_5001" when X"00000010", -- MOV R5,#1 // store? = 1
        X"E58A_4000" when X"00000014", -- STR R4,[R10] // display 0

        X"E59B_2000" when X"00000018", -- main: LDR R2,[R11]
        X"E202_2003" when X"0000001C", -- AND R2,R2,#3
        X"E352_0000" when X"00000020", -- CMP R2,#0
        X"0A00_000D" when X"00000024", -- BEQ bumping

        X"E3A0_5001" when X"00000028", -- MOV R5,#1 //reset the counter preparer
        X"E352_0002" when X"0000002C", -- CMP R2,#2 // turning
        X"0A00_0004" when X"00000030", -- BEQ turnleft
        X"E352_0001" when X"00000034", -- CMP R2,#1
        X"0A00_0005" when X"00000038", -- BEQ turnright

        X"E3A0_100F" when X"0000003C", -- forward: MOV R1,#0x0F
        X"E589_1000" when X"00000040", -- STR R1,[R9]
        X"EAFF_FFF3" when X"00000044", -- B main

        X"E3A0_100C" when X"00000048", -- turnleft: MOV R1,#0x0C 
        X"E589_1000" when X"0000004C", -- STR R1,[R9]
        X"EAFF_FFF0" when X"00000050", -- B main

        X"E3A0_1003" when X"00000054", -- turnright: MOV R1,#0x03
        X"E589_1000" when X"00000058", -- STR R1,[R9]
        X"EAFF_FFED" when X"0000005C", -- B main

        X"E355_0001" when X"00000060", -- bumping: CMP R5,#1
        X"1A00_0002" when X"00000064", -- BNE bumpThenMove
        X"E284_4001" when X"00000068", -- ADD R4,R4,#1 //increase counter
        X"E58A_4000" when X"0000006C", -- STR R4,[R10] //to leds
        X"E3A0_5000" when X"00000070", -- MOV R5,#0 //reset

        X"E3A0_100F" when X"00000074", -- bumpThenMove: MOV R1,#0x0F //makes sure the robot keeps on moving after bump (had weird errors with this)
        X"E589_1000" when X"00000078", -- STR R1,[R9]
        X"EAFF_FFE5" when X"0000007C", -- B main

        X"EAFF_FFFE" when others;
  

 end architecture MULTIPLEXER;