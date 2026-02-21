# Arduino Examples

This directory contains a curated collection of Arduino examples organized by category. These examples are available through the `aci` (Arduino CLI Interactive) tool.

---

## Categories

### 01. Basics
Simple starter examples for beginners learning Arduino programming.
- **Level:** Beginner
- **Examples:** Blink, AnalogReadSerial, DigitalReadSerial, etc.

### 02. Digital
Digital I/O operations including buttons, LEDs, and switches.
- **Level:** Beginner to Intermediate
- **Topics:** Digital input/output, debouncing, state machines

### 03. Analog
Analog I/O operations and PWM control.
- **Level:** Beginner to Intermediate
- **Topics:** Analog reading, PWM, fading, calibration

### 04. Communication
Serial, I2C, SPI, and other communication protocols.
- **Level:** Intermediate to Advanced
- **Topics:** UART, I2C, SPI, software serial

### 05. Control
Flow control, timing, and advanced program structures.
- **Level:** Intermediate
- **Topics:** If-else, loops, timing, millis(), state machines

### 06. Sensors
Interfacing with various sensors.
- **Level:** Intermediate
- **Topics:** Temperature, humidity, distance, light sensors

### 07. Display
LCD, OLED, LED matrix, and other display interfaces.
- **Level:** Intermediate to Advanced
- **Topics:** Character LCD, OLED, LED matrices, 7-segment displays

### 08. Strings
String manipulation and text processing.
- **Level:** Beginner to Intermediate
- **Topics:** String operations, parsing, formatting

### 09. USB
USB communication and HID functionality.
- **Level:** Advanced
- **Topics:** USB serial, HID keyboard/mouse (for compatible boards)

### 10. StarterKit_BasicKit
Projects from Arduino Starter Kits.
- **Level:** Beginner
- **Topics:** Complete starter kit projects

### 11. ArduinoISP
In-System Programming examples.
- **Level:** Advanced
- **Topics:** Programming other microcontrollers using Arduino as ISP

---

## Contributing Examples

We welcome new Arduino examples! See below for guidelines.

### Example Structure

Each example should be in its own directory within the appropriate category:

```
examples/
└── 02.Digital/
    └── Button_LED/
        ├── Button_LED.ino
        └── README.md (optional, for complex examples)
```

### Code Template

Use this template for your `.ino` file:

```cpp
/*
 * Example_Name
 * 
 * Description: Brief description of what this example demonstrates
 * 
 * Hardware Required:
 * - Arduino board (specify compatible boards)
 * - List of components needed
 * - Tools or wires
 * 
 * Circuit:
 * - Component pin to Arduino pin X
 * - Component pin to Arduino pin Y
 * - Component to GND/5V via resistor (if needed)
 * 
 * Created: YYYY-MM-DD
 * By: Your Name
 * 
 * License: Public Domain (or specify other if needed)
 */

// === CONSTANTS ===
const int LED_PIN = 13;
const int BUTTON_PIN = 2;

// === GLOBAL VARIABLES ===
int buttonState = 0;

// === SETUP ===
void setup() {
  // Initialize pins
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUTTON_PIN, INPUT);
  
  // Initialize serial communication (if needed)
  Serial.begin(9600);
  Serial.println("Example started");
}

// === MAIN LOOP ===
void loop() {
  // Read inputs
  buttonState = digitalRead(BUTTON_PIN);
  
  // Control outputs
  if (buttonState == HIGH) {
    digitalWrite(LED_PIN, HIGH);
  } else {
    digitalWrite(LED_PIN, LOW);
  }
}
```

### Best Practices

#### Code Quality
- ✅ Use descriptive variable names: `ledPin` not `lp`
- ✅ Use `const` for pin definitions
- ✅ Add comments explaining non-obvious code
- ✅ Use consistent indentation (2 spaces)
- ✅ Keep functions focused and small

