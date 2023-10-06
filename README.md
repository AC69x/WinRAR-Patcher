
# NoirBird's WinRAR Patcher

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

A simple Python script to activate WinRAR.

**Note: I do NOT condone using cracked software. Please buy [a licence](https://www.rarlab.com/shop2rarlab-index.php?prod=winrar&x-source=winraronly).**
## Usage

**Python Script:**

```bat
  py NoirBird-WR-Patcher.py
```

**EXE File:**

```bat
Just open the file LoL
```


## Building

To convert Python file to Executable binary you may use 2 different options:

**Nuitka:**

```bat
  pip install nuitka
  nuitka --mingw64 --onefile --assume-yes-for-downloads --remove-output --output-filename=NBWRPatcher "NoirBird-WR-Patcher.py"
```

**PyInstaller:**

```bat
  pip install pyinstaller
  pyinstaller -F --uac-admin NoirBird-WR-Patcher.py
```
