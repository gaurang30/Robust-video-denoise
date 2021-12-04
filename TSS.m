function [ans_i , ans_j , min] = TSS(ref_i,ref_j,ref_k,start_i,start_j,fno)
global H;
global W;
global globalmask;
global original_video;
stepSize = 8;
x = start_i;
y = start_j;
costs = ones(3, 3) * 65537;
costs(2,2) = costFuncMSE(original_video(ref_i:ref_i+7,ref_j:ref_j+7,ref_k),original_video(x-4:x+3,y-4:y+3,fno),8);


 while(stepSize >= 1)  
          
            for m = -stepSize : stepSize : stepSize        
                for n = -stepSize : stepSize : stepSize
                    
                    if ( x + m - 4 < 1 || x + m + 3 > H || y + n - 4 < 1 || y + n + 3 > W)
                        continue;
                    end
                    costRow = m/stepSize + 2;
                    costCol = n/stepSize + 2;
                    if (costRow == 2 && costCol == 2)
                        continue
                    end
                    costs(costRow, costCol ) =costFuncMSE(original_video(ref_i:ref_i+7,ref_j:ref_j+7,ref_k),original_video(x+m-4:x+m+3,y+n-4:y+n+3,fno),8);
               
                end
            end
   [dx, dy, min] = minCost(costs); 
   x = x + (dx-2)*stepSize;
   y = y + (dy-2)*stepSize;
   
   if(dx==2 && dy==2)
       break
   end
   
   stepSize = stepSize / 2;
   costs = ones(3, 3) * 65537;
   costs(2,2) = costs(dy,dx);
 end
 ans_i = x - 4;
 ans_j = y - 4;
 
end