#### Documentation
- ✅ List all required hardware
- ✅ Provide clear circuit connections
- ✅ Explain what the example demonstrates
- ✅ Include expected behavior
- ✅ Add troubleshooting tips for complex examples

#### Testing
- ✅ Test compilation with `arduino-cli compile`
- ✅ Test on actual hardware if possible
- ✅ Verify with multiple board types when relevant
- ✅ Check serial output works as expected

### Example Categories Guide

**When to use each category:**

| Category | Use When... |
|----------|-------------|
| Basics | Teaching fundamental concepts (blink, serial, pins) |
| Digital | Working with digital I/O (buttons, switches, LEDs) |
| Analog | Reading sensors or using PWM (potentiometers, fading) |
| Communication | Using serial protocols (UART, I2C, SPI) |
| Control | Demonstrating program flow (if/else, for loops, state) |
| Sensors | Reading specific sensor types (DHT, ultrasonic, etc.) |
| Display | Showing text or graphics (LCD, OLED, LED matrix) |
| Strings | Processing text (parsing, formatting, conversion) |
| USB | Computer interfacing (keyboard, mouse emulation) |
| StarterKit | Complete projects with step-by-step guides |
| ArduinoISP | Programming other chips via ISP |

### Complex Examples

For complex examples, add a `README.md` in the example directory:

```markdown
# Example Name

## Description
Detailed description of what this example does and why it's useful.

## Hardware Required
- Arduino Uno (or compatible)
- HC-SR04 Ultrasonic Sensor
- Breadboard and jumper wires

## Circuit Diagram

```
HC-SR04 Ultrasonic Sensor:
  VCC → Arduino 5V
  GND → Arduino GND
  TRIG → Arduino Pin 9
  ECHO → Arduino Pin 10
```

## How It Works
Explanation of the code logic and algorithm.

## Expected Output
What you should see when running the example.

## Troubleshooting
Common issues and solutions.

## Learn More
- [Ultrasonic Sensor Datasheet](link)
- [Related Tutorial](link)
```

### Submission Process

1. **Choose Category:** Pick the most appropriate category
2. **Create Directory:** Use a descriptive name (e.g., `Button_Debounce`)
3. **Write Code:** Follow the template and best practices
4. **Test:** Compile and test on hardware
5. **Add README:** For complex examples, add documentation
6. **Submit PR:** Create a pull request with:
   - Clear title: "Add [Example Name] to [Category]"
   - Description of what the example teaches
   - Hardware tested on
   - Link to circuit diagram (if external)

### Example PR Description Template

```markdown
## Example Submission

**Category:** 02.Digital
**Example Name:** Button_Debounce
**Level:** Intermediate

### Description
Demonstrates proper button debouncing technique using millis() instead of delay().

### What It Teaches
- Debouncing mechanical buttons
- Using millis() for timing
- State change detection

### Hardware Tested
- Arduino Uno
- Generic pushbutton
- 10kΩ pull-down resistor

### Circuit
Simple button circuit with pull-down resistor on pin 2, LED on pin 13.

### Additional Notes
This is a more robust alternative to the basic button example, teaching best practices for production code.
```

---

## Using Examples in ACI

When you run `aci`, you can:

1. **Browse Examples:** Select from all categories
2. **View Code:** See the example before using it
3. **Compile:** Test compilation for your board
4. **Upload:** Flash to your Arduino board

---

## Example Statistics

Run this to see example counts:
```bash
find examples/ -name "*.ino" | wc -l
```

---

## License

Most examples are in the Public Domain or under MIT License. Check individual example headers for specific licensing.

---

## Questions?

- 📖 [Main Contributing Guide](../CONTRIBUTING.md)
- 💬 [GitHub Discussions](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/discussions)
- 🐛 [Report Issues](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/issues)

---

**Thank you for contributing examples!** 🎓

Your examples help others learn Arduino programming and make the `aci` tool more valuable to everyone.
