# Lipsi Project

## Overview

This project implements a **Lipsi 8-bit accumulator-based processor** in **Verilog HDL** and targets the **Basys3 FPGA board**. The processor was designed as a compact educational soft processor capable of executing arithmetic, memory, branching, and I/O operations while demonstrating real program execution on hardware.

The implementation includes:
- accumulator-based datapath
- unified instruction and data memory
- finite state machine (FSM) control unit
- program counter and memory interface
- seven-segment display output on Basys3
- I/O support for external input
- demonstration programs for **Fibonacci** and **factorial**

---

## Architecture Summary

The processor is based on a simplified Lipsi-style design with the following major components:

- **Program Counter (PC)**  
  Stores the current instruction address.

- **Accumulator (A)**  
  Main working register used by arithmetic and logical instructions.

- **Arithmetic Logic Unit (ALU)**  
  Performs operations such as load, add, and subtract.

- **Unified Memory**  
  Stores both instructions and data.

- **Control Unit**  
  Implemented using a multicycle FSM with states for fetch, decode, operand fetch, memory read, execute, and exit.

- **I/O Interface**  
  Supports external input and output instructions.

- **Seven-Segment Display Driver**  
  Displays processor output on the Basys3 board in hexadecimal format.

---

## Memory Organization

The processor uses a single memory array divided logically into:

| Address Range | Purpose |
|---|---|
| 0 -- 255 | Data / register memory |
| 256 -- 511 | Instruction memory |

The lower memory region is used as software-visible registers and data storage during program execution.

---

## Implemented Instruction Categories

The implemented design supports the core instruction families required for the demonstrated applications:

- **ALU register instructions**
- **Store instructions**
- **ALU immediate instructions**
- **Branch instructions**
- **I/O instructions**
- **Exit instruction**

These were sufficient to execute the demonstrated Fibonacci and factorial programs on simulation and hardware.

---

## ALU Encoding

The ALU operation is selected using a 3-bit function field.

| Encoding | Name | Operation |
|---|---|---|
| 000 | add | `A = A + op` |
| 001 | sub | `A = A - op` |
| 010 | adc | `A = A + op + c` |
| 011 | sbb | `A = A - op - c` |
| 100 | and | `A = A & op` |
| 101 | or  | `A = A \| op` |
| 110 | xor | `A = A ^ op` |
| 111 | ld  | `A = op` |

In the current demonstrated programs, the most frequently used operations are **load**, **add**, and **subtract**.

---

## FSM Control Flow

The control unit uses a multicycle finite state machine with the following main states:

- `FETCH1` – fetch instruction byte
- `DECODE` – decode instruction type
- `FETCH2` – fetch second byte for immediate/branch instructions
- `MEMREAD` – read operand from memory
- `EXEC` – execute instruction
- `EXIT` – stop execution

This FSM structure allows support for both 1-byte and 2-byte instructions while keeping the datapath compact.

---

## Basys3 Integration

The design was implemented for the **Basys3 FPGA board**.

### Input
An 8-bit input path is provided so that values such as `n` can be supplied externally.

### Output
The processor output is transferred to an output register and displayed on the **seven-segment display**.

### Display Format
The 8-bit value is displayed as **two hexadecimal digits**:
- lower nibble on one digit
- upper nibble on the next digit

A refresh mechanism multiplexes the digits at a high enough rate for stable viewing.

---

## Demonstration Programs

### 1. Fibonacci Program
The processor executes a Fibonacci program using memory locations as working registers for:
- previous value
- current value
- counter
- temporary storage

The generated sequence is computed iteratively and displayed on hardware.

### 2. Factorial Program
The factorial program computes `N!` using iterative arithmetic and loop-based control flow. Since no direct multiplication unit was used in the demonstrated design, the algorithm was implemented using repeated arithmetic operations and branching.

---

## Main Verilog Modules

Typical project files include:

- `pc.v` – Program Counter
- `accumulator.v` – Accumulator register
- `alu.v` – Arithmetic Logic Unit
- `memory.v` – Unified memory block
- `control_unit.v` – FSM-based controller
- `seven_segment.v` – Display driver
- `lipsi_top.v` – Top-level module for Basys3 integration

---

## How to Run

### Simulation
1. Add all Verilog source files and the testbench to your simulation project.
2. Compile the design.
3. Run the testbench.
4. Observe internal signals such as:
   - accumulator output
   - memory values
   - program counter
   - control states

### FPGA Implementation
1. Add all Verilog files to your Vivado project.
2. Add the Basys3 constraints file.
3. Synthesize and implement the design.
4. Generate the bitstream.
5. Program the Basys3 board.
6. Apply input values and observe output on the seven-segment display.

---

