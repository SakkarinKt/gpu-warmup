#include <cstdio>
#include <cuda_runtime.h>

__global__ void vecAdd(const float* a, const float* b, float* c, int n) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < n) c[i] = a[i] + b[i];
}

int main() {
  const int N = 1 << 24; // 16M
  const size_t bytes = N * sizeof(float);
  // host
  float *h_a = (float*)malloc(bytes), *h_b = (float*)malloc(bytes), *h_c = (float*)malloc(bytes);
  for (int i=0;i<N;++i){ h_a[i]=1.0f; h_b[i]=2.0f; }

  // device
  float *d_a, *d_b, *d_c;
  cudaMalloc(&d_a, bytes); cudaMalloc(&d_b, bytes); cudaMalloc(&d_c, bytes);
  cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice);

  int block = 256;
  int grid = (N + block - 1) / block;

  cudaEvent_t start, stop;
  cudaEventCreate(&start); cudaEventCreate(&stop);
  cudaEventRecord(start);
  vecAdd<<<grid, block>>>(d_a, d_b, d_c, N);
  cudaEventRecord(stop); cudaEventSynchronize(stop);
  float ms=0; cudaEventElapsedTime(&ms, start, stop);

  cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost);
  printf("C[0]=%f  time=%f ms  approx GB/s=%.2f\n", h_c[0],
         ms, (3.0 * bytes / (ms/1000.0)) / 1e9);

  cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
  free(h_a); free(h_b); free(h_c);
  return 0;
}