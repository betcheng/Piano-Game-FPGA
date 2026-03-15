# FPGA Electronic Piano Game

An interactive piano learning game implemented in Verilog on the **Efinix Trion T20F256** FPGA. The system operates at a 50 MHz system clock and provides real-time audio feedback via a buzzer, visual feedback via LEDs, and error tracking on a 7-segment display.

## Demo

[![FPGA Piano Game Demo](https://img.youtube.com/vi/tMM7kKgCvpU/0.jpg)](https://www.youtube.com/watch?v=tMM7kKgCvpU)

---

## Features

- **Demo Mode**: Plays a predefined melody automatically; LEDs illuminate in sync with each note to guide the player
- **Interactive Mode**: Ten logic switches act as piano keys spanning two octaves (middle C to D6); the player follows the demo melody and errors are counted
- **Hardware Debouncing**: Dedicated 4-state FSM debounce module (`xiaodou.v`) with configurable hold time
- **Error Tracking**: Incorrect key presses increment an error counter (0–15) displayed on a 7-segment display
- **Mode Switching**: A dedicated button toggles between Demo and Interactive modes at any time
- **Reset**: Active-low reset restarts the current mode from the beginning

---

## Hardware Platform

| Item | Detail |
|------|--------|
| FPGA | Efinix Trion T20F256 |
| System Clock | 50 MHz |
| Audio Output | Passive buzzer (PWM square wave) |
| User Input | 10 logic switches |
| Visual Output | 10 LEDs + 1 seven-segment display digit |
| Control Buttons | Reset (`rst_n`), Mode Switch (`key_begin`) |

---

## System Architecture

```
                    ┌─────────────┐
                    │   piano.v   │  (Top-level)
                    └──────┬──────┘
           ┌───────────────┼───────────────┐
           ▼               ▼               ▼
      ┌─────────┐    ┌──────────┐   ┌────────────────┐
      │ song.v  │    │speaker.v │   │input_detector.v│
      │  Demo   │    │  Keys →  │   │ Pattern match  │
      │ melody  │    │  Tones   │   │ + error count  │
      └────┬────┘    └────┬─────┘   └───────┬────────┘
           │              │                  │
           └──────────────┴──────────────────┘
                          │
                     ┌────▼─────┐
                     │ select.v │  (Mode multiplexer)
                     └──────────┘
                          │
              ┌───────────┴──────────┐
              ▼                      ▼
         beep / LEDs          seg_led / seg_sel
```

---

## Module Descriptions

### `piano.v` — Top-Level Module
Instantiates and connects all submodules. Routes clock, reset, key inputs, and mode-select signals. Passes audio and display outputs to top-level ports.

### `song.v` — Demo Melody Sequencer
A 64-state FSM-driven melody player. Each state maps to a note frequency and a corresponding LED indicator. The frequency divider generates a PWM square wave at the target pitch; silence states (`R_0`) suppress the wave toggle to mute output cleanly.

**Note frequencies (50 MHz clock):**

| Parameter | Note | Frequency |
|-----------|------|-----------|
| `M_5` | Sol (G5) | ~783 Hz |
| `M_6` | La (A5) | ~879 Hz |
| `M_7` | Si (B5) | ~987 Hz |
| `H_1` | Do' (C6) | ~1046 Hz |
| `H_2` | Re' (D6) | ~1175 Hz |

### `speaker.v` — Real-Time Tone Generator
Maps each of the 10 switch inputs to a note frequency via a `case` statement. A frequency-division counter toggles the buzzer output at the corresponding rate. Supports full middle-octave range (C5–B5) plus C6 and D6.

### `input_detector.v` — Game Logic & Error Tracker
Stores the expected 28-note melody sequence in a register array. On each debounced key press, validates the input against the current expected note. Mismatches increment a 4-bit error counter (max 15) displayed on the 7-segment display using hardcoded segment encoding.

### `select.v` — Mode Multiplexer
A falling-edge-triggered flip-flop toggles `key_r` on each press of `key_begin`, selecting between Demo mode outputs (song + no display) and Interactive mode outputs (speaker + input_detector).

### `xiaodou.v` — Hardware Debounce Module
Parameterised debounce FSM with four states: `IDLE → DONE → HOLD → UP`. A three-stage synchroniser pipeline eliminates metastability on asynchronous switch inputs. Default debounce period: 20 ms (1,000,000 cycles at 50 MHz). Outputs a single-cycle `key_flag` pulse on confirmed key release.

---

## File Structure

```
Piano-Game-FPGA/
├── piano.v              # Top-level module
├── song.v               # Demo melody sequencer
├── speaker.v            # Key-to-tone frequency generator
├── input_detector.v     # Game logic and error tracking
├── select.v             # Demo / interactive mode multiplexer
├── xiaodou.v            # Parameterised hardware debounce FSM
├── piano.lpf            # Pin constraint file (main project)
├── piano.peri.xml       # Efinix peripheral configuration
├── piano.pt.sdc         # Timing constraints
├── select_test.lpf      # Pin constraints for select module testbench
├── select_test.xml      # Peripheral config for select testbench
└── select_test.pt.sdc   # Timing constraints for select testbench
```

---

## How to Use

### Build & Program
1. Open **Efinix Efinity IDE** and create a project targeting the **Trion T20F256**
2. Add all `.v` source files; set `piano.v` as the top-level module
3. Import `piano.lpf` for pin assignments and `piano.peri.xml` for peripheral configuration
4. Compile and upload the bitstream to the board

### Playing
1. Power on — the board starts in **Demo Mode**, playing the melody with LED feedback
2. Press **`key_begin`** to switch to **Interactive Mode**
3. Follow the LED indicators and press the corresponding switches in sequence
4. Errors are shown on the 7-segment display (0–F)
5. Press **`rst_n`** at any time to restart the current mode

---

## Known Limitations

- Single-switch-at-a-time input only; simultaneous presses default to mute
- Melody sequence is hardcoded (28 notes); extending it requires modifying `input_detector.v`
- `select.v` mode toggle uses a negedge-triggered flip-flop without a reset; initial mode state depends on synthesis tool defaults
- Error count saturates at 15 (4-bit counter, one display digit)

---

## License

This project was developed as a university coursework assignment. No licence is currently applied.

