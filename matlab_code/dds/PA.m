function [OUT] = PA(FCW)
global N;
global PHASE;
OUT = adder(PHASE,FCW,N);
PHASE = OUT;
end