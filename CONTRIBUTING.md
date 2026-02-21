# Contributing to Arduino CLI Interactive (aci)

Thank you for your interest in contributing to `aci`! 🎉

This document provides guidelines for contributing to the project. Whether you're fixing a bug, adding a feature, improving documentation, or adding examples, we appreciate your help!

---

## Table of Contents

- [Quick Links](#quick-links)
- [First-Time Contributors](#first-time-contributors-)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Code Style Guidelines](#code-style-guidelines)
- [Testing Your Changes](#testing-your-changes)
- [Adding Examples](#adding-examples)
- [OSCG Participants](#oscg-participants)
- [Communication](#communication)
- [Code of Conduct](#code-of-conduct)

---

## Quick Links

- 📖 [README](./README.md) - Project overview and installation
- 🎓 [OSCG Contributor Guidelines](./OSCG_CONTRIBUTOR_Guidelines.md) - For OSCG'26 participants
- 🤝 [Code of Conduct](./CODE_OF_CONDUCT.md) - Community standards
- 🐛 [Report a Bug](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/issues/new?template=bug_report.yml)
- 💡 [Request a Feature](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/issues/new?template=feature_request.yml)
- 💬 [GitHub Discussions](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/discussions)

---

## First-Time Contributors 🌱

Welcome! We're excited to have you here. Here's how to make your first contribution:

### Getting Started

1. **Find an issue to work on:**
   - Look for issues labeled [`good-first-issue`](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/labels/good-first-issue)
   - Check [`help-wanted`](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/labels/help-wanted) for community-requested features
   - Browse open issues and ask to be assigned

2. **Claim the issue:**
   - Comment on the issue: "I'd like to work on this"
   - Wait for maintainer approval before starting work

3. **Ask questions:**
   - Use [GitHub Discussions](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/discussions) for questions
   - Comment on the issue if you need clarification
   - Don't be afraid to ask - we're here to help!

### Good First Contributions

Here are some easy ways to contribute:

- ✍️ Fix typos or improve documentation clarity
- 📝 Add comments to improve code readability
- 🎨 Add new Arduino examples to the `examples/` directory
- 🐛 Fix small bugs with clear reproduction steps
- 📚 Improve error messages to be more user-friendly
- 🎯 Add validation or error handling to existing features

---

## Development Setup

### Prerequisites

Make sure you have these installed:

- **Bash** 4.0 or later (check with: `bash --version`)
- **Git** (check with: `git --version`)
- **arduino-cli** - [Installation guide](https://arduino.github.io/arduino-cli/1.1/installation/)
- **gum** - TUI framework ([Installation guide](https://github.com/charmbracelet/gum#installation))
- **timer** - Interactive progress bars ([Installation guide](https://github.com/caarlos0/timer#installation))

**Quick install (macOS/Linux with Homebrew):**
```bash
brew install arduino-cli gum caarlos0/tap/timer
```

### Local Development Setup

1. **Fork the repository** on GitHub

2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/arduino-cli-interactive.git
   cd arduino-cli-interactive
   ```

3. **Add upstream remote:**
   ```bash
   git remote add upstream https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git
   ```

4. **Test the script locally:**
   ```bash
   cd bash_shell_script
   chmod +x main.sh
   ./main.sh
   ```

5. **Verify dependencies:**
   - The script will check for missing dependencies on startup
   - If dependencies are missing, install them using the links above

---

## How to Contribute

### Workflow

1. **Sync with upstream:**
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create a feature branch:**
   ```bash
   git switch -c type/short-description
   ```
   
   Branch naming conventions:
   - `feature/add-serial-logging` - New features
   - `fix/null-pointer-crash` - Bug fixes
   - `docs/update-readme` - Documentation
   - `refactor/cleanup-parser` - Code refactoring
   - `test/add-unit-tests` - Testing improvements

3. **Make your changes:**
   - Keep changes focused on a single issue
   - Follow the [Code Style Guidelines](#code-style-guidelines)
   - Add comments for complex logic
   - Test your changes thoroughly

4. **Commit your changes:**
   ```bash
   git add .
   git commit
   ```
   
   **Commit message format:**
   ```
   type(scope): short summary
   
   Optional longer description explaining what and why.
   ```
   
   Examples:
   - `fix(parser): handle empty input safely`
   - `feat(serial): add baud rate selection`
   - `docs(readme): update installation steps for WSL`

5. **Push to your fork:**
   ```bash
   git push origin your-branch-name
   ```

6. **Open a Pull Request:**
   - Go to the [original repository](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive)
   - Click "New Pull Request"
   - Select your fork and branch
   - Fill out the PR template completely
   - Link related issues using `Closes #123`

7. **Respond to feedback:**
   - Address review comments professionally
   - Push updates to the same branch
   - Don't open a new PR unless requested

---

## Code Style Guidelines

To maintain consistency across the codebase, please follow these conventions:

### Bash Script Style

- **Indentation:** Use 2 spaces (no tabs)
- **Line length:** Keep lines under 100 characters when possible
- **Comments:** Add comments for complex logic and functions

### Naming Conventions

```bash
# Variables: use lowercase with underscores
selected_board="arduino:avr:uno"
user_input=""

# Functions: use snake_case
select_board() {
  # Function body
}

# Internal/helper functions: prefix with underscore
_validate_input() {
  # Helper function
}

# Constants: use UPPERCASE
readonly DEFAULT_BAUD_RATE=9600
readonly MAX_RETRIES=3
```

### Function Structure

```bash
# Good: Clear, focused function with comments
select_arduino_board() {
  # Get list of available boards
  local boards=$(arduino-cli board listall)
  
  # Let user select board using gum
  local selected=$(echo "$boards" | gum filter)
  
  # Validate selection
  if [[ -z "$selected" ]]; then
    echo "No board selected"
    return 1
  fi
  
  echo "$selected"
}
```

### Best Practices

- ✅ Use `[[ ]]` for conditionals (better than `[ ]`)
- ✅ Quote variables: `"$var"` not `$var`
- ✅ Use local variables in functions
- ✅ Check command exit codes
- ✅ Provide meaningful error messages
- ✅ Use `readonly` for constants
- ✅ Fail fast with `set -e` when appropriate

### Code Organization

```bash
#!/usr/bin/env bash

# === CONSTANTS ===
readonly VERSION="1.2.0"
readonly CONFIG_DIR="$HOME/.aci"

# === HELPER FUNCTIONS ===
_validate_input() { ... }
_check_dependencies() { ... }

# === MAIN FUNCTIONS ===
select_board() { ... }
upload_sketch() { ... }

# === ENTRY POINT ===
main() { ... }
main "$@"
```

---

## Testing Your Changes

Before submitting a PR, please test your changes thoroughly.

### Manual Testing Checklist

- [ ] Script starts without errors: `./main.sh`
- [ ] All menu options work as expected
- [ ] Changes work on a clean system (if possible)
- [ ] No breaking changes to existing functionality
- [ ] Error messages are clear and helpful
- [ ] Dependencies are properly checked

### Feature-Specific Testing

**Board Management:**
- Test with at least 2 different board types (e.g., Arduino Uno, ESP32)
- Verify board selection, core installation

**Library Features:**
- Test library install/uninstall
- Verify example compilation

**Serial Monitor:**
- Test different baud rates
- Verify connection/disconnection

**Sketch Operations:**
- Test compile, upload, verify
- Test with both old and new bootloaders

### Platform Testing

If possible, test on multiple platforms:
- macOS
- Linux (different distros if possible)
- WSL (Windows Subsystem for Linux)

**Note:** Mention which platform(s) you tested on in your PR description.

---

## Adding Examples

We welcome new Arduino examples! Here's how to add them:

### Example Structure

```
examples/
├── 01.Basics/
├── 02.Digital/
│   └── Button_LED/
│       ├── Button_LED.ino
│       └── README.md (optional, for complex examples)
├── 03.Analog/
└── ...
```

### Guidelines

1. **Choose the right category:**
   - `01.Basics` - Simple starter examples (Blink, Serial)
   - `02.Digital` - Digital I/O (buttons, LEDs, switches)
   - `03.Analog` - Analog I/O (sensors, PWM)
   - `04.Communication` - Serial, I2C, SPI
   - `05.Control` - Flow control, timing
   - `06.Sensors` - Sensor interfacing
   - `07.Display` - LCD, OLED, LED matrices
   - `08.Strings` - String manipulation
   - `09.USB` - USB communication
   - `10.StarterKit_BasicKit` - Arduino starter kit projects
   - `11.ArduinoISP` - ISP programming

2. **Example template:**
   ```cpp
   /*
    * Example_Name
    * 
    * Description: Brief description of what this example demonstrates
    * 
    * Hardware Required:
    * - Arduino board (Uno, Nano, etc.)
    * - LED
    * - 220Ω resistor
    * 
    * Circuit:
    * - LED anode (long leg) to pin 13
    * - LED cathode (short leg) to GND via 220Ω resistor
    * 
    * Created: YYYY-MM-DD
    * By: Your Name
    */

   // Constants and pin definitions
   const int LED_PIN = 13;

   void setup() {
     // Initialize hardware
     pinMode(LED_PIN, OUTPUT);
     
     // Initialize serial if needed
     Serial.begin(9600);
     Serial.println("Example started");
   }

   void loop() {
     // Main logic with comments
     digitalWrite(LED_PIN, HIGH);
     delay(1000);
     digitalWrite(LED_PIN, LOW);
     delay(1000);
   }
   ```

3. **Best practices:**
   - Use descriptive names for variables and functions
   - Add comments explaining non-obvious code
   - Use constants for pin numbers and configuration values
   - Include setup instructions in comments
   - Test compilation before submitting

4. **Submit your example:**
   - Add to appropriate category
   - Test compilation with arduino-cli
   - Create PR with example details

---

## OSCG Participants

If you're contributing as part of the **Open Source Contribution Gym (OSCG'26)** program:

### Special Requirements

1. **PR Title Prefix:** All PRs **MUST** include `OSCG26` prefix
   - Example: `OSCG26 feat(examples): add ultrasonic sensor example`

2. **Pre-work Discussion:** For non-trivial work:
   - Use [GitHub Discussions](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/discussions) first
   - Get mentor/admin approval before opening issues or PRs
   - Design discussions required for architectural changes

3. **Full Guidelines:** Read [OSCG_CONTRIBUTOR_Guidelines.md](./OSCG_CONTRIBUTOR_Guidelines.md)

### Evaluation Criteria

OSCG contributions are evaluated on:
- **Quality** - Well-written, tested code
- **Correctness** - Works as intended, no bugs
- **Clarity** - Clear code, good documentation
- **Usefulness** - Solves real problems
- **Collaboration** - Professional communication

**Note:** Volume of PRs is NOT a metric. Quality over quantity!

---

## Communication

### Where to Ask Questions

- 💬 **GitHub Discussions** - General questions, ideas, brainstorming
- 🐛 **GitHub Issues** - Bug reports, feature requests
- 💬 **PR Comments** - Code review, implementation feedback

### What NOT to Do

- ❌ Don't repeatedly tag maintainers
- ❌ Don't comment "please merge" on PRs
- ❌ Don't DM maintainers for reviews
- ❌ Don't spam issues or PRs

### Response Times

- Maintainers are volunteers with limited time
- Expect 24-48 hours for initial response
- Complex reviews may take longer
- Inactive PRs may be closed after 30 days

---

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](./CODE_OF_CONDUCT.md).

By participating, you agree to:
- Communicate respectfully and professionally
- Be inclusive and welcoming
- Accept constructive feedback gracefully
- Respect maintainer decisions

**Zero tolerance for:**
- Harassment or discrimination
- Toxic or aggressive behavior
- Spam or manipulation
- Plagiarism or misrepresentation

Violations may result in removal from the project.

---

## Recognition

Contributors are recognized in:
- GitHub contributor graph
- Release notes (for significant contributions)
- Project documentation (for major features)

---

## Questions?

- 💬 [Start a Discussion](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/discussions)
- 📧 Email: write2vaichu@gmail.com (for sensitive matters)

---

**Thank you for contributing to arduino-cli-interactive!** 🚀

Your contributions help make Arduino development more accessible to everyone.
