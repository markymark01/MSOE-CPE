# Single-Cycle Processor (VHDL) — MSOE Computer Architecture & Assembly Language

A single-cycle processor (SCP) with an **ARMv4-style 32-bit RISC architecture**, designed
from scratch in VHDL and deployed onto an Intel/Altera **DE10-Lite FPGA** (MAX 10,
10M50DAF484C7G) to drive real hardware I/O. Built over three labs for **CPE1510** at MSOE.

## Overview

This project implements a complete single-cycle CPU datapath and control unit in VHDL,
progressing from simulation to real hardware control:

- **Lab 1 — Core SCP design.** Built the datapath and control unit for a single-cycle,
  ARMv4-style processor: 16 general-purpose registers, 32-bit instruction/data width, ALU,
  barrel shifter/rotator, and a CPSR (condition flags) register — following the ARM
  convention of condition-coded instruction execution. Verified in simulation before moving
  to hardware.
- **Lab 2 — Hardware deployment.** Synthesized the SCP onto a DE10-Lite FPGA and used it as
  a real hardware controller: driving six 7-segment displays and controlling motor outputs
  for basic robot movement, closing the loop between the processor's instruction execution
  and physical outputs.
- **Lab 3 — Custom IROM / behavior simulation.** Authored the instruction ROM (IROM) that
  the SCP executes, programming a sequence of ARM-style instructions to simulate the
  behavior of a puppy — barking, following a perimeter, spinning, and crawling — all driven
  purely by code running on the processor built in Labs 1–2.

## Architecture

- **ISA style:** ARMv4-influenced — condition-coded execution via a CPSR (flags) register,
  32-bit instructions decoded into standard ARM-style fields (opcode, Rn/Rd fields, shift
  amount, rotate select, immediate/second-operand select)
- **Datapath:** single-cycle (one instruction fully executes per clock cycle — no pipelining)
- **Register file:** 16 general-purpose registers, 32-bit width
- **Key components:** ALU, barrel shifter/rotator, adder (PC/branch target calc), address
  decoder, data memory (DMEM), sign/immediate extender, 4-to-1 bus mux, CPSR, IROM, register
  file, general register elements
- **Control unit:** built in Lab 1 — decode + control logic driving register-write,
  source-select, shift-amount-select, and rotate-select signals each cycle
- **Target hardware:** Intel/Altera DE10-Lite FPGA (MAX 10, 10M50DAF484C7G)
- **I/O:** 6× 7-segment displays, 10 LEDs, 5 motor outputs, 10 slider switches, 3 clear
  lines, system reset

## Repo structure (Quartus project)

\`\`\`
components/
  adder.vhd            -- PC increment / branch target adder
  addressdecoder.vhd    -- memory-mapped address decoding
  alu.vhd                 -- arithmetic/logic unit
  busmux4to1.vhd           -- 4-to-1 operand bus mux
  control.vhd               -- control unit / instruction decode logic
  cpsr.vhd                   -- condition flags register (ARM-style CPSR)
  dmem.vhd                    -- data memory
  extender.vhd                 -- sign/zero extension for immediates
  irom.vhd                      -- instruction ROM (Lab 3: puppy-behavior program)
  reg32.vhd, regn.vhd, regfile.vhd  -- 32-bit register, general register, register file (16 regs)
  rotator.vhd, shifter.vhd            -- barrel shifter/rotator
  seg7decode.vhd                       -- 7-segment display decoder
LAB3.qsf / LAB3.qpf         -- Quartus project + pin assignments (DE10-Lite)
*.bdf                        -- top-level and datapath block diagrams (schematic capture)
\`\`\`

## What this demonstrates

- Full-stack processor design: datapath, control logic, instruction encoding, and ROM
  authoring — not just theory, but a working chip programmed and deployed on real hardware.
- Hardware/software integration: writing the actual instruction sequence (IROM) that drives
  physical outputs — motors, displays — through the processor you built yourself.
- Simulation-to-silicon workflow: verified in simulation (Lab 1) before committing to FPGA
  synthesis and physical I/O (Labs 2–3).

---
*Course project for CPE1510, MSOE.*
