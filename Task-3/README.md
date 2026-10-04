# Task-3: Design a Multi-Register GPIO IP with Software Control

## Objective

Design and validate a memory-mapped GPIO IP with multiple software-accessible registers for GPIO data, direction control, and pin readback.

The GPIO IP supports 32 GPIO pins.

## GPIO Register Map

| Offset | Register | Access | Description |
|---|---|---|---|
| `0x00` | `GPIO_DATA` | R/W | Stores GPIO output data |
| `0x04` | `GPIO_DIR` | R/W | Controls GPIO pin direction |
| `0x08` | `GPIO_READ` | R | Reads current GPIO pin state |

### GPIO_DATA — 0x00

Stores the value to be driven on GPIO output pins.

- Write → Updates GPIO data.
- Read → Returns the stored GPIO data.

### GPIO_DIR — 0x04

Controls the direction of each GPIO pin independently.

- `1` → Output
- `0` → Input

For example:

```text
GPIO_DIR = 0xFFFFFFFF
