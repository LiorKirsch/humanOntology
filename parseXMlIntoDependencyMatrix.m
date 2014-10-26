function parseXMlIntoDependencyMatrix(xmlFile)
    xmlFile='mouseOntology.xml';
    structureData = xml2struct(xmlFile);
    structuredObjects = createStructure(structureData.children);
    
    save('mouseOntology.mat','structuredObjects');

end

    
function structuredNode = createStructure(node)
    %structuredNode = struct;
    structuredNode = struct('color', nan(3,1),'id', {}, 'atlas_id', {}, 'name',{}, 'acronym',{}, 'childStructures', struct([]));
    structIndex = 0;
    if isfield(node, 'children')
        for m=1:length(node)
            struct_child = node(m);
            if strcmp(struct_child.name ,'structure')
                structIndex = structIndex + 1;
        %
        
                for i=1:length(struct_child.children)
                    curr_child = struct_child.children(i);
                    
                
                    if strcmp(curr_child.name ,'id')
                        structuredNode(structIndex).id = curr_child.children.data;
                    end
                    if strcmp(curr_child.name ,'atlas_id')
                        try
                            structuredNode(structIndex).atlas_id = curr_child.children.data;
                        catch
                            structuredNode(structIndex).atlas_id = '';
                        end
                    end

                    if strcmp(curr_child.name ,'name')
                        structuredNode(structIndex).name = curr_child.children.data;
                    end

                    if strcmp(curr_child.name , 'acronym')
                        structuredNode(structIndex).acronym = curr_child.children.data;
                    end
                    if strcmp(curr_child.name ,'red')
                        structuredNode(structIndex).color(1) = str2double(curr_child.children.data);
                    end
                    if strcmp(curr_child.name , 'green')
                        structuredNode(structIndex).color(2) = str2double(curr_child.children.data);
                    end
                    if strcmp(curr_child.name ,'blue')
                        structuredNode(structIndex).color(3) = str2double(curr_child.children.data);
                    end

                    if strcmp(curr_child.name ,'children')
                        structuredNode(structIndex).childStructures = createStructure(curr_child.children);
                    end
                end
            end
        end
    end
    
end

function out = xml2struct(xmlfile)
    %XML2STRUCT Read XML file into a structure.

    % Douglas M. Schwarz

    xml = xmlread(xmlfile);

    children = xml.getChildNodes;
    for i = 1:children.getLength
       out(i) = node2struct(children.item(i-1));
    end
end

function s = node2struct(node)

    s.name = char(node.getNodeName);

    if node.hasAttributes
       attributes = node.getAttributes;
       nattr = attributes.getLength;
       s.attributes = struct('name',cell(1,nattr),'value',cell(1,nattr));
       for i = 1:nattr
          attr = attributes.item(i-1);
          s.attributes(i).name = char(attr.getName);
          s.attributes(i).value = char(attr.getValue);
       end
    else
       s.attributes = [];
    end

    try
       s.data = char(node.getData);
    catch
       s.data = '';
    end

    if node.hasChildNodes
       children = node.getChildNodes;
       nchildren = children.getLength;
       c = cell(1,nchildren);
       s.children = struct('name',c,'attributes',c,'data',c,'children',c);
       for i = 1:nchildren
          child = children.item(i-1);
          s.children(i) = node2struct(child);
       end
    else
       s.children = [];
    end
end