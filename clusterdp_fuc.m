function [Idx_sort,Idx_center,rhos,deltas,nneigh]=clusterdp_fuc(X, percent,numCluster0,flagRhao)

%    showShapeSet(X);
    num_case=size(X,1);
    dim_case=size(X,2);
    distset = shapeset2distset(X);
     dc = computeDc(distset, percent);
%     dc = 0.5;
%dc
     rhos = getLocalDensity(distset, dc);
    [deltas, nneigh] = getDistanceToHigherDensity(distset, rhos);

    lamda=rhos.*deltas;
%    lamda_range=sort(lamda);
    
    Idx_center=zeros(1,numCluster0);
    cluster = zeros(1,num_case);
    for i=1:numCluster0
        [lamda_max idx_ct]=max(lamda);
        lamda(idx_ct)=0;
       Idx_center(1,i)=idx_ct;
       cluster(1,idx_ct)=i;
    end
   
    [sorted_rhos, rords] = sort(rhos, 'descend');
    for i = 1:size(rords, 2)          %·ÖÀà
        if cluster(1,rords(i)) == 0
            neigh_cluster = cluster(1,nneigh(rords(i)));     
            if flagRhao==1 && i>(size(rords, 2)*0.9)    
                neigh_cluster=10;       
            end
            assert(neigh_cluster ~= 0, 'neigh_cluster has not assign!');
            cluster(1,rords(i)) = neigh_cluster;
        end
    end
  
    Idx_sort=cluster; 
 
 save('rhos','rhos');
 save('deltas','deltas');
end

function showElementCount(cluster, halo, cluster_num)
    for i = 0:cluster_num
        halo_filter = (halo == i);
        cluster_filter = (cluster == i);
        nc = length(find(cluster_filter));
        nh = length(find(halo_filter));
        fprintf('CLUSTER: %i, ELEMENTS: %i, CORE: %i, HALO: %i\n', i, nc, nh, nc-nh);
    end
end

function [min_rho, min_delta] = selectRect()
    subplot(2,2,2);
    rect = getrect;
    %fprintf('rect(x:%i y:%i width:%i height:%i)\n', rect(1), rect(2), rect(3), rect(4));
    min_rho   = rect(1);
    min_delta = rect(2);
end

function showHaloShape(shapeset, cluster, halo, cluster_num, ords)
    subplot(2,2,4); 
    hold on;    
    cmap = colormap;
    for i = 0:cluster_num
        filter = (halo == i);
        x = shapeset(:, 1)';
        y = shapeset(:, 2)';
        xx = x(filter);
        yy = y(filter);
        ic = int8(i * 32.0 / cluster_num) + 1;
        %fprintf('i: %d, cluster_element: %d\n', i, size(xx, 2));
        tt=plot(xx, yy, 'o', 'MarkerSize', 2, 'MarkerFaceColor', cmap(ic,:), 'MarkerEdgeColor', cmap(ic,:));
    end
    for i = 1:size(ords, 2)
        color = cluster(ords(i));
        x = shapeset(ords(i), 1);
        y = shapeset(ords(i), 2);
        ic = int8(color * 64.0 / cluster_num);
        tt=plot([x], [y], 'o', 'MarkerSize', 10, 'MarkerFaceColor', cmap(ic,:), 'MarkerEdgeColor', cmap(ic,:));
    end    
    text = strcat('HaloShape: ', num2str(cluster_num));
    title (text, 'FontSize', 15.0);
    xlabel ('x');
    ylabel ('y');    
end

function showColorShape(shapeset, cluster, cluster_num, ords)
    subplot(2,2,3); 
    hold on;    
    cmap = colormap;
    for i = 0:cluster_num
        filter = (cluster == i);
        x = shapeset(:, 1)';
        y = shapeset(:, 2)';
        xx = x(filter);
        yy = y(filter);
        ic = int8(i * 32.0 / cluster_num) + 1;
        %fprintf('i: %d, cluster_element: %d\n', i, size(xx, 2));
        tt=plot(xx, yy, 'o', 'MarkerSize', 2, 'MarkerFaceColor', cmap(ic,:), 'MarkerEdgeColor', cmap(ic,:));
    end
    for i = 1:size(ords, 2)
        color = cluster(ords(i));
        x = shapeset(ords(i), 1);
        y = shapeset(ords(i), 2);
        ic = int8(color * 64.0 / cluster_num);
        tt=plot([x], [y], 'o', 'MarkerSize', 10, 'MarkerFaceColor', cmap(ic,:), 'MarkerEdgeColor', cmap(ic,:));
    end    
    text = strcat('ColorShape: ', num2str(cluster_num));
    title (text, 'FontSize', 15.0);
    xlabel ('x');
    ylabel ('y');    
end

function showShapeSet(shapeset)
    scrsz = get(0,'ScreenSize');
    figure('Position', [6 72 scrsz(3)/2. scrsz(4)/1.3]);
    subplot(2,2,1); 
    tt = plot(shapeset(:, 1), shapeset(:, 2), 'o', 'MarkerSize', 2, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
    text = 'LoadShape';
    title (text, 'FontSize', 15.0);
    xlabel ('x');
    ylabel ('y');       
end

function showDeltas(rhos, deltas)
    subplot(2,2,2);
    tt = plot(rhos(:), deltas(:), 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
    text = strcat('max rho: ', num2str(max(rhos)), ', delta: ', num2str(max(deltas)));
    title (text, 'FontSize', 15.0);
    xlabel ('rho');
    ylabel ('delta');
end


