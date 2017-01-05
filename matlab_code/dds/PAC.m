function [WAVE] = PAC()
global PHASE;
global N;global K;global M;
% phase trunction
% dither = dectobin(round(2^(N-K)*(0.5-rand())),N);
% PHASE_dither = adder(PHASE,dither,N);
% PHASE_trunc = PHASE_dither(N-K+1:N);
 PHASE_trunc = PHASE(N-K+1:N);
% PHASE_trunc = adder(PHASE(N-K+1:N),[zeros(1,K-1),PHASE(N-K)],K);

% phase symetry
if(PHASE_trunc(K-1))
    Index = ~PHASE_trunc(1:K-2);
else
    Index = PHASE_trunc(1:K-2);
end

WAVE = LUT_TABLE(Index);
if(PHASE(N) == logical(1))
  temp = adder(WAVE,logical(ones(1,M)),M);
  WAVE = ~temp;
end
end