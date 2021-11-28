# bubblwrap

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

- Wrap docker commands with `make`
