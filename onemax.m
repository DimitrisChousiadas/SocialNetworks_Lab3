% ONEMAX

n = 20;

x = zeros(n,20,7,20);
fval = zeros(20,7,20);
for population = 10:10:200
    pInd = population/10;
    for crossover = 0.3:0.1:0.9
       cInd = int16(10*crossover-2);
       for mutation = 0.01:0.01:0.2
           mInd = int16(100*mutation);
           options = gaoptimset('PopulationSize',population,'PopulationType','bitstring',...
               'CrossoverFraction',crossover,'MutationFcn',{@mutationuniform,mutation});
           [r,f] = ga(@oneMaxFit,n,[],[],[],[],[],[],[],[],options);
           x(:,pInd,cInd,mInd) = r;
           fval(pInd,cInd,mInd) = f;
           fprintf('pInd: %d, cInd: %d, mInd: %d\n', pInd,cInd,mInd);
      end
   end
end

save('results\onemax.mat');