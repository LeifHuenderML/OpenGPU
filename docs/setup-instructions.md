# OpenGPU Setup Instructions

## Prerequisites

Ensure you have the following before you begin:
- A fresh installation of **Ubuntu Server**
- A stable **Network Connection**

## Installation Guide

### Step 1: Update and Upgrade Packages

Update your system's package list and upgrade the installed packages:

```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: Install Git

Git is required to clone the repository. Install it using the following command:

```bash
sudo apt install git
```

### Step 3: Clone the OpenGPU Repository

Clone the OpenGPU repository from GitHub to your local machine:

```bash
git clone https://github.com/LeifHuenderML/OpenGPU.git
```

### Step 4: Make the Build Script Executable

Navigate to the OpenGPU directory and make the build script executable:

```bash
cd OpenGPU
sudo chmod +x build.sh
```

### Step 5: Run the Build Script

Execute the build script to start the installation process:

```bash
./build.sh
```

### Step 6: Follow On-Screen Instructions

During the build process, follow any on-screen instructions to complete the installation.
