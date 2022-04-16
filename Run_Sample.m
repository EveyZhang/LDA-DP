load('Sample.mat');
Dim_sub=3; %dim of feature subspace
numCluster0=4; %initial cluster num
flagMerge=1; %1:merge 0: non-merge

X_test=this_waveforms;
Sample_data=size(X_test,1);
[COEFF,SCORE] = pca(X_test);
W0List{1,1}=COEFF(:,1:3)';
[W,Y,Idx_sort0,Idx_center0,Idx_sort1,Idx_center1,cycle,errtrval]=ldadp_fuc(X_test,Sample_data,Dim_sub,W0List,numCluster0,flagMerge);