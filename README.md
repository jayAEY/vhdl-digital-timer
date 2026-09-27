# ⏱️ VHDL Four-Digit Digital Timer

A four-digit MM:SS digital timer implemented in VHDL and deployed on a DE10-Lite FPGA development board.

The design uses cascaded modulo counters, clock division logic, and 7-segment display drivers to track and display elapsed time. The project was completed as part of a Digital Systems course lab.

---

## 🚀 Key Features

* Cascaded modulo counters for seconds and minutes rollover.
* Independent counter stages for minute tens, minute ones, second tens, and second ones.
* 7-segment display decoding for FPGA display output.
* Configurable clock division for simulation and hardware deployment.
  
---

## ⚙️ Architecture

| Component Group | Signal | Target Display Output | Modulo Property (M) | Bit-Width (N) |
| :--- | :--- | :--- | :--- | :--- |
| 🔴 **Minutes Tens** | `minTens` | `HEX3` (Tens Position) | `M => 6` | `N => 4` |
| 🔴 **Minutes Ones** | `minOnes` | `HEX2` (Ones Position) | `M => 10` | `N => 4` |
| 🔵 **Seconds Tens** | `secTens` | `HEX1` (Tens Position) | `M => 6` | `N => 4` |
| 🔵 **Seconds Ones** | `secOnes` | `HEX0` (Ones Position) | `M => 10` | `N => 4` |
| 🟢 **System Clock Divider** | `prescalar` | Internal Driver | Variable | `N => 26` |

---

## 🔬 Hardware Verification & Implementation

* **7-Segment Display Drivers:** Active-low mapping arrays for display output from `0` to `F`.
* **Frequency Adjustment**: Clock divider implemented using configurable generics to support both simulation and hardware operation.
* **Functional Testing**: Verified counter rollover behavior and display outputs during simulation and FPGA deployment.
---

## 🔧 Target System Tools

* **Development Tools:** Intel Quartus Prime Toolchain
* **Hardware Language:** VHDL-1993 / IEEE standard libraries (`std_logic_1164`, `numeric_std`)
* **Target Interface:** FPGA Board 7-Segment Displays (`HEX0` - `HEX3`)

---

## 💻 Hardware Platform

* **Development Board:** Terasic DE10-Lite
* **Onboard FPGA:** Intel MAX 10 (10M50DAF484C7G)
* **Hardware Clock Frequency:** 50 MHz Onboard Oscillator (`MAX10_CLK1_50`)
* **Display Configuration:** 4x Built-In Common-Anode 7-Segment Digit Arrays
