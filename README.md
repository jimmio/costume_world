# bubblewrap

A simple tool to get heavily signatured offensive security tools past antivirus.

With a given executable:

1. Generates shellcode from the executable with `donut`
1. Inserts the shellcode into a basic c++ dropper and dynamically updates the length of the byte array
1. Compiles the c++ dropper
1. Packs the resulting executable with `upx`

As of 2021-11, `bubblewrap` provides safe shipping for off-the-shelf `mimikatz` past an up-to-date Windows Defender.

## Requirements

- docker
- make

## Setup

```
make build
```

## Usage

```
make bubblewrap <executable_name>
```

## TODO

- Put the output in a sub-directory
- Prevent clobbering and conflicts with existing output
  - e.g. `upx` is unhappy if `dropper_packed.exe` already exists
- Provide more configuration options
  - Support for 32-bit binaries
