N = 10; % numero de simulacoes
lambdas = [1500,1600,1700,1800,1900,2000];
alfa= 0.1; %90% confidence interval%

C = 10;
f = 10000000;
P = 10000;
b = 0;

valuePL = zeros(1,length(lambdas));
valueAPD = zeros(1,length(lambdas));
valueMPD = zeros(1,length(lambdas));
valueTT = zeros(1,length(lambdas));

termPL = zeros(1,length(lambdas));
termAPD = zeros(1,length(lambdas));
termMPD = zeros(1,length(lambdas));
termTT = zeros(1,length(lambdas));

PL=zeros(1,N);
APD=zeros(1,N);
MPD=zeros(1,N);
TT=zeros(1,N);

for i=1:length(lambdas)
    for it= 1:N
        [PL(it),APD(it),MPD(it),TT(it)]= simulator2(lambdas(i),C,f,P,b);
    end
    valuePL(i) = mean(PL);
    termPL(i) = norminv(1-alfa/2) * sqrt(var(PL)/N);
    valueAPD(i) = mean(APD);
    termAPD(i) = norminv(1-alfa/2) * sqrt(var(APD)/N);
    valueMPD(i) = mean(MPD);
    termMPD(i) = norminv(1-alfa/2) * sqrt(var(MPD)/N);
    valueTT(i) = mean(TT);
    termTT(i) = norminv(1-alfa/2) * sqrt(var(TT)/N);
end


figure(1)
bar(lambdas,valueAPD)
hold on
erro=errorbar(lambdas,valueAPD,termAPD,termAPD);
erro.Color=[0 0 0];
erro.LineStyle = 'none';
hold off
grid on
xlabel('\lambda (requests/hour)')
title('Average Packet Delay (milliseconds)')

figure(2)
bar(lambdas,valueMPD)
hold on
errb=errorbar(lambdas,valueMPD,termMPD,termMPD);
errb.Color=[0 0 0];
errb.LineStyle = 'none';
hold off
grid on
xlabel('\lambda (requests/hour)')
title('Maximum Packet Delay (milliseconds)')

figure(3)
bar(lambdas,valueTT)
hold on
erro=errorbar(lambdas,valueTT,termTT,termTT);
erro.Color=[0 0 0];
erro.LineStyle = 'none';
hold off
grid on
xlabel('\lambda (requests/hour)')
title('Transmited Throughput (Mbps)')
