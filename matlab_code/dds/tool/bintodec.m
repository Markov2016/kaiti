function [out] = bintodec(in,N)
if(in(N))
    temp = adder(in,logical(ones(1,N)),N);
    temp = ~temp;d=-1;
else
    temp = in;d=1;
end
temp2 = reshape(-N+1:1:0,N,1);
out = d * double(temp) * (2.^temp2);
end