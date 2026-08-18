-- ***************************************************************************
-- Project:		CPE1510 Single-cycle Processor		
-- Filename:	control.vhd
-- Author:		Mark Harbar
-- Date:			03/18/2026
-- Provides:	
-- - A control circuit for the ARMv4 ISA single-cycle processor.
-- - Use when-else to create equations for each signal.
-- ***************************************************************************
-- The following instructions must be implemented in all appropriate modes:
-- - Arithmetic: add, adds, cmp, cmn, rsb, rsbs, sub, subs 
-- - Bitwise logic: and, ands, asl, asls, asr, asrs, bic, bics, 
--		    eor, eors, lsl, lsls, lsr, lsrs, orr, ors
-- - Moves: mov, movs, mvn, mvns
-- - Load-store: ldr, str (offset indexing, + or - offset)  
-- - Conditional branch: beq, bne
-- - Unconditional branch:bal, bl 
-- ***************************************************************************
-- The following instructions are optional but make a more complete uproc 
-- - Conditional branch: 		bge: pc <- braddr if 	not (N xor V) 
-- - Conditional branch: 		blt: pc <- braddr if 	N xor V 
-- - Conditional branch: 		bgt: pc <- braddr if 	not Z and not (N xor V)
-- - Conditional branch: 		ble: pc <- braddr if 	Z or (N xor V) 
-- ***************************************************************************

-- use library packages 
-- std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;

-- functional block symbol
-- inputs
--    IBUS:	 	the 32-bit machine code instruction 
--    C,V,N,Z:	the condition code flag signals from the CPSR
-- outputs 
--    PCSEL:   0 = ground				1 = WD4 (for mov PC, LR) 
--					2 = BRADDR				3 = PC+4
--    A3SEL:   0 = Rs					1 = Rd 
--    ROTSEL:  0 = ROTATE field		1 = constant 0
--    SHAMTSEL:0 = SHAMT field		1 = R[RS] - lower five bits
--    SRC2SEL: 0 = SHIFTED RM	    	1 = immediate
--    REGWR:   0 = Regfile Write    1 = Regfile does not write 
--    ALUSEL:  0 = AND              1 = EOR
--             2 = SUB              3 = RSB
--             4 = ADD              C = ORR
--             D = MOV/SHIFTS       E = BIC
--	       F = MVN
--    CSPRWR:  0 = sample CVNZ      1 = sample CNZ		
--	       2 = sample NZ	    3 = hold, do not sample
--    MEMWR:   0 = Mem Write (STR)  1 = not an STR
--    MEMRD:   0 = Mem Read (LDR)   1 = not an LDR
--    WD4SEL:  0 = Data Mem Value   1 = ALU Value		
--	       2 = PC+4 (BL)	    3 = ground
--    A4SEL:   0 = rd		    1 = constant 14: LR

entity CONTROL is 
port(IBUS:     in  std_logic_vector(31 downto 0);
     C,V,N,Z:  in  std_logic;
     PCSEL:    out std_logic_vector(1 downto 0); 
     A3SEL:    out std_logic; 
     ROTSEL:   out std_logic; 
     SHAMTSEL: out std_logic;
     SRC2SEL:  out std_logic;
     REGWR:    out std_logic;
     ALUSEL:   out std_logic_vector(3 downto 0);
     CPSRWR:   out std_logic_vector(1 downto 0);
     MEMWR:    out std_logic;
     MEMRD:    out std_logic;
     WD4SEL:   out std_logic_vector(1 downto 0);
     A4SEL:		out std_logic);
end entity CONTROL;

-- circuit description 
architecture DATAFLOW of CONTROL is 
   -- declare signals for the IBUS bit fields 
   -- data processing: fields used for implementing arithmetic  
   signal COND : std_logic_vector(3 downto 0);
   signal OPCODE: std_logic_vector(1 downto 0);
   signal I: std_logic;
   signal CMD: std_logic_vector(3 downto 0);
   signal S: std_logic;
   -- load-store: fields used to implement load-store
   signal IBAR: std_logic;
   signal PUBWL: std_logic_vector(4 downto 0);
   signal L: std_logic;
   -- branch: fields used to help implement branches and MOV PC,LR
   signal BL: std_logic; -- the branch L bit is a different bit than memory L
   signal RD: std_logic_vector(3 downto 0);
	signal RM: std_logic_vector(3 downto 0);  
	signal BIT4: std_logic;
	
