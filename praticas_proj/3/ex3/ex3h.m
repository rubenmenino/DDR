N = 40; %number of simulations
alfa= 0.1; %90% confidence interval%
lambda = [1500,1600,1700,1800,1900,2000];
C = 10000000; 
b = 10^(-5); 


APD = zeros(1,length(lambda));
TT = zeros(1,length(lambda));

%M/G/1 Aux
P = zeros(1,4); %Probability of each packet size Bi being sent without errors
B = [64, 110, 1518, (sum([65:109 111:1517])/length([65:109 111:1517]))];


%Packet Sizes
p = [0.16, 0.25, 0.2, 0.39]; 
ES = 0;
ES2 = 0; 
for i=1:4
    P(i) = (1-b)^(8*B(i));
    ES = ES + (p(i)*((8*B(i))/C));
    ES2 = ES2 + (p(i)*(((8*B(i))/C))^2);
end


for run=1:length(lambda)
    for it= 1:N
    [tPL(it), tAPD(it), tMPD(it), tTT(it)] = simulator2(lambda(run),10,10000000,10000,b);
    end
    APD(run) = mean(tAPD);
    eAPD(run) = norminv(1-alfa/2)*sqrt(var(tAPD)/N);
    TT(run) = mean(tTT);
    eTT(run) = norminv(1-alfa/2)*sqrt(var(tTT)/N);
    
    %M/G/1
    Wq = (lambda(run)*ES2)/(2*(1-lambda(run)*ES));
    Wi = zeros(1,4);
    APD_Num = 0;
    APD_Den = 0;
    for j=1:4
        Wi(j) = Wq + (8 * B(j))/C;
        APD_Num = APD_Num + (p(j)*P(j)*Wi(j));
        APD_Den = APD_Den + (p(j)*P(j));
        Theoretical_TT_MG1(run) = Theoretical_TT_MG1(run) + (p(j)*P(j)*lambda(run)*(8*B(j)))/1000000;
    end
    Theoretical_APD_MG1(run) = APD_Num/APD_Den * 1000;
end

figure(1)
bar(lambda, [APD;Theoretical_APD_MG1])
xlabel('\lambda (requests/hour)')
ylabel('Av. Packet Delay (ms)')
title('Average Packet Delay')
legend('Simulator','Theoretical M/G/1', 'Location', 'northwest')
grid on

figure(2)
bar(lambda, [TT;Theoretical_TT_MG1])
xlabel('\lambda (requests/hour)')
ylabel('Throughput (Mbps)')
title('Total Throughput')
legend('Simulator','Theoretical M/G/1', 'Location', 'northwest')

















