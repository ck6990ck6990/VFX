function [w] = weighting()
    w = zeros(256, 1);
    for i = 1 : 128
        w(i) = i-1;
        w(257-i) = i-1;
    end
end