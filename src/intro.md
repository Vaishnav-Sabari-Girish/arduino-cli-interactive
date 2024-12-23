__NOTE__ : This page is only for those who are just starting out with Arduino programming. 
If you already have an idea on Arduino , you can skip this page and go to [Chapter 1](./chapter_1.md)
<br><br>

# Introduction

## What is Arduino ? 

Arduino is an open-source microcontroller platform designed for building and programming electronic 
projects with ease and flexibility.

### What is Arduino used for ? 

- **Robotics Projects**: Build and control robots, including autonomous vehicles and robotic arms.

- **Home Automation**: Automate lights, temperature, and security systems for smart home setups.

- **IoT Applications**: Create Internet-connected devices for data monitoring and control.

- **Prototyping Electronics**: Test and develop innovative electronic circuits and gadgets.

- **Educational Tools**: Learn programming, electronics, and engineering concepts interactively.

Arduino boards come in many flavors , som eof the most famous ones being : 
1. Arduino Uno 
2. Arduino Nano
3. Arduino Mega

All Arduino boards are programmed using the [Arduino IDE](https://www.arduino.cc/en/software).

### The Arduino IDE (Integrated Development Environment)

The Arduino IDE is the software that is used to program the Arduino Boards. It has a pretty easy-to-use
interface that can make it easier for beginners to learn how to use Arduino using the Arduino IDE. 

Check out the official Arduino [website](https://arduino.cc) for more information on the IDE.

### The Arduino CLI (Command-Line Interface)

Now , installing the Arduino IDE in Windows is as easy as going to their website clicking on 
Download and done . 

But in the case of macOS (older distributions) and linux (especially) , the IDE requires a huge
amount of permissions to be able to access the Serial Ports (The USB port in which the
Arduino Board is connected).

To avoid this , we do not have to install the Arduino IDE , instead , we can use the command line version
of the IDE known as `arduino-cli`. 

This tool uses the Command Line Interface (CLI) instead of the traditional Graphical User Interfaces (GUI) of the 
Arduino IDE.

This makes it easy for devs who want to use Arduino through linux. 

But , there is one teensy little problem. 

Here is an example of a command to upload the Arduino Sketch title "MySketch" to an Arduino Uno board. 

```bash
arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno MySketch/MySketch.ino
```

Here `-p` represents the serial port and the `--fqbn` flag represents the "Fully Qualified Board Name" , 
which is used to denote the boards. 

Now , remembering the FQBN of 2 or 3 boards is pretty easy , but in case you are working with multiple 
boards of different types , say you are working with Arduino Uno , Arduino Nano , or ESP32. 
Remembering the FQBN of each and every board become increasingly difficult. 

To combat this problem , the project `arduino-cli-interactive` or `aci` was born. 
