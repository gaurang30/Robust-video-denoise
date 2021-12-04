function theta = ista(y,lambda,alpha,A,epsilon)

    theta = randn(size(A,2),1);
    
    while 1>0
        
        theta_next = wthresh(theta + (A')*(y - A*theta)./alpha,'s', lambda/(2*alpha));
        if norm(theta_next - theta)<epsilon
            theta = theta_next;
           break; 
        end
        theta = theta_next;
    end
end
