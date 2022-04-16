function [ W, trval] = lda_fuc( X, Idx_sort,numCluster,Dim_sub)
% LDA
    [~,numDim]=size(X);
    numList=zeros(1,numCluster);
    for i=1:numCluster
        numList(1,i)=sum(Idx_sort==i);
    end
    numSample=sum(numList);
    idxList=zeros(1,numCluster+1);  
    idxList(1,1)=1;
    for i=2:numCluster+1
         idxList(1,i)=idxList(1,i-1)+numList(1,i-1);
    end
    % w
    idxList1=idxList;
    w=zeros(numSample,numDim);
    for i=1:numSample
        for j=1:numCluster
            if Idx_sort(1,i)==j
                w( idxList1(1,j),:)=X(i,:);
                idxList1(1,j)=idxList1(1,j)+1;
            end
        end
    end
    % 
    meanList=zeros(numCluster,numDim);
    for i=1:numCluster
        id1=idxList(1,i);
        id2=idxList(1,i+1)-1;
        if numList(1,i)~=0
            meanList(i,:)=sum(w(id1:id2,:))/numList(1,i);
        end
    end
    %    meanAll=mean(X);
    meanAll=mean(w(1:idxList(1,numCluster+1)-1,:));
    %
    s=zeros(numDim,numDim,numCluster);
    for i=1:numCluster
        id1=idxList(1,i);
        id2=idxList(1,i+1)-1;
        for id=id1:id2
            s(:,:,i)=s(:,:,i)+(w(id,:)-meanList(i,:))'*(w(id,:)-meanList(i,:));
        end
    end
    %Sw
    Sw=zeros(numDim,numDim);
    for i=1:numCluster
  %      temp(:,:)=numList(1,i)*s(:,:,i);  %1*64*64
        temp(:,:)=s(:,:,i);        
        Sw=Sw+temp;
  %      Sw=Sw+numList(1,i)*s(i,:,:);
    end
    Sw=Sw/numSample;
    %Sb
     Sb=zeros(numDim,numDim);
    for i=1:numCluster
        Sb=Sb+numList(1,i)*(meanAll-meanList(i,:))'*(meanAll-meanList(i,:));
    end
    Sb=Sb/numSample;
    %
%    A = repmat(0.1,[1,size(Sw,1)]);
     A = repmat(0.0001,[1,size(Sw,1)]);  %10.24ÐÞ¸Ä
    B = diag(A);
%     S=single((Sw + B)\Sb);
S=(Sw + B)\Sb;
    [V,D]=eig(S);
    Lamda=max(D);
    
%    Dim_sub=min([numCluster-1,3]);
%W=zeros(Dim_sub,numDim);
W=zeros(Dim_sub,numDim);
trval=sum(Lamda);
    for i=1:Dim_sub
        [~,b]=max(Lamda);
        W(i,:)= V(:,b)';
        Lamda(b)=0;           
    end
    ans=1;
end