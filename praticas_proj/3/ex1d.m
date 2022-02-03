N = 10; %number of simulations
P = 10000;
alfa = 0.1;
lambda = 1800;
C = 10; 
f = 1000000;


packet_loss=0; %fila infinita logo nunca se perdem
values=[65:109 111:1517];
length_values=length(values);

aux4=(1-(0.16+0.25+0.2))/length_values;

B=0.16*64+0.25*110+0.2*1518+aux4*sum(values);

S64bytes=64*8/(C*1000000);    %% bits por segundo
S110bytes=110*8/(C*1000000);  %% bits por segundo
S1518bytes=1518*8/(C*1000000);%% bits por segundo

S1=values*8/(C*1000000);      %% bits por segundo
S2=S1.^2;

ES= 0.16 * S64bytes + 0.25 * S110bytes + 0.2 * S1518bytes + aux4 * sum(S1);
ES2=0.16*((S64bytes)^2)+0.25*((S110bytes)^2)+0.2*((S1518bytes)^2)+aux4*sum(S2);

WQ=(lambda*ES2)/(2*(1-lambda*ES));
packet_delay1=WQ+ES;
throughput1 = (lambda*(B*8))/1000000;
fprintf('Packet Loss (%%) = %.4e\n',packet_loss1)
fprintf('Av. Packet delay (ms) = %.4e\n',packet_delay1*1000)
fprintf('Throughput (Mbps) = %.4e\n',throughput1)