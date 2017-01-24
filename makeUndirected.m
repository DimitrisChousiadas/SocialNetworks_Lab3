%% Make a directed graph undirected

function undirected = makeUndirected (graph)

    gt = graph';
    undirected = (graph~=gt) + (graph==1 & gt==1);
    
end