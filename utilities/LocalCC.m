function [U,UdotV,shifts] = LocalCC(U,V)

% 2D cross-correlation that doesn't use FFTs, since we only need a local
% search for the maximum correlation
% it works by using a sort of "line search"
% U is shifted onto V

% Written by Toby Sanders 
% @ Lickenbrock Technologies


shifts = zeros(1,2);
sPos = [-1 0; 1 0; 0 -1; 0 1];
sPostmp = sPos;
UdotV = sum(U.*V);
cnt = 0;ii = 0;
maxCnt = 4;

% step in each direction, if the dot product increases, move and continue
% the search from there.  If all directions have been checked and there is
% no increase, then the algorithm is complete
while cnt<maxCnt 
    cnt = cnt+1;
    ii = mod(ii,maxCnt) + 1;
    CC = sum(sum(V.*circshift(U,shifts + sPostmp(ii,:))));
    % if dot product has increased, update reference point, shifts, and all
    % other variables accordingly
    if UdotV<CC
        % update shifts and counter
        shifts = shifts + sPostmp(ii,:);
        cnt = 0;
        % reset maxCnt since we can now avoid the previous direction
        maxCnt = 3; 
        if sPostmp(ii,1) == -1, sPostmp = sPos([1,3,4],:);
        elseif sPostmp(ii,1) == 1, sPostmp = sPos(2:4,:);
        elseif sPostmp(ii,2) == -1, sPostmp = sPos(1:3,:);
        elseif sPostmp(ii,2) == 1, sPostmp = sPos([1,2,4],:); 
        end
        ii = ii - 1; % reset ii to last value
        UdotV = CC; % reset correlation value at current shift
        
        % if shifts is getting too large, give up and use FFT approach
        if sum(abs(shifts))>20
            [U,shifts] = cross_corr_2V(V,U);
            UdotV = sum(sum(U.*V));
            return;
        end           
    end
end
U = circshift(U,shifts); % done

