function [out] = adder(in1,in2,N)
out = logical(zeros(1,N));
c = logical(0);
for i=1:N
    out(i) = xor(xor(in1(i),in2(i)),c);
    c = (in1(i) & in2(i))|(in1(i) & c)|(c & in2(i));
end
end