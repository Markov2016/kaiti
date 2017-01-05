function [ BinNum ] = dectobin( DecNum, N )
decnum = DecNum;
BinNum = logical(zeros(1,N));
if(decnum>=0)
    if(decnum>=2^(N-1))
        BinNum(1:N-1) = logical(ones(1,N-1));
    else
        temp = dec2bin(decnum,N-1);
        BinNum(1:N-1) = logical(temp(N-1:-1:1) - 48*ones(1,N-1));
    end
    
else
    BinNum(N) = logical(1);
    if (decnum >= -2^(N))
        temp = dec2bin(-decnum,N-1);
        BinNum(1:N-1) = ~logical(temp(N-1:-1:1) - 48*ones(1,N-1));
        one = logical(zeros(1,N));one(1) = logical(1);
        BinNum = adder(BinNum,one,N);
    end
end
end

