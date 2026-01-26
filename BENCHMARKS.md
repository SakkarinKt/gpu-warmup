# Benchmarks Summary

Source files: `artifacts/artifacts/deviceQuery.txt`, `artifacts/artifacts/bandwidthTest.txt`, `artifacts/artifacts/bandwidthTest_range.txt`.

## Device Query (deviceQuery)

- GPU: NVIDIA L4
- CUDA driver/runtime: 12.4 / 12.4
- Compute capability: 8.9
- Global memory: 22478 MiB (23,570,219,008 bytes)
- SMs: 58
- CUDA cores: 7424
- Max GPU clock: 2040 MHz
- Memory clock: 6251 MHz
- Memory bus width: 192-bit
- L2 cache: 50,331,648 bytes
- ECC: Enabled
- Result: PASS

## Bandwidth Test (Quick Mode)

Pinned memory transfers, 1 device:

| Direction | Transfer size | Bandwidth (GB/s) |
| --- | --- | --- |
| Host → Device | 32,000,000 bytes | 12.3 |
| Device → Host | 32,000,000 bytes | 13.2 |
| Device → Device | 32,000,000 bytes | 242.9 |

Result: PASS

## Bandwidth Test (Range Mode)

Pinned memory transfers, Device → Host:

- Transfer size range: 1,024 to 102,400 bytes
- Observed bandwidth range: 0.6 to 11.5 GB/s
- Max observed bandwidth: 11.5 GB/s at 102,400 bytes

Result: PASS

## Notes

- CUDA Samples warn that these tests are not definitive performance measurements and can vary with GPU Boost.

