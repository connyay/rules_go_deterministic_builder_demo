# rules_go_deterministic_builder_demo

Demo showing non determinist `go_sdk/builder`.

Run `make` from the root of the repo multiple.

Expected: Same `sha1 bazel-out/host/bin/external/go_sdk/builder` after each builds.
Actual: Different builder sha1s due to bazel sandbox paths in built binary.

```console
bazel clean
INFO: Starting clean.
bazel build //cmd/main:main
INFO: Analyzed target //cmd/main:main (36 packages loaded, 6938 targets configured).
INFO: Found 1 target...
Target //cmd/main:main up-to-date:
  bazel-bin/cmd/main/main_/main
INFO: Elapsed time: 4.948s, Critical Path: 2.75s
INFO: 8 processes: 4 internal, 4 darwin-sandbox.
INFO: Build completed successfully, 8 total actions
sha1sum bazel-out/host/bin/external/go_sdk/builder
ae6779e572aacd382e4caa4e981aafc7c9297d1c  bazel-out/host/bin/external/go_sdk/builder
```

```console
bazel clean
INFO: Starting clean.
bazel build //cmd/main:main
INFO: Analyzed target //cmd/main:main (36 packages loaded, 6938 targets configured).
INFO: Found 1 target...
Target //cmd/main:main up-to-date:
  bazel-bin/cmd/main/main_/main
INFO: Elapsed time: 4.546s, Critical Path: 2.16s
INFO: 8 processes: 4 internal, 4 darwin-sandbox.
INFO: Build completed successfully, 8 total actions
sha1sum bazel-out/host/bin/external/go_sdk/builder
82495a996aeb2be6a43ff3df44d2699d3888830a  bazel-out/host/bin/external/go_sdk/builder
```

```console
go tool objdump bazel-out/host/bin/external/go_sdk/builder | grep sandbox
TEXT internal/bytealg.init.0(SB) /private/var/tmp/_bazel_connor.hindley/d1d70ecadb5e65256496d7b325bf6954/sandbox/darwin-sandbox/38/execroot/__main__/external/go_sdk/src/internal/bytealg/index_amd64.go
TEXT _cmpbody(SB) /private/var/tmp/_bazel_connor.hindley/d1d70ecadb5e65256496d7b325bf6954/sandbox/darwin-sandbox/38/execroot/__main__/external/go_sdk/src/internal/bytealg/compare_amd64.s
TEXT runtime.cmpstring(SB) /private/var/tmp/_bazel_connor.hindley/d1d70ecadb5e65256496d7b325bf6954/sandbox/darwin-sandbox/38/execroot/__main__/external/go_sdk/src/internal/bytealg/compare_amd64.s
TEXT _countbody(SB) /private/var/tmp/_bazel_connor.hindley/d1d70ecadb5e65256496d7b325bf6954/sandbox/darwin-sandbox/38/execroot/__main__/external/go_sdk/src/internal/bytealg/count_amd64.s
TEXT internal/bytealg.Count(SB) /private/var/tmp/_bazel_connor.hindley/d1d70ecadb5e65256496d7b325bf6954/sandbox/darwin-sandbox/38/execroot/__main__/external/go_sdk/src/internal/bytealg/count_amd64.s
```
