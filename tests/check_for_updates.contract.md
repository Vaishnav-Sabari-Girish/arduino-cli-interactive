# Contract: check_for_updates

This document defines the expected behavior of the `check_for_updates` function.

## Expected outcomes

| Scenario                          | Expected exit code |
|----------------------------------|--------------------|
| No internet connection           | 0                  |
| GitHub token not set             | 1                  |
| GitHub API error / invalid JSON  | 1                  |
| New version available            | 2                  |
| Already on latest version        | 0                  |

## Notes

- This function must not require Arduino hardware
- Designed to be testable in CI
- Exit codes are part of the public contract
