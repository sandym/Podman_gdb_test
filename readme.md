
## How to test

Build the image:
```
> podman build -t gdb_test .
```

Run it:
```
> podman run --rm -ti gdb_test bash
```

Debug:
```
bash-5.1# gdb a.out 
...
(gdb) br main
Breakpoint 1 at 0x40314c: file test.cpp, line 5.
(gdb) r
Starting program: /files/a.out 
warning: Error disabling address space randomization: Function not implemented
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".

Breakpoint 1, main () at test.cpp:5
5       std::print("hello world!\n");
...
```
## Results

Works fine on an M1 and M2 (tested).

M3 - untested, I think it might work, M4+ implement amrv9. 

On an M4:
```
warning: Error disabling address space randomization: Function not implemented
Unable to fetch SVE/SSVE vector length: Invalid argument.
```

It would seem that it's impossible to debug on an Apple Silicon M4 or better with Podman.
Likely reason is that the cpu SVE2 extension is not managed correctly.
see: https://github.com/podman-container-tools/podman/issues/28312

