-- ************************************************************************
-- Project:	CPE1510 Single-cycle Processor		
-- Filename:	cpsr.vhd
-- Author:	Mark Harbar 
-- Date:	03/18/2026
-- Provides:	
-- - The ARM current program status register. 
-- - This register stores ALU flag signals C, V, N, Z.
-- - Input bus LD determines which bits are sampled and stored on clk edge.
-- ************************************************************************ 

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;

-- function block symbol
-- inputs:
--   D3,D2,D1,D0 are input bits for storage 
--   LD is a two-bit bus determining which inputs are sampled
--   RST is an active-low synchronous reset signal 
--   CLK is a rising-edge triggered clock 
-- outputs
--   Q3,Q2,Q1,Q0 are stored output bits
--   do not convert to bus! see reference diagrams
entity CPSR is 
port(D3, D2, D1, D0: in std_logic;
     LD: in std_logic_vector(1 downto 0); 
     RST: in std_logic;
     CLK: in std_logic;
     Q3, Q2, Q1, Q0: out std_logic);
end entity CPSR;

-- circuit description 
architecture BEHAVIORAL of CPSR is 

signal q3_reg, q2_reg, q1_reg, q0_reg : std_logic;

begin

--internal signals issues with buffer this might help
	
	 Q3 <= q3_reg; Q2 <= q2_reg; Q1 <= q1_reg; Q0 <= q0_reg;

--update it helped (however, I have a feeling I may have typed something wrong earlier giving me the buffer error)


  -- next state logic 
  -- D3 = C, D2 = V, D1 = N, D0 = Z
  reg: process(LD, RST, CLK)
  begin
    if rising_edge(CLK) then 
	   if RST='0' then q3_reg<='0'; q2_reg<='0'; q1_reg <= '0'; q0_reg <= '0'; 
		-- LD = 0: sample C, V, N, Z
		-- LD = 1: sample C, N, Z
		-- LD = 2: sample N, Z
		-- LD = 3: default - hold and don't change
		
      elsif LD=B"00" then q3_reg<=D3; q2_reg<=D2; q1_reg <= D1; q0_reg <= D0; -- CVNZ
		
      elsif LD=B"01" then q3_reg <= D3; q2_reg <= D2; q1_reg <= D1; q0_reg <= D0; -- C, N, Z 
		--(Quartus says"Error (10309): VHDL Interface Declaration error in cpsr.vhd(50): interface object "Q2" of mode out cannot be read. Change object mode to buffer.) 

		
      elsif LD=B"10" then q3_reg <= q3_reg; q2_reg <= q2_reg; q1_reg <= D1; q0_reg <= D0; -- N, Z 
		
      else q3_reg <= q3_reg; q2_reg <= q2_reg; q1_reg <= D1; q0_reg <= q0_reg; -- hold
		
      end if ;
		
    end if;
  end process reg;
  
end architecture BEHAVIORAL;