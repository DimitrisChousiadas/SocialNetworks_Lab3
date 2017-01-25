function dy = func_SIS(t,y)

global N alpha

I = y(1);
tau = y(2);

dI = (beta(tau)*N - alpha)*I - beta(tau)*I^2;
dtau = 1;

dy = [dI;dtau];
