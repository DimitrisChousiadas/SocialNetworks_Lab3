% Dolphins - Community Detection

clc;
clear;
PathAdd;

dolphins = importgmlDolphins('dolphins.gml');
dolphins = makeUndirected(dolphins);

t = 0;
n = size(dolphins,1);

crossoverProb = 0.8;
mutationProb = 0.1;
elitism = 1;

%% Population Initialization

chromosomes = 300;
population = zeros(chromosomes,n);

for i = 1:chromosomes
    for j = 1:n
        neighbors = find(dolphins(j,:));
        l = size(neighbors);
        k = randi(l,1);
        population(i,j) = neighbors(k);
    end
end

%% Genetics

generation = 1;
maxFit = 0;
counter = 1;
newPopulation = zeros(chromosomes,n);

while generation <= 30 && counter < 5
      
    fprintf('Generation: %d\n', generation);
    
    generation = generation + 1;
    counter = counter + 1;
    
    % proportional selection
    sumCS = 0;
    csCum = zeros(chromosomes,1);
    for j = 1:chromosomes
        fit = comDetFit(dolphins,population(j,:));
        if fit > maxFit
            maxFit = fit;
            counter = 1;
            bestIndividual = population(j,:);
        end
        sumCS = sumCS + fit;
        csCum(j) = sumCS;
    end
    fprintf('Max Fit: %d\n', maxFit);
       
    for iter = 1:chromosomes
        
       x = rand(1);
       k = 1;
       flag = (x < csCum(k)/sumCS);
       
       while k < chromosomes && flag
           k = k + 1;
           flag = (x < csCum(k)/sumCS);
       end
       
       newPopulation(iter,:) = population(k,:);
       
    end
    population = newPopulation;
    
    % one-point crossover
    for iter = 1:2:(chromosomes-1)
       if rand(1) <= crossoverProb
           pos = randi(n-1,1);
           for k = (pos+1):n
               aux = population(iter,k);
               population(iter,k) = population(iter+1,k);
               population(iter+1,k) = aux;
           end
       end
    end
    
    % mutation
    for iter = 1:chromosomes
        for k = 1:n
            neighbors = find(dolphins(k,:));
            l = size(neighbors,2);
            if (rand(1) <= mutationProb) && (l>1)
                node = neighbors(randi(l,1));
                while node == population(iter,k)
                    node = neighbors(randi(l,1));
                end
                population(iter,k) = node;
            end
        end
    end
    
end

%% Plot Communities

n = size(dolphins,1);
    
adj_comp = zeros(n,n);
for iter = 1:n
    i = bestIndividual(iter);
    if i ~= iter
        adj_comp(i,iter) = 1;
        adj_comp(iter,i) = 1;
    end
end

% DFS
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

communities = zeros(1,n);
for iter = 1:k
    for j = 1:n
        if components(iter,j) == 1
            communities(j) = iter;
        end
    end
end

PlotGraph(dolphins, communities);