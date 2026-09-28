# Task 1: Environment Setup & RISC-V Reference Bring-Up

* **Environment Confirmation:** GitHub Codespaces only (Reference container: `vsdip/vsd-riscv2`)

---

## 1. Execution Evidence & Verification

### A. RISC-V Reference Program Execution
The reference C application (`sum1ton.c`) was compiled with the `riscv64-unknown-elf-gcc` cross-compiler and simulated using the Spike ISA simulator coupled with the RISC-V Proxy Kernel (`pk`).

![RISC-V Reference Execution](./images/riscv_reference_execution.png)

### B. VSDFPGA Lab Bring-Up
The `vsdfpga_labs` repository was integrated into the workspace. The reference firmware (`riscv_logo.c`) was built using the embedded bare-metal toolchain (`-march=rv32i -mabi=ilp32`), generating the target execution ELF and block RAM image (`riscv_logo.bram.hex`).

![VSDFPGA Lab Build](./images/vsdfpga_lab_simulation.png)

### C. Optional Confidence Task (Program Modification)
The loop bound in `sum1ton.c` was adjusted from `n = 9` to `n = 10`. The source was recompiled and simulated via Spike, confirming the expected output `Sum from 1 to 10 is 55`.

![Confidence Task](./images/confidence_task_output.png)

---

## 2. Understanding Check Answers

### Q1: Where is the RISC-V program located in the vsd-riscv2 repository?
**Answer:**  
In the `vsd-riscv2` environment, sample application programs are located inside the `samples/` directory (e.g., `samples/sum1ton.c`, `samples/1ton_custom.c`). In the cloned `vsdfpga_labs` repository, the reference firmware files are located under `basicRISCV/Firmware/` (e.g., `riscv_logo.c`).

### Q2: How is the program compiled and loaded into memory?
**Answer:**  
The source code is compiled into an ELF binary using the RISC-V GNU cross-compiler (`riscv64-unknown-elf-gcc`) configured with target architectural flags and a linker script (such as `bram.ld`).  
* **In Spike ISA simulation:** The RISC-V Proxy Kernel (`pk`) parses the ELF headers, handles segment mapping, and loads the instructions into simulated memory.
* **In HDL/FPGA bring-up:** The compiled ELF binary is converted via firmware utilities into a Verilog-readable memory initialization file (`riscv_logo.bram.hex`), which is loaded into synthesized Block RAM (BRAM) or read during RTL simulation using the `$readmemh` system task.

### Q3: How does the RISC-V core access memory and memory-mapped IO?
**Answer:**  
The core performs standard load and store instructions (`lb`, `lh`, `lw`, `ld`, `sb`, `sh`, `sw`, `sd`). The system implements a unified memory map where physical RAM and memory-mapped I/O (MMIO) registers (such as UART, GPIO, and timers) share the same address space. When a memory access is triggered, the system bus/interconnect decodes the upper address lines to route the transaction to physical RAM if within the RAM region, or to the appropriate peripheral control/status registers if within the MMIO region.

### Q4: Where would a new FPGA IP block logically integrate in this system?
**Answer:**  
A new FPGA IP block logically connects as a slave peripheral on the on-chip system bus/interconnect (such as Wishbone, AXI-Lite, or TileLink). It is allocated an address aperture in the system address map, enabling the RISC-V processor to configure, write to, and read from the IP's internal control and data registers via standard MMIO operations.
