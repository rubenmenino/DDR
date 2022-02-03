 C=10;
 f=10e7;
 b=0;
 P=10000;
 N = 10; %number of simulations
 lambda=[1500,1600,1700,1800,1900,2000];
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
 
B=(0.16*64+0.25*110+0.2*1518+ ((1-(0.16+0.25+0.2))/ length([65:109 111:1517]) )  * sum([65:109 111:1517]))*8;
miu=C*1000000/B;
for j=1:length(lambda)
    packet_delay(j) = 1/(miu-lambda(j))*1000;
    throughput(j) = (lambda(j)*B)/1000000;
end
 
figure(24)
bar(lambda,[valueAPD;packet_delay])
title('Average Packet Delay (milliseconds)')

figure(25)
bar(lambda,[valueTT;throughput])
title('Transmited Throughput (Mbps)')
 
 
