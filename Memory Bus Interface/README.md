# Memory Bus Interface (CPU ↔ Memory Communication)

## 📘 Theory

Modern digital systems (SoCs) consist of multiple components such as CPUs, memories, and peripherals that must communicate efficiently. This communication is handled through a **bus interface**, which defines how data and control signals are exchanged.

This project implements a **simple memory bus protocol** between a CPU and memory using a **handshake-based communication model**.

---

## 🏗️ Architecture

```text
        ┌──────────┐        ┌──────────┐
        │   CPU    │        │  Memory  │
        └────┬─────┘        └────┬─────┘
             │                   │
             └────── Bus ────────┘

Signals:
addr, write_data, read_data,
read, write, ready
```

---

## ⚙️ Bus Signals

| Signal       | Description                      |
| ------------ | -------------------------------- |
| `addr`       | Address for read/write operation |
| `write_data` | Data sent from CPU to memory     |
| `read_data`  | Data returned from memory        |
| `read`       | Read request signal              |
| `write`      | Write request signal             |
| `ready`      | Indicates operation completion   |

---

## 🔄 Communication Flow

### Write Transaction

```text
1. CPU sets addr + write_data
2. CPU asserts write = 1
3. Memory processes request
4. Memory asserts ready = 1
```

---

### Read Transaction

```text
1. CPU sets addr
2. CPU asserts read = 1
3. Memory fetches data
4. Memory sets read_data
5. Memory asserts ready = 1
```

---

## 🤝 Handshake Mechanism

The `ready` signal is critical:

* CPU **must wait** until `ready = 1`
* Prevents incorrect assumptions about timing
* Supports **variable latency systems**

### Key Idea

```text
Request → Wait → Ready → Complete
```

---

## 🧠 Key Design Concepts

### 1. Decoupled Communication

* CPU does not assume immediate response
* Memory controls when data is valid

👉 This enables flexible system design

---

### 2. Interface Abstraction

SystemVerilog `interface` is used to group bus signals:

* Improves readability
* Reduces wiring complexity
* Supports `modport` for direction control

---

### 3. FSM-Based CPU Control

CPU uses a **Finite State Machine** to manage:

* issuing read/write requests
* waiting for `ready`
* sequencing transactions

---

### 4. Synchronous Communication

* All signals operate on the same clock
* Ensures predictable timing behavior

---

## ⚠️ Design Considerations

### 1. Latency Handling

* Memory may not respond immediately
* CPU must stall until `ready` is asserted

---

### 2. Mutual Exclusivity

* `read` and `write` should not be active together
* Avoids undefined behavior

---

### 3. Address Validity

* CPU must provide valid address before asserting control signals

---

### 4. Data Stability

* Signals must remain stable until transaction completes

---

## 🧠 Advanced Insight

This simple protocol models real industry buses:

| Protocol | Key Feature                 |
| -------- | --------------------------- |
| AXI      | High-performance, pipelined |
| AHB      | Burst transfers             |
| APB      | Simple peripheral interface |

Your design is conceptually closest to **APB-style handshake**.

---

## 🚀 What I Learned

* Designing **module-to-module communication**
* Implementing **handshake protocols**
* Using **interfaces and modports**
* Handling **variable latency systems**
* Building **FSM-controlled transactions**

---

## 🔧 Possible Improvements

* Add **burst transactions**
* Support **multiple masters (arbitration)**
* Introduce **pipelining**
* Add **error/response signals**
* Implement **timeout mechanism**

---

## 🎯 Real-World Relevance

Bus interfaces are used in:

* System-on-Chip (SoC) design
* Embedded processors
* Memory controllers
* Peripheral communication

---

## 🧠 Important Note

This is a simplified synchronous model.

