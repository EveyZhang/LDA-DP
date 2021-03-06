function distset = shapeset2distset(shapeset)
    casenum = size(shapeset, 1);
    distset = zeros(casenum, casenum);
    for i = 1:casenum-1
        case1 = shapeset(i,:);
        for j = 2:casenum
            case2 = shapeset(j,:);
            dist = sqrt((case1 - case2) * (case1 - case2)');
            distset(i, j) = dist;
            distset(j, i) = dist;
        end
    end
end