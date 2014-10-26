function ontologyToTreeView(fileName, humanOntology, rednodes, yellowStrokeNodes, unique_regions_count, samplesCountInHeir)

%     [unique_regions b c] = unique(human_gross_region_data( human_gross_region_vec, 1));
%     unique_regions_count = hist(c,length(unique_regions));
%     ontologyToTreeView(humanOntology, compact_display_regions, unique_regions, unique_regions_count)
%     fileName = 'tree.json';
    fid = fopen(fileName,'w');

    
    printRecursive( humanOntology.recursiveStructure, fid, true,'', rednodes, yellowStrokeNodes,unique_regions_count, samplesCountInHeir)
    fclose(fid);
end


function printRecursive( recursiveObject, fid, isLastObject,spaces, rednodes, yellowStrokeNodes, unique_regions_count, samplesCountInHeir)

    if ismember(recursiveObject.id, rednodes)
        colorString = '"color":"#f00",';
    else
        colorString = '';
    end
    
    [is_it_member, member_ind] = ismember(recursiveObject.id, yellowStrokeNodes);
    if is_it_member
        samples_count = unique_regions_count(member_ind);
        strokeString = sprintf('"stroke":"rgb(200, 221, 46)", "samples_count":"%d", ', samples_count);
    else
        strokeString = '';
    end
    
    [is_member, member_ind] = ismember(recursiveObject.id, samplesCountInHeir(:,1) );
    if is_member
        samples_count_recursive = num2str(  samplesCountInHeir{member_ind,2}  );
    else
        samples_count_recursive = '';
    end
    
    fprintf(fid, '\n%s {"id":"%s", %s %s "name":"%s-%s-", "atlas_id":"%s", "data":{}, "children":[', spaces, recursiveObject.id, colorString, strokeString, recursiveObject.name, samples_count_recursive, recursiveObject.atlas_id);
    for i = 1:length(recursiveObject.childStructures)
        if i == length(recursiveObject.childStructures)
            printRecursive( recursiveObject.childStructures(i), fid, true, [spaces, '   '], rednodes, yellowStrokeNodes, unique_regions_count, samplesCountInHeir);
        else
            printRecursive( recursiveObject.childStructures(i), fid, false, [spaces, '   '], rednodes, yellowStrokeNodes, unique_regions_count, samplesCountInHeir);
        end
    end
    
    if isLastObject
        fprintf(fid, '%s]}\n', spaces);
    else
        fprintf(fid, '%s]},', spaces);
    end
    
    
end