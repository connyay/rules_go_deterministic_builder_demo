.PHONY:build

test:
	bazel clean
	bazel build //cmd/main:main
	sha1sum bazel-out/host/bin/external/go_sdk/builder