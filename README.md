# APT Simulator

APT Simulator is a Windows Batch script that uses a set of tools and output files to make a system look as if it was compromised

# Use Cases

1. POCs: Endpoint detection agents / compromise assessment tools
2. Test your security monitoring's detection capabilities 
3. Test your SOCs response on a threat that isn't EICAR or a port scan
4. Prepare an environment for digital forensics classes

# Motives

Customers tested our scanners in a POC and sent us a complaint that our scanners didn't report on programs that they had installed on their test systems. They had installed an Nmap, dropped a PsExec.exe in the Downloads folder and placed on EICAR test virus on the user's Desktop. That was the moment when I decided to build a tool that simulates a real threat in a more appropriate way.  

# Why Batch?

- Because it's simple: Everyone can read, modify or extend it
- It runs on every Windows system without any prerequisites
- It is closest to a real attacker working on the command line

# Focus

The focus of this tool is to simulate adversary activity, not malware. See the [Advanced Solutions](#advanced-solutions) section for advanced tools to simulate adversary and malware activity.

![APT vs Malware](/screenshots/MalwareAPT.png)

# Getting Started

1. Download the latest release from the "release" section
2. Extract the package on a demo system (Password: apt)
3. Start a cmd.exe as Administrator
4. Navigate to the extracted program folder and run APTSimulator.bat

# Avoiding Early Detection

The batch script extracts the tools and shells from an encrypted 7z archive at runtime. Do not download the master repo using the "download as ZIP" button. Instead use the official release from the [release](https://github.com/Neo23x0/APTSimulator/releases) section.

# Extending the Test Set

Since version 0.4 it is pretty easy to extend the test sets by adding a single `.bat` file to one of the test-set category folders. 

E.g. If you want to write a simple use case for "privilege escalation", that uses a tool named "privesc.exe", clone the repo and do the following:

1. Add you tool to the `toolset` folder
2. Write a new batch script `privesc-1.bat` and add it to the `./test-sets/privilege-escalation` folder
3. Run `build_pack.bat`
4. Add your test to the table and action list in the README.md
5. Create a pull request

## Tool and File Extraction

If you script includes a tool, web shell, auxiliary or output file, place them in the folders `./toolset` or `./workfiles`. Running the build script `build_pack.bat` will include them in the encrypted archives `enc-toolset.7z` and `enc-files.7z`.

### Extract a Tool 

```
%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%APTDIR% toolset\tool.exe > NUL
```

### Extract a File

```
%ZIP% e -p%PASS% %FILEARCH% -aoa -o%APTDIR% workfile\tool-output.txt > NUL
```

# Detection 

The following table shows the different test cases and the expected detection results.

- AV = Antivirus
- NIDS = Network Intrusion Detection System
- EDR = Endpoint Detection and Response
- SM = Security Monitoring
- CA = Compromise Assessment

| Test Case                             | AV  | NIDS | EDR | SM  | CA  |
|---------------------------------------|-----|------|-----|-----|-----|
| Dumps (Pwdump, Dir Listing)           |     |      |     |     | X   |
| Recon Activity (Typical Commands)     |     |      | X   | X   | X   |
| DNS (Cache Injection)                 | (X) | X    |     | X   | X   |
| Eventlog (WCE entries)                |     |      | X   | X   | X   |
| Hosts File (AV/Win Update blocks)     | (X) |      | X   |     | X   |
| Backdoor - StickyKey                  |     |      | X   |     | X   |
| Obfuscation (RAR with JPG ext)        |     |      |     |     | (X) |
| Web Shells (a good selection)         | X   |      | (X) |     | X   |
| Ncat Alternative (Drop & Exec)        | X   |      | X   | X   | X   |
| Remote Execution Tool (Drop)          | (X) |      |     |     | X   |
| Mimikatz (Drop & Exec)                | X   |      | X   | X   | X   |
| PsExec (Drop & Exec)                  |     |      | X   | X   | X   |
| At Job Creation                       |     |      | X   | X   | X   |
| RUN Key Entry Creation                |     |      | X   | X   | X   |
| System File in Susp Loc (Drop & Exec) |     |      | X   | X   | X   |
| Guest User (Activation & Admin)       |     |      | X   | X   | X   |
| LSASS Dump (with Procdump)            |     |      | X   | X   | X   |
| C2 Requests                           | (X) | X    | X   | X   |     |
| Malicious User Agent (Malware, RATs)  |     | X    | X   | X   |     |
| Scheduled Task Creation               |     |      | X   | X   | X   |
| Nbtscan Discovery (Scan & Output)     |     | X    | X   | (X) | X   |

# Actions

## 1. Dumps 

- drops pwdump output to the working dir
- drops directory listing to the working dir

## 2. Recon 

- Executes command used by attackers to get information about a target system

## 3. DNS 

- Looks up several well-known C2 addresses to cause DNS requests and get the addresses into the local DNS cache

## 4. Eventlog

- Creates Windwows Eventlog entries that look as if WCE had been executed

## 5. Hosts

- Adds entries to the local hosts file (update blocker, entries caused by malware)

## 6. Sticky Key Backdoor

- Tries to replace sethc.exe with cmd.exe (a backup file is created)
- Tries to register cmd.exe as debugger for sethc.exe

## 7. Obfuscation

- Drops a cloaked RAR file with JPG extension

## 8. Web Shells

- Creates a standard web root directory
- Drops standard web shells to that diretory
- Drops GIF obfuscated web shell to that diretory

## 9. Ncat Alternative

- Drops a PowerShell Ncat alternative to the working directory

## 10. Remote Execution Tool

- Drops a remote execution tool to the working directory

## 11. Mimikatz 

- Dumps mimikatz output to working directory (fallback if other executions fail)
- Run special version of mimikatz and dump output to working directory
- Run Invoke-Mimikatz in memory (github download, reflection)

## 12. PsExec 

- Dump a renamed version of PsExec to the working directory
- Run PsExec to start a command line in LOCAL_SYSTEM context

## 13. At Job

- Creates an at job that runs mimikatz and dumps credentials to file

## 14. RUN Key

- Create a suspicious new RUN key entry that dumps "net user" output to a file

## 15. System File Suspicious Location

- Drops suspicious executable with system file name (svchost.exe) in %PUBLIC% folder
- Runs that suspicious program in %PUBLIC% folder

## 16. Guest User

- Activates Guest user
- Adds Guest user to the local administrators

## 17. LSASS DUMP

- Dumps LSASS process memory to a suspicious folder

## 18. C2 Requests

- Uses Curl to access well-known C2 servers

## 19. Malicious User Agents

- Uses malicious user agents to access web sites

## 20. Scheduled Task Creation

- Creates a scheduled task that runs mimikatz and dumps the output to a file

## 21. Nbtscan Discovery

- Scanning 3 private IP address class-C subnets and dumping the output to the working directory

# Warning

This repo contains tools and executables that can harm your system's integrity and stability. Do only use them on non-productive test or demo systems.

# Screenshots

![Screen](/screenshots/apt-0.png)
![Screen](/screenshots/apt-1.png)
![Screen](/screenshots/apt-2.png)
![Screen](/screenshots/apt-c2.png)

# Advanced Solutions

The CALDERA automated adversary emulation system
[https://github.com/mitre/caldera](https://github.com/mitre/caldera)

Infection Monkey - An automated pentest tool
[https://github.com/guardicore/monkey](https://github.com/guardicore/monkey)

Flightsim - A utility to generate malicious network traffic and evaluate controls 
[https://github.com/alphasoc/flightsim](https://github.com/alphasoc/flightsim)

# Integrated Projects / Software

- [Mimikatz](https://github.com/gentilkiwi/mimikatz)
- [PowerSploit](https://github.com/PowerShellMafia/PowerSploit)
- [PowerCat](https://github.com/besimorhino/powercat)
- [PsExec](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec)
- [ProcDump](https://docs.microsoft.com/en-us/sysinternals/downloads/procdump)
- [7Zip](http://www.7-zip.org/download.html)
- [curl](https://curl.haxx.se/)

# Contact

Follow and contact me on Twitter @cyb3rops
