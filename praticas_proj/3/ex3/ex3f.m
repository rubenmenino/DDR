N = 40; %number of simulations
alfa= 0.1; %90% confidence interval%
fd = [2500,5000,7500,10000,12500,15000,17500,20000];

lambda = 1800;
C=10;
f=10e7;
b=10^(-5);
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
end

figure(1)
bar(fd, PL)
hold on
er = errorbar(fd,PL,-valuePL,valuePL);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off
title('Packet Loss (%)')
grid on

figure(2)
bar(fd, APD(:))
hold on
er = errorbar(fd,APD,-valueAPD,valueAPD);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off
title('Average Packet Delay (milliseconds)')
grid on

figure(3)
bar(fd, MPD(:))
hold on
er = errorbar(fd,MPD,-valueMPD,valueMPD);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off
title('Maximum Packet Delay (milliseconds)')
grid on

figure(4)
bar(fd, TT)
hold on
er = errorbar(fd,TT,-valueTT,valueTT);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off
title('Transmited Throughput (Mbps)')
grid on


