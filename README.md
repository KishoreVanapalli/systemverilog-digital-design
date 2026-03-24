# 🚀 SystemVerilog RTL & Verification Projects

This repository contains a collection of **SystemVerilog-based RTL design and verification projects** built to demonstrate strong fundamentals in:

* Digital Design (RTL)
* Verification Methodologies
* System-Level Thinking
* Hardware Communication Protocols

Each project focuses on a **real-world hardware concept**, progressing from basic RTL to complete system-level design and verification.

---

# 📂 Project Structure

```
├── UART
├── Dual-Port Register File
├── Memory Bus Interface
├── Watchdog Timer with Assertions
├── Random Instruction Generator
├── FIFO Verification Environment
├── Packet Buffer System
└── README.md
```

---

# 🗓 Project Breakdown

---

## 🟢 Day 1 – UART System (Baud + TX + RX + Interface)

### 📘 Overview

Designed a complete **UART communication system** including:

* Baud Rate Generator
* Transmitter (FSM-based)
* Receiver
* Interface-based connectivity

### 🎯 Key Concepts

* FSM-controlled datapath
* Serial communication
* Timing synchronization using clock enable
* Interface & modport usage

### 🚀 Learning Outcome

* Built a full communication pipeline
* Understood timing mismatches and sampling issues
* Debugged real-world UART problems

---

## 🔵 Day 2 – Dual-Port Register File

### 📘 Overview

Implemented a **16x32 dual-port register file** supporting:

* 2 simultaneous reads
* 1 write operation

### 🎯 Key Concepts

* Multi-port memory design
* Synchronous write & combinational read
* Address decoding
* CPU datapath relevance

### 🚀 Learning Outcome

* Learned how processors fetch operands in parallel
* Understood read-after-write hazards

---

## 🟡 Day 3 – Memory Bus Interface

### 📘 Overview

Designed a **CPU ↔ Memory communication system** using a handshake protocol.

### 🎯 Key Concepts

* Bus protocols
* Ready/valid handshake
* Interface-based communication
* FSM-based transaction control

### 🚀 Learning Outcome

* Understood how SoC components communicate
* Learned latency handling using handshake signals

---

## 🔴 Day 4 – Watchdog Timer with Assertions

### 📘 Overview

Implemented a **watchdog timer** with:

* Counter-based timeout detection
* SystemVerilog Assertions (SVA)
* Functional coverage

### 🎯 Key Concepts

* Safety-critical design
* Assertions (`assert property`)
* Coverage-driven verification

### 🚀 Learning Outcome

* Learned how to verify correctness, not just functionality
* Introduced to formal-like verification concepts

---

## 🟣 Day 5 – Random Instruction Generator

### 📘 Overview

Built a **constrained random instruction generator** for CPU verification.

### 🎯 Key Concepts

* SystemVerilog classes
* Randomization (`rand`, `randc`)
* Constraints
* Functional validity

### 🚀 Learning Outcome

* Generated meaningful test scenarios
* Understood constrained random verification (CRV)

---

## 🟠 Day 6 – FIFO Verification Environment

### 📘 Overview

Developed a **transaction-based verification environment** for FIFO.

### 🧩 Components

* Driver
* Monitor
* Scoreboard
* Environment

### 🎯 Key Concepts

* Mailbox communication
* Transaction-level modeling
* Data integrity checking
* Concurrency (`fork-join`)

### 🚀 Learning Outcome

* Built modular verification architecture
* Understood real industry-style testbench design

---

## 🟤 Day 7 – Packet Buffer System (Mini SoC Block)

### 📘 Overview

Designed a **packet processing pipeline**:

```
Packet Generator → FIFO → Packet Processor
```

### 🎯 Key Concepts

* Streaming interfaces (valid/ready)
* Backpressure handling
* FIFO buffering
* End-to-end verification

### 🚀 Learning Outcome

* Built a system-level design
* Understood data flow and pipeline architecture

---

# 🧠 Key Skills Demonstrated

* SystemVerilog RTL Design
* FSM Design
* Interface & Modport Usage
* Assertions & Coverage
* Constrained Random Verification
* Transaction-Based Verification
* FIFO & Buffer Design
* SoC Communication Concepts

---

# ⚙️ Tools & Technologies

* SystemVerilog
* ModelSim / QuestaSim
* VS Code

---

# 🚀 How to Run

```bash
# Compile
vlog rtl/*.sv tb/*.sv

# Simulate
vsim tb_top

# Run
run -all
```

---

# 📈 Future Improvements

* Convert environments to **UVM-based architecture**
* Add **functional coverage models**
* Implement **AXI/Advanced bus protocols**
* Add **formal verification**
* Improve **error handling & corner case testing**

---

# 🎯 Conclusion

This repository demonstrates a complete journey from:

* Basic RTL design →
* Communication protocols →
* Verification environments →
* System-level architecture

It reflects strong understanding of both:
✔ Design (RTL)
✔ Verification (Testbench & Assertions)

---

