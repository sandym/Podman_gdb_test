
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

M3 - untested, but I suspect it would be the same as M4.

On an M4:
```
warning: Error disabling address space randomization: Function not implemented
Unable to fetch SVE/SSVE vector length: Invalid argument.
```

It would seem that it's impossible to debug on an Apple Silicon M3 or better with Podman.
Likely reason is that nested virtualisation is not enabled as this is the fix with other container technologies.
See: https://stackoverflow.com/questions/79312200/gdb-error-unable-to-fetch-sve-ssve-vector-length-invalid-argument-on-docker
Nested virtualisation is only available with M3 or better so M1/M2 are unaffected.

Podman uses `vfkit` to start its virtual machine and I could not find a way to setup Podman so that it send the `nested` argument to `vfkit`.
https://github.com/crc-org/vfkit/blob/3c1abf3e3a8c2864892462832924da73b9df7e42/pkg/cmdline/cmdline.go#L63
