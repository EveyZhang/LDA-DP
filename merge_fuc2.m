function [ Idx_sortNew , Idx_centerNew] = merge_fuc2( Y,Idx_sort,Idx_center,numCluster )

DBIPA=1.6;%1~4:1.6      
Sample_data=size(Y,1);
stop=1;
while (stop)
     [ meanDbi, dbi] = QualityDbi_fuc(Y,Idx_center,Idx_sort,numCluster);

    DBI=DBIPA*sum(sum(dbi))/(numCluster*(numCluster-1)/2);
%     DBI=DBIPA*meanDbi;
%  DBI=0.6;
    flag=zeros(1,numCluster);
    numClusterNew=numCluster;
    for i=1:numCluster
        if flag(1,i)==0
             flag(1,i)=i;
        end
        for j=(i+1):numCluster
            if flag(1,j)==0
                if dbi(i,j)>DBI
                    flag(1,j)=flag(1,i);
                    numClusterNew=numClusterNew-1;
                end
            end
        end
    end

    Idx_centerNew=zeros(1,numClusterNew);         
    r=1;
    for i=1:numCluster
        if flag(1,i)==i
            Idx_centerNew(1,r)=Idx_center(1,i);
            flag(1,i)=r;
            r=r+1;
        else
            flag(1,i)=flag(1,flag(1,i));
        end
    end
    Idx_sortNew=zeros(1,Sample_data);
    if  numClusterNew<numCluster
        for i=1:Sample_data
            if Idx_sort(1,i)~=10
                Idx_sortNew(1,i)= flag(1,Idx_sort(1,i));
            else
                Idx_sortNew(1,i)=10;
            end
        end
    else
        Idx_sortNew=Idx_sort;
    end
    if(numCluster~=numClusterNew)
        Idx_center=Idx_centerNew;
        Idx_sort=Idx_sortNew;
        numCluster=numClusterNew;
    else
        stop=0;
    end
end

end

