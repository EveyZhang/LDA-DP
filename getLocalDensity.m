function rhos = getLocalDensity(distset, dc)

    casenum = size(distset, 1);
    %rhos = zeros(1, casenum);
    gaus = exp(-((distset / dc) .^ 2));
    rhos = sum(gaus) - 1;
end

