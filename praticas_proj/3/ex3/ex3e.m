N = 40; %number of simulations
alfa= 0.1; %90% confidence interval%
fd = [2500,5000,7500,10000,12500,15000,17500,20000];

lambda = 1800;
C=10;
f=10e7;
b=0;
P=10000;

valuePL = zeros(1,length(fd));
valueAPD = zeros(1,length(fd));
valueMPD = zeros(1,length(fd));
valueTT = zeros(1,length(fd));

termPL = zeros(1,N);
termAPD = zeros(1,N);
termMPD = zeros(1,N);
termTT = zeros(1,N);

PL = zeros(1,length(fd));
APD = zeros(1,length(fd));
MPD = zeros(1,length(fd));
TT = zeros(1,length(fd));

m = zeros(1,length(fd));
MM1_Num = zeros(1,length(fd));
MM1_Den = zeros(1,length(fd));
MM1_PL = zeros(1,length(fd));

L = zeros(1,length(fd));
MM1_PD = zeros(1,length(fd));
th = zeros(1,length(fd));

B=(0.16*64+0.25*110+0.2*1518+ ((1-(0.16+0.25+0.2))/ length([65:109 111:1517]) )  * sum([65:109 111:1517]))*8;
u=C*1000000/B;

for i=1:length(fd)
    for it= 1:N
        [termPL(it), termAPD(it), termMPD(it), termTT(it)] = simulator2(lambda,C,fd(i),P,b);
    end
    PL(i) = mean(termPL);
    valuePL(i) = norminv(1-alfa/2)*sqrt(var(termPL)/N);
    APD(i) = mean(termAPD);
    valueAPD(i) = norminv(1-alfa/2)*sqrt(var(termAPD)/N);
    MPD(i) = mean(termMPD);
    valueMPD(i) = norminv(1-alfa/2)*sqrt(var(termMPD)/N);
    TT(i) = mean(termTT);
    valueTT(i) = norminv(1-alfa/2)*sqrt(var(termTT)/N);
    
    m(i)=round(fd(i) * 8/B)+1;
    MM1_Num(i)=0;
    MM1_Den(i)=0;
    for j=0:m(i)
        MM1_Num(i)=MM1_Num(i)+(j*(lambda/u)^j);
        MM1_Den(i)=MM1_Den(i)+(lambda/u)^j;
    end
    MM1_PL(i)=((lambda/u)^m(i))/MM1_Den(i);
    L(i)=MM1_Num(i)/MM1_Den(i);
    MM1_PD(i)=L(i)/(lambda*(1-MM1_PL(i)));
    th(i) = ((lambda*B)/1000000)*(1-MM1_PL(i));
end

figure(1)
bar(fd, [PL;MM1_PL*100])
xlabel('Queue Size (Bytes)')
ylabel('Packet Loss (%%)')
title('Packet Loss')
legend('Simulator','Theoretical M/M/1/m', 'Location', 'northeast')
grid on


figure(2)
bar(fd,[APD;MM1_PD*1000])
xlabel('Queue Size (Bytes)')
ylabel('Av. Packet Delay (ms)')
title('Average Packet Delay')
legend('Simulator','Theoretical M/M/1/m', 'Location', 'northwest')
grid on

figure(3)
bar(fd,[TT;th])
xlabel('Queue Size (Bytes)')
ylabel('Throughput (Mbps)')
title('Total Throughput')
legend('Simulator','Theoretical M/M/1/m', 'Location', 'northwest')
grid on

