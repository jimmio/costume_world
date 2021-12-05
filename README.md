# bubblewrap

A simple tool to get heavily signatured offensive security tools past antivirus solutions.

## What does it do?

1. Generates shellcode from an executable using `donut`
1. Inserts the shellcode into a basic c++ dropper and updates the length of the byte array accordingly
1. Compiles the c++ dropper with `gcc`
1. Packs the resulting executable with `upx` (using the `--ultra-brute` option)

## Requirements

- `bash` or similar (probably)
- `docker`
- `make`

## Setup

```
# build the docker container
make build
```

## Usage

```
cp /path/to/tool.exe /path/to/bubblewrap/input/
make bubblewrap
```

## Why?

I asked myself, what is the minimum amount of change necessary to run an official release of `mimikatz` on a fully up-to-date Windows 10 Enterprise system running Windows Defender in late 2021? As it turns out, not much change is necessary, and I wanted to make the process easy to apply to other tools.

## TODO

- Provide more configuration options
  - Support for 32-bit binaries
- Handle multiple executables
- Figure out .NET EXE issues
  - e.g. winpeas not running
