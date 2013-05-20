function buildDependecyMatrix()
    load('humanOntology.mat','structuredObjects');
   
    [structureLabels , structureColors] = getLabels(structuredObjects);
    dependecyMatrix = sparse(size(structureLabels,1), size(structureLabels,1));
    dependecyMatrix = buildDepMatrix(structuredObjects, structureLabels, dependecyMatrix);
    
    assert(max(sum(dependecyMatrix,1)) ==1, 'every node must have exactly one father');

    save('humanOntology.mat','structuredObjects','dependecyMatrix','structureLabels','structureColors');
end

function [structureLabels, structureColors] = getLabels(node)

    structureLabels = {node.id, node.atlas_id, node.acronym, node.name};
    structureColors = node.color;
    for i=1:length(node.childStructures)
       [childStructureLabels , childColors] =  getLabels(node.childStructures(i));
       structureLabels = [structureLabels ; childStructureLabels];
       structureColors = [structureColors ; childColors];
    end
end

function depMatrix = buildDepMatrix(node, structureLabels, depMatrix)
    if ~isempty(node.childStructures)
        currentNodeIndex = strcmp(node.id, structureLabels(:,1));
        
        for i =1:length(node.childStructures);
            childNode = node.childStructures(i);
            childNodeIndex = strcmp(childNode.id, structureLabels(:,1));
            depMatrix(currentNodeIndex, childNodeIndex) = 1;
            depMatrix = buildDepMatrix(childNode, structureLabels, depMatrix);
        end
    end
end