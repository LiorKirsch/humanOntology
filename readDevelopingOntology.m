[acronym,color_hex_triplet,graph_order,id,name,parent_structure_id,st_level,structure_id_path] = textread('developing_human_structures.csv' ,'%s %s %s %s %s %s %s %s', 'delimiter',',','headerlines',1);


save('developing_human_ontology.mat');