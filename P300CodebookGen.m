function codebook=P300CodebookGen()
%generation of P300-like codebook
%for 6 x 6 matrix
%3rd row: parallel codes

for i=1:6
    codebook{i}=[i i i i i i;1 2 3 4 5 6;i i i i i i];
    codebook{i+6}=[1 2 3 4 5 6;i i i i i i;i+6 i+6 i+6 i+6 i+6 i+6];
end
