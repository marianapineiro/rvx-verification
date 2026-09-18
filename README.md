# RVX Processor Verification (`rvx-verification`)

This repository was created for the verification process of the **RVX RISC-V processor core** as part of the **CI EXPERT** program.

---

## 🚀 Quick Start & Remote Simulation

This project includes a helper script (`scripts/run_cadmicro.sh`) to synchronize files and launch **Synopsys VCS** simulations on the **CADMICRO** cluster at UFRGS (`cadmicro01` .. `cadmicro08`).

### Prerequisites & SSH Setup

To run simulations on CADMICRO PCs seamlessly, configure your local `~/.ssh/config` file:

```sshconfig
Host cadmicro??
    User YOUR_UFRGS_USERNAME
    XAuthLocation /usr/bin/xauth
    ForwardAgent yes
    ForwardX11 yes
    ForwardX11Trusted yes
    Compression yes

Host cadmicro01
    HostName cadmicro-el8-01.inf.ufrgs.br
Host cadmicro02
    HostName cadmicro-el8-02.inf.ufrgs.br
Host cadmicro03
    HostName cadmicro-el8-03.inf.ufrgs.br
Host cadmicro04
    HostName cadmicro-el8-04.inf.ufrgs.br
Host cadmicro05
    HostName cadmicro-el8-05.inf.ufrgs.br
Host cadmicro06
    HostName cadmicro-el8-06.inf.ufrgs.br
Host cadmicro07
    HostName cadmicro-el8-07.inf.ufrgs.br
Host cadmicro08
    HostName cadmicro-el8-08.inf.ufrgs.br
```

#### Setting up Passwordless SSH (One-time Setup)
Copy your local SSH public key to CADMICRO:
```bash
ssh-copy-id cadmicro06
```
*(Since home directories are shared via NFS across the CADMICRO cluster, doing this once authorizes your SSH key across all CADMICRO PCs `cadmicro01` to `cadmicro08`!)*

---

## 🛠️ Running Simulations

To synchronize your repository and execute Synopsys VCS on CADMICRO:

```bash
# Default (runs on cadmicro06)
./scripts/run_cadmicro.sh

# Target a specific CADMICRO PC (e.g., cadmicro01, cadmicro03)
./scripts/run_cadmicro.sh cadmicro03
```

---

## 📂 Project Structure

```text
rvx-verification/
├── dut/
│   └── rvx/               # RVX RISC-V IP Core (Git Submodule)
├── scripts/
│   └── run_cadmicro.sh    # CADMICRO cluster sync & simulation script
└── README.md
```
