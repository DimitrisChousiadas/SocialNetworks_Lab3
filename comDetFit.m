% b Fitness Function - Community Detection

function cs = comDetFit (adj,individual)

    n = size(adj,1);
   
    adj_comp = zeros(n,n);
    for iter = 1:n
        i = individual(iter);
        if i ~= iter
            adj_comp(i,iter) = 1;
            adj_comp(iter,i) = 1;
        end
    end

    % DFS to find connected components
    s = zeros(1,n); % 0->undiscovered, 1->under discovery, 2->discovered
    state = zeros(1,n);
    p = zeros(1,n);
    comps = zeros(n,n);
    k = 0;
    for node = 1:n
        if state(node) == 0
            k = k + 1;
            [state, parent, components] = dfs(s, p, node, adj_comp, comps, k);
            comps = components;
            s = state;
            p = parent;
        end
    end
    
    % CS calculation
    cs = 0;
    for comp = 1:k
        I = find(components(comp,:));
        S = adj(I,I);
        uS = sum(sum(S));
        mS = 0;
        for iter = 1:size(I,2)
            aiJ = sum(S(iter,:))/size(I,2);
            mS = mS + aiJ;
        end
        mS = mS/size(I,2);
        qS = mS*uS;
        cs = cs + qS;
    end
    
end