# Dual-Port Register File (CPU Block)

## 📘 Theory

A register file is a small, high-speed storage block used inside processors to store **operands, intermediate results, and temporary data** during instruction execution.

This project implements a **dual-port register file**, which allows:

* **Two simultaneous read operations**
* **One write operation per clock cycle**

This structure is fundamental to modern CPUs, enabling parallel data access and improving execution efficiency.

---

## 🏗️ Architecture

```text id="h2q1nb"
           ┌───────────────────────────┐
           │       Register File       │
           │                           │
 write →   │  [16 x 32-bit registers] │   → read_data1
           │                           │   → read_data2
           └───────────────────────────┘
                ↑           ↑
          read_addr1   read_addr2
```

---

## ⚙️ Key Features

* **16 Registers** → Addressed using 4-bit indices
* **32-bit Width** → Each register stores 32-bit data
* **Dual Read Ports** → Two independent read addresses
* **Single Write Port** → Controlled by `write_enable`

---

## 🔄 Operation

### 1. Write Operation (Synchronous)

* Occurs on **clock edge**
* Controlled by `write_enable`
* Data is written to `regs[write_addr]`

```text id="7kgv5f"
if (write_enable)
    regs[write_addr] <= write_data;
```

---

### 2. Read Operation (Combinational)

* Reads are **instant (no clock required)**
* Outputs update whenever read addresses change

```text id="8w4x3c"
read_data1 = regs[read_addr1]
read_data2 = regs[read_addr2]
```

---

## 🧠 Key Design Concepts

### 1. Parallel Data Access

Dual-port design allows:

* Fetching two operands simultaneously
* Essential for instructions like:

```text id="8x3z3j"
ADD R1, R2, R3   → needs R2 and R3 at same time
```

---

### 2. Synchronous Write vs Combinational Read

* Writes are clocked → ensures stability
* Reads are combinational → ensures speed

👉 This combination balances **performance and reliability**

---

### 3. Address Decoding

* Register selection is based on address inputs
* Internally implemented as array indexing

---

### 4. Hardware Efficiency

Register files are optimized for:

* Low latency
* High bandwidth
* Frequent access

---

## ⚠️ Design Considerations

### 1. Read-After-Write Hazard

If:

```text id="qz2j0x"
write_addr == read_addr
```

Question:
👉 Should read return **old value or new value?**

This depends on design choice:

* Write-first (new value)
* Read-first (old value)

---

### 2. Write Conflicts

* Only one write port → avoids conflicts
* Multi-write designs require arbitration

---

### 3. Reset Behavior

* Registers may need initialization (optional)
* Some designs leave them undefined for performance

---

## 🧠 Advanced Insight

In real processors:

* Register file is accessed in **pipeline stages**
* Must support **multiple reads per cycle**
* Designed using **multi-ported SRAM or flip-flops**

---

## 🚀 What I Learned

* Designing **multi-port memory structures**
* Handling **parallel read operations**
* Understanding **CPU datapath components**
* Managing **synchronous vs combinational logic**

---

## 🔧 Possible Improvements

* Add **reset initialization**
* Support **multiple write ports**
* Add **forwarding logic (hazard resolution)**
* Implement **register zero (always 0) behavior**
* Add **pipeline compatibility**

---

## 🎯 Real-World Relevance

Register files are used in:

* CPUs (RISC-V, ARM, x86)
* DSP processors
* GPUs
* Embedded controllers

---

## 🧠 Important Note

This is a simplified behavioral model.


