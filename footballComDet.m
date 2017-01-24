% American Football - Community Detection

clc;
clear;

football = importgml('football.gml');
football = makeUndirected(football);

t = 0;
n = size(football,1);
foo = 1;
for iter = 1:size(dec2bin(n),2)
    foo = foo + 2^iter;
end

crossoverProb = 0.7;
mutationProb = 0.1;

%% Population Initialization

chromosomes = 300;
population = zeros(chromosomes,n);

for i = 1:chromosomes
    for j = 1:n
        neighbors = find(football(j,:));
        l = size(neighbors);
        k = randi(l,1);
        population(i,j) = neighbors(k);
    end
end

%% Genetics

generation = 1;
while generation < 30
    
    % proportional selection
    sumCS = 0;
    csCum = zeros(chromosomes,1);
    for j = 1:chromosomes
        sumCS = sumCS + comDetFit(football,population(j,:));
        csCum(j) = sumCS;
    end
       
    for iter = 1:chromosomes
        
       x = rand(1);
       k = 1;
       flag = (x < csCum(k)/sumCS);
       
       while k<n && flag
           k = k + 1;
           flag = (x < csCum(k)/sumCS);
       end
       
       population(iter,:) = population(k,:);
       
    end
    
    % one-point crossover
    for iter = 1:2:chromosomes
       if rand(1) <= crossoverProb
           pos = randi(n-1,1);
           for k = pos+1:n
               aux = population(iter,k);
               population(iter,k) = population(iter+1,k);
               population(iter+1,k) = aux;
           end
       end
    end
    
    % mutation
    for iter = 1:chromosomes
        for k = 1:n
            neighbors = find(football(k,:));
            l = size(neighbors);
            if rand(1) <= mutationProb
                %population(iter,k) = bitxor(population(iter,k),foo);
                population(iter,k) = neighbors(randi(l,1));
            end
        end
    end
    
    generation = generation + 1;
    
end