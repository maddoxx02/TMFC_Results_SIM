function CodeV2(matrix, threshold)

% Load BSC_LSS_TaskA_vs_TaskB_group 
% thresold = threshold for P value 
% alpha = alpha value for FWE Bonnfferni approach


if nargin == 1
    threshold = 0.001;
end

alpha = 0.05;
N = length(matrix);

% ----------------------------------------------------------------------
% Case 1, When p<0.001

% To Store final Result
thres_1 = [];


for i=1:N
    for j = 1:N
        [h,p(i,j)] = ttest(matrix(i,j,:));        
    end
end

thres_1 = p<threshold;

% Generation of Heatmap
H1 = heatmap(double(thres_1));
H1.XLabel = 'ROI';
H1.YLabel = 'ROI';
H1.Title = ['Correlation when p < ', num2str(threshold),'Uncorrected'];

% ----------------------------------------------------------------------
% 
% % Case 2, When p<0.001 - via False Discovery Rate error correction
% thres_2 = [];
% 
% % Generation of P value
% ctr = 1;
% for i = 1:100
%     for j = 1:100
%         [h,p] = ttest(matrix(i,j,:));
%         thres_2(ctr) = p;
%         ctr = ctr +1;                
%     end
% end
% 
% % FDR implementaiton using mafdr() matlab function
% ss = mafdr(thres_2);
% 
% % restoration from 1D array to 2D
% ctr = 1;
% for i = 1: 100
%     for j = 1:100
%         sub_2(i,j) = ss(ctr);
%         ctr = ctr+1;        
%     end
% end
% 
% % Construction of Binary Matrix
% thres_2b = [];
% for i=1:100
%     for j = 1:100
%         
%         if sub_2(i,j)<threshold
%             thres_2b(i,j,:) = 1;
%         else
%             thres_2b(i,j,:) = 0;
%         end
%         
%     end
% end
% 
% 
% H2 = heatmap(thres_2b);
% H2.XLabel = 'ROI';
% H2.YLabel = 'ROI';
% H2.Title = 'Corr when p < 0.001 (FDR Corrected)';
% figure;
% % ----------------------------------------------------------------------
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


