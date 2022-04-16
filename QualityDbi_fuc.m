function [ dbi, dbiList] = QualityDbi_fuc(X_data,Idx_center,Idx_sort,K)

if K<=1
    dbi=0;
    dbiList=0;
else
Compactness=zeros(1,K);
Sample_data=size(X_data,1);
% Compactness
 for i=1:K
     temp_dist=zeros(1,Sample_data);
     numElement=0;
     center=X_data(Idx_center(i),:);
     for j=1:Sample_data
         if Idx_sort(1,j)==i
            temp_dist(1,j)=sqrt(sum((X_data(j,:)-center).*(X_data(j,:)-center))) ;
            numElement=numElement+1;
         end
     end
     Compactness(1,i)=sum(temp_dist)/numElement;
 end
 %Separation
 Separation=zeros(1,K*(K-1)/2);
dbiList=zeros(K,K);
 r=1;count=0;
 for i=1:K-1
     center1=X_data(Idx_center(i),:);
     for j=(i+1):K
         center2=X_data(Idx_center(j),:);
         Separation(1,r)=sqrt(sum((center1-center2).*(center1-center2)));
         if Separation(1,r)~=0
             dbiList(i,j)=(Compactness(1,i)+Compactness(1,j))/Separation(1,r);% 越小越好count=count+1;
             count=count+1;
         else
             dbiList(i,j)=0;
         end
         r=r+1;
     end
 end
%dbi=max(max(dbiList));
%dbi=sum(sum(dbiList))/count;
dbi=mean(max(dbiList));
end

end

