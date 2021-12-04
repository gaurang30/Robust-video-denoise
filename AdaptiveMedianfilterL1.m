function [] = AdaptiveMedianfilterL1(i,j,k,Win)

global H;
global W;
global T;
global globalmask;
global original_video;



        if Win>=3
            return;
        end
        med = median(reshape(original_video(max(1,i-Win):min(H,i+Win),max(1,j-Win):min(W,j+Win),max(1,k-Win):min(T,k+Win)),[],1));
        
        if (med<=0 || med>=255)
            AdaptiveMedianfilterL1(i,j,k,Win+1);
        else
            if (original_video(i,j,k) == 0) || (original_video(i,j,k)==255)
                original_video(i,j,k) = med;
                globalmask(i,j,k) = 1;
            end
        end
            
        
         
end