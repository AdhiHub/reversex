# ReverseX v1.0

Reverse shell payload generator supporting Bash, Python, PHP, and Netcat payloads with a colorful interactive menu.

## One-Line Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/AdhiHub/reversex/main/install.sh)
```

## Features

| Feature            | Description                                  |
|--------------------|----------------------------------------------|
| Multi-Payload      | Bash, Python, PHP, Netcat reverse shells     |
| All-in-One Mode    | Generate all payloads at once                |
| Listener Command   | Shows the matching `nc -lvnp` listener       |
| Save to File       | Exports payloads to a text file              |
| Interactive Menu   | User-friendly TUI with color-coded output    |
| CLI Flags          | Run directly via arguments for automation    |

## Usage

```bash
# Interactive mode
./reversex.sh

# Generate specific payload
./reversex.sh -bash 10.0.0.5 4444
./reversex.sh -python 10.0.0.5 4444
./reversex.sh -php 10.0.0.5 4444
./reversex.sh -nc 10.0.0.5 4444

# Generate all payloads
./reversex.sh -all 10.0.0.5 4444

# Show help
./reversex.sh -h
```

## Requirements

- curl (for install)
- Linux or Termux (Android)

## Disclaimer

> Use at your own risk. Developer(s) assume NO liability. For authorized security testing ONLY.
