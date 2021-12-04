function [blocks] = Blockmatching(ref_i,ref_j,ref_k,T)

blocks = zeros(5*T+1,3);


for i = 1:T
    frameblocks = Blockmatchingframe(ref_i,ref_j,ref_k,uint8(i));
    for j = 1:5
        blocks((i-1)*5+j,:) = frameblocks(j,:);
    end
        
end
blocks(T*5+1,:) = [ref_i, ref_j, ref_k];

end