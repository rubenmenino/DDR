N = 10;               % number of simulations
lambdas = 100:20:200; % request arrival rate (in requests per hour) 
p = 20;               % percentage of requests for 4K movies (in %)
R = 10000;            % stop simulation on ARRIVAL no. R
W = 600;                % resource reservation for 4K movies (in Mbps)
n = [10,4,1];         % number of servers
S = [100, 250, 1000]; % interface capacity of each server (in Mbps)
alfa = 0.1;           % 90 confidence interval%
fname = 'movies.txt'; % nome do ficheiro

blockingHD = zeros(3, 6);
blocking4K = zeros(3, 6);
saveTermHD = zeros(3, 6);
saveTerm4K = zeros(3, 6);

it = 1;

for lambdas = 100:20:200
    for configuration = 1 : length(n)
        results = zeros(2,N);

        for it2=1:N
           [results(1,it2), results(2,it2)] = simulator2(lambdas,p,n(configuration),S(configuration),W,R,fname);
        end

        
        media_blockingHD = mean(results(1,:));
        media_blocking4K = mean(results(2,:));

        termHD = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);
        term4K = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);
        
        blockingHD(configuration, it) = media_blockingHD
        saveTermHD(configuration, it) = termHD
        blocking4K(configuration, it) = media_blocking4K
        saveTerm4K(configuration, it) = term4K
        

    end
    it = it + 1;

end
xgraph = 100:20:200;
figure;
bar(xgraph,blockingHD)
grid on;

hold on
 
legend('Configuration1','Configuration2', 'Configuration3','Location','northwest');

title('Blocking probability HD movies(%),  W = 600Mbps');
hold off

figure;
bar(xgraph,blocking4K)
grid on;
hold on

legend('Configuration1','Configuration2', 'Configuration3','Location','northwest');

title('Blocking probability 4K movies(%), W = 600Mbps');
hold off