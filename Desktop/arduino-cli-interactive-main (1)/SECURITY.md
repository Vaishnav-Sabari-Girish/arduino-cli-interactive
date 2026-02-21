# Security Policy

## Reporting a Vulnerability

The arduino-cli-interactive (aci) team takes security seriously. We appreciate your efforts to responsibly disclose your findings.

### How to Report

If you discover a security vulnerability in arduino-cli-interactive, please report it privately:

1. **DO NOT** open a public GitHub issue for security vulnerabilities
2. **Email:** write2vaichu@gmail.com with subject line: `[SECURITY] Brief description`
3. **Include:**
   - Description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact assessment
   - Suggested fix (if you have one)
   - Your contact information (optional, for follow-up)

### What to Expect

- **Acknowledgment:** We will acknowledge receipt of your vulnerability report within 48-72 hours
- **Updates:** We will send you regular updates on our progress
- **Timeline:** We aim to provide a fix within 7-14 days for critical issues
- **Credit:** With your permission, we will credit you in the security advisory

---

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          | Status             |
| ------- | ------------------ | ------------------ |
| 1.2.x   | ✅ Yes             | Active development |
| 1.1.x   | ⚠️ Limited support | Maintenance mode   |
| 1.0.x   | ❌ No              | End of life        |
| < 1.0   | ❌ No              | End of life        |

**Recommendation:** Always use the latest version for the best security and features.

---

## Security Best Practices

### For Users

When using arduino-cli-interactive:

1. **Keep Updated:** Regularly update to the latest version
   ```bash
   brew upgrade aci  # if installed via Homebrew
   ```

2. **Verify Sources:** Only install from official sources:
   - Official Homebrew tap: `vaishnav-sabari-girish/arduino-cli-interactive`
   - Official GitHub: https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive
   - Official Codeberg: https://codeberg.org/Vaishnav-Sabari-Girish/arduino-cli-interactive

3. **Review Scripts:** If installing from source, review the code before running

4. **Permissions:** The tool requires permissions to:
   - Access serial ports (for Arduino communication)
   - Read/write files in your home directory (for configuration)
   - Execute arduino-cli commands

5. **GitHub Token:** If using update notifications with `ACI_GITHUB_TOKEN`:
   - Use a token with minimal permissions (only `repo` read access)
   - Never commit tokens to version control
   - Rotate tokens regularly

### For Contributors

When contributing code:

1. **Input Validation:** Always validate user inputs
   ```bash
   # Good: Validate before use
   if [[ ! "$port" =~ ^[a-zA-Z0-9/_-]+$ ]]; then
     echo "Invalid port format"
     return 1
   fi
   ```

2. **Command Injection:** Avoid executing arbitrary user input
   ```bash
   # Bad: Direct command execution
   eval "$user_input"
   
   # Good: Validated and sanitized
   if [[ "$user_input" == "upload" ]]; then
     arduino-cli upload ...
   fi
   ```

3. **File Path Safety:** Sanitize file paths
   ```bash
   # Good: Prevent directory traversal
   sketch_path="${sketch_path//..\/}"
   ```

4. **Sensitive Data:** Never log or store sensitive information
   - API tokens
   - User credentials
   - Personal information

5. **Dependencies:** Keep dependencies updated
   - arduino-cli
   - gum
   - timer

6. **Code Review:** Security-sensitive changes require thorough review

---

## Known Security Considerations

### Serial Port Access

- The tool requires access to serial ports to communicate with Arduino boards
- This is normal behavior for Arduino development tools
- The tool does not access other USB devices or system resources

### File System Access

- Configuration stored in user's home directory (`~/.aci` or similar)
- Sketches compiled in temporary directories
- No system-wide files are modified
- No data is transmitted externally

### External Commands

The tool executes these external commands:
- `arduino-cli` - Arduino command-line interface
- `gum` - Terminal UI framework
- `timer` - Progress bar tool
- Standard Unix tools: `sed`, `awk`, `grep`, etc.

All external commands are from trusted sources and installed by the user.

### Network Access

- arduino-cli may download:
  - Board cores from Arduino repositories
  - Libraries from Arduino Library Manager
  - Updates from official Arduino sources
- No user data is transmitted to external servers
- Update notifications (if enabled) check GitHub API for new releases

---

## Security Update Process

When a security vulnerability is confirmed:

1. **Assessment:** We assess the severity and impact
2. **Fix Development:** A fix is developed and tested privately
3. **Testing:** The fix is tested across supported platforms
4. **Release:** A new version is released with the security fix
5. **Notification:** Users are notified via:
   - GitHub Security Advisories
   - Release notes
   - README updates
6. **Disclosure:** Public disclosure after fix is available

---

## Vulnerability Severity Levels

We use the following severity levels:

### Critical
- Remote code execution
- Privilege escalation
- Data exfiltration

**Response:** Immediate fix within 24-48 hours

### High
- Local code execution via crafted input
- Unauthorized file access
- Denial of service

**Response:** Fix within 7 days

### Medium
- Information disclosure
- Input validation bypass

**Response:** Fix within 14 days

### Low
- Minor information leaks
- Non-security bugs with security implications

**Response:** Fix in next regular release

---

## Responsible Disclosure

We follow responsible disclosure practices:

1. **Private Reporting:** Security issues reported privately first
2. **Fix First:** Security fixes released before public disclosure
3. **Coordinated Disclosure:** Public disclosure coordinated with fix release
4. **Credit:** Researchers credited in security advisories (with permission)

We ask security researchers to:
- Report vulnerabilities privately
- Give us reasonable time to fix issues before public disclosure
- Not exploit vulnerabilities for malicious purposes

---

## Security Hall of Fame

We recognize security researchers who help improve our security:

*No security vulnerabilities have been reported yet.*

---

## Contact

- **Security Issues:** write2vaichu@gmail.com
- **General Questions:** [GitHub Discussions](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/discussions)
- **Bug Reports:** [GitHub Issues](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/issues)

---

## Additional Resources

- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [Bash Security Best Practices](https://tldp.org/LDP/abs/html/securityissues.html)
- [GitHub Security Advisories](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/security/advisories)

---

**Last Updated:** 2026-02-15

Thank you for helping keep arduino-cli-interactive secure! 🔒
