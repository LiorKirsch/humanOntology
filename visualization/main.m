addpath('/home/lab/lior/Projects/buildStructureOntology/');
load('../mouseOntologyObject.mat');
ontologyToTreeView('mouseBrain.json', mouseOntology, {}, {}, [], cell(0,2) );



clear;
load('../developingMouseOntologyObject.mat');
ontologyToTreeView('developingMouseBrain.json', mouseOntology, {}, {}, [], cell(0,2) );