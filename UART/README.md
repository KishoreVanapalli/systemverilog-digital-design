UART System (Baud + TX + RX + Interface)

## 📘 Theory

A UART (Universal Asynchronous Receiver Transmitter) system enables **serial communication between digital devices without a shared clock**. Instead of a clock line, both transmitter and receiver operate using a **common baud rate**, ensuring synchronized data transfer.

This project implements a **complete UART communication chain**, including:

* Baud Rate Generator
* UART Transmitter (TX)
* UART Receiver (RX)
* Interface-based connectivity

---

## 📡 UART Frame Format

Each transmitted data frame follows a structured format:

```text
| START (0) | DATA (8 bits, LSB first) | STOP (1) |
```

* **Start Bit (0)** → Indicates beginning of transmission
* **Data Bits** → 8-bit payload, transmitted LSB first
* **Stop Bit (1)** → Marks end of frame

The line remains **HIGH (1)** during idle.

---

## 🏗️ System Architecture

```text
        ┌──────────────────────┐
        │  Baud Rate Generator │
        │  (tx_en / rx_en)     │
        └─────────┬────────────┘
                  │
      ┌───────────▼───────────┐
      │      Interface        │
      │ (shared signals)      │
      └───────┬───────┬───────┘
              │       │
        ┌─────▼───┐ ┌─▼──────┐
        │ Transmit│ │ Receive│
        │   (TX)  │ │  (RX)  │
        └─────┬───┘ └───┬────┘
              │          │
              └────tx────┘
```

---

## ⚙️ Key Components

### 1. Baud Rate Generator

The baud rate generator creates timing pulses:

* `tx_en` → controls transmission timing
* `rx_en` → controls sampling timing

Each pulse represents **one bit duration**.

### Insight

All UART operations must align with this timing—any mismatch leads to data corruption.

---

### 2. UART Transmitter (TX)

The transmitter converts parallel data into a serial stream using an FSM.

#### States:

* **IDLE** → waits for enable signal
* **START** → sends start bit (`0`)
* **DATA** → transmits 8 bits (LSB first)
* **STOP** → sends stop bit (`1`)

#### Operation:

* Loads input data into a register
* Shifts out bits on each `tx_en` pulse

---

### 3. UART Receiver (RX)

The receiver reconstructs parallel data from the serial stream.

#### States:

* **IDLE** → monitors line for start bit
* **DATA** → samples incoming bits
* **STOP** → completes frame reception

#### Operation:

* Detects falling edge (start bit)
* Samples bits at correct intervals using `rx_en`
* Stores received bits into output register

---

### 4. Interface-Based Design

A SystemVerilog `interface` is used to connect all modules.

#### Benefits:

* Cleaner connectivity
* Avoids excessive port wiring
* Supports `modport` for directional control

---

## ⏱️ Timing and Synchronization

UART is **asynchronous**, so timing is critical:

* Transmitter and receiver must use the **same baud rate**
* Receiver samples bits at the **center of each bit period**
* Any mismatch leads to incorrect data reconstruction

---

## 🧠 Key Design Concepts

### 1. FSM-Controlled Communication

Both TX and RX are controlled by FSMs that manage sequencing and timing.

---

### 2. Serial Data Flow

* Parallel input → serialized transmission
* Serial input → reconstructed parallel output

---

### 3. Clock Enable vs Clock

Instead of generating a new clock:

* Use **clock enable signals (`tx_en`, `rx_en`)**
* Keeps design synchronous and stable

---

### 4. Interface Abstraction

Encapsulates communication signals and simplifies system integration.

---

## ⚠️ Design Challenges

* **Baud rate mismatch** → data corruption
* **Incorrect sampling** → wrong bit capture
* **State misalignment** → frame errors
* **Start bit detection reliability**

---

## 🚀 What I Learned

* Designing a **complete communication system**
* Handling **timing-sensitive protocols**
* Implementing **FSM-based TX and RX**
* Using **SystemVerilog interfaces and modports**
* Debugging **real timing mismatches**

---

## 🔧 Possible Improvements

* Add **oversampling (8x/16x)** for robust reception
* Implement **parity bit for error detection**
* Add **FIFO buffering** for continuous data flow
* Support **configurable baud rates**
* Handle **asynchronous clock domains (CDC)**

---

## 🎯 Real-World Relevance

UART is widely used in:

* Embedded systems (microcontrollers)
* Debugging interfaces (serial console)
* Communication modules (Bluetooth, GPS, Wi-Fi)

---

## 🧠 Important Note

This implementation is a **synchronous simplified model** of UART.
