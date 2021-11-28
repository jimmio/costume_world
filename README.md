# bubblewrap

A simple tool to get heavily signatured offensive security tools past antivirus.

With a given executable:

1. Generates shellcode from the executable with `donut`
1. Inserts the shellcode into a basic c++ dropper and dynamically updates the length of the byte array
1. Compiles the c++ dropper
1. Packs the resulting executable with `upx`

As of 2021-11, `bubblewrap` provides safe shipping for off-the-shelf `mimikatz` past an up-to-date Windows Defender.

## Setup

1. Build the image:

   ```
   docker build -t bubblewrap .
   ```

1. Copy the input executable to the bubblewrap directory.

## Usage

```
docker run -v /path/to/bubblewrap:/root/bubblewrap bubblewrap <executable>
```

## TODO

- Put the output in a sub-directory
- Wrap docker commands with `make`
