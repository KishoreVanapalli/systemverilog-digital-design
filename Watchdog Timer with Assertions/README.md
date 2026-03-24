Good—Day 4 is where your project starts showing **verification maturity**, not just RTL ability.
# Watchdog Timer with Assertions

## 📘 Theory

A watchdog timer is a hardware safety mechanism used to detect and recover from system failures such as software hangs, infinite loops, or unexpected stalls.

It operates by continuously monitoring system activity. If the system fails to respond within a predefined time window, the watchdog triggers a **timeout signal**, which can be used to reset or recover the system.

---

## ⚙️ Working Principle

The watchdog contains a **counter** that increments on every clock cycle.

```text id="wdq7g8"
Normal Operation:
System sends periodic "kick" → counter resets → no timeout

Failure Case:
No kick → counter reaches LIMIT → timeout triggered
```

---

## 🏗️ Architecture

```text id="p0o9yx"
        ┌───────────────┐
        │   Watchdog    │
        │               │
clk ───▶│ Counter Logic │───▶ timeout
rst ───▶│               │
kick ──▶│ Reset Control │
        └───────────────┘
```

---

## 🔄 Operation Flow

### Normal Condition

```text id="u2ny8u"
kick → counter reset → system healthy
```

### Timeout Condition

```text id="9aqw0m"
no kick → counter increments → reaches LIMIT → timeout = 1
```

---

## 🧠 Key Design Concepts

### 1. Safety Monitoring

The watchdog ensures:

* System is alive and responsive
* Failures are detected automatically

---

### 2. Counter-Based Timing

* Uses a counter to track elapsed time
* Timeout occurs when:

```text id="sq8uvm"
counter == LIMIT
```

---

### 3. Priority Control

* `rst` (highest priority) → clears system
* `kick` → resets counter
* otherwise → counter increments

---

### 4. Non-Blocking Behavior

* Counter stops incrementing after timeout
* Prevents overflow and undefined behavior

---

## 🔍 Assertions (SystemVerilog Assertions – SVA)

Assertions are used to verify that the design behaves correctly under all conditions.

### Purpose

* Detect design violations early
* Automatically check correctness during simulation

---

### Key Assertions Used

#### 1. Reset Behavior

```text id="vj8e4g"
If reset is asserted → counter must be 0
```

---

#### 2. Kick Behavior

```text id="0l9u4k"
If kick is asserted → counter resets in next cycle
```

---

#### 3. Counter Limit

```text id="cy0r7k"
Counter must never exceed LIMIT
```

---

#### 4. Timeout Condition

```text id="d1j9pw"
Timeout must occur only when counter reaches LIMIT
```

---

### Assertion Operators

* `|->` → immediate implication (same cycle)
* `|=>` → delayed implication (next cycle)
* `##` → cycle delay

---

## 📊 Functional Coverage

Coverage ensures that important scenarios are actually tested.

### Covered Scenarios

* Kick events
* Timeout occurrence
* Counter range behavior
* Interaction between kick and timeout

---

### Purpose

* Measures test completeness
* Ensures edge cases are exercised

---

## ⚠️ Design Considerations

### 1. Kick Timing

* Kick must occur before timeout
* Late kick → system reset unavoidable

---

### 2. Counter Overflow

* Must prevent counter exceeding LIMIT

---

### 3. Reset Priority

* Reset must override all other operations

---

### 4. Glitch-Free Timeout

* Timeout must be stable and deterministic

---

## 🧠 Advanced Insight

In real systems:

* Watchdogs may include **windowing**
  → Kick allowed only within a valid time window

* Can trigger:

  * system reset
  * interrupt
  * fail-safe mode

* Used in:

  * Automotive systems (ASIL compliance)
  * Medical devices
  * Embedded controllers

---

## 🚀 What I Learned

* Designing **safety-critical hardware blocks**
* Writing **SystemVerilog Assertions (SVA)**
* Understanding **formal-like verification concepts**
* Using **coverage to validate test completeness**

---

## 🔧 Possible Improvements

* Add **programmable timeout value**
* Implement **window watchdog**
* Add **interrupt before timeout**
* Integrate with **system reset controller**
* Extend with **formal verification (assume/assert)**

---

## 🎯 Real-World Relevance

Watchdog timers are used in:

* Automotive ECUs
* Embedded systems
* Industrial control systems
* Safety-critical applications

---

## 🧠 Important Note

This is a simplified model.

---
