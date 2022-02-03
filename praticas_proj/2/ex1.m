%% 1a

N = 10; %number of simulations
results= zeros(1,N); %vector with N simulation results
for it= 1:N
    [results(1, it), results(2, it)] = simulator1(20,100,4,500,"movies.txt");
end

alfa= 0.1; %90% confidence interval%
media = mean(results(1,:));
term = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);

fprintf('Blocking probability (%%) = %.2e +-%.2e\n',media,term)

media = mean(results(2,:));
term = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);

fprintf('Average ocupation (Mbps) = %.2e +-%.2e\n',media,term)

%% 1b

N = 10; %number of simulations
lambdas = 10:5:40;
results= zeros(1,N); %vector with N simulation results
media= zeros(1,7);
term= zeros(1,7);

for lambda= 1:7
    for it= 1:N
        [results(1, it), results(2, it)] = simulator1(lambdas(lambda),100,4,500,"movies.txt");
    end
    
    media(1,lambda) = mean(results(1,:));
    term(1,lambda) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);
    media(2,lambda) = mean(results(2,:));
    term(2,lambda) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);
    
end

figure(1)

bar(lambdas,media(1,:))             

hold on

er = errorbar(lambdas,media(1,:),-term(1,:),term(1,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
xlabel('\lambda (requests/hour)')
title('Blocking probability (%)')

figure(2)
bar(lambdas,media(2,:))             

hold on

er = errorbar(lambdas,media(2,:),-term(2,:),term(2,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
xlabel('\lambda (requests/hour)')
title('Average server occupation (Mbps)')

%% 1c

N = 10; %number of simulations
lambdas = 10:5:40;
results= zeros(1,N); %vector with N simulation results
media= zeros(1,7);
term= zeros(1,7);

for lambda= 1:7
    for it= 1:N
        [results(1, it), results(2, it)] = simulator1(lambdas(lambda),100,4,5000,"movies.txt");
    end
    
    media(1,lambda) = mean(results(1,:));
    term(1,lambda) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);
    media(2,lambda) = mean(results(2,:));
    term(2,lambda) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);
    
end

figure(1)

bar(lambdas,media(1,:))             

hold on

er = errorbar(lambdas,media(1,:),-term(1,:),term(1,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
xlabel('\lambda (requests/hour)')
title('Blocking probability (%)')

figure(2)
bar(lambdas,media(2,:))             

hold on

er = errorbar(lambdas,media(2,:),-term(2,:),term(2,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
xlabel('\lambda (requests/hour)')
title('Average server occupation (Mbps)')

%% 1c

N = 10; %number of simulations
lambdas = 100:50:400;
results= zeros(1,N); %vector with N simulation results
media= zeros(1,7);
term= zeros(1,7);

for lambda= 1:7
    for it= 1:N
        [results(1, it), results(2, it)] = simulator1(lambdas(lambda),1000,4,5000,"movies.txt");
    end
    
    media(1,lambda) = mean(results(1,:));
    term(1,lambda) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);
    media(2,lambda) = mean(results(2,:));
    term(2,lambda) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);
    
end

figure(1)

bar(lambdas,media(1,:))             

hold on

er = errorbar(lambdas,media(1,:),-term(1,:),term(1,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
xlabel('\lambda (requests/hour)')
title('Blocking probability (%)')

figure(2)
bar(lambdas,media(2,:))             

hold on

er = errorbar(lambdas,media(2,:),-term(2,:),term(2,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
xlabel('\lambda (requests/hour)')
title('Average server occupation (Mbps)')

%% 1e

N = 10; %number of simulations
lambdas = 10:5:40;
results= zeros(1,N); %vector with N simulation results
media= zeros(1,7);
term= zeros(1,7);
prob= zeros(1,7);
occupation= zeros(1,7);

for ind= 1:7

    ro = lambdas(ind)/((1/86.3) * 60);

    a= 1;
    p= 1;
    for n= 25:-1:1
        a= a*n/ro;
        p= p+a;
    end
    prob(ind)= (1/p)*100;
    
    a= 25;
    numerator= a;
    for i= 25-1:-1:1
        a= a*i/ro;
        numerator= numerator + a;
    end
    
    a= 1;
    denominator= a;    
    for i= 25:-1:1
        a= a*i/ro;
        denominator= denominator+a;
    end
    occupation(ind) = (numerator/denominator) * 4;
    
    for it= 1:N
        [results(1, it), results(2, it)] = simulator1(lambdas(ind),100,4,5000,"movies.txt");
    end
    
    media(1,ind) = mean(results(1,:));
    media(2,ind) = mean(results(2,:));
    
end

figure(1)

bar(lambdas,[media(1,:); prob(1,:)])  
%bar(lambdas,prob(1,:))

xlabel('\lambda (requests/hour)')
title('Blocking probability (%)')

figure(2)
bar(lambdas,[media(2,:); occupation(1,:)])             

xlabel('\lambda (requests/hour)')
title('Average server occupation (Mbps)')

%% 1f

N = 10; %number of simulations
lambdas = 100:50:400;
results= zeros(1,N); %vector with N simulation results
media= zeros(1,7);
term= zeros(1,7);
prob= zeros(1,7);
occupation= zeros(1,7);

for ind= 1:7

    ro = lambdas(ind)/((1/86.3) * 60);

    a= 1;
    p= 1;
    for n= 250:-1:1
        a= a*n/ro;
        p= p+a;
    end
    prob(ind)= (1/p)*100;
    
    a= 250;
    numerator= a;
    for i= 250-1:-1:1
        a= a*i/ro;
        numerator= numerator + a;
    end
    
    a= 1;
    denominator= a;    
    for i= 250:-1:1
        a= a*i/ro;
        denominator= denominator+a;
    end
    occupation(ind) = (numerator/denominator) * 4;
    
    for it= 1:N
        [results(1, it), results(2, it)] = simulator1(lambdas(ind),1000,4,5000,"movies.txt");
    end
    
    media(1,ind) = mean(results(1,:));
    media(2,ind) = mean(results(2,:));
    
end

figure(1)

bar(lambdas,[media(1,:); prob(1,:)])  
%bar(lambdas,prob(1,:))

xlabel('\lambda (requests/hour)')
title('Blocking probability (%)')

figure(2)
bar(lambdas,[media(2,:); occupation(1,:)])             

xlabel('\lambda (requests/hour)')
title('Average server occupation (Mbps)')

