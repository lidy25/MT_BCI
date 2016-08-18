% Reshaping the data coming from the BioSemi
function out = unsplice32(in)

for i=1:size(in,1)
    for j=1:size(in,2)
        temp = uint32(in(i,j));
        temp1 = bitand(temp,255);
        temp2 = bitand(temp,bitshift(255,8));
        temp3 = bitand(temp,bitshift(255,16));
        temp4 = bitand(temp,bitshift(255,24));
        temp1 = bitshift(temp1,24);
        temp2 = bitshift(temp2,8);
        temp3 = bitshift(temp3,-8);
        temp4 = bitshift(temp4,-24);
        temp = bitor(bitor(bitor(temp1,temp2),temp3),temp4)';
%         if(find(bitget(temp,32))) % negative numbers
%             % out = [single(temp(1:cfg.chanNum)); single(bitand(bitshift(temp(cfg.chanNum+1),-8),255))];
%             out(i,j) = -single(temp);
%         else
%             out(i,j) = single(temp);
%         end
        out(i,j) = int32(temp);
    end
end