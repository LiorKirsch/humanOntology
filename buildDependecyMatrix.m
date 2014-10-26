function buildDependecyMatrix()
    ontlogyFile = 'developingMouseOntology.mat';
    
    load(ontlogyFile,'structuredObjects');
   
    [structureLabels , structureColors] = getLabels(structuredObjects);
    dependecyMatrix = sparse(size(structureLabels,1), size(structureLabels,1));
    dependecyMatrix = buildDepMatrix(structuredObjects, structureLabels, dependecyMatrix);
    
    assert(max(sum(dependecyMatrix,1)) ==1, 'every node must have exactly one father');

    structureLabels(:,4) = removeQuotation( structureLabels(:,4) );
    structureLabels(:,3) = removeQuotation( structureLabels(:,3) );
    save(ontlogyFile,'structuredObjects','dependecyMatrix','structureLabels','structureColors');
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

function cleanArray = removeQuotation(cellArrayOfStrings)
    cleanArray = cell(size(cellArrayOfStrings));
    
    for i = 1:length(cellArrayOfStrings)
       currentString = cellArrayOfStrings{i};
       
       if currentString(1) == '"' && currentString(end) == '"'
           cleanArray{i} = currentString(2:end -1);
       else
           cleanArray{i} = currentString;
       end
    end

end