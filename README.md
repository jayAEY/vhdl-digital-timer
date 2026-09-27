# ⏱️ Cascading VHDL 4-Digit Digital Timer

A modular **4-digit digital timer (MM:SS)** written in VHDL for a Digital Systems lab assignment. 
Built upon an instructor-provided template, this project expands the base code into a cascading time-tracking core that outputs directly to an FPGA board's 7-segment displays in hex.

---

## 🚀 Lab Implementation Details

* **Cascading Counter Topology** → Interlinked counter blocks via dynamic output enable lines for precise rollovers.
* **Dual Time Domains** → Structural isolation managing Minute Tens, Minute Ones, Second Tens, and Second Ones.
* **Hex Decoding Interface** → Decodes 4-bit binary values into active-low 7-segment array codes.
* **Variable Prescalar Division** → Scales simulation timelines and physical hardware timing.

---

## ⚙️ Project Architecture & Signal Flow

| Component Group | Component Mapping | Target Display Output | Modulo Property (M) | Bit-Width Flag (N) |
| :--- | :--- | :--- | :--- | :--- |
| 🔴 **Minutes Tens** | `minTens` | `HEX3` (Tens Position) | `M => 6` | `N => 4` |
| 🔴 **Minutes Ones** | `minOnes` | `HEX2` (Ones Position) | `M => 10` | `N => 4` |
| 🔵 **Seconds Tens** | `secTens` | `HEX1` (Tens Position) | `M => 6` | `N => 4` |
| 🔵 **Seconds Ones** | `secOnes` | `HEX0` (Ones Position) | `M => 10` | `N => 4` |
| 🟢 **System Clock Divider** | `prescalar` | Internal Driver | Variable | `N => 26` |

---

## 🔬 Hardware Verification & Implementation

* **7-Segment Display Drivers:** Active-low mapping arrays for display output from `0` to `F`.
* **Frequency Adjustment:** Configurable generics for simulation versus real-world 50 MHz physical clock inputs.

---

## 🔧 Target System Tools

* **Software Ecosystem:** Intel Quartus Prime Toolchain
* **Hardware Language:** VHDL-1993 / IEEE standard libraries (`std_logic_1164`, `numeric_std`)
* **Target Interface:** FPGA Board 7-Segment Displays (`HEX0` - `HEX3`)

---

## 💻 Target Deployment Hardware

* **Development Board:** Terasic DE10-Lite
* **Onboard FPGA:** Intel MAX 10 (10M50DAF484C7G)
* **Hardware Clock Frequency:** 50 MHz Onboard Oscillator (`MAX10_CLK1_50`)
* **Display Configuration:** 4x Built-In Common-Anode 7-Segment Digit Arrays
