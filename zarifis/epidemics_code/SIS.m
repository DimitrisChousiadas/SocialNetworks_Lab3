global N alpha

alpha = 1;
N = 1;

options = odeset('MaxStep',0.01);
[T,Y] = ode45('func_SIS',[0 10],[0.2 0],options);  

figure(1)
plot(T,Y(:,1));
xlabel('t');
ylabel('I');

for i=1:1000         %also plot a scaled version of beta
   tt(i) = 0.01*i;
   bb(i) = beta(tt(i));
end
hold on;
plot(tt,0.1*bb,'r');
