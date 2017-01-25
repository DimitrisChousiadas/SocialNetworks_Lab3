%% connectivity

clear;
vertices = 190;

%% REG
connected_reg = zeros(5,1);
for d = 2:2:10
    for iter = 1:100
        A = smallw(vertices,d,0.1);
        if isconnected(A)
            connected_reg(d/2) = connected_reg(d/2)+1;
        end
    end
end
percentage_reg = connected_reg;

%% RG(ER)
connected_er = zeros(8,1);
for M = 100:100:800
    for iter = 1:100
        A = erdrey(vertices,M);
        if isconnected(A)
            connected_er(M/100) = connected_er(M/100)+1;
        end
    end
end
percentage_er = connected_er;

%% RG(G)
connected_g = zeros(9,1);
for p = 1:9
    for iter = 1:100
        A = erdosRenyi(vertices,0.1*p,1);
        if isconnected(A.Adj)
            connected_g(p) = connected_g(p)+1;
        end
    end
end
percentage_g = connected_g;

%% RGG
connected_rgg = zeros(10,1);
for R = 25:25:250
    for iter = 1:100
        coordinateMatrix = randi(1000, [vertices 2]);
        [A, node_degree] = rgg(coordinateMatrix, vertices, R);
        if isconnected(A)
            connected_rgg(R/25) = connected_rgg(R/25)+1;
        end
    end
end
percentage_rgg = connected_rgg;

%% SF
connected_sf = zeros(5,1);
for d = 2:2:10
    for iter = 1:100
        A = pref(vertices, d);
        if isconnected(A)
            connected_sf(d/2) = connected_sf(d/2)+1;
        end
    end
end
percentage_sf = connected_sf;

%% SW
connected_sw = zeros(5,7);
for d = 2:2:10
    for g = 1:7
        for iter = 1:100
            sw = smallw(vertices, d, 0.1*g);
            if isconnected(A)
                connected_sw(d/2,g) = connected_sw(d/2,g)+1;
            end
        end
    end
end
percentage_sw = connected_sw;

save('results/connectivity_percentages');

