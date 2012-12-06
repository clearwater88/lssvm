function [x,y] = makeData(nSamples)

    minLat = -20;
    maxLat = 20;
    x = minLat + (maxLat-minLat)*rand(nSamples,2);
    y = ~((x(:,1) < 0) & (x(:,2) < 0));

end