# https://devblogs.nvidia.com/drop-in-acceleration-gnu-octave/
N = 8192;
A = single(rand(N,N));
B = single(rand(N,N));
start = clock();
C = A * B;
elapsedTime = etime(clock(), start);
disp(elapsedTime);
gFlops = 2*N*N*N/(elapsedTime * 1e+9);
disp(gFlops);
pause

# DEFAULT
# 7.8284 elapsedTime
# 140.45 GFLOPS