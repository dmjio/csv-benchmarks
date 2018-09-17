csv-benchmarks
======================

Time and space benchmarks of various `CSV` lexing / parsing libraries.
All tests are executed with `-O2` and `-funbox-strict-fields`.

The main test bed consists of lexing all fields in ~`301MB` `CSV` file.
The `PAD` database of NYC must first be fetched. Instructions in the [Benchmarks](#benchmarks) section.

### Setup
  - [cassava](http://hackage.haskell.org/package/cassava), efficient CSV parsing library for `Haskell`.
  - [hw-dsv](https://github.com/haskell-works/hw-dsv#readme), succinct data structures-based DSV parsing library.
  - [scythe](https://github.com/dmjio/scythe), `alex`-based bytestring lexing library.
  - [csv-killa](https://github.com/dmjio/csv-killa/blob/master/src/Main.hs), hand-rolled `ByteString` lexing of `CSV` data.

### Build
```
$ nix-build
```

### Develop
```
$ nix-shell
```

### Benchmarks
```
$ nix-build -A benchmarks && ./result/bin/benchmarks
```

Executed on an old 2012 Macbook Pro without `BMI2`, updated results for more modern hardward coming soon!

### Result
```
Running cassava...
34107138
  24,552,249,768 bytes allocated in the heap
     320,588,672 bytes copied during GC
          60,784 bytes maximum residency (2 sample(s))
          36,368 bytes maximum slop
               2 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     22844 colls,     0 par    0.350s   0.379s     0.0000s    0.0001s
  Gen  1         2 colls,     0 par    0.000s   0.000s     0.0002s    0.0003s

  INIT    time    0.000s  (  0.003s elapsed)
  MUT     time    6.373s  (  6.672s elapsed)
  GC      time    0.350s  (  0.379s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    6.724s  (  7.054s elapsed)

  %GC     time       5.2%  (5.4% elapsed)

  Alloc rate    3,852,402,905 bytes per MUT second

  Productivity  94.8% of total user, 94.6% of total elapsed

Running csv-killa...
34107138
  23,655,178,336 bytes allocated in the heap
      30,301,856 bytes copied during GC
          87,424 bytes maximum residency (362 sample(s))
          36,360 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     22062 colls,     0 par    0.136s   0.158s     0.0000s    0.0001s
  Gen  1       362 colls,     0 par    0.023s   0.023s     0.0001s    0.0002s

  INIT    time    0.000s  (  0.003s elapsed)
  MUT     time    4.101s  (  4.251s elapsed)
  GC      time    0.159s  (  0.181s elapsed)
  EXIT    time    0.000s  (  0.010s elapsed)
  Total   time    4.260s  (  4.445s elapsed)

  %GC     time       3.7%  (4.1% elapsed)

  Alloc rate    5,767,908,320 bytes per MUT second

  Productivity  96.3% of total user, 95.9% of total elapsed

Running scythe...
34107138
 230,049,860,760 bytes allocated in the heap
      40,957,760 bytes copied during GC
          58,000 bytes maximum residency (352 sample(s))
          36,360 bytes maximum slop
               5 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     133165 colls,     0 par    1.318s   1.470s     0.0000s    0.0001s
  Gen  1       352 colls,     0 par    0.033s   0.034s     0.0001s    0.0003s

  INIT    time    0.000s  (  0.003s elapsed)
  MUT     time   21.527s  ( 21.951s elapsed)
  GC      time    1.351s  (  1.504s elapsed)
  EXIT    time    0.000s  (  0.011s elapsed)
  Total   time   22.879s  ( 23.470s elapsed)

  %GC     time       5.9%  (6.4% elapsed)

  Alloc rate    10,686,489,280 bytes per MUT second

  Productivity  94.1% of total user, 93.6% of total elapsed

Running hw-dsv...
34107138
  12,288,681,568 bytes allocated in the heap
      14,985,672 bytes copied during GC
          58,528 bytes maximum residency (346 sample(s))
          36,360 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     11211 colls,     0 par    0.102s   0.115s     0.0000s    0.0011s
  Gen  1       346 colls,     0 par    0.029s   0.030s     0.0001s    0.0002s

  INIT    time    0.000s  (  0.003s elapsed)
  MUT     time   25.546s  ( 25.775s elapsed)
  GC      time    0.131s  (  0.145s elapsed)
  EXIT    time    0.000s  (  0.007s elapsed)
  Total   time   25.677s  ( 25.931s elapsed)

  %GC     time       0.5%  (0.6% elapsed)

  Alloc rate    481,034,579 bytes per MUT second

  Productivity  99.5% of total user, 99.4% of total elapsed

Running hw-dsv with BMI2 enabled...
34107138
  12,288,681,568 bytes allocated in the heap
      14,985,672 bytes copied during GC
          58,528 bytes maximum residency (346 sample(s))
          36,360 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     11211 colls,     0 par    0.090s   0.101s     0.0000s    0.0001s
  Gen  1       346 colls,     0 par    0.027s   0.027s     0.0001s    0.0002s

  INIT    time    0.000s  (  0.003s elapsed)
  MUT     time   26.362s  ( 26.558s elapsed)
  GC      time    0.116s  (  0.129s elapsed)
  EXIT    time    0.000s  (  0.006s elapsed)
  Total   time   26.479s  ( 26.695s elapsed)

  %GC     time       0.4%  (0.5% elapsed)

  Alloc rate    466,150,170 bytes per MUT second

  Productivity  99.6% of total user, 99.5% of total elapsed
```
