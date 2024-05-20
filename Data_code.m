for i=1:100
    for j = 1:100
        [h,p(i,j)] = ttest(D(i,j,:));        
    end
end
clear i j h;

q = 0.001
p = p(isfinite(p));  % Toss NaN's
p = sort(p(:)); % sorted p values
V = length(p); % length of elements
I = (1:V)'; % index

cVID = 1;
cVN = sum(1./(1:V));

pID = p(max(find(p<=I/V*q/cVID)));
if isempty(pID), pID=0; end
pN = p(max(find(p<=I/V*q/cVN)));
if isempty(pN), pN=0; end


% 
 pp = p(isfinite(p));  % Toss NaN's
% pp = sort(pp(:));
% m = length(pp);
% for i = 1:m
%     if pp(i)<=(i/m)*a;
%        k = i;
%        %break;
%     end
% end
q = 0.001;
pp = p;
pp = sort(pp(:));
m = length(pp);
I = (1:m)';
for i = 1:m
    if pp(i) <= (i/m)*q
        k = i;
    end
end
pp(:)<=(I/m)*q


[FDR] = mafdr(pp,'BHFDR',true);
