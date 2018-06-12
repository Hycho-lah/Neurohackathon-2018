function [ nConnections ] = visualizeGlasso( precMat )
%VISUALIZECORR Summary of this function goes here
%   Detailed explanation goes here

    covMat = inv(precMat);
    corrMat = corrcov(covMat);

    [nNeurons,~] = size(corrMat);
    
    corrDist = 1-abs(corrMat);
    
    lowD = cmdscale(corrDist);
    
    %figure; hold on;
        
    % draw links between nodes
    nConnections = 0;
    for ii=1:nNeurons
        for jj=(ii+1):nNeurons
            if abs(precMat(ii,jj))>1e-5 && ii~=jj
                plot([lowD(ii,1) lowD(jj,1)],[lowD(ii,2) lowD(jj,2)],'-','Color',[0.5 0.5 0.5])
                nConnections = nConnections+1;
            end
        end
    end
    
    % draw graph nodes (with coloring based on clustering)
    for ii=1:nNeurons
        plot(lowD(ii,1),lowD(ii,2),'.','MarkerSize',15,'Color',[0 0.3 0.6])
    end
    
end

