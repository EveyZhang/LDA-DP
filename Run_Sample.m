load('Sample.mat');
Dim_sub=3; %dim of feature subspace
numCluster0=4; %initial cluster num
flagMerge=1; %1:merge 0: non-merge

X_test=this_waveforms;
Sample_data=size(X_test,1);
[Idx_sort,Idx_center]=ldadp_fuc(X_test,Sample_data,Dim_sub,numCluster0,flagMerge);