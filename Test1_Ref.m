function [matrix_FDR Nsig_FDR pval tval matrix_uncorr001 Nsig_uncorr001] = Test_1_Ref(matrix,alpha_FDR);

% ========================================================================
% Ruslan Masharipov, October, 2023
% email: ruslan.s.masharipov@gmail.com
% ========================================================================

N = length(matrix);

for roii = 1:N
    for roij = 1:N
        if roii == roij
           pval(roii,roij) = 0;
           tval(roii,roij) = 0;
        else
           [h,pval(roii,roij),ci,stat] = ttest(shiftdim(matrix(roii,roij,:)));
           tval(roii,roij) = stat.tstat;
        end
    end
end

matrix_mask = ones(N,N);
matrix_mask = tril(matrix_mask,-1);
a_mask = matrix_mask(:);

for i = 1:size(matrix,3)
    tmp = matrix(:,:,i);
    a_matrix = tmp(:);
    a_matix_masked(i,:) = a_matrix(find(a_mask)); 
end

[h,p,ci,stats] = ttest(a_matix_masked);
[pFDR,pN] = FDR(p,alpha_FDR);

matrix_FDR = pval<pFDR;
matrix_uncorr001 = pval<0.001;

Nsig_FDR = sum(lower_triangle(double(matrix_FDR)));
Nsig_uncorr001 = sum(lower_triangle(double(matrix_uncorr001)));

function [pID,pN] = FDR(p,q)
% FORMAT [pID,pN] = FDR(p,q)
% 
% p   - vector of p-values
% q   - False Discovery Rate level
%
% pID - p-value threshold based on independence or positive dependence
% pN  - Nonparametric p-value threshold
%______________________________________________________________________________
% $Id: FDR.m,v 2.1 2010/08/05 14:34:19 nichols Exp $


p = p(isfinite(p));  % Toss NaN's
p = sort(p(:));
V = length(p);
I = (1:V)';

cVID = 1;
cVN = sum(1./(1:V));

pID = p(max(find(p<=I/V*q/cVID)));
if isempty(pID), pID=0; end
pN = p(max(find(p<=I/V*q/cVN)));
if isempty(pN), pN=0; end
end


function low = lower_triangle(matrix)

% ========================================================================
% Ruslan Masharipov, October, 2023
% email: ruslan.s.masharipov@gmail.com
% ========================================================================

matrix(1:1+size(matrix,1):end) = NaN;
low = matrix(tril(true(size(matrix)))).';
low(isnan(low)) = [];

end


end