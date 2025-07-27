# Penetration Testing Automation Scripts

## Overview

This repository contains two Bash scripts designed to assist in the process of **network enumeration**, **web application reconnaissance**, and **privilege escalation enumeration**. These scripts are intended for use in **penetration testing environments**, such as Capture The Flag (CTF) challenges, ethical hacking labs, or controlled security audits.

---

## 🔧 Scripts

### 1. `scan_starget.sh`
### 2. `privilage.sh`

A semi-automated script for initial reconnaissance and enumeration on a target IP. It guides the user through:
- Basic service detection via Nmap
- Web directory fuzzing with Gobuster and FFUF
- SSH brute-forcing with Hydra depending on available credentials

**Features:**
- Interactive prompts to adapt the scan based on services running
- Support for both default and custom wordlists
- Conditional execution paths depending on detected services

**Usage:**
```bash
chmod +x scan_starget.sh
chmod +x privilage.sh
sudo ./web_attack_enum.sh
sudo ./privilage.sh