begin

   -- assign IBUS bits to internal signals 
   COND <= IBUS(31 downto 28);
   OPCODE <= IBUS(27 downto 26);
   I <= IBUS(25);
   CMD <= IBUS(24 downto 21);
   S <= IBUS(20);
   IBAR <= not IBUS(25);
   PUBWL <= IBUS(24 downto 20);
   L <= IBUS(20); -- memory instruction L bit
   BL <= IBUS(24); -- branch instruction L bit
   RD <= IBUS(15 downto 12); -- destination register
	RM <= IBUS(3 downto 0);
	BIT4 <= IBUS(4); -- convenience for writing equations

	 -- write output equations using when-else syntax 
		
		
		
		
   -- include rows from data processing, load-store, and branch truth tables
   PCSEL <= B"10" when COND=X"1" and OPCODE=B"10" and BL='0' and Z='0' else 				-- bne taking branch
            B"10" when COND=X"0" and OPCODE=B"10" and BL='0' and Z='1' else 				-- beq taking branch
				B"10" when COND=X"E" and OPCODE=B"10" and BL='0' else 					 				-- branch always 
            B"10" when COND=X"E" and OPCODE=B"10" and BL='1' else 							-- branch link 
				B"01" when COND=X"E" and OPCODE=B"00" and CMD=X"D" and RD=X"F" and RM=X"E" else -- mov pc,lr
				B"11"; -- PC+4
		 
		 

   A3SEL <= '1' when COND=X"E" and OPCODE=B"01" and L='0' else -- str
				'1' when OPCODE=B"10" and BL='1' else 					--b/c b writes to lr
            '0';
   
	
   -- choose rotated immediate or not
   ROTSEL <= '1' when OPCODE=B"00" and I='1' else
             '0';

				 
   -- choose shift amount source
   SHAMTSEL <= '1' when OPCODE=B"00" and I='0' and BIT4='1' else
               '0';

					
   -- choose ALU source 2
   SRC2SEL <= '1' when OPCODE=B"00" and I='1' else
              '1' when OPCODE=B"01" else
              '0';

				  
	--active low !!!!!!!! (MESSED ME UP IN TESTING)			
	REGWR <= '0' when OPCODE="00" and CMD/=X"A" and CMD/=X"B" else -- data processing apart from compares
				'0' when OPCODE="01" and L='1' else                   -- ldr
				'0' when OPCODE="10" and BL='1' else                  -- bl
				'1';	
				

				
   -- ALU operation select
   ALUSEL <= X"0" when OPCODE=B"00" and CMD=X"0" else 	 -- and
             X"1" when OPCODE=B"00" and CMD=X"1" else 	 -- eor
             X"2" when OPCODE=B"00" and CMD=X"2" else 	 -- sub
             X"2" when OPCODE=B"00" and CMD=X"A" else 	 -- cmp
             X"3" when OPCODE=B"00" and CMD=X"3" else 	 -- rsb
             X"4" when OPCODE=B"00" and CMD=X"4" else 	 -- add
             X"4" when OPCODE=B"00" and CMD=X"B" else  	 -- cmn
             X"C" when OPCODE=B"00" and CMD=X"C" else 	 -- orr
             X"D" when OPCODE=B"00" and CMD=X"D" else 	 -- mov
             X"E" when OPCODE=B"00" and CMD=X"E" else	    -- bic
             X"F" when OPCODE=B"00" and CMD=X"F" else 	 -- mvn
             X"4" when OPCODE=B"01" and IBUS(23)='1' else -- ldr/str +offset
             X"2" when OPCODE=B"01" and IBUS(23)='0' else -- ldr/str -offset
             X"0";

   -- CPSR write select (flags)
   CPSRWR <= B"00" when OPCODE=B"00" and CMD=X"A" else -- cmp
             B"00" when OPCODE=B"00" and CMD=X"B" else -- cmn
             B"00" when OPCODE=B"00" and S='1' and CMD=X"2" else -- subs
             B"00" when OPCODE=B"00" and S='1' and CMD=X"3" else -- rsbs
             B"00" when OPCODE=B"00" and S='1' and CMD=X"4" else -- adds
             B"01" when OPCODE=B"00" and S='1' and CMD=X"0" else -- ands
             B"01" when OPCODE=B"00" and S='1' and CMD=X"1" else -- eors
             B"01" when OPCODE=B"00" and S='1' and CMD=X"C" else -- orrs
             B"01" when OPCODE=B"00" and S='1' and CMD=X"D" else -- movs
             B"01" when OPCODE=B"00" and S='1' and CMD=X"E" else -- bics
             B"01" when OPCODE=B"00" and S='1' and CMD=X"F" else -- mvns
             B"11";

				 
   -- memory write enable | store
   MEMWR <= '0' when OPCODE=B"01" and L='0' else '1';

   -- memory read enable | load
   MEMRD <= '0' when OPCODE=B"01" and L='1' else '1';

   -- writeback data select
	WD4SEL <= "00" when OPCODE="01" and L='1' else  --LDR
				 "10" when OPCODE="10" and BL='1' else --PC4
				 "01";                                 --ALU
			                              

   -- destination register select | (bl writes to lr)
   A4SEL <= '1' when OPCODE=B"10" and BL='1' else 
            '0';
				 
end architecture DATAFLOW;