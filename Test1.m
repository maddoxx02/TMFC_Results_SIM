function Test1(matrix, threshold)
% V2

% Load BSC_LSS_TaskA_vs_TaskB_group 
% matrix = matrices of patient data in the form of x*y*z
% thresold = threshold for P value (default: 0.001)
% alpha = alpha value for FWE Bonnfferni approach

% -------------------------------------------------------------------------
% This code "Test - 1" is aimed at learning & getting Familiar with 
% Matrices, structure of the data (i.e. 100*100*100 (i.e. 100 ROIs of each 
% patient * 100 Patients). 

% The first task is to generate statistical inferences from the above
% 100 matrices of patient data 
%   Task: 
%   Apply three types of thresholds: 
%       1. p < 0.001 uncorrected
%       2. p < 0.001 FDR - corrected
%       3. p < 0.05 FWE - Corrected
% -------------------------------------------------------------------------

if nargin == 1
    threshold = 0.001;
end

alpha = 0.05;
N = length(matrix);

% ----------------------------------------------------------------------
% Case 1, When p < 0.001 (Uncorrected)

% To Store final Result
thres_1 = [];

% Performing T-Test on data
for i=1:N
    for j = 1:N
        [h,p(i,j)] = ttest(matrix(i,j,:));        
    end
end

% Comparison with Threshold (0.001)
thres_1 = p<threshold;

% Generation of Heatmap
H1 = heatmap(double(thres_1));
H1.XLabel = 'ROI';
H1.YLabel = 'ROI';
H1.Title = ['Correlation when p < ', num2str(threshold),' "Uncorrected"'];
figure;
% ----------------------------------------------------------------------

% Case 2, When p<0.001 - via False Discovery Rate error correction
% thres_2 = [];
% 
% 1. Perform T Test on the data 
% 2. Extract & Determine the corrected P value using the FDR method
% 3. Filter the matrix by the threshold 
% 4. Generate Heat map 

% Approach #1 
p2 = p(isfinite(p));
p2 = sort(p(:));
V = length(p2);
for i = 1:V
    if p2(i) <= (i/V)*threshold
        k = i;
    end
end
kk = k/10000000;

thres_2 = p<kk;

% Alternatively 
% pID = p2(max(find(p2<=I/V*threshold)));
% if isempty(pID), pID=0; end

H2 = heatmap(double(thres_2));
H2.XLabel = 'ROI';
H2.YLabel = 'ROI';
H2.Title = 'Corr when p < 0.001 (FDR Corrected)';
figure;
% ----------------------------------------------------------------------
% 
% % Case 3, when p < 0.05 - Family Wise Error correction
% 
% thres_3 = [];
% 
% % Peforming T Test
% ctr = 1;
% for i=1:100
%     for j = 1:100
%         
%         [h,p] = ttest(matrix(i,j,:));
%         thres_3(ctr) = p;
%         ctr = ctr +1;                
%     end
% end
% 
% 
% % 
% sub_3 = [];
% ctr = 1;
% for i = 1: 100
%     for j = 1:100
%         
% % Bonferroni Correction where in hypotheses H1... Hn, with p values p1..... pn, 
% % if pi <= alpha/total number of null hypothesis 
% %       1 = accepted hypothesis
% %       0 = rejected hypothesis
% 
%         if ss(ctr) <= alpha/10000            
%             sub_3(i,j) = 1;
%         else
%             sub_3(i,j) = 0;
%         end
%         ctr = ctr+1;
%         
%     end
% end
% 
% 
% H3 = heatmap(sub_3);
% H3.XLabel = 'ROI';
% H3.YLabel = 'ROI';
% H3.Title = 'Corr when p < 0.05 (FDE Corrected)';


end

