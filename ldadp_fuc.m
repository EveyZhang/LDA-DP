function [W,Y,Idx_sort0,Idx_center0,Idx_sort1,Idx_center1,cycle,errtrval]=ldadp_fuc(X,Sample_data,Dim_sub,W0List,numCluster0,flagMerge)
percent=2;
RatioNoise=0.02;
Errtrval=0.000001;
CYCLE1=5;CYCLE2=50;CYCLE3=100;
% initialize
W=W0List{1,1};  
stop=0;cycle=0;
errtrval=0;
trval=1;
flagRhao=0;
Y=X*W';
[Idx_sort0,Idx_center0,rhos,deltas,nneigh]=clusterdp_fuc(Y, percent,numCluster0,flagRhao); 
L= Idx_sort0;dc=1;

while (cycle<CYCLE1)||(stop==0)
    cycle=cycle+1;
    numCluster=size(Idx_center0,2);
    W_pre=W;
    if cycle==CYCLE2
        W=W0List{1,1};  %
        CYCLE1=CYCLE2+CYCLE1;
    else
       [ W, trval]= lda_fuc( X, Idx_sort0,numCluster,Dim_sub);
    end
    Y=X*W'; 
    [Idx_sort0,Idx_center0,rhos,deltas,nneigh]=clusterdp_fuc(Y, percent,numCluster0,flagRhao);
    L_pre=L;
    L=Idx_sort0;
    fx=zeros(1,numCluster0);
    for i=1:numCluster0
        fx(1,i)=L_pre(1,Idx_center0(1,i));  
    end
    for i=1:Sample_data
        if L(i)==10       

        else
            if fx(L(i))~=L_pre(i)
                stop=stop+1;
            end
        end
    end
    if (stop/Sample_data)<=RatioNoise 
        stop=1;
    else
        stop=0;
    end
    if cycle>CYCLE3
        stop=1;
    end

 end

%merge
 if flagMerge==1
     [Idx_sort1,Idx_center1 ] = merge_fuc2( Y,Idx_sort0,Idx_center0,size(Idx_center0,2) );
 else
     Idx_sort1=Idx_sort0;
     Idx_center1=Idx_center0;
 end
end