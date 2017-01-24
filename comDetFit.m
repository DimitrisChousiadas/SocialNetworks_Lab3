%% Fitness Function - Community Detection

function cs = comDetFit (adj,individual)

    n = size(adj,1);
    components = zeros(FindComponents(adj,n),n);
    
    visited = zeros(1,n);
    pos = 1;
    comp = 1;
    
    while pos < n && visited(pos) == 0
        visited(pos) = 1;
        node = individual(pos);
        components(comp,node) = 1;
        
    end

end