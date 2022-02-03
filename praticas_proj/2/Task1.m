%% 1a) ----------------------------------------------

lambda= 20;
C= 100;
M= 4;
R= 500;
N = 10;
fname= 'movies.txt';


blockingProbability = zeros(1, N);
averageInternet = zeros(1, N);


for it = 1:N
    [blockingProbability(it), averageInternet(it) ] = simulator1(lambda,C,M,R,fname);
end

alfa = 0.1;
media1 = mean(blockingProbability);
media2 = mean(averageInternet);
term1 = norminv(1-alfa/2)*sqrt(var(blockingProbability)/N);
term2 = norminv(1-alfa/2)*sqrt(var(averageInternet)/N);


fprintf('Blocking probability (%%)   = %.2e +- %.2e\n',media1,term1);
fprintf('Average occupation (mbps)= %.2e +- %.2e\n',media2,term2);

%% 1b) ----------------------------------------------

% grafico
lambda= 10:5:40;



C= 100;
M= 4;
R= 500;
N = 10;
fname= 'movies.txt';


blockingProbability = zeros(1, N);
averageInternet = zeros(1, N);

for lambda = 10:5:40

    for it = 1:N
        [blockingProbability(it, lambda), averageInternet(it, lambda) ] = simulator1(lambda,C,M,R,fname);
        alfa = 0.1;
        media1 = mean(blockingProbability);
        media2 = mean(averageInternet);
        term1 = norminv(1-alfa/2)*sqrt(var(blockingProbability)/N);
        term2 = norminv(1-alfa/2)*sqrt(var(averageInternet)/N);
               
        
    end    
end
data1 = media1
bar(lambda, media1)

fprintf('Blocking probability (%%)   = %.2e +- %.2e\n',media1,term1);
fprintf('Average occupation (mbps)= %.2e +- %.2e\n',media2,term2);


data2 = media2
figure(1)

%bar(lambda, media2)

hold on


hold off



%% 1e

lambdas= 10:5:40;
C= 100;
M= 4;
R= 5000;
N = 10;
fname= 'movies.txt';

results = zeros(1, N);
media = zeros(1,7);
blockingProbability = zeros(1, 7);
averageInternet = zeros(1, 7);
o = zeros(1,7)

for lambda = 1:7
    
    % ro = lambda / miu
    miu = (1/86.3) * 60;
    ro = lambdas(lambda) / miu ;
    
    % calculate blockingProbability
    a = 1;
    p = 1;
    N2 =  100/4 %  ligacao 100mb cada filme 4mbc = 25
    for n = N2:-1:1
        a = a * n / ro;
        p = p + a;
    end
    blockingProbability(lambda) = (1 / p) * 100;
    
    % calculate averageInternet
    a= N2;
    numerator= a;
    for i= N2-1:-1:1
         a= a*i/ro;
         numerator= numerator + a;
    end
    
    a= 1;
    denominator= a;
    for i= N2:-1:1
         a= a*i/ro;
         denominator= denominator + a;
    end
    o(lambda)= (numerator/denominator) * 4

    
    for it= 1:N
        [results(1, it), results(2, it)] = simulator1(lambdas(lambda),100,4,5000,"movies.txt");
    end
    
    media(1,lambda) = mean(results(1,:))
    media(2,lambda) = mean(results(2,:))
        
        
 end





































