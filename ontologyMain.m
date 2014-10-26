clear;
hOntology = load('mouseOntology.mat');

ontologyObject = ontology;

ontologyObject.dependencyMatrix = hOntology.dependecyMatrix;
ontologyObject.structureLabels = hOntology.structureLabels;
ontologyObject.structureColors = hOntology.structureColors;
ontologyObject.recursiveStructure = hOntology.structuredObjects;
ontologyObject.directedDistanceMatrix = hOntology.directedDistanceMatrix;
ontologyObject.unDirectedDistanceMatrix = hOntology.unDirectedDistanceMatrix;
ontologyObject = ontologyObject.distanceToCommonParent2();

% tests 
undirectedMatrix = ontologyObject.getUndirectedMatrix();
[allChilds, nodeLevel] = ontologyObject.allChildNodes();
leafNames = {'Dentate Gyrus', 'paracentral lobule, anterior part, Left'};
leafIndices = ismember(ontologyObject.structureLabels(:,4), leafNames);
reducedOntology = ontologyObject.reduceToLeafAndParents(leafIndices);
[allChilds2, nodeLevel2] = reducedOntology.allChildNodes();

reducedOntology2 = ontologyObject.reduceToNodeAndChilds([12]);
[allChilds3, nodeLevel3] = reducedOntology.allChildNodes();

save('mouseOntologyObject.mat', 'ontologyObject');