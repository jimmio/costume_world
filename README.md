# costume_world

A container for toying with AV bypass using [`donut`](https://github.com/thewover/donut) and [`upx`](https://github.com/upx/upx).

## What does it do?

It accepts one x86\_64 PE and returns two:

1. The first contains the provided PE in a compressed and encrypted form.
1. The second is the first, only run through a packer.

## What does it, like, really do?

1. Generates shellcode from an executable using `donut`
1. Inserts the shellcode into a C++ dropper template and updates the length of the byte array accordingly
1. Compiles the C++ dropper with `gcc`
1. Packs the resulting executable with `upx`

## Why bother?

I was trying to find some minimal modifications to get an official `mimikatz` release past Defender. Then I got tired of manually running the commands and forgetting to update the payload length for `VirtualAlloc`.

## Does it bypass AV?

It depends. Observed during testing in late 2021:

- Regular Defender did not detect or block `mimikatz` as a `donut` module, but did detect and block even a benign `upx`-packed PE ("Trojan:Win32/Wacatac.B!ml").
- Defender for Endpoint detected and blocked the use of `donut` for being `donut` ("VirTool:Win32/Wovdnut.gen!B"), but it didn't care about `upx` so much as what was present once the PE was unpacked.

Think more "Halloween party" and less "deep cover CIA disguise".

## Requirements

- `bash` or similar (probably)
- `docker`
- `make`

## Setup

Build the container:

```
make build
```

## Usage

Place a PE in `/input` and dress it up:

```
cp /path/to/tool.exe /path/to/costume_world/input/
make costume
```
