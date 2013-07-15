clear;
hOntology = load('humanOntology.mat');

humanOntology = ontology;

humanOntology.dependencyMatrix = hOntology.dependecyMatrix;
humanOntology.structureLabels = hOntology.structureLabels;
humanOntology.structureColors = hOntology.structureColors;
humanOntology.recursiveStructure = hOntology.structuredObjects;
humanOntology.directedDistanceMatrix = hOntology.directedDistanceMatrix;
humanOntology.unDirectedDistanceMatrix = hOntology.unDirectedDistanceMatrix;
humanOntology = humanOntology.distanceToCommonParent2();

% tests 
undirectedMatrix = humanOntology.getUndirectedMatrix();
[allChilds, nodeLevel] = humanOntology.allChildNodes();
leafNames = {'Dentate Gyrus', 'paracentral lobule, anterior part, Left'};
leafIndices = ismember(humanOntology.structureLabels(:,4), leafNames);
reducedOntology = humanOntology.reduceToLeafAndParents(leafIndices);
[allChilds2, nodeLevel2] = reducedOntology.allChildNodes();

reducedOntology2 = humanOntology.reduceToNodeAndChilds([12]);
[allChilds3, nodeLevel3] = reducedOntology.allChildNodes();

save('humanOntologyObject.mat', 'humanOntology');