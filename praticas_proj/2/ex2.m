N = 10;               % number of simulations
lambdas = 100:20:200; % request arrival rate (in requests per hour) 
p = 20;               % percentage of requests for 4K movies (in %)
R = 10000;            % stop simulation on ARRIVAL no. R
W = 0;                % resource reservation for 4K movies (in Mbps)
n = 10;               % number of servers
S = 100;              % interface capacity of each server (in Mbps)
alfa = 0.1;           % 90 confidence interval%
%C = 1000;            % internet connect of server farm
fname = 'movies.txt'; % nome do ficheiro

% 100, 120, 140, 160, 180, 200
% arrays para guardar os valores que vao ser calculados
blockingHD = zeros(1, 6);
blocking4K = zeros(1, 6);
saveTermHD = zeros(1, 6);
saveTerm4K = zeros(1, 6);


for lambda =  1:6
    results_HD = zeros(1,N); %vector with N simulation results
    results_4K = zeros(1,N); %vector with N simulation results
    
    % iterar 10 vezes, para correr o simulator2 10 vezes
    for it = 1:10
        [results_HD(it), results_4K(it)] = simulator2(lambdas(lambda),p,n,S,W,R,fname);
    end
    
    % calcular a media dos resultados dos filmes hd
    blockingHD(lambda) = mean(results_HD);
    saveTermHD(lambda) = norminv(1-alfa/2)*sqrt(var(results_HD)/ N);
    
    % calcular a media dos resultados dos filmes 4k
    blocking4K(lambda) = mean(results_4K); 
    saveTerm4K(lambda) = norminv(1-alfa/2)*sqrt(var(results_4K)/ N);
end

figure(1)

bar(lambdas,blockingHD)             

hold on

er = errorbar(lambdas,blockingHD(1,:) ,-saveTermHD(1,:),saveTermHD(1,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
ylim([0 100])
xlabel('\lambda (requests/hour)')
title('Blocking probability HD (%)')

figure(2)
bar(lambdas,blocking4K(1,:))             

hold on

er = errorbar(lambdas,blocking4K(1,:),-saveTerm4K(1,:),saveTerm4K(1,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
xlabel('\lambda (requests/hour)')
title('Blocking probability 4K (%)')
