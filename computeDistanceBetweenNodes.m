function computeDistanceBetweenNodes()
    ontologyFile = 'mouseOntology.mat';

    addpath('~/Projects/matlab_bgl')
    load(ontologyFile,'structuredObjects','dependecyMatrix','structureLabels');

    undirectedMatrix = dependecyMatrix + dependecyMatrix';
    directedDistanceMatrix = nan(size(dependecyMatrix));
    unDirectedDistanceMatrix = nan(size(dependecyMatrix));
    for i = 1:size(dependecyMatrix,1)
        [nodeDistance ~] = dijkstra_sp(dependecyMatrix,i);
        directedDistanceMatrix(:,i) = nodeDistance;
        
        [nodeDistance ~] = dijkstra_sp(undirectedMatrix,i);
        unDirectedDistanceMatrix(:,i) = nodeDistance;
        
    end
    
    save(ontologyFile,'directedDistanceMatrix','unDirectedDistanceMatrix' ,'-append');
end