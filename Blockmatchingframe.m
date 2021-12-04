function [min5,min64] = Blockmatchingframe(ref_i,ref_j,ref_k,fno)
global H;
global W;
global globalmask;
global original_video;
min64 = zeros(64,4);

for i = 1:8
    for j = 1:8
        [ans_i , ans_j , mini] = TSS(ref_i,ref_j,ref_k,(i-1)*32+16,(j-1)*32+16,fno);
        min64((i-1)*8 + j,:) = [mini ans_i ans_j fno];
    end
end

min64 = sortrows(min64);

min5 = zeros(5,3);

cnt = 1;
min5(1,:) = min64(1,2:4);

for i = 2:64
    
    if(min64(i,2) == min5(cnt,1) && min64(i,3) == min5(cnt,2) && min64(i,4) == min5(cnt,3))
       cnt = cnt + 0;
    else
       cnt = cnt + 1;
       min5(cnt,:) = min64(i,2:4);
    end
    
    if(cnt == 5)
        break
    end
        
    
end

end