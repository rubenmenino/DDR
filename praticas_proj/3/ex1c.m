N = 10; %number of simulations
P = 10000;
alfa = 0.1;
lambda = 1800;
C = 10; 
f = 10000;


packet_loss=0; %fila infinita logo nunca se perdem
aux1=[65:109 111:1517];
aux3=length(aux1);
aux4=(1-(0.16+0.25+0.2))/aux3;
B=0.16*64+0.25*110+0.2*1518+aux4*sum(aux1);
miu=C*1000000/(B*8);
packet_delay=1/(miu-lambda)*1000


%%%

throughput = (lambda * (B*8)) / 1000000



