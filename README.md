# ⏱️ VHDL Four-Digit Digital Timer

A four-digit MM:SS digital timer implemented in VHDL and deployed on a DE10-Lite FPGA development board for my digital systems lab.

The design uses a clock divider, counters for the seconds and minutes rollover, and 7-segment display decoders to track and show elapsed time.

---

## 🚀 Features

* **Minutes and Seconds Tracking:** Separate counter stages for minute tens, minute ones, second tens, and second ones.
* **Rollover Logic:** Counters automatically reset and carry over when seconds hit 59 and minutes hit 59.
* **7-Segment Display Decoding:** Built-in multiplexing/decoding to output numbers directly to the board's display digits.
* **Simulation/Hardware Modes:** Uses a configurable generic for the clock divider. Allows for switching between faster counting for simulations and real seconds on the board.

---

## ⚙️ Architecture

| Component | Target Display | Max Count (Modulo) |
| :--- | :--- | :---: |
| **Minutes Tens** | `HEX3` | 6 |
| **Minutes Ones** | `HEX2` | 10 |
| **Seconds Tens** | `HEX1` | 6 |
| **Seconds Ones** | `HEX0` | 10 |

---

## 🔬 Testing

### 💻 Simulation 

* Adjusted the clock divider generic to test the counter rollovers quickly without waiting for a real 50 MHz clock cycle.
* Verified that the active-low display outputs correctly mapped to numbers 0-9.

### 🛠️ Hardware Testing (Intel MAX 10 FPGA)

* Tested on a physical **Terasic DE10-Lite FPGA board with Intel MAX 10 FPGA**
* Programmed with **Intel Quartus Prime**
* Tied timer operation to a slide switch to pause/run, used a pushbutton for hardware reset, and routed the real-time count directly to the four built-in 7-segment displays.

### FPGA Pin Assignments

| Port | Hardware | Description |
| :--- | :--- | :--- |
| **`clock`** | `MAX10_CLK1_50` | Onboard 50 MHz Clock Source |
| **`run_timer`** | Switch 4 | Run / Pause Toggle |
| **`l_reset`** | Key 0 | Active-Low Hardware Reset |
| **`HEX0 - HEX3`** | Seven Segment Displays | 4-Digit Time Output (MM:SS) |
