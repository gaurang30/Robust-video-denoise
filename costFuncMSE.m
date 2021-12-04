function cost = costFuncMSE(currentBlk,refBlk, n)
err = 0;
% for i = 1:n
%     for j = 1:n
%         err = err + abs((currentBlk(i,j) - refBlk(i,j)))*abs((currentBlk(i,j) - refBlk(i,j)));
%     end
% end
err = norm(currentBlk - refBlk,"fro");

cost = err / (n*n);