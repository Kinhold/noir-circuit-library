#!/bin/bash
set -e
echo "=== Cleaning ==="
rm -rf target
echo "=== Compiling All Binaries ==="
nargo compile
echo "=== Benchmark Results ==="
for bin in merkle_util nullifier auth htlc state dex_match; do
    echo "Primitive: $bin"
    nargo info --package $bin
done
