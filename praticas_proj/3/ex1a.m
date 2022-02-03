N = 10; %number of simulations
P = 10000;
alfa = 0.1;
lambda = 1800;
C = 10; 
f = 1000000;
% 1 - packet loss, PL
% 2 - Average packet delay, APD
% 3 - Maximum Packet delay, MPD
% 4 - Transmited throughput, TT
resultsPL= zeros(1,N); %vector with N simulation results
resultsAPD= zeros(1,N);
resultMPD= zeros(1,N);
resultsTT= zeros(1,N);

for it= 1:N
    [resultsPL(it), resultsAPD(it), resultMPD(it), resultsTT(it)] = simulator1(lambda,C,f,P);
end

mediaPL = mean(resultsPL);
mediaAPD = mean(resultsAPD);
mediaMPD = mean(resultMPD);
mediaTT = mean(resultsTT);

termPL = norminv(1-alfa/2)*sqrt(var(resultsPL)/N);
termAPD = norminv(1-alfa/2)*sqrt(var(resultsAPD)/N);
termMPD = norminv(1-alfa/2)*sqrt(var(resultMPD)/N);
termTT = norminv(1-alfa/2)*sqrt(var(resultsTT)/N);

fprintf('1-PacketLoss   = %.2e +-%.2e\n',mediaPL,termPL)
fprintf('2-Av. Packet Delay (ms)  = %.2e +-%.2e\n',mediaAPD,termAPD)
fprintf('3-Max. Packet Delay (ms) = %.2e +-%.2e\n',mediaMPD,termMPD)
fprintf('4-Throughput (Mbps) = %.2e +-%.2e\n',mediaTT,termTT)

