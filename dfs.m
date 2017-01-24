% DFS

function [state, parents, components] = dfs (s, p, node, adj, comps, k)
    
    s(node) = 1;
    comps(k,node) = 1;
    neighbors = find(adj(node,:));
    l = size(neighbors,2);
    for iter = 1:l
        n = neighbors(iter);
        if s(n) == 0
            p(n) = node;
            [s,p,comps] = dfs(s,p,n,adj,comps,k);
        end
    end
    
    s(node) = 2;
    state = s;
    parents = p;
    components = comps;

end